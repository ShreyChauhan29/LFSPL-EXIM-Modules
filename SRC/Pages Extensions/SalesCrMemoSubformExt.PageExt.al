namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.Document;

pageextension 72022 "LFS Sales Cr. Memo Subform Ext" extends "Sales Cr. Memo Subform"
{
    layout
    {
        addafter(Exempted)
        {
            field("Incentive Type"; Rec."LFS Incentive Type")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the Incentive Type';
            }
            field("FOB (FC)"; Rec."LFS FOB Amount (FCY)")
            {
                ApplicationArea = all;
                Editable = false;
                Caption = 'FOB (FCY)';
                ToolTip = 'Specifies the FOB (FCY)';
            }
            field("FOB (LC)"; Rec."LFS FOB Amount (LCY)")
            {
                ApplicationArea = all;
                Editable = false;
                Caption = 'FOB (LCY)';
                ToolTip = 'Specifies the FOB (LCY)';
            }
            field("FOB (FCY) Per Unit"; Rec."LFS FOB Amount (FCY)")
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Specifies the FOB (FCY) Per Unit';
            }
            field("LFS CIF(FCY)"; Rec."LFS CIF Value (FCY)")
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Specifies the CIF(FCY)';
            }
            field("LFS CIF(LCY)"; Rec."LFS CIF Value (LCY)")
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Specifies the CIF(LCY)';
            }
            field("CIF (FCY) Per Unit"; Rec."LFS CIF Amount (FCY)")
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Specifies the CIF (FCY) Per Unit';
            }
            field("Freight Value Per Type (FCY)"; Rec."LFS Freight Value (FCY)")
            {
                ApplicationArea = all;
                Caption = 'Freight Value (FCY)';
                ToolTip = 'Specifies the Freight Value (FCY)';
            }
            field("Freight Value Per Type (LCY)"; Rec."LFS Freight Value (LCY)")
            {
                ApplicationArea = all;
                Caption = 'Freight Value (LCY)';
                Editable = false;
                ToolTip = 'Specifies the Freight Value (LCY)';
            }
            field("Insurance Value Per Type (FCY)"; Rec."LFS Insurance Value (FCY)")
            {
                ApplicationArea = all;
                Caption = 'Insurance Value (FCY)';
                ToolTip = 'Specifies the Insurance Value (FCY)';
            }
            field("Insurance Value Per Type (LCY)"; Rec."LFS Insurance Value (LCY)")
            {
                ApplicationArea = all;
                Caption = 'Insurance Value (LCY)';
                Editable = false;
                ToolTip = 'Specifies the Insurance Value (LCY)';
            }

        }
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
        addafter("Qty. Assigned")
        {
            field("LFS Exim Group No."; Rec."LFS Exim Group No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Exim Group No. field.', Comment = '%';
            }
        }
        modify("Variant Code")
        {
            Visible = true;
        }
    }
    actions
    {
        addafter("Co&mments")
        {
            action("LFS Licenses")
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
                    EXIM_License2.Reset();
                    EXIM_License2.setrange("LFS Source No.", Rec."Document No.");
                    EXIM_License2.setrange("LFS Source line No.", Rec."Line No.");
                    if Rec."LFS Exim Group No." <> '' then
                        EXIM_License2.SetRange("LFS Exim Group No.", Rec."LFS Exim Group No.");
                    EXIM_licenseList.SetTableView(EXIM_License2);
                    EXIM_licenseList.SetRecord(EXIM_License2);
                    EXIM_licenseList.run();
                end;
            }
        }
    }
}