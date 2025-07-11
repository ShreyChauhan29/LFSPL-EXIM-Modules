namespace LFSEximModule.LFSPLEXIMModule;

page 72016 "LFS EXIM Item Group Code Card"
{
    ApplicationArea = All;
    Caption = 'EXIM Item Group Code Card';
    PageType = Document;
    SourceTable = "LFS EXIM Item Group Code";
    UsageCategory = Tasks;
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("LFS Group Code No."; Rec."LFS Group Code No.")
                {
                    ToolTip = 'Specifies the value of the Group Code No. field.', Comment = '%';
                }
                field("LFS Description"; Rec."LFS Description")
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
            part("LFS EXIM Iem Group Line"; "LFS EXIM Item Group Code Lines")
            {
                ApplicationArea = all;
                SubPageLink = "LFS Group Code No." = FIELD("LFS Group Code No.");
                UpdatePropagation = Both;
            }
        }
    }
}
