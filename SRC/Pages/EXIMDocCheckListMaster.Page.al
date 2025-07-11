namespace LFSEximModule.LFSPLEXIMModule;

page 72006 "LFS EXIM Doc.Check List Master"
{
    ApplicationArea = All;
    Caption = 'EXIM Doc.Check List Master';
    PageType = List;
    SourceTable = "LFS EXIM Doc. Check ListMaster";
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
                field("Document Type"; Rec."LFS Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                    ApplicationArea = All;
                }
                field("Incoming / Outgoing Document"; Rec."LFS Incoming Outgoing Doc")
                {
                    ToolTip = 'Specifies the value of the Incoming / Outgoing Document field.';
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