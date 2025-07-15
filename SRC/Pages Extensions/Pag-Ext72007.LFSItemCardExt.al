namespace LFSEXIMModule.LFSPLEXIMModules;

using Microsoft.Inventory.Item;

pageextension 72007 "LFS Item Card Ext." extends "Item Card"
{
    layout
    {
        addlast(Item)
        {
            field("LFS Exim Group No."; Rec."LFS Exim Group No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Exim Group No. field.', Comment = '%';
            }
        }
    }
}
