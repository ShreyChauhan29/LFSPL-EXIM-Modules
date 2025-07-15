namespace LFSEximModule.LFSPLEXIMModule;

page 72022 "LFS EXIMClosed Adv.LicenseList"
{
    ApplicationArea = All;
    Caption = 'EXIMClosed Adv.LicenseList';
    PageType = List;
    SourceTable = "LFS EXIM License Header";
    UsageCategory = History;
    Editable = false;
    CardPageId = "LFS EXIMClosed Adv.LicenseCard";
    SourceTableView = where("LFS Status" = const(Closed));
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."LFS No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                }
                field(Description; Rec."LFS Description")
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Issue Date"; Rec."LFS Issue Date")
                {
                    ToolTip = 'Specifies the value of the Issue Date field.';
                    ApplicationArea = All;
                }
                field("Expiry Date"; Rec."LFS Expiry Date")
                {
                    ToolTip = 'Specifies the value of the Expiry Date field.';
                    ApplicationArea = All;
                }
                field("Export Validity Date"; Rec."LFS Export Validity Date")
                {
                    ToolTip = 'Specifies the value of the Export Validity Date field.';
                    ApplicationArea = All;
                }
                field("Export Extension No."; Rec."LFS Export Extension No.")
                {
                    ToolTip = 'Specifies the value of the Export Extension No. field.';
                    ApplicationArea = All;
                }
                field("Export Extension Date"; Rec."LFS Export Extension Date")
                {
                    ToolTip = 'Specifies the value of the Export Extension Date field.';
                    ApplicationArea = All;
                }
                // field("Export Expiry Date"; Rec."LFS Export Expiry Date")
                // {
                //     ToolTip = 'Specifies the value of the Export Expiry Date field.';
                //     ApplicationArea = All;
                // }
                field("Import Validity Date"; Rec."LFS Import Validity Date")
                {
                    ToolTip = 'Specifies the value of the Import Validity Date field.';
                    ApplicationArea = All;
                }
                field("Import Extension No."; Rec."LFS Import Extension No.")
                {
                    ToolTip = 'Specifies the value of the Import Extension No. field.';
                    ApplicationArea = All;
                }
                field("Import Extension Date"; Rec."LFS Import Extension Date")
                {
                    ToolTip = 'Specifies the value of the Import Extension Date field.';
                    ApplicationArea = All;
                }
                // field("Import Expiry Date"; Rec."LFS Import Expiry Date")
                // {
                //     ToolTip = 'Specifies the value of the Import Expiry Date field.';
                //     ApplicationArea = All;
                // }
                field(Status; Rec."LFS Status")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                }
                field("Export Type"; Rec."LFS Export Type")
                {
                    ToolTip = 'Specifies the value of the Export Type field.';
                    ApplicationArea = All;
                }
                // field("Item Type"; Rec."LFS Item Type")
                // {
                //     ToolTip = 'Specifies the value of the Item Type field.';
                //     ApplicationArea = All;
                // }
                field("Adv. License Export Qty."; Rec."LFS Adv. Lic Export Qty.")
                {
                    ToolTip = 'Specifies the value of the Adv. License Export Qty. field.';
                    ApplicationArea = All;
                }
                field("Adv. License Export FOB Value"; Rec."LFS Adv. Lic Exp FOB Value")
                {
                    ToolTip = 'Specifies the value of the Adv. License Export FOB Value field.';
                    ApplicationArea = All;
                }
                field("Export Order FOB Value"; Rec."LFS Export Order FOB Value")
                {
                    ToolTip = 'Specifies the value of the Export Order FOB Value field.';
                    ApplicationArea = All;
                }
                field("Export Invoice FOB Value"; Rec."LFS Export Inv FOB Value")
                {
                    ToolTip = 'Specifies the value of the Export Invoice FOB Value field.';
                    ApplicationArea = All;
                }
                field("Export Order Qty."; Rec."LFS Export Order Qty.")
                {
                    ToolTip = 'Specifies the value of the Export Order Qty. field.';
                    ApplicationArea = All;
                }
                field("Export Invoice Qty."; Rec."LFS Export Invoice Qty.")
                {
                    ToolTip = 'Specifies the value of the Export Invoice Qty. field.';
                    ApplicationArea = All;
                }
                field("Adv. License Import Qty."; Rec."LFS Adv. License Imp Qty.")
                {
                    ToolTip = 'Specifies the value of the Adv. License Import Qty. field.';
                    ApplicationArea = All;
                }
                field("Adv. License Import CIF Value"; Rec."LFS Adv. Lic Imp CIF Value")
                {
                    ToolTip = 'Specifies the value of the Adv. License Import CIF Value field.';
                    ApplicationArea = All;
                }
                field("Import Order CIF Value"; Rec."LFS Import Order CIF Value")
                {
                    ToolTip = 'Specifies the value of the Import Order CIF Value field.';
                    ApplicationArea = All;
                }
                field("Import Invoice CIF Value"; Rec."LFS Import Inv CIF Value")
                {
                    ToolTip = 'Specifies the value of the Import Invoice CIF Value field.';
                    ApplicationArea = All;
                }
                field("Import Order Qty."; Rec."LFS Import Order Qty.")
                {
                    ToolTip = 'Specifies the value of the Import Order Qty. field.';
                    ApplicationArea = All;
                }
                field("Import Invoice Qty."; Rec."LFS Import Invoice Qty.")
                {
                    ToolTip = 'Specifies the value of the Import Invoice Qty. field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}