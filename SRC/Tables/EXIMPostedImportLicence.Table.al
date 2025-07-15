namespace LFSEximModule.LFSPLEXIMModule;
table 72023 "LFS EXIM Posted Import Licence"
{
    Caption = 'EXIM Posted Import Licence';
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
            TableRelation = if ("LFS License Type" = const("Adv. License")) "LFS EXIM License Header" where("LFS Import Inv Bal Qty" = filter(> 0))
            else if ("LFS License Type" = const(RoDTEP)) "LFS Rodtep License Header";
            DataClassification = CustomerContent;
            Caption = 'License No.';

        }
        field(7; "LFS Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity';

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
        }
        field(19; "LFS Exim Group No."; Code[20])
        {
            Caption = 'Exim Group No.';
            TableRelation = "EXIM Group Master"."LFS Group No.";
        }
    }

    keys
    {
        key(Key1; "LFS Source Type", "LFS Source No.", "LFS Source line No.", "LFS Line No.")
        {
            Clustered = true;
        }
    }
}