namespace LFSEximModule.LFSPLEXIMModule;

page 72014 "LFS EXIM Item Group"
{
    ApplicationArea = All;
    Caption = 'EXIM Item Group';
    PageType = List;
    SourceTable = "LFS EXIM Item Group";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
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
                field("EXIM Type"; Rec."LFS EXIM Type")
                {
                    ToolTip = 'Specifies the value of the EXIM Type field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}