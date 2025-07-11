namespace LFSEximModule.LFSPLEXIMModule;

page 72003 "LFS EXIM Inco Terms"
{
    ApplicationArea = All;
    Caption = 'EXIM Inco Terms';
    PageType = List;
    SourceTable = "LFS EXIM Inco Terms";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec."LFS Code")
                {
                    Caption = 'Code';
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field(Description; Rec."LFS Description")
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field(Type; Rec."LFS FOB CIF Calc. Type")
                {
                    Caption = 'Type';
                    ToolTip = 'Specifies the value of the Type field.';
                    ApplicationArea = all;
                }
            }
        }
    }
}