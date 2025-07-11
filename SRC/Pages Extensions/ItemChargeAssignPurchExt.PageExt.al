namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.Document;

pageextension 72036 "LFSItem Charge AssignPurch Ext" extends "Item Charge Assignment (Purch)"
{
    actions
    {
        modify(GetSalesShipmentLines)
        {
            trigger OnBeforeAction()
            var
                Selection: Integer;
                ImportDomesticLbl: Label '&Domestic,&Export';
                Text002Lbl: Label 'Choose one of the following options:';
            begin
                Selection := Dialog.STRMENU(ImportDomesticLbl, 1, Text002Lbl);
                if Selection = 1 then
                    Rec."LFS Import & Domestic" := true
                else
                    Rec."LFS Import & Domestic" := false;
            end;
        }
    }
}