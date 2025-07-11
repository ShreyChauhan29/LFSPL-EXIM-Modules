namespace LFSEximModule.LFSPLEXIMModule;
table 72006 "LFS EXIM Doc. Check ListMaster"
{
    Caption = 'EXIM Doc. Check List Master';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "LFS Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(2; "LFS Description"; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "LFS Additional Description"; Text[250])
        {
            Caption = 'Additional Description';
            DataClassification = CustomerContent;
        }
        field(4; "LFS Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
            OptionMembers = " ",Bank,Customer,Vendor,Customs,DGFT,Internal,Other;
            OptionCaption = ' ,Bank,Customer,Vendor,Customs,DGFT,Internal,Other';
        }
        field(5; "LFS Incoming Outgoing Doc"; Option)
        {

            DataClassification = CustomerContent;
            Caption = 'Incoming / Outgoing Document';
            OptionMembers = " ",Incoming,Outgoing;
            OptionCaption = ' ,Incoming,Outgoing';
        }
        field(6; "LFS Insert DefaultLCDetails"; Boolean)
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
