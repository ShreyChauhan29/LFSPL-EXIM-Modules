namespace LFSEximModule.LFSPLEXIMModule;

page 72041 "LFS EXIM DDB Rate Setup"
{
    ApplicationArea = All;
    Caption = 'EXIM DDB Rate Setup';
    PageType = List;
    SourceTable = "LFS EXIM DDB Rate Setup";
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
                // field("Unit of Measure Code"; Rec."LFS Unit of Measure Code")
                // {
                //     ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                //     ApplicationArea = All;
                // }
                field("DDB Rate"; Rec."LFS DDB Rate")
                {
                    ToolTip = 'Specifies the value of the DDB Rate field.';
                    ApplicationArea = All;
                }
                field("LFS Block"; Rec."LFS Block")
                {
                    ToolTip = 'Specifies the value of the Block field.', Comment = '%';
                }
            }
        }
    }
}