namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.History;

pageextension 72011 "LFS Pstd.SalesInvoice Sub. Ext" extends "Posted Sales Invoice Subform"
{
    layout
    {
        addafter("Line Amount")
        {
            field("LFS RoDTEP License No."; Rec."LFS RoDTEP License No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the RoDTEP License No. Value.';
            }
            field("LFSRoDTEP License Sales Values"; Rec."LFSRoDTEP License Sales Values")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the RoDTEP License Sales Values.';
            }
        }
    }
}
