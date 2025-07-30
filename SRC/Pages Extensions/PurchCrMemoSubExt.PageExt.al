namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.Document;

pageextension 72017 "LFS Purch. Cr. Memo Sub. Ext." extends "Purch. Cr. Memo Subform"
{
    layout
    {
        addafter("Qty. Assigned")
        {
            field("LFS CIF Currency Code"; Rec."LFS CIF Currency Code")
            {
                ToolTip = 'Specifies the value of the CIF Currency Code field.', Comment = '%';
            }
            field("LFS CIF Currency Factor"; Rec."LFS CIF Currency Factor")
            {
                ToolTip = 'Specifies the value of the CIF Currency Factor field.', Comment = '%';
            }
            field("LFS USD CIF (FCY)"; Rec."LFS USD CIF (FCY)")
            {
                ToolTip = 'Specifies the value of the USD CIF (FCY) field.', Comment = '%';
            }
            field("LFS USD CIF (LCY)"; Rec."LFS USD CIF (LCY)")
            {
                ToolTip = 'Specifies the value of the USD CIF (LCY) field.', Comment = '%';
            }
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
            field("LFS Exim Group No."; Rec."LFS Exim Group No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Exim Group No. field.', Comment = '%';
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