namespace LFSEximModule.LFSPLEXIMModule;

page 72097 "EXIM Group Master"
{
    ApplicationArea = All;
    Caption = 'EXIM Group Master';
    PageType = List;
    SourceTable = "EXIM Group Master";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Type; Rec."LFS EXIM Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field("Group No."; Rec."LFS Group No.")
                {
                    ToolTip = 'Specifies the value of the Group No. field.', Comment = '%';
                }
                field("Group Name"; Rec."LFS Group Name")
                {
                    ToolTip = 'Specifies the value of the Group Name field.', Comment = '%';
                }
                field("ITCHS Code"; Rec."LFS ITCHS Code")
                {
                    ToolTip = 'Specifies the value of the ITCHS Code field.', Comment = '%';
                }
            }
        }
    }
}