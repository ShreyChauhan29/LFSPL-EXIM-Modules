namespace LFSEximModule.LFSPLEXIMModule;

table 72002 "LFS EXIM Shipping Line"
{
    Caption = 'Shipping Line';
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
    }

    keys
    {
        key(Key1; "LFS Code")
        {
            Clustered = true;
        }
    }
}