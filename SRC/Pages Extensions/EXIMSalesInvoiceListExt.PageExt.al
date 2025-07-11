namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.Document;

pageextension 72024 "LFSEXIM Sales Invoice List Ext" extends "Sales Invoice List"
{
    trigger OnOpenPage()
    begin
        Rec.SetFilter("LFS EXIM Type", '%1', Rec."LFS EXIM Type"::" ");
    end;
}
