namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Sales.Receivables;
using Microsoft.Sales.History;
using Microsoft.Finance.Currency;
using Microsoft.Inventory.Tracking;
using Microsoft.Inventory.Location;
using Microsoft.Warehouse.Document;
using Microsoft.Purchases.History;
using Microsoft.Purchases.Document;
using Microsoft.Inventory.Item;
using Microsoft.Sales.Document;
using Microsoft.Warehouse.Request;
using Microsoft.Foundation.PaymentTerms;

codeunit 72001 "LFS EXIM General Functions"
{
    Permissions = tabledata "Cust. Ledger Entry" = RIM;
    procedure UpdateDueDateBL(SalesInvHead: Record "Sales Invoice Header"; LFSPostedExportInformation: Record "LFS Posted Export Information")
    var
        CustLedgeEntry: Record "Cust. Ledger Entry";
        PaymentTerms: Record "Payment Terms";
    begin
        PaymentTerms.SetRange(Code, SalesInvHead."Payment Terms Code");
        PaymentTerms.SetRange("LFS Calc. Based On BL Date", true);
        if PaymentTerms.FindFirst() then begin
            CustLedgeEntry.SetRange("Document No.", SalesInvHead."No.");
            CustLedgeEntry.SetRange("Document Type", CustLedgeEntry."Document Type"::Invoice);
            if CustLedgeEntry.FindFirst() then begin
                // CustLedgeEntry."Due Date" := CalcDate(PaymentTerms."Due Date Calculation", LFSPostedExportInformation."LFS BL Date/ AWB Date");
                CustLedgeEntry."Due Date" := CalcDate(PaymentTerms."Due Date Calculation", SalesInvHead."Posting Date");
                CustLedgeEntry.Modify();
            end;
        end;
    end;

    var

        EXIMSetup: Record "LFS EXIM Setup";
        // SalesShipmentHeader: Record "Sales Shipment Header";
        GetSourceDocuments: Report "Get Source Documents";
        // Text00001ConfLbl: Label 'Packing Lines already exist. Do you wish to Overwrite them?';
#pragma warning disable AA0470
        TextErrLbl: Label 'if %1 is %2 in %3 no. %4, then all associated lines where type is %5 must use the same location.';
        Text002Lbl: Label 'The warehouse shipment was not created because the Shipping Advice field is set to Complete, and item no. %1 is not available in location code %2.\\You can create the warehouse shipment by either changing the Shipping Advice field to Partial in %3 no. %4 or by manually filling in the warehouse shipment document.';
        Text003Lbl: Label 'The warehouse shipment was not created because an open warehouse shipment exists for the Sales Header and Shipping Advice is %1.\\You must add the item(s) as new line(s) to the existing warehouse shipment or change Shipping Advice to Partial.';
        Text004Lbl: Label 'No %1 was found. The warehouse shipment could not be created.';
#pragma warning restore AA0470
    procedure "LFS InsertLicenseDtlFromExportSalesOrderDoc"(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
    begin
        if (SalesHeader."LFS EXIM Type" <> SalesHeader."LFS EXIM Type"::Export) OR
   ((SalesHeader."Document Type" <> SalesHeader."Document Type"::Order) AND
    (SalesHeader."Document Type" <> SalesHeader."Document Type"::"Return Order")) then
            EXIT;

        EXIMSetup.GET();

        SalesLine.Reset();
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        if SalesLine.Findset() then
            repeat
                "LFS InsertLicenseDtlFromExportSalesOrderDocToAdvLicense"(SalesLine);
            UNTIL SalesLine.Next() = 0;
    end;

    procedure "LFS InsertLicenseDtlFromExportSalesOrderDocToAdvLicense"(SalesLine: Record "Sales Line")
    var
        //Item: Record Item;
        EXIMAdvLicenseHeader: Record "LFS EXIM License Header";
        EXIMAdvLicenseLines: Record "LFS EXIM License Lines";
        Licenses: Record "LFS EXIM Posted Export Licence";
        LineNo: Integer;
    begin
        EXIMAdvLicenseLines.SETRANGE(EXIMAdvLicenseLines."LFS Adv. License No.", EXIMAdvLicenseHeader."LFS No.");
        if EXIMAdvLicenseLines.FindLast() then
            LineNo := EXIMAdvLicenseLines."LFS Line No." + 10000
        else
            LineNo := 10000;
        EXIMAdvLicenseLines.Init();

        Licenses.Reset();
        Licenses.SetRange("LFS Source No.", SalesLine."Document No.");
        if Licenses.Findset() then
            repeat
                EXIMAdvLicenseHeader.GET(SalesLine."LFS License No.");
                EXIMAdvLicenseLines.Reset();
                EXIMAdvLicenseLines."LFS Adv. License No." := EXIMAdvLicenseHeader."LFS No.";
                EXIMAdvLicenseLines."LFS Line No." := LineNo;
                EXIMAdvLicenseLines.insert();
                EXIMAdvLicenseLines."LFS Qty." := Licenses."LFS Quantity";
                EXIMAdvLicenseLines."LFS FOB Value" := Licenses."LFS FOB (FCY)";
                EXIMAdvLicenseLines."LFS Type" := EXIMAdvLicenseLines."LFS Type"::Export;
                EXIMAdvLicenseLines."LFS Document Type" := EXIMAdvLicenseLines."LFS Document Type"::Order;
                EXIMAdvLicenseLines."LFS Document No." := SalesLine."Document No.";
                EXIMAdvLicenseLines."LFS Document Line No." := SalesLine."Line No.";
                EXIMAdvLicenseLines.VALIDATE("LFS Item No.", SalesLine."No.");
                EXIMAdvLicenseLines."LFS UOM" := SalesLine."Unit of Measure Code";
                EXIMAdvLicenseLines."LFS Currency Code" := SalesLine."Currency Code";
                // if EXIMSetup."LFS Advance Lic Calc. Type" = EXIMSetup."LFS Advance Lic Calc. Type"::"Currency Exch." then
                EXIMAdvLicenseLines."LFS Currency Exch. Rate" := SalesLine."LFS Custom Exch. Rate";
                // else
                //     EXIMAdvLicenseLines."LFS Currency Exch. Rate" := SalesLine."LFS Custom Exch. Rate";
                EXIMAdvLicenseLines."LFS FOB LCY Value" := EXIMAdvLicenseLines."LFS FOB Value" * EXIMAdvLicenseLines."LFS Currency Exch. Rate";
                EXIMAdvLicenseLines."LFS CIF LCY Value" := EXIMAdvLicenseLines."LFS CIF Value" * EXIMAdvLicenseLines."LFS Currency Exch. Rate";
                // Item.GET(EXIMAdvLicenseLines."LFS Item No.");
                // EXIMAdvLicenseLines."LFS EXIM Item Group" := Item."LFS EXIM Item Group";
                EXIMAdvLicenseLines."LFS License Currency Factor" := EXIMAdvLicenseHeader."LFS Currency Factor";
                EXIMAdvLicenseLines.Modify();

            until Licenses.Next() = 0;
    end;


    procedure "LFS InsertLicenseDtlFromExportPostedSalesInvDoc"(SalesInvoiceLine: Record "Sales Invoice Line"; SalesInvoiceHeader: record "Sales Invoice Header")
    begin
        if (SalesInvoiceLine."LFS EXIM Type" <> SalesInvoiceLine."LFS EXIM Type"::Export) then
            "LFS InsertLicenseDtlFromExportPostedSalesInvDocToRodtepLicense"(SalesInvoiceLine)
        else
            "LFS InsertLicenseDtlFromExportPostedSalesInvDocToAdvLicense"(SalesInvoiceLine);
    end;

    local procedure "LFS InsertLicenseDtlFromExportPostedSalesInvDocToAdvLicense"(SalesInvoiceLine: Record "Sales Invoice Line")
    var
        EXIMAdvLicenseHeader: Record "LFS EXIM License Header";
        EXIMAdvLicenseLines: Record "LFS EXIM License Lines";
        EXIMLicenseMultiple: Record "LFS EXIM Posted Export Licence";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        LineNo: Integer;
    begin
        EXIMLicenseMultiple.SetRange("LFS Source No.", SalesInvoiceLine."Document No.");
        EXIMLicenseMultiple.SetRange("LFS Source line No.", SalesInvoiceLine."Line No.");
        if EXIMLicenseMultiple.Findset() then
            repeat
                EXIMAdvLicenseHeader.SetRange("LFS No.", EXIMLicenseMultiple."LFS License No.");
                if EXIMAdvLicenseHeader.FindFirst() then begin
                    EXIMAdvLicenseLines.SETRANGE(EXIMAdvLicenseLines."LFS Adv. License No.", EXIMAdvLicenseHeader."LFS No.");
                    EXIMAdvLicenseLines.SetCurrentKey("LFS Line No.");
                    if EXIMAdvLicenseLines.FindLast() then
                        LineNo := EXIMAdvLicenseLines."LFS Line No." + 10000
                    else
                        LineNo := 10000;

                    EXIMAdvLicenseLines."LFS Adv. License No." := EXIMLicenseMultiple."LFS License No.";
                    EXIMAdvLicenseLines."LFS Line No." := LineNo;
                    EXIMAdvLicenseLines."LFS Qty." := EXIMLicenseMultiple."LFS Quantity";

                    //LFS:SC:29-08-2024++
                    // SalesInvoiceHeader.GET(SalesInvoiceLine."Document No.");
                    // if EXIMAdvLicenseHeader."Currency Code" <> SalesInvoiceHeader."Currency Code" then begin
                    //     EXIMAdvLicenseLines."FOB LCY Value" := EXIMLicenseMultiple."FOB (FCY)" * SalesInvoiceLine."Currency Exch. Rate";
                    //     CurrencyMaster.Reset();
                    //     CurrencyMaster.SetRange(Code, EXIMAdvLicenseHeader."Currency Code");
                    //     if CurrencyMaster.FindFirst() then begin
                    //         currencyExch.Reset();
                    //         currencyExch.SetRange("Currency Code", CurrencyMaster.Code);
                    //         currencyExch.SetRange("Starting Date", SalesInvoiceHeader."Posting Date");
                    //         if currencyExch.FindFirst() then begin
                    //             EXIMAdvLicenseLines."FOB Value" := EXIMAdvLicenseLines."FOB LCY Value" / currencyExch."Relational Exch. Rate Amount";
                    //             EXIMAdvLicenseLines."Currency Exch. Rate" := currencyExch."Relational Exch. Rate Amount";
                    //         end;
                    //     end;
                    //     EXIMAdvLicenseLines."Currency Code" := EXIMAdvLicenseHeader."Currency Code";
                    // end else begin 
                    //     EXIMAdvLicenseLines."FOB Value" := EXIMLicenseMultiple."FOB (FCY)";
                    //     EXIMAdvLicenseLines."Currency Exch. Rate" := SalesInvoiceLine."Currency Exch. Rate";
                    //     EXIMAdvLicenseLines."FOB LCY Value" := EXIMAdvLicenseLines."FOB Value" * EXIMAdvLicenseLines."Currency Exch. Rate";
                    //     EXIMAdvLicenseLines."Currency Code" := SalesInvoiceHeader."Currency Code";
                    // end;
                    //LFS:SC:29-08-2024--

                    EXIMAdvLicenseLines."LFS FOB Value" := EXIMLicenseMultiple."LFS FOB (FCY)";
                    EXIMAdvLicenseLines."LFS CIF Value" := 0;
                    EXIMAdvLicenseLines."LFS Type" := EXIMAdvLicenseLines."LFS Type"::Export;
                    EXIMAdvLicenseLines."LFS IsImport" := false;
                    EXIMAdvLicenseLines."LFS Isexport" := true;
                    EXIMAdvLicenseLines."LFS Document Type" := EXIMAdvLicenseLines."LFS Document Type"::"Posted Invoice";
                    EXIMAdvLicenseLines."LFS Document No." := EXIMLicenseMultiple."LFS Source No.";
                    EXIMAdvLicenseLines."LFS Document Line No." := EXIMLicenseMultiple."LFS Source line No.";
                    EXIMAdvLicenseLines.VALIDATE("LFS Item No.", EXIMLicenseMultiple."LFS Item No.");
                    EXIMAdvLicenseLines.Validate("LFS Variant Code", EXIMLicenseMultiple."LFS Variant Code");
                    EXIMAdvLicenseLines.Validate("LFS Item Description", SalesInvoiceLine.Description);
                    EXIMAdvLicenseLines."LFS UOM" := SalesInvoiceLine."Unit of Measure Code";
                    EXIMAdvLicenseLines."LFS Currency Exch. Rate" := SalesInvoiceLine."LFS Custom Exch. Rate";
                    EXIMAdvLicenseLines."LFS CIF LCY Value" := EXIMAdvLicenseLines."LFS CIF Value" * EXIMAdvLicenseLines."LFS Currency Exch. Rate";
                    EXIMAdvLicenseLines."LFS Exim Group No." := SalesInvoiceLine."LFS Exim Group No.";
                    // EXIMAdvLicenseLines."LFS FOB CIF in USD" := SalesInvoiceLine."LFS FOB in USD";
                    EXIMAdvLicenseLines."LFS FOB CIF Currency Code" := SalesInvoiceLine."LFS FOB Currency Code";
                    EXIMAdvLicenseLines."LFS FOBCIFCurrencyExchangeRate" := SalesInvoiceLine."LFS FOB Currency Exchange Rate";
                    EXIMAdvLicenseLines."LFS FOB LCY Value" := (EXIMAdvLicenseLines."LFS FOB Value" * SalesInvoiceLine."LFS FOB Currency Exchange Rate");
                    SalesInvoiceHeader.GET(SalesInvoiceLine."Document No.");
                    EXIMAdvLicenseLines."LFS Currency Code" := SalesInvoiceHeader."Currency Code";
                    EXIMAdvLicenseLines.insert();
                end;
            until EXIMLicenseMultiple.Next() = 0;
    end;

    procedure "LFS InsertLicenseDtlFromExportPostedSalesCrNoteDoc"(SalesCrMemoLine: Record "Sales Cr.Memo Line")
    begin
        "LFS InsertLicenseDtlFromExportPostedSalesCrNoteDocToAdvLicense"(SalesCrMemoLine);
    end;

    local procedure "LFS InsertLicenseDtlFromExportPostedSalesCrNoteDocToAdvLicense"(SalesCrMemoLine: Record "Sales Cr.Memo Line")
    var
        EXIMAdvLicenseHeader: Record "LFS EXIM License Header";
        EXIMAdvLicenseLines: Record "LFS EXIM License Lines";
        EXIMLicenseMultiple: Record "LFS EXIM Posted Export Licence";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        LineNo: Integer;
    begin
        EXIMAdvLicenseLines.Init();
        EXIMLicenseMultiple.SetRange("LFS Source No.", salesCrMemoLine."Document No.");
        EXIMLicenseMultiple.SetRange("LFS Source line No.", SalesCrMemoLine."Line No.");
        if EXIMLicenseMultiple.Findset() then
            repeat
                EXIMAdvLicenseHeader.SetRange("LFS No.", EXIMLicenseMultiple."LFS License No.");
                if EXIMAdvLicenseHeader.FindFirst() then begin
                    EXIMAdvLicenseLines.SETRANGE(EXIMAdvLicenseLines."LFS Adv. License No.", EXIMAdvLicenseHeader."LFS No.");
                    EXIMAdvLicenseLines.SetCurrentKey("LFS Line No.");
                    if EXIMAdvLicenseLines.FindLast() then
                        LineNo := EXIMAdvLicenseLines."LFS Line No." + 10000
                    else
                        LineNo := 10000;

                    EXIMAdvLicenseLines."LFS Adv. License No." := EXIMLicenseMultiple."LFS License No.";
                    EXIMAdvLicenseLines."LFS Line No." := LineNo;
                    EXIMAdvLicenseLines."LFS Qty." := -EXIMLicenseMultiple."LFS Quantity";
                    EXIMAdvLicenseLines."LFS FOB Value" := -EXIMLicenseMultiple."LFS FOB (FCY)";
                    EXIMAdvLicenseLines."LFS CIF Value" := 0;
                    EXIMAdvLicenseLines."LFS Type" := EXIMAdvLicenseLines."LFS Type"::Export;
                    EXIMAdvLicenseLines."LFS Isexport" := true;
                    EXIMAdvLicenseLines."LFS IsImport" := false;
                    EXIMAdvLicenseLines."LFS Document Type" := EXIMAdvLicenseLines."LFS Document Type"::"Credit Memo";
                    EXIMAdvLicenseLines."LFS Document No." := EXIMLicenseMultiple."LFS Source No.";
                    EXIMAdvLicenseLines."LFS Document Line No." := EXIMLicenseMultiple."LFS Source Line No.";
                    EXIMAdvLicenseLines.VALIDATE("LFS Item No.", EXIMLicenseMultiple."LFS Item No.");
                    EXIMAdvLicenseLines.Validate("LFS Variant Code", EXIMLicenseMultiple."LFS Variant Code");
                    EXIMAdvLicenseLines.Validate("LFS Item Description", salesCrMemoLine.Description);
                    EXIMAdvLicenseLines."LFS UOM" := salesCrMemoLine."Unit of Measure Code";
                    EXIMAdvLicenseLines."LFS Currency Exch. Rate" := salesCrMemoLine."LFS Custom Exch. Rate";
                    // EXIMAdvLicenseLines."LFS FOB LCY Value" := EXIMAdvLicenseLines."LFS FOB Value" * EXIMAdvLicenseLines."LFS Currency Exch. Rate";
                    EXIMAdvLicenseLines."LFS CIF LCY Value" := EXIMAdvLicenseLines."LFS CIF Value" * EXIMAdvLicenseLines."LFS Currency Exch. Rate";
                    // EXIMAdvLicenseLines."LFS FOB CIF in USD" := -salesCrMemoLine."LFS FOB in USD";
                    EXIMAdvLicenseLines."LFS FOB CIF Currency Code" := salesCrMemoLine."LFS FOB Currency Code";
                    EXIMAdvLicenseLines."LFS FOBCIFCurrencyExchangeRate" := salesCrMemoLine."LFS FOB Currency Exchange Rate";
                    EXIMAdvLicenseLines."LFS FOB LCY Value" := (EXIMAdvLicenseLines."LFS FOB Value" * salesCrMemoLine."LFS FOB Currency Exchange Rate");
                    SalesCrMemoHeader.GET(salesCrMemoLine."Document No.");
                    EXIMAdvLicenseLines."LFS Currency Code" := SalesCrMemoHeader."Currency Code";
                    EXIMAdvLicenseLines.insert();
                end;
            until EXIMLicenseMultiple.Next() = 0;
    end;

    // procedure "LFS GetPstedShipLinesCustomPacking"(EXIMPackHdr: Record "LFS EXIM Packing Header")
    // var
    //     EXIMPackLines: Record "LFS EXIM Packing Lines";
    //     SalShipHdr: Record "Sales Shipment Header";
    //     // SalShipHdr2: Record "Sales Shipment Header";
    //     SalShipLine: Record "Sales Shipment Line";
    //     PstedSalShipPg: Page "LFS Posted Export Shipments";
    //     // HdrUpdated: Boolean;
    //     LineNo: Integer;
    // begin
    //     EXIMPackLines.Reset();
    //     EXIMPackLines.SETRANGE(EXIMPackLines."LFS Type", EXIMPackHdr."LFS Type");
    //     EXIMPackLines.SETRANGE(EXIMPackLines."LFS Packing List No.", EXIMPackHdr."LFS Packing List No.");
    //     if EXIMPackLines.FINDFIRST() then
    //         if NOT CONFIRM(Text00001ConfLbl, FALSE) then
    //             EXIT;
    //     Commit();
    //     EXIMPackLines.Reset();
    //     EXIMPackLines.SETRANGE(EXIMPackLines."LFS Type", EXIMPackHdr."LFS Type");
    //     EXIMPackLines.SETRANGE(EXIMPackLines."LFS Packing List No.", EXIMPackHdr."LFS Packing List No.");
    //     EXIMPackLines.DELETEALL(true);
    //     COMMIT();

    //     SalShipHdr.Reset();
    //     SalShipHdr.FILTERGROUP(2);
    //     SalShipHdr.SETRANGE("LFS EXIM Type", SalShipHdr."LFS EXIM Type"::Export);
    //     // SalShipHdr.SETRANGE("LFS Completely Packed", FALSE);
    //     // SalShipHdr.SETFILTER("LFS Total Line Qty.", '<>%1', 0);
    //     SalShipHdr.FILTERGROUP(0);

    //     CLEAR(PstedSalShipPg);
    //     PstedSalShipPg.LOOKUPMODE(true);
    //     PstedSalShipPg.SETTABLEVIEW(SalShipHdr);
    //     if PstedSalShipPg.RUNMODAL() <> ACTION::LookupOK then
    //         EXIT;

    //     PstedSalShipPg.GetResult(SalShipHdr);

    //     if SalShipHdr.Findset() then
    //         repeat
    //             // HdrUpdated := FALSE;
    //             SalShipLine.Reset();
    //             SalShipLine.SETRANGE(SalShipLine."Document No.", SalShipHdr."No.");
    //             SalShipLine.SETRANGE(SalShipLine.Type, SalShipLine.Type::Item);
    //             if SalShipLine.Findset() then
    //                 // begin
    //                 repeat
    //                     LineNo += 10000;
    //                     EXIMPackLines.Init();
    //                     EXIMPackLines."LFS Type" := EXIMPackHdr."LFS Type";
    //                     EXIMPackLines."LFS Line No." := LineNo;
    //                     EXIMPackLines."LFS Parent Line No." := 0;
    //                     EXIMPackLines."LFS Packing List No." := EXIMPackHdr."LFS Packing List No.";
    //                     EXIMPackLines.Insert();
    //                     Commit();
    //                     EXIMPackLines.Reset();
    //                     EXIMPackLines.SetRange("LFS Packing List No.", EXIMPackHdr."LFS Packing List No.");
    //                     if EXIMPackLines.FindLast() then begin
    //                         EXIMPackLines.VALIDATE(EXIMPackLines."LFS Item No.", SalShipLine."No.");
    //                         EXIMPackLines."LFS Unit of Measure Code" := SalShipLine."Unit of Measure Code";
    //                         // EXIMPackLines."LFS Total Shipment Qty." := SalShipLine."LFS Rem. Qty. To be Packed";
    //                         EXIMPackLines."LFS BL No." := SalShipHdr."Bill Of Export No.";
    //                         EXIMPackLines."LFS BL Date" := SalShipHdr."Bill Of Export Date";
    //                         EXIMPackLines."LFS Shipment Document No." := SalShipLine."Document No.";
    //                         EXIMPackLines."LFS Shipment Document Line No." := SalShipLine."Line No.";
    //                         // EXIMPackLines."LFS Shipping Bill Date" := SalShipLine."LFS Shipping Bill Date";
    //                         // EXIMPackLines."LFS Shipping Bill No." := SalShipLine."LFS Shipping Bill No.";
    //                         EXIMPackLines."LFS Container No." := EXIMPackHdr."LFS Container No.";
    //                         EXIMPackLines."LFS Container Size" := EXIMPackHdr."LFS Container Size";
    //                         EXIMPackLines."LFS Trailor No." := EXIMPackHdr."LFS Trailor No.";
    //                         EXIMPackLines."LFS Vehicle No." := EXIMPackHdr."LFS Vehicle No.";
    //                         EXIMPackLines."LFS Agent Seal No." := EXIMPackHdr."LFS Agent Seal No.";
    //                         EXIMPackLines."LFS RFID E-Seal Nos." := EXIMPackHdr."LFS RFID E-Seal Nos.";
    //                         EXIMPackLines."LFS Rotation No." := EXIMPackHdr."LFS Rotation No.";
    //                         EXIMPackLines."LFS Shipping Line" := EXIMPackHdr."LFS Shipping Line";
    //                         EXIMPackLines."LFS Vessel / Flight Details" := EXIMPackHdr."LFS Vessel / Flight Details";
    //                         EXIMPackLines."LFS Carriage" := EXIMPackHdr."LFS Carriage";
    //                         EXIMPackLines."LFS ETD" := EXIMPackHdr."LFS ETD";
    //                         EXIMPackLines."LFS ETA" := EXIMPackHdr."LFS ETA";
    //                         EXIMPackLines."LFS Date of Stuffing" := EXIMPackHdr."LFS Date of Stuffing";
    //                         EXIMPackLines."LFS Port Cut off" := EXIMPackHdr."LFS Port Cut off";
    //                         EXIMPackLines."LFS Forwarder No." := EXIMPackHdr."LFS Forwarder No.";
    //                         EXIMPackLines."LFS CHA No." := EXIMPackHdr."LFS CHA No.";
    //                         EXIMPackLines."LFS Transporter No." := EXIMPackHdr."LFS Transporter No.";
    //                         EXIMPackLines."LFS QC Vendor No." := EXIMPackHdr."LFS QC Vendor No.";
    //                         EXIMPackLines."LFS BL No." := EXIMPackHdr."LFS BL No.";
    //                         EXIMPackLines."LFS BL Date" := EXIMPackHdr."LFS BL Date";
    //                         EXIMPackLines."LFS Total Shipment Qty." := SalShipLine.Quantity;
    //                         EXIMPackLines.Modify();
    //                         Commit();
    //                     end;
    //                 UNTIL SalShipLine.Next() = 0;
    //             // if NOT HdrUpdated then begin
    //             //     if SalShipHdr2.GET(SalShipHdr."No.") then begin
    //             //         SalShipHdr2."LFS Shipping Bill Date" := SalShipLine."LFS Shipping Bill Date";
    //             //         SalShipHdr2."LFS Shipping Bill No." := SalShipLine."LFS Shipping Bill No.";
    //             //         SalShipHdr2.MODIFY();
    //             //     end;
    //             //     HdrUpdated := true;
    //             // end;
    //             // end;
    //             Commit();
    //         UNTIL SalShipHdr.Next() = 0;
    // end;


    // procedure "LFS GetRelCusPackingLinesCommPacking"(EXIMPackHdr: Record "LFS EXIM Packing Header")
    // var
    //     EXIMPackHdr_Custom: Record "LFS EXIM Packing Header";
    //     EXIMPackLines_Commercial: Record "LFS EXIM Packing Lines";
    //     EXIMPackLines_Custom: Record "LFS EXIM Packing Lines";
    //     EXIMCustomPackingList: Page "LFS EXIM Custom Packing List";
    //     LineNo: Integer;

    // begin
    //     EXIMPackLines_Commercial.Reset();
    //     EXIMPackLines_Commercial.SetRange(EXIMPackLines_Commercial."LFS Type", EXIMPackHdr."LFS Type");
    //     EXIMPackLines_Commercial.SetRange(EXIMPackLines_Commercial."LFS Packing List No.", EXIMPackHdr."LFS Packing List No.");
    //     if EXIMPackLines_Commercial.FindFirst() then
    //         if not Confirm(Text00001ConfLbl, false) then
    //             exit;

    //     EXIMPackLines_Commercial.Reset();
    //     EXIMPackLines_Commercial.SetRange(EXIMPackLines_Commercial."LFS Type", EXIMPackHdr."LFS Type");
    //     EXIMPackLines_Commercial.SetRange(EXIMPackLines_Commercial."LFS Packing List No.", EXIMPackHdr."LFS Packing List No.");
    //     EXIMPackLines_Commercial.DeleteAll(true);
    //     Commit();

    //     EXIMPackHdr_Custom.Reset();
    //     EXIMPackHdr_Custom.FilterGroup(2);
    //     EXIMPackHdr_Custom.SetRange(EXIMPackHdr_Custom."LFS Commercial Packing No.", '');
    //     EXIMPackHdr_Custom.SetRange(EXIMPackHdr_Custom."LFS Posted", true);
    //     EXIMPackHdr_Custom.FilterGroup(0);

    //     Clear(EXIMCustomPackingList);
    //     EXIMCustomPackingList.LookupMode(true);
    //     EXIMCustomPackingList.SetTableView(EXIMPackHdr_Custom);
    //     if EXIMCustomPackingList.RunModal() <> Action::LookupOK then
    //         exit;

    //     EXIMCustomPackingList.GetResult(EXIMPackHdr_Custom);

    //     if EXIMPackHdr_Custom.FindFirst() then
    //         repeat
    //             EXIMPackHdr_Custom.Reset();
    //             EXIMPackHdr_Custom.SetRange(EXIMPackHdr_Custom."LFS Type", EXIMPackHdr_Custom."LFS Type"::Custom);
    //             EXIMPackHdr_Custom.SetRange(EXIMPackHdr_Custom."LFS Packing List No.", EXIMPackHdr_Custom."LFS Packing List No.");
    //             if EXIMPackHdr_Custom.Findset() then
    //                 repeat
    //                     LineNo += 10000;
    //                     EXIMPackLines_Commercial.Init();
    //                     EXIMPackLines_Commercial.TransferFields(EXIMPackLines_Custom);
    //                     EXIMPackLines_Commercial."LFS Type" := EXIMPackHdr."LFS Type";
    //                     EXIMPackLines_Commercial."LFS Packing List No." := Format(EXIMPackHdr."LFS Pallet Size");
    //                     EXIMPackLines_Commercial."LFS Line No." := LineNo;
    //                     EXIMPackLines_Commercial."LFS Custom Packing No." := EXIMPackLines_Custom."LFS Packing List No.";
    //                     EXIMPackLines_Commercial."LFS Custom Packing Line No." := EXIMPackLines_Custom."LFS Line No.";
    //                     EXIMPackLines_Commercial.Insert();
    //                 until EXIMPackLines_Custom.Next() = 0;
    //         until EXIMPackHdr_Custom.Next() = 0;
    // end;

    // procedure "LFS PostCustomPackingDocument"(var EXIMPackingHeader: Record "LFS EXIM Packing Header")
    // var
    // // EXIMPackingLines: Record "LFS EXIM Packing Lines";
    // // SalesShipmentLine: Record "Sales Shipment Line";
    // begin
    //     // EXIMPackingLines.Reset();
    //     // EXIMPackingLines.SETRANGE("LFS Type", EXIMPackingHeader."LFS Type");
    //     // EXIMPackingLines.SETRANGE("LFS Packing List No.", EXIMPackingHeader."LFS Packing List No.");
    //     // EXIMPackingLines.SETFILTER("LFS Parent Line No.", '<>%1', 0);
    //     // if EXIMPackingLines.Findset() then
    //     //     repeat
    //     //         SalesShipmentLine.GET(EXIMPackingLines."LFS Shipment Document No.", EXIMPackingLines."LFS Shipment Document Line No.");
    //     //         // SalesShipmentLine."LFS Packed Qty." += EXIMPackingLines."LFS Qty. To Pack";
    //     //         // if SalesShipmentLine."LFS Packed Qty." > SalesShipmentLine.Quantity then
    //     //         //     ERROR('Cannot pack more than %1 units', SalesShipmentLine.Quantity);
    //     //         // SalesShipmentLine."LFS Rem. Qty. To be Packed" -= EXIMPackingLines."LFS Qty. To Pack";
    //     //         // SalesShipmentLine.MODIFY();
    //     //     UNTIL EXIMPackingLines.Next() = 0;
    //     EXIMPackingHeader."LFS Posted" := true;
    //     EXIMPackingHeader.MODIFY();
    //     // if SalesShipmentHeader.GET(EXIMPackingLines."LFS Shipment Document No.") then begin
    //     //     SalesShipmentHeader."LFS Packing Posted" := true;
    //     //     SalesShipmentHeader.MODIFY();
    //     // end;
    // end;

    procedure "LFS InsertDDBEntryFromExportPostedSalesDoc"(SalesInvLine: Record "Sales Invoice Line"; EXIMDDBRateSetup: record "LFS EXIM DDB Rate Setup")
    var
        EXIMDDBEntry: Record "LFS EXIM DDB Entry";
        EXIMSetups: Record "LFS EXIM Setup";
        EntryNo: Integer;

    begin
        EXIMSetups.GET();
        // SalesDocRef.OPEN(TableRecID.TABLENO);
        // SalesDocRef.GET(TableRecID);

        EXIMDDBEntry.Reset();
        if EXIMDDBEntry.FindLast() then
            EntryNo := EXIMDDBEntry."LFS Entry No.";

        EntryNo += 1;
        EXIMDDBEntry.Init();
        EXIMDDBEntry."LFS Entry No." := EntryNo;
        // if TableRecID.TABLENO = 113 then
        EXIMDDBEntry."LFS Document Type" := EXIMDDBEntry."LFS Document Type"::"Posted Sales Invoice";
        // else
        //     if TableRecID.TABLENO = 115 then
        //         EXIMDDBEntry."LFS Document Type" := EXIMDDBEntry."LFS Document Type"::"Posted Sales Cr. Memo";
        EXIMDDBEntry."LFS Document No." := SalesInvLine."Document No.";
        EXIMDDBEntry."LFS Posting Date" := SalesInvLine."Posting Date";
        EXIMDDBEntry."LFS Type" := SalesInvLine.Type;
        EXIMDDBEntry."LFS No." := SalesInvLine."No.";
        EXIMDDBEntry."LFS Description" := SalesInvLine.Description;
        EXIMDDBEntry."LFS HSN No." := SalesInvLine."HSN/SAC Code";
        EXIMDDBEntry."LFS Unit of Measure" := SalesInvLine."Unit of Measure Code";
        EXIMDDBEntry."LFS Quantity" := SalesInvLine.Quantity;
        EXIMDDBEntry."LFS Rate" := SalesInvLine."Unit Price";
        EXIMDDBEntry."LFS FCY Amount" := SalesInvLine."Line Amount";
        // EXIMDDBEntry."LFS LCY Amount" := SalesInvLine."Line Amount";    code commented
        EXIMDDBEntry."LFS LCY Amount" := SalesInvLine."LFS FOB Amount (LCY)";
        EXIMDDBEntry."LFS Exchange Rate" := SalesInvLine."Unit Price";
        EXIMDDBEntry."LFS Custom Exchange Rate" := SalesInvLine."LFS Custom Exch. Rate";
        EXIMDDBEntry."LFS EXIM Type" := SalesInvLine."LFS EXIM Type";
        EXIMDDBEntry."LFS Incentive Type" := SalesInvLine."LFS Incentive Type";
        EXIMDDBEntry."LFS FOB Amount (FCY)" := SalesInvLine."LFS FOB Amount (FCY)";
        EXIMDDBEntry."LFS CIF Amount (FCY)" := SalesInvLine."LFS CIF Amount (FCY)";
        if EXIMDDBEntry."LFS Currency Exch. Rate" <> 0 then
            EXIMDDBEntry."LFS FOB FCY Amount" := SalesInvLine."LFS FOB Amount (FCY)"
        else
            EXIMDDBEntry."LFS FOB FCY Amount" := SalesInvLine."LFS FOB in USD" * SalesInvLine."LFS FOB Currency Exchange Rate";
        EXIMDDBEntry."LFS Claim DDB" := SalesInvLine."LFS Claim DDB";
        // if EXIMDDBRateSetup."LFS DDB Rate" <> 0 then
        //     EXIMDDBEntry."LFS DDB %" := EXIMDDBRateSetup."LFS DDB Rate"
        // else begin
        //     EXIMSetup.get;
        //     EXIMDDBEntry."LFS DDB %" := EXIMSetup."LFS DDB %";
        // end;
        EXIMDDBEntry."LFS DDB %" := SalesInvLine."LFS DDB Rate";
        EXIMDDBEntry."LFS FCY Amount" := SalesInvLine."LFS FOB Amount (FCY)";
        EXIMDDBEntry."LFS LCY Amount" := SalesInvLine."LFS FOB Amount (LCY)";
        EXIMDDBEntry."LFS FOB Amount (FCY)" := SalesInvLine."LFS FOB Amount (FCY)";
        EXIMDDBEntry."LFS CIF FCY Amount" := SalesInvLine."LFS CIF Value (FCY)";
        EXIMDDBEntry."LFS CIF LCY Amount" := SalesInvLine."LFS CIF Value (LCY)";
        EXIMDDBEntry."LFS CIF Amount (FCY)" := SalesInvLine."LFS CIF Amount (FCY)";
        // EXIMDDBEntry."ILFS Insurance Type" := SalesInvLine."LFS Insurance Type";
        EXIMDDBEntry."LFS Insurance Value (FCY)" := SalesInvLine."LFS Insurance Value (FCY)";
        EXIMDDBEntry."LFS Insurance Value (LCY)" := SalesInvLine."LFS Insurance Value (LCY)";
        // EXIMDDBEntry."LFS Freight Type" := SalesInvLine."LFS Freight Type";
        EXIMDDBEntry."LFS Freight Value (FCY)" := SalesInvLine."LFS Freight Value (FCY)";
        EXIMDDBEntry."LFS Freight Value (LCY)" := SalesInvLine."LFS Freight Value (LCY)";
        // EXIMDDBEntry."LFS DDB Value LCY" := EXIMDDBEntry."LFS DDB Value FCY" * EXIMDDBEntry."LFS Currency Exch. Rate"
        EXIMDDBEntry."LFS DDB Value LCY" := SalesInvLine."LFS DDB Value (LCY)";
        // EXIMDDBEntry."LFS DDB Value FCY" := (EXIMDDBEntry."LFS FOB FCY Amount" * EXIMDDBEntry."LFS DDB %") / 100;
        if SalesInvLine."LFS Custom Exch. Rate" <> 0 then
            EXIMDDBEntry."LFS DDB Value FCY" := SalesInvLine."LFS DDB Value (LCY)" / SalesInvLine."LFS Custom Exch. Rate"
        else
            EXIMDDBEntry."LFS DDB Value FCY" := SalesInvLine."LFS DDB Value (LCY)";
        EXIMDDBEntry."LFS Currency Exch. Rate" := SalesInvLine."LFS Custom Exch. Rate";
        EXIMDDBEntry."LFS Custom Exch. Rate" := SalesInvLine."LFS Custom Exch. Rate";
        EXIMDDBEntry.Insert();
    end;

    procedure "LFS InsertDDBEntryFromExportPostedSalesCrNoteDoc"(SalesCrMemoLine: Record "Sales Cr.Memo Line"; EXIMDDBRateSetup: record "LFS EXIM DDB Rate Setup")
    var
        // SalesDocRef: RecordRef;
        //EXIMSetup: Record "LFS EXIM Setup";
        EXIMDDBEntry: Record "LFS EXIM DDB Entry";
        Qty: Decimal;
        EntryNo: Integer;
    begin
        EXIMSetup.Get();
        // SalesDocRef.OPEN(TableRecID.TABLENO);
        // SalesDocRef.GET(TableRecID);

        EXIMDDBEntry.Reset();
        if EXIMDDBEntry.FindLast() then
            EntryNo := EXIMDDBEntry."LFS Entry No.";

        EntryNo += 1;
        EXIMDDBEntry.Init();
        EXIMDDBEntry."LFS Entry No." := EntryNo;
        // if TableRecID.TABLENO = 113 then
        //     EXIMDDBEntry."LFS Document Type" := EXIMDDBEntry."LFS Document Type"::"Posted Sales Invoice"
        // else
        //     if TableRecID.TABLENO = 115 then
        EXIMDDBEntry."LFS Document Type" := EXIMDDBEntry."LFS Document Type"::"Posted Sales Cr. Memo";
        EXIMDDBEntry."LFS Document No." := SalesCrMemoLine."Document No.";
        EXIMDDBEntry."LFS Posting Date" := SalesCrMemoLine."Posting Date";
        EXIMDDBEntry."LFS Type" := SalesCrMemoLine.Type;
        EXIMDDBEntry."LFS No." := SalesCrMemoLine."No.";
        EXIMDDBEntry."LFS Description" := SalesCrMemoLine.Description;
        EXIMDDBEntry."LFS HSN No." := SalesCrMemoLine."HSN/SAC Code";
        EXIMDDBEntry."LFS Unit of Measure" := SalesCrMemoLine."Unit of Measure Code";
        Qty := SalesCrMemoLine.Quantity;
        EXIMDDBEntry."LFS Quantity" := -Qty;
        EXIMDDBEntry."LFS Rate" := SalesCrMemoLine."Unit Price";
        EXIMDDBEntry."LFS FCY Amount" := -SalesCrMemoLine."LFS FOB Amount (FCY)";
        EXIMDDBEntry."LFS LCY Amount" := -SalesCrMemoLine."LFS FOB Amount (LCY)";
        EXIMDDBEntry."LFS Exchange Rate" := SalesCrMemoLine."LFS Custom Exch. Rate";
        EXIMDDBEntry."LFS Custom Exchange Rate" := SalesCrMemoLine."LFS Custom Exch. Rate";
        EXIMDDBEntry."LFS EXIM Type" := SalesCrMemoLine."LFS EXIM Type";
        EXIMDDBEntry."LFS Incentive Type" := SalesCrMemoLine."LFS Incentive Type";
        EXIMDDBEntry."LFS FOB Amount (FCY)" := SalesCrMemoLine."LFS FOB Amount (FCY)";
        EXIMDDBEntry."LFS CIF Amount (FCY)" := SalesCrMemoLine."LFS CIF Amount (FCY)";
        EXIMDDBEntry."LFS Insurance Value (FCY)" := -SalesCrMemoLine."LFS Insurance Value (FCY)";
        EXIMDDBEntry."LFS Insurance Value (LCY)" := -SalesCrMemoLine."LFS Insurance Value (LCY)";
        EXIMDDBEntry."LFS Freight Value (FCY)" := -SalesCrMemoLine."LFS Freight Value (FCY)";
        EXIMDDBEntry."LFS Freight Value (LCY)" := -SalesCrMemoLine."LFS Freight Value (LCY)";
        if EXIMDDBEntry."LFS Currency Exch. Rate" <> 0 then
            EXIMDDBEntry."LFS FOB FCY Amount" := SalesCrMemoLine."LFS FOB Amount (FCY)"
        else
            EXIMDDBEntry."LFS FOB FCY Amount" := SalesCrMemoLine."LFS FOB in USD" * SalesCrMemoLine."LFS FOB Currency Exchange Rate";
        EXIMDDBEntry."LFS Claim DDB" := SalesCrMemoLine."LFS Claim DDB";
        if EXIMDDBRateSetup."LFS DDB Rate" <> 0 then
            EXIMDDBEntry."LFS DDB %" := EXIMDDBRateSetup."LFS DDB Rate"
        else begin
            EXIMSetup.Get();
            EXIMDDBEntry."LFS DDB %" := EXIMSetup."LFS DDB %";
        end;
        // EXIMDDBEntry."LFS DDB Value FCY" := -(EXIMDDBEntry."LFS FOB FCY Amount" * EXIMDDBEntry."LFS DDB %") / 100;
        EXIMDDBEntry."LFS Currency Exch. Rate" := SalesCrMemoLine."LFS Custom Exch. Rate";
        EXIMDDBEntry."LFS Custom Exch. Rate" := SalesCrMemoLine."LFS Custom Exch. Rate";
        EXIMDDBEntry."LFS DDB Value LCY" := -SalesCrMemoLine."LFS DDB Value (LCY)";
        // EXIMDDBEntry."LFS DDB Value FCY" := (EXIMDDBEntry."LFS FOB FCY Amount" * EXIMDDBEntry."LFS DDB %") / 100;
        if SalesCrMemoLine."LFS Custom Exch. Rate" <> 0 then
            EXIMDDBEntry."LFS DDB Value FCY" := -SalesCrMemoLine."LFS DDB Value (LCY)" / SalesCrMemoLine."LFS Custom Exch. Rate"
        else
            EXIMDDBEntry."LFS DDB Value FCY" := -SalesCrMemoLine."LFS DDB Value (LCY)";
        // EXIMDDBEntry."LFS Currency Exch. Rate" := SalesInvLine."LFS Custom Exch. Rate";
        // if EXIMDDBEntry."LFS Currency Exch. Rate" <> 0 then
        //     EXIMDDBEntry."LFS DDB Value LCY" := EXIMDDBEntry."LFS DDB Value FCY" * EXIMDDBEntry."LFS Currency Exch. Rate"
        // else
        //     EXIMDDBEntry."LFS DDB Value LCY" := EXIMDDBEntry."LFS DDB Value FCY";
        EXIMDDBEntry.Insert();
    end;


    // procedure LFS InsertRoDTEPEntryFromExportPostedSalesDoc(TableRecID: RecordID; TableRecIDHdr: RecordID; RodtepSetup: Record "LFS EXIM RoDTEP Rate Setup")
    // var
    //     SalesDocRef: RecordRef;
    //     EXIMRoDTEPEntry: Record "LFS EXIM RoDTEP Rebate Entry";
    //     EntryNo: Integer;
    //     EXIMRoDTEPRateSetup: Record "LFS EXIM RoDTEP Rate Setup";
    //     SalesHdrDocRef: RecordRef;
    //     CountryRegion: Record "Country/Region";
    //     CountryRegionCode: Code[20];
    //     SalesLine: Record "Sales Line";
    //     RodtepRate: Decimal;
    //     EXIMSetup: Record "LFS EXIM Setup";
    // begin
    //     EXIMSetup.GET;
    //     SalesDocRef.OPEN(TableRecID.TABLENO);
    //     SalesDocRef.GET(TableRecID);

    //     SalesHdrDocRef.OPEN(TableRecIDHdr.TABLENO);
    //     SalesHdrDocRef.GET(TableRecIDHdr);

    //     EXIMRoDTEPEntry.Reset();
    //     if EXIMRoDTEPEntry.FindLast() then
    //         EntryNo := EXIMRoDTEPEntry."LFS Entry No.";
    //     EntryNo += 1;
    //     EXIMRoDTEPEntry.Init();
    //     EXIMRoDTEPEntry."LFS Entry No." := EntryNo;
    //     if TableRecID.TABLENO = 113 then
    //         EXIMRoDTEPEntry."LFS Document Type" := EXIMRoDTEPEntry."LFS Document Type"::"Posted Sales Invoice"
    //     else
    //         if TableRecID.TABLENO = 115 then
    //             EXIMRoDTEPEntry."LFS Document Type" := EXIMRoDTEPEntry."LFS Document Type"::"Posted Sales Cr. Memo";
    //     EXIMRoDTEPEntry."LFS Document No." := SalesDocRef.FIELD(3).VALUE;
    //     EXIMRoDTEPEntry."LFS Document Line No." := SalesDocRef.Field(4).Value;
    //     EXIMRoDTEPEntry."LFS Posting Date" := SalesDocRef.FIELD(131).VALUE;
    //     EXIMRoDTEPEntry ."LFS Type" := SalesDocRef.FIELD(5).VALUE;
    //     EXIMRoDTEPEntry."LFS No." := SalesDocRef.FIELD(6).VALUE;
    //     EXIMRoDTEPEntry."LFS Description":= SalesDocRef.FIELD(11).VALUE;
    //     EXIMRoDTEPEntry."LFS Unit of Measure" := SalesDocRef.FIELD(13).VALUE;
    //     EXIMRoDTEPEntry.LFS Quantity := SalesDocRef.FIELD(15).VALUE;
    //     EXIMRoDTEPEntry.LFS Rate := SalesDocRef.FIELD(22).VALUE;
    //     EXIMRoDTEPEntry."LFS FCY Amount" := SalesDocRef.FIELD(103).VALUE;
    //     EXIMRoDTEPEntry."LFS Exchange Rate" := SalesDocRef.FIELD(70128).VALUE;
    //     EXIMRoDTEPEntry."LFS Custom Exchange Rate" := SalesDocRef.FIELD(70129).VALUE;
    //     if EXIMRoDTEPEntry."LFS Exchange Rate" <> 0 then
    //         EXIMRoDTEPEntry."LFS LCY Amount" := EXIMRoDTEPEntry."LFS FCY Amount" * EXIMRoDTEPEntry."LFS Exchange Rate";
    //     EXIMRoDTEPEntry."LFS EXIM Type" := SalesDocRef.FIELD(70106).VALUE;
    //     EXIMRoDTEPEntry."LFS Incentive Type" := SalesDocRef.FIELD(70107).VALUE;
    //     EXIMRoDTEPEntry."LFS FOB Amount (FCY)" := SalesDocRef.FIELD(70110).value;
    //     EXIMRoDTEPEntry."LFS CIF Amount (FCY)" := SalesDocRef.FIELD(70111).VALUE;
    //     EXIMRoDTEPEntry."LFS No. of Container" := SalesDocRef.FIELD(70112).VALUE;
    //     if RodtepSetup."LFS RoDTEP Rebate Rate %" <> 0 then
    //         EXIMRoDTEPEntry."LFS RoDTEP Rebate Rate %" := RodtepSetup."LFS RoDTEP Rebate Rate %"
    //     else begin
    //         EXIMSetup.Get();
    //         EXIMRoDTEPEntry."LFS RoDTEP Rebate Rate %" := EXIMSetup."LFS RoDTEP %";
    //     end;
    //     RodtepRate := EXIMRoDTEPEntry."LFS RoDTEP Rebate Rate %";
    //     EXIMRoDTEPEntry."LFS RoDTEP Rebate Value FCY" := RodtepRate / 100 * EXIMRoDTEPEntry."LFS FCY Amount";
    //     EXIMRoDTEPEntry."LFS RoDTEP Rebate Value LCY" := EXIMRoDTEPEntry."LFS RoDTEP Rebate Value FCY" * EXIMRoDTEPEntry."LFS Exchange Rate";
    //     EXIMRoDTEPEntry."LFS Claim Amount" := EXIMRoDTEPEntry."LFS RoDTEP Rebate Value FCY" * EXIMRoDTEPEntry."LFS Exchange Rate";
    //     EXIMRoDTEPEntry.Insert();
    // end;

    //NEw
    procedure "LFS InsertRoDTEPEntryFromExportPostedSalesDoc"(SalesInvLine: Record "Sales Invoice Line"; SalesInvHdr: Record "Sales Invoice Header"; RodtepSetup: Record "LFS EXIM RoDTEP Rate Setup")
    var

        EXIMRoDTEPEntry: Record "LFS EXIM RoDTEP Rebate Entry";
        // RodtepRate: Decimal;
        EntryNo: Integer;

    begin
        EXIMSetup.Get();
        if SalesInvLine."LFS RoDTEP Rebate Value" <> 0 then begin

            EXIMRoDTEPEntry.Reset();
            if EXIMRoDTEPEntry.FindLast() then
                EntryNo := EXIMRoDTEPEntry."LFS Entry No.";
            EntryNo += 1;
            EXIMRoDTEPEntry.Init();
            EXIMRoDTEPEntry."LFS Entry No." := EntryNo;
            EXIMRoDTEPEntry."LFS Document Type" := EXIMRoDTEPEntry."LFS Document Type"::"Posted Sales Invoice";
            EXIMRoDTEPEntry."LFS Document No." := SalesInvLine."Document No.";
            EXIMRoDTEPEntry."LFS Document Line No." := SalesInvLine."Line No.";
            EXIMRoDTEPEntry."LFS Posting Date" := SalesInvLine."Posting Date";
            EXIMRoDTEPEntry."LFS Type" := SalesInvLine.Type;
            EXIMRoDTEPEntry."LFS No." := SalesInvLine."No.";
            EXIMRoDTEPEntry."LFS Description" := SalesInvLine.Description;
            EXIMRoDTEPEntry."LFS Unit of Measure" := SalesInvLine."Unit of Measure Code";
            EXIMRoDTEPEntry."LFS Quantity" := SalesInvLine.Quantity;
            EXIMRoDTEPEntry."LFS Rate" := SalesInvLine."Unit Price";
            EXIMRoDTEPEntry."LFS FCY Amount" := SalesInvLine."LFS FOB Amount (FCY)";

            EXIMRoDTEPEntry."LFS CIF Value (FCY)" := SalesInvLine."LFS CIF Value (FCY)";
            EXIMRoDTEPEntry."LFS CIF Value (LCY)" := SalesInvLine."LFS CIF Value (LCY)";
            EXIMRoDTEPEntry."LFS CIF Amount (FCY)" := SalesInvLine."LFS CIF Amount (FCY)";
            EXIMRoDTEPEntry."LFS Freight Value (FCY)" := SalesInvLine."LFS Freight Value (FCY)";
            EXIMRoDTEPEntry."LFS Freight Value (LCY)" := SalesInvLine."LFS Freight Value (LCY)";
            EXIMRoDTEPEntry."LFS Insurance Value (FCY)" := SalesInvLine."LFS Insurance Value (FCY)";
            EXIMRoDTEPEntry."LFS Insurance Value (LCY)" := SalesInvLine."LFS Insurance Value (LCY)";

            EXIMRoDTEPEntry."LFS Exchange Rate" := SalesInvLine."LFS Custom Exch. Rate";
            EXIMRoDTEPEntry."LFS Custom Exchange Rate" := SalesInvLine."LFS Custom Exch. Rate";
            EXIMRoDTEPEntry."LFS LCY Amount" := SalesInvLine."LFS FOB Amount (LCY)";
            EXIMRoDTEPEntry."LFS EXIM Type" := SalesInvLine."LFS EXIM Type";
            EXIMRoDTEPEntry."LFS Incentive Type" := SalesInvLine."LFS Incentive Type";
            EXIMRoDTEPEntry."LFS FOB Amount (FCY)" := SalesInvLine."LFS FOB Amount (FCY)";
            EXIMRoDTEPEntry."LFS No. of Container" := SalesInvLine."LFS No. of Container";
            // if RodtepSetup."LFS RoDTEP Rebate Rate %" <> 0 then
            EXIMRoDTEPEntry."LFS RoDTEP Rebate Rate %" := SalesInvLine."LFS RoDTEP Rebate Rate %";
            EXIMRoDTEPEntry."LFS RoDTEP Rebate Value LCY" := SalesInvLine."LFS RoDTEP Rebate Value";
            if SalesInvLine."LFS Custom Exch. Rate" <> 0 then
                EXIMRoDTEPEntry."LFS RoDTEP Rebate Value FCY" := SalesInvLine."LFS RoDTEP Rebate Value" / SalesInvLine."LFS Custom Exch. Rate"
            else
                EXIMRoDTEPEntry."LFS RoDTEP Rebate Value FCY" := SalesInvLine."LFS RoDTEP Rebate Value";
            EXIMRoDTEPEntry."LFS Claim Amount" := SalesInvLine."LFS RoDTEP Rebate Value";
            // 
            // else begin
            //     EXIMSetup.Get();
            //     EXIMRoDTEPEntry."LFS RoDTEP Rebate Rate %" := EXIMSetup."LFS RoDTEP %";
            // end;
            // RodtepRate := EXIMRoDTEPEntry."LFS RoDTEP Rebate Rate %";
            // if EXIMRoDTEPEntry."LFS Exchange Rate" <> 0 then begin
            //     EXIMRoDTEPEntry."LFS RoDTEP Rebate Value FCY" := RodtepRate / 100 * EXIMRoDTEPEntry."LFS FCY Amount";
            //     EXIMRoDTEPEntry."LFS RoDTEP Rebate Value LCY" := EXIMRoDTEPEntry."LFS RoDTEP Rebate Value FCY" * EXIMRoDTEPEntry."LFS Exchange Rate";
            //     EXIMRoDTEPEntry."LFS Claim Amount" := EXIMRoDTEPEntry."LFS RoDTEP Rebate Value FCY" * EXIMRoDTEPEntry."LFS Exchange Rate";
            // end
            // else begin
            //     EXIMRoDTEPEntry."LFS RoDTEP Rebate Value FCY" := RodtepRate / 100 * SalesInvLine."LFS FOB in USD";
            //     EXIMRoDTEPEntry."LFS RoDTEP Rebate Value LCY" := EXIMRoDTEPEntry."LFS RoDTEP Rebate Value FCY" * SalesInvLine."LFS FOB Currency Exchange Rate";
            //     EXIMRoDTEPEntry."LFS Claim Amount" := EXIMRoDTEPEntry."LFS RoDTEP Rebate Value FCY" * SalesInvLine."LFS FOB Currency Exchange Rate";
            // end;
            EXIMRoDTEPEntry.Insert();
        end;
    end;
    //

    // procedure LFS InsertRoDTEPEntryFromExportPostedSalesCrNoteDoc(TableRecID: RecordID; TableRecIDHdr: RecordID; RodtepSetup: Record "LFS EXIM RoDTEP Rate Setup")
    // var
    //     SalesDocRef: RecordRef;
    //     EXIMRoDTEPEntry: Record "LFS EXIM RoDTEP Rebate Entry";
    //     EntryNo: Integer;
    //     EXIMRoDTEPRateSetup: Record "LFS EXIM RoDTEP Rate Setup";
    //     SalesHdrDocRef: RecordRef;
    //     CountryRegion: Record "Country/Region";
    //     CountryRegionCode: Code[20];
    //     SalesLine: Record "Sales Line";
    //     RodtepRate: Decimal;
    //     EXIMSetup: Record "LFS EXIM Setup";
    //     Qty: Decimal;
    // begin
    //     EXIMSetup.GET;
    //     SalesDocRef.OPEN(TableRecID.TABLENO);
    //     SalesDocRef.GET(TableRecID);

    //     SalesHdrDocRef.OPEN(TableRecIDHdr.TABLENO);
    //     SalesHdrDocRef.GET(TableRecIDHdr);

    //     EXIMRoDTEPEntry.Reset();
    //     if EXIMRoDTEPEntry.FindLast() then
    //         EntryNo := EXIMRoDTEPEntry."LFS Entry No.";
    //     EntryNo += 1;
    //     EXIMRoDTEPEntry.Init();
    //     EXIMRoDTEPEntry."LFS Entry No." := EntryNo;
    //     if TableRecID.TABLENO = 113 then
    //         EXIMRoDTEPEntry."LFS Document Type" := EXIMRoDTEPEntry."LFS Document Type"::"Posted Sales Invoice"
    //     else
    //         if TableRecID.TABLENO = 115 then
    //             EXIMRoDTEPEntry."LFS Document Type" := EXIMRoDTEPEntry."LFS Document Type"::"Posted Sales Cr. Memo";
    //     EXIMRoDTEPEntry."LFS Document No." := SalesDocRef.FIELD(3).VALUE;
    //     EXIMRoDTEPEntry."LFS Document Line No." := SalesDocRef.Field(4).Value;
    //     EXIMRoDTEPEntry."LFS Posting Date" := SalesDocRef.FIELD(131).VALUE;
    //     EXIMRoDTEPEntry ."LFS Type" := SalesDocRef.FIELD(5).VALUE;
    //     EXIMRoDTEPEntry."LFS No." := SalesDocRef.FIELD(6).VALUE;
    //     EXIMRoDTEPEntry."LFS Description":= SalesDocRef.FIELD(11).VALUE;
    //     EXIMRoDTEPEntry."LFS Unit of Measure" := SalesDocRef.FIELD(13).VALUE;
    //     qty := SalesDocRef.FIELD(15).VALUE;
    //     EXIMRoDTEPEntry.LFS Quantity := -qty;
    //     EXIMRoDTEPEntry.LFS Rate := SalesDocRef.FIELD(22).VALUE;
    //     EXIMRoDTEPEntry."LFS FCY Amount" := SalesDocRef.FIELD(103).VALUE;
    //     EXIMRoDTEPEntry."LFS Exchange Rate" := SalesDocRef.FIELD(70128).VALUE;
    //     EXIMRoDTEPEntry."LFS Custom Exchange Rate" := SalesDocRef.FIELD(70129).VALUE;
    //     if EXIMRoDTEPEntry."LFS Exchange Rate" <> 0 then
    //         EXIMRoDTEPEntry."LFS LCY Amount" := EXIMRoDTEPEntry."LFS FCY Amount" * EXIMRoDTEPEntry."LFS Exchange Rate";
    //     EXIMRoDTEPEntry."LFS EXIM Type" := SalesDocRef.FIELD(70106).VALUE;
    //     EXIMRoDTEPEntry."LFS Incentive Type" := SalesDocRef.FIELD(70107).VALUE;
    //     EXIMRoDTEPEntry."LFS FOB Amount (FCY)" := SalesDocRef.FIELD(70110).value;
    //     EXIMRoDTEPEntry."LFS CIF Amount (FCY)" := SalesDocRef.FIELD(70111).VALUE;
    //     EXIMRoDTEPEntry."LFS No. of Container" := SalesDocRef.FIELD(70112).VALUE;
    //     if RodtepSetup."LFS RoDTEP Rebate Rate %" <> 0 then
    //         EXIMRoDTEPEntry."LFS RoDTEP Rebate Rate %" := RodtepSetup."LFS RoDTEP Rebate Rate %"
    //     else begin
    //         EXIMSetup.Get();
    //         EXIMRoDTEPEntry."LFS RoDTEP Rebate Rate %" := EXIMSetup."LFS RoDTEP %";
    //     end;
    //     RodtepRate := EXIMRoDTEPEntry."LFS RoDTEP Rebate Rate %";
    //     EXIMRoDTEPEntry."LFS RoDTEP Rebate Value FCY" := RodtepRate / 100 * EXIMRoDTEPEntry."LFS FCY Amount";
    //     EXIMRoDTEPEntry."LFS RoDTEP Rebate Value LCY" := EXIMRoDTEPEntry."LFS RoDTEP Rebate Value FCY" * EXIMRoDTEPEntry."LFS Exchange Rate";
    //     EXIMRoDTEPEntry."LFS Claim Amount" := EXIMRoDTEPEntry."LFS RoDTEP Rebate Value FCY" * EXIMRoDTEPEntry."LFS Exchange Rate";
    //     EXIMRoDTEPEntry.Insert();
    // end;
    //New
    procedure "LFS InsertRoDTEPEntryFromExportPostedSalesCrNoteDoc"(SalesCrMemoLine: Record "Sales Cr.Memo Line"; SalesCrMemoHdr: Record "Sales Cr.Memo Header"; RodtepSetup: Record "LFS EXIM RoDTEP Rate Setup")
    var
        EXIMRoDTEPEntry: Record "LFS EXIM RoDTEP Rebate Entry";
        EXIMSetupL: Record "LFS EXIM Setup";
        Qty: Decimal;
        // RodtepRate: Decimal;
        EntryNo: Integer;
    begin
        EXIMSetupL.Get();
        if SalesCrMemoLine."LFS RoDTEP Rebate Value" <> 0 then begin

            EXIMRoDTEPEntry.Reset();
            if EXIMRoDTEPEntry.FindLast() then
                EntryNo := EXIMRoDTEPEntry."LFS Entry No.";
            EntryNo += 1;
            EXIMRoDTEPEntry.Init();
            EXIMRoDTEPEntry."LFS Entry No." := EntryNo;
            EXIMRoDTEPEntry."LFS Document Type" := EXIMRoDTEPEntry."LFS Document Type"::"Posted Sales Cr. Memo";
            EXIMRoDTEPEntry."LFS Document No." := SalesCrMemoLine."Document No.";
            EXIMRoDTEPEntry."LFS Document Line No." := SalesCrMemoLine."Line No.";
            EXIMRoDTEPEntry."LFS Posting Date" := SalesCrMemoLine."Posting Date";
            EXIMRoDTEPEntry."LFS Type" := SalesCrMemoLine.Type;
            EXIMRoDTEPEntry."LFS No." := SalesCrMemoLine."No.";
            EXIMRoDTEPEntry."LFS Description" := SalesCrMemoLine.Description;
            EXIMRoDTEPEntry."LFS HSN No." := SalesCrMemoLine."HSN/SAC Code";
            EXIMRoDTEPEntry."LFS Unit of Measure" := SalesCrMemoLine."Unit of Measure Code";
            qty := SalesCrMemoLine.Quantity;
            EXIMRoDTEPEntry."LFS Quantity" := -qty;
            EXIMRoDTEPEntry."LFS Rate" := SalesCrMemoLine."Unit Price";
            EXIMRoDTEPEntry."LFS FCY Amount" := -SalesCrMemoLine."LFS FOB Amount (FCY)";

            EXIMRoDTEPEntry."LFS CIF Value (FCY)" := -SalesCrMemoLine."LFS CIF Value (FCY)";
            EXIMRoDTEPEntry."LFS CIF Value (LCY)" := -SalesCrMemoLine."LFS CIF Value (LCY)";
            EXIMRoDTEPEntry."LFS CIF Amount (FCY)" := SalesCrMemoLine."LFS CIF Amount (FCY)";
            EXIMRoDTEPEntry."LFS Freight Value (FCY)" := -SalesCrMemoLine."LFS Freight Value (FCY)";
            EXIMRoDTEPEntry."LFS Freight Value (LCY)" := -SalesCrMemoLine."LFS Freight Value (LCY)";
            EXIMRoDTEPEntry."LFS Insurance Value (FCY)" := -SalesCrMemoLine."LFS Insurance Value (FCY)";
            EXIMRoDTEPEntry."LFS Insurance Value (LCY)" := -SalesCrMemoLine."LFS Insurance Value (LCY)";
            EXIMRoDTEPEntry."LFS Exchange Rate" := SalesCrMemoLine."LFS Custom Exch. Rate";
            EXIMRoDTEPEntry."LFS Custom Exchange Rate" := SalesCrMemoLine."LFS Custom Exch. Rate";
            EXIMRoDTEPEntry."LFS LCY Amount" := -SalesCrMemoLine."LFS FOB Amount (LCY)";
            EXIMRoDTEPEntry."LFS EXIM Type" := SalesCrMemoLine."LFS EXIM Type";
            EXIMRoDTEPEntry."LFS Incentive Type" := SalesCrMemoLine."LFS Incentive Type";
            EXIMRoDTEPEntry."LFS FOB Amount (FCY)" := -SalesCrMemoLine."LFS FOB Amount (FCY)";
            EXIMRoDTEPEntry."LFS CIF Amount (FCY)" := -SalesCrMemoLine."LFS CIF Amount (FCY)";
            EXIMRoDTEPEntry."LFS No. of Container" := -SalesCrMemoLine."LFS No. of Container";
            // if RodtepSetup."LFS RoDTEP Rebate Rate %" <> 0 then
            //     EXIMRoDTEPEntry."LFS RoDTEP Rebate Rate %" := RodtepSetup."LFS RoDTEP Rebate Rate %"
            // else begin
            //     EXIMSetupL.Get();
            //     EXIMRoDTEPEntry."LFS RoDTEP Rebate Rate %" := EXIMSetupL."LFS RoDTEP %";
            // end;
            // RodtepRate := EXIMRoDTEPEntry."LFS RoDTEP Rebate Rate %";
            // if EXIMRoDTEPEntry."LFS Exchange Rate" <> 0 then begin
            //     EXIMRoDTEPEntry."LFS RoDTEP Rebate Value FCY" := -RodtepRate / 100 * EXIMRoDTEPEntry."LFS FCY Amount";
            //     EXIMRoDTEPEntry."LFS RoDTEP Rebate Value LCY" := EXIMRoDTEPEntry."LFS RoDTEP Rebate Value FCY" * EXIMRoDTEPEntry."LFS Exchange Rate";
            //     EXIMRoDTEPEntry."LFS Claim Amount" := EXIMRoDTEPEntry."LFS RoDTEP Rebate Value FCY" * EXIMRoDTEPEntry."LFS Exchange Rate";
            // end
            // else begin
            //     EXIMRoDTEPEntry."LFS RoDTEP Rebate Value FCY" := -RodtepRate / 100 * SalesCrMemoLine."LFS FOB in USD";
            //     EXIMRoDTEPEntry."LFS RoDTEP Rebate Value LCY" := EXIMRoDTEPEntry."LFS RoDTEP Rebate Value FCY" * SalesCrMemoLine."LFS FOB Currency Exchange Rate";
            //     EXIMRoDTEPEntry."LFS Claim Amount" := EXIMRoDTEPEntry."LFS RoDTEP Rebate Value FCY" * SalesCrMemoLine."LFS FOB Currency Exchange Rate";
            // end;
            EXIMRoDTEPEntry."LFS RoDTEP Rebate Rate %" := SalesCrMemoLine."LFS RoDTEP Rebate Rate %";
            EXIMRoDTEPEntry."LFS RoDTEP Rebate Value LCY" := SalesCrMemoLine."LFS RoDTEP Rebate Value";
            if SalesCrMemoLine."LFS Custom Exch. Rate" <> 0 then
                EXIMRoDTEPEntry."LFS RoDTEP Rebate Value FCY" := SalesCrMemoLine."LFS RoDTEP Rebate Value" / SalesCrMemoLine."LFS Custom Exch. Rate"
            else
                EXIMRoDTEPEntry."LFS RoDTEP Rebate Value FCY" := SalesCrMemoLine."LFS RoDTEP Rebate Value";
            EXIMRoDTEPEntry."LFS Claim Amount" := SalesCrMemoLine."LFS RoDTEP Rebate Value";
            EXIMRoDTEPEntry.Insert();
        end;
    end;


    procedure "LFS InsertLicenseDtlFromImportPostedPurchInvDoc"(PurchInvLine: Record "Purch. Inv. Line"; PurchInvHeader: record "Purch. Inv. Header")
    begin
        if (PurchInvLine."LFS EXIM Type" <> PurchInvLine."LFS EXIM Type"::Import) then
            EXIT;
        "LFS InsertLicenseDtlFromImportPostedPurchInvDocToAdvLicense"(PurchInvLine);
    end;

    // procedure LFS InsertLicenseDtlFromExportPostedSalesInvDoc(SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: record "Sales Invoice Header")
    // begin
    //     if (PurchInvLine."LFS EXIM Type" <> PurchInvLine."LFS EXIM Type"::Import) then
    //         EXIT;
    //     LFS InsertLicenseDtlFromImportPostedPurchInvDocToAdvLicense(PurchInvLine);
    // end;


    local procedure "LFS InsertLicenseDtlFromImportPostedPurchInvDocToAdvLicense"(PurchInvLine: Record "Purch. Inv. Line")
    var
        EXIMAdvLicenseHeader: Record "LFS EXIM License Header";
        EXIMAdvLicenseLines: Record "LFS EXIM License Lines";
        EXIMLicenseMultiple: Record "LFS EXIM Posted Import Licence";
        rodtepLicenseHeader: Record "LFS Rodtep License Header";
        RodtepLicenseLines: Record "LFS Rodtep License Lines";
        PurchInvHeader: Record "Purch. Inv. Header";
        LineNo: Integer;
        RoDTEPLineNo: Integer;
    begin
        EXIMAdvLicenseLines.Init();
        EXIMLicenseMultiple.SetRange("LFS Source No.", PurchInvLine."Document No.");
        EXIMLicenseMultiple.SetRange("LFS Source line No.", PurchInvLine."Line No.");
        EXIMLicenseMultiple.SetRange("LFS License Type", EXIMLicenseMultiple."LFS License Type"::"Adv. License");
        if EXIMLicenseMultiple.Findset() then
            repeat
                EXIMAdvLicenseHeader.SetRange("LFS No.", EXIMLicenseMultiple."LFS License No.");
                if EXIMAdvLicenseHeader.FindFirst() then begin
                    LineNo := 0;
                    EXIMAdvLicenseLines.SETRANGE(EXIMAdvLicenseLines."LFS Adv. License No.", EXIMAdvLicenseHeader."LFS No.");
                    EXIMAdvLicenseLines.SetCurrentKey("LFS Line No.");
                    if EXIMAdvLicenseLines.FindLast() then
                        LineNo := EXIMAdvLicenseLines."LFS Line No." + 10000
                    else
                        LineNo := 10000;

                    EXIMAdvLicenseLines."LFS Adv. License No." := EXIMLicenseMultiple."LFS License No.";
                    EXIMAdvLicenseLines."LFS Line No." := LineNo;
                    EXIMAdvLicenseLines."LFS Qty." := -EXIMLicenseMultiple."LFS Quantity";
                    EXIMAdvLicenseLines."LFS CIF Value" := -EXIMLicenseMultiple."LFS CIF Value (FCY)";
                    EXIMAdvLicenseLines."LFS FOB Value" := 0;
                    EXIMAdvLicenseLines."LFS Type" := EXIMAdvLicenseLines."LFS Type"::Import;
                    EXIMAdvLicenseLines."LFS IsImport" := true;
                    EXIMAdvLicenseLines."LFS Isexport" := false;
                    EXIMAdvLicenseLines."LFS Document Type" := EXIMAdvLicenseLines."LFS Document Type"::"Posted Invoice";
                    EXIMAdvLicenseLines."LFS Document No." := EXIMLicenseMultiple."LFS Source No.";
                    EXIMAdvLicenseLines."LFS Document Line No." := EXIMLicenseMultiple."LFS Source line No.";
                    EXIMAdvLicenseLines.VALIDATE("LFS Item No.", EXIMLicenseMultiple."LFS Item No.");
                    EXIMAdvLicenseLines.Validate("LFS Item Description", PurchInvLine.Description);
                    EXIMAdvLicenseLines.Validate("LFS Variant Code", EXIMLicenseMultiple."LFS Variant Code");
                    EXIMAdvLicenseLines."LFS UOM" := PurchInvLine."Unit of Measure Code";
                    EXIMAdvLicenseLines."LFS Currency Code" := PurchInvHeader."Currency Code";
                    EXIMAdvLicenseLines."LFS FOB CIF Currency Code" := PurchInvLine."LFS CIF Currency Code";
                    EXIMAdvLicenseLines."LFS FOBCIFCurrencyExchangeRate" := PurchInvLine."LFS CIF Currency Exchange Rate";
                    EXIMAdvLicenseLines."LFS Currency Exch. Rate" := PurchInvLine."LFS Custom Exch. Rate";
                    EXIMAdvLicenseLines."LFS CIF LCY Value" := EXIMAdvLicenseLines."LFS CIF Value" * EXIMAdvLicenseLines."LFS FOBCIFCurrencyExchangeRate";

                    // EXIMAdvLicenseLines."LFS FOB CIF in USD" := -PurchInvLine."LFS USD CIF (FCY)";
                    EXIMAdvLicenseLines."LFS FOB LCY Value" := EXIMAdvLicenseLines."LFS FOB Value" * EXIMAdvLicenseLines."LFS Currency Exch. Rate";
                    EXIMAdvLicenseLines."LFS Exim Group No." := PurchInvLine."LFS Exim Group No.";
                    PurchInvHeader.GET(PurchInvLine."Document No.");
                    EXIMAdvLicenseLines.insert();
                end;
            until EXIMLicenseMultiple.Next() = 0;
        RodtepLicenseLines.Init();
        EXIMLicenseMultiple.Reset();
        EXIMLicenseMultiple.SetRange("LFS Source No.", PurchInvLine."Document No.");
        EXIMLicenseMultiple.SetRange("LFS Source line No.", PurchInvLine."Line No.");
        EXIMLicenseMultiple.SetRange("LFS License Type", EXIMLicenseMultiple."LFS License Type"::RoDTEP);
        if EXIMLicenseMultiple.Findset() then
            repeat
                rodtepLicenseHeader.SetRange("LFS No.", EXIMLicenseMultiple."LFS License No.");
                if rodtepLicenseHeader.FindFirst() then begin
                    RoDTEPLineNo := 0;
                    RodtepLicenseLines.SETRANGE(RodtepLicenseLines."LFS License No.", rodtepLicenseHeader."LFS No.");
                    RodtepLicenseLines.SetCurrentKey("LFS Line No.");
                    if RodtepLicenseLines.FindLast() then
                        RoDTEPLineNo := RodtepLicenseLines."LFS Line No." + 10000
                    else
                        RoDTEPLineNo := 10000;

                    RodtepLicenseLines."LFS License No." := EXIMLicenseMultiple."LFS License No.";
                    RodtepLicenseLines."LFS Line No." := RoDTEPLineNo;
                    RodtepLicenseLines."LFS Type" := RodtepLicenseLines."LFS type"::Import;
                    RodtepLicenseLines."LFS Entry Type" := RodtepLicenseLines."LFS Entry Type"::Utilization;
                    RodtepLicenseLines."LFS Document Type" := RodtepLicenseLines."LFS Document Type"::"Posted Invoice";
                    RodtepLicenseLines."LFS Document No." := EXIMLicenseMultiple."LFS Source No.";
                    RodtepLicenseLines."LFS Document Line No." := EXIMLicenseMultiple."LFS Source line No.";
                    RodtepLicenseLines."LFS Item No." := EXIMLicenseMultiple."LFS Item No.";
                    RodtepLicenseLines."LFS Variant Code" := EXIMLicenseMultiple."LFS Variant Code";
                    RodtepLicenseLines."LFS Description" := PurchInvLine.Description;
                    RodtepLicenseLines."LFS UOM" := Format(PurchInvLine."Unit of Measure");
                    RodtepLicenseLines."LFS Qty." := PurchInvLine.Quantity;
                    RodtepLicenseLines."LFS CIF Value(FC)" := PurchInvLine."LFS CIF Amount (FCY)";
                    RodtepLicenseLines."LFS CIF Value (LCY)" := PurchInvLine."LFS CIF Amount (FCY)" * PurchInvLine."LFS Custom Exch. Rate";
                    RodtepLicenseLines."LFS RoDTEP Value (LCY)" := EXIMLicenseMultiple."LFS RoDTEP Consump Value";
                    RodtepLicenseLines.Insert();
                end;
            until EXIMLicenseMultiple.Next() = 0;
    end;


    // procedure "LFS InsertRodtepLicenseLines"(PurchInvLine: Record "Purch. Inv. Line"; PurchInvHeader: record "Purch. Inv. Header")
    // begin
    //     if (PurchInvLine."LFS EXIM Type" <> PurchInvLine."LFS EXIM Type"::Import) then
    //         EXIT;
    //     "LFS InsertRodtepLicenseLineDtlsfromPostedPurchInvoice"(PurchInvLine)
    // end;

    // procedure "LFS InsertRodtepLicenseLineDtlsfromPostedPurchInvoice"(PurchInvLine: Record "Purch. Inv. Line")
    // var
    //     rodtepLicenseHeader: Record "LFS Rodtep License Header";
    //     RodtepLicenseLines: Record "LFS Rodtep License Lines";
    //     LineNo: Integer;
    // begin
    //     if PurchInvLine."LFS License Type" = PurchInvLine."LFS License Type"::RoDTEP then begin
    //         rodtepLicenseHeader.SetRange("LFS No.", PurchInvLine."LFS License No.");
    //         if rodtepLicenseHeader.FindFirst() then begin
    //             RodtepLicenseLines.SETRANGE(RodtepLicenseLines."LFS License No.", rodtepLicenseHeader."LFS No.");
    //             RodtepLicenseLines.SetCurrentKey("LFS Line No.");
    //             if RodtepLicenseLines.FindLast() then
    //                 LineNo := RodtepLicenseLines."LFS Line No." + 10000
    //             else
    //                 LineNo := 10000;

    //             RodtepLicenseLines."LFS License No." := PurchInvLine."LFS License No.";
    //             RodtepLicenseLines."LFS Line No." := LineNo;
    //             RodtepLicenseLines."LFS Type" := RodtepLicenseLines."LFS type"::Import;
    //             RodtepLicenseLines."LFS Entry Type" := RodtepLicenseLines."LFS Entry Type"::Utilization;
    //             RodtepLicenseLines."LFS Document Type" := RodtepLicenseLines."LFS Document Type"::"Posted Invoice";
    //             RodtepLicenseLines."LFS Document No." := PurchInvLine."Document No.";
    //             RodtepLicenseLines."LFS Line No." := PurchInvLine."Line No.";
    //             RodtepLicenseLines."LFS Item No." := PurchInvLine."No.";
    //             RodtepLicenseLines."LFS Variant Code" := PurchInvLine."Variant Code";
    //             RodtepLicenseLines."LFS Description" := PurchInvLine.Description;
    //             RodtepLicenseLines."LFS UOM" := Format(PurchInvLine."Unit of Measure");
    //             RodtepLicenseLines."LFS Qty." := PurchInvLine.Quantity;
    //             RodtepLicenseLines."LFS CIF Value(FC)" := PurchInvLine."LFS CIF Amount (FCY)";
    //             RodtepLicenseLines."LFS CIF Value (LCY)" := PurchInvLine."LFS CIF Amount (FCY)" * PurchInvLine."LFS Custom Exch. Rate";
    //             RodtepLicenseLines."LFS RoDTEP Value (LCY)" := PurchInvLine."LFS RoDTEP Value (LCY)";
    //             RodtepLicenseLines.Insert();
    //         end;
    //     end;
    // end;

    procedure "LFS InsertLicenseDtlFromImportPostedPurchCrNoteDoc"(PurchCrMemoLine: Record "Purch. Cr. Memo Line")
    begin
        if (PurchCrMemoLine."LFS EXIM Type" <> PurchCrMemoLine."LFS EXIM Type"::Import) then
            EXIT;
        "LFS InsertLicenseDtlFromImportPostedPurchCrNoteDocToAdvLicense"(PurchCrMemoLine);
    end;

    local procedure "LFS InsertLicenseDtlFromImportPostedPurchCrNoteDocToAdvLicense"(PurchCrMemoLine: Record "Purch. Cr. Memo Line")
    var
        EXIMAdvLicenseHeader: Record "LFS EXIM License Header";
        EXIMAdvLicenseLines: Record "LFS EXIM License Lines";
        EXIMLicenseMultiple: Record "LFS EXIM Posted Import Licence";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        rodtepLicenseHeader: Record "LFS Rodtep License Header";
        RodtepLicenseLines: Record "LFS Rodtep License Lines";
        LineNo: Integer;
        RoDTEPLineNo: Integer;
    begin
        EXIMAdvLicenseLines.Init();
        EXIMLicenseMultiple.SetRange("LFS Source No.", PurchCrMemoLine."Document No.");
        EXIMLicenseMultiple.SetRange("LFS Source line No.", PurchCrMemoLine."Line No.");
        if EXIMLicenseMultiple.Findset() then
            repeat
                EXIMAdvLicenseHeader.SetRange("LFS No.", EXIMLicenseMultiple."LFS License No.");
                if EXIMAdvLicenseHeader.FindFirst() then begin
                    EXIMAdvLicenseLines.SETRANGE(EXIMAdvLicenseLines."LFS Adv. License No.", EXIMAdvLicenseHeader."LFS No.");
                    EXIMAdvLicenseLines.SetCurrentKey("LFS Line No.");
                    if EXIMAdvLicenseLines.FindLast() then
                        LineNo := EXIMAdvLicenseLines."LFS Line No." + 10000
                    else
                        LineNo := 10000;

                    EXIMAdvLicenseLines."LFS Adv. License No." := EXIMLicenseMultiple."LFS License No.";
                    EXIMAdvLicenseLines."LFS Line No." := LineNo;

                    EXIMAdvLicenseLines."LFS Qty." := EXIMLicenseMultiple."LFS Quantity";
                    EXIMAdvLicenseLines."LFS FOB Value" := 0;
                    EXIMAdvLicenseLines."LFS CIF Value" := EXIMLicenseMultiple."LFS CIF Value (FCY)";
                    EXIMAdvLicenseLines."LFS Type" := EXIMAdvLicenseLines."LFS Type"::Import;
                    EXIMAdvLicenseLines."LFS IsImport" := true;
                    EXIMAdvLicenseLines."LFS Isexport" := false;
                    EXIMAdvLicenseLines."LFS Document Type" := EXIMAdvLicenseLines."LFS Document Type"::"Credit Memo";
                    EXIMAdvLicenseLines."LFS Document No." := EXIMLicenseMultiple."LFS Source No.";
                    EXIMAdvLicenseLines."LFS Document Line No." := EXIMLicenseMultiple."LFS Source line No.";
                    EXIMAdvLicenseLines.VALIDATE("LFS Item No.", EXIMLicenseMultiple."LFS Item No.");
                    EXIMAdvLicenseLines.Validate("LFS Variant Code", EXIMLicenseMultiple."LFS Variant Code");
                    EXIMAdvLicenseLines.Validate("LFS Item Description", PurchCrMemoLine.Description);
                    EXIMAdvLicenseLines."LFS UOM" := PurchCrMemoLine."Unit of Measure Code";
                    EXIMAdvLicenseLines."LFS FOB CIF Currency Code" := PurchCrMemoLine."LFS CIF Currency Code";
                    EXIMAdvLicenseLines."LFS FOBCIFCurrencyExchangeRate" := PurchCrMemoLine."LFS CIF Currency Exchange Rate";
                    EXIMAdvLicenseLines."LFS Currency Exch. Rate" := PurchCrMemoLine."LFS Custom Exch. Rate";
                    EXIMAdvLicenseLines."LFS FOB LCY Value" := EXIMAdvLicenseLines."LFS FOB Value" * EXIMAdvLicenseLines."LFS Currency Exch. Rate";
                    EXIMAdvLicenseLines."LFS CIF LCY Value" := EXIMAdvLicenseLines."LFS CIF Value" * EXIMAdvLicenseLines."LFS FOBCIFCurrencyExchangeRate";

                    // EXIMAdvLicenseLines."LFS FOB CIF in USD" := PurchCrMemoLine."LFS USD CIF (FCY)";
                    PurchCrMemoHdr.GET(PurchCrMemoLine."Document No.");
                    EXIMAdvLicenseLines."LFS Currency Code" := PurchCrMemoHdr."Currency Code";
                    EXIMAdvLicenseLines.insert();
                end;
            until EXIMLicenseMultiple.Next() = 0;

        RodtepLicenseLines.Init();
        EXIMLicenseMultiple.Reset();
        EXIMLicenseMultiple.SetRange("LFS Source No.", PurchCrMemoLine."Document No.");
        EXIMLicenseMultiple.SetRange("LFS Source line No.", PurchCrMemoLine."Line No.");
        EXIMLicenseMultiple.SetRange("LFS License Type", EXIMLicenseMultiple."LFS License Type"::RoDTEP);
        if EXIMLicenseMultiple.Findset() then
            repeat
                rodtepLicenseHeader.SetRange("LFS No.", EXIMLicenseMultiple."LFS License No.");
                if rodtepLicenseHeader.FindFirst() then begin
                    RoDTEPLineNo := 0;
                    RodtepLicenseLines.SETRANGE(RodtepLicenseLines."LFS License No.", rodtepLicenseHeader."LFS No.");
                    RodtepLicenseLines.SetCurrentKey("LFS Line No.");
                    if RodtepLicenseLines.FindLast() then
                        RoDTEPLineNo := RodtepLicenseLines."LFS Line No." + 10000
                    else
                        RoDTEPLineNo := 10000;

                    RodtepLicenseLines."LFS License No." := EXIMLicenseMultiple."LFS License No.";
                    RodtepLicenseLines."LFS Line No." := RoDTEPLineNo;
                    RodtepLicenseLines."LFS Type" := RodtepLicenseLines."LFS type"::Import;
                    RodtepLicenseLines."LFS Entry Type" := RodtepLicenseLines."LFS Entry Type"::Utilization;
                    RodtepLicenseLines."LFS Document Type" := RodtepLicenseLines."LFS Document Type"::"Posted Credit Memo";
                    RodtepLicenseLines."LFS Document No." := EXIMLicenseMultiple."LFS Source No.";
                    RodtepLicenseLines."LFS Document Line No." := EXIMLicenseMultiple."LFS Source line No.";
                    RodtepLicenseLines."LFS Item No." := EXIMLicenseMultiple."LFS Item No.";
                    RodtepLicenseLines."LFS Variant Code" := EXIMLicenseMultiple."LFS Variant Code";
                    RodtepLicenseLines."LFS Description" := PurchCrMemoLine.Description;
                    RodtepLicenseLines."LFS UOM" := Format(PurchCrMemoLine."Unit of Measure");
                    RodtepLicenseLines."LFS Qty." := -PurchCrMemoLine.Quantity;
                    RodtepLicenseLines."LFS CIF Value(FC)" := -PurchCrMemoLine."LFS CIF Amount (FCY)";
                    RodtepLicenseLines."LFS CIF Value (LCY)" := -PurchCrMemoLine."LFS CIF Amount (FCY)" * PurchCrMemoLine."LFS Custom Exch. Rate";
                    RodtepLicenseLines."LFS RoDTEP Value (LCY)" := -EXIMLicenseMultiple."LFS RoDTEP Consump Value";
                    RodtepLicenseLines.Insert();
                end;
            until EXIMLicenseMultiple.Next() = 0;
    end;

    procedure "LFS UpdateCustExhRateSales"(Var Rec: Record "Sales Line")
    var
        RecEXIMCustCurr: Record "LFSEXIM Currency Exchange Rate";
        RecSalesHeader: record "Sales Header";
    begin
        RecSalesHeader.SetRange("No.", Rec."Document No.");
        if RecSalesHeader.FindFirst() then begin
            RecEXIMCustCurr.Reset();
            RecEXIMCustCurr.SetRange("LFS Currency Code", RecSalesHeader."Currency Code");
            RecEXIMCustCurr.SetRange("LFS Starting Date", 0D, RecSalesHeader."Posting Date");
            if RecEXIMCustCurr.FindLast() then
                if Rec."LFS EXIM Type" = Rec."LFS EXIM Type"::Export then
                    Rec.Validate("LFS Custom Exch. Rate", RecEXIMCustCurr."LFS Exch Rate Amount (Exp)" / RecSalesHeader."Currency Factor");
        end;
    end;

    procedure "LFS UpdateCustExhRatePurchase"(Var Rec: Record "Purchase Line")
    var
        RecEXIMCustCurr: Record "LFSEXIM Currency Exchange Rate";
        RecPurchaseHeader: record "Purchase Header";
    begin
        RecPurchaseHeader.SetRange("No.", Rec."Document No.");
        if RecPurchaseHeader.FindFirst() then begin
            RecEXIMCustCurr.Reset();
            RecEXIMCustCurr.SetRange("LFS Currency Code", RecPurchaseHeader."Currency Code");
            RecEXIMCustCurr.SetRange("LFS Starting Date", 0D, RecPurchaseHeader."Posting Date");
            if RecEXIMCustCurr.FindLast() then
                if Rec."LFS EXIM Type" = Rec."LFS EXIM Type"::Import then
                    Rec.Validate("LFS Custom Exch. Rate", RecEXIMCustCurr."LFS Exch Rate Amount (IMp)" / RecPurchaseHeader."Currency Factor");
        end;
    end;

    procedure "LFS CreateFromSalesOrder"(SalesHeader: Record "Sales Header")
    begin
        "LFS ShowResult"("LFS CreateFromSalesOrderHideDialog"(SalesHeader));
    end;

    local procedure "LFS ShowResult"(WhseShipmentCreated: Boolean)
    var
        WarehouseRequest: Record "Warehouse Request";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeShowResult(WhseShipmentCreated, IsHandled, GetSourceDocuments);
        if IsHandled then
            exit;

        if WhseShipmentCreated then begin
            GetSourceDocuments.ShowShipmentDialogEXIM();
            "LFS OpenWarehouseShipmentPage"();
        end else
            Message(Text004Lbl, WarehouseRequest.TableCaption());
    end;

    local procedure "LFS OpenWarehouseShipmentPage"()
    var
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOpenWarehouseShipmentPage(GetSourceDocuments, IsHandled);
        if IsHandled then
            exit;

        GetSourceDocuments.GetLastShptHeader(WarehouseShipmentHeader);
        PAGE.Run(PAGE::"LFS Export Warehouse Shipment", WarehouseShipmentHeader);
    end;

    procedure "LFS CreateFromSalesOrderHideDialog"(SalesHeader: Record "Sales Header"): Boolean
    var
        WhseRqst: Record "Warehouse Request";
    begin
        if not SalesHeader.IsApprovedForPosting() then
            exit(false);

        "LFS FindWarehouseRequestForSalesOrder"(WhseRqst, SalesHeader);

        if WhseRqst.IsEmpty() then
            exit(false);

        "LFS CreateWhseShipmentHeaderFromWhseRequest"(WhseRqst);
        exit(true);
    end;

    local procedure "LFS CreateWhseShipmentHeaderFromWhseRequest"(var WarehouseRequest: Record "Warehouse Request") Result: Boolean
    var
        WhseShptHeader: Record "Warehouse Shipment Header";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCreateWhseShipmentHeaderFromWhseRequest(WarehouseRequest, Result, IsHandled, GetSourceDocuments);
        if IsHandled then
            exit(Result);

        if WarehouseRequest.IsEmpty() then
            exit(false);

        Clear(GetSourceDocuments);
        GetSourceDocuments.UseRequestPage(false);
        GetSourceDocuments.SetTableView(WarehouseRequest);
        GetSourceDocuments.SetHideDialog(true);
        GetSourceDocuments.RunModal();

        GetSourceDocuments.GetLastShptHeader(WhseShptHeader);
        OnAfterCreateWhseShipmentHeaderFromWhseRequest(WarehouseRequest, WhseShptHeader);

        exit(true);
    end;


    local procedure "LFS FindWarehouseRequestForSalesOrder"(var WhseRqst: Record "Warehouse Request"; SalesHeader: Record "Sales Header")
    begin
        SalesHeader.TestField(Status, SalesHeader.Status::Released);
        "LFS CheckWhseShipmentConflict"(SalesHeader);
        "LFS CheckSalesHeader"(SalesHeader, true);
        WhseRqst.SetRange(Type, WhseRqst.Type::Outbound);
        WhseRqst.SetSourceFilter(DATABASE::"Sales Line", SalesHeader."Document Type".AsInteger(), SalesHeader."No.");
        WhseRqst.SetRange("Document Status", WhseRqst."Document Status"::Released);
        OnFindWarehouseRequestForSalesOrderOnAfterWhseRqstSetFilters(WhseRqst, SalesHeader);
        "LFS GetRequireShipRqst"(WhseRqst);

        OnAfterFindWarehouseRequestForSalesOrder(WhseRqst, SalesHeader);
    end;

    local procedure "LFS CheckWhseShipmentConflict"(SalesHeader: Record "Sales Header")
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCheckWhseShipmentConflict(SalesHeader, IsHandled);
        if not IsHandled then
            if SalesHeader.WhseShipmentConflict(SalesHeader."Document Type", SalesHeader."No.", SalesHeader."Shipping Advice") then
                Error(Text003Lbl, Format(SalesHeader."Shipping Advice"));
    end;

    local procedure "LFS GetRequireShipRqst"(var WhseRqst: Record "Warehouse Request")
    var
        Location: Record Location;
        IsHandled: Boolean;
        LocationCode: Text;
    begin
        IsHandled := false;
        OnBeforeGetRequireShipRqst(WhseRqst, IsHandled);
        if IsHandled then
            exit;

        if WhseRqst.Findset() then begin
            repeat
                if Location.RequireShipment(WhseRqst."Location Code") then
                    LocationCode += WhseRqst."Location Code" + '|';
            until WhseRqst.Next() = 0;
            if LocationCode <> '' then begin
                LocationCode := CopyStr(LocationCode, 1, StrLen(LocationCode) - 1);
                if LocationCode[1] = '|' then
                    LocationCode := '''''' + LocationCode;
            end;
            WhseRqst.SetFilter("Location Code", LocationCode);
        end;
    end;

    procedure "LFS CheckSalesHeader"(SalesHeader: Record "Sales Header"; ShowError: Boolean) Result: Boolean
    var
        SalesLine: Record "Sales Line";
    begin
        OnBeforeCheckSalesHeader(SalesHeader, ShowError);

        if SalesHeader."Shipping Advice" = SalesHeader."Shipping Advice"::Partial then
            exit(false);

        SalesLine.SetCurrentKey("Document Type", Type, "No.", "Variant Code");
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        OnCheckSalesHeaderOnAfterSetLineFilters(SalesLine, SalesHeader);
        "LFS CheckSalesHeaderMarkSalesLines"(SalesHeader, SalesLine);

        exit("LFS CheckSalesLines"(SalesHeader, SalesLine, ShowError));
    end;

    local procedure "LFS CheckSalesLines"(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; ShowError: Boolean) Result: Boolean
    var
        CurrItemVariant: Record "Item Variant";
        SalesOrder: Page "Sales Order";
        IsHandled: Boolean;
        LocationCode: Code[10];
        QtyOutstandingBase: Decimal;
        RecordNo: Integer;
        TotalNoOfRecords: Integer;
    begin
        IsHandled := false;
        OnBeforeCheckSalesLines(SalesHeader, SalesLine, ShowError, Result, IsHandled);
        if IsHandled then
            exit(Result);

        if SalesLine.Findset() then begin
            LocationCode := SalesLine."Location Code";
            "LFS SetItemVariant"(CurrItemVariant, SalesLine."No.", SalesLine."Variant Code");
            TotalNoOfRecords := SalesLine.Count();
            repeat
                RecordNo += 1;

                if SalesLine."Location Code" <> LocationCode then begin
                    if ShowError then
                        Error(TextErrLbl, SalesHeader.FieldCaption("Shipping Advice"), SalesHeader."Shipping Advice",
                          SalesOrder.Caption, SalesHeader."No.", SalesLine.Type);
                    exit(true);
                end;

                if "LFS EqualItemVariant"(CurrItemVariant, SalesLine."No.", SalesLine."Variant Code") then
                    QtyOutstandingBase += SalesLine."Outstanding Qty. (Base)"
                else begin
                    if "LFS CheckSalesHeaderOnBeforeCheckAvailability"(SalesHeader, SalesLine, ShowError, Result) then
                        exit(Result);

                    if "LFS CheckAvailability"(
                         CurrItemVariant, QtyOutstandingBase, SalesLine."Location Code",
                         SalesOrder.Caption, DATABASE::"Sales Line", SalesHeader."Document Type".AsInteger(), SalesHeader."No.", ShowError)
                    then
                        exit(true);
                    "LFS SetItemVariant"(CurrItemVariant, SalesLine."No.", SalesLine."Variant Code");
                    if "LFS CheckSalesHeaderOnAfterSetItemVariant"(Result) then
                        exit(Result);
                    QtyOutstandingBase := SalesLine."Outstanding Qty. (Base)";
                end;
                if RecordNo = TotalNoOfRecords then begin
                    if "LFS CheckSalesHeaderOnBeforeCheckAvailability"(SalesHeader, SalesLine, ShowError, Result) then
                        exit(Result);

                    if "LFS CheckAvailability"(
                         CurrItemVariant, QtyOutstandingBase, SalesLine."Location Code",
                         SalesOrder.Caption, DATABASE::"Sales Line", SalesHeader."Document Type".AsInteger(), SalesHeader."No.", ShowError)
                    then
                        exit(true);
                end;
            until SalesLine.Next() = 0;
        end;
    end;

    procedure "LFS CheckAvailability"(CurrItemVariant: Record "Item Variant"; QtyBaseNeeded: Decimal; LocationCode: Code[10]; FormCaption: Text; SourceType: Integer; SourceSubType: Integer; SourceID: Code[20]; ShowError: Boolean): Boolean
    var
        Item: Record Item;
        ReservEntry: Record "Reservation Entry";
        ReservEntry2: Record "Reservation Entry";
        IsHandled: Boolean;
        NotAvailable: Boolean;
        Result: Boolean;
        QtyReservedForOrder: Decimal;
        ErrorMessage: Text;
    begin
        IsHandled := false;
        OnBeforeCheckAvailability(
          CurrItemVariant, QtyBaseNeeded, LocationCode, FormCaption, SourceType, SourceSubType, SourceID, ShowError, Result, IsHandled);
        if IsHandled then
            exit(Result);

        Item.Get(CurrItemVariant."Item No.");
        Item.SetRange("Location Filter", LocationCode);
        Item.SetRange("Variant Filter", CurrItemVariant.Code);
        Item.CalcFields(Inventory, "Reserved Qty. on Inventory");
        ReservEntry.SetSourceFilter(SourceType, SourceSubType, SourceID, -1, true);
        ReservEntry.SetRange("Item No.", CurrItemVariant."Item No.");
        ReservEntry.SetRange("Location Code", LocationCode);
        ReservEntry.SetRange("Variant Code", CurrItemVariant.Code);
        ReservEntry.SetRange("Reservation Status", ReservEntry."Reservation Status"::Reservation);
        if ReservEntry.Findset() then
            repeat
                ReservEntry2.Get(ReservEntry."Entry No.", not ReservEntry.Positive);
                QtyReservedForOrder += ReservEntry2."Quantity (Base)";
            until ReservEntry.Next() = 0;

        NotAvailable := Item.Inventory - (Item."Reserved Qty. on Inventory" - QtyReservedForOrder) < QtyBaseNeeded;
        ErrorMessage := StrSubstNo(Text002Lbl, CurrItemVariant."Item No.", LocationCode, FormCaption, SourceID);
        if "LFS AfterCheckAvailability"(NotAvailable, ShowError, ErrorMessage, Result) then
            exit(Result);
    end;

    local procedure "LFS AfterCheckAvailability"(NotAvailable: Boolean; ShowError: Boolean; ErrorMessage: Text; var Result: Boolean) IsHandled: Boolean;
    begin
        OnAfterCheckAvailability(NotAvailable, ShowError, ErrorMessage, Result, IsHandled);
        if IsHandled then
            exit(true);

        if NotAvailable then begin
            if ShowError then
                Error(ErrorMessage);
            exit(true);
        end;
    end;

    local procedure "LFS SetItemVariant"(var CurrItemVariant: Record "Item Variant"; ItemNo: Code[20]; VariantCode: Code[10])
    begin
        CurrItemVariant."Item No." := ItemNo;
        CurrItemVariant.Code := VariantCode;
    end;

    local procedure "LFS EqualItemVariant"(CurrItemVariant: Record "Item Variant"; ItemNo: Code[20]; VariantCode: Code[10]): Boolean
    begin
        exit((CurrItemVariant."Item No." = ItemNo) and (CurrItemVariant.Code = VariantCode));
    end;

    local procedure "LFS CheckSalesHeaderOnAfterSetItemVariant"(var Result: Boolean) IsHandled: Boolean
    begin
        OnCheckSalesHeaderOnAfterSetItemVariant(Result, IsHandled);
    end;

    local procedure "LFS CheckSalesHeaderOnBeforeCheckAvailability"(SalesHeader: Record "Sales Header"; SalesLine: record "Sales Line"; ShowError: Boolean; var Result: Boolean) IsHandled: Boolean
    begin
        OnCheckSalesHeaderOnBeforeCheckAvailability(SalesHeader, SalesLine, ShowError, Result, IsHandled);
    end;

    local procedure "LFS CheckSalesHeaderMarkSalesLines"(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCheckSalesHeaderMarkSalesLines(SalesLine, SalesHeader, IsHandled);
        if IsHandled then
            exit;

        if SalesLine.Findset() then
            repeat
                if SalesLine.IsInventoriableItem() then
                    SalesLine.Mark(true);
            until SalesLine.Next() = 0;
        SalesLine.MarkedOnly(true);
    end;

    procedure "LFS InitTextVariable"()
    begin
        OnesText[1] := OneLbl;
        OnesText[2] := TwoLbl;
        OnesText[3] := ThreeLbl;
        OnesText[4] := FourLbl;
        OnesText[5] := FiveLbl;
        OnesText[6] := SixLbl;
        OnesText[7] := SevenLbl;
        OnesText[8] := EightLbl;
        OnesText[9] := NineLbl;
        OnesText[10] := TenLbl;
        OnesText[11] := ElevenLbl;
        OnesText[12] := TwelveLbl;
        OnesText[13] := ThirteenLbl;
        OnesText[14] := FourteenLbl;
        OnesText[15] := FifteenLbl;
        OnesText[16] := SixteenLbl;
        OnesText[17] := SeventeenLbl;
        OnesText[18] := EighteenLbl;
        OnesText[19] := NinteenLbl;
        TensText[1] := '';
        TensText[2] := TwentyLbl;
        TensText[3] := ThirtyLbl;
        TensText[4] := FortyLbl;
        TensText[5] := FiftyLbl;
        TensText[6] := SixtyLbl;
        TensText[7] := SeventyLbl;
        TensText[8] := EightyLbl;
        TensText[9] := NinetyLbl;
        ExponentText[1] := '';
        ExponentText[2] := ThousandLbl;
        ExponentText[3] := LakhLbl;
        ExponentText[4] := CroreLbl;
    end;

    procedure "LFS FormatNoText"(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var
        CurrRec: Record Currency;
        PrintExponent: Boolean;
        Exponent: Integer;
        Hundreds: Integer;
        NoTextIndex: Integer;
        Ones: Integer;
        OnesDec: Integer;
        Tens: Integer;
        TensDec: Integer;
    begin
        Clear(NoText);
        NoTextIndex := 1;
        if No < 1 then
            "LFS AddToNoText"(NoText, NoTextIndex, PrintExponent, ZeroLbl)
        else
            for Exponent := 4 DOWNTO 1 do begin
                PrintExponent := false;
                if No > 99999 then begin
                    Ones := No DIV (Power(100, Exponent - 1) * 10);
                    Hundreds := 0;
                end else begin
                    Ones := No DIV Power(1000, Exponent - 1);
                    Hundreds := Ones DIV 100;
                end;
                Tens := (Ones MOD 100) DIV 10;
                Ones := Ones MOD 10;
                if Hundreds > 0 then begin
                    "LFS AddToNoText"(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    "LFS AddToNoText"(NoText, NoTextIndex, PrintExponent, HundreadLbl);
                end;
                if Tens >= 2 then begin
                    "LFS AddToNoText"(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    if Ones > 0 then
                        "LFS AddToNoText"(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                end else
                    if (Tens * 10 + Ones) > 0 then
                        "LFS AddToNoText"(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                if PrintExponent and (Exponent > 1) then
                    "LFS AddToNoText"(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                if No > 99999 then
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * Power(100, Exponent - 1) * 10
                else
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * Power(1000, Exponent - 1);
            end;

        if CurrencyCode <> '' then begin
            CurrRec.Get(CurrencyCode);
            "LFS AddToNoText"(NoText, NoTextIndex, PrintExponent, '');
        end else
            "LFS AddToNoText"(NoText, NoTextIndex, PrintExponent, 'RUPEES');

        if No <> 0 then
            "LFS AddToNoText"(NoText, NoTextIndex, PrintExponent, AndLbl);

        TensDec := ((No * 100) MOD 100) DIV 10;
        OnesDec := (No * 100) MOD 10;
        if TensDec >= 2 then begin
            "LFS AddToNoText"(NoText, NoTextIndex, PrintExponent, TensText[TensDec]);
            if OnesDec > 0 then
                "LFS AddToNoText"(NoText, NoTextIndex, PrintExponent, OnesText[OnesDec]);
        end else
            if (TensDec * 10 + OnesDec) > 0 then
                "LFS AddToNoText"(NoText, NoTextIndex, PrintExponent, OnesText[TensDec * 10 + OnesDec]);
        if No > 0 then begin
            if (CurrencyCode <> '') then
                "LFS AddToNoText"(NoText, NoTextIndex, PrintExponent, 'ONLY')
            else
                "LFS AddToNoText"(NoText, NoTextIndex, PrintExponent, 'PAISA ONLY');
        end
        else
            "LFS AddToNoText"(NoText, NoTextIndex, PrintExponent, 'ONLY')

    end;

    local procedure "LFS AddToNoText"(
          var NoText: array[2] of Text[80];
          var NoTextIndex: Integer;
          var PrintExponent: Boolean;
          AddText: Text[30])
    begin
        PrintExponent := true;

        while StrLen(NoText[NoTextIndex] + ' ' + AddText) > MaxStrLen(NoText[1]) do begin
            NoTextIndex := NoTextIndex + 1;
            if NoTextIndex > ArrayLen(NoText) then
                Error(exceededStringErr, AddText);
        end;

        NoText[NoTextIndex] := CopyStr(DelChr(NoText[NoTextIndex] + ' ' + AddText, '<'), 1, 80);
    end;

    procedure "LFS InsertRodtepLicenseLinesSalesInv"(SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header")
    begin
        if (SalesInvLine."LFS EXIM Type" <> SalesInvLine."LFS EXIM Type"::Export) then
            EXIT;
        // LFS InsertRodtepLicenseLineDtlsfromPostedSalesInvoice(SalesInvLine)
    end;


    // procedure LFS InsertRodtepLicenseLineDtlsfromPostedSalesInvoice(SalesInvLine: Record "Sales Invoice Line")
    // var
    //     EXIMLicenseMultiple: Record "LFS EXIM Export License";
    //     RodtepLicenseLines: Record "LFS Rodtep License Lines";
    //     RodtepLicenseHeader: Record "LFS Rodtep License Header";
    //     RoDTEPLineNo: Integer;
    // begin
    //     RodtepLicenseLines.Init();
    //     EXIMLicenseMultiple.Reset();
    //     EXIMLicenseMultiple.SetRange("LFS Source No.", SalesInvLine."Document No.");
    //     EXIMLicenseMultiple.SetRange("LFS Source line No.", SalesInvLine."Line No.");
    //     EXIMLicenseMultiple.SetRange("LFS License Type", EXIMLicenseMultiple."LFS License Type"::RoDTEP);
    //     if EXIMLicenseMultiple.Findset() then begin
    //         repeat
    //             RodtepLicenseHeader.SetRange("LFS No.", EXIMLicenseMultiple."LFS License No.");
    //             if RodtepLicenseHeader.FindFirst() then begin
    //                 RoDTEPLineNo := 0;
    //                 RodtepLicenseLines.SETRANGE(RodtepLicenseLines."LFS License No.", RodtepLicenseHeader."LFS No.");
    //                 RodtepLicenseLines.SetCurrentKey("LFS Line No.");
    //                 if RodtepLicenseLines.FindLast() then begin
    //                     RoDTEPLineNo := RodtepLicenseLines."LFS Line No." + 10000
    //                 end
    //                 else begin
    //                     RoDTEPLineNo := 10000;
    //                 end;

    //                 RodtepLicenseLines."LFS License No." := EXIMLicenseMultiple."LFS License No.";
    //                 RodtepLicenseLines."LFS Line No." := RoDTEPLineNo;
    //                 RodtepLicenseLines ."LFS Type" := RodtepLicenseLines ."LFS Type"::export;
    //                 RodtepLicenseLines."LFS Document Type" := RodtepLicenseLines."LFS Document Type"::"Posted Invoice";
    //                 RodtepLicenseLines."LFS Document No." := EXIMLicenseMultiple."LFS Source No.";
    //                 RodtepLicenseLines."LFS Document Line No." := EXIMLicenseMultiple."LFS Source line No.";
    //                 RodtepLicenseLines."LFS Item No." := EXIMLicenseMultiple."LFS Item No.";
    //                 RodtepLicenseLines."LFS Variant Code" := EXIMLicenseMultiple."LFS Variant Code";
    //                 RodtepLicenseLines."LFS Description":= SalesInvLine.Description;
    //                 RodtepLicenseLines ."LFS UOM" := SalesInvLine."Unit of Measure";
    //                 RodtepLicenseLines."LFS Qty." := SalesInvLine.Quantity;
    //                 RodtepLicenseLines."LFS CIF Value(FC)" := SalesInvLine."LFS CIF(FCY)";
    //                 RodtepLicenseLines."LFS CIF Value (LCY)" := SalesInvLine."LFS CIF(FCY)" * SalesInvLine."LFS Currency Exch. Rate";
    //                 RodtepLicenseLines."LFS RoDTEP Value (LCY)" := EXIMLicenseMultiple."LFS RoDTEP Consump Value";
    //                 RodtepLicenseLines.Insert();
    //             end;
    //         until EXIMLicenseMultiple.Next() = 0;
    //     end;
    // end;
    //   --

    [IntegrationEvent(false, false)]
    local procedure OnBeforeShowResult(WhseShipmentCreated: Boolean; var IsHandled: Boolean; var GetSourceDocuments: Report "Get Source Documents");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckAvailability(CurrItemVariant: Record "Item Variant"; QtyBaseNeeded: Decimal; LocationCode: Code[10]; FormCaption: Text; SourceType: Integer; SourceSubType: Integer; SourceID: Code[20]; ShowError: Boolean; var Result: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCheckAvailability(NotAvailable: Boolean; ShowError: Boolean; ErrorMessage: Text; var Result: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckSalesHeaderMarkSalesLines(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCheckSalesHeaderOnAfterSetItemVariant(var Result: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCheckSalesHeaderOnBeforeCheckAvailability(SalesHeader: Record "Sales Header"; SalesLine: record "Sales Line"; ShowError: Boolean; var Result: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckSalesLines(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; ShowError: Boolean; var Result: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCreateWhseShipmentHeaderFromWhseRequest(var WarehouseRequest: Record "Warehouse Request"; var Rusult: Boolean; var IsHandled: Boolean; var GetSourceDocuments: Report "Get Source Documents")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFindWarehouseRequestForSalesOrder(var WarehouseRequest: Record "Warehouse Request"; SalesHeader: Record "Sales Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckWhseShipmentConflict(SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetRequireShipRqst(var WarehouseRequest: Record "Warehouse Request"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnFindWarehouseRequestForSalesOrderOnAfterWhseRqstSetFilters(var WhseRqst: Record "Warehouse Request"; var SalesHeader: Record "Sales Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckSalesHeader(var SalesHeader: Record "Sales Header"; var ShowError: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCheckSalesHeaderOnAfterSetLineFilters(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCreateWhseShipmentHeaderFromWhseRequest(var WarehouseRequest: Record "Warehouse Request"; var WhseShptHeader: Record "Warehouse Shipment Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOpenWarehouseShipmentPage(var GetSourceDocuments: Report "Get Source Documents";

    var
        IsHandled: Boolean)
    begin
    end;

    local procedure "LFS InsertLicenseDtlFromExportPostedSalesInvDocToRodtepLicense"(SalesInvoiceLine: Record "Sales Invoice Line")
    var

        EXIMLicenseMultiple: Record "LFS EXIM Posted Export Licence";
        rodtepLicenseHeader: Record "LFS Rodtep License Header";
        RodtepLicenseLines: Record "LFS Rodtep License Lines";
        RoDTEPLineNo: Integer;
    begin
        EXIMLicenseMultiple.SetRange("LFS Source No.", SalesInvoiceLine."Document No.");
        EXIMLicenseMultiple.SetRange("LFS Source line No.", SalesInvoiceLine."Line No.");
        if EXIMLicenseMultiple.Findset() then
            repeat
                rodtepLicenseHeader.SetRange("LFS No.", EXIMLicenseMultiple."LFS License No.");
                if rodtepLicenseHeader.FindFirst() then begin
                    RoDTEPLineNo := 0;
                    RodtepLicenseLines.SETRANGE(RodtepLicenseLines."LFS License No.", rodtepLicenseHeader."LFS No.");
                    RodtepLicenseLines.SetCurrentKey("LFS Line No.");
                    if RodtepLicenseLines.FindLast() then
                        RoDTEPLineNo := RodtepLicenseLines."LFS Line No." + 10000
                    else
                        RoDTEPLineNo := 10000;
                    RodtepLicenseLines."LFS License No." := EXIMLicenseMultiple."LFS License No.";
                    RodtepLicenseLines."LFS Line No." := RoDTEPLineNo;
                    RodtepLicenseLines."LFS Type" := RodtepLicenseLines."LFS Type"::Domestic;
                    RodtepLicenseLines."LFS Entry Type" := RodtepLicenseLines."LFS Entry Type"::Utilization;
                    RodtepLicenseLines."LFS Document Type" := RodtepLicenseLines."LFS Document Type"::"Posted Invoice";
                    RodtepLicenseLines."LFS Document No." := EXIMLicenseMultiple."LFS Source No.";
                    RodtepLicenseLines."LFS Document Line No." := EXIMLicenseMultiple."LFS Source line No.";
                    RodtepLicenseLines."LFS Item No." := EXIMLicenseMultiple."LFS Item No.";
                    RodtepLicenseLines."LFS Variant Code" := EXIMLicenseMultiple."LFS Variant Code";
                    RodtepLicenseLines."LFS Description" := SalesInvoiceLine.Description;
                    RodtepLicenseLines."LFS UOM" := Format(SalesInvoiceLine."Unit of Measure");
                    RodtepLicenseLines."LFS Qty." := SalesInvoiceLine.Quantity;
                    RodtepLicenseLines."LFS CIF Value(FC)" := SalesInvoiceLine."LFS CIF Value (FCY)";
                    RodtepLicenseLines."LFS CIF Value (LCY)" := SalesInvoiceLine."LFS CIF Value (LCY)";
                    RodtepLicenseLines."LFS RoDTEP Value (LCY)" := EXIMLicenseMultiple."LFS RoDTEP Consump Value";
                    RodtepLicenseLines."LFS FOB Amount (FCY)" := SalesInvoiceLine."LFS FOB Amount (FCY)";
                    RodtepLicenseLines."LFS FOB Amount (LCY)" := SalesInvoiceLine."LFS FOB Amount (LCY)";
                    RodtepLicenseLines.Insert();
                end;
            until EXIMLicenseMultiple.Next() = 0;
    end;


    procedure "LFS InsertLicenseDtlFromDomesticPostedSalesInvDocToRodtepLicense"(SalesInvoiceLine: Record "Sales Invoice Line")
    var
        rodtepLicenseHeader: Record "LFS Rodtep License Header";
        RodtepLicenseLines: Record "LFS Rodtep License Lines";
        salesInvoiceLine2: Record "Sales Invoice Line";
        salesInvoiceLine3: Record "Sales Invoice Line";
        RoDTEPLineNo: Integer;
    begin
        salesInvoiceLine2.SetRange("Document No.", SalesInvoiceLine."Document No.");
        salesInvoiceLine2.SetRange("LFS RoDTEP License No.", SalesInvoiceLine."LFS RoDTEP License No.");
        salesInvoiceLine2.SetRange("LFSRoDTEP License Sales Values", SalesInvoiceLine."LFSRoDTEP License Sales Values");
        if salesInvoiceLine2.Findset() then
            repeat
                rodtepLicenseHeader.SetRange("LFS No.", salesInvoiceLine2."LFS RoDTEP License No.");
                if rodtepLicenseHeader.FindFirst() then begin
                    RoDTEPLineNo := 0;
                    RodtepLicenseLines.SETRANGE(RodtepLicenseLines."LFS License No.", rodtepLicenseHeader."LFS No.");
                    RodtepLicenseLines.SetCurrentKey("LFS Line No.");
                    if RodtepLicenseLines.FindLast() then
                        RoDTEPLineNo := RodtepLicenseLines."LFS Line No." + 10000
                    else
                        RoDTEPLineNo := 10000;
                    RodtepLicenseLines."LFS License No." := SalesInvoiceLine."LFS RoDTEP License No.";
                    RodtepLicenseLines."LFS Line No." := RoDTEPLineNo;
                    RodtepLicenseLines."LFS Type" := RodtepLicenseLines."LFS Type"::Domestic;
                    RodtepLicenseLines."LFS Entry Type" := RodtepLicenseLines."LFS Entry Type"::Sales;
                    RodtepLicenseLines."LFS Document Type" := RodtepLicenseLines."LFS Document Type"::"Posted Invoice";
                    RodtepLicenseLines."LFS Document No." := SalesInvoiceLine."Document No.";
                    RodtepLicenseLines."LFS Document Line No." := SalesInvoiceLine."Line No.";
                    RodtepLicenseLines."LFS Item No." := SalesInvoiceLine."No.";
                    RodtepLicenseLines."LFS Variant Code" := SalesInvoiceLine."Variant Code";
                    RodtepLicenseLines."LFS Description" := SalesInvoiceLine.Description;
                    RodtepLicenseLines."LFS UOM" := Format(SalesInvoiceLine."Unit of Measure");
                    RodtepLicenseLines."LFS Qty." := SalesInvoiceLine.Quantity;
                    RodtepLicenseLines."LFS CIF Value(FC)" := SalesInvoiceLine."LFS CIF Value (FCY)";
                    RodtepLicenseLines."LFS CIF Value (LCY)" := SalesInvoiceLine."LFS CIF Value (LCY)";
                    RodtepLicenseLines."LFS RoDTEP Value (LCY)" := SalesInvoiceLine."LFSRoDTEP License Sales Values" - SalesInvoiceLine."Line Discount Amount";
                    RodtepLicenseLines."LFS FOB Amount (FCY)" := SalesInvoiceLine."LFS FOB Amount (FCY)";
                    RodtepLicenseLines."LFS FOB Amount (LCY)" := SalesInvoiceLine."LFS FOB Amount (LCY)";
                    RodtepLicenseLines.Insert();
                end;
            until salesInvoiceLine2.Next() = 0;

        salesInvoiceLine3.SetRange("Document No.", SalesInvoiceLine."Document No.");
        salesInvoiceLine3.SetRange("LFS RoDTEP License No.", SalesInvoiceLine."LFS RoDTEP License No.");
        salesInvoiceLine3.SetRange("LFSRoDTEP License Sales Values", SalesInvoiceLine."LFSRoDTEP License Sales Values");
        salesInvoiceLine3.SetFilter("Line Discount Amount", '>%1', 0);
        if salesInvoiceLine3.Findset() then
            repeat
                rodtepLicenseHeader.SetRange("LFS No.", salesInvoiceLine3."LFS RoDTEP License No.");
                if rodtepLicenseHeader.FindFirst() then begin
                    RoDTEPLineNo := 0;
                    RodtepLicenseLines.SETRANGE(RodtepLicenseLines."LFS License No.", rodtepLicenseHeader."LFS No.");
                    RodtepLicenseLines.SetCurrentKey("LFS Line No.");
                    if RodtepLicenseLines.FindLast() then
                        RoDTEPLineNo := RodtepLicenseLines."LFS Line No." + 10000
                    else
                        RoDTEPLineNo := 10000;
                    RodtepLicenseLines."LFS License No." := SalesInvoiceLine."LFS RoDTEP License No.";
                    RodtepLicenseLines."LFS Line No." := RoDTEPLineNo;
                    RodtepLicenseLines."LFS Type" := RodtepLicenseLines."LFS Type"::Domestic;
                    RodtepLicenseLines."LFS Entry Type" := RodtepLicenseLines."LFS Entry Type"::Loss;
                    RodtepLicenseLines."LFS Document Type" := RodtepLicenseLines."LFS Document Type"::"Posted Invoice";
                    RodtepLicenseLines."LFS Document No." := SalesInvoiceLine."Document No.";
                    RodtepLicenseLines."LFS Document Line No." := SalesInvoiceLine."Line No.";
                    RodtepLicenseLines."LFS Item No." := SalesInvoiceLine."No.";
                    RodtepLicenseLines."LFS Variant Code" := SalesInvoiceLine."Variant Code";
                    RodtepLicenseLines."LFS Description" := SalesInvoiceLine.Description;
                    RodtepLicenseLines."LFS UOM" := Format(SalesInvoiceLine."Unit of Measure");
                    RodtepLicenseLines."LFS Qty." := SalesInvoiceLine.Quantity;
                    RodtepLicenseLines."LFS CIF Value(FC)" := SalesInvoiceLine."LFS CIF Value (FCY)";
                    RodtepLicenseLines."LFS CIF Value (LCY)" := SalesInvoiceLine."LFS CIF Value (LCY)";
                    RodtepLicenseLines."LFS RoDTEP Value (LCY)" := SalesInvoiceLine."Line Discount Amount";
                    RodtepLicenseLines."LFS FOB Amount (FCY)" := SalesInvoiceLine."LFS FOB Amount (FCY)";
                    RodtepLicenseLines."LFS FOB Amount (LCY)" := SalesInvoiceLine."LFS FOB Amount (LCY)";
                    RodtepLicenseLines.Insert();
                end;
            until salesInvoiceLine3.Next() = 0;
    end;

    procedure "LFS InsertLicenseDtlFromDomesticPostedSalesCreditDocToRodtepLicense"(SalesCreditMemoLine: Record "Sales Cr.Memo Line")
    var
        rodtepLicenseHeader: Record "LFS Rodtep License Header";
        RodtepLicenseLines: Record "LFS Rodtep License Lines";
        salesCrdeitLine2: Record "Sales Cr.Memo Line";
        salesCreditLine3: Record "Sales Cr.Memo Line";
        RoDTEPLineNo: Integer;
    begin
        salesCrdeitLine2.SetRange("Document No.", SalesCreditMemoLine."Document No.");
        salesCrdeitLine2.SetRange("LFS RoDTEP License No.", SalesCreditMemoLine."LFS RoDTEP License No.");
        salesCrdeitLine2.SetRange("LFSRoDTEP License Sales Values", SalesCreditMemoLine."LFSRoDTEP License Sales Values");
        if salesCrdeitLine2.Findset() then
            repeat
                rodtepLicenseHeader.SetRange("LFS No.", salesCrdeitLine2."LFS RoDTEP License No.");
                if rodtepLicenseHeader.FindFirst() then begin
                    RoDTEPLineNo := 0;
                    RodtepLicenseLines.SETRANGE(RodtepLicenseLines."LFS License No.", rodtepLicenseHeader."LFS No.");
                    RodtepLicenseLines.SetCurrentKey("LFS Line No.");
                    if RodtepLicenseLines.FindLast() then
                        RoDTEPLineNo := RodtepLicenseLines."LFS Line No." + 10000
                    else
                        RoDTEPLineNo := 10000;
                    RodtepLicenseLines."LFS License No." := SalesCreditMemoLine."LFS RoDTEP License No.";
                    RodtepLicenseLines."LFS Line No." := RoDTEPLineNo;
                    RodtepLicenseLines."LFS Type" := RodtepLicenseLines."LFS Type"::Domestic;
                    RodtepLicenseLines."LFS Entry Type" := RodtepLicenseLines."LFS Entry Type"::"Credit Memo";
                    RodtepLicenseLines."LFS Document Type" := RodtepLicenseLines."LFS Document Type"::"Posted Invoice";
                    RodtepLicenseLines."LFS Document No." := SalesCreditMemoLine."Document No.";
                    RodtepLicenseLines."LFS Document Line No." := SalesCreditMemoLine."Line No.";
                    RodtepLicenseLines."LFS Item No." := SalesCreditMemoLine."No.";
                    RodtepLicenseLines."LFS Variant Code" := SalesCreditMemoLine."Variant Code";
                    RodtepLicenseLines."LFS Description" := SalesCreditMemoLine.Description;
                    RodtepLicenseLines."LFS UOM" := Format(SalesCreditMemoLine."Unit of Measure");
                    RodtepLicenseLines."LFS Qty." := SalesCreditMemoLine.Quantity;
                    RodtepLicenseLines."LFS CIF Value(FC)" := SalesCreditMemoLine."LFS CIF Value (FCY)";
                    RodtepLicenseLines."LFS CIF Value (LCY)" := SalesCreditMemoLine."LFS CIF Value (LCY)";
                    RodtepLicenseLines."LFS RoDTEP Value (LCY)" := -(SalesCreditMemoLine."LFSRoDTEP License Sales Values" - SalesCreditMemoLine."Line Discount Amount");
                    RodtepLicenseLines."LFS FOB Amount (FCY)" := SalesCreditMemoLine."LFS FOB Amount (FCY)";
                    RodtepLicenseLines."LFS FOB Amount (LCY)" := SalesCreditMemoLine."LFS FOB Amount (LCY)";
                    RodtepLicenseLines.Insert();
                end;
            until salesCrdeitLine2.Next() = 0;

        salesCreditLine3.SetRange("Document No.", SalesCreditMemoLine."Document No.");
        salesCreditLine3.SetRange("LFS RoDTEP License No.", SalesCreditMemoLine."LFS RoDTEP License No.");
        salesCreditLine3.SetRange("LFSRoDTEP License Sales Values", SalesCreditMemoLine."LFSRoDTEP License Sales Values");
        salesCreditLine3.SetFilter("Line Discount Amount", '>%1', 0);
        if salesCreditLine3.Findset() then
            repeat
                rodtepLicenseHeader.SetRange("LFS No.", salesCreditLine3."LFS RoDTEP License No.");
                if rodtepLicenseHeader.FindFirst() then begin
                    RoDTEPLineNo := 0;
                    RodtepLicenseLines.SETRANGE(RodtepLicenseLines."LFS License No.", rodtepLicenseHeader."LFS No.");
                    RodtepLicenseLines.SetCurrentKey("LFS Line No.");
                    if RodtepLicenseLines.FindLast() then
                        RoDTEPLineNo := RodtepLicenseLines."LFS Line No." + 10000
                    else
                        RoDTEPLineNo := 10000;
                    RodtepLicenseLines."LFS License No." := SalesCreditMemoLine."LFS RoDTEP License No.";
                    RodtepLicenseLines."LFS Line No." := RoDTEPLineNo;
                    RodtepLicenseLines."LFS Type" := RodtepLicenseLines."LFS Type"::Domestic;
                    RodtepLicenseLines."LFS Entry Type" := RodtepLicenseLines."LFS Entry Type"::Loss;
                    RodtepLicenseLines."LFS Document Type" := RodtepLicenseLines."LFS Document Type"::"Posted Invoice";
                    RodtepLicenseLines."LFS Document No." := SalesCreditMemoLine."Document No.";
                    RodtepLicenseLines."LFS Document Line No." := SalesCreditMemoLine."Line No.";
                    RodtepLicenseLines."LFS Item No." := SalesCreditMemoLine."No.";
                    RodtepLicenseLines."LFS Variant Code" := SalesCreditMemoLine."Variant Code";
                    RodtepLicenseLines."LFS Description" := SalesCreditMemoLine.Description;
                    RodtepLicenseLines."LFS UOM" := Format(SalesCreditMemoLine."Unit of Measure");
                    RodtepLicenseLines."LFS Qty." := SalesCreditMemoLine.Quantity;
                    RodtepLicenseLines."LFS CIF Value(FC)" := SalesCreditMemoLine."LFS CIF Value (FCY)";
                    RodtepLicenseLines."LFS CIF Value (LCY)" := SalesCreditMemoLine."LFS CIF Value (LCY)";
                    RodtepLicenseLines."LFS RoDTEP Value (LCY)" := -SalesCreditMemoLine."Line Discount Amount";
                    RodtepLicenseLines."LFS FOB Amount (FCY)" := SalesCreditMemoLine."LFS FOB Amount (FCY)";
                    RodtepLicenseLines."LFS FOB Amount (LCY)" := SalesCreditMemoLine."LFS FOB Amount (LCY)";
                    RodtepLicenseLines.Insert();
                end;
            until salesCreditLine3.Next() = 0;
    end;

    var
        AndLbl: Label 'AND';
        CroreLbl: Label 'CRORE';
        EighteenLbl: Label 'EIGHTEEN';
        EightLbl: Label 'EIGHT';
        EightyLbl: Label 'EIGHTY';
        ElevenLbl: Label 'ELEVEN';
        exceededStringErr: Label '%1 results in a written number that is too long.', Comment = '%1= AddText';
        FifteenLbl: Label 'FIFTEEN';
        FiftyLbl: Label 'FIFTY';
        FiveLbl: Label 'FIVE';
        FortyLbl: Label 'FORTY';
        FourLbl: Label 'FOUR';
        FourteenLbl: Label 'FOURTEEN';
        HundreadLbl: Label 'HUNDRED';
        LakhLbl: Label 'LAKH';
        NineLbl: Label 'NINE';
        NinetyLbl: Label 'NINETY';
        NinteenLbl: Label 'NINETEEN';
        OneLbl: Label 'ONE';
        SevenLbl: Label 'SEVEN';
        SeventeenLbl: Label 'SEVENTEEN';
        SeventyLbl: Label 'SEVENTY';
        SixLbl: Label 'SIX';
        SixteenLbl: Label 'SIXTEEN';
        SixtyLbl: Label 'SIXTY';
        TenLbl: Label 'TEN';
        ThirteenLbl: Label 'THIRTEEN';
        ThirtyLbl: Label 'THIRTY';
        ThousandLbl: Label 'THOUSAND';
        ThreeLbl: Label 'THREE';
        TwelveLbl: Label 'TWELVE';
        TwentyLbl: Label 'TWENTY';
        TwoLbl: Label 'TWO';
        ZeroLbl: Label 'ZERO';
        ExponentText: array[5] of Text[30];
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];

}