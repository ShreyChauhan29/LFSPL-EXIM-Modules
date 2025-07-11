namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.Document;

pageextension 72023 "LFS EXIM Sales Invoice Ext." extends "Sales Invoice"
{
    layout
    {
        addafter("External Document No.")
        {
            field("LFS Your Reference Date"; Rec."LFS Your Reference Date")
            {
                Caption = 'Customer Order Date';
                ToolTip = 'Specifies the Customer Order Date';
                ApplicationArea = all;
            }
        }
    }
}