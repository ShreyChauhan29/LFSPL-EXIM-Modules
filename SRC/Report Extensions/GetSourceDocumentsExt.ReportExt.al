namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Warehouse.Request;
using Microsoft.Sales.Document;
using Microsoft.Warehouse.Document;

reportextension 72000 "LFS Get Source Documents Ext" extends "Get Source Documents"
{

    var
        WhseShptLine2: Record "Warehouse Shipment Line";
        NoWhseShipmLinesActionCaptionMsg: Label 'Show open lines';
        Text009Err: Label 'This usually happens when Warehouse Shipment Lines have already been created for a sales %1. Or there were no changes to sales %1 quantities since you last created the warehouse shipment lines.', Comment = '%1 = Sales Order Type';
        Text0101Err: Label 'There are no new warehouse shipment lines to create';
        Text00301Err: Label 'There are no Warehouse Shipment Lines created.';

    procedure ShowShipmentDialogEXIM()
    var
        // SpecialHandlingMessage: Text[1024];
        ErrorNoLinesToCreate: ErrorInfo;
    begin
        if not LineCreated then begin
            ErrorNoLinesToCreate.Title := Text0101Err;
            ErrorNoLinesToCreate.Message := StrSubstNo(Text009Err, "Sales Header"."Document Type");
            ErrorNoLinesToCreate.PageNo := Page::"LFSExportWarehouseShipmentList";
            WhseShptLine2.SetRange("Source No.", "Sales Header"."No.", "Sales Header"."No.");
            ErrorNoLinesToCreate.CustomDimensions.Add('Source Type', Format(Database::"Sales Line"));
            ErrorNoLinesToCreate.CustomDimensions.Add('Source Subtype', Format("Sales Header"."Document Type"));
            ErrorNoLinesToCreate.CustomDimensions.Add('Source No.', Format("Sales Header"."No."));
            ErrorNoLinesToCreate.AddAction(NoWhseShipmLinesActionCaptionMsg, 5753, 'ReturnListofWhseShipments');
            if WhseShptLine2.FindFirst() then begin
                ErrorNoLinesToCreate.PageNo := Page::"LFSExportWarehouseShipmentList";
                Error(ErrorNoLinesToCreate);
            end
            else
                Error(Text00301Err);
        end;
    end;
}
