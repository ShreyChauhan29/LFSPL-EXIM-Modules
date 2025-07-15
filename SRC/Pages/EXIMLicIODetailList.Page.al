namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Inventory.Item;

page 72024 "LFS EXIM Lic. IO Detail List"
{
    ApplicationArea = All;
    Caption = 'EXIM Lic. IO Detail List';
    PageType = List;
    SourceTable = "LFS EXIM License IO Details";
    UsageCategory = Lists;
    AutoSplitKey = true;

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
                field("Type"; Rec."LFS Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if Rec."LFS Type" = Rec."LFS Type"::Export then begin
                            Rec."LFS isExport" := true;
                            rec."LFS isImport" := false;
                        end
                        else
                            if Rec."LFS Type" = Rec."LFS Type"::Import then begin
                                Rec."LFS isImport" := true;
                                Rec."LFS isExport" := false;
                            end;

                        if Rec."LFS type" = Rec."LFS Type"::Export then
                            cifeditable := false
                        else
                            cifeditable := true;
                        if Rec."LFS Type" = Rec."LFS Type"::Import then
                            fobeditable := false
                        else
                            fobeditable := true;
                    end;
                }
                field("Item No."; Rec."LFS Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                    ApplicationArea = All;
                    Lookup = true;
                    LookupPageId = "Item List";
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Item: Record Item;
                        Items: Page "Item List";
                    begin
                        if Rec."LFS Type" = Rec."LFS Type"::Export then begin
                            //Item.SetRange("Item Category Code", 'FGS');
                            Items.LookupMode(true);
                            Items.SetTableView(Item);
                            if Page.RunModal(Page::"Item List", Item) = Action::LookupOK then begin
                                Rec."LFS Item No." := Item."No.";
                                Rec."LFS Item Description" := Item.Description;
                                Rec."LFS UOM" := Item."Base Unit of Measure";
                            end;
                        end;
                        if Rec."LFS Type" = Rec."LFS Type"::Import then begin
                            //Item.SetRange("Item Category Code", 'RMS');
                            Items.LookupMode(true);
                            Items.SetTableView(Item);
                            if Page.RunModal(Page::"Item List", Item) = Action::LookupOK then begin
                                Rec."LFS Item No." := Item."No.";
                                Rec."LFS Item Description" := Item.Description;
                                Rec."LFS UOM" := Item."Base Unit of Measure";
                            end;
                        end;
                    end;
                }
                field("Variant Code"; Rec."LFS Variant Code")
                {
                    ToolTip = 'Specifies the Variant Code of the Item.';
                    Caption = 'Variant Code';
                    Visible = false;
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
                    Editable = fobeditable;
                }
                field("CIF Value"; Rec."LFS CIF Value")
                {
                    ToolTip = 'Specifies the value of the CIF Value field.';
                    ApplicationArea = All;
                    Editable = cifeditable;
                }
                field("FOB Value (LCY)"; Rec."LFS FOB Value (LCY)")
                {
                    ToolTip = 'Specifies the value of the FOB Value (LCY) field.';
                    ApplicationArea = All;
                }
                field("CIF Value (LCY)"; Rec."LFS CIF Value (LCY)")
                {
                    ToolTip = 'Specifies the value of the CIF Value (LCY) field.';
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
                }
                field("Export Inv Bal Qty"; Rec."LFS Export Inv Bal Qty")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Export Inv Bal Qty';
                }
                field("Import Inv Bal Qty"; Rec."LFS Import Inv Bal Qty")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Import Inv Bal Qty';
                }
                field("LFS Exim Group No."; Rec."LFS Exim Group No.")
                {
                    ToolTip = 'Specifies the value of the Exim Group No. field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    // SumRebateLCY: Decimal;

    trigger OnAfterGetRecord()
    var
        LicenseHeader: Record "LFS EXIM License Header";
    begin
        if Rec."LFS type" = Rec."LFS Type"::Export then begin
            Rec.CalcFields("LFS Consumed Export Qty.");
            Rec."LFS Export Inv Bal Qty" := Rec."LFS Qty." - Rec."LFS Consumed Export Qty.";
            Rec.Modify();
            cifeditable := false;
        end
        else
            cifeditable := true;
        if Rec."LFS Type" = Rec."LFS Type"::Import then begin
            Rec.CalcFields("LFS Consumed Import Qty.");
            Rec."LFS Import Inv Bal Qty" := Rec."LFS Qty." + Rec."LFS Consumed Import Qty.";
            Rec.Modify();
            fobeditable := false;
        end
        else
            fobeditable := true;

        LicenseHeader.SetRange("LFS No.", Rec."LFS Adv. License No.");
        if LicenseHeader.FindFirst() then begin
            Rec."LFS Status" := LicenseHeader."LFS Status";
            Rec."LFS Scheme Type" := LicenseHeader."LFS Scheme Type";
            Rec."LFS Currency Factor" := LicenseHeader."LFS Currency Factor";
            Rec."LFS Currency Code" := LicenseHeader."LFS Currency Code";
            Rec.Modify();
        end;


    end;

    var
        // EXIMAdvLicenseHeader: Record "LFS EXIM  License Header";
        // IsContEdit: Boolean;
        cifeditable: Boolean;
        fobeditable: Boolean;

}
