namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Inventory.Item;

tableextension 72004 "LFS EXIM Item Ext." extends Item
{
    fields
    {
        field(72000; "LFS EXIM Item Group"; Code[50])
        {
            Caption = 'EXIM Item Group';
            DataClassification = CustomerContent;
        }
        field(72001; "LFS Exim Group No."; Code[20])
        {
            Caption = 'Exim Group No.';
            DataClassification = CustomerContent;
            TableRelation = "EXIM Group Master"."LFS Group No.";
        }
    }
}
