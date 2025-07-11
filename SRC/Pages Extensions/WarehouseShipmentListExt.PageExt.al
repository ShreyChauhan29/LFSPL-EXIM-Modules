namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Warehouse.Document;

pageextension 72034 "LFSWarehouse Shipment List Ext" extends "Warehouse Shipment List"
{
    trigger OnOpenPage()
    begin
        Rec.SetFilter("LFS EXIM Type", '%1', Rec."LFS EXIM Type"::" ");
    end;
}
