namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Foundation.Company;

pageextension 72004 "LFS Company Information Ext." extends "Company Information"
{
    layout
    {
        addafter("Company Badge")
        {
            group("LFS Exim")
            {
                field("LFS R.B.I. CODE NO."; Rec."LFS R.B.I. CODE NO.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the R.B.I. CODE NO. -  Authorised Dealer (AD) Code';
                }
                field("LFS I.E.C. CODE NO."; Rec."LFS I.E.C. CODE NO.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the I.E.C. CODE NO. - Importer - Exporter Code';
                }
            }
        }
    }
}
