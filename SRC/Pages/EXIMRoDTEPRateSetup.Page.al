namespace LFSEximModule.LFSPLEXIMModule;

page 72036 "LFS EXIM RoDTEP Rate Setup"
{
    ApplicationArea = All;
    Caption = 'EXIM RoDTEP Rate Setup';
    PageType = List;
    SourceTable = "LFS EXIM RoDTEP Rate Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Starting Date"; Rec."LFS Starting Date")
                {
                    ToolTip = 'Specifies the value of the Starting Date field.';
                    ApplicationArea = All;
                }
                field("Item Code"; Rec."LFS Item Code")
                {
                    ToolTip = 'Specifies the value of the Item Code field.';
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."LFS Item Description")
                {
                    ToolTip = 'Specifies the value of the Item Description field.';
                    ApplicationArea = All;
                }
                field("HSN No."; Rec."LFS HSN No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the HSN No.';
                }
                field("RoDTEP Rebate Rate %"; Rec."LFS RoDTEP Rebate Rate %")
                {
                    ToolTip = 'Specifies the value of the Rebate Rate % field.';
                    ApplicationArea = All;
                }
                field(Block; Rec."LFS Block")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Block';
                }
            }
        }
    }
}