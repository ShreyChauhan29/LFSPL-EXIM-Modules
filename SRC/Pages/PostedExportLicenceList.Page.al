namespace LFSEximModule.LFSPLEXIMModule;

page 72034 "LFS Posted Export Licence List"
{
    ApplicationArea = All;
    Caption = 'Posted Export Licence List';
    PageType = List;
    SourceTable = "LFS EXIM Posted Export Licence";
    UsageCategory = History;
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("License Type"; Rec."LFS License Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the License Type';
                }
                field("License No."; Rec."LFS License No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the License No.';
                }
                field(Quantity; Rec."LFS Quantity")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Quantity';
                }
                field("FOB (FCY)"; Rec."LFS FOB (FCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the FOB (FCY)';
                }
                field("Unit Price"; Rec."LFS Unit Price")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Unit Price';
                }
                field("Export Inv Bal Qty"; Rec."LFS Export Inv Bal Qty")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Export Inv Bal Qty';
                }
                field("LFS Exim Group No."; Rec."LFS Exim Group No.")
                {
                    ToolTip = 'Specifies the value of the Exim Group No. field.', Comment = '%';
                }
            }
        }
    }
}