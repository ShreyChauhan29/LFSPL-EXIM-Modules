namespace LFSEximModule.LFSPLEXIMModule;
table 72020 "LFS EXIM License Lines"
{
    Caption = 'EXIM License Lines';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "LFS Adv. License No."; Code[20])
        {
            Caption = 'Adv. License No.';
            DataClassification = CustomerContent;
        }
        field(2; "LFS Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "LFS Type"; Enum "LFS EXIM Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(4; "LFS Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
            OptionMembers = " ",Order,"Posted Invoice",Opening,"Credit Memo";

        }
        field(5; "LFS Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(6; "LFS Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
            DataClassification = CustomerContent;
        }
        field(7; "LFS Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
        }
        field(8; "LFS Item Description"; Text[80])
        {
            Caption = 'Item Description';
            DataClassification = CustomerContent;
        }
        field(9; "LFS UOM"; Code[20])
        {
            Caption = 'UOM';
            DataClassification = CustomerContent;
        }
        field(10; "LFS Qty."; Decimal)
        {
            Caption = 'Qty.';
            DataClassification = CustomerContent;
        }
        field(11; "LFS Currency Code"; Code[20])
        {
            Caption = 'Currency Code';
            DataClassification = CustomerContent;
        }
        field(12; "LFS FOB Value"; Decimal)
        {
            Caption = 'FOB Value';
            DataClassification = CustomerContent;
        }
        field(13; "LFS CIF Value"; Decimal)
        {
            Caption = 'CIF Value';
            DataClassification = CustomerContent;
        }
        field(14; "LFS Currency Exch. Rate"; Decimal)
        {
            Caption = 'Currency Exch. Rate';
            DataClassification = CustomerContent;
        }
        field(15; "LFS FOB LCY Value"; Decimal)
        {
            Caption = 'FOB LCY Value';
            DataClassification = CustomerContent;
        }
        field(16; "LFS Commercial Invoice No."; Code[20])
        {
            Caption = 'Commercial Invoice No.';
            DataClassification = CustomerContent;
        }
        field(17; "LFS Commercial Invoice Date"; Date)
        {
            Caption = 'Commercial Invoice Date';
            DataClassification = CustomerContent;
        }
        field(18; "LFS CIF LCY Value"; Decimal)
        {
            Caption = 'CIF LCY Value';
            DataClassification = CustomerContent;
        }
        // field(19; "LFS EXIM Item Group"; Code[50])
        // {
        //     Caption = 'EXIM Item Group';
        //     TableRelation = "LFS EXIM Item Group";
        //     DataClassification = CustomerContent;
        // }
        field(20; "LFS License Currency Factor"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            MinValue = 0;
            Editable = false;
        }
        field(21; "LFS BCD LCY Value"; Decimal)
        {
            Caption = 'BCD LCY Value';
            DataClassification = CustomerContent;
        }
        field(22; "LFS Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            DataClassification = CustomerContent;
        }
        field(23; "LFS Isexport"; Boolean)
        {
            Caption = 'Isexport';
            DataClassification = CustomerContent;
        }
        field(24; "LFS IsImport"; Boolean)
        {
            Caption = 'Is Import';
            DataClassification = CustomerContent;
        }
        field(25; "LFS Exim Group No."; Code[20])
        {
            Caption = 'Exim Group No.';
            Editable = true;
        }
        // field(26; "LFS FOB CIF in USD"; decimal)
        // {
        //     Caption = 'FOB/CIF in USD';
        //     DataClassification = CustomerContent;
        //     DecimalPlaces = 0 : 2;
        //     Editable = false;
        // }
        field(27; "LFS FOB CIF Currency Code"; Code[10])
        {
            Caption = 'FOB/CIF Currency Code';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "LFSEXIM Currency Exchange Rate";
        }
        field(28; "LFS FOBCIFCurrencyExchangeRate"; Decimal)
        {
            Caption = 'FOB/CIF Currency Exchange Rate';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 15;
            MinValue = 0;
        }
    }

    keys
    {
        key(Key1; "LFS Adv. License No.", "LFS Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnModify()
    begin
        EXIMAdvLicenseHeader.Reset();
        EXIMAdvLicenseHeader.GET("LFS Adv. License No.");
        if EXIMAdvLicenseHeader."LFS Status" <> EXIMAdvLicenseHeader."LFS Status"::Created then
            ERROR('Status must be in created stage');
    end;

    trigger OnDelete()
    begin
        EXIMAdvLicenseHeader.Reset();
        EXIMAdvLicenseHeader.GET("LFS Adv. License No.");
        if EXIMAdvLicenseHeader."LFS Status" <> EXIMAdvLicenseHeader."LFS Status"::Created then
            ERROR('Status must be in created stage');

        EXIMAdvLicenseIODetails.Reset();
        EXIMAdvLicenseIODetails.SETRANGE(EXIMAdvLicenseIODetails."LFS Adv. License No.", "LFS Adv. License No.");
        EXIMAdvLicenseIODetails.SETRANGE(EXIMAdvLicenseIODetails."LFS Type", "LFS Type");
        EXIMAdvLicenseIODetails.SETRANGE(EXIMAdvLicenseIODetails."LFS Item No.", "LFS Item No.");
        EXIMAdvLicenseIODetails.DELETEALL();
    end;

    var
        EXIMAdvLicenseHeader: Record "LFS EXIM License Header";
        EXIMAdvLicenseIODetails: Record "LFS EXIM License IO Details";
}