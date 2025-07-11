namespace LFSEximModule.LFSPLEXIMModule;
table 72014 "LFS EXIM Item Group Code"
{
    Caption = 'EXIM Item Group Code';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "LFS Group Code No."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Group Code No.';

        }
        field(2; "LFS Description"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "LFS Group Code No.")
        {
            Clustered = true;
        }
    }
}