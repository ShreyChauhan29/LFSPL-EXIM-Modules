namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.History;

pageextension 72012 "LFS Posted Sales Invoice Ext." extends "Posted Sales Invoice"
{
    layout
    {
        modify("External Document No.")
        {
            Caption = 'Customer Order No.';
        }
        addafter("External Document No.")
        {
            field("LFS Your Reference Date"; Rec."LFS Your Reference Date")
            {
                ApplicationArea = all;
                ToolTip = 'Customer Order Date';
            }
        }
    }

    actions
    {
        addafter("Co&mments")
        {
            action("LFS Export Information")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the Export Information';
                Image = ViewDetails;
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction()
                var
                    Export: Record "LFS Posted Export Information";
                    exportInfor: Page "LFS Posted Export Information";
                begin
                    export.SetRange("LFS Document Type", Export."LFS Document Type"::Invoice);
                    Export.SetRange("LFS Document No.", Rec."No.");
                    exportInfor.SetTableView(Export);
                    Page.RunModal(Page::"LFS Posted Export Information", Export)
                end;
            }
        }
    }
}