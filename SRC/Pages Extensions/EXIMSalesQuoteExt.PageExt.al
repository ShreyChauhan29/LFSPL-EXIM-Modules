namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.Document;

pageextension 72005 "LFS EXIM Sales Quote Ext." extends "Sales Quote"
{
    layout
    {
        addafter(Status)
        {
            field("LFS EXIM Type"; Rec."LFS EXIM Type")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the EXIM Type';
                trigger OnValidate()
                begin
                    if rec."LFS EXIM Type" = Rec."LFS EXIM Type"::Import then
                        error('You cannot select Import for this document');
                end;
            }
        }
    }
}
