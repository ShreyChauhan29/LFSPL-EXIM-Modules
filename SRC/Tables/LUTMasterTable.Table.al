namespace LFSEXIMModule.LFSPLEXIMModule;
table 72008 "LFS LUT Master Table"
{
    Caption = 'LUT Master';
    DataClassification = CustomerContent;
    DrillDownPageId = "LFS LUT Master List";
    LookupPageId = "LFS LUT Master List";

    fields
    {
        field(1; "LFS LUT No."; Code[30])
        {
            Caption = 'LFS LUT No.';
        }
        field(2; "LFS LUT Expiry Date"; Date)
        {
            Caption = 'LFS LUT Expiry Date';
        }
    }
    keys
    {
        key(PK; "LFS LUT No.")
        {
            Clustered = true;
        }
    }
}
