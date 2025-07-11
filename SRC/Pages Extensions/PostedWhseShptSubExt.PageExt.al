namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Warehouse.History;

pageextension 72016 "LFS Posted Whse. Shpt. Sub Ext" extends "Posted Whse. Shipment Subform"
{
    actions
    {
        addafter("Posted Source Document")
        {
            action("LFS Packing List")
            {
                ApplicationArea = All;
                Image = ListPage;
                Caption = 'Packing List';
                ToolTip = 'Specifies the Packing List';
                trigger OnAction()
                var
                    PackingList: Record "LFS EXIM Posted Packing Table";
                    PackingListPage: page "LFS Posted Packing List";
                begin
                    PackingList.SetRange("LFS PostedWhseShipment", Rec."No.");
                    PackingList.SetRange("LFS PostWhseShipmentLineNo", Rec."Line No.");
                    PackingListPage.SetTableView(PackingList);
                    Page.RunModal(page::"LFS Posted Packing List", PackingList);
                end;
            }
        }
    }
}