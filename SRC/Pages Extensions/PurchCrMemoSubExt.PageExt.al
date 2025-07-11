namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.Document;

pageextension 72017 "LFS Purch. Cr. Memo Sub. Ext." extends "Purch. Cr. Memo Subform"
{
    layout
    {
        addafter("Qty. Assigned")
        {
            field("LFS CIF Amount (FCY)"; Rec."LFS CIF Amount (FCY)")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the CIF Amount (FCY)';
            }
            field("LFS CIF Amount (LCY)"; Rec."LFS CIF Amount (LCY)")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the CIF Amount (LCY)';
            }
        }
        modify("Variant Code")
        {
            Visible = true;
        }
    }

    actions
    {
        addafter("Co&mments")
        {
            action("LFS Licenses")
            {
                Caption = 'Multiple License';
                ToolTip = 'Specifies the Multiple License';
                ApplicationArea = all;
                Image = Task;
                RunObject = page "LFS Import Licenses";
                RunPageLink = "LFS Source No." = field("Document No."), "LFS Source line No." = field("Line No.");
            }
        }
    }
}