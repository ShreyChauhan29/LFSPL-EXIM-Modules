namespace LFSEximModule.LFSPLEXIMModule;

page 72007 "LFS Doc. Check List SubPage"
{
    ApplicationArea = All;
    Caption = 'Doc. Check List SubPage';
    PageType = ListPart;
    SourceTable = "LFSEXIM Document CheckListLine";

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
                field("Action By"; Rec."LFS Action By")
                {
                    ToolTip = 'Specifies the value of the Action By field.';
                    ApplicationArea = All;
                }
                field("Action On"; Rec."LFS Action On")
                {
                    ToolTip = 'Specifies the value of the Action On field.';
                    ApplicationArea = All;
                }
                field("Completed On"; Rec."LFS Completed On")
                {
                    ToolTip = 'Specifies the value of the Completed On field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}