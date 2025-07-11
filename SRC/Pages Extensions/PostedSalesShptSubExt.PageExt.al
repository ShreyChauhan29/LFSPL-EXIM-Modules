namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.History;

pageextension 72032 "LFS Posted Sales Shpt. Sub Ext" extends "Posted Sales Shpt. Subform"
{
    layout
    {
        addafter("ShortcutDimCode[4]")
        {
            field("LFS Item/Value Entry No."; Rec."LFS Item/Value Entry No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Ledger Entry No. field.', Comment = '%';
            }
            field("LFS Item Charge No."; Rec."LFS Item Charge No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the LFS Item Charge No. field.', Comment = '%';
            }
        }
    }
    actions
    {
        addafter(Comments)
        {
            action("LFS Packing List")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Packing List';
                Image = Report;
                trigger OnAction()
                var
                    EXIMPackingLines: Record "LFS EXIM Posted Packing Table";
                    EXIMPackingLinespage: Page "LFS Posted Packing List";
                begin
                    EXIMPackingLines.SetRange("LFS Posted Export Shipment", Rec."Document No.");
                    EXIMPackingLines.SetRange("LFS PostExShipmentLineNo.", Rec."Line No.");
                    EXIMPackingLinespage.SetTableView(EXIMPackingLines);
                    Page.RunModal(page::"LFS Posted Packing List", EXIMPackingLines);
                end;
            }
        }
    }
}