namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.Document;

pageextension 72028 "LFS Sales Order Subform Ext." extends "Sales Order Subform"
{
    actions
    {
        addafter("Co&mments")
        {
            action("LFS Packing List")
            {
                ApplicationArea = all;
                // PromotedCategory = Process;
                // Promoted = true;
                // PromotedIsBig = true;
                ToolTip = 'Packing List';
                Image = TaskPage;
                Caption = 'Packing List';
                trigger OnAction()
                var
                    PackingList: Record "LFS EXIM Packing List Tab.";
                    PackingListPage: page "LFS EXIM Packing List";
                begin
                    PackingList.SetRange("LFS Source Document No.", Rec."Document No.");
                    PackingList.SetRange("LFS Source Doc. Line No.", Rec."Line No.");
                    PackingList.setrange("LFS Source Order No.", Rec."Document No.");
                    PackingList.setrange("LFS Source Order Line No.", Rec."Line No.");
                    PackingList.setrange("LFS Source Document Type", PackingList."LFS Source Document Type"::"Sales Order");
                    PackingListPage.SetRecord(PackingList);
                    PackingListPage.SetTableView(PackingList);
                    Page.RunModal(page::"LFS EXIM Packing List", PackingList);
                end;
            }
        }
    }
}