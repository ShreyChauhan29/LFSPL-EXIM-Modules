namespace LFSEximModule.LFSPLEXIMModule;

page 72019 "LFS LC Terms & Cond. Subpage"
{
    ApplicationArea = All;
    Caption = 'LC Terms & Cond. Subpage';
    PageType = ListPart;
    SourceTable = "LFS EXIM LC T&C Lines";

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
            }
        }
    }
}