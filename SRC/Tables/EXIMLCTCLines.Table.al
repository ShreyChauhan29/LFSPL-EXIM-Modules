namespace LFSEximModule.LFSPLEXIMModule;
table 72017 "LFS EXIM LC T&C Lines"
{
    Caption = 'EXIM LC T&C Lines';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "LFS No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(2; "LFS Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(3; "LFS Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(4; "LFS Description"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(5; "LFS Additional Description"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Additional Description';
        }
    }

    keys
    {
        key(Key1; "LFS No.")
        {
            Clustered = true;
        }
    }
}