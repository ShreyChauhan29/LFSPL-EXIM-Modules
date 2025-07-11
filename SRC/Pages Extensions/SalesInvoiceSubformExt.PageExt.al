namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.Document;

pageextension 72025 "LFS Sales Invoice Subform Ext." extends "Sales Invoice Subform"
{
    layout
    {
        addafter("Line Amount")
        {
            field("LFS RoDTEP License No."; Rec."LFS RoDTEP License No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the RoDTEP License No. Value.';
            }
            field("LFSRoDTEP License Sales Values"; Rec."LFSRoDTEP License Sales Values")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the RoDTEP License Sales Values.';
            }
        }
    }
    actions
    {
        addafter("Co&mments")
        {
            action("LFS Packing List")
            {
                ApplicationArea = all;
                Image = ListPage;
                Caption = 'Packing List';
                ToolTip = 'Specifies the Packing List';
                trigger OnAction()
                var
                    PackingList: Record "LFS EXIM Packing List Tab.";
                    PackingListPage: page "LFS EXIM Packing List";
                begin
                    PackingList.SetRange("LFS Source Document No.", Rec."No.");
                    PackingList.SetRange("LFS Source Doc. Line No.", Rec."Line No.");
                    PackingList.SetRange("LFS Source Order No.", Rec."LFS Source No.");
                    PackingList.SetRange("LFS Source Order Line No.", Rec."LFS Source Line No.");
                    PackingListPage.SetTableView(PackingList);
                    Page.Run(page::"LFS EXIM Packing List", PackingList);
                end;
            }
            action(Licenses)
            {
                Caption = 'Multiple License';
                ToolTip = 'Specifies the Multiple License';
                ApplicationArea = all;
                Image = Task;
                trigger OnAction()
                var
                    EXIM_License2: Record "LFS EXIM Export License";
                    EXIM_licenseList: Page "LFS EXIM Export License";

                begin
                    if rec."LFS Incentive Type" <> Rec."LFS Incentive Type"::DDB then begin
                        EXIM_License2.Reset();
                        EXIM_License2.setrange("LFS Source No.", Rec."Document No.");
                        EXIM_License2.setrange("LFS Source line No.", Rec."Line No.");
                        EXIM_licenseList.SetTableView(EXIM_License2);
                        EXIM_licenseList.SetRecord(EXIM_License2);
                        EXIM_licenseList.run();
                    end
                    else
                        Error('Incentive type DDB is defined for this invoice line');
                end;
            }
        }
    }
}