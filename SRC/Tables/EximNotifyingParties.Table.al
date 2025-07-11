namespace LFSEximModule.LFSPLEXIMModule;
table 72030 "LFS Exim Notifying Parties"
{
    Caption = 'Exim Notifying Parties';
    DataClassification = CustomerContent;
    LookupPageId = "LFS EXIM Notify Parties";
    DrillDownPageId = "LFS EXIM Notify Parties";

    fields
    {
        field(1; "LFS Party Code"; Code[20])
        {
            Caption = 'Party Code';
            DataClassification = CustomerContent;
        }
        field(2; "LFS Party Name"; Text[250])
        {
            Caption = 'Party Name';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "LFS Party Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "LFS Party Code", "LFS Party Name")
        {
        }
    }
}