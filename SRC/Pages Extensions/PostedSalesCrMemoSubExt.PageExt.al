namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.History;

pageextension 72008 "Posted Sales Cr. Memo Sub. Ext" extends "Posted Sales Cr. Memo Subform"
{
    layout
    {
        addafter("Line Amount")
        {
            field("LFS FOB Amount (FCY)"; rec."LFS FOB Amount (FCY)")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the FOB (FCY)';
            }
            field("LFS FOB Amount (LCY)"; Rec."LFS FOB Amount (LCY)")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the FOB (LCY)';
            }
            // field("LFS FOB Amount (FCY)"; Rec."LFS FOB Amount (FCY)")
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Specifies the FOB (FCY) Per Unit';
            // }
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
            field("LFS HS Code"; Rec."LFS HS Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the HS Code';
                Visible = false;
            }
        }
    }

    actions
    {
        addafter(Comments)
        {
            action("LFS Licenses")
            {
                Caption = 'Multiple License';
                ToolTip = 'Specifies the Multiple License';
                ApplicationArea = all;
                Image = Task;
                trigger OnAction()
                var
                    EXIM_License2: Record "LFS EXIM Posted Export Licence";
                    EXIM_licenseList: Page "LFS Posted Export Licence List";

                begin
                    EXIM_License2.Reset();
                    EXIM_License2.setrange("LFS Source No.", Rec."Document No.");
                    EXIM_License2.setrange("LFS Source line No.", Rec."Line No.");
                    EXIM_licenseList.SetTableView(EXIM_License2);
                    EXIM_licenseList.SetRecord(EXIM_License2);
                    EXIM_licenseList.run();
                end;
            }
        }
    }
}