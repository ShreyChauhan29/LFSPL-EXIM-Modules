namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Sales.Document;

page 72012 "LFS EXIM Export License"
{
    ApplicationArea = All;
    Caption = 'EXIM Export License';
    PageType = List;
    SourceTable = "LFS EXIM Export License";
    UsageCategory = Lists;
    AutoSplitKey = true;
    MultipleNewLines = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("License Type"; Rec."LFS License Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the License Type';
                    trigger OnValidate()
                    var
                        ExportLicense: Record "LFS EXIM Export License";
                        SalesHeader: Record "Sales Header";
                    begin

                        SalesHeader.SetRange("Document Type", Rec."LFS Source Type");
                        SalesHeader.SetRange("No.", Rec."LFS Source No.");
                        SalesHeader.SetRange("LFS EXIM Type", SalesHeader."LFS EXIM Type"::Export);
                        if not SalesHeader.IsEmpty() then
                            if Rec."LFS License Type" = Rec."LFS License Type"::RoDTEP then
                                Error('RoDTEP License Selection only for Domestic Sales.');

                        ExportLicense.SetRange("LFS Source Type", Rec."LFS Source Type");
                        ExportLicense.SetRange("LFS Source No.", Rec."LFS Source No.");
                        ExportLicense.SetRange("LFS Source line No.", Rec."LFS Source line No.");
                        ExportLicense.SetFilter("LFS Line No.", '<>%1', Rec."LFS Line No.");
                        if ExportLicense.Findset() then
                            repeat
                                if Rec."LFS License Type" = Rec."LFS License Type"::RoDTEP then begin
                                    Rec."LFS Export Inv Bal Qty" := 0;
                                    Rec."LFS FOB (FCY)" := 0;
                                    Rec."LFS Quantity" := 0;
                                end;
                                if Rec."LFS License Type" = Rec."LFS License Type"::"Adv. License" then begin
                                    Rec."LFS RoDTEP Balance" := 0;
                                    Rec."LFS RoDTEP Consump Value" := 0;
                                end;
                            until ExportLicense.Next() = 0;
                    end;
                }
                field("License No."; Rec."LFS License No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the License No.';
                    Lookup = true;
                    LookupPageId = "LFS EXIM License List";
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        exportLicense: Record "LFS EXIM Export License";
                        eximIOdetails: Record "LFS EXIM License IO Details";
                        // eximLicenseHeader: Record "LFS EXIM  License Header";
                        rodtepLicenseHeader: Record "LFS Rodtep License Header";
                        EximSetup: Record "LFS EXIM Setup";
                        // eximlicenseList: Page "LFS EXIM License List";
                        eximIOdetailslist: Page "LFS EXIM Lic. IO Detail List";
                    begin
                        EximSetup.Get();
                        if Rec."LFS License Type" = rec."LFS License Type"::"Adv. License" then begin
                            eximIOdetails.SetRange("LFS type", eximIOdetails."LFS Type"::Export);
                            if EximSetup."LFS Group Wise License" then
                                eximIOdetails.SetRange("LFS Exim Group No.", Rec."LFS Exim Group No.")
                            else
                                eximIOdetails.SetRange("LFS Item No.", Rec."LFS Item No.");
                            eximIOdetails.SetRange("LFS Status", eximIOdetails."LFS Status"::Active);
                            eximIOdetails.SetRange("LFS Scheme Type", eximIOdetails."LFS Scheme Type"::"Advance License");
                            eximIOdetails.SetFilter("LFS Export Inv Bal Qty", '>%1', 0);
                            eximIOdetailslist.LookupMode(true);
                            eximIOdetailslist.SetTableView(eximIOdetails);
                            if Page.Runmodal(Page::"LFS EXIM Lic. IO Detail List", eximIOdetails) = Action::LookupOK then begin
                                Rec."LFS License No." := eximIOdetails."LFS Adv. License No.";
                                Rec."LFS Export Inv Bal Qty" := eximIOdetails."LFS Export Inv Bal Qty";
                            end;
                        end;

                        if Rec."LFS License Type" = rec."LFS License Type"::RoDTEP then begin
                            rodtepLicenseHeader.Reset();
                            if rodtepLicenseHeader.Findset() then
                                if Page.RunModal(Page::"LFS Rodtep License List", rodtepLicenseHeader) = Action::LookupOK then begin
                                    Rec."LFS License No." := rodtepLicenseHeader."LFS No.";
                                    Rec."LFS RoDTEP Balance" := rodtepLicenseHeader."LFS Balance LCY";
                                end;
                        end;
                        exportLicense.SetRange("LFS Source Type", Rec."LFS Source Type");
                        exportLicense.SetRange("LFS Source No.", Rec."LFS Source No.");
                        exportLicense.SetRange("LFS Source line No.", Rec."LFS Source line No.");
                        exportLicense.SetRange("LFS License Type", Rec."LFS License Type");
                        exportLicense.SetRange("LFS License No.", Rec."LFS License No.");
                        if not exportLicense.IsEmpty() then
                            Error('License has already been selected for this document line');
                    end;

                    trigger OnValidate()
                    var
                        exportLicenseIO: Record "LFS EXIM License IO Details";
                    begin
                        exportLicenseIO.SetRange("LFS Adv. License No.", Rec."LFS License No.");
                        exportLicenseIO.SetRange("LFS Item No.", Rec."LFS Item No.");
                        if exportLicenseIO.Findset() then
                            repeat
                                exportLicenseIO.SetRange("LFS Type", exportLicenseIO."LFS Type"::Export);
                                if exportLicenseIO.FindSet() then
                                    Rec."LFS Export Inv Bal Qty" := exportLicenseIO."LFS Export Inv Bal Qty";
                            until exportLicenseIO.Next() = 0;
                    end;

                }
                field(Quantity; Rec."LFS Quantity")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Quantity';
                    trigger OnValidate()
                    var
                        EXIM_License: Record "LFS EXIM Export License";
                        exportOrderLine: Record "Sales Line";
                        // eximLicenseHeader: Record "LFS EXIM  License Header";
                        sumQty: Decimal;
                    begin
                        if Rec."LFS Source Type" <> Rec."LFS Source Type"::"Credit Memo" then begin
                            sumQty := 0;
                            EXIM_License.Reset();
                            EXIM_License.SetRange("LFS Source No.", Rec."LFS Source No.");
                            EXIM_License.SetRange("LFS Source line No.", Rec."LFS Source line No.");
                            EXIM_License.SetFilter("LFS Line No.", '<>%1', Rec."LFS Line No.");
                            if EXIM_License.Findset() then
                                repeat
                                    sumQty += EXIM_License."LFS Quantity";
                                until EXIM_License.Next() = 0;
                            sumQty := sumQty + Rec."LFS Quantity";
                            exportOrderLine.Reset();
                            exportOrderLine.SetRange("Document No.", Rec."LFS Source No.");
                            exportOrderLine.SetRange("Line No.", Rec."LFS Source line No.");
                            if exportOrderLine.FindFirst() then
                                if (sumQty > exportOrderLine.Quantity) or (Rec."LFS Quantity" > exportOrderLine.Quantity) then
                                    Error('Quantity should not exceed the document line quantity %1', exportOrderLine.Quantity);
                        end;
                    end;
                }
                field("FOB (FCY)"; Rec."LFS FOB (FCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the FOB (FCY)';
                }
                field("Unit Price"; Rec."LFS Unit Price")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Unit Price';
                }
                field("Export Inv Bal Qty"; Rec."LFS Export Inv Bal Qty")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Export Inv Bal Qty';
                }
                field("RoDTEP Consumption Value"; Rec."LFS RoDTEP Consump Value")
                {
                    ApplicationArea = all;
                    Editable = rodConsumptionED;
                    ToolTip = 'Specifies the RoDTEP Consumption Value';
                }
                field("RoDTEP Balance"; Rec."LFS RoDTEP Balance")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the RoDTEP Balance';
                }
                field("LFS Exim Group No."; Rec."LFS Exim Group No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Exim Group No. field.';
                }
            }
        }
    }

    // actions
    // {
    //     area(Processing)
    //     {
    //         action(ActionName)
    //         {
    //             ApplicationArea = All;
    //             trigger OnAction()
    //             begin
    //             end;
    //         }
    //     }
    // }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        EXIM_License: Record "LFS EXIM Export License";
        exportOrderLine: Record "Sales Line";
        // eximLicenseHeader: Record "LFS EXIM  License Header";
        sumQty: Decimal;
    begin
        if Rec."LFS Source Type" = Rec."LFS Source Type"::"Credit Memo" then begin
            sumQty := 0;
            EXIM_License.Reset();
            EXIM_License.SetRange("LFS Source No.", Rec."LFS Source No.");
            EXIM_License.SetRange("LFS Source line No.", Rec."LFS Source line No.");
            if EXIM_License.Findset() then
                repeat
                    sumQty += EXIM_License."LFS Quantity";
                until EXIM_License.Next() = 0;
            exportOrderLine.Reset();
            exportOrderLine.SetRange("Document No.", Rec."LFS Source No.");
            exportOrderLine.SetRange("Line No.", Rec."LFS Source line No.");
            if exportOrderLine.FindFirst() then
                if (sumQty > exportOrderLine.Quantity) or (Rec."LFS Quantity" > exportOrderLine.Quantity) then
                    Error('Quantity should not exceed the document line quantity %1', exportOrderLine.Quantity);
        end;
    end;

    trigger OnAfterGetRecord()
    // var
    //     exportLicense: Record "LFS EXIM Export License";
    //     EXIMiodetails: Record "LFS EXIM License IO Details";
    begin
        exportSalesOrder.Reset();
        exportSalesOrder.SetRange("Document No.", Rec."LFS Source No.");
        exportSalesOrder.SetRange("Line No.", Rec."LFS Source line No.");
        if exportSalesOrder.FindFirst() then begin
            rec.Validate("LFS Unit Price", exportSalesOrder."Unit Price");
            Rec.Validate("LFS Item No.", exportSalesOrder."No.");
            Rec.Validate("LFS Variant Code", exportSalesOrder."Variant Code");
        end;
        exportLicenseIO.Reset();
        exportLicenseIO.SetRange("LFS Adv. License No.", Rec."LFS License No.");
        exportLicenseIO.SetRange("LFS Item No.", Rec."LFS Item No.");
        if exportLicenseIO.Findset() then
            repeat
                exportLicenseIO.SetRange("LFS Type", exportLicenseIO."LFS Type"::Export);
                if exportLicenseIO.FindFirst() then
                    Rec."LFS Export Inv Bal Qty" := exportLicenseIO."LFS Export Inv Bal Qty";
            until exportLicenseIO.Next() = 0;
        Rec.Modify();

        if Rec."LFS License Type" = Rec."LFS License Type"::RoDTEP then
            rodConsumptionED := true
        else
            rodConsumptionED := false;
    end;

    trigger OnAfterGetCurrRecord()
    // var
    //     myInt: Integer;
    begin
        exportSalesOrder.Reset();
        exportSalesOrder.SetRange("Document No.", Rec."LFS Source No.");
        exportSalesOrder.SetRange("Line No.", Rec."LFS Source line No.");
        if exportSalesOrder.FindFirst() then begin
            Rec.Validate("LFS Source Type", exportSalesOrder."Document Type");
            rec.Validate("LFS Unit Price", exportSalesOrder."Unit Price");
            Rec.Validate("LFS Item No.", exportSalesOrder."No.");
            Rec.Validate("LFS Variant Code", exportSalesOrder."Variant Code");
        end;
        exportLicenseIO.Reset();
        exportLicenseIO.SetRange("LFS Adv. License No.", Rec."LFS License No.");
        exportLicenseIO.SetRange("LFS Item No.", Rec."LFS Item No.");
        if exportLicenseIO.Findset() then
            repeat
                exportLicenseIO.SetRange("LFS Type", exportLicenseIO."LFS Type"::Export);
                if exportLicenseIO.FindFirst() then
                    Rec."LFS Export Inv Bal Qty" := exportLicenseIO."LFS Export Inv Bal Qty";
            until exportLicenseIO.Next() = 0;
    end;

    var
        // exportPurchOrder: Record "Purchase Line";
        exportLicenseIO: Record "LFS EXIM License IO Details";
        exportSalesOrder: Record "Sales Line";
        rodConsumptionED: Boolean;

    // [IntegrationEvent(false, false)]
    // local procedure OnBeforeCopyMultipleLicense(var MultipleLicense: Record "LFS EXIM Posted Export Licence"; ToDocumentNo: Code[20]; var IsHandled: Boolean; FromDocumentNo: Code[20])
    // begin
    // end;

    // [IntegrationEvent(false, false)]
    // local procedure OnBeforeCopyMultipleLicenseOnBeforeInsert(var NewLicenses: Record "LFS EXIM Posted Export Licence"; Oldlicense: Record "LFS EXIM Posted Export Licence")
    // begin
    // end;
}