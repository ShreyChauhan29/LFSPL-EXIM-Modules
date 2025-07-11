namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.Setup;

pageextension 72029 "LFS Sales & Receivables Setup" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Journal Templates")
        {
            field("LFS WorkSheet Template Name"; Rec."LFS WorkSheet Template Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the WorkSheet Template Name';
            }
        }
    }
}
