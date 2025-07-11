namespace LFSEximModule.LFSPLEXIMModule;
table 72036 "EXIM Group Master"
{
    Caption = 'EXIM Group Master';
    DataClassification = CustomerContent;
    DrillDownPageId = "Exim Group Master";
    LookupPageId = "Exim Group Master";

    fields
    {
        field(1; "LFS EXIM Type"; Enum "LFS EXIM Type")
        {
            Caption = 'EXIM Type';
        }
        field(2; "LFS Group No."; Code[20])
        {
            Caption = 'Group No.';
        }
        field(3; "LFS Group Name"; Text[100])
        {
            Caption = 'Group Name';
        }
        field(4; "LFS ITCHS Code"; Code[10])
        {
            Caption = 'ITCHS Code';
        }
    }
    keys
    {
        key(PK; "LFS Group No.", "LFS EXIM Type")
        {
            Clustered = true;
        }
    }
}