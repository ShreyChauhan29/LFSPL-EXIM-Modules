table 72035 "LFS Rodtep License Lines"
{
    Caption = 'Rodtep License Lines';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "LFS License No."; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'License No.';

        }
        field(2; "LFS Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(3; "LFS Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Type';
            OptionMembers = Import,Export,Domestic;
            OptionCaption = 'Import,Export,Domestic';
        }
        field(4; "LFS Document Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Type';
            OptionMembers = "Posted Invoice","Posted Credit Memo";
            OptionCaption = 'Posted Invoice,Posted Credit Memo';
        }
        field(5; "LFS Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(6; "LFS Document Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Line No.';
        }
        field(7; "LFS Item No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item No.';
        }
        field(8; "LFS Variant Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Variant Code';
        }
        field(9; "LFS Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(10; "LFS Qty."; decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty.';
        }
        field(11; "LFS UOM"; code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'UOM';
        }
        field(12; "LFS CIF Value(FC)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'CIF Value(FCY)';
        }
        field(13; "LFS CIF Value (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'CIF Value (LCY)';
        }
        field(14; "LFS RoDTEP Value (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'RoDTEP Value (LCY)';
        }
        field(15; "LFS FOB Amount (LCY)"; decimal)
        {
            Caption = 'FOB (LCY)';
            DataClassification = CustomerContent;
        }
        field(16; "LFS FOB Amount (FCY)"; Decimal)
        {
            Caption = 'FOB (FCY)';
            DataClassification = CustomerContent;
        }
        field(17; "LFS Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionMembers = Utilization,Sales,Loss,"Credit Memo";
            OptionCaption = 'Utilization,Sales,Loss,Credit Memo';
        }
    }

    keys
    {
        key(Key1; "LFS License No.", "LFS Line No.")
        {
            Clustered = true;
        }
    }
}