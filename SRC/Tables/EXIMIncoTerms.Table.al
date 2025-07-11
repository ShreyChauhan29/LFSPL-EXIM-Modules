namespace LFSEximModule.LFSPLEXIMModule;

table 72003 "LFS EXIM Inco Terms"
{
    Caption = 'EXIM Inco Terms';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "LFS Code"; Code[50])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; "LFS Description"; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "LFS FOB CIF Calc. Type"; Option)
        {
            Caption = 'FOB/CIF Calculation Type';
            DataClassification = CustomerContent;
            OptionMembers = FOB,CIF;
            OptionCaption = 'FOB,CIF';
        }
    }

    keys
    {
        key(Key1; "LFS Code")
        {
            Clustered = true;
        }
    }
}