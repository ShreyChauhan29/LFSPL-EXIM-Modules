namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Foundation.Attachment;

page 72020 "LFS EXIM License List"
{
    ApplicationArea = All;
    Caption = 'EXIM Advance License List';
    PageType = List;
    SourceTable = "LFS EXIM License Header";
    UsageCategory = Lists;
    Editable = false;
    CardPageID = "LFS EXIM License Card";
    SourceTableView = where("LFS Status" = filter(<> Closed));

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
                // field("Import Expiry Date"; Rec."LFS Import Expiry Date")
                // {
                //     ToolTip = 'Specifies the value of the Import Expiry Date field.';
                //     ApplicationArea = All;
                // }
                field("Adv. License Export Qty."; Rec."LFS Adv. Lic Export Qty.")
                {
                    ToolTip = 'Specifies the value of the Adv. License Export Qty. field.';
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
                field("Export Inv Bal Qty"; Rec."LFS Export Inv Bal Qty")
                {
                    ToolTip = 'Specifies the value of the Export Inv Bal Qty field.';
                    ApplicationArea = All;
                }
                field("Adv. License Import Qty."; Rec."LFS Adv. License Imp Qty.")
                {
                    ToolTip = 'Specifies the value of the Adv. License Import Qty. field.';
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
                field("Import Order Bal Qty"; Rec."LFS Import Order Bal Qty")
                {
                    ToolTip = 'Specifies the value of the Import Order Bal Qty field.';
                    ApplicationArea = All;
                }
                field("Import Inv Bal Qty"; Rec."LFS Import Inv Bal Qty")
                {
                    ToolTip = 'Specifies the value of the Import Inv Bal Qty field.';
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
            }
        }
        area(FactBoxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"LFS EXIM License Header"),
                              "No." = field("LFS No.");
                // "Document Type" = field("Document Type");
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("LFS Adv. Lic Export Qty.", "LFS Adv. License Imp Qty.", "LFS Export Invoice Qty.", "LFS Export Order Qty.", "LFS Import Invoice Qty.", "LFS Import Order Qty.");
        Rec."LFS Import Inv Bal Qty" := Rec."LFS Adv. License Imp Qty." + Rec."LFS Import Invoice Qty.";
        Rec."LFS Import Order Bal Qty" := Rec."LFS Adv. License Imp Qty." + Rec."LFS Import Order Qty.";
        Rec."LFS Export Inv Bal Qty" := Rec."LFS Adv. Lic Export Qty." - Rec."LFS Export Invoice Qty.";
    end;

    trigger OnAfterGetCurrRecord()
    begin
        Rec.CalcFields("LFS Adv. Lic Export Qty.", "LFS Adv. License Imp Qty.", "LFS Export Invoice Qty.", "LFS Export Order Qty.", "LFS Import Invoice Qty.", "LFS Import Order Qty.");
        Rec."LFS Import Inv Bal Qty" := Rec."LFS Adv. License Imp Qty." + Rec."LFS Import Invoice Qty.";
        Rec."LFS Import Order Bal Qty" := Rec."LFS Adv. License Imp Qty." + Rec."LFS Import Order Qty.";
        Rec."LFS Export Inv Bal Qty" := Rec."LFS Adv. Lic Export Qty." - Rec."LFS Export Invoice Qty.";
    end;
}