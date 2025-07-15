namespace LFSEximModule.LFSPLEXIMModule;

page 72025 "LFS EXIM ClAdv. Lic.IO Details"
{
    ApplicationArea = All;
    Caption = 'EXIM Closed Advance License IO Details List';
    PageType = List;
    SourceTable = "LFS EXIM License IO Details";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Adv. License No."; Rec."LFS Adv. License No.")
                {
                    ToolTip = 'Specifies the value of the Adv. License No. field.';
                    ApplicationArea = All;
                }
                field("Line No."; Rec."LFS Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                }
                field("Type"; Rec."LFS Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    ApplicationArea = All;
                }
                // field("Item Type"; Rec."LFS Item Type")
                // {
                //     ToolTip = 'Specifies the value of the Item Type field.';
                //     ApplicationArea = All;
                // }
                field("Item No."; Rec."LFS Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."LFS Item Description")
                {
                    ToolTip = 'Specifies the value of the Item Description field.';
                    ApplicationArea = All;
                }
                field(UOM; Rec."LFS UOM")
                {
                    ToolTip = 'Specifies the value of the UOM field.';
                    ApplicationArea = All;
                }
                field("Qty."; Rec."LFS Qty.")
                {
                    ToolTip = 'Specifies the value of the Qty. field.';
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."LFS Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                    ApplicationArea = All;
                }
                field("FOB Value"; Rec."LFS FOB Value")
                {
                    ToolTip = 'Specifies the value of the FOB Value field.';
                    ApplicationArea = All;
                }
                field("CIF Value"; Rec."LFS CIF Value")
                {
                    ToolTip = 'Specifies the value of the CIF Value field.';
                    ApplicationArea = All;
                }
                field("Consumed Export Qty."; Rec."LFS Consumed Export Qty.")
                {
                    ToolTip = 'Specifies the value of the Consumed Export Qty. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Consumed FOB Value"; Rec."LFS Consumed FOB Value")
                {
                    ToolTip = 'Specifies the value of the Consumed FOB Value field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Consumed Import Qty."; Rec."LFS Consumed Import Qty.")
                {
                    ToolTip = 'Specifies the value of the Consumed Import Qty. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Consumed CIF Value"; Rec."LFS Consumed CIF Value")
                {
                    ToolTip = 'Specifies the value of the Consumed CIF Value field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Currency Factor"; Rec."LFS Currency Factor")
                {
                    ToolTip = 'Specifies the value of the Currency Factor field.';
                    ApplicationArea = All;
                }
                field("FOB Value (LCY)"; Rec."LFS FOB Value (LCY)")
                {
                    ToolTip = 'Specifies the value of the FOB Value (LCY) field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Clear(IsContEdit);
        EXIMAdvLicenseHeader.Get(Rec."LFS Adv. License No.");
        IsContEdit := not (EXIMAdvLicenseHeader."LFS Status" = EXIMAdvLicenseHeader."LFS Status"::Active);
    end;

    var
        EXIMAdvLicenseHeader: Record "LFS EXIM License Header";
        IsContEdit: Boolean;
}