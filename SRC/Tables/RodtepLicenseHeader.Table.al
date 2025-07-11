namespace LFSEximModule.LFSPLEXIMModule;
table 72034 "LFS Rodtep License Header"
{
    Caption = 'Rodtep License Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "LFS No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(2; "LFS Description"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(3; "LFS Issue Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Issue Date';
        }
        field(4; "LFS Expiry Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Expiry Date';
        }
        field(5; "LFS Status"; option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionMembers = " ",Created,Active,Closed;
            OptionCaption = ' ,Created,Active,Closed';
        }
        field(6; "LFS Rodtep Value LCY"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Rodtep Value LCY';
        }
        field(7; "LFS Balance LCY"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Balance LCY';
        }
        field(8; "LFS Con Rodtep Value LCY"; Decimal)
        {
            AutoFormatType = 1;
            FieldClass = FlowField;
            CalcFormula = sum("LFS Rodtep License Lines"."LFS RoDTEP Value (LCY)" where("LFS License No." = field("LFS No.")));
            Editable = false;
            Caption = 'Consumed Rodtep Value LCY';

        }
        field(9; "LFS Remarks"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Remarks';
        }
    }

    keys
    {
        key(Key1; "LFS No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "LFS No.", "LFS Description", "LFS Balance LCY")
        { }
    }
}