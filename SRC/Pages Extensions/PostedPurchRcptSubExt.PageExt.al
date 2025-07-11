namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.History;

pageextension 72037 "LFS Posted Purch Rcpt. Sub Ext" extends "Posted Purchase Rcpt. Subform"
{
    layout
    {
        addafter("ShortcutDimCode[4]")
        {
            field("LFS Item/Value Entry No."; Rec."LFS Item/Value Entry No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Ledger Entry No. field.', Comment = '%';
            }
            field("LFS Item Charge No."; Rec."LFS Item Charge No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the LFS Item Charge No. field.', Comment = '%';
            }
        }
        modify("Variant Code")
        {
            Visible = true;
        }
        modify("ShortcutDimCode[3]")
        {
            Visible = true;
        }
        modify("ShortcutDimCode[4]")
        {
            Visible = true;
        }
    }
}