namespace LFSEximModule.LFSPLEXIMModule;

page 72015 "LFS EXIM Item Group Code List"
{
    ApplicationArea = All;
    Caption = 'EXIM Item Group Code List';
    PageType = List;
    SourceTable = "LFS EXIM Item Group Code";
    UsageCategory = Lists;
    CardPageId = "LFS EXIM Item Group Code Card";


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("LFS Group Code No."; Rec."LFS Group Code No.")
                {
                    ToolTip = 'Specifies the value of the Group Code No. field.', Comment = '%';
                }
                field("LFS Description"; Rec."LFS Description")
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
        }
    }
}
