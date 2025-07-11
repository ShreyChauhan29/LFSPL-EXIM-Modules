namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.Document;

pageextension 72031 "LFS Sales Return Order Sub Ext" extends "Sales Return Order Subform"
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