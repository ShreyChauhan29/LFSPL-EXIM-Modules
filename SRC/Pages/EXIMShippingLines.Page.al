namespace LFSEximModule.LFSPLEXIMModule;

page 72002 "LFS EXIM Shipping Lines"
{
    ApplicationArea = All;
    Caption = 'EXIM Shipping Lines';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "LFS EXIM Shipping Line";
    layout
    {
        area(content)
        {
            repeater("Group")
            {
                field("Code"; Rec."LFS Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field(Description; Rec."LFS Description")
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}