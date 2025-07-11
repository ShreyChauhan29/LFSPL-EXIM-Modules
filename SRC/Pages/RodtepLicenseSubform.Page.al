namespace LFSEximModule.LFSPLEXIMModule;

page 72052 "LFS Rodtep License Subform"
{
    ApplicationArea = All;
    Caption = 'Rodtep License Subform';
    PageType = ListPart;
    SourceTable = "LFS Rodtep License Lines";
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("License No."; Rec."LFS License No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the License No.';
                }
                field(Type; Rec."LFS Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Type';
                }
                field("LFS Entry Type"; Rec."LFS Entry Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Entry Type';
                }
                field("Document Type"; Rec."LFS Document Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Document Type';
                }
                field("Document No."; Rec."LFS Document No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Document No.';
                }
                field("Document Line No."; Rec."LFS Document Line No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Document Line No.';
                }
                field("Item No."; Rec."LFS Item No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Item No.';
                }
                field("Variant Code"; Rec."LFS Variant Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Variant Code';
                }
                field(Description; Rec."LFS Description")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Description';
                }
                field("Qty."; Rec."LFS Qty.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the "Qty."';
                }
                field(UOM; Rec."LFS UOM")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the UOM';
                }
                field("CIF Value(FC)"; Rec."LFS CIF Value(FC)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the CIF Value(FCY)';
                }
                field("CIF Value (LCY)"; Rec."LFS CIF Value (LCY)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the CIF Value (LCY)';
                }
                field("RoDTEP Value (LCY)"; Rec."LFS RoDTEP Value (LCY)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the RoDTEP Value (LCY)';
                }
                field("LFS FOB Amount (FCY)"; Rec."LFS FOB Amount (FCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FOB (FCY) field.', Comment = '%';
                }
                field("LFS FOB Amount (LCY)"; Rec."LFS FOB Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FOB (LCY) field.', Comment = '%';
                }
            }
        }
    }
}