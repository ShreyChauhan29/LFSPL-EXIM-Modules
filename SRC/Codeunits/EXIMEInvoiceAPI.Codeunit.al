namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Sales.Document;
using Microsoft.Inventory.Item;
using Microsoft.FixedAssets.FixedAsset;
using Microsoft.Finance.GST.Sales;
using Microsoft.Foundation.UOM;
using System.Text;
using Microsoft.QRGeneration;
using System.Reflection;
using System.Utilities;
using Microsoft.Sales.History;
using Microsoft.Foundation.Company;
using Microsoft.Finance.GST.Base;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Sales.Customer;
using Microsoft.Finance.TCS.TCSBase;
using Microsoft.Finance.TaxEngine.TaxTypeHandler;
using Microsoft.Inventory.Location;
using Microsoft.Finance.TaxBase;

codeunit 72003 "EXIM EInvoiceAPI"
{

    var
        CompInfo: Record "Company Information";
        GSTRegNos: Record "GST Registration Nos.";
        SaleaInvLine: Record "Sales Invoice Line";
        SalesCreditMemoLine: Record "Sales Cr.Memo Line";
        TempBlob: Codeunit "Temp Blob";
        QRCodeGen: Codeunit "QR Generator";
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        IGSTAmt: Decimal;
        TotAssVal: Decimal;
        GSTPer: Decimal;
        GSTAssAmt: Decimal;
        TCSAmt: Decimal;
        GlbTextVar: Text;
#pragma warning disable AA0470
        IRNMsg: Label 'IRN No. has been Generated with,\Ack No. %1 \Ack Dt %2.';
        CancelMsg: Label 'Do you want to cancel IRN for document no. %1';
#pragma warning restore AA0470
        EwayBillNo: text;
        EwayBillDt: text;
        EwayBillValid: Text;
        PreviousLineNo: Integer;

    // local procedure CheckReverseCharge(DocNo: Code[20]): Text[1]
    // var
    //     DtldGstLedgEntry: Record "Detailed GST Ledger Entry";
    // begin
    //     DtldGstLedgEntry.SetRange("Document No.", DocNo);
    //     IF DtldGstLedgEntry.FindFirst() then
    //         if DtldGstLedgEntry."Reverse Charge" then
    //             exit('Y')
    //         else
    //             exit('N');
    // end;

    procedure CancelIRN(DocNo: Code[20]; DocType: Integer; GSTIN: Code[20]; CancelReason: Code[20])
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        // L_Message: Text;
        TempDateTime: DateTime;
        HttpClient: HttpClient;
        HttpContent: HttpContent;
        HttpHeader: HttpHeaders;
        HttpRequest: HttpRequestMessage;
        HttpResponse: HttpResponseMessage;
        CancelReasonInt: Integer;
        CancelDt: Text;
        MessageID: text;
        Response: Text;
    begin
        IF NOT CONFIRM(STRSUBSTNO(CancelMsg, DocNo), FALSE) THEN
            EXIT;
        Authenticate(GSTIN);

        GlbTextVar := '';
        GlbTextVar += '{';
        WriteToGlbTextVar('action', 'CANCEL', 0, TRUE);
        CASE DocType OF
            1:
                BEGIN
                    SalesInvoiceHeader.GET(DocNo);
                    CancelReasonInt := ConvertEnumToInt(SalesInvoiceHeader."Cancel Reason");
                    WriteToGlbTextVar('IRNNo', SalesInvoiceHeader."IRN Hash", 0, TRUE);
                    WriteToGlbTextVar('CancelReason', format(CancelReasonInt), 0, TRUE);
                    WriteToGlbTextVar('CancelRemarks', format(SalesInvoiceHeader."Cancel Reason"), 0, FALSE);
                END;
            2:
                BEGIN
                    SalesCrMemoHeader.GET(DocNo);
                    CancelReasonInt := ConvertEnumToInt(SalesCrMemoHeader."Cancel Reason");
                    WriteToGlbTextVar('IRNNo', SalesCrMemoHeader."IRN Hash", 0, TRUE);
                    WriteToGlbTextVar('CancelReason', FORMAT(CancelReasonInt), 0, TRUE);
                    WriteToGlbTextVar('CancelRemarks', FORMAT(SalesCrMemoHeader."Cancel Reason"), 0, FALSE);
                END;
        END;

        GlbTextVar += '}';
        Message(GlbTextVar);
        HttpRequest.Method := 'POST';
        HttpRequest.SetRequestUri(GSTRegNos."E-Invoice URL");
        HttpContent.WriteFrom(GlbTextVar);
        HttpContent.GetHeaders(HttpHeader);
        HttpHeader.Add('client_id', GSTRegNos."Client Id");
        HttpHeader.Add('client_secret', GSTRegNos."Client Secret");
        HttpHeader.Add('IPAddress', GSTRegNos."IP Address");
        HttpHeader.Remove('Content-Type');
        HttpHeader.Add('Content-Type', 'application/json');
        HttpHeader.Add('user_name', GSTRegNos."User Name");
        //Header.Add('Gstin', GSTRegNos.Code);
        HttpHeader.Add('Gstin', GSTRegNos.Code);
        HttpRequest.Content(HttpContent);
        if HttpClient.Send(HttpRequest, HttpResponse) then begin
            if HttpResponse.HttpStatusCode() = 200 then begin
                HttpResponse.Content.ReadAs(Response);
                ReadCancelResponse(Response, CancelDt, MessageID);
            end else
                Error('Unable to connect %1', HttpResponse.HttpStatusCode());
        end else
            Error('Cannot connect,connection error');

        IF MessageID = '1' THEN begin
            TempDateTime := ConvertAckDt(CancelDt);
            CASE DocType OF
                1:
                    BEGIN
                        SalesInvoiceHeader."E-Inv. Cancelled Date" := TempDateTime;
                        SalesInvoiceHeader.MODIFY();
                    END;
                2:
                    BEGIN
                        SalesCrMemoHeader."E-Inv. Cancelled Date" := TempDateTime;
                        SalesCrMemoHeader.MODIFY();
                    END;
            END;
        end;
        MESSAGE(Response);
    END;


    procedure FetchIRN(DocNo: Code[20]; DocType: Integer; DocDate: Date; GSTIN: Code[20])
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        RecRef: RecordRef;
        FieldRef: FieldRef;
        HttpClient: HttpClient;
        HttpContent: HttpContent;
        HttpHeader: HttpHeaders;
        HttpRequest: HttpRequestMessage;
        HttpResponse: HttpResponseMessage;
        AckDt: text;
        // IRNStatus: text;
        MessageID: text;
        Response: Text;
        RQRCode: text;
        AckNo: Text[30];
        IRNText: Text[64];
    begin
        Authenticate(GSTIN);
        GlbTextVar := '';
        //Write Common Details
        GlbTextVar += '{';
        WriteToGlbTextVar('action', 'IRNBYDOCDETAILS', 0, TRUE);
        //DocType 1 = Invoice,2 = Credit Memo, 3 = Transfer Shipment
        CASE DocType OF
            1, 3:
                WriteToGlbTextVar('doctype', 'INV', 0, TRUE);
            2:
                WriteToGlbTextVar('doctype', 'CRN', 0, TRUE);
        END;
        WriteToGlbTextVar('docnum', DocNo, 0, TRUE);
        WriteToGlbTextVar('docdate', FORMAT(DocDate, 0, '<Day,2>/<Month,2>/<Year4>'), 0, TRUE);
        GlbTextVar += '}';
        Message(GlbTextVar);

        HttpRequest.Method := 'POST';
        HttpRequest.SetRequestUri(GSTRegNos."E-Invoice URL");
        HttpContent.WriteFrom(GlbTextVar);
        HttpContent.GetHeaders(HttpHeader);
        HttpHeader.Add('client_id', GSTRegNos."Client Id");
        HttpHeader.Add('client_secret', GSTRegNos."Client Secret");
        HttpHeader.Add('IPAddress', GSTRegNos."IP Address");
        HttpHeader.Remove('Content-Type');
        HttpHeader.Add('Content-Type', 'application/json');
        HttpHeader.Add('user_name', GSTRegNos."User Name");
        //Header.Add('Gstin', GSTRegNos.Code);
        HttpHeader.Add('Gstin', GSTRegNos.Code);
        HttpRequest.Content(HttpContent);
        if HttpClient.Send(HttpRequest, HttpResponse) then begin
            if HttpResponse.HttpStatusCode() = 200 then begin
                HttpResponse.Content.ReadAs(Response);
                ReadfromResponse(Response, IRNText, AckNo, AckDt, RQRCode, MessageID);
            end else
                Error('Unable to connect %1', HttpResponse.HttpStatusCode());
        end else
            Error('Cannot connect,connection error');

        Clear(RecRef);
        IF MessageID = '1' THEN
            case DocType of
                1:
                    begin
                        SalesInvoiceHeader.get(DocNo);
                        SalesInvoiceHeader."IRN Hash" := IRNText;
                        SalesInvoiceHeader."Acknowledgement No." := AckNo;
                        SalesInvoiceHeader."Acknowledgement Date" := ConvertAckDt(AckDt);
                        SalesInvoiceHeader.Modify();
                        RecRef.GetTable(SalesInvoiceHeader);
                        QRCodeGen.GenerateQRCodeImage(RQRCode, TempBlob);
                        FieldRef := RecRef.Field(SalesInvoiceHeader.FieldNo("QR Code"));
                        TempBlob.ToRecordRef(RecRef, SalesInvoiceHeader.FieldNo("QR Code"));
                        RecRef.Modify();
                        MESSAGE(IRNMsg, AckNo, AckDt);
                    END;
                2:
                    begin
                        SalesCrMemoHeader.get(DocNo);
                        SalesCrMemoHeader."IRN Hash" := IRNText;
                        SalesCrMemoHeader."Acknowledgement No." := AckNo;
                        SalesCrMemoHeader."Acknowledgement Date" := ConvertAckDt(AckDt);
                        SalesCrMemoHeader.Modify();
                        RecRef.GetTable(SalesCrMemoHeader);
                        QRCodeGen.GenerateQRCodeImage(RQRCode, TempBlob);
                        FieldRef := RecRef.Field(SalesCrMemoHeader.FieldNo("QR Code"));
                        TempBlob.ToRecordRef(RecRef, SalesCrMemoHeader.FieldNo("QR Code"));
                        RecRef.Modify();
                        MESSAGE(IRNMsg, AckNo, AckDt);
                    end;
            end
        ELSE
            MESSAGE(Response);
    end;

    procedure FetchIRNExport(DocNo: Code[20]; DocType: Integer; DocDate: Date; GSTIN: Code[20]; PostingNo: Code[20])
    var
        SalesInvoiceHeader: Record "Sales Header";
        RecRef: RecordRef;
        FieldRef: FieldRef;
        HttpClient: HttpClient;
        HttpContent: HttpContent;
        HttpHeader: HttpHeaders;
        HttpRequest: HttpRequestMessage;
        HttpResponse: HttpResponseMessage;
        AckDt: text;
        // IRNStatus: text;
        MessageID: text;
        Response: Text;
        RQRCode: text;
        AckNo: Text[30];
        IRNText: Text[64];
    begin
        Authenticate(GSTIN);
        GlbTextVar := '';
        //Write Common Details
        GlbTextVar += '{';
        WriteToGlbTextVar('action', 'IRNBYDOCDETAILS', 0, TRUE);
        //DocType 1 = Invoice,2 = Credit Memo, 3 = Transfer Shipment
        CASE DocType OF
            1, 3:
                WriteToGlbTextVar('doctype', 'INV', 0, TRUE);
            2:
                WriteToGlbTextVar('doctype', 'CRN', 0, TRUE);
        END;
        WriteToGlbTextVar('docnum', PostingNo, 0, TRUE);
        WriteToGlbTextVar('docdate', FORMAT(DocDate, 0, '<Day,2>/<Month,2>/<Year4>'), 0, false);
        GlbTextVar += '}';
        Message(GlbTextVar);

        HttpRequest.Method := 'POST';
        HttpRequest.SetRequestUri(GSTRegNos."E-Invoice URL");
        HttpContent.WriteFrom(GlbTextVar);
        HttpContent.GetHeaders(HttpHeader);
        HttpHeader.Add('client_id', GSTRegNos."Client Id");
        HttpHeader.Add('client_secret', GSTRegNos."Client Secret");
        HttpHeader.Add('IPAddress', GSTRegNos."IP Address");
        HttpHeader.Remove('Content-Type');
        HttpHeader.Add('Content-Type', 'application/json');
        HttpHeader.Add('user_name', GSTRegNos."User Name");
        //Header.Add('Gstin', GSTRegNos.Code);
        HttpHeader.Add('Gstin', GSTRegNos.Code);
        HttpRequest.Content(HttpContent);
        if HttpClient.Send(HttpRequest, HttpResponse) then begin
            if HttpResponse.HttpStatusCode() = 200 then begin
                HttpResponse.Content.ReadAs(Response);
                ReadfromResponse(Response, IRNText, AckNo, AckDt, RQRCode, MessageID);
            end else
                Error('Unable to connect %1', HttpResponse.HttpStatusCode());
        end else
            Error('Cannot connect,connection error');

        Clear(RecRef);
        IF MessageID = '1' THEN
            case DocType of
                1:
                    begin
                        SalesInvoiceHeader.SetRange("No.", DocNo);
                        SalesInvoiceHeader.SetRange("Document Type", SalesInvoiceHeader."Document Type"::Invoice);
                        SalesInvoiceHeader.SetRange("LFS EXIM Type", SalesInvoiceHeader."LFS EXIM Type"::Export);
                        if SalesInvoiceHeader.FindFirst() then begin
                            SalesInvoiceHeader."IRN Hash" := IRNText;
                            SalesInvoiceHeader."Acknowledgement No." := AckNo;
                            SalesInvoiceHeader."Acknowledgement Date" := ConvertAckDt(AckDt);
                            SalesInvoiceHeader.Modify();
                            RecRef.GetTable(SalesInvoiceHeader);
                            QRCodeGen.GenerateQRCodeImage(RQRCode, TempBlob);
                            FieldRef := RecRef.Field(SalesInvoiceHeader.FieldNo("QR Code"));
                            TempBlob.ToRecordRef(RecRef, SalesInvoiceHeader.FieldNo("QR Code"));
                            RecRef.Modify();
                        end;
                        Message(IRNMsg, AckNo, AckDt);
                    end;
            end
        else
            Message(Response);
    end;

    procedure GenerateIRN(DocNo: Code[20]; DocType: Integer; LocGSTIN: Code[20])
    var
#pragma warning disable AA0470
        ConfirmMsg: Label 'Do you want to generate IRN for document no. %1';
#pragma warning restore AA0470
    begin
        If not Confirm(StrSubstNo(ConfirmMsg, DocNo), false) then
            exit;

        Authenticate(LocGSTIN);
        CompInfo.get();

        GlbTextVar := '';
        //Write Common Details
        GlbTextVar += '{';
        WriteToGlbTextVar('action', 'INVOICE', 0, TRUE);
        WriteToGlbTextVar('Version', '1.1', 0, TRUE);
        WriteToGlbTextVar('Irn', '', 0, TRUE);

        case DocType of
            1:
                WriteSalesOrderDetails(DocNo);
        end;
    end;

    procedure GetDocumentTCSAmt(DocNo: Code[20]) DocTCSAmt: Decimal
    var
        SalesInvoiceLine: record "Sales Invoice Line";
    begin
        SalesInvoiceLine.SetRange("Document No.", DocNo);
        SalesInvoiceLine.SetFilter("TCS Nature of Collection", '<>%1', '');
        if SalesInvoiceLine.FindSet() then
            repeat
                DocTCSAmt += GetTDSAmount(SalesInvoiceLine.RecordId);
            until SalesInvoiceLine.Next() = 0;

    end;

    procedure GetDocumentTCSAmtForOrd(DocNo: Code[20]) DocTCSAmt: Decimal
    var
        SalesLine: record "Sales Line";
    begin
        SalesLine.SetRange("Document No.", DocNo);
        SalesLine.SetFilter("TCS Nature of Collection", '<>%1', '');
        if SalesLine.FindSet() then
            repeat
                DocTCSAmt += GetTDSAmount(SalesLine.RecordId);
            until SalesLine.Next() = 0;

    end;

    procedure GetGSTAmount(RecID: RecordID)
    var
        GSTSetup: Record "GST Setup";
        TaxTransactionValue: Record "Tax Transaction Value";

    begin
        Clear(SGSTAmt);
        Clear(CGSTAmt);
        Clear(IGSTAmt);
        Clear(GSTPer);

        if not GSTSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        //TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        TaxTransactionValue.SetFilter(Amount, '<>%1', 0);
        if TaxTransactionValue.FindSet() then
            repeat
                if TaxTransactionValue."Value ID" = 2 then begin
                    CGSTAmt := TaxTransactionValue."Amount (LCY)";
                    GSTPer += TaxTransactionValue.Percent;
                end;

                if TaxTransactionValue."Value ID" = 6 then begin
                    SGSTAmt := TaxTransactionValue."Amount (LCY)";
                    GSTPer += TaxTransactionValue.Percent;
                end;

                if TaxTransactionValue."Value ID" = 3 then begin
                    IGSTAmt := TaxTransactionValue."Amount (LCY)";
                    GSTPer += TaxTransactionValue.Percent;
                end;

                if TaxTransactionValue."Value ID" = 10 then
                    GSTAssAmt := TaxTransactionValue."Amount (LCY)";

            until TaxTransactionValue.Next() = 0;
    end;

    procedure GetJsonBody(var SalesInvoiceHeader: Record "Sales Invoice Header"; glbTxt: Text)
    var
        //TypeHelper: Codeunit "Type Helper";
        OutStream: OutStream;
    begin
        // SalesInvoiceHeader.CalcFields("Json Body");
        SalesInvoiceHeader."Json Body".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(glbTxt);
        SalesInvoiceHeader.Modify();
        //exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), SalesInvoiceHeader.FieldName("Json Body")));
    end;

    procedure GetJsonBodyForSalesOrd(var SalesInvoiceHeader: Record "Sales Header"; glbTxt: Text)
    var
        //TypeHelper: Codeunit "Type Helper";
        OutStream: OutStream;
    begin
        // SalesInvoiceHeader.CalcFields("Json Body");
        SalesInvoiceHeader."Json Body".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(glbTxt);
        SalesInvoiceHeader.Modify();
        //exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), SalesInvoiceHeader.FieldName("Json Body")));
    end;

    procedure GetTotalGSTAmount(RecID: RecordID)
    var
        GSTSetup: Record "GST Setup";
        TaxTransactionValue: Record "Tax Transaction Value";
    begin
        if not GSTSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        // TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        TaxTransactionValue.SetFilter(Amount, '<>%1', 0);
        if TaxTransactionValue.FindSet() then
            repeat
                if TaxTransactionValue."Value ID" = 2 then
                    CGSTAmt += TaxTransactionValue."Amount (LCY)";

                if TaxTransactionValue."Value ID" = 6 then
                    SGSTAmt += TaxTransactionValue."Amount (LCY)";

                if TaxTransactionValue."Value ID" = 3 then
                    IGSTAmt += TaxTransactionValue."Amount (LCY)";

                if TaxTransactionValue."Value ID" = 10 then
                    TotAssVal += TaxTransactionValue."Amount (LCY)";

            until TaxTransactionValue.Next() = 0;
    end;


    local procedure Authenticate(GSTIN: Code[20])
    var
        Client: HttpClient;
        Content: HttpContent;
        Header: HttpHeaders;
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        JsonObject: JsonObject;
        JsonToken: JsonToken;
        L_Message: Text;
        MessageID: Text;
    begin
        GSTRegNos.Get(GSTIN);
        GSTRegNos.TestField("Client Id");
        GSTRegNos.TestField("Client Secret");
        GSTRegNos.TestField("IP Address");
        GSTRegNos.TestField("User Name");
        GSTRegNos.TestField(Password);
        GSTRegNos.TestField(Description);

        GlbTextVar += '{';
        WriteToGlbTextVar('action', 'ACCESSTOKEN', 0, TRUE);
        WriteToGlbTextVar('UserName', GSTRegNos."User Name", 0, TRUE);
        WriteToGlbTextVar('Password', GSTRegNos.Password, 0, TRUE);
        WriteToGlbTextVar('Gstin', GSTRegNos.Code, 0, FALSE);
        GlbTextVar += '}';

        Request.Method := 'Post';
        Request.SetRequestUri(GSTRegNos."Authentication URL");
        Content.WriteFrom(GlbTextVar);
        Content.GetHeaders(Header);
        Header.Add('client_id', GSTRegNos."Client Id");
        Header.Add('client_secret', GSTRegNos."Client Secret");
        Header.Add('IPAddress', GSTRegNos."IP Address");
        Header.Remove('Content-Type');
        Header.Add('Content-Type', 'application/json');
        Request.Content(Content);
        if Client.Send(Request, Response) then begin
            if Response.IsSuccessStatusCode then begin
                Response.Content.ReadAs(L_Message);
                JsonObject.ReadFrom(L_Message);
                if JsonObject.Get('MessageId', JsonToken) then
                    MessageID := JsonToken.AsValue().AsText();

            end else
                Error('Unable to authenticate %1', Response.HttpStatusCode());
        end else
            Error('Cannot connect,connection error');

        IF MessageID = '0' THEN
            ERROR(L_Message)
    end;

    local procedure ClearGSTVariabales()
    begin
        Clear(CGSTAmt);
        Clear(SGSTAmt);
        Clear(IGSTAmt);
        Clear(GSTPer);
        Clear(GSTAssAmt);
        Clear(PreviousLineNo);
        Clear(TCSAmt);
        clear(EwayBillNo);
        clear(EwayBillDt);
        clear(EwayBillValid);
    end;

    local procedure ConvertAckDt(Dt: Text) DateTimeL: DateTime;
    var
        DD: Integer;
        MM: Integer;
        YYYY: Integer;
        TimeL: Time;
    begin
        EVALUATE(YYYY, COPYSTR(Dt, 1, 4));
        EVALUATE(MM, COPYSTR(Dt, 6, 2));
        EVALUATE(DD, COPYSTR(dt, 9, 2));
        EVALUATE(TimeL, COPYSTR(Dt, 12, 8));
        DateTimeL := CREATEDATETIME(DMY2DATE(DD, MM, YYYY), TimeL);
    end;

    local procedure ConvertEnumToInt(EnumValue: Enum "e-Invoice Cancel Reason"): Integer
    var
        CancelReason: Enum "e-Invoice Cancel Reason";
    begin
        CancelReason := EnumValue;
        exit(CancelReason.AsInteger());
    end;

    local procedure GetOtherChargesForOrd(DocNo: Code[20]; DocType: Integer) OthAmt: Decimal
    var
        SalesLine: Record "Sales Line";
    begin
        Clear(DocType);
        SalesLine.SetRange("Document No.", DocNo);
        SalesLine.SetRange(Type, SalesLine.Type::"Charge (Item)");
        SalesLine.SetFilter("HSN/SAC Code", '%1', '');
        if SalesLine.FindSet() then
            repeat
                OthAmt += SalesLine."Line Amount";
            until SalesLine.Next() = 0;
        exit(OthAmt);
    end;


    local procedure GetTDSAmount(RecID: RecordID): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        TCSSetup: Record "TCS Setup";
    begin
        if not TCSSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        TaxTransactionValue.SetRange("Tax Type", TCSSetup."Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if not TaxTransactionValue.IsEmpty() then
            TaxTransactionValue.CalcSums(Amount);

        exit(TaxTransactionValue.Amount);
    end;

    local procedure ReadCancelResponse(Response: Text; var CancelDt: Text; var MessageId: Text)
    var
        json_object: JsonObject;
        json_token: JsonToken;
        valuejson_token: JsonToken;
    begin
        if json_token.ReadFrom(Response) then begin

            if json_token.IsObject then begin
                json_object := json_token.AsObject();
                json_object.Get('MessageId', valuejson_token);
                MessageId := valuejson_token.AsValue().AsText();
                IF MessageId = '1' then
                    if json_object.Get('Data', json_token) then begin
                        if json_token.IsObject then begin
                            json_object := json_token.AsObject();
                            json_object.Get('CancelDate', valuejson_token);
                            CancelDt := valuejson_token.AsValue().AsText();
                        end;
                    end;
            end;
        end;
    end;

    local procedure ReadfromResponse(Response: Text; var IRNNo: Text[64]; var AckNo: Text[30]; var AckDt: Text; var QrCode: Text; var MessageId: Text)
    var
        json_object: JsonObject;
        json_token: JsonToken;
        valuejson_token: JsonToken;
    begin
        if json_token.ReadFrom(Response) then
            if json_token.IsObject then begin
                json_object := json_token.AsObject();
                json_object.Get('MessageId', valuejson_token);
                MessageId := valuejson_token.AsValue().AsText();
                IF MessageId = '1' then
                    if json_object.Get('Data', json_token) then
                        if json_token.IsObject then begin
                            json_object := json_token.AsObject();
                            json_object.Get('Irn', valuejson_token);
                            IRNNo := CopyStr(valuejson_token.AsValue().AsText(), 1, 64);
                            json_object.Get('AckNo', valuejson_token);
                            AckNo := CopyStr(valuejson_token.AsValue().AsText(), 1, 30);
                            json_object.Get('AckDt', valuejson_token);
                            AckDt := valuejson_token.AsValue().AsText();
                            json_object.Get('SignedQRCode', valuejson_token);
                            QrCode := valuejson_token.AsValue().AsText();
                        end;
            end;
    end;

    local procedure RoundOfAmt(DocNo: Code[20]; DocType: Integer) RoundOfAmt: Decimal
    begin
        CLEAR(RoundOfAmt);
        IF DocType = 1 THEN BEGIN
            SaleaInvLine.RESET();
            SaleaInvLine.SETRANGE("Document No.", DocNo);
            SaleaInvLine.SETRANGE("No.", '403255');
            SaleaInvLine.SETRANGE(Type, SaleaInvLine.Type::"G/L Account");
            IF SaleaInvLine.FINDFIRST() THEN
                RoundOfAmt := SaleaInvLine."Line Amount";
            EXIT(RoundOfAmt);
        END ELSE
            IF DocType = 2 THEN BEGIN
                SalesCreditMemoLine.RESET();
                SalesCreditMemoLine.SETRANGE("Document No.", DocNo);
                SalesCreditMemoLine.SETRANGE("No.", '403255');
                SalesCreditMemoLine.SETRANGE(Type, SalesCreditMemoLine.Type::"G/L Account");
                IF SalesCreditMemoLine.FINDFIRST() THEN
                    RoundOfAmt := SalesCreditMemoLine."Line Amount";
                EXIT(RoundOfAmt);
            END;
    end;

    //Unposted Export Sales Order++
    local procedure WriteSalesOrderDetails(InvoiceNo: code[20])
    var
        FixedAsset: Record "Fixed Asset";
        // DtldGSTLedgEntry: Record "Detailed GST Ledger Entry";
        GLAccount: Record "G/L Account";
        Items: Record Item;
        ChargeItem: Record "Item Charge";
        Location: Record Location;
        SalesInvoiceHeader: Record "Sales Header";
        SalesInvoiceLine: Record "Sales Line";
        SalesLine: Record "Sales Line";
        ShiptoAddress: Record "Ship-to Address";
        State: Record State;
        UnitofMeasure: Record "Unit of Measure";
        RecRef: RecordRef;
        FieldRef: FieldRef;
        OthCharges: Decimal;
        TCSAmount: Decimal;
        Client: HttpClient;
        HttpContent: HttpContent;
        HttpHeader: HttpHeaders;
        HttpRequest: HttpRequestMessage;
        HttpResponse: HttpResponseMessage;
        LineCnt: Integer;
        // AssVal: Decimal;
        SalesLineCount: Integer;
        AckDt: text;
        // IRNStatus: text;
        MessageID: text;
        Response: Text;
        RQRCode: text;
        AckNo: Text[30];
        IRNText: Text[64];
    // OutS: InStream;
    begin
        SalesInvoiceHeader.Get(SalesInvoiceHeader."Document Type"::Invoice, InvoiceNo);

        //WriteTransDtls ++
        GlbTextVar += '"TpApiTranDtls": {';
        //WriteToGlbTextVar('RevReverseCharge', CheckReverseCharge(SalesInvoiceHeader."No."), 0, TRUE);
        WriteToGlbTextVar('RevReverseCharge', 'N', 0, TRUE);
        case SalesInvoiceHeader."GST Customer Type" of
            "GST Customer Type"::Registered,
            "GST Customer Type"::Exempted:
                WriteToGlbTextVar('Typ', 'B2B', 0, TRUE);
            "GST Customer Type"::Export:
                if SalesInvoiceHeader."GST Without Payment of Duty" then
                    WriteToGlbTextVar('Typ', 'EXPWOP', 0, TRUE)
                else
                    WriteToGlbTextVar('Typ', 'EXPWP', 0, TRUE);
            "GST Customer Type"::Unregistered:
                WriteToGlbTextVar('Typ', '', 0, TRUE);
            "GST Customer Type"::"SEZ Unit",
              "GST Customer Type"::"SEZ Development":
                if SalesInvoiceHeader."GST Without Payment of Duty" then
                    WriteToGlbTextVar('Typ', 'SEZWOP', 0, TRUE)
                ELSE
                    WriteToGlbTextVar('Typ', 'SEZWP', 0, TRUE);
            "GST Customer Type"::"Deemed Export":
                WriteToGlbTextVar('Typ', 'DEXP', 0, TRUE);
        end;
        WriteToGlbTextVar('TaxPayerType', 'GST', 0, FALSE);
        GlbTextVar += '},';
        //WriteTransDtls --
        //Write TpApiDocDtls ++
        GlbTextVar += '"TpApiDocDtls": {';
        if (SalesInvoiceHeader."Invoice Type" <> SalesInvoiceHeader."Invoice Type"::"Debit Note") and
        (SalesInvoiceHeader."Invoice Type" <> SalesInvoiceHeader."Invoice Type"::Supplementary) then
            WriteToGlbTextVar('DocTyp', 'INV', 0, TRUE)
        else
            WriteToGlbTextVar('DocTyp', 'DBN', 0, TRUE);
        WriteToGlbTextVar('DocNo', SalesInvoiceHeader."Posting No.", 0, TRUE);
        WriteToGlbTextVar('DocDate', FORMAT(SalesInvoiceHeader."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'), 0, TRUE);
        WriteToGlbTextVar('OrgInvNo', SalesInvoiceHeader."Posting No.", 0, FALSE);
        GlbTextVar += '},';
        //Write TpApiDocDtls --
        //Write SellerDtls ++
        GlbTextVar += '"TpApiSellerDtls": {';
        WriteToGlbTextVar('GstinNo', SalesInvoiceHeader."Location GST Reg. No.", 0, TRUE);
        Location.GET(SalesInvoiceHeader."Location Code");
        WriteToGlbTextVar('LegalName', CompInfo.Name, 0, TRUE);
        WriteToGlbTextVar('TrdName', Location.Name, 0, TRUE);
        WriteToGlbTextVar('Address1', Location.Address, 0, TRUE);
        WriteToGlbTextVar('Address2', Location."Address 2", 0, TRUE);
        WriteToGlbTextVar('Location', Location.City, 0, TRUE);
        WriteToGlbTextVar('Pincode', Location."Post Code", 1, TRUE);
        State.GET(Location."State Code");
        WriteToGlbTextVar('StateCode', State."State Code (GST Reg. No.)", 0, FALSE);
        GlbTextVar += '},';
        //Write SellerDtls ++
        //Write BuyerDtls ++
        GlbTextVar += '"TpApiBuyerDtls": {';
        case SalesInvoiceHeader."GST Customer Type" of

            "GST Customer Type"::Registered,
            "GST Customer Type"::"SEZ Unit",
            "GST Customer Type"::"SEZ Development",
            "GST Customer Type"::"Deemed Export":
                begin
                    // WriteToGlbTextVar('GstinNo', '06AAACB0652N007', 0, TRUE);
                    WriteToGlbTextVar('GstinNo', SalesInvoiceHeader."Customer GST Reg. No.", 0, TRUE);
                    if SalesInvoiceHeader."Ship-to Code" = '' then
                        State.GET(SalesInvoiceHeader."GST Bill-to State Code")
                    else
                        State.Get(SalesInvoiceHeader."GST Ship-to State Code");
                    WriteToGlbTextVar('LegalName', SalesInvoiceHeader."Bill-to Name", 0, TRUE);
                    WriteToGlbTextVar('TrdName', SalesInvoiceHeader."Bill-to Name", 0, TRUE);
                    WriteToGlbTextVar('PlaceOfSupply', State."State Code (GST Reg. No.)", 0, TRUE);
                    WriteToGlbTextVar('Address1', SalesInvoiceHeader."Bill-to Address", 0, TRUE);
                    WriteToGlbTextVar('Location', SalesInvoiceHeader."Bill-to City", 0, TRUE);
                    WriteToGlbTextVar('Pincode', SalesInvoiceHeader."Bill-to Post Code", 1, TRUE);
                    State.GET(SalesInvoiceHeader."GST Bill-to State Code");
                    WriteToGlbTextVar('StateCode', State."State Code (GST Reg. No.)", 0, FALSE);

                end;
            "GST Customer Type"::Export:
                BEGIN
                    WriteToGlbTextVar('GstinNo', 'URP', 0, TRUE);
                    WriteToGlbTextVar('LegalName', SalesInvoiceHeader."Bill-to Name", 0, TRUE);
                    WriteToGlbTextVar('TrdName', SalesInvoiceHeader."Bill-to Name", 0, TRUE);
                    WriteToGlbTextVar('PlaceOfSupply', '96', 0, TRUE);
                    WriteToGlbTextVar('Address1', SalesInvoiceHeader."Bill-to Address", 0, TRUE);
                    WriteToGlbTextVar('Location', SalesInvoiceHeader."Bill-to City", 0, TRUE);
                    WriteToGlbTextVar('Pincode', '999999', 1, TRUE);
                    WriteToGlbTextVar('StateCode', '96', 0, false);
                    // WriteToGlbTextVar('CountryCode', SalesInvoiceHeader."Bill-to Country/Region Code", 0, FALSE)
                END;

        end;
        GlbTextVar += '},';

        //Write ShipDtls ++
        if SalesInvoiceHeader."Ship-to Code" <> '' then begin
            GlbTextVar += '"TpApiShipDtls": {';
            ShiptoAddress.GET(SalesInvoiceHeader."Bill-to Customer No.", SalesInvoiceHeader."Ship-to Code");
            IF SalesInvoiceHeader."Ship-to GST Reg. No." <> '' THEN
                WriteToGlbTextVar('GstinNo', SalesInvoiceHeader."Ship-to GST Reg. No.", 0, TRUE)
            ELSE
                WriteToGlbTextVar('GstinNo', 'URP', 0, TRUE);

            WriteToGlbTextVar('LegalName', ShiptoAddress.Name, 0, TRUE);
            WriteToGlbTextVar('TrdName', ShiptoAddress.Name, 0, TRUE);
            WriteToGlbTextVar('Address1', ShiptoAddress.Address, 0, TRUE);
            WriteToGlbTextVar('Address2', ShiptoAddress."Address 2", 0, TRUE);
            WriteToGlbTextVar('Location', ShiptoAddress.City, 0, TRUE);
            IF SalesInvoiceHeader."GST Customer Type" <> SalesInvoiceHeader."GST Customer Type"::Export THEN BEGIN
                State.GET(ShiptoAddress.State);
                WriteToGlbTextVar('Pincode', ShiptoAddress."Post Code", 1, TRUE);
                WriteToGlbTextVar('StateCode', State."State Code (GST Reg. No.)", 0, FALSE);
            END ELSE BEGIN
                WriteToGlbTextVar('Pincode', '999999', 1, TRUE);
                WriteToGlbTextVar('StateCode', '96', 0, FALSE);
            END;
            GlbTextVar += '},';
        end;
        //Write ShipDtls --
        //Write ValDtls ++
        GlbTextVar += '"TpApiValDtls": {';

        SalesLine.Reset();
        SalesLine.SetRange("Document Type", SalesInvoiceHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesInvoiceHeader."No.");
        SalesLine.SETFILTER(Type, '<>%1', SalesLine.Type::" ");
        SalesLine.SetFilter("No.", '<>%1', '403255');
        SalesLine.SetFilter(Quantity, '<>%1', 0);
        if SalesLine.FindSet() then
            repeat
                GetTotalGSTAmount(SalesLine.RecordId);
            until SalesLine.Next() = 0;

        TCSAmount := GetDocumentTCSAmtForOrd(SalesInvoiceHeader."No.");
        OthCharges := GetOtherChargesForOrd(SalesInvoiceHeader."No.", 1);
        WriteToGlbTextVar('TotalTaxableVal', FORMAT(Round(ABS(TotAssVal), 0.01), 0, 2), 1, TRUE);
        WriteToGlbTextVar('TotalSgstVal', FORMAT(Round(ABS(SGSTAmt), 0.01), 0, 2), 1, TRUE);
        WriteToGlbTextVar('TotalCgstVal', FORMAT(Round(ABS(CGSTAmt), 0.01), 0, 2), 1, TRUE);
        WriteToGlbTextVar('TotalIgstVal', FORMAT(Round(ABS(IGSTAmt), 0.01), 0, 2), 1, TRUE);
        WriteToGlbTextVar('TotalCesVal', FORMAT(0), 1, TRUE);
        WriteToGlbTextVar('TotalStateCesVal', FORMAT(0), 1, TRUE);

        WriteToGlbTextVar('OthChrg', FORMAT(Round(ABS(TCSAmount + OthCharges), 0.01), 0, 2), 1, TRUE);
        WriteToGlbTextVar('RoundofAmt', FORMAT(RoundOfAmt(SalesInvoiceHeader."No.", 1)), 1, TRUE);
        WriteToGlbTextVar('TotInvoiceVal', FORMAT(Round(ABS(TotAssVal + CGSTAmt + SGSTAmt + IGSTAmt + OthCharges - abs(TCSAmount) + RoundOfAmt(SalesInvoiceHeader."No.", 1)), 0.01), 0, 2), 1, FALSE);

        GlbTextVar += '},';
        //Write ValDtls --

        //Write ExpDtls ++
        if SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."GST Customer Type"::Export then begin
            GlbTextVar += '"TpApiExpDtls": {';
            // WriteToGlbTextVar('ShippingBillNo', SalesInvoiceHeader."Bill Of Export No.", 0, TRUE);
            // WriteToGlbTextVar('ShippingBillDate', FORMAT(SalesInvoiceHeader."Bill Of Export Date", 0, '<Day,2>/<Month,2>/<Year4>'), 0, TRUE);
            // WriteToGlbTextVar('ShippingBillNo', 'null', 0, TRUE);
            // WriteToGlbTextVar('ShippingBillDate', '', 0, TRUE);
            WriteToGlbTextVar('PortCode', SalesInvoiceHeader."LFS Port of Loading", 0, TRUE);
            WriteToGlbTextVar('RefundClaim', 'N', 0, TRUE);
            IF SalesInvoiceHeader."Currency Code" <> '' THEN begin
                WriteToGlbTextVar('ForeignCurrency', SalesInvoiceHeader."Currency Code", 0, TRUE);
                WriteToGlbTextVar('CountryCode', SalesInvoiceHeader."Bill-to Country/Region Code", 0, FALSE)
            end else begin
                WriteToGlbTextVar('ForCur', 'INR', 0, TRUE);
                WriteToGlbTextVar('CntCode', 'IN', 0, FALSE);
            end;
            GlbTextVar += '},';
        end;
        //Write ExpDtls --

        //Write ItemList
        ClearGSTVariabales();
        GlbTextVar += '"TpApiItemList": [';
        SalesInvoiceLine.SetRange("Document Type", SalesInvoiceLine."Document Type"::Invoice);
        SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
        SalesInvoiceLine.SETFILTER(Type, '<>%1', SalesInvoiceLine.Type::" ");
        SalesInvoiceLine.SetFilter("No.", '<>%1', '403255');
        SalesInvoiceLine.SetFilter(Quantity, '<>%1', 0);
        if SalesInvoiceLine.FindSet() then begin
            SalesLineCount := SalesInvoiceLine.Count;
            repeat
                LineCnt += 1;
                GlbTextVar += '{';
                WriteToGlbTextVar('SiNo', FORMAT(LineCnt), 0, TRUE);
                case SalesInvoiceLine.Type of
                    SalesInvoiceLine.Type::"G/L Account":
                        begin
                            GLAccount.Get(SalesInvoiceLine."No.");
                            WriteToGlbTextVar('ProductDesc', GLAccount.Name, 0, TRUE);
                            if SalesInvoiceLine."GST Group Type" = SalesInvoiceLine."GST Group Type"::Service then
                                WriteToGlbTextVar('IsService', 'Y', 0, TRUE)
                            else
                                WriteToGlbTextVar('IsService', 'N', 0, TRUE);
                        end;
                    SalesInvoiceLine.Type::"Charge (Item)":
                        begin
                            ChargeItem.Get(SalesInvoiceLine."No.");
                            WriteToGlbTextVar('ProductDesc', ChargeItem.Description, 0, TRUE);
                            if SalesInvoiceLine."GST Group Type" = SalesInvoiceLine."GST Group Type"::Service then
                                WriteToGlbTextVar('IsService', 'Y', 0, TRUE)
                            else
                                WriteToGlbTextVar('IsService', 'N', 0, TRUE);
                        end;
                    SalesInvoiceLine.Type::Item:
                        begin
                            Items.Get(SalesInvoiceLine."No.");
                            WriteToGlbTextVar('ProductDesc', Items.Description, 0, TRUE);
                            if SalesInvoiceLine."GST Group Type" = SalesInvoiceLine."GST Group Type"::Service then
                                WriteToGlbTextVar('IsService', 'Y', 0, TRUE)
                            else
                                WriteToGlbTextVar('IsService', 'N', 0, TRUE);
                        end;
                    SalesInvoiceLine.Type::"Fixed Asset":
                        begin
                            FixedAsset.Get((SalesInvoiceLine."No."));
                            WriteToGlbTextVar('ProductDesc', FixedAsset.Description, 0, TRUE);
                            if SalesInvoiceLine."GST Group Type" = SalesInvoiceLine."GST Group Type"::Service then
                                WriteToGlbTextVar('IsService', 'Y', 0, TRUE)
                            else
                                WriteToGlbTextVar('IsService', 'N', 0, TRUE);
                        end;
                end;
                WriteToGlbTextVar('HsnCode', SalesInvoiceLine."HSN/SAC Code", 0, TRUE);
                WriteToGlbTextVar('Quantity', FORMAT(ABS(SalesInvoiceLine.Quantity), 0, 2), 1, TRUE);

                Clear(GSTPer);
                Clear(GSTAssAmt);
                Clear(TCSAmount);
                Clear(CGSTAmt);
                Clear(SGSTAmt);
                Clear(IGSTAmt);
                GetGSTAmount(SalesInvoiceLine.RecordId); //calculate GST
                // DtldGSTLedgEntry.Reset();
                // DtldGSTLedgEntry.SetRange("Document No.", SalesInvoiceHeader."No.");
                // DtldGSTLedgEntry.SetRange("Document Line No.", SalesInvoiceLine."Line No.");
                // DtldGSTLedgEntry.SetRange("Entry Type", DtldGSTLedgEntry."Entry Type"::"Initial Entry");
                // IF DtldGSTLedgEntry.FindSet() then
                //     repeat
                //         if PreviousLineNo <> DtldGSTLedgEntry."Document Line No." then
                //             GSTAssAmt += DtldGSTLedgEntry."GST Base Amount";
                //         IF DtldGSTLedgEntry."GST Component Code" = 'CGST' then begin
                //             GSTPer += DtldGSTLedgEntry."GST %";
                //             CGSTAmt := DtldGSTLedgEntry."GST Amount";
                //         end;

                //         if DtldGSTLedgEntry."GST Component Code" = 'SGST' then begin
                //             GSTPer += DtldGSTLedgEntry."GST %";
                //             SGSTAmt := DtldGSTLedgEntry."GST Amount";
                //         end;
                //         if DtldGSTLedgEntry."GST Component Code" = 'IGST' then begin
                //             GSTPer := DtldGSTLedgEntry."GST %";
                //             IGSTAmt := DtldGSTLedgEntry."GST Amount";
                //         end;
                //         PreviousLineNo := DtldGSTLedgEntry."Document Line No.";
                //     until DtldGSTLedgEntry.Next() = 0;

                if (SalesInvoiceLine.Type = SalesInvoiceLine.Type::"Charge (Item)") or (SalesInvoiceLine.Type = SalesInvoiceLine.Type::"G/L Account") then
                    WriteToGlbTextVar('Unit', 'NOS', 0, TRUE)
                else
                    if UnitofMeasure.GET(SalesInvoiceLine."Unit of Measure Code") then
                        WriteToGlbTextVar('Unit', UnitofMeasure."International Standard Code", 0, TRUE);

                //UnitofMeasure.GET(SalesInvoiceLine."Unit of Measure Code");
                //WriteToGlbTextVar('Unit', UnitofMeasure."International Standard Code", 0, TRUE);
                TCSAmount := GetTDSAmount(SalesInvoiceLine.RecordId);
                IF SalesInvoiceHeader."Currency Code" = '' THEN BEGIN
                    WriteToGlbTextVar('UnitPrice', FORMAT(Round(SalesInvoiceLine."Unit Price", 0.00001), 0, 2), 1, TRUE);
                    WriteToGlbTextVar('TotAmount', FORMAT(Round((SalesInvoiceLine."Line Amount"), 0.01), 0, 2), 1, TRUE);
                    WriteToGlbTextVar('AssAmount', FORMAT(Round(ABS(GSTAssAmt), 0.01), 0, 2), 1, TRUE);
                    WriteToGlbTextVar('TotItemVal', FORMAT(Round(ABS(GSTAssAmt) + abs(CGSTAmt) + abs(SGSTAmt) + abs(IGSTAmt) + abs(TCSAmount), 0.01), 0, 2), 1, true);
                END ELSE BEGIN
                    WriteToGlbTextVar('UnitPrice', FORMAT(Round((SalesInvoiceLine."Unit Price" / SalesInvoiceHeader."Currency Factor"), 0.01), 0, 2), 1, TRUE);
                    WriteToGlbTextVar('TotAmount', FORMAT(Round((SalesInvoiceLine."Line Amount" / SalesInvoiceHeader."Currency Factor"), 0.01), 0, 2), 1, TRUE);
                    WriteToGlbTextVar('Discount', FORMAT(Round(((SalesInvoiceLine."Inv. Discount Amount" + SalesInvoiceLine."Line Discount Amount") / SalesInvoiceHeader."Currency Factor"), 0.01), 0, 2), 1, TRUE);
                    WriteToGlbTextVar('AssAmount', FORMAT(Round(((SalesInvoiceLine."Line Amount" - (SalesInvoiceLine."Inv. Discount Amount" + SalesInvoiceLine."Line Discount Amount")) / SalesInvoiceHeader."Currency Factor"), 0.01), 0, 2), 1, TRUE);
                    IF SalesInvoiceLine.Type = SalesInvoiceLine.Type::"Charge (Item)" then
                        WriteToGlbTextVar('TotItemVal', FORMAT(Round(((SalesInvoiceLine."Line Amount") / SalesInvoiceHeader."Currency Factor"), 0.01), 0, 2), 1, true)
                    else
                        WriteToGlbTextVar('TotItemVal', FORMAT(Round(ABS(GSTAssAmt) + abs(CGSTAmt) + abs(SGSTAmt) + abs(IGSTAmt) + abs(TCSAmount), 0.01), 0, 2), 1, true);
                END;

                WriteToGlbTextVar('OtherCharges', FORMAT(Round(abs(TCSAmount), 0.01), 0, 2), 1, TRUE);
                WriteToGlbTextVar('GSTRate', FORMAT(Round(GSTPer, 0.01), 0, 2), 1, TRUE);
                WriteToGlbTextVar('CgstAmt', FORMAT(Round(abs(CGSTAmt), 0.01), 0, 2), 1, TRUE);
                WriteToGlbTextVar('SgstAmt', FORMAT(Round(abs(SGSTAmt), 0.01), 0, 2), 1, TRUE);
                WriteToGlbTextVar('IgstAmt', FORMAT(Round(abs(IGSTAmt), 0.01), 0, 2), 1, false);

                IF LineCnt <> SalesLineCount THEN
                    GlbTextVar += '},'
                ELSE
                    GlbTextVar += '}'
                until SalesInvoiceLine.Next() = 0;
        end;
        GlbTextVar += ']';
        GlbTextVar += '}';
        //Write ItemList --
        Message(GlbTextVar);

        // SalesInvoiceHeader.Validate("Json Body");
        GetJsonBodyForSalesOrd(SalesInvoiceHeader, GlbTextVar);

        HttpRequest.Method := 'POST';
        HttpRequest.SetRequestUri(GSTRegNos."E-Invoice URL");
        HttpContent.WriteFrom(GlbTextVar);
        HttpContent.GetHeaders(HttpHeader);
        HttpHeader.Add('client_id', GSTRegNos."Client Id");
        HttpHeader.Add('client_secret', GSTRegNos."Client Secret");
        HttpHeader.Add('IPAddress', GSTRegNos."IP Address");
        HttpHeader.Remove('Content-Type');
        HttpHeader.Add('Content-Type', 'application/json');
        HttpHeader.Add('user_name', GSTRegNos."User Name");
        //Header.Add('Gstin', GSTRegNos.Code);// To be uncommented when deploying
        HttpHeader.Add('Gstin', GSTRegNos.Code);
        HttpRequest.Content(HttpContent);
        if Client.Send(HttpRequest, HttpResponse) then begin
            if HttpResponse.HttpStatusCode() = 200 then begin
                HttpResponse.Content.ReadAs(Response);
                ReadfromResponse(Response, IRNText, AckNo, AckDt, RQRCode, MessageID);
            end else
                Error('Unable to connect %1', HttpResponse.HttpStatusCode());
        end else
            Error('Cannot connect,connection error');

        Clear(RecRef);
        IF MessageID = '1' THEN BEGIN
            SalesInvoiceHeader."IRN Hash" := IRNText;
            SalesInvoiceHeader."Acknowledgement No." := AckNo;
            SalesInvoiceHeader."Acknowledgement Date" := ConvertAckDt(AckDt);
            SalesInvoiceHeader.Modify();
            RecRef.GetTable(SalesInvoiceHeader);
            QRCodeGen.GenerateQRCodeImage(RQRCode, TempBlob);
            FieldRef := RecRef.Field(SalesInvoiceHeader.FieldNo("QR Code"));
            TempBlob.ToRecordRef(RecRef, SalesInvoiceHeader.FieldNo("QR Code"));
            RecRef.Modify();
            MESSAGE(IRNMsg, AckNo, AckDt);
        END ELSE
            MESSAGE(Response);

    end;

    local procedure WriteToGlbTextVar(label: Text; Value: Text; ValFormat: Option Text,Number; InsertComma: Boolean)
    var
        CommaLbl: Label ',';
        DoubleQuotesLbl: Label '"';
    begin
        IF Value <> '' THEN BEGIN
            IF ValFormat = ValFormat::Text THEN BEGIN
                IF InsertComma THEN
                    GlbTextVar += DoubleQuotesLbl + Label + DoubleQuotesLbl + ': ' + DoubleQuotesLbl + Value + DoubleQuotesLbl + CommaLbl
                ELSE
                    GlbTextVar += DoubleQuotesLbl + Label + DoubleQuotesLbl + ': ' + DoubleQuotesLbl + Value + DoubleQuotesLbl;
            END ELSE BEGIN
                IF InsertComma THEN
                    GlbTextVar += DoubleQuotesLbl + Label + DoubleQuotesLbl + ': ' + Value + CommaLbl
                ELSE
                    GlbTextVar += DoubleQuotesLbl + Label + DoubleQuotesLbl + ': ' + Value;
            END;
        END ELSE BEGIN
            IF ValFormat = ValFormat::Text THEN BEGIN
                IF InsertComma THEN
                    GlbTextVar += DoubleQuotesLbl + Label + DoubleQuotesLbl + ': ' + DoubleQuotesLbl + DoubleQuotesLbl + CommaLbl
                ELSE
                    GlbTextVar += DoubleQuotesLbl + Label + DoubleQuotesLbl + ': ' + DoubleQuotesLbl + DoubleQuotesLbl;
            END
            ELSE BEGIN
                IF InsertComma THEN
                    GlbTextVar += DoubleQuotesLbl + Label + DoubleQuotesLbl + ': ' + DoubleQuotesLbl + '0' + DoubleQuotesLbl + CommaLbl
                ELSE
                    GlbTextVar += DoubleQuotesLbl + Label + DoubleQuotesLbl + ': ' + DoubleQuotesLbl + '0' + DoubleQuotesLbl;
            END;
        END;
    end;
}