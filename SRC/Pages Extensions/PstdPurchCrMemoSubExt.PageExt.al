namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.History;

pageextension 72009 "LFS PstdPurch.Cr.Memo Sub. Ext" extends "Posted Purch. Cr. Memo Subform"
{
    layout
    {
        addafter("Line Amount")
        {
            field("LFS CIF Amount (FCY)"; Rec."LFS CIF Amount (LCY)")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the CIF (FCY)';
            }
            field("LFS CIF Amount (LCY)"; Rec."LFS CIF Amount (LCY)")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the CIF (LCY)';
            }
        }
        modify("Variant Code")
        {
            Visible = true;
        }
    }

    actions
    {
        addafter(Comments)
        {
            action("LFS Licenses")
            {
                Caption = 'Multiple License';
                ToolTip = 'Specifies the Multiple License';
                ApplicationArea = all;
                Image = Task;
                RunObject = page "LFS Posted Import Licence List";
                RunPageLink = "LFS Source No." = field("Document No."), "LFS Source line No." = field("Line No.");
            }
        }
    }
}