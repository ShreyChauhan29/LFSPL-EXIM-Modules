namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Finance.GST.Base;

pageextension 72006 "LFS GST Registration Nos. Ext." extends "GST Registration Nos."
{
    layout
    {
        addafter("State Code")
        {
            field("LFS LUT No."; Rec."LFS LUT No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the LUT No.';
                Visible = true;
            }
            field("LFS LUT Date"; Rec."LFS LUT Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the LUT Date';
                Visible = true;
            }
        }
    }
}
