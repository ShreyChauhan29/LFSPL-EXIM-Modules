namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Warehouse.History;

pageextension 72015 "LFS Posted Whse. Shpt List Ext" extends "Posted Whse. Shipment List"
{
    trigger OnOpenPage()
    begin
        Rec.SetFilter("LFS EXIM Type", '%1', Rec."LFS EXIM Type"::" ");
    end;
}
