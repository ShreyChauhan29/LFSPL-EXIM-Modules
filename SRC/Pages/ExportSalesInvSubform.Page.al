namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.Document;
using Microsoft.Finance.Dimension;
using Microsoft.Warehouse.Structure;
using Microsoft.Inventory.Availability;
using Microsoft.Finance.GST.StockTransfer;
using Microsoft.Sales.Pricing;
using Microsoft.Foundation.ExtendedText;
using Microsoft.Utilities;
using Microsoft.Finance.TaxBase;

page 72056 "LFS Export Sales Inv. Subform"
{
    ApplicationArea = All;
    Caption = 'Export Sales Invoice Subform';
    PageType = ListPart;
    SourceTable = "Sales Line";
    DelayedInsert = true;
    MultipleNewLines = true;
    AutoSplitKey = true;
    LinksAllowed = false;
    SourceTableView = where("Document Type" = filter(Invoice));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the line type.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        TypeOnAfterValidate();
                        NoOnAfterValidate();
                        TypeChosen := Rec.HasTypeToFillMandatotyFields();
                    end;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the record.';
                    ApplicationArea = All;
                    ShowMandatory = TypeChosen;
                    trigger OnValidate()
                    var
                        EXIMCurrExRate: Record "LFSEXIM Currency Exchange Rate";
                        Exc_Rate: Decimal;
                    begin
                        AllowItemtoModify();
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the item or service on the line.';
                    ApplicationArea = All;
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ToolTip = 'Specifies the code of the intercompany partner that the transaction is related to if the entry was created from an intercompany transaction.';
                    ApplicationArea = All;
                    Visible = false;

                }
                field("IC Partner Ref. Type"; Rec."IC Partner Ref. Type")
                {
                    ToolTip = 'Specifies the item or account in your IC partner''s company that corresponds to the item or account on the line.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("IC Partner Reference"; Rec."IC Partner Reference")
                {
                    ToolTip = 'Specifies the IC partner. if the line is being sent to one of your intercompany partners, this field is used together with the IC Partner Ref. Type field to indicate the item or account in your partner''s company that corresponds to the line.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies the variant of the item on the line.';
                    ApplicationArea = All;
                    Visible = true;
                }
                field(Nonstock; Rec.Nonstock)
                {
                    ToolTip = 'Specifies that this item is a catalog item.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ToolTip = 'Specifies the VAT specification of the involved item or resource to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the vendor''s or customer''s trade type to link transactions made for this business partner with the appropriate general ledger account according to the general posting setup.';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        DeltaUpdateTotals();
                    end;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the item''s product type to link transactions made for this item with the appropriate general ledger account according to the general posting setup.';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        DeltaUpdateTotals();
                    end;
                }
                field("EXIM Type"; Rec."LFS EXIM Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the EXIM Type';
                }
                field("Price Inclusive of Tax"; Rec."Price Inclusive of Tax")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Price Inclusive of Tax';
                }
                field("Unit Price Incl. of Tax"; Rec."Unit Price Incl. of Tax")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Unit Price Incl. of Tax';
                    trigger OnValidate()
                    begin
                        CalculateTAX();
                    end;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    ToolTip = 'Specifies the code explaining why the item was returned.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the inventory location from which the items sold should be picked and where the inventory decrease is registered.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CalculateTAX();
                    end;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ToolTip = 'Specifies the bin where the items are picked or put away.';
                    ApplicationArea = All;
                    Visible = false;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Bin: Record Bin;
                    begin
                        Bin.SetRange("Location Code", Rec."Location Code");
                        // Bin.SetFilter("LFS Quarantine Bin", '%1', false); // Manually filter the calculated field

                        if Page.RunModal(Page::"Bin List", Bin) = Action::LookupOK then
                            Rec.Validate("Bin Code", Bin.Code);
                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the quantity of the sales order line.';
                    ApplicationArea = All;
                    ShowMandatory = TypeChosen;
                    BlankZero = true;
                    trigger OnValidate()
                    begin
                        QuantityOnAfterValidate();
                        AllowQuantitytomodify();
                        CalculateTAX();
                    end;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        UnitofMeasureCodeOnAfterValida();
                    end;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ToolTip = 'Specifies the name of the item or resource''s unit of measure, such as piece or hour.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ToolTip = 'Specifies the cost, in LCY, of one unit of the item or resource on the line.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(PriceExists; Rec.PriceExists())
                {
                    ApplicationArea = all;
                    Visible = false;
                    Editable = false;
                    Caption = 'Sales Price Exists';
                    ToolTip = 'Specifies the Sales Price Exists';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the price for one unit on the sales line.';
                    ApplicationArea = All;
                    ShowMandatory = TypeChosen;
                    BlankZero = true;
                    trigger OnValidate()
                    begin
                        AllowUnitPricetomodify();
                    end;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ToolTip = 'Specifies the net amount, excluding any invoice discount amount, that must be paid for products on the line.';
                    ApplicationArea = All;
                    BlankZero = true;
                    trigger OnValidate()
                    begin
                        AllowLineAmounttomodify();
                    end;
                }
                field(LineDiscExists; Rec.LineDiscExists())
                {
                    ApplicationArea = all;
                    Visible = false;
                    Editable = false;
                    Caption = 'Sales Line Disc. Exists';
                    ToolTip = 'Specifies the Sales Line Disc. Exists';
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    Visible = false;
                    ToolTip = 'Specifies the discount percentage that is granted for the item on the line.';
                    ApplicationArea = All;
                    BlankZero = true;
                    trigger OnValidate()
                    begin
                        CalculateTAX();
                    end;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ToolTip = 'Specifies the discount amount that is granted for the item on the line.';
                    ApplicationArea = All;
                    Visible = false;
                    trigger OnValidate()
                    begin
                        CalculateTAX();
                    end;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ToolTip = 'Specifies if the invoice line is included when the invoice discount is calculated.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    ToolTip = 'Specifies the invoice discount amount for the line.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                    ToolTip = 'Specifies that you can assign item charges to this line.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Qty. to Assign"; Rec."Qty. to Assign")
                {
                    Visible = false;
                    ToolTip = 'Specifies how many units of the item charge will be assigned to the line.';
                    ApplicationArea = All;
                    BlankZero = true;
                    trigger OnDrillDown()
                    begin
                        CurrPage.SaveRecord();
                        Rec.ShowItemChargeAssgnt();
                        UpdateForm(false);
                    end;
                }
                field("Qty. Assigned"; Rec."Qty. Assigned")
                {
                    ToolTip = 'Specifies the quantity of the item charge that was assigned to a specified item when you posted this sales line.';
                    ApplicationArea = All;
                    BlankZero = true;
                    Visible = false;
                    trigger OnDrillDown()
                    begin
                        CurrPage.SAVERECORD();
                        Rec.ShowItemChargeAssgnt();
                        UpdateForm(FALSE);
                    end;
                }
                field("Job No."; Rec."Job No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the number of the related job. if you fill in this field and the Job Task No. field, then a job ledger entry will be posted together with the sales line.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ToolTip = 'Specifies the number of the related job task.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Contract Entry No."; Rec."Job Contract Entry No.")
                {
                    ToolTip = 'Specifies the entry number of the job planning line that the sales line is linked to.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Tax Category"; Rec."Tax Category")
                {
                    ToolTip = 'Specifies the VAT category in connection with electronic document sending. For example, when you send sales documents through the PEPPOL service, the value in this field is used to populate several fields, such as the ClassifiedTaxCategory element in the Item group. It is also used to populate the TaxCategory element in both the TaxSubtotal and AllowanceCharge group. The number is based on the UNCL5305 standard.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                    ToolTip = 'Specifies which work type the resource applies to when the sale is related to a job.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    ToolTip = 'Specifies the number of the blanket order that the record originates from.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    ToolTip = 'Specifies the number of the blanket order line that the record originates from.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("FA Posting Date"; Rec."FA Posting Date")
                {
                    ToolTip = 'Specifies the date that will be used on related fixed asset ledger entries.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
                {
                    ToolTip = 'Specifies if depreciation was calculated until the FA posting date of the line.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    ToolTip = 'Specifies the code for the depreciation book to which the line will be posted if you have selected Fixed Asset in the Type field for this line.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Duplicate in Depreciation Book"; Rec."Duplicate in Depreciation Book")
                {
                    ToolTip = 'Specifies a depreciation book code if you want the journal line to be posted to that depreciation book, as well as to the depreciation book in the Depreciation Book Code field.';
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Use Duplication List"; Rec."Use Duplication List")
                {
                    ToolTip = 'Specifies, if the type is Fixed Asset, that information on the line is to be posted to all the assets defined depreciation books. ';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Appl.-from Item Entry"; Rec."Appl.-from Item Entry")
                {
                    ToolTip = 'Specifies the number of the item ledger entry that the document or journal line is applied from.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ToolTip = 'Specifies the number of the item ledger entry that the document or journal line is applied -to.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Return Receipt Line No."; Rec."Return Receipt Line No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Return Receipt Line No. field.';
                    ApplicationArea = All;
                }
                field("Deferral Code"; Rec."Deferral Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the deferral template that governs how revenue earned with this sales document is deferred to the different accounting periods when the good or service was delivered.';
                    ApplicationArea = All;
                    Enabled = (Rec.Type <> Rec.Type::"Fixed Asset") AND (Rec.Type <> Rec.Type::" ");
                }
                field("GST Place Of Supply"; Rec."GST Place Of Supply")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the GST Place Of Supply';
                    trigger OnValidate()
                    begin
                        CalculateTAX();
                    end;
                }
                field("GST Group Code"; Rec."GST Group Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the GST Group Code';
                    trigger OnValidate()
                    begin
                        CalculateTAX();
                    end;
                }
                field("GST Group Type"; Rec."GST Group Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the GST Group Type';
                }
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the HSN/SAC Code';

                    trigger OnValidate()
                    begin
                        AllowUnitPricetomodify();
                        CalculateTAX();
                    end;
                }
                field("LFS HS Code"; Rec."LFS HS Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the HS Code ';
                }
                field("Invoice Type"; Rec."Invoice Type")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Invoice Type';
                }
                field(Exempted; Rec.Exempted)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Exempted';
                    trigger OnValidate()
                    begin
                        CalculateTAX();
                    end;
                }
                field("Incentive Type"; Rec."LFS Incentive Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Incentive Type';
                    trigger OnValidate()
                    var
                        // ddbSetup: Record "LFS EXIM DDB Rate Setup";
                        license: Record "LFS EXIM Export License";
                    // Salesheader: Record "Sales Header";
                    begin
                        license.setrange("LFS Source No.", Rec."Document No.");
                        license.setrange("LFS Source line No.", Rec."Line No.");
                        if not license.IsEmpty() then
                            if Rec."LFS Incentive Type" = Rec."LFS Incentive Type"::DDB then
                                error('Multiple Licenses are already defined for this document line');
                    end;
                }
                field("FOB (FC)"; Rec."LFS FOB Amount (FCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'FOB (FCY)';
                    ToolTip = 'Specifies the FOB (FCY)';
                }
                field("FOB (LC)"; Rec."LFS FOB Amount (LCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'FOB (LCY)';
                    ToolTip = 'Specifies the FOB (LCY)';
                }
                field("FOB (FCY) Per Unit"; Rec."LFS FOB Amount (FCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the FOB (FCY) Per Unit';
                }
                field("LFS CIF(FCY)"; Rec."LFS CIF Value (FCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the CIF(FCY)';
                }
                field("LFS CIF(LCY)"; Rec."LFS CIF Value (LCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the CIF(LCY)';
                }
                field("CIF (FCY) Per Unit"; Rec."LFS CIF Amount (FCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the CIF (FCY) Per Unit';
                }
                field("Freight Value Per Type (FCY)"; Rec."LFS Freight Value (FCY)")
                {
                    ApplicationArea = all;
                    Caption = 'Freight Value (FCY)';
                    ToolTip = 'Specifies the Freight Value (FCY)';
                }
                field("Freight Value Per Type (LCY)"; Rec."LFS Freight Value (LCY)")
                {
                    ApplicationArea = all;
                    Caption = 'Freight Value (LCY)';
                    ToolTip = 'Specifies the Freight Value (LCY)';
                    Editable = false;
                }
                field("Insurance Value Per Type (FCY)"; Rec."LFS Insurance Value (FCY)")
                {
                    ApplicationArea = all;
                    Caption = 'Insurance Value (FCY)';
                    ToolTip = 'Specifies the Insurance Value (FCY)';
                }
                field("Insurance Value Per Type (LCY)"; Rec."LFS Insurance Value (LCY)")
                {
                    ApplicationArea = all;
                    Caption = 'Insurance Value (LCY)';
                    ToolTip = 'Specifies the Insurance Value (LCY)';
                    Editable = false;
                }
                field("LFS FOB in USD"; Rec."LFS FOB in USD")
                {
                    ToolTip = 'Specifies the value of the FOB in USD field.', Comment = '%';
                }
                field("LFS FOB Currency Code"; Rec."LFS FOB Currency Code")
                {
                    ToolTip = 'Specifies the value of the FOB Currency Code field.', Comment = '%';
                }
                field("LFS FOB Currency Factor"; Rec."LFS FOB Currency Factor")
                {
                    ToolTip = 'Specifies the value of the FOB Currency Factor field.', Comment = '%';
                }
                field("LFS RoDTEP Rebate Rate %"; Rec."LFS RoDTEP Rebate Rate %")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the RoDTEP Rebate Rate %';
                }
                field("LFS RoDTEP Rebate Value"; Rec."LFS RoDTEP Rebate Value")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the RoDTEP Rebate Value';
                }
                field("LFS DDB Rate"; Rec."LFS DDB Rate")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the DDB Rate %';

                }
                field("LFS DDB Value (LCY)"; Rec."LFS DDB Value (LCY)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the DDB Value (LCY)';

                }
                // field("Category Type"; Rec."LFS Category Type")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                //     ToolTip = 'Specifies the Category Type';
                // }

                // field("Packing List No."; Rec."LFS Packing List No.")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                //     ToolTip = 'Specifies the Packing List No.';
                // }
                field("Currency Exch. Rate"; Rec."LFS Currency Exch. Rate")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Currency Exch. Rate';
                }
                field("Custom Exch. Rate"; Rec."LFS Custom Exch. Rate")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Custom Exch. Rate';
                }
                field("Claim DDB"; Rec."LFS Claim DDB")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Claim DDB';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    ApplicationArea = all;
                    // Visible = false;
                    ToolTip = 'Specifies the Shortcut Dimension 3';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3), "Dimension Value Type" = const(Standard), Blocked = const(false));
                    CaptionClass = '1,2,3';
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    ApplicationArea = all;
                    // Visible = false;
                    ToolTip = 'Specifies the Shortcut Dimension 4';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard), "Blocked" = const(false));
                    CaptionClass = '1,2,4';
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Shortcut Dimension 5';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5), "Dimension Value Type" = const(Standard), Blocked = const(false));
                    CaptionClass = '1,2,5';
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Shortcut Dimension 6';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6), "Dimension Value Type" = const(Standard), Blocked = const(false));
                    CaptionClass = '1,2,6';
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Shortcut Dimension 7';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7), "Dimension Value Type" = const(Standard), Blocked = const(false));
                    CaptionClass = '1,2,7';
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Shortcut Dimension 8';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8), "Dimension Value Type" = const(Standard), Blocked = const(false));
                    CaptionClass = '1,2,8';
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }

                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the document number.';
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the line number.';
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = false;
                    Visible = false;
                }
                field("Shipment No."; Rec."Shipment No.")
                {
                    ToolTip = 'Specifies the value of the Shipment No. field.';
                    ApplicationArea = All;
                }
                field("Shipment Line No."; Rec."Shipment Line No.")
                {
                    ToolTip = 'Specifies the value of the Shipment Line No. field.';
                    ApplicationArea = All;
                }
                field("LFS From"; Rec."LFS Container No/Shipp. Marks")
                {
                    ToolTip = 'Specifies the value of the EX_From field.';
                    ApplicationArea = All;
                }
                field("LFS to"; Rec."LFS No. & Kind of Packages")
                {
                    ToolTip = 'Specifies the value of the EX_To field.';
                    ApplicationArea = All;
                }
                field("RoDTEP Rebate Value"; Rec."LFS RoDTEP Rebate Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the RoDTEP Rebate Value';
                }
                field("LFS Exim Group No."; Rec."LFS Exim Group No.")
                {
                    ToolTip = 'Specifies the value of the Exim Group No. field.', Comment = '%';
                }
                // field("Dispatch Instruction"; Rec."LFS Dispatch Instruction")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                //     ToolTip = 'Specifies the Dispatch Instruction';
                // }
                // field("Packing Details"; Rec."LFS Packing Details")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                //     ToolTip = 'Specifies the Packing Details';
                // }
            }
            group(Control33)
            {
                Visible = false;
                field("Invoice Discount Amount"; TotalSalesLine."Inv. Discount Amount")
                {
                    ApplicationArea = all;
                    Editable = InvDiscAmountEditable;
                    Caption = 'Invoice Discount Amount';
                    ToolTip = 'Specifies the Invoice Discount Amount';
                    AutoFormatExpression = TotalSalesHeader."Currency Code";
                    Style = Subordinate;
                    StyleExpr = RefreshMessageEnabled;
                    trigger OnValidate()
                    begin
                        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
                        SalesCalcDiscByType.ApplyInvDiscBasedOnAmt(TotalSalesLine."Inv. Discount Amount", SalesHeader);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                field("Invoice Disc. Pct."; SalesCalcDiscByType.GetCustInvoiceDiscountPct(Rec))
                {
                    ApplicationArea = all;
                    Visible = true;
                    Editable = false;
                    Caption = 'Invoice Discount %';
                    ToolTip = 'Specifies the Invoice Disc. %';
                    Style = Subordinate;
                    StyleExpr = RefreshMessageEnabled;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(Functions)
            {
                Caption = 'F&unctions';
                Image = Action;
                action(GetPrice)
                {
                    ApplicationArea = All;
                    Caption = 'Get &Price';
                    ToolTip = 'Specifies the Get &Price';
                    Image = Price;
                    Ellipsis = true;
                    trigger OnAction()
                    begin
                        ShowPrices();
                    end;
                }
                action(GetLineDiscount)
                {
                    ApplicationArea = All;
                    Caption = 'Get Li&ne Discount';
                    ToolTip = 'Specifies the GetLineDiscount';
                    Ellipsis = true;
                    Image = LineDiscount;
                    trigger OnAction()
                    begin
                        ShowLineDisc();
                    end;
                }
                action(Explode_BOM)
                {
                    ApplicationArea = All;
                    Caption = 'E&xplode BOM';
                    ToolTip = 'Specifies the Explode BOM';
                    Image = ExplodeBOM;
                    trigger OnAction()
                    begin
                        ExplodeBOM();
                    end;
                }
                action(InsertExtTexts)
                {
                    ApplicationArea = All;
                    Caption = 'Insert &Ext. Texts';
                    ToolTip = 'Specifies the InsertExtTexts';
                    Image = Text;
                    trigger OnAction()
                    begin
                        InsertExtendedText(true);
                    end;
                }
                action(GetShipmentLines)
                {
                    ApplicationArea = All;
                    Caption = 'Get &Shipment Lines';
                    ToolTip = 'Specifies the GetShipmentLines';
                    Image = Shipment;
                    Ellipsis = true;
                    trigger OnAction()
                    begin
                        GetShipment();
                    end;
                }
            }
            group(Line)
            {
                Caption = '&Line';
                Image = Line;
                group(ItemAvailability)
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    action(E_vent)
                    {
                        ApplicationArea = All;
                        Caption = 'Event';
                        ToolTip = 'Specifies the Event';
                        Image = "Event";
                        trigger OnAction()
                        // begin
                        //     ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByEvent())
                        // end;
                        var
                            SalesAvailabilityMgt: Codeunit Microsoft.Sales.Document."Sales Availability Mgt.";
                        begin
                            SalesAvailabilityMgt.ShowItemAvailabilityFromSalesLine(Rec, "Item Availability Type"::"Event");
                        end;
                    }
                    action(Period)
                    {
                        ApplicationArea = All;
                        Caption = 'Period';
                        ToolTip = 'Specifies the Period';
                        Image = Period;
                        trigger OnAction()
                        // begin
                        //     ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByPeriod)
                        // end;
                        var
                            SalesAvailabilityMgt: Codeunit Microsoft.Sales.Document."Sales Availability Mgt.";
                        begin
                            SalesAvailabilityMgt.ShowItemAvailabilityFromSalesLine(Rec, "Item Availability Type"::Period);
                        end;
                    }
                    action(Variant)
                    {
                        ApplicationArea = All;
                        Caption = 'Variant';
                        ToolTip = 'Specifies the Variant';
                        Image = ItemVariant;
                        trigger OnAction()
                        // begin
                        //     ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByVariant())
                        // end;
                        var
                            SalesAvailabilityMgt: Codeunit Microsoft.Sales.Document."Sales Availability Mgt.";
                        begin
                            SalesAvailabilityMgt.ShowItemAvailabilityFromSalesLine(Rec, "Item Availability Type"::Variant);
                        end;
                    }
                    action(Location)
                    {
                        ApplicationArea = All;
                        Caption = 'Location';
                        ToolTip = 'Specifies the Location';
                        Image = Warehouse;
                        trigger OnAction()
                        // begin
                        //     ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByLocation)
                        // end;
                        var
                            SalesAvailabilityMgt: Codeunit Microsoft.Sales.Document."Sales Availability Mgt.";
                        begin
                            SalesAvailabilityMgt.ShowItemAvailabilityFromSalesLine(Rec, "Item Availability Type"::Location);
                        end;
                    }
                    action(BOMLevel)
                    {
                        ApplicationArea = All;
                        Caption = 'BOM Level';
                        ToolTip = 'Specifies the ';
                        Image = BOMLevel;
                        trigger OnAction()
                        // begin
                        //     ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByBOM)
                        // end;
                        var
                            SalesAvailabilityMgt: Codeunit Microsoft.Sales.Document."Sales Availability Mgt.";
                        begin
                            SalesAvailabilityMgt.ShowItemAvailabilityFromSalesLine(Rec, "Item Availability Type"::BOM);
                        end;
                    }

                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    ToolTip = 'Specifies the Dimensions';
                    Image = Dimensions;
                    ShortcutKey = 'Shift+Ctrl+D';
                    trigger OnAction()
                    begin
                        Rec.ShowDimensions();
                    end;
                }
                action(Comments)
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    ToolTip = 'Specifies the Comments';
                    Image = ViewComments;
                    trigger OnAction()
                    begin
                        Rec.ShowLineComments();
                    end;
                }

                action(ItemChargeAssignment)
                {
                    ApplicationArea = All;
                    Caption = 'Item Charge &Assignment';
                    ToolTip = 'Specifies the ItemChargeAssignment';
                    Image = ItemCosts;
                    trigger OnAction()
                    begin
                        Rec.ShowItemChargeAssgnt();
                    end;
                }
                action(ItemTrackingLines)
                {
                    ApplicationArea = All;
                    Caption = 'Item &Tracking Lines';
                    ToolTip = 'Specifies the ItemTrackingLines';
                    Image = ItemTrackingLines;
                    ShortcutKey = 'Shift+Ctrl+I';
                    trigger OnAction()
                    begin
                        Rec.OpenItemTrackingLines();
                    end;
                }
                action(DetailedGST)
                {
                    ApplicationArea = All;
                    Caption = 'Detailed GST';
                    ToolTip = 'Specifies the DetailedGST';
                    Visible = false;
                    Image = ServiceTax;
                    RunObject = page "Detailed GST Entry Buffer";
                    RunPageLink = "Transaction Type" = filter(Sales), "Document Type" = field("Document Type"), "Document No." = field("Document No."), "Line No." = field("Line No.");
                }
                action(DeferralSchedule)
                {
                    ApplicationArea = All;
                    Caption = 'Deferral Schedule';
                    ToolTip = 'Specifies the ';
                    Enabled = Rec."Deferral Code" <> '';
                    Image = PaymentPeriod;
                    trigger OnAction()
                    begin
                        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
                        Rec.ShowDeferrals(SalesHeader."Posting Date", SalesHeader."Currency Code");
                    end;
                }
            }
            group("Exim")
            {
                Caption = 'EXIM';
                action("Packing List")
                {
                    ApplicationArea = all;
                    Caption = 'Packing List';
                    ToolTip = 'Specifies the Packing List';
                    Image = List;
                    trigger OnAction()
                    var
                        postedPacking: Record "LFS EXIM Posted Packing Table";
                        PostedPackingList: Page "LFS Posted Packing List";
                    begin
                        postedPacking.SetRange("LFS Posted Export Shipment", Rec."Shipment No.");
                        postedPacking.SetRange("LFS PostExShipmentLineNo.", Rec."Shipment Line No.");
                        PostedPackingList.SetTableView(postedPacking);
                        Page.RunModal(page::"LFS Posted Packing List", postedPacking);
                    end;
                }
                action(Licenses)
                {
                    Caption = 'Multiple License';
                    ToolTip = 'Specifies the Licenses';
                    ApplicationArea = all;
                    Image = Task;
                    trigger OnAction()
                    var
                        EXIM_License2: Record "LFS EXIM Export License";
                        EXIM_licenseList: Page "LFS EXIM Export License";

                    begin
                        if rec."LFS Incentive Type" <> Rec."LFS Incentive Type"::DDB then begin
                            EXIM_License2.Reset();
                            EXIM_License2.setrange("LFS Source No.", Rec."Document No.");
                            EXIM_License2.setrange("LFS Source line No.", Rec."Line No.");
                            EXIM_License2.SetRange("LFS Exim Group No.", Rec."LFS Exim Group No.");
                            EXIM_licenseList.SetTableView(EXIM_License2);
                            EXIM_licenseList.SetRecord(EXIM_License2);
                            EXIM_licenseList.run();
                        end
                        else
                            Error('Incentive type DDB is defined for this invoice line');
                    end;
                }
                action("Calculate RoDTEP & DDB")
                {
                    ApplicationArea = All;
                    Caption = 'Calculate RoDTEP & DDB';
                    ToolTip = 'It Calculate the RoDTEP and DDB Values and Rate.';
                    Image = Calculate;
                    trigger OnAction()
                    var
                        SalesLine: Record "Sales Line";
                    begin
                        SalesLine.SetRange("Document No.", Rec."Document No.");
                        SalesLine.SetRange("Document Type", Rec."Document Type");
                        if SalesLine.FindSet() then
                            repeat
                                SalesLine.CalculateRoDTEPandDDB();
                            until SalesLine.Next() = 0;
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        EximCodeunit: Codeunit "LFS EXIM General Functions";
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        TypeChosen := Rec.HasTypeToFillMandatoryFields();
        Rec."LFS EXIM Type" := Rec."LFS EXIM Type"::Export;
        EximCodeunit."LFS UpdateCustExhRateSales"(Rec);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.InitType();
        CLEAR(ShortcutDimCode);
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReserveSalesLine: Codeunit "Sales Line-Reserve";
    begin
        if (Rec.Quantity <> 0) AND Rec.ItemExists(Rec."No.") then begin
            COMMIT();
            if NOT ReserveSalesLine.DeleteLineConfirm(Rec) then
                EXIT(FALSE);
            ReserveSalesLine.DeleteLine(Rec);
        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if SalesHeader.GET(Rec."Document Type", Rec."Document No.") then;
    end;

    var
        SalesHeader: Record "Sales Header";
        TotalSalesHeader: Record "Sales Header";
        TotalSalesLine: Record "Sales Line";
        DocumentTotals: Codeunit "Document Totals";
        SalesCalcDiscByType: Codeunit "Sales - Calc Discount By Type";
        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        InvDiscAmountEditable: Boolean;
        ItemPanelVisible: Boolean;
        RefreshMessageEnabled: Boolean;
        TypeChosen: Boolean;
        UpdateAllowedVar: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        InvoiceDiscountAmount: Decimal;
        InvoiceDiscountPct: Decimal;
        VATAmount: Decimal;
        Text000Lbl: Label 'Unable to run this function while in View mode.';

    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Disc. (Yes/No)", Rec);
    end;

    procedure CalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Calc. Discount", Rec);
    end;

    procedure CalculateTAX()
    var
        CalculateTaxVar: Codeunit "Calculate Tax";
    begin
        CurrPage.SaveRecord();
        if (Rec."GST Group Code" <> '') and (Rec."HSN/SAC Code" <> '') then begin
            Rec.Validate("GST Place Of Supply");
            CalculateTaxVar.CallTaxEngineOnSalesLine(Rec, xRec);
        end;
    end;

    procedure ClearTotalSalesHeader();
    begin
        Clear(TotalSalesHeader);
    end;

    procedure DeltaUpdateTotals()
    begin
        DocumentTotals.SalesDeltaUpdateTotals(Rec, xRec, TotalSalesLine, VATAmount, InvoiceDiscountAmount, InvoiceDiscountPct);
        if Rec."Line Amount" <> xRec."Line Amount" then
            Rec.SendLineInvoiceDiscountResetNotification();
    end;

    procedure ExplodeBOM()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Explode BOM", Rec);
    end;

    procedure ForceTotalsCalculation()
    var
        DocumentTotals1: Codeunit "Document Totals";
    begin
        DocumentTotals1.SalesDocTotalsNotUpToDate();
    end;

    procedure GetShipment()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Get Shipment", Rec);
    end;

    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        if TransferExtendedText.SalesCheckIfAnyExtText(Rec, Unconditionally) then begin
            CurrPage.SAVERECORD();
            COMMIT();
            TransferExtendedText.InsertSalesExtText(Rec);
        end;
        if TransferExtendedText.MakeUpdate() then
            UpdateForm(true);
    end;

    procedure SetUpdateAllowed(UpdateAlloweds: Boolean)
    begin
        UpdateAllowedVar := UpdateAlloweds;
    end;

    procedure ShowLineDisc()
    begin
        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
        CLEAR(SalesPriceCalcMgt);
        SalesPriceCalcMgt.GetSalesLineLineDisc(SalesHeader, Rec);
    end;

    procedure ShowPrices()
    begin
        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
        CLEAR(SalesPriceCalcMgt);
        SalesPriceCalcMgt.GetSalesLinePrice(SalesHeader, Rec);
    end;

    procedure UpdateAllowed(): Boolean
    begin
        if UpdateAllowedVar = FALSE then begin
            MESSAGE(Text000Lbl);
            EXIT(FALSE);
        end;
        EXIT(true);
    end;

    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;

    local procedure AllowItemtoModify()
    var
        ExportLicense: Record "LFS EXIM Export License";
    begin
        ExportLicense.SetRange("LFS Source No.", Rec."Document No.");
        ExportLicense.SetRange("LFS Source line No.", Rec."Line No.");
        if not ExportLicense.IsEmpty() then
            Error('License is already defined for this line.\Item cannot be edited.');
    end;

    local procedure AllowLineAmounttomodify()
    var
        ExportLicense: Record "LFS EXIM Export License";
    begin
        ExportLicense.SetRange("LFS Source No.", Rec."Document No.");
        ExportLicense.SetRange("LFS Source line No.", Rec."Line No.");
        if not ExportLicense.IsEmpty() then
            Error('License is already defined for this line.\Line Amount cannot be edited.');
    end;

    local procedure AllowQuantitytomodify()
    var
        ExportLicense: Record "LFS EXIM Export License";
        licenseQuantity: Decimal;
    begin
        ExportLicense.SetRange("LFS Source No.", Rec."Document No.");
        ExportLicense.SetRange("LFS Source line No.", Rec."Line No.");
        if ExportLicense.Findset() then
            repeat
                licenseQuantity += ExportLicense."LFS Quantity";
            until ExportLicense.Next() = 0;
        if licenseQuantity <> 0 then
            if (Rec.Quantity < licenseQuantity) or (rec.quantity > xRec.Quantity) then
                Error('License is already defined for this line.\License quantity is %1.\Line Quantity cannot be edited.', licenseQuantity);
    end;

    local procedure AllowUnitPricetomodify()
    var
        ExportLicense: Record "LFS EXIM Export License";
    begin
        ExportLicense.SetRange("LFS Source No.", Rec."Document No.");
        ExportLicense.SetRange("LFS Source line No.", Rec."Line No.");
        if not ExportLicense.IsEmpty() then
            Error('License is already defined for this line.\Unit Price cannot be edited.');
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(FALSE);
        if (Rec.Type = Rec.Type::"Charge (Item)") AND (Rec."No." <> xRec."No.") AND
           (xRec."No." <> '')
        then
            CurrPage.SAVERECORD();
    end;

    // local procedure CrossReferenceNoOnAfterValidat()
    // begin
    //     InsertExtendedText(FALSE);
    // end;

    local procedure QuantityOnAfterValidate()
    begin
        if Rec.Reserve = Rec.Reserve::Always then begin
            CurrPage.SAVERECORD();
            Rec.AutoReserve();
        end;
    end;

    local procedure TypeOnAfterValidate()
    begin
        Clear(ItemPanelVisible);
        ItemPanelVisible := Rec.Type = Rec.Type::Item;
    end;

    local procedure UnitofMeasureCodeOnAfterValida()
    begin
        if Rec.Reserve = Rec.Reserve::Always then begin
            CurrPage.SAVERECORD();
            Rec.AutoReserve();
        end;
    end;
}