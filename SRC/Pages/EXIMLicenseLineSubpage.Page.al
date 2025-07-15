namespace LFSEximModule.LFSPLEXIMModule;

page 72026 "LFS EXIM License Line Subpage"
{
    ApplicationArea = All;
    Caption = 'EXIM License Line Subpage';
    PageType = ListPart;
    SourceTable = "LFS EXIM License Lines";
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Adv. License No."; Rec."LFS Adv. License No.")
                {
                    ToolTip = 'Specifies the value of the Adv. License No. field.';
                    ApplicationArea = All;
                }
                field("Line No."; Rec."LFS Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Type"; Rec."LFS Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."LFS Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                    ApplicationArea = All;
                }
                field("Document No."; Rec."LFS Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                    ApplicationArea = All;
                }
                field("Document Line No."; Rec."LFS Document Line No.")
                {
                    ToolTip = 'Specifies the value of the Document Line No. field.';
                    ApplicationArea = All;
                }
                field("Item No."; Rec."LFS Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."LFS Item Description")
                {
                    ToolTip = 'Specifies the value of the Item Description field.';
                    ApplicationArea = All;
                }
                field(UOM; Rec."LFS UOM")
                {
                    ToolTip = 'Specifies the value of the UOM field.';
                    ApplicationArea = All;
                }
                field("Qty."; Rec."LFS Qty.")
                {
                    ToolTip = 'Specifies the value of the Qty. field.';
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."LFS Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                    ApplicationArea = All;
                }
                field("FOB Value"; Rec."LFS FOB Value")
                {
                    ToolTip = 'Specifies the value of the FOB Value field.';
                    ApplicationArea = All;
                }
                field("CIF Value"; Rec."LFS CIF Value")
                {
                    ToolTip = 'Specifies the value of the CIF Value field.';
                    ApplicationArea = All;
                }
                field("Currency Exch. Rate"; Rec."LFS Currency Exch. Rate")
                {
                    ToolTip = 'Specifies the value of the Currency Factor field.';
                    ApplicationArea = All;
                }
                field("FOB LCY Value"; Rec."LFS FOB LCY Value")
                {
                    ToolTip = 'Specifies the value of the FOB LCY Value field.';
                    ApplicationArea = All;
                }
                field("CIF LCY Value"; Rec."LFS CIF LCY Value")
                {
                    ToolTip = 'Specifies the value of the CIF LCY Value field.';
                    ApplicationArea = All;
                }
                field("LFS Exim Group No."; Rec."LFS Exim Group No.")
                {
                    ToolTip = 'Specifies the value of the Exim Group No. field.', Comment = '%';
                }
            }
        }
    }
}