namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Purchases.History;
using Microsoft.Sales.History;
using Microsoft.Purchases.Document;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Finance.GeneralLedger.Posting;
using Microsoft.Utilities;
using Microsoft.Warehouse.Request;
using Microsoft.Inventory.Location;
using Microsoft.Sales.Customer;
using Microsoft.Purchases.Vendor;
using Microsoft.Foundation.Attachment;
using Microsoft.Sales.Document;
using Microsoft.Sales.Posting;
using Microsoft.Warehouse.History;
using Microsoft.Warehouse.Document;
using Microsoft.Purchases.Posting;
using Microsoft.Foundation.NoSeries;
using Microsoft.Purchases.Setup;
codeunit 72002 "LFS EXIM Event Subscribers"
{
    Permissions = tabledata "Purch. Inv. Line" = m, tabledata "Sales Invoice Header" = m, tabledata "Sales Invoice Line" = m, tabledata "Sales Shipment Header" = m;

    local procedure GetNextImpLicLineNo(EXIMpostedLicPara: Record "LFS EXIM Posted Import Licence"): Integer
    var
        EXIMpostedLic: Record "LFS EXIM Posted Import Licence";
    begin
        EXIMpostedLic.Reset();
        EXIMpostedLic.SetRange("LFS Source Type", EXIMpostedLicPara."LFS Source Type");
        EXIMpostedLic.SetRange("LFS Source No.", EXIMpostedLicPara."LFS Source No.");
        EXIMpostedLic.SetRange("LFS Source line No.", EXIMpostedLicPara."LFS Source line No.");
        if EXIMpostedLic.FindLast() then
            exit(EXIMpostedLic."LFS Line No." + 10000)
        else
            exit(EXIMpostedLic."LFS Line No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", OnCopySalesDocWithHeader, '', false, false)]
    local procedure "Copy Document Mgt._OnCopySalesDocWithHeader"(FromDocType: Option; FromDocNo: Code[20]; var ToSalesHeader: Record "Sales Header"; FromDocOccurenceNo: Integer; FromDocVersionNo: Integer; var FromSalesHeader: Record "Sales Header")
    begin
        if ToSalesHeader."LFS EXIM Type" = ToSalesHeader."LFS EXIM Type"::Export then begin
            ToSalesHeader.Validate("LFS Custom Currency Code", FromSalesHeader."LFS Custom Currency Code");
            ToSalesHeader.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Report, Report::"Copy Sales Document", OnBeforeLookupPostedInvoice, '', false, false)]
    local procedure "Copy Sales Document_OnBeforeLookupPostedInvoice"(var FromSalesInvHeader: Record "Sales Invoice Header"; var SalesHeader: Record "Sales Header")
    begin
        if SalesHeader."LFS EXIM Type" = SalesHeader."LFS EXIM Type"::Export then begin
            FromSalesInvHeader.SetFilter("LFS EXIM Type", '=%1', SalesHeader."LFS EXIM Type"::Export);
            if not FromSalesInvHeader.IsEmpty then;
        end
        else begin
            if SalesHeader."LFS EXIM Type" = SalesHeader."LFS EXIM Type"::" " then
                FromSalesInvHeader.SetFilter("LFS EXIM Type", '=%1', SalesHeader."LFS EXIM Type"::" ");
            if not FromSalesInvHeader.IsEmpty then;
        end;
    end;

    [EventSubscriber(ObjectType::Report, Report::"Copy Sales Document", OnLookupPostedInvoiceOnBeforeRunLookup, '', false, false)]
    local procedure "Copy Sales Document_OnLookupPostedInvoiceOnBeforeRunLookup"(var FromSalesInvoiceHeader: Record "Sales Invoice Header"; var SalesHeader: Record "Sales Header")
    begin
        if SalesHeader."LFS EXIM Type" = SalesHeader."LFS EXIM Type"::Export then begin
            FromSalesInvoiceHeader.SetFilter("LFS EXIM Type", '=%1', SalesHeader."LFS EXIM Type"::Export);
            if not FromSalesInvoiceHeader.IsEmpty then;
        end
        else begin
            if SalesHeader."LFS EXIM Type" = SalesHeader."LFS EXIM Type"::" " then
                FromSalesInvoiceHeader.SetFilter("LFS EXIM Type", '=%1', SalesHeader."LFS EXIM Type"::" ");
            if not FromSalesInvoiceHeader.IsEmpty then;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Doc. Attachment List Factbox", OnAfterGetRecRefFail, '', false, false)]
    local procedure "Doc. Attachment List Factbox_OnAfterGetRecRefFail"(var Sender: Page "Doc. Attachment List Factbox"; DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        EXIMLicenseHeader: Record "LFS EXIM License Header";
    begin
        case DocumentAttachment."Table ID" of
            DATABASE::"LFS EXIM License Header":
                begin
                    RecRef.Open(DATABASE::"LFS EXIM License Header");
                    if EXIMLicenseHeader.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(EXIMLicenseHeader);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", OnAfterInitFieldsFromRecRef, '', false, false)]
    local procedure "Document Attachment_OnAfterInitFieldsFromRecRef"(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of
            DATABASE::"LFS EXIM License Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
        end;
    end;


    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnValidatePostingAndDocumentDateOnAfterCalcPostingDateExists, '', false, false)]
    // local procedure "Sales-Post_OnValidatePostingAndDocumentDateOnAfterCalcPostingDateExists"(var PostingDateExists: Boolean; var ReplacePostingDate: Boolean; var ReplaceDocumentDate: Boolean; var PostingDate: Date; var SalesHeader: Record "Sales Header"; var ModifyHeader: Boolean)
    // var
    //     SalesLine: Record "Sales Line";
    // begin
    //     SalesLine.SetRange("Document No.", SalesHeader."No.");
    //     SalesLine.SetRange("Document Type", SalesHeader."Document Type");
    //     if SalesLine.FindSet() then
    //         repeat
    //             SalesLine.CalculateRoDTEPandDDB();
    //         until SalesLine.Next() = 0;
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforePostSalesDoc, '', false, false)]
    //     local procedure "Sales-Post_OnBeforePostSalesDoc"(var Sender: Codeunit "Sales-Post"; var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean; var IsHandled: Boolean; var CalledBy: Integer)
    //     var
    //         SalesLine1: Record "Sales Line";
    //         Multiple_License: Record "EXIM Export License";
    //         Lic_IO_deatils: Record "EXIM License IO Details";
    //         sales_Header: Record "Sales Header";
    //         CurrncyMaster: Record Currency;
    //         CurrencyExch: Record "Currency Exchange Rate";
    //     begin
    //         if SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then begin
    //             SalesLine1.Reset();
    //             SalesLine1.SetRange("Document No.", SalesHeader."No.");
    //             SalesLine1.SetFilter("Document Type", '%1', SalesLine1.Type::Item);
    //             if SalesLine1.FindSet() then begin
    //                 repeat
    //                     Multiple_License.Reset();
    //                     Multiple_License.SetRange("Source Type", Multiple_License."Source Type"::Invoice);
    //                     Multiple_License.SetRange("Source No.", SalesLine1."Document No.");
    //                     Multiple_License.SetRange("Source line No.", SalesLine1."Line No.");
    //                     if Multiple_License.FindSet() then begin
    //                         repeat
    //                             Lic_IO_deatils.Reset();
    //                             Lic_IO_deatils.SetRange("Adv. License No.", Multiple_License."License No.");
    //                             Lic_IO_deatils.SetRange(Type, Lic_IO_deatils.Type::Export);
    //                             Lic_IO_deatils.SetRange("Item No.", Multiple_License."Item No.");
    //                             Lic_IO_deatils.SetFilter("Export Inv Bal Qty", '>%1', 0);
    //                             Lic_IO_deatils.SetRange("Scheme Type", Lic_IO_deatils."Scheme Type"::"Advance License");
    //                             Lic_IO_deatils.SetRange(Status, Lic_IO_deatils.Status::Active);
    //                             if Lic_IO_deatils.FindSet() then begin
    //                                 if SalesHeader."Currency Code" <> Lic_IO_deatils."Currency Code" then begin
    //                                     CurrencyExch.Reset();
    //                                     CurrencyExch.SetRange("Currency Code", Lic_IO_deatils."Currency Code");
    //                                     CurrencyExch.SetRange("Starting Date", SalesHeader."Posting Date");
    //                                     IF not CurrencyExch.FindFirst() then begin
    //                                         IsHandled := true;
    //                                         Error('Please Enter valid Currecy Rate in Currecy Master for %1 and for %2 Currecy Code', SalesHeader."Posting Date", Lic_IO_deatils."Currency Code")
    //                                     end else
    //                                         IsHandled := false;
    //                                 end;
    //                             end;
    //                         until Multiple_License.Next() = 0;
    //                     end;
    //                 until SalesLine1.Next() = 0;
    //             end;
    //         end;
    //     end;

    // [EventSubscriber(ObjectType::Page, Page::"Item Charge Assignment (Purch)", OnGetReceiptLinesOnActionOnAfterItemChargeAssgntPurchSetFilters, '', false, false)]
    // local procedure "Item Charge Assignment (Purch)_OnGetReceiptLinesOnActionOnAfterItemChargeAssgntPurchSetFilters"(var ItemChargeAssignmentPurch: Record "Item Charge Assignment (Purch)"; var PurchReceiptLines: Record "Purch. Rcpt. Line"; PurchLine: Record "Purchase Line")
    // begin
    //     if ItemChargeAssignmentPurch."LFS Import & Domestic" = false then
    //         PurchReceiptLines.SetRange("LFS_EX_Exim Type", PurchReceiptLines."LFS_EX_Exim Type"::Import)
    //     else
    //         if ItemChargeAssignmentPurch."LFS Import & Domestic" = true then begin
    //             PurchReceiptLines.SetRange("LFS_EX_Exim Type", PurchReceiptLines."LFS_EX_Exim Type"::" ");
    //             PurchReceiptLines.CalcFields("LFS Item Charge No.");
    //             PurchReceiptLines.SetFilter("LFS Item Charge No.", '=%1', '');
    //         end;
    // end;

    [EventSubscriber(ObjectType::Page, Page::"Item Charge Assignment (Purch)", OnGetSalesShipmentLinesOnActionOnAfterItemChargeAssgntPurchSetFilters, '', false, false)]
    local procedure "Item Charge Assignment (Purch)_OnGetSalesShipmentLinesOnActionOnAfterItemChargeAssgntPurchSetFilters"(var ItemChargeAssignmentPurch: Record "Item Charge Assignment (Purch)"; var SalesShptLine: Record "Sales Shipment Line"; PurchLine: Record "Purchase Line")
    begin
        if ItemChargeAssignmentPurch."LFS Import & Domestic" = false then
            SalesShptLine.SetRange("LFS Exim Type", SalesShptLine."LFS Exim Type"::Export)
        else
            if ItemChargeAssignmentPurch."LFS Import & Domestic" = true then begin
                SalesShptLine.SetRange("LFS Exim Type", SalesShptLine."LFS Exim Type"::" ");
                SalesShptLine.CalcFields("LFS Item Charge No.");
                SalesShptLine.SetFilter("LFS Item Charge No.", '=%1', '');
            end;
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnBeforeInitRecord', '', false, false)]
    local procedure LFS_EX_GetPostedExportNos(var IsHandled: Boolean; var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header")
    var
        EximSetup: Record "LFS EXIM Setup";
    // NoSeriesMgt: Codeunit "No. Series";
    begin
        if SalesHeader."LFS EXIM Type" = SalesHeader."LFS EXIM Type"::" " then
            exit;
        EximSetup.Get();
        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice:
                begin
                    // NoSeriesMgt.LookupRelatedNoSeries(SalesHeader."Posting No. Series", EximSetup."LFS Posted Exp Invoice No.");
                    // NoSeriesMgt.LookupRelatedNoSeries(SalesHeader."Shipping No. Series", EximSetup."LFS Posted Exp Shipment No.");
                    SalesHeader."Posting No. Series" := EximSetup."LFS Posted Exp Invoice Nos.";
                    SalesHeader."Shipping No. Series" := EximSetup."LFS Posted Exp Shipment Nos.";
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnBeforeInitRecord', '', false, false)]
    local procedure LFS_EX_GetPostedImportNos(GLSetup: Record "General Ledger Setup"; PurchSetup: Record "Purchases & Payables Setup"; var IsHandled: Boolean; var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header")
    var
        EximSetup: Record "LFS EXIM Setup";
    // NoSeriesMgt: Codeunit NoSeriesManagement;

    begin
        if PurchaseHeader."LFS EXIM Type" = PurchaseHeader."LFS EXIM Type"::" " then
            exit;
        EximSetup.Get();
        case PurchaseHeader."Document Type" of
            PurchaseHeader."Document Type"::Order, PurchaseHeader."Document Type"::Invoice:
                begin
                    PurchaseHeader."Posting No. Series" := EximSetup."LFS Posted Imp Invoice Nos.";
                    PurchaseHeader."Receiving No. Series" := EximSetup."LFS Posted Imp Receipt Nos.";
                    // NoSeriesMgt.SetDefaultSeries(PurchaseHeader."Posting No. Series", EximSetup."LFS_EX_Posted Imp Invoice No.");
                    // NoSeriesMgt.SetDefaultSeries(PurchaseHeader."Receiving No. Series", EximSetup."LFS_EX_Posted Imp Receipt No.");
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnBeforeInitInsert', '', false, false)]
    local procedure LFS_EX_GetUnpostedExportNos(var IsHandled: Boolean; var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header")
    var
        NoSeriesMgt: Codeunit "No. Series";
    begin
        if SalesHeader."LFS EXIM Type" = SalesHeader."LFS EXIM Type"::" " then
            exit;
        SalesHeader.TestEximExportNoSeries();
        // NoSeriesMgt.InitSeries(SalesHeader.GetEximExportNoSeriesCode(), xSalesHeader."No.", SalesHeader."Posting Date", SalesHeader."No.", SalesHeader."No. Series");
        NoSeriesMgt.AreRelated(SalesHeader.GetEximExportNoSeriesCode(), SalesHeader."No. Series");
        // SalesHeader.Validate("No.", NoSeriesMgt.GetNextNo(SalesHeader."No. Series", WorkDate()));
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnBeforeInitInsert', '', false, false)]
    local procedure LFS_EX_GetUnpostedImportNos(var PurchaseHeader: Record "Purchase Header"; var xPurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        NoSeriesMgt: Codeunit "No. Series";
    begin
        if PurchaseHeader."LFS EXIM Type" = PurchaseHeader."LFS EXIM Type"::" " then
            exit;
        PurchaseHeader.TestEximNoSeries();
        NoSeriesMgt.AreRelated(PurchaseHeader.GetEximNoSeriesCode(), PurchaseHeader."No. Series");
        // PurchaseHeader.Validate("No.", NoSeriesMgt.GetNextNo(PurchaseHeader."No. Series", WorkDate()));
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Warehouse Shipment Header", 'OnAfterOnInsert', '', false, false)]
    local procedure LFS_EX_GetUnpostedWhseShipmentNos(var WarehouseShipmentHeader: Record "Warehouse Shipment Header"; var xWarehouseShipmentHeader: Record "Warehouse Shipment Header")
    var
        EximSetup: Record "LFS EXIM Setup";
        NoSeriesMgt: Codeunit "No. Series";

    begin
        if WarehouseShipmentHeader."LFS EXIM Type" = WarehouseShipmentHeader."LFS EXIM Type"::" " then
            exit;
        EximSetup.Get();
        WarehouseShipmentHeader."No." := '';
        NoSeriesMgt.LookupRelatedNoSeries(WarehouseShipmentHeader."Shipping No. Series", EximSetup."LFS Post Whse Shipment Nos.");
        WarehouseShipmentHeader.Validate("No.", NoSeriesMgt.GetNextNo(EximSetup."LFS Warehouse Shipment Nos.", WorkDate(), true));
        // NoSeriesMgt.InitSeries(EximSetup."LFS Warehouse Shipment No.", xWarehouseShipmentHeader."No. Series", WorkDate(), WarehouseShipmentHeader."No.", WarehouseShipmentHeader."No. Series");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPurchCrMemoLineInsert', '', false, false)]
    local procedure LFS_EX_InsertCrMemoLicenseDetails(CommitIsSupressed: Boolean; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var PurchCrMemoLine: Record "Purch. Cr. Memo Line"; var PurchLine: Record "Purchase Line")
    var
        eximLicense: Record "LFS EXIM Import License";
        EXIMpostedLicense: Record "LFS EXIM Posted Import Licence";
    begin
        //if PurchCrMemoLine.Type <> PurchCrMemoLine.Type::" " then begin
        eximLicense.SetRange("LFS Source No.", PurchLine."Document No.");
        eximLicense.SetRange("LFS Source line No.", PurchLine."Line No.");
        if eximLicense.Findset() then
            repeat
                EXIMpostedLicense.Init();
                EXIMpostedLicense."LFS Source Type" := EXIMpostedLicense."LFS Source Type"::"Credit Memo";
                EXIMpostedLicense."LFS Source No." := PurchCrMemoLine."Document No.";
                EXIMpostedLicense."LFS Source line No." := PurchCrMemoLine."Line No.";
                EXIMpostedLicense."LFS Line No." := GetNextImpLicLineNo(EXIMpostedLicense);
                EXIMpostedLicense."LFS Item No." := eximLicense."LFS Item No.";
                EXIMpostedLicense."LFS Quantity" := eximLicense."LFS Quantity";
                EXIMpostedLicense."LFS License Type" := eximLicense."LFS License Type";
                EXIMpostedLicense."LFS License No." := eximLicense."LFS License No.";
                EXIMpostedLicense."LFS Unit Cost" := eximLicense."LFS Unit Cost";
                EXIMpostedLicense."LFS Import Inv Bal Qty" := eximLicense."LFS Import Inv Bal Qty";
                EXIMpostedLicense."LFS CIF(FCY)" := eximLicense."LFS CIF(FCY)";
                EXIMpostedLicense."LFS Variant Code" := eximLicense."LFS Variant Code";
                EXIMpostedLicense."LFS RoDTEP Balance" := eximLicense."LFS RoDTEP Balance";
                EXIMpostedLicense."LFS RoDTEP Consump Value" := eximLicense."LFS RoDTEP Consump Value";
                EXIMpostedLicense.Insert();
            until eximLicense.Next() = 0;
        //end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesCrMemoLineInsert', '', false, false)]
    local procedure LFS_EX_InsertExpCrmemoLicense(CommitIsSuppressed: Boolean; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesLine: Record "Sales Line"; var SalesCrMemoLine: Record "Sales Cr.Memo Line"; var SalesHeader: Record "Sales Header"; var TempItemChargeAssgntSales: Record "Item Charge Assignment (Sales)"; var TempWhseRcptHeader: Record "Warehouse Receipt Header"; var TempWhseShptHeader: Record "Warehouse Shipment Header"; WhseReceive: Boolean; WhseShip: Boolean)
    var

        eximLicense: Record "LFS EXIM Export License";
        EXIMpostedLicense: Record "LFS EXIM Posted Export Licence";
    begin
        eximLicense.SetRange("LFS Source No.", SalesLine."Document No.");
        eximLicense.SetRange("LFS Source line No.", SalesLine."Line No.");
        if eximLicense.Findset() then
            repeat
                EXIMpostedLicense."LFS Source Type" := EXIMpostedLicense."LFS Source Type"::"Credit Memo";
                EXIMpostedLicense."LFS Source No." := SalesCrMemoLine."Document No.";
                EXIMpostedLicense."LFS Source line No." := SalesCrMemoLine."Line No.";
                EXIMpostedLicense."LFS Line No." := eximLicense."LFS Line No.";
                EXIMpostedLicense."LFS Item No." := eximLicense."LFS Item No.";
                EXIMpostedLicense."LFS Quantity" := eximLicense."LFS Quantity";
                EXIMpostedLicense."LFS License Type" := eximLicense."LFS License Type";
                EXIMpostedLicense."LFS License No." := eximLicense."LFS License No.";
                EXIMpostedLicense."LFS Unit Price" := eximLicense."LFS Unit Price";
                EXIMpostedLicense."LFS Export Inv Bal Qty" := eximLicense."LFS Export Inv Bal Qty";
                EXIMpostedLicense."LFS FOB (FCY)" := eximLicense."LFS FOB (FCY)";
                EXIMpostedLicense."LFS Variant Code" := eximLicense."LFS Variant Code";
                EXIMpostedLicense."LFS RoDTEP Balance" := eximLicense."LFS RoDTEP Balance";
                EXIMpostedLicense."LFS RoDTEP Consump Value" := eximLicense."LFS RoDTEP Consump Value";
                EXIMpostedLicense.Insert();
            until eximLicense.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvLineInsert', '', false, false)]
    local procedure LFS_EX_InsertExpInvLicense(CommitIsSuppressed: Boolean; ItemLedgShptEntryNo: Integer; PreviewMode: Boolean; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header"; var SalesInvLine: Record "Sales Invoice Line"; var TempItemChargeAssgntSales: Record "Item Charge Assignment (Sales)"; var TempWhseRcptHeader: Record "Warehouse Receipt Header"; var TempWhseShptHeader: Record "Warehouse Shipment Header"; WhseReceive: Boolean; WhseShip: Boolean)
    var
        eximLicense: Record "LFS EXIM Export License";
        EXIMpostedLicense: Record "LFS EXIM Posted Export Licence";
        EXIMMngt: Codeunit "LFS EXIM General Functions";

    begin
        if SalesHeader."LFS EXIM Type" = SalesHeader."LFS EXIM Type"::Export then begin
            SalesInvLine."LFS EXIM Type" := SalesInvLine."LFS EXIM Type"::Export;
            SalesInvLine."LFS Source No." := SalesInvLine."Document No.";
            SalesInvLine."LFS Source Line No." := SalesInvLine."Line No.";
            SalesInvLine.Modify();
        end;

        if SalesHeader."LFS EXIM Type" = SalesHeader."LFS EXIM Type"::Export then
            SalesInvLine."LFS EXIM Type" := SalesInvLine."LFS EXIM Type"::Export;
        if SalesInvLine.Type = SalesInvLine.Type::Item then begin
            eximLicense.SetRange("LFS Source No.", SalesLine."Document No.");
            eximLicense.SetRange("LFS Source line No.", SalesLine."Line No.");
            if eximLicense.Findset() then begin
                repeat
                    EXIMpostedLicense."LFS Source Type" := EXIMpostedLicense."LFS Source Type"::Invoice;
                    EXIMpostedLicense."LFS Source No." := SalesInvLine."Document No.";
                    EXIMpostedLicense."LFS Source line No." := SalesInvLine."Line No.";
                    EXIMpostedLicense."LFS Line No." := eximLicense."LFS Line No.";
                    EXIMpostedLicense."LFS Item No." := eximLicense."LFS Item No.";
                    EXIMpostedLicense."LFS Quantity" := eximLicense."LFS Quantity";
                    EXIMpostedLicense."LFS License Type" := eximLicense."LFS License Type";
                    EXIMpostedLicense."LFS License No." := eximLicense."LFS License No.";
                    EXIMpostedLicense."LFS Unit Price" := eximLicense."LFS Unit Price";
                    EXIMpostedLicense."LFS Export Inv Bal Qty" := eximLicense."LFS Export Inv Bal Qty";
                    EXIMpostedLicense."LFS FOB (FCY)" := eximLicense."LFS FOB (FCY)";
                    EXIMpostedLicense."LFS Variant Code" := eximLicense."LFS Variant Code";
                    EXIMpostedLicense."LFS RoDTEP Balance" := eximLicense."LFS RoDTEP Balance";
                    EXIMpostedLicense."LFS RoDTEP Consump Value" := eximLicense."LFS RoDTEP Consump Value";
                    EXIMpostedLicense.Insert();
                until eximLicense.Next() = 0;
                eximLicense.DeleteAll();
            end;
        end;


        SalesInvLine.SetRange("Document No.", SalesInvHeader."No.");
        if SalesInvLine.Findset() then
            repeat
                if SalesInvLine.Type = SalesInvLine.Type::Item then
                    EXIMMngt."LFS InsertRodtepLicenseLinesSalesInv"(SalesInvLine, SalesInvHeader);
            until SalesInvLine.Next() = 0;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPurchInvLineInsert', '', false, false)]
    local procedure LFS_EX_InsertInvLicenseDetails(var PurchInvLine: Record "Purch. Inv. Line"; PurchInvHeader: Record "Purch. Inv. Header"; PurchLine: Record "Purchase Line"; ItemLedgShptEntryNo: Integer; WhseShip: Boolean; WhseReceive: Boolean; CommitIsSupressed: Boolean; PurchHeader: Record "Purchase Header"; PurchRcptHeader: Record "Purch. Rcpt. Header"; TempWhseRcptHeader: Record "Warehouse Receipt Header")
    var
        EximLicense: Record "LFS EXIM Import License";
        EXIMpostedLicense: Record "LFS EXIM Posted Import Licence";
    begin
        if PurchHeader."LFS EXIM Type" = PurchHeader."LFS EXIM Type"::Import then begin
            PurchInvLine."LFS EXIM Type" := PurchInvLine."LFS EXIM Type"::Import;
            PurchInvLine."LFS Source No." := PurchInvLine."Document No.";
            PurchInvLine."LFS Source Line No." := PurchInvLine."Line No.";
            PurchInvLine.Modify();
        end;
        eximLicense.SetRange("LFS Source No.", PurchLine."Document No.");
        eximLicense.SetRange("LFS Source line No.", PurchLine."Line No.");
        if eximLicense.Findset() then begin
            repeat
                EXIMpostedLicense."LFS Source Type" := EXIMpostedLicense."LFS Source Type"::Invoice;
                EXIMpostedLicense."LFS Source No." := PurchInvLine."Document No.";
                EXIMpostedLicense."LFS Source line No." := PurchInvLine."Line No.";
                EXIMpostedLicense."LFS Line No." := eximLicense."LFS Line No.";
                EXIMpostedLicense."LFS Item No." := eximLicense."LFS Item No.";
                EXIMpostedLicense."LFS Quantity" := eximLicense."LFS Quantity";
                EXIMpostedLicense."LFS License Type" := eximLicense."LFS License Type";
                EXIMpostedLicense."LFS License No." := eximLicense."LFS License No.";
                EXIMpostedLicense."LFS Unit Cost" := EximLicense."LFS Unit Cost";
                EXIMpostedLicense."LFS Import Inv Bal Qty" := eximLicense."LFS Import Inv Bal Qty";
                EXIMpostedLicense."LFS CIF(FCY)" := eximLicense."LFS CIF(FCY)";
                EXIMpostedLicense."LFS Variant Code" := eximLicense."LFS Variant Code";
                EXIMpostedLicense."LFS RoDTEP Balance" := EximLicense."LFS RoDTEP Balance";
                EXIMpostedLicense."LFS RoDTEP Consump Value" := EximLicense."LFS RoDTEP Consump Value";
                EXIMpostedLicense.Insert();
            until eximLicense.Next() = 0;
            EximLicense.DeleteAll();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", OnAfterCopySalesHeader, '', false, false)]
    local procedure LFS_EX_OnAfterCopySalesHeader(var ToSalesHeader: Record "Sales Header"; OldSalesHeader: Record "Sales Header"; FromSalesHeader: Record "Sales Header"; FromDocType: Enum "Sales Document Type From");
    var
        ExportInfo: Record "LFS Export Information Header";
        ExportInfo2: Record "LFS Export Information Header";
    begin
        if FromSalesHeader."LFS EXIM Type" = FromSalesHeader."LFS EXIM Type"::Export then
            if (FromDocType = FromDocType::Order) And (ToSalesHeader."Document Type" = ToSalesHeader."Document Type"::Invoice) then begin
                ExportInfo.SetRange("LFS Document Type", ExportInfo."LFS Document Type"::Order);
                ExportInfo.SetRange("LFS Document No.", FromSalesHeader."No.");
                if ExportInfo.FindFirst() then begin
                    exportInfo2."LFS Document Type" := ExportInfo2."LFS Document Type"::Invoice;
                    exportInfo2."LFS Document No." := ToSalesHeader."No.";
                    exportInfo2.Insert();
                    exportInfo2.TransferFields(ExportInfo, false);
                    exportInfo2.Modify();
                end;
            end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", 'OnAfterCreatePostedShptHeader', '', false, false)]
    local procedure LFS_EX_OnAfterCreatePostedShptHeaderSub(var PostedWhseShptHeader: Record "Posted Whse. Shipment Header"; var WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    var
        exportInfo: Record "LFS Export Information Header";
        PostedExport: Record "LFS Posted Export Information";
    begin
        PostedWhseShptHeader."LFS Commission Agent" := WarehouseShipmentHeader."LFS Commission Agent";
        PostedWhseShptHeader."LFS Comm. Amount" := WarehouseShipmentHeader."LFS Comm. Amount";
        PostedWhseShptHeader.Modify();

        exportInfo.SetRange("LFS Document Type", exportInfo."LFS Document Type"::Shipment);
        exportInfo.SetRange("LFS Document No.", WarehouseShipmentHeader."No.");
        if exportInfo.FindFirst() then begin
            PostedExport."LFS Document Type" := PostedExport."LFS Document Type"::Shipment;
            PostedExport."LFS Document No." := PostedWhseShptHeader."No.";
            PostedExport.Insert();
            PostedExport.TransferFields(exportInfo, false);
            OnMyCustomEvent(exportInfo, PostedExport);
            PostedExport.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterFinalizePosting, '', false, false)]
    local procedure LFS_EX_OnAfterFinalizePosting(var SalesHeader: Record "Sales Header"; var SalesShipmentHeader: Record "Sales Shipment Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var ReturnReceiptHeader: Record "Return Receipt Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; CommitIsSuppressed: Boolean; PreviewMode: Boolean);
    var
        EximSetup: Record "LFS EXIM Setup";
        PHdr: Record "Purchase Header";
        PL_rec: Record "Purchase Line";
        NoSeriesMgmt: Codeunit "No. Series";
        EximExportinvpage: Page "LFS Export Sales Invoice";
        PurchDocNo: Code[20];


    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then
            if SalesHeader."LFS EXIM Type" = SalesHeader."LFS EXIM Type"::Export then
                EximExportinvpage.InsertDDBRODTepEntry(SalesInvoiceHeader)
            else
                EximExportinvpage.InsertRODTepConsumptionEntryForDomesticSales(SalesInvoiceHeader)
        else
            if SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" then
                if SalesHeader."LFS EXIM Type" = SalesHeader."LFS EXIM Type"::Export then
                    EximExportinvpage.InsertDDBRODTepEntryCreditMemo(SalesCrMemoHeader)
                else
                    EximExportinvpage.InsertRODTepConsumptionEntryForSalesCreditMemo(SalesCrMemoHeader);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnAfterFinalizePosting, '', false, false)]
    local procedure LFS_EX_OnAfterFinalizePostingPurch(var PurchHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var ReturnShptHeader: Record "Return Shipment Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean; CommitIsSupressed: Boolean);
    var
        ImportPurchaseInvoice: Page "LFS Import Purchase Invoice";
    begin
        if PurchHeader."LFS EXIM Type" = PurchHeader."LFS EXIM Type"::Import then
            ImportPurchaseInvoice.InsertDDBRODTepEntryForImport(PurchInvHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", OnAfterPostedWhseRcptHeaderInsert, '', false, false)]
    local procedure LFS_EX_OnAfterPostedWhseRcptHeaderInsert(var PostedWhseReceiptHeader: Record "Posted Whse. Receipt Header"; WarehouseReceiptHeader: Record "Warehouse Receipt Header");
    begin
        PostedWhseReceiptHeader."LFS Commission Agent" := WarehouseReceiptHeader."LFS Commission Agent";
        PostedWhseReceiptHeader."LFS Comm. Amount" := WarehouseReceiptHeader."LFS Comm. Amount";
        PostedWhseReceiptHeader.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterProcessPurchLines', '', true, true)]
    local procedure LFS_EX_OnAfterPostPurchLinesSub(var PurchHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var ReturnShipmentHeader: Record "Return Shipment Header"; WhseShip: Boolean; WhseReceive: Boolean; var PurchLinesProcessed: Boolean; CommitIsSuppressed: Boolean; EverythingInvoiced: Boolean)
    var

        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        PurchInvLine: Record "Purch. Inv. Line";
        EximMgmt: Codeunit "LFS EXIM General Functions";
    begin
        PurchInvLine.SetRange("Document No.", PurchInvHeader."No.");
        if PurchInvLine.Findset() then
            repeat
                if PurchInvLine.Type = PurchInvLine.Type::Item then
                    EximMgmt."LFS InsertLicenseDtlFromImportPostedPurchInvDoc"(PurchInvLine, PurchInvHeader);
            until PurchInvLine.Next() = 0;
        PurchCrMemoLine.SetRange("Document No.", PurchCrMemoHdr."No.");
        if PurchCrMemoLine.Findset() then
            repeat
                if PurchCrMemoLine.Type = PurchCrMemoLine.type::Item then
                    EximMgmt."LFS InsertLicenseDtlFromImportPostedPurchCrNoteDoc"(PurchCrMemoLine);
            until PurchCrMemoLine.Next() = 0;

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesLines', '', false, false)]
    local procedure LFS_EX_OnAfterPostSalesLinesSub(var SalesHeader: Record "Sales Header"; var SalesShipmentHeader: Record "Sales Shipment Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var ReturnReceiptHeader: Record "Return Receipt Header"; WhseShip: Boolean; WhseReceive: Boolean; var SalesLinesProcessed: Boolean; CommitIsSuppressed: Boolean; EverythingInvoiced: Boolean; var TempSalesLineGlobal: Record "Sales Line" temporary)
    var
        EXIMDDBRateSetup: Record "LFS EXIM DDB Rate Setup";
        AdvLicense: Record "LFS EXIM Posted Export Licence";
        RodtepRatesetup: Record "LFS EXIM RoDTEP Rate Setup";
        eximsetup: Record "LFS EXIM Setup";
        exportInfo: Record "LFS Export Information Header";
        PostedExport: Record "LFS Posted Export Information";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        SalesInvLine: Record "Sales Invoice Line";
        EXIMMngt: Codeunit "LFS EXIM General Functions";
    begin
        SalesInvLine.SetRange("Document No.", SalesInvoiceHeader."No.");
        if SalesInvLine.Findset() then
            repeat
                if SalesInvLine.Type = SalesInvLine.Type::"G/L Account" then
                    EXIMMngt."LFS InsertLicenseDtlFromDomesticPostedSalesInvDocToRodtepLicense"(SalesInvLine);
                if SalesInvLine.Type = SalesInvLine.Type::Item then begin
                    EXIMMngt."LFS InsertLicenseDtlFromExportPostedSalesInvDoc"(SalesInvLine, SalesInvoiceHeader);
                    AdvLicense.Reset();
                    AdvLicense.SetRange("LFS Source No.", SalesInvLine."Document No.");
                    AdvLicense.SetRange("LFS Source line No.", SalesInvLine."Line No.");
                    if not AdvLicense.FindFirst() then begin
                        RodtepRatesetup.Reset();
                        RodtepRatesetup.SetRange("LFS Item Code", SalesInvLine."No.");
                        RodtepRatesetup.Setfilter("LFS Starting Date", '<=%1', SalesInvoiceHeader."Posting Date");
                        if RodtepRatesetup.FindLast() then
                            EXIMMngt."LFS InsertRoDTEPEntryFromExportPostedSalesDoc"(SalesInvLine, SalesInvoiceHeader, RodtepRatesetup)
                        else
                            if SalesInvLine."HSN/SAC Code" <> '' then begin
                                RodtepRatesetup.Reset();
                                RodtepRatesetup.SetRange("LFS HSN No.", SalesInvLine."HSN/SAC Code");
                                RodtepRatesetup.Setfilter("LFS Starting Date", '<=%1', SalesInvoiceHeader."Posting Date");
                                if RodtepRatesetup.FindLast() then
                                    EXIMMngt."LFS InsertRoDTEPEntryFromExportPostedSalesDoc"(SalesInvLine, SalesInvoiceHeader, RodtepRatesetup)
                            end
                            else begin
                                EXIMSetup.Get();
                                if eximsetup."LFS RoDTEP %" <> 0 then
                                    EXIMMngt."LFS InsertRoDTEPEntryFromExportPostedSalesDoc"(SalesInvLine, SalesInvoiceHeader, RodtepRatesetup);
                            end;
                    end;

                    EXIMDDBRateSetup.SETfilter("LFS Starting Date", '<=%1', SalesInvoiceHeader."Posting Date");
                    EXIMDDBRateSetup.SETRANGE("LFS Item Code", SalesInvLine."No.");
                    // EXIMDDBRateSetup.SETRANGE("LFS Unit of Measure Code", SalesInvLine."Unit of Measure Code");
                    if EXIMDDBRateSetup.FindLast() then begin
                        if (SalesInvLine."LFS Incentive Type" = SalesInvLine."LFS Incentive Type"::DDB) and (SalesInvLine."LFS Claim DDB") then
                            EXIMMngt."LFS InsertDDBEntryFromExportPostedSalesDoc"(SalesInvLine, EXIMDDBRateSetup)
                    end else
                        if SalesInvLine."HSN/SAC Code" <> '' then begin
                            EXIMDDBRateSetup.Reset();
                            EXIMDDBRateSetup.SETfilter("LFS Starting Date", '<=%1', SalesInvoiceHeader."Posting Date");
                            EXIMDDBRateSetup.SETRANGE("LFS HSN No.", SalesInvLine."HSN/SAC Code");
                            if EXIMDDBRateSetup.FindLast() then
                                // if (SalesInvLine."LFS Incentive Type" = SalesInvLine."LFS Incentive Type"::DDB) and (SalesInvLine."LFS Claim DDB") then
                                    EXIMMngt."LFS InsertDDBEntryFromExportPostedSalesDoc"(SalesInvLine, EXIMDDBRateSetup);
                        end
                        else begin
                            EXIMSetup.Get();
                            if eximsetup."LFS DDB %" <> 0 then
                                EXIMMngt."LFS InsertRoDTEPEntryFromExportPostedSalesDoc"(SalesInvLine, SalesInvoiceHeader, RodtepRatesetup);
                        end;
                end;
            until SalesInvLine.Next() = 0;

        SalesCrMemoLine.SetRange("Document No.", SalesCrMemoHeader."No.");
        if SalesCrMemoLine.Findset() then
            repeat
                if SalesCrMemoLine.Type = SalesCrMemoLine.Type::"G/L Account" then
                    EXIMMngt."LFS InsertLicenseDtlFromDomesticPostedSalesCreditDocToRodtepLicense"(SalesCrMemoLine);
                if SalesCrMemoLine.Type = SalesCrMemoLine.Type::Item then begin
                    EXIMMngt."LFS InsertLicenseDtlFromExportPostedSalesCrNoteDoc"(SalesCrMemoLine);
                    AdvLicense.Reset();
                    AdvLicense.SetRange("LFS Source No.", SalesCrMemoLine."Document No.");
                    AdvLicense.SetRange("LFS Source line No.", SalesCrMemoLine."Line No.");
                    if AdvLicense.Isempty() then begin
                        RodtepRatesetup.Reset();
                        RodtepRatesetup.SetRange("LFS Item Code", SalesCrMemoLine."No.");
                        RodtepRatesetup.Setfilter("LFS Starting Date", '<=%1', SalesCrMemoLine."Posting Date");
                        if RodtepRatesetup.FindLast() then
                            EXIMMngt."LFS InsertRoDTEPEntryFromExportPostedSalesCrNoteDoc"(SalesCrMemoLine, SalesCrMemoHeader, RodtepRatesetup)
                        else
                            if SalesCrMemoLine."HSN/SAC Code" <> '' then begin
                                RodtepRatesetup.Reset();
                                RodtepRatesetup.SetRange("LFS HSN No.", SalesCrMemoLine."HSN/SAC Code");
                                RodtepRatesetup.Setfilter("LFS Starting Date", '<=%1', SalesCrMemoLine."Posting Date");
                                if RodtepRatesetup.FindLast() then
                                    EXIMMngt."LFS InsertRoDTEPEntryFromExportPostedSalesCrNoteDoc"(SalesCrMemoLine, SalesCrMemoHeader, RodtepRatesetup)
                            end
                            else begin
                                EXIMSetup.Get();
                                if eximsetup."LFS RoDTEP %" <> 0 then
                                    EXIMMngt."LFS InsertRoDTEPEntryFromExportPostedSalesCrNoteDoc"(SalesCrMemoLine, SalesCrMemoHeader, RodtepRatesetup)
                            end;
                    end;
                    EXIMDDBRateSetup.SETfilter("LFS Starting Date", '<=%1', SalesCrMemoHeader."Posting Date");
                    EXIMDDBRateSetup.SETRANGE("LFS Item Code", SalesCrMemoLine."No.");
                    // EXIMDDBRateSetup.SETRANGE("LFS Unit of Measure Code", SalesCrMemoLine."Unit of Measure Code");
                    if EXIMDDBRateSetup.FindLast() then
                        if (SalesCrMemoLine."LFS Incentive Type" = SalesCrMemoLine."LFS Incentive Type"::DDB) and (SalesCrMemoLine."LFS Claim DDB") then
                            EXIMMngt."LFS InsertDDBEntryFromExportPostedSalesCrNoteDoc"(SalesCrMemoLine, EXIMDDBRateSetup)
                        else
                            if SalesCrMemoLine."HSN/SAC Code" <> '' then begin
                                EXIMDDBRateSetup.Reset();
                                EXIMDDBRateSetup.SETfilter("LFS Starting Date", '<=%1', SalesCrMemoHeader."Posting Date");
                                EXIMDDBRateSetup.SETRANGE("LFS HSN No.", SalesCrMemoLine."HSN/SAC Code");
                                // EXIMDDBRateSetup.SETRANGE("LFS Unit of Measure Code", SalesCrMemoLine."Unit of Measure Code");
                                if EXIMDDBRateSetup.FindLast() then
                                    // if (SalesCrMemoLine."LFS Incentive Type" = SalesCrMemoLine."LFS Incentive Type"::DDB) and (SalesCrMemoLine."LFS Claim DDB") then
                                        EXIMMngt."LFS InsertDDBEntryFromExportPostedSalesCrNoteDoc"(SalesCrMemoLine, EXIMDDBRateSetup);
                            end
                            else begin
                                EXIMSetup.Get();
                                if eximsetup."LFS DDB %" <> 0 then
                                    EXIMMngt."LFS InsertDDBEntryFromExportPostedSalesCrNoteDoc"(SalesCrMemoLine, EXIMDDBRateSetup);
                            end;
                end;
            until SalesCrMemoLine.Next() = 0;
        if SalesInvoiceHeader."No." <> '' then begin
            exportInfo.Reset();
            exportInfo.SetRange("LFS Document Type", SalesHeader."Document Type");
            exportInfo.SetRange("LFS Document No.", SalesHeader."No.");
            if exportInfo.FindFirst() then begin
                PostedExport."LFS Document Type" := PostedExport."LFS Document Type"::Invoice;
                PostedExport."LFS Document No." := SalesInvoiceHeader."No.";
                PostedExport.Insert();
                PostedExport.TransferFields(exportInfo, false);
                OnMyCustomEvent(exportInfo, PostedExport);
                PostedExport.Modify();
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvHeaderInsert', '', false, false)]
    local procedure LFS_EX_OnAfterSalesInvHeaderInsertSub(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; WhseShip: Boolean; WhseReceive: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header"; var TempWhseRcptHeader: Record "Warehouse Receipt Header"; PreviewMode: Boolean)
    begin
        if not WhseShip then begin
            SalesInvHeader."LFS Commission Agent" := SalesHeader."LFS Commission Agent";
            SalesInvHeader."LFS Comm. Amount" := SalesHeader."LFS Comm. Amount";
            SalesInvHeader."LFS Additional Information" := SalesHeader."LFS Additional Information";
            SalesInvHeader.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesShptHeaderInsert', '', false, false)]
    local procedure LFS_EX_OnAfterSalesShptHeaderInsertSub(var SalesShipmentHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header"; SuppressCommit: Boolean; WhseShip: Boolean; WhseReceive: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header"; var TempWhseRcptHeader: Record "Warehouse Receipt Header"; PreviewMode: Boolean)
    var
        exportInfo: Record "LFS Export Information Header";
        PostedExport: Record "LFS Posted Export Information";
    begin
        if WhseShip then begin
            SalesShipmentHeader."LFS Commission Agent" := TempWhseShptHeader."LFS Commission Agent";
            SalesShipmentHeader."LFS Comm. Amount" := TempWhseShptHeader."LFS Comm. Amount";
            SalesShipmentHeader.Modify();
        end
        else begin
            SalesShipmentHeader."LFS Commission Agent" := SalesHeader."LFS Commission Agent";
            SalesShipmentHeader."LFS Comm. Amount" := SalesHeader."LFS Comm. Amount";
            SalesShipmentHeader."LFS Additional Information" := SalesHeader."LFS Additional Information";
            SalesShipmentHeader.Modify();
        end;

        exportInfo.SetRange("LFS Document Type", exportInfo."LFS Document Type"::Shipment);
        exportInfo.SetRange("LFS Document No.", TempWhseShptHeader."No.");
        if exportInfo.FindFirst() then begin
            PostedExport."LFS Document Type" := PostedExport."LFS Document Type"::Shipment;
            PostedExport."LFS Document No." := SalesShipmentHeader."No.";
            PostedExport.Insert();
            PostedExport.TransferFields(exportInfo, false);
            OnMyCustomEvent(exportInfo, PostedExport);
            PostedExport.Modify();
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesShptLineInsert', '', false, false)]
    local procedure LFS_EX_OnAfterSalesShptLineInsertSub(var SalesShipmentLine: Record "Sales Shipment Line"; SalesLine: Record "Sales Line"; ItemShptLedEntryNo: Integer; WhseShip: Boolean; WhseReceive: Boolean; CommitIsSuppressed: Boolean; SalesInvoiceHeader: Record "Sales Invoice Header"; var TempWhseShptHeader: Record "Warehouse Shipment Header" temporary; var TempWhseRcptHeader: Record "Warehouse Receipt Header" temporary; SalesShptHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header")
    var
        PackingList: Record "LFS EXIM Packing List Tab.";
        postedpackinglist: record "LFS EXIM Posted Packing Table";
        WsheShipLine: Record "Posted Whse. Shipment Line";
        LineNo: integer;
    begin
        LineNo := 10000;
        PackingList.SetRange("LFS Source Order No.", SalesLine."Document No.");
        PackingList.SetRange("LFS Source Order Line No.", SalesLine."Line No.");
        if PackingList.Findset() then begin
            repeat
                postedpackinglist.TransferFields(PackingList);
                postedpackinglist."LFS Posted Export Shipment" := SalesShipmentLine."Document No.";
                postedpackinglist."LFS PostExShipmentLineNo." := SalesShipmentLine."Line No.";
                postedpackinglist."LFS Line No." := LineNo;
                postedpackinglist.Insert();
                if WhseShip then begin
                    WsheShipLine.Reset();
                    WsheShipLine.SetRange("Source Type", 37);
                    WsheShipLine.SetRange("Source No.", SalesLine."Document No.");
                    WsheShipLine.SetRange("Source Line No.", SalesLine."Line No.");
                    WsheShipLine.SetRange("Posted Source No.", postedpackinglist."LFS Posted Export Shipment");
                    if WsheShipLine.FindFirst() then begin
                        postedpackinglist."LFS PostedWhseShipment" := WsheShipLine."No.";
                        postedpackinglist."LFS PostWhseShipmentLineNo" := WsheShipLine."Line No.";
                        postedpackinglist.Modify();
                    end;
                end;
                LineNo := LineNo + 10000;
            until PackingList.Next() = 0;
            PackingList.DeleteAll();
        end;

    end;

    [EventSubscriber(ObjectType::Report, Report::"Get Source Documents", 'OnBeforeCreateShptHeader', '', false, false)]
    local procedure LFS_EX_OnBeforeCreateShptHeaderSub(var WarehouseShipmentHeader: Record "Warehouse Shipment Header"; var WarehouseRequest: Record "Warehouse Request"; SalesLine: Record "Sales Line"; var IsHandled: Boolean; Location: Record Location; var WhseShptLine: Record "Warehouse Shipment Line"; var ActivitiesCreated: Integer; var WhseHeaderCreated: Boolean; var RequestType: Option Receive,Ship)
    var
        EXIMSetup: Record "LFS EXIM Setup";
        Location2: Record Location;
        NoSeriesMgt: codeunit "No. Series";
    begin
        if SalesLine."LFS EXIM Type" = SalesLine."LFS EXIM Type"::Export then begin
            WarehouseShipmentHeader.Init();
            WarehouseShipmentHeader."No." := '';
            WarehouseShipmentHeader."Location Code" := WarehouseRequest."Location Code";
            Location2.setrange(code, WarehouseShipmentHeader."Location Code");
            if Location2.FindFirst() then
                WarehouseShipmentHeader."Bin Code" := Location2."Shipment Bin Code";
            WarehouseShipmentHeader."External Document No." := WarehouseRequest."External Document No.";
            WarehouseShipmentHeader."Shipment Method Code" := WarehouseRequest."Shipment Method Code";
            WarehouseShipmentHeader."Shipping Agent Code" := WarehouseRequest."Shipping Agent Code";
            WarehouseShipmentHeader."Shipping Agent Service Code" := WarehouseRequest."Shipping Agent Service Code";
            WhseShptLine.LockTable();

            EXIMSetup.Get();
            if WarehouseShipmentHeader."No." = '' then begin
                EXIMSetup.TestField("LFS Warehouse Shipment Nos.");
                WarehouseShipmentHeader.Validate("No.", NoSeriesMgt.GetNextNo(EXIMSetup."LFS Warehouse Shipment Nos.", WorkDate()));
                // NoSeriesMgt.InitSeries(EXIMSetup."LFS Warehouse Shipment No.", WarehouseShipmentHeader."No. Series", WarehouseShipmentHeader."Posting Date", WarehouseShipmentHeader."No.", WarehouseShipmentHeader."No. Series");
            end;

            NoSeriesMgt.LookupRelatedNoSeries(WarehouseShipmentHeader."Shipping No. Series", EXIMSetup."LFS Post Whse Shipment Nos.");
            WarehouseShipmentHeader."Posting Date" := WorkDate();
            WarehouseShipmentHeader."Shipment Date" := WorkDate();
            ActivitiesCreated := ActivitiesCreated + 1;
            WhseHeaderCreated := true;
            WarehouseShipmentHeader.Insert();
            IsHandled := true
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", 'OnBeforePostedWhseShptHeaderInsert', '', false, false)]
    local procedure LFS_EX_OnBeforePostedWhseShptHeaderInsertSub(var PostedWhseShipmentHeader: Record "Posted Whse. Shipment Header"; WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    begin
        PostedWhseShipmentHeader."LFS EXIM Type" := WarehouseShipmentHeader."LFS EXIM Type";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Get Return Receipts", OnBeforeTransferLineToSalesDoc, '', false, false)]
    local procedure LFS_EX_OnBeforeTransferLineToSalesDoc(ReturnReceiptHeader: Record "Return Receipt Header"; ReturnReceiptLine: Record "Return Receipt Line"; var SalesHeader: Record "Sales Header"; var TransferLine: Boolean);
    begin
        SalesHeader."LFS Commission Agent" := ReturnReceiptHeader."LFS Commission Agent";
        SalesHeader."LFS Comm. Amount" := ReturnReceiptHeader."LFS Comm. Amount";
        SalesHeader.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Get Shipment", 'OnBeforeTransferLineToSalesDoc', '', false, false)]
    local procedure LFS_EX_OnBeforeTransferLineToSalesDocSub(SalesShipmentHeader: Record "Sales Shipment Header"; SalesShipmentLine: Record "Sales Shipment Line"; var SalesHeader: Record "Sales Header"; var TransferLine: Boolean)
    var
        exportInfo: Record "LFS Export Information Header";
        exportInformation: Record "LFS Export Information Header";
        PostedExport: Record "LFS Posted Export Information";
    begin
        SalesHeader."LFS Commission Agent" := SalesShipmentHeader."LFS Commission Agent";
        SalesHeader."LFS Comm. Amount" := SalesShipmentHeader."LFS Comm. Amount";
        SalesHeader.Modify();

        exportInfo.SetRange("LFS Document Type", SalesHeader."Document Type");
        exportInfo.SetRange("LFS Document No.", SalesHeader."No.");
        if not exportInfo.IsEmpty() then
            exit;

        if SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then begin
            PostedExport.SetRange("LFS Document Type", PostedExport."LFS Document Type"::Shipment);
            PostedExport.SetRange("LFS Document No.", SalesShipmentHeader."No.");
            if PostedExport.FindFirst() then begin
                exportInformation."LFS Document Type" := SalesHeader."Document Type";
                exportInformation."LFS Document No." := SalesHeader."No.";
                exportInformation.Insert();
                exportInformation.TransferFields(PostedExport, false);

                exportInformation.Modify();
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", OnCopySalesDocSalesLineOnAfterSetFilters, '', false, false)]
    local procedure LFS_EX_OnCopySalesDocSalesLineOnAfterSetFilters(FromSalesHeader: Record "Sales Header"; var FromSalesLine: Record "Sales Line"; var ToSalesHeader: Record "Sales Header"; var RecalculateLines: Boolean);
    begin
        if FromSalesHeader."LFS EXIM Type" = FromSalesHeader."LFS EXIM Type"::Export then
            if ToSalesHeader."Document Type" = ToSalesHeader."Document Type"::Invoice then
                FromSalesLine.SetFilter(Type, '<>%1', FromSalesLine.Type::Item);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", OnCopySalesInvLinesToDocOnAfterCopySalesDocLine, '', false, false)]
    local procedure LFS_EX_OnCopySalesInvLinesToDocOnAfterCopySalesDocLine(ToSalesLine: Record "Sales Line"; FromSalesInvLine: Record "Sales Invoice Line");
    var
        SalesHeader: Record "Sales Header";
        salesinvHeader: Record "Sales Invoice Header";
    begin
        salesinvHeader.SetRange("No.", FromSalesInvLine."Document No.");
        if salesinvHeader.FindFirst() then begin
            SalesHeader.SetRange("No.", ToSalesLine."Document No.");
            if SalesHeader.FindFirst() then begin
                SalesHeader."LFS Commission Agent" := salesinvHeader."LFS Commission Agent";
                SalesHeader."LFS Comm. Amount" := salesinvHeader."LFS Comm. Amount";
                SalesHeader.Modify();
            end;
        end;

    end;


    [EventSubscriber(ObjectType::Report, Report::"Get Source Documents", OnSalesLineOnAfterCreateRcptHeader, '', false, false)]
    local procedure LFS_EX_OnSalesLineOnAfterCreateRcptHeader(var WhseReceiptHeader: Record "Warehouse Receipt Header"; WhseHeaderCreated: Boolean; SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; WarehouseRequest: Record "Warehouse Request");
    begin
        if SalesHeader."LFS Commission Agent" <> '' then begin
            WhseReceiptHeader."LFS Commission Agent" := SalesHeader."LFS Commission Agent";
            WhseReceiptHeader."LFS Comm. Amount" := SalesHeader."LFS Comm. Amount";
            WhseReceiptHeader.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Report, report::"Get Source Documents", 'OnSalesLineOnAfterCreateShptHeader', '', false, false)]
    local procedure LFS_EX_OnSalesLineOnAfterCreateShptHeaderSub(var WhseShptHeader: Record "Warehouse Shipment Header"; WhseHeaderCreated: Boolean; SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; WarehouseRequest: Record "Warehouse Request")
    var
        ExportInfo: Record "LFS Export Information Header";
        exportInfo2: record "LFS Export Information Header";
    begin
        if SalesHeader."LFS Commission Agent" <> '' then begin
            WhseShptHeader."LFS Commission Agent" := SalesHeader."LFS Commission Agent";
            WhseShptHeader."LFS Comm. Amount" := SalesHeader."LFS Comm. Amount";
            WhseShptHeader.Modify();

        end;
        if SalesHeader."LFS EXIM Type" = SalesHeader."LFS EXIM Type"::Export then begin
            WhseShptHeader."LFS EXIM Type" := SalesHeader."LFS EXIM Type";
            WhseShptHeader."LFS Port of Discharge" := SalesHeader."LFS Port of Discharge";
            WhseShptHeader."LFS Port of Loading" := SalesHeader."LFS Port of Loading";
            WhseShptHeader."LFS Country of Final Dest." := SalesHeader."LFS Country of Final Dest.";
            WhseShptHeader."LFS Final Destination" := SalesHeader."LFS Final Destination";
            WhseShptHeader."LFS Country Origin Goods" := SalesHeader."LFS Country Origin Goods";
            WhseShptHeader."LFS Inco Terms" := SalesHeader."LFS Inco Terms";
            WhseShptHeader."LFS Export Remark" := SalesHeader."LFS Export Remark";
            WhseShptHeader."LFS Custom Currency Code" := SalesHeader."LFS Custom Currency Code";
            WhseShptHeader."LFS Custom Currency Factor" := SalesHeader."LFS Custom Currency Factor";
            WhseShptHeader."LFS Shpping Line" := SalesHeader."LFS Shipping Line";
            WhseShptHeader."LFS Pre Carriage" := SalesHeader."LFS Pre Carriage";
            WhseShptHeader."LFS Bill of Lading Date" := SalesHeader."LFS Bill of Lading Date";
            WhseShptHeader."LFS Bill of Lading No." := SalesHeader."LFS Bill of Lading No.";
            WhseShptHeader."LFS ETD" := SalesHeader."LFS ETD";
            WhseShptHeader."LFS ETA" := SalesHeader."LFS ETA";
            WhseShptHeader."LFS Customs Bank Account" := SalesHeader."LFS Customs Bank Account";
            WhseShptHeader."LFS Commercial Bank Account" := SalesHeader."LFS Commercial Bank Account";
            WhseShptHeader."LFS Carrier" := SalesHeader."LFS Carrier";
            WhseShptHeader.Modify();
            if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
                ExportInfo.SetRange("LFS Document Type", ExportInfo."LFS Document Type"::Order);
                ExportInfo.SetRange("LFS Document No.", SalesHeader."No.");
                if ExportInfo.FindFirst() then begin
                    exportInfo2."LFS Document Type" := ExportInfo2."LFS Document Type"::shipment;
                    exportInfo2."LFS Document No." := WhseShptHeader."No.";
                    exportInfo2.Insert();
                    exportInfo2.TransferFields(ExportInfo, false);
                    exportInfo2.Modify();
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Report, Report::"Get Source Documents", OnSalesLineOnAfterGetRecordOnBeforeCreateRcptHeader, '', false, false)]
    local procedure LFS_EX_OnSalesLineOnAfterGetRecordOnBeforeCreateRcptHeader(SalesLine: Record "Sales Line"; var WarehouseRequest: Record "Warehouse Request"; var WarehouseReceiptHeader: Record "Warehouse Receipt Header"; var WhseHeaderCreated: Boolean; var OneHeaderCreated: Boolean);
    var
        SalesHeader: Record "Sales Header";
    begin
        if OneHeaderCreated = true then begin
            SalesHeader.SetRange("No.", SalesLine."Document No.");
            if SalesHeader.FindFirst() then
                if SalesHeader."LFS Commission Agent" <> '' then begin
                    WarehouseReceiptHeader."LFS Commission Agent" := SalesHeader."LFS Commission Agent";
                    WarehouseReceiptHeader."LFS Comm. Amount" := SalesHeader."LFS Comm. Amount";
                    WarehouseReceiptHeader.Modify();
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Report, Report::"Get Source Documents", OnSalesLineOnAfterGetRecordOnBeforeCreateShptHeader, '', false, false)]
    local procedure LFS_EX_OnSalesLineOnAfterGetRecordOnBeforeCreateShptHeader(var Sender: Report "Get Source Documents"; SalesLine: Record "Sales Line";

    var
        WarehouseRequest: Record "Warehouse Request";

    var
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";

    var
        WhseHeaderCreated: Boolean;

    var
        OneHeaderCreated: Boolean;

    var
        IsHandled: Boolean;

    var
        ErrorOccured: Boolean;

    var
        LinesCreated: Boolean);
    var
        SalesHeader: Record "Sales Header";
    begin
        if OneHeaderCreated = true then begin
            SalesHeader.SetRange("No.", SalesLine."Document No.");
            if SalesHeader.FindFirst() then
                if SalesHeader."LFS Commission Agent" <> '' then begin
                    WarehouseShipmentHeader."LFS Commission Agent" := SalesHeader."LFS Commission Agent";
                    WarehouseShipmentHeader."LFS Comm. Amount" := SalesHeader."LFS Comm. Amount";
                    WarehouseShipmentHeader.Modify();
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, DATABASE::"Purchase Header", 'OnValidateBuyFromVendorNoOnAfterUpdateBuyFromCont', '', false, false)]
    local procedure LFS_EX_OnValidateBuyFromVendorNoOnAfterUpdateBuyFromCont(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header")
    var
        RecVendor: Record Vendor;
    begin
        if RecVendor.Get(PurchaseHeader."Buy-from Vendor No.") then
            purchaseHeader.Validate("LFS Custom Currency Code", RecVendor."Currency Code");
    end;

    [EventSubscriber(ObjectType::Table, DATABASE::"Sales Header", 'OnAfterValidateEvent', 'LFS Custom Currency Code', true, true)]
    local procedure LFS_EX_OnValidateCustomCurrencyCode(Var Rec: Record "Sales Header")
    var
        RecEXIMCustCurr: Record "LFSEXIM Currency Exchange Rate";
    begin
        RecEXIMCustCurr.Reset();
        RecEXIMCustCurr.SetRange("LFS Currency Code", Rec."LFS Custom Currency Code");
        RecEXIMCustCurr.SetRange("LFS Starting Date", 0D, Rec."Posting Date");
        if RecEXIMCustCurr.FindLast() then begin
            if Rec."LFS EXIM Type" = Rec."LFS EXIM Type"::Export then
                Rec.Validate("LFS Custom Currency Factor", RecEXIMCustCurr."LFS Exch Rate Amount (Exp)" / RecEXIMCustCurr."LFS Rel Exch Rate Amt (Exp)");
            Rec.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Table, DATABASE::"Purchase Header", 'OnAfterValidateEvent', 'LFS Custom Currency Code', true, true)]
    local procedure LFS_EX_OnValidateCustomCurrencyCodePurch(Var Rec: Record "Purchase Header")
    var
        RecEXIMCustCurr: Record "LFSEXIM Currency Exchange Rate";
    begin
        RecEXIMCustCurr.Reset();
        RecEXIMCustCurr.SetRange("LFS Currency Code", Rec."LFS Custom Currency Code");
        RecEXIMCustCurr.SetRange("LFS Starting Date", 0D, Rec."Posting Date");
        if RecEXIMCustCurr.FindLast() then begin
            if Rec."LFS EXIM Type" = Rec."LFS EXIM Type"::Import then
                Rec.Validate(Rec."LFS Custom Currency Factor", RecEXIMCustCurr."LFS Exch Rate Amount (imp)" / RecEXIMCustCurr."LFS Rel Exch Rate Amt (imp)");
            Rec.Modify();
        end;
    end;


    [EventSubscriber(ObjectType::Table, DATABASE::"Purchase Line", 'OnValidateFOBValue', '', false, false)]
    local procedure LFS_EX_OnValidateFOBValue(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line"; CurrentFieldNo: Integer)
    var
        RecEXIMCustCurr: Record "LFSEXIM Currency Exchange Rate";
        PurchHeader: Record "Purchase Header";
    begin
        PurchHeader.Reset();
        PurchHeader.SetRange("No.", PurchaseLine."Document No.");
        if PurchHeader.FindFirst() then begin
            RecEXIMCustCurr.Reset();
            RecEXIMCustCurr.SetRange("LFS Currency Code", PurchHeader."LFS Custom Currency Code");
            RecEXIMCustCurr.SetRange("LFS Starting Date", 0D, PurchHeader."Posting Date");
            if RecEXIMCustCurr.FindLast() then begin
                PurchaseLine."LFS Custom Exch. Rate" := RecEXIMCustCurr."LFS Rel Exch Rate Amt (Imp)";
                PurchaseLine.Modify();
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, DATABASE::"Sales Line", 'OnValidateQuantityOnBeforeResetAmounts', '', false, false)]
    local procedure LFS_EX_OnValidateQuantityOnBeforeResetAmounts(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line")
    var
        RecEXIMCustCurr: Record "LFSEXIM Currency Exchange Rate";
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.Reset();
        SalesHeader.SetRange("No.", SalesLine."Document No.");
        if SalesHeader.FindLast() then begin
            RecEXIMCustCurr.Reset();
            RecEXIMCustCurr.SetRange("LFS Currency Code", SalesHeader."LFS Custom Currency Code");
            RecEXIMCustCurr.SetRange("LFS Starting Date", 0D, SalesHeader."Posting Date");
            if RecEXIMCustCurr.FindLast() then begin
                SalesLine."LFS Custom Exch. Rate" := RecEXIMCustCurr."LFS Exch Rate Amount (Exp)" / SalesHeader."Currency Factor";
                SalesLine."LFS Currency Exch. Rate" := RecEXIMCustCurr."LFS Exch Rate Amount (Exp)" / SalesHeader."Currency Factor";
            end;
        end;
    end;


    [EventSubscriber(ObjectType::Table, DATABASE::"Sales Header", 'OnValidateSellToCustomerNoOnBeforeRecallModifyAddressNotification', '', false, false)]
    local procedure LFS_EX_OnValidateSellToCustomerNoOnBeforeRecallModifyAddressNotification(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header")
    var
        RecCustomer: Record Customer;
    begin
        if RecCustomer.get(SalesHeader."Sell-to Customer No.") then
            SalesHeader.Validate("LFS Custom Currency Code", RecCustomer."Currency Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Get Receipt", OnAfterCreateInvLines, '', false, false)]
    local procedure "LFS_EX_Purch.-Get Receipt_OnAfterCreateInvLines"(var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line")
    var
        PurchRcptLine3: Record "Purch. Rcpt. Line";
        PurchaseHeader1: Record "Purchase Header";
    begin
        if PurchaseHeader."LFS EXIM Type" = PurchaseHeader."LFS EXIM Type"::Import then begin
            PurchRcptLine3.Reset();
            PurchRcptLine3.SetRange("Document No.", PurchaseLine."Receipt No.");
            if PurchRcptLine3.FindFirst() then begin
                PurchaseHeader1.Reset();
                PurchaseHeader1.SetRange("No.", PurchRcptLine3."Order No.");
                if PurchaseHeader1.FindFirst() then begin
                    PurchaseHeader."LFS Port of Loading" := PurchaseHeader1."LFS Port of Loading";
                    PurchaseHeader."LFS Port of Discharge" := PurchaseHeader1."LFS Port of Discharge";
                    PurchaseHeader."LFS Country of Final Dest." := PurchaseHeader1."LFS Country of Final Dest.";
                    PurchaseHeader."LFS Country Origin Goods" := PurchaseHeader1."LFS Country Origin Goods";
                    PurchaseHeader."LFS Inco Terms" := PurchaseHeader1."LFS Inco Terms";
                    PurchaseHeader."Transport Method" := PurchaseHeader1."Transport Method";
                    PurchaseHeader."Payment Terms Code" := PurchaseHeader1."Payment Terms Code";
                    PurchaseHeader.Modify();
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Get Shipment", OnAfterCreateInvLines, '', false, false)]
    local procedure "LFS_EX_Sales-Get Shipment_OnAfterCreateInvLines"(var Sender: Codeunit "Sales-Get Shipment"; var SalesShipmentLine2: Record "Sales Shipment Line"; var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; SalesShipmentHeader: Record "Sales Shipment Header")
    var
        SalesHeader1: Record "Sales Header";
        SalesShipmentline: Record "Sales Shipment Line";
    // ExportInformation: Record "LFS Export Information Header";
    // ExportInformation1: Record "LFS Export Information Header";
    // rodtepsetup: Record "LFS EXIM RoDTEP Rate Setup";
    begin
        if SalesHeader."LFS EXIM Type" = SalesHeader."LFS EXIM Type"::Export then begin
            SalesShipmentline.Reset();
            SalesShipmentline.SetRange("Document No.", SalesLine."Shipment No.");
            if SalesShipmentline.FindFirst() then begin
                SalesHeader1.Reset();
                SalesHeader1.SetRange("No.", SalesShipmentline."Order No.");
                if SalesHeader1.FindFirst() then begin
                    SalesHeader."LFS Port of Loading" := SalesHeader1."LFS Port of Loading";
                    SalesHeader."LFS Port of Discharge" := SalesHeader1."LFS Port of Discharge";
                    SalesHeader."LFS Country of Final Dest." := SalesHeader1."LFS Country of Final Dest.";
                    SalesHeader."LFS Final Destination" := SalesHeader1."LFS Final Destination";
                    SalesHeader."LFS Country Origin Goods" := SalesHeader1."LFS Country Origin Goods";
                    SalesHeader."LFS Pre Carriage" := SalesHeader1."LFS Pre Carriage";
                    SalesHeader."LFSPlaceofReceiptPre-Carriage" := SalesHeader1."LFSPlaceofReceiptPre-Carriage";
                    SalesHeader."LFS Inco Terms" := SalesHeader1."LFS Inco Terms";
                    SalesHeader."LFS FOB CIF Calc. Type" := SalesHeader1."LFS FOB CIF Calc. Type";
                    SalesHeader."LFS Shipping Line" := SalesHeader1."LFS Shipping Line";
                    SalesHeader."LFS Customs Bank Account" := SalesHeader1."LFS Customs Bank Account";
                    SalesHeader."LFS Commercial Bank Account" := SalesHeader1."LFS Commercial Bank Account";
                    SalesHeader."Payment Terms Code" := SalesHeader1."Payment Terms Code";
                    SalesHeader."Payment Method Code" := SalesHeader1."Payment Method Code";
                    SalesHeader."Shipment Method Code" := SalesHeader1."Shipment Method Code";
                    SalesHeader."Posting No." := SalesHeader1."Posting No.";
                    SalesHeader.Modify(true);
                end;
                // rodtepsetup.SetFilter("LFS_EX_Starting Date", '<=%1', SalesHeader."Posting Date");
                // rodtepsetup.setrange("LFS_EX_Item Code", Salesline."No.");
                // rodtepsetup.setfilter(LFS_EX_block, '<>%1', true);
                // rodtepsetup.SetCurrentKey("LFS_EX_Starting Date");
                // if rodtepsetup.FindLast() then begin
                //     SalesLine.Validate("LFS_EX_RoDTEP Rebate Rate %", rodtepsetup."LFS_EX_RoDTEP Rebate Rate %");   
                //     SalesLine.Validate("LFS_EX_RoDTEP Rebate Value", (Salesline."LFS_EX_FOB (LC)" - Salesline."LFS_EX_Freight Value (LCY)" - Salesline."LFS_EX_Insurance Value (LCY)") * rodtepsetup."LFS_EX_RoDTEP Rebate Rate %" / 100);   
                //     SalesLine.Modify();
                // end;
            end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", OnAfterInsertSalesOrderHeader, '', false, false)]
    local procedure "LFS_EX_Sales-Quote to Order_OnAfterInsertSalesOrderHeader"(var SalesOrderHeader: Record "Sales Header"; SalesQuoteHeader: Record "Sales Header")
    begin
        if SalesQuoteHeader."LFS EXIM Type" = SalesQuoteHeader."LFS EXIM Type"::Export then
            SalesOrderHeader."LFS EXIM Type" := SalesOrderHeader."LFS EXIM Type"::Export;
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnBeforeUpdateLocationCode', '', false, false)]
    local procedure LFS_EX_SkipLocationCheck(LocationCode: Code[10]; var IsHandled: Boolean; var PurchaseHeader: Record "Purchase Header")
    begin
        if PurchaseHeader."LFS EXIM Type" = PurchaseHeader."LFS EXIM Type"::" " then
            exit;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeCreatePostedWhseShptHeader', '', false, false)]
    local procedure LFS_EX_UpdateEXIMType(SalesHeader: Record "Sales Header"; var PostedWhseShipmentHeader: Record "Posted Whse. Shipment Header"; WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    begin
        PostedWhseShipmentHeader."LFS EXIM Type" := SalesHeader."LFS EXIM Type";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Get Shipment", OnAfterInsertLine, '', false, false)]
    local procedure "Sales-Get Shipment_OnAfterInsertLine"(var SalesShptLine: Record "Sales Shipment Line"; var SalesLine: Record "Sales Line"; SalesShptLine2: Record "Sales Shipment Line"; TransferLine: Boolean; var SalesHeader: Record "Sales Header")
    var
        rodtepsetup: Record "LFS EXIM RoDTEP Rate Setup";
    begin
        rodtepsetup.SetFilter("LFS Starting Date", '<=%1', SalesHeader."Posting Date");
        rodtepsetup.setrange("LFS Item Code", Salesline."No.");
        rodtepsetup.setfilter("LFS block", '<>%1', true);
        rodtepsetup.SetCurrentKey("LFS Starting Date");
        if rodtepsetup.FindLast() then begin
            SalesLine.Validate("LFS RoDTEP Rebate Rate %", rodtepsetup."LFS RoDTEP Rebate Rate %");
            SalesLine.Validate("LFS RoDTEP Rebate Value", (Salesline."LFS FOB Amount (LCY)" - Salesline."LFS Freight Value (LCY)" - Salesline."LFS Insurance Value (LCY)") * rodtepsetup."LFS RoDTEP Rebate Rate %" / 100);
            SalesLine.Modify();
        end
        else
            if SalesLine."HSN/SAC Code" <> '' then begin
                rodtepsetup.Reset();
                rodtepsetup.SetFilter("LFS Starting Date", '<=%1', SalesHeader."Posting Date");
                rodtepsetup.setrange("LFS HSN No.", Salesline."HSN/SAC Code");
                rodtepsetup.setfilter("LFS block", '<>%1', true);
                rodtepsetup.SetCurrentKey("LFS Starting Date");
                if rodtepsetup.FindLast() then begin
                    SalesLine.Validate("LFS RoDTEP Rebate Rate %", rodtepsetup."LFS RoDTEP Rebate Rate %");
                    SalesLine.Validate("LFS RoDTEP Rebate Value", (Salesline."LFS FOB Amount (LCY)" - Salesline."LFS Freight Value (LCY)" - Salesline."LFS Insurance Value (LCY)") * rodtepsetup."LFS RoDTEP Rebate Rate %" / 100);
                    SalesLine.Modify();
                end;
            end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnInsertInvoiceHeaderOnAfterSalesInvHeaderTransferFields, '', false, false)]
    local procedure "Sales-Post_OnInsertInvoiceHeaderOnAfterSalesInvHeaderTransferFields"(var SalesHeader: Record "Sales Header"; var SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        if SalesHeader."LFS EXIM Type" = SalesHeader."LFS EXIM Type"::Export then begin
            SalesHeader.CalcFields("QR Code");
            if SalesHeader."IRN Hash" <> '' then
                SalesInvoiceHeader."QR Code" := SalesHeader."QR Code";
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnMyCustomEvent(var ExportInformation: Record "LFS Export Information Header"; var PostedExportInformation: Record "LFS Posted Export Information")
    begin

    end;

    // [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnBeforeAssistEdit, '', false, false)]
    // local procedure "Sales Header_OnBeforeAssistEdit"(var SalesHeader: Record "Sales Header"; OldSalesHeader: Record "Sales Header"; var IsHandled: Boolean; var Result: Boolean)
    // var
    //     EximSetup: Record "LFS EXIM Setup";
    //     NoSeriesMgt: Codeunit "No. Series";
    //     NewNo: Code[20];
    //     SalesHeader2: Record "Sales Header";
    // begin
    //     if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then
    //         exit;

    //     if SalesHeader."LFS EXIM Type" <> SalesHeader."LFS EXIM Type"::Export then
    //         exit;

    //     if not EximSetup.Get() then
    //         Error('EXIM Setup not found.');

    //     if EximSetup."LFS Export Order Nos." = '' then
    //         Error('Export Order No. Series is not defined in EXIM Setup.');

    //     SalesHeader.TestNoSeries();

    //     if NoSeriesMgt.LookupRelatedNoSeries(EximSetup."LFS Export Order Nos.", OldSalesHeader."No. Series", SalesHeader."No. Series") then begin
    //         NewNo := NoSeriesMgt.GetNextNo(SalesHeader."No. Series", WorkDate(), true);

    //         if SalesHeader2.Get(SalesHeader."Document Type", NewNo) then
    //             Error('A sales order with number %1 already exists.', NewNo);

    //         SalesHeader."No." := NewNo;
    //         Commit();
    //         // SalesHeader.Modify();
    //         Result := true;
    //         IsHandled := true;
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnBeforeRename, '', false, false)]
    // local procedure "Sales Header_OnBeforeRename"(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; xSalesHeader: Record "Sales Header")
    // begin
    //     if SalesHeader."LFS EXIM Type" = SalesHeader."LFS EXIM Type"::Export then
    //         IsHandled := true;
    // end;

}