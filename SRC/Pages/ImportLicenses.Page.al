namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Purchases.Document;

page 72013 "LFS Import Licenses"
{
    ApplicationArea = All;
    Caption = 'Import Licenses';
    PageType = List;
    SourceTable = "LFS EXIM Import License";
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
                        ImportLicense: Record "LFS EXIM Import License";
                    begin
                        ImportLicense.SetRange("LFS Source Type", Rec."LFS Source Type");
                        ImportLicense.SetRange("LFS Source No.", Rec."LFS Source No.");
                        ImportLicense.SetRange("LFS Source line No.", Rec."LFS Source line No.");
                        ImportLicense.SetFilter("LFS Line No.", '<>%1', Rec."LFS Line No.");
                        if ImportLicense.Findset() then
                            repeat
                                if Rec."LFS License Type" = Rec."LFS License Type"::RoDTEP then begin
                                    Rec."LFS Import Inv Bal Qty" := 0;
                                    Rec."LFS CIF Value (FCY)" := 0;
                                    Rec."LFS Quantity" := 0;
                                    if (ImportLicense."LFS License Type" = ImportLicense."LFS License Type"::"Adv. License") then
                                        Error('You cannot choose Rodtep license type for this document');
                                end;
                                if Rec."LFS License Type" = Rec."LFS License Type"::"Adv. License" then begin
                                    Rec."LFS RoDTEP Balance" := 0;
                                    Rec."LFS RoDTEP Consump Value" := 0;
                                    if (ImportLicense."LFS License Type" = ImportLicense."LFS License Type"::RoDTEP) then
                                        Error('You cannot choose Advance license type for this document');
                                end;
                            until ImportLicense.Next() = 0;
                        if Rec."LFS License Type" = Rec."LFS License Type"::RoDTEP then
                            rodConsumptionED := true
                        else
                            rodConsumptionED := false;
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
                        // eximlicenseList: Page "LFS EXIM License List";
                        ImportLicense: Record "LFS EXIM Import License";
                        eximIOdetails: Record "LFS EXIM License IO Details";
                        rodtepLicenseHeader: Record "LFS Rodtep License Header";
                        eximIOdetailslist: Page "LFS EXIM Lic. IO Detail List";
                    // RodtepLicenseList: page "LFS Rodtep License List";
                    begin
                        if Rec."LFS License Type" = rec."LFS License Type"::"Adv. License" then begin
                            eximIOdetails.SetRange("LFS type", eximIOdetails."LFS Type"::Import);
                            eximIOdetails.SetRange("LFS Item No.", Rec."LFS Item No.");
                            eximIOdetails.SetRange("LFS Status", eximIOdetails."LFS Status"::Active);
                            eximIOdetails.SetRange("LFS Scheme Type", eximIOdetails."LFS Scheme Type"::"Advance License");
                            eximIOdetails.SetFilter("LFS Import Inv Bal Qty", '>%1', 0);
                            eximIOdetailslist.LookupMode(true);
                            eximIOdetailslist.SetTableView(eximIOdetails);
                            if Page.Runmodal(Page::"LFS EXIM Lic. IO Detail List", eximIOdetails) = Action::LookupOK then begin
                                Rec."LFS License No." := eximIOdetails."LFS Adv. License No.";
                                Rec."LFS Import Inv Bal Qty" := eximIOdetails."LFS Import Inv Bal Qty";
                            end;
                        end;

                        if rodtepLicenseHeader.Findset() then
                            if Rec."LFS License Type" = Rec."LFS License Type"::RoDTEP then
                                if Page.RunModal(Page::"LFS Rodtep License List", rodtepLicenseHeader) = Action::LookupOK then begin
                                    Rec."LFS License No." := rodtepLicenseHeader."LFS No.";
                                    Rec."LFS RoDTEP Balance" := rodtepLicenseHeader."LFS Balance LCY";
                                end;

                        ImportLicense.SetRange("LFS Source Type", Rec."LFS Source Type");
                        ImportLicense.SetRange("LFS Source No.", Rec."LFS Source No.");
                        ImportLicense.SetRange("LFS Source line No.", Rec."LFS Source line No.");
                        ImportLicense.SetRange("LFS License Type", Rec."LFS License Type");
                        ImportLicense.SetRange("LFS License No.", Rec."LFS License No.");
                        if not ImportLicense.IsEmpty() then
                            Error('License has already been selected for this document line');

                    end;

                    trigger OnValidate()
                    var
                        ImportLicenseIO: Record "LFS EXIM License IO Details";
                    begin
                        ImportLicenseIO.Reset();
                        ImportLicenseIO.SetRange("LFS Adv. License No.", Rec."LFS License No.");
                        ImportLicenseIO.SetRange("LFS Item No.", Rec."LFS Item No.");
                        ImportLicenseIO.SetRange("LFS Type", ImportLicenseIO."LFS Type"::import);
                        if ImportLicenseIO.FindFirst() then
                            Rec."LFS Import Inv Bal Qty" := ImportLicenseIO."LFS Import Inv Bal Qty";
                    end;

                }
                field(Quantity; Rec."LFS Quantity")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Quantity';
                    trigger OnValidate()
                    var
                        EXIM_License: Record "LFS EXIM Import License";
                        importPurchLine: Record "Purchase Line";
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
                            importPurchLine.Reset();
                            importPurchLine.SetRange("Document No.", Rec."LFS Source No.");
                            importPurchLine.SetRange("Line No.", Rec."LFS Source line No.");
                            if importPurchLine.FindFirst() then
                                if (sumQty > importPurchLine.Quantity) or (Rec."LFS Quantity" > importPurchLine.Quantity) then
                                    Error('Quantity should not exceed the document line quantity %1.', importPurchLine.Quantity);
                        end;
                    end;
                }
                field("Unit Cost"; Rec."LFS Unit Cost")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Unit Cost';
                }
                field("CIF(FCY)"; Rec."LFS CIF Value (FCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the CIF (FCY)';
                }
                field("Import Inv Bal Qty"; Rec."LFS Import Inv Bal Qty")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Import Inv Bal Qty';
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
        EXIM_License: Record "LFS EXIM Import License";
        EXIM_License2: Record "LFS EXIM Import License";
        importPurchLine: Record "Purchase Line";
        importPurchLine2: Record "Purchase Line";
        SumBal: Decimal;
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
            importPurchLine.Reset();
            importPurchLine.SetRange("Document No.", Rec."LFS Source No.");
            importPurchLine.SetRange("Line No.", Rec."LFS Source line No.");
            if importPurchLine.FindFirst() then
                if (sumQty > importPurchLine.Quantity) then
                    Error('Quantity should not exceed the document line quantity %1', importPurchLine.Quantity);
        end;
        if Rec."LFS License Type" = Rec."LFS License Type"::RoDTEP then begin
            SumBal := 0;
            EXIM_License2.SetRange("LFS Source No.", Rec."LFS Source No.");
            EXIM_License2.SetRange("LFS Source line No.", Rec."LFS Source line No.");
            if EXIM_License2.Findset() then
                repeat
                    SumBal += EXIM_License2."LFS RoDTEP Consump Value";
                until EXIM_License2.Next() = 0;
            importPurchLine2.SetRange("Document No.", Rec."LFS Source No.");
            importPurchLine2.SetRange("Line No.", Rec."LFS Source line No.");
            if importPurchLine2.FindFirst() then
                if (SumBal > importPurchLine2."LFS Import Duties Amt. (LCY)") then
                    Error('RoDTEP Consumption Value should not exceed the Import Duty Amount %1', importPurchLine2."LFS Import Duties Amt. (LCY)");
        end;
    end;

    trigger OnAfterGetRecord()
    // var
    //     ImportLicense: Record "LFS EXIM Import License";
    //     EXIMiodetails: Record "LFS EXIM License IO Details";
    begin
        ImportPurchOrder.Reset();
        ImportPurchOrder.SetRange("Document No.", Rec."LFS Source No.");
        ImportPurchOrder.SetRange("Line No.", Rec."LFS Source line No.");
        if ImportPurchOrder.FindFirst() then begin
            rec.Validate("LFS Unit Cost", ImportPurchOrder."Unit Cost");
            Rec.Validate("LFS Item No.", ImportPurchOrder."No.");
            Rec.Validate("LFS Variant Code", ImportPurchOrder."Variant Code");
        end;
        ImportLicenseIO.Reset();
        ImportLicenseIO.SetRange("LFS Adv. License No.", Rec."LFS License No.");
        ImportLicenseIO.SetRange("LFS Item No.", Rec."LFS Item No.");
        ImportLicenseIO.SetRange("LFS Type", ImportLicenseIO."LFS Type"::import);
        if ImportLicenseIO.FindFirst() then
            Rec."LFS import Inv Bal Qty" := ImportLicenseIO."LFS Import Inv Bal Qty";
        Rec.Modify();
        if Rec."LFS License Type" = Rec."LFS License Type"::RoDTEP then
            rodConsumptionED := true
        else
            rodConsumptionED := false;
    end;

    trigger OnAfterGetcurrRecord()
    // var
    //     myInt: Integer;
    begin
        ImportPurchOrder.Reset();
        ImportPurchOrder.SetRange("Document No.", Rec."LFS Source No.");
        ImportPurchOrder.SetRange("Line No.", Rec."LFS Source line No.");
        if ImportPurchOrder.FindFirst() then begin
            Rec.Validate("LFS Source Type", ImportPurchOrder."Document Type");
            rec.Validate("LFS Unit Cost", ImportPurchOrder."Unit Cost");
            Rec.Validate("LFS Item No.", ImportPurchOrder."No.");
            Rec.Validate("LFS Variant Code", ImportPurchOrder."Variant Code");
        end;
        ImportLicenseIO.Reset();
        ImportLicenseIO.SetRange("LFS Adv. License No.", Rec."LFS License No.");
        ImportLicenseIO.SetRange("LFS Item No.", Rec."LFS Item No.");
        ImportLicenseIO.SetRange("LFS Type", ImportLicenseIO."LFS Type"::import);
        if ImportLicenseIO.FindFirst() then
            Rec."LFS import Inv Bal Qty" := ImportLicenseIO."LFS Import Inv Bal Qty";
    end;


    var
        ImportLicenseIO: Record "LFS EXIM License IO Details";
        ImportPurchOrder: Record "Purchase Line";
        rodConsumptionED: Boolean;

}