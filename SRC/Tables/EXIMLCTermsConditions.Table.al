namespace LFSEximModule.LFSPLEXIMModule;
table 72016 "LFS EXIM LC Terms & Conditions"
{
    Caption = 'EXIM LC Terms & Conditions';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "LFS Code"; Code[50])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; "LFS Description"; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "LFS Additional Description"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Additional Description';
        }
        field(4; "LFS Insert DefaultLCDetails"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Insert Default in LC Details';
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