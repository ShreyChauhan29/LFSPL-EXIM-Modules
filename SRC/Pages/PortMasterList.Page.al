namespace LFSEximModule.LFSPLEXIMModule;

page 72001 "LFS Port Master List"
{
    ApplicationArea = All;
    Caption = 'Port Master List';
    PageType = List;
    SourceTable = "LFS EXIM Port";
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
                field("Port Name"; Rec."LFS Port Name")
                {
                    ToolTip = 'Specifies the value of the Port Name field.';
                    ApplicationArea = All;
                }
                field(Address; Rec."LFS Address")
                {
                    ToolTip = 'Specifies the value of the Address field.';
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."LFS Address 2")
                {
                    ToolTip = 'Specifies the value of the Address 2 field.';
                    ApplicationArea = All;
                }
                field(City; Rec."LFS City")
                {
                    ToolTip = 'Specifies the value of the City field.';
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."LFS Post Code")
                {
                    ToolTip = 'Specifies the value of the Post Code field.';
                    ApplicationArea = All;
                }
                field("State Code"; Rec."LFS State Code")
                {
                    ToolTip = 'Specifies the value of the State Code field.';
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."LFS Country/Region Code")
                {
                    ToolTip = 'Specifies the value of the Country/Region Code field.';
                    ApplicationArea = All;
                }
                field("Sea Port"; Rec."LFS Sea Port")
                {
                    ToolTip = 'Specifies the value of the Sea Port field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}