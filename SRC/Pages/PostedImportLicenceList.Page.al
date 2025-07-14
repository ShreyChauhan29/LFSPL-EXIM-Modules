namespace LFSEximModule.LFSPLEXIMModule;

page 72035 "LFS Posted Import Licence List"
{
    ApplicationArea = All;
    Caption = 'Posted Import Licence List';
    PageType = List;
    SourceTable = "LFS EXIM Posted Import Licence";
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
                    ToolTip = 'Specifies the Quantity';
                }
                field("Unit Cost"; Rec."LFS Unit Cost")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Unit Cost';
                }
                field("CIF(FCY)"; Rec."LFS CIF Value (FCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the CIF(FCY)';
                }
                field("Import Inv Bal Qty"; Rec."LFS Import Inv Bal Qty")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the Import Inv Bal Qty';
                }
                field("RoDTEP Consumption Value"; Rec."LFS RoDTEP Consump Value")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the RoDTEP Consumption Value';
                }
            }
        }
    }
}