namespace LFSEXIMModule.LFSPLEXIMModule;

page 72121 "LFS Container Type Master List"
{
    ApplicationArea = All;
    Caption = 'Container Type Master List';
    PageType = List;
    SourceTable = "LFS Container Type Master";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("LFS Code"; Rec."LFS Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field("LFS Description"; Rec."LFS Description")
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
        }
    }
}
