namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.History;

pageextension 72010 "LFS Posted Purch. Invoices Ext" extends "Posted Purchase Invoices"
{
    trigger OnOpenPage()
    begin
        Rec.SetFilter("LFS EXIM Type", '%1', Rec."LFS EXIM Type"::" ");
    end;
}
