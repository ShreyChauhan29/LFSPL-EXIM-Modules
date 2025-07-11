namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Inventory.Item;
table 72015 "LFS EXIM Item Group Code Line"
{
    Caption = 'EXIM Item Group Code Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "LFS Group Code No."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Group Code No.';
        }
        field(2; "LFS Item No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Item;
            Caption = 'Item No.';

            trigger OnValidate()
            var
                Item: Record Item;
            begin
                if Item.Get("LFS Item No.") then begin
                    "LFS Description" := Item.Description;
                    "LFS UOM" := Item."Base Unit of Measure";
                end else
                    if "LFS Item No." = '' then begin
                        "LFS Description" := '';
                        "LFS UOM" := '';
                    end;
            end;
        }
        field(3; "LFS Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(4; "LFS UOM"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'UOM';
        }
        field(5; "LFS Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
            Editable = false;
            AutoIncrement = true;
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