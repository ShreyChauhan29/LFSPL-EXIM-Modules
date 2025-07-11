namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.History;

pageextension 72014 "LFS Posted Sales Shipments Ext" extends "Posted Sales Shipments"
{
    trigger OnOpenPage()
    begin
        Rec.SetFilter("LFS EXIM Type", '%1', Rec."LFS EXIM Type"::" ");
    end;
}
