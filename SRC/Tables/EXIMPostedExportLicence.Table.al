namespace LFSEximModule.LFSPLEXIMModule;
table 72022 "LFS EXIM Posted Export Licence"
{
    Caption = 'EXIM Posted Export Licence';
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
            TableRelation = if ("LFS License Type" = const("Adv. License")) "LFS EXIM License Header" where("LFS Export Inv Bal Qty" = filter(> 0));
            DataClassification = CustomerContent;
            Caption = 'License No.';
        }
        field(7; "LFS Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity';

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