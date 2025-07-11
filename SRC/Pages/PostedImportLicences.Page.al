namespace LFSEximModule.LFSPLEXIMModule;

page 72079 "LFS Posted Import Licences"
{
    ApplicationArea = All;
    Caption = 'Posted Import Licences';
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
                field("CIF(FCY)"; Rec."LFS CIF(FCY)")
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