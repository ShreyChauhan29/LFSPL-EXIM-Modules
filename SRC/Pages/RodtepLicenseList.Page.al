namespace LFSEximModule.LFSPLEXIMModule;

page 72050 "LFS Rodtep License List"
{
    ApplicationArea = All;
    Caption = 'Rodtep License List';
    PageType = List;
    SourceTable = "LFS Rodtep License Header";
    UsageCategory = Lists;
    Editable = false;
    CardPageID = "LFS Rodtep License Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."LFS No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the No.';
                }
                field("Issue Date"; Rec."LFS Issue Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Issue Date';
                }
                field("Expiry Date"; Rec."LFS Expiry Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Expiry Date';
                }
                field("Rodtep Value LCY"; Rec."LFS Rodtep Value LCY")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Rodtep Value LCY';
                }
                field("Balance LCY"; Rec."LFS Balance LCY")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Balance LCY';
                }
                field("Consumed Rodtep Value LCY"; Rec."LFS Con Rodtep Value LCY")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Consumed Rodtep Value LCY';
                }
            }
        }
    }
}