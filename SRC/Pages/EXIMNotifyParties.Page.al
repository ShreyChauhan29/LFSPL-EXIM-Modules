namespace LFSEximModule.LFSPLEXIMModule;

page 72046 "LFS EXIM Notify Parties"
{
    ApplicationArea = All;
    Caption = 'EXIM Notify Parties';
    PageType = List;
    SourceTable = "LFS Exim Notifying Parties";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Party Code"; Rec."LFS Party Code")
                {
                    ToolTip = 'Specifies the value of the Party Code field.', Comment = '%';
                }
                field("Party Name"; Rec."LFS Party Name")
                {
                    ToolTip = 'Specifies the value of the Party Name field.', Comment = '%';
                }
            }
        }
    }
}