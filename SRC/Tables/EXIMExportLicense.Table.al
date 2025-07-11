namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Sales.Document;
table 72011 "LFS EXIM Export License"
{
    Caption = 'EXIM Export License';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "LFS Source Type"; enum "LFS Sales Source Document Type")
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
            Caption = 'Line No.';
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
            Caption = 'License No.';
            trigger OnValidate()
            var
                exportLicense: Record "LFS EXIM Export License";
            begin
                exportLicense.SetRange("LFS Source Type", Rec."LFS Source Type");
                exportLicense.SetRange("LFS Source No.", Rec."LFS Source No.");
                exportLicense.SetRange("LFS Source line No.", Rec."LFS Source line No.");
                exportLicense.SetRange("LFS License Type", Rec."LFS License Type");
                exportLicense.SetRange("LFS License No.", Rec."LFS License No.");
                if not exportLicense.IsEmpty() then
                    Error('License has already been selected for this document line');
            end;
        }
        field(7; "LFS Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity';
            trigger OnValidate()
            var
                EXIMiodetails: Record "LFS EXIM License IO Details";
                Text001Lbl: Label 'Quantity should not exceed the Export Balance Qty. of the license.';
            begin
                EXIMiodetails.setrange("LFS Adv. License No.", Rec."LFS License No.");
                EXIMiodetails.SetRange("LFS Item No.", Rec."LFS Item No.");
                EXIMiodetails.SetRange("LFS Type", EXIMiodetails."LFS Type"::Export);
                if EXIMiodetails.FindFirst() then
                    if (EXIMiodetails."LFS Export Inv Bal Qty" < Rec."LFS Quantity") and (Rec."LFS Source Type" <> Rec."LFS Source Type"::"Credit Memo") then
                        Error(Text001Lbl);
                if Rec."LFS Source Type" <> Rec."LFS Source Type"::"Credit Memo" then
                    CheckTotalQty();
                Rec."LFS FOB (FCY)" := Rec."LFS Quantity" * Rec."LFS Unit Price";
            end;
        }
        field(8; "LFS FOB (FCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'FOB (FCY)';
        }
        field(9; "LFS Unit Price"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Price';
            trigger OnValidate()

            begin
                Rec."LFS FOB (FCY)" := Rec."LFS Quantity" * Rec."LFS Unit Price";
            end;
        }
        field(10; "LFS EXIM Item Group"; Code[20])
        {
            Caption = 'EXIM Item Group';
            Editable = false;
            TableRelation = "LFS EXIM Item Group";
            DataClassification = CustomerContent;
        }
        field(11; "LFS Item No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item No.';
        }
        field(12; "LFS Export Inv Bal Qty"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Export Inv Bal Qty';
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
    }

    keys
    {
        key(Key1; "LFS Source No.", "LFS Source line No.", "LFS Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        exportOrder.Reset();
        exportOrder.SetRange("Document Type", Rec."LFS Source Type");
        exportOrder.SetRange("Document No.", Rec."LFS Source No.");
        exportOrder.SetRange("Line No.", Rec."LFS Source line No.");
        exportOrder.setrange(Type, exportOrder.Type::Item);

        if exportOrder.FindFirst() then begin
            rec.Validate("LFS Unit Price", exportOrder."Unit Price");
            Rec.Validate("LFS Item No.", exportOrder."No.");
            Rec.Validate("LFS Variant Code", exportOrder."Variant Code");
        end;
        if Rec."LFS Source Type" = Rec."LFS Source Type"::"Credit Memo" then
            error('You cannot delete credit memo license')
    end;


    trigger OnDelete()
    begin
        if Rec."LFS Quantity" <> 0 then
            if Rec."LFS Source Type" = Rec."LFS Source Type"::"Credit Memo" then
                error('You cannot delete credit memo license')
    end;

    var
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
    //     if "LFS Quantity" + EXIMAdvLicenseIODetails."LFS Consumed Export Qty." > EXIMAdvLicenseIODetails."LFS Qty." then
    //         MESSAGE('ALERT: Consumption for License No. %1 is going to exceed or has exceeded already.', "LFS License No.");
    // end;

    local procedure CheckTotalQty()
    var
        EXIM_License: Record "LFS EXIM Export License";
        exportOrderLine: Record "Sales Line";
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

        exportOrderLine.Reset();
        exportOrderLine.SetRange("Document No.", Rec."LFS Source No.");
        exportOrderLine.SetRange("Line No.", Rec."LFS Source line No.");
        if exportOrderLine.FindFirst() then
            if (sumQty > exportOrderLine.Quantity) or (Rec."LFS Quantity" > exportOrderLine.Quantity) then
                Error('Quantity should not exceed the Export line quantity');
    end;

}