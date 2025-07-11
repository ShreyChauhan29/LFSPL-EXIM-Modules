namespace LFSEximModule.LFSPLEXIMModule;
table 72007 "LFSEXIM Document CheckListLine"
{
    Caption = 'EXIM Document CheckListLine';
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
        field(6; "LFS Document Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Type';
            OptionMembers = " ",Bank,Customer,Vendor,Customs,DGFT,Internal,Other;
            OptionCaption = ' ,Bank,Customer,Vendor,Customs,DGFT,Internal,Other';
        }
        field(7; "LFS Incoming Outgoing Doc"; Option)
        {

            DataClassification = CustomerContent;
            Caption = 'Incoming / Outgoing Document';
            OptionMembers = " ",Incoming,Outgoing;
            OptionCaption = ' ,Incoming,Outgoing';
        }
        field(8; "LFS Action By"; Text[100])
        {
            Caption = 'Action By';
            DataClassification = CustomerContent;
        }
        field(9; "LFS Action On"; Date)
        {
            Caption = 'Action On';
            DataClassification = CustomerContent;
        }
        field(10; "LFS Completed On"; Date)
        {
            Caption = 'Completed On';
            DataClassification = CustomerContent;
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