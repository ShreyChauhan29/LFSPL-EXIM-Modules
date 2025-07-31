namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Sales.Document;
using Microsoft.Purchases.Document;
table 72012 "LFS EXIM Import License"
{
    Caption = 'EXIM Import License';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "LFS Source Type"; enum "LFSPurchaseSourceDocumentType")
        {
            DataClassification = CustomerContent;
            Caption = 'Source Type';
        }
        field(2; "LFS Source No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Source No.';

        }
        field(3; "LFS Source line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Source line No.';
        }
        field(4; "LFS Line No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
            Caption = 'line No.';
        }
        field(5; "LFS License Type"; Enum "LFS License Type")
        {
            DataClassification = CustomerContent;
            Caption = 'License Type';
            trigger OnValidate()
            begin
                Clear("LFS License No.");
            end;
        }
        field(6; "LFS License No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'License No.';
        }
        field(7; "LFS Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity';
            trigger OnValidate()
            var
                EXIMiodetails: Record "LFS EXIM License IO Details";
                PurchaseLine: Record "Purchase Line";
                Text001Lbl: Label 'Quantity should not exceed the Import Balance Qty. of the license.';
            begin
                EXIMiodetails.setrange("LFS Adv. License No.", Rec."LFS License No.");
                EXIMiodetails.SetRange("LFS Item No.", Rec."LFS Item No.");
                EXIMiodetails.SetRange("LFS Type", EXIMiodetails."LFS Type"::Import);
                if EXIMiodetails.FindFirst() then
                    if (EXIMiodetails."LFS Import Inv Bal Qty" < Rec."LFS Quantity") and (Rec."LFS Source Type" <> Rec."LFS Source Type"::"Credit Memo") then
                        Error(Text001Lbl);
                if Rec."LFS Source Type" <> Rec."LFS Source Type"::"Credit Memo" then
                    CheckTotalQty();
                Rec."LFS CIF Value (FCY)" := Rec."LFS Quantity" * Rec."LFS Unit Cost";
                if Rec."LFS License Type" = Rec."LFS License Type"::RoDTEP then begin
                    PurchaseLine.Reset();
                    PurchaseLine.SetRange("Document No.", Rec."LFS Source No.");
                    PurchaseLine.SetRange("Line No.", Rec."LFS Source line No.");
                    if PurchaseLine.FindFirst() then
                        Rec."LFS RoDTEP Consump Value" := Rec."LFS Quantity" * (PurchaseLine."LFS Import Duties Amt. (LCY)" / PurchaseLine.Quantity);
                end;
            end;
        }
        // field(10; "LFS EXIM Item Group"; Code[20])
        // {
        //     Caption = 'EXIM Item Group';
        //     Editable = false;
        //     TableRelation = "LFS EXIM Item Group";
        //     DataClassification = CustomerContent;
        // }
        field(11; "LFS Item No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item No.';
        }
        field(13; "LFS Import Inv Bal Qty"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Import Inv Bal Qty';
        }
        field(14; "LFS CIF Value (FCY)"; decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'CIF(FCY)';
        }
        field(15; "LFS Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Cost';
            trigger OnValidate()
            begin
                Rec."LFS CIF Value (FCY)" := Rec."LFS Quantity" * Rec."LFS Unit Cost";
            end;
        }
        field(16; "LFS Variant Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Variant Code';
        }
        field(17; "LFS RoDTEP Balance"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'RoDTEP Balance';
        }
        field(18; "LFS RoDTEP Consump Value"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'RoDTEP Consumption Value';
            trigger OnValidate()
            begin
                if Rec."LFS RoDTEP Consump Value" > Rec."LFS RoDTEP Balance" then
                    Error('Consumption value should not be greater tha RoDTEP Balance');

            end;
        }
        field(19; "LFS EXIM Group No."; Code[20])
        {
            Caption = 'EXIM Group No.';
            TableRelation = "EXIM Group Master"."LFS Group No.";
            ToolTip = 'Exim';
        }
    }

    keys
    {
        key(Key1; "LFS Source No.", "LFS Source line No.", "LFS Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        PurchLine: Record "Purchase Line";
    begin
        PurchLine.Reset();
        PurchLine.SetFilter("Document Type", '%1|%2|%3', PurchLine."Document Type"::Order,
                                PurchLine."Document Type"::Invoice,
                                PurchLine."Document Type"::"Credit Memo");
        PurchLine.SetRange("Document No.", Rec."LFS Source No.");
        PurchLine.SetRange("Line No.", Rec."LFS Source line No.");
        if PurchLine.FindFirst() then
            if PurchLine."LFS Exim Group No." <> '' then
                Rec."LFS Exim Group No." := PurchLine."LFS Exim Group No.";

        exportOrder.Reset();
        exportOrder.SetRange("Document No.", Rec."LFS Source No.");
        exportOrder.SetRange("Line No.", Rec."LFS Source line No.");
        exportOrder.setrange(Type, exportOrder.Type::Item);
        if exportOrder.FindFirst() then begin
            rec.Validate("LFS Unit Cost", exportOrder."Unit Cost");
            Rec.Validate("LFS Item No.", exportOrder."No.");
            Rec.Validate("LFS Variant Code", exportOrder."Variant Code");
        end;

    end;


    trigger OnDelete()
    begin
        if Rec."LFS Quantity" <> 0 then
            if Rec."LFS Source Type" = Rec."LFS Source Type"::"Credit Memo" then
                error('You cannot delete credit memo license')
    end;


    var
        // EXIMlicenseHeader: Record "LFS EXIM  License Header";
        // ImportPurchaseordersub: Record "Purchase Line";
        // EXIM_License: record "LFS EXIM Import License";
        // EXIM_license1: Record "LFS EXIM Import License";
        // EXIM_licenseList: Page "LFS Import Licenses";
        exportOrder: Record "Sales Line";

    // local procedure PromptLicUsageMsg()
    // var
    //     EXIMAdvLicenseIODetails: Record "LFS EXIM License IO Details";

    // begin
    //     if "LFS License Type" <> "LFS License Type"::"Adv. License" then
    //         EXIT;

    //     if "LFS License No." = '' then
    //         EXIT;

    //     EXIMAdvLicenseIODetails.Reset();
    //     EXIMAdvLicenseIODetails.SETRANGE(EXIMAdvLicenseIODetails."LFS Adv. License No.", "LFS License No.");
    //     EXIMAdvLicenseIODetails.SETRANGE(EXIMAdvLicenseIODetails."LFS Item Type", "LFS EXIM Item Group");
    //     if EXIMAdvLicenseIODetails.FINDFIRST() then;
    //     EXIMAdvLicenseIODetails.CALCFIELDS(EXIMAdvLicenseIODetails."LFS Consumed Import Qty.");
    //     if "LFS Quantity" + EXIMAdvLicenseIODetails."LFS Consumed Import Qty." > EXIMAdvLicenseIODetails."LFS Qty." then
    //         MESSAGE('ALERT: Consumption for License No. %1 is going to exceed or has exceeded already.', "LFS License No.");
    // end;

    local procedure CheckTotalQty()
    var
        EXIM_License: Record "LFS EXIM Export License";
        importPurchLine: Record "Purchase Line";
        // EximLicense1: Record "LFS EXIM Export License";
        // eximLicenseHeader: Record "LFS EXIM  License Header";
        sumQty: Decimal;
    begin
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
                Error('Quantity should not exceed the Import line quantity');
    end;

}