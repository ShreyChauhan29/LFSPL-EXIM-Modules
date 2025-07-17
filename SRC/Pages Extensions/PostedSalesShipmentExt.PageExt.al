namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.History;

pageextension 72013 "LFS Posted Sales Shipment Ext." extends "Posted Sales Shipment"
{
    actions
    {
        addafter("Co&mments")
        {
            action("LFS Export Information")
            {
                ApplicationArea = all;
                ToolTip = 'Export Information';
                Image = ViewDetails;
                Promoted = true;
                PromotedCategory = Category5;
                trigger OnAction()
                var
                    Export: Record "LFS Posted Export Information";
                    exportInfor: Page "LFS Posted Export Information";
                begin
                    export.SetRange("LFS Document Type", Export."LFS Document Type"::Shipment);
                    Export.SetRange("LFS Document No.", Rec."No.");
                    exportInfor.SetTableView(Export);
                    Page.RunModal(Page::"LFS Posted Export Information", Export)
                end;
            }
            // action("LFS Factory Packing List")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Factory Packing List';
            //     Image = Report;
            //     Promoted = true;
            //     PromotedCategory = Report;
            //     PromotedIsBig = true;
            //     trigger OnAction()
            //     var
            //         SalesShptHeader: Record "Sales Shipment Header";
            //     begin
            //         SalesShptHeader.Reset();
            //         SalesShptHeader.SETRANGE("No.", Rec."No.");
            //         if SalesShptHeader.FindFirst() then
            //             REPORT.RUNMODAL(70240, true, true, SalesShptHeader);
            //     end;
            // }
        }
    }
}