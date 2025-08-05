namespace LFSEXIMModule.LFSPLEXIMModule;

page 72117 "LFS LUT Master List"
{
    ApplicationArea = All;
    Caption = 'LUT Master List';
    PageType = List;
    SourceTable = "LFS LUT Master Table";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("LFS LUT No."; Rec."LFS LUT No.")
                {
                    ToolTip = 'Specifies the value of the LFS LUT No. field.', Comment = '%';
                }
                field("LFS LUT Expiry Date"; Rec."LFS LUT Expiry Date")
                {
                    ToolTip = 'Specifies the value of the LFS LUT Expiry Date field.', Comment = '%';
                }
            }
        }
    }
}
