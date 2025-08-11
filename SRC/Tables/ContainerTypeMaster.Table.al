namespace LFSEximModule.LFSPLEXIMModule;
table 72009 "LFS Container Type Master"
{
    Caption = 'Container Type Master';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "LFS Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "LFS Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "LFS Code")
        {
            Clustered = true;
        }
    }
}
