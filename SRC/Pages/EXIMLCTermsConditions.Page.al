namespace LFSEximModule.LFSPLEXIMModule;

page 72018 "LFS EXIM LC Terms & Conditions"
{
    ApplicationArea = All;
    Caption = 'EXIM LC Terms & Conditions';
    PageType = List;
    SourceTable = "LFS EXIM LC Terms & Conditions";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
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
                field("Additional Description"; Rec."LFS Additional Description")
                {
                    ToolTip = 'Specifies the value of the Additional Description field.';
                    ApplicationArea = All;
                }
                field("Insert Default in LC Details"; Rec."LFS Insert DefaultLCDetails")
                {
                    ToolTip = 'Specifies the value of the Insert Default in LC Details field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
