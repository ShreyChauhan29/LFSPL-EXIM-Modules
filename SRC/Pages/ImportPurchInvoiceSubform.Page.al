namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.Document;
using Microsoft.Purchases.History;
using Microsoft.Finance.TaxBase;
using Microsoft.Inventory.Availability;
using Microsoft.Inventory.Location;
using Microsoft.Finance.Dimension;
using Microsoft.Inventory.Item;
using Microsoft.Finance.AllocationAccount;
using Microsoft.Finance.AllocationAccount.Purchase;
using Microsoft.Foundation.Attachment;
using Microsoft.Inventory.BOM;
using Microsoft.Sales.History;
using System.Integration.Excel;
using Microsoft.Foundation.ExtendedText;
using Microsoft.Utilities;
using System.Environment.Configuration;
using Microsoft.Sales.Document;
using Microsoft.Foundation.Navigate;

page 72070 "LFS ImportPurch.InvoiceSubform"
{
    ApplicationArea = All;
    Caption = 'ImportPurch.InvoiceSubform';
    PageType = ListPart;
    SourceTable = "Purchase Line";
    SourceTableView = where("Document Type" = filter(Invoice));
    DelayedInsert = true;
    MultipleNewLines = true;
    AutoSplitKey = true;
    LinksAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the document type of this document.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        NoOnAfterValidate();
                        TypeChosen := Rec.HasTypeToFillMandatotyFields();

                        if xRec."No." <> '' then
                            RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the subcontracting order.';
                    ApplicationArea = All;
                    ShowMandatory = TypeChosen;
                    trigger OnValidate()
                    begin
                        Allowitemtomodify();
                        EximCodeunit."LFS UpdateCustExhRatePurchase"(Rec);
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate();

                        if xRec."No." <> '' then
                            RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies the variant code of the item of this line.';
                    ApplicationArea = All;
                    Visible = true;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description.';
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the unit of measure code of the item of this line.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the to total quantity of ordered finished material.';
                    ApplicationArea = All;
                    ShowMandatory = TypeChosen;
                    BlankZero = true;

                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate();
                        AllowQuantitytomodify();
                    end;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ToolTip = 'Specifies the direct unit cost of this line.';
                    ApplicationArea = All;
                    ShowMandatory = TypeChosen;
                    BlankZero = true;
                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate();
                        Rec.Validate("LFS FOB Amount (FCY)", Rec."Line Amount");
                        AllowUnitCosttomodify();
                    end;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ToolTip = 'Specifies the line amount of this line.';
                    ApplicationArea = All;
                    BlankZero = true;
                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate();
                        AllowLineAmounttomodify();
                    end;
                }
                field("GST Assesable Value INR"; rec."LFS GST Assesable Value INR")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the GST Assesable Value INR';
                    trigger OnValidate()
                    begin
                        exhchangeRateCalculation();
                        Rec."GST Assessable Value" := Rec."LFS GST Assesable Value INR" / ExchRate;
                        Rec.Validate("GST Assessable Value");
                    end;
                }
                field("GST Assessable Value"; Rec."GST Assessable Value")
                {
                    ToolTip = 'Specifies the assessable value on which GST will be calculated in case of import purchase.';
                    ApplicationArea = All;
                    Editable = false;
                    trigger OnValidate()
                    begin
                        CalculateTAX();
                    end;
                }
                field("Import Duties LCY Per Unit"; Rec."LFS Import Duties Amt. (LCY)")
                {
                    ToolTip = 'Specifies the value of the Import Duties LCY Per Unit field.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    // var
                    //     myInt: Integer;
                    begin
                        exhchangeRateCalculation();
                        rec."Custom Duty Amount" := Rec."LFS Import Duties Amt. (LCY)" / ExchRate;
                        Rec.Validate("Custom Duty Amount");
                    end;
                }
                field("Custom Duty Amount"; Rec."Custom Duty Amount")
                {
                    ToolTip = 'Specifies the custom duty amount  on the transfer line.';
                    ApplicationArea = All;
                    Editable = false;
                    trigger OnValidate()
                    begin

                        Rec."LFS Import Duties Amt. (LCY)" := Rec."Custom Duty Amount" * Rec."LFS Custom Exch. Rate";
                        Rec.Validate("GST Assessable Value");
                        CalculateTAX();
                    end;
                }
                field("GST Group Code"; Rec."GST Group Code")
                {
                    ToolTip = 'Specifies the GST Group code for the calculation of GST on Transaction line.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CalculateTAX();
                    end;
                }
                field("GST Group Type"; Rec."GST Group Type")
                {
                    ToolTip = 'Specifies if the GST group is assigned for goods or service.';
                    ApplicationArea = All;
                }
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    ToolTip = 'Specifies the HSN/SAC code for the calculation of GST on Transaction line.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CalculateTAX();
                    end;
                }
                field(Exempted; Rec.Exempted)
                {
                    ToolTip = 'Specifies if the service is exempted from GST.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CalculateTAX();
                    end;
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ToolTip = 'Specifies the IC partner code this order is linked to.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("IC Partner Ref. Type"; Rec."IC Partner Ref. Type")
                {
                    ToolTip = 'Specifies the IC partner reference number this order is linked to.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("IC Partner Reference"; Rec."IC Partner Reference")
                {
                    ToolTip = 'Specifies the IC pPartner reference this order is linked to.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Nonstock; Rec.Nonstock)
                {
                    ToolTip = 'Specifies if the item of this line is non stock item';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ToolTip = 'Specifies the tax area that is used to calculate and post sales tax.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ToolTip = 'Specifies the VAT product posting group of the item this order is linked to.';
                    ApplicationArea = All;
                    Visible = false;
                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }

                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    ToolTip = 'Specifies the return reason code this order is linked to.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location code of this document.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CalculateTAX();
                    end;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ToolTip = 'Specifies the bin code of this document.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ToolTip = 'Specifies the unit of measure of the item of this line.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    ToolTip = 'Specifies the indirect unit cost % of this line.';
                    ApplicationArea = All;
                    BlankZero = false;
                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ToolTip = 'Specifies the unit cost (LCY) of this line.';
                    ApplicationArea = All;
                    Visible = false;
                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                    ToolTip = 'Specifies the unit price (LCY) of this line.';
                    ApplicationArea = All;
                    Visible = false;
                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Nature of Remittance"; Rec."Nature of Remittance")
                {
                    ToolTip = 'Specify the type of remittance deductee deals with.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Act Applicable"; Rec."Act Applicable")
                {
                    ToolTip = 'Specify the tax rates prescribed under the IT Act or DATA on the TDS entry.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Work Tax Nature Of Deduction"; Rec."Work Tax Nature Of Deduction")
                {
                    ToolTip = 'Specifies the value of the Work Tax Nature Of Deduction field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ToolTip = 'Specifies the line discount % of this line.';
                    ApplicationArea = All;
                    BlankZero = true;
                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ToolTip = 'Specifies the line discount amount of this line.';
                    ApplicationArea = All;
                    Visible = false;
                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field(Supplementary; Rec.Supplementary)
                {
                    ToolTip = 'Specifies the value of the Supplementary field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Source Document Type"; Rec."Source Document Type")
                {
                    ToolTip = 'Specifies the value of the Source Document Type field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Source Document No."; Rec."Source Document No.")
                {
                    ToolTip = 'Specifies the value of the Source Document No. field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ToolTip = 'Specifies if invoice discount is allowed in this line.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    ToolTip = 'Specifies the invoice discount amount of this line.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                    ToolTip = 'Specifies if item charge assignment is allowed.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Qty. to Assign"; Rec."Qty. to Assign")
                {
                    ToolTip = 'Specifies the quantity that needs to be assigned.';
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnDrillDown()
                    begin
                        CurrPage.SAVERECORD();
                        Rec.ShowItemChargeAssgnt();
                        UpdateForm(FALSE);
                    end;
                }
                field("Qty. Assigned"; Rec."Qty. Assigned")
                {
                    ToolTip = 'Specifies the quantity assigned.';
                    ApplicationArea = All;
                    BlankZero = true;
                    trigger OnDrillDown()
                    begin
                        CurrPage.SAVERECORD();
                        Rec.ShowItemChargeAssgnt();
                        UpdateForm(FALSE);
                    end;
                }
                field("Custom Exch. Rate"; Rec."LFS Custom Exch. Rate")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Custom Exch. Rate';
                }

                field("GST Credit"; Rec."GST Credit")
                {
                    ToolTip = 'Specifies if the GST Credit has to be availed or not.';
                    ApplicationArea = All;
                    Visible = true;
                    trigger OnValidate()
                    begin
                        CalculateTAX();
                    end;
                }
                field("Job No."; Rec."Job No.")
                {
                    ToolTip = 'Specifies the job number this order is linked to.';
                    ApplicationArea = All;
                    Visible = false;
                    trigger OnValidate()
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ToolTip = 'Specifies the job task number this order is linked to.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Line Type"; Rec."Job Line Type")
                {
                    ToolTip = 'Specifies the job line type this order is linked to.';
                    ApplicationArea = All;
                    visible = false;
                }
                field("Job Unit Price"; Rec."Job Unit Price")
                {
                    ToolTip = 'Specifies the job unit price of this order.';
                    ApplicationArea = All;
                    visible = false;
                }
                field("Job Line Amount"; Rec."Job Line Amount")
                {
                    ToolTip = 'Specifies the job line amount of this order.';
                    ApplicationArea = All;
                    visible = false;
                }
                field("Job Line Discount Amount"; Rec."Job Line Discount Amount")
                {
                    ToolTip = 'Specifies the job line discount amount of this order.';
                    ApplicationArea = All;
                    visible = false;
                }
                field("Job Line Discount %"; Rec."Job Line Discount %")
                {
                    ToolTip = 'Specifies the job line discount % of this order.';
                    ApplicationArea = All;
                    visible = false;
                }
                field("Job Total Price"; Rec."Job Total Price")
                {
                    ToolTip = 'Specifies the job total price of this order.';
                    ApplicationArea = All;
                    visible = false;
                }
                field("Job Unit Price (LCY)"; Rec."Job Unit Price (LCY)")
                {
                    ToolTip = 'Specifies the job unit price (LCY) of this order.';
                    ApplicationArea = All;
                    visible = false;
                }
                field("Job Total Price (LCY)"; Rec."Job Total Price (LCY)")
                {
                    ToolTip = 'Specifies the job total price (LCY) of this order.';
                    ApplicationArea = All;
                    visible = false;
                }
                field("Job Line Amount (LCY)"; Rec."Job Line Amount (LCY)")
                {
                    ToolTip = 'Specifies the job line amount (LCY) of this order.';
                    ApplicationArea = All;
                    visible = false;
                }
                field("Job Line Disc. Amount (LCY)"; Rec."Job Line Disc. Amount (LCY)")
                {
                    ToolTip = 'Specifies the job line discount amount (LCY) of this order.';
                    ApplicationArea = All;
                    visible = false;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ToolTip = 'Specifies the production order number this order is linked to.';
                    ApplicationArea = All;
                    visible = false;
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    ToolTip = 'Specifies the blanket order number this order is linked to.';
                    ApplicationArea = All;
                    visible = false;
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    ToolTip = 'Specifies the blanket order line number this order is linked to.';
                    ApplicationArea = All;
                    visible = false;
                }
                field("Insurance No."; Rec."Insurance No.")
                {
                    ToolTip = 'Specifies the insurance number to post an insurance coverage entry to.';
                    ApplicationArea = All;
                    visible = false;
                }
                field("Budgeted FA No."; Rec."Budgeted FA No.")
                {
                    ToolTip = 'Specifies the number of a fixed asset with the Budgeted Asset check box selected. When you post the journal or document line, an additional entry is created for the budgeted fixed asset where the amount has the opposite sign.';
                    ApplicationArea = All;
                    visible = false;
                }
                field("FA Posting Type"; Rec."FA Posting Type")
                {
                    ToolTip = 'Specifies the date that will be used on related fixed asset ledger entries.';
                    ApplicationArea = All;
                    visible = false;
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    ToolTip = 'Specifies the code for the depreciation book to which the line will be posted if you have selected Fixed Asset in the Type field for this line.';
                    ApplicationArea = All;
                    visible = false;
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
                {
                    ToolTip = 'Specifies if depreciation was calculated until the FA posting date of the line.';
                    ApplicationArea = All;
                    visible = false;
                }
                field("Depr. Acquisition Cost"; Rec."Depr. Acquisition Cost")
                {
                    ToolTip = 'Specifies if, when this line was posted, the additional acquisition cost posted on the line was depreciated in proportion to the amount by which the fixed asset had already been depreciated.';
                    ApplicationArea = All;
                    visible = false;
                }
                field("TDS Section Code"; Rec."TDS Section Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the TDS Section Code';
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.OnAfterTDSSectionCodeLookupPurchLine(Rec, Rec."Buy-from Vendor No.", true);
                        UpdateTaxAmount();
                    end;

                    trigger OnValidate()
                    begin
                        UpdateTaxAmount();
                    end;
                }
                field("Duplicate in Depreciation Book"; Rec."Duplicate in Depreciation Book")
                {
                    ToolTip = 'Specifies a depreciation book code if you want the journal line to be posted to that depreciation book, as well as to the depreciation book in the Depreciation Book Code field.';
                    ApplicationArea = All;
                    visible = false;
                }
                field("Use Duplication List"; Rec."Use Duplication List")
                {
                    ToolTip = 'Specifies, if the type is Fixed Asset, that information on the line is to be posted to all the assets defined depreciation books. ';
                    ApplicationArea = All;
                    visible = false;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ToolTip = 'Specifies the apply to item entry this order is linked to.';
                    ApplicationArea = All;
                    visible = false;
                }
                field("Deferral Code"; Rec."Deferral Code")
                {
                    ToolTip = 'Specifies the deferral template that governs how expenses paid with this purchase document are deferred to the different accounting periods when the expenses were incurred.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the shortcut dimension 1 code this order is linked to.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the shortcut dimension 2 code this order is linked to.';
                    ApplicationArea = All;
                }
                // field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.', Comment = '%';
                // }
                // field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.', Comment = '%';
                // }
                field(ShortcutDimCode3; ShortcutDimCode[3])
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the ShortcutDimCode 3';
                    CaptionClass = '1,2,3';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    // Visible = DimVisible3;
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field(ShortcutDimCode4; ShortcutDimCode[4])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,4';
                    ToolTip = 'Specifies the ShortcutDimCode 4';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    // Visible = DimVisible4;
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("EXIM Type"; Rec."LFS EXIM Type")
                {
                    ToolTip = 'Specifies the value of the EXIM Type field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("License Type"; Rec."LFS License Type")
                {
                    ToolTip = 'Specifies the value of the License Type field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("License No."; Rec."LFS License No.")
                {
                    ToolTip = 'Specifies the value of the License No. field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("RoDTEP Value (LCY)"; Rec."LFS RoDTEP Value (LCY)")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the RoDTEP Value (LCY)';
                }
                field("CIF (FCY)"; Rec."LFS CIF Amount (FCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'CIF (FCY)';
                    ToolTip = 'Specifies the CIF (FCY)';
                }
                field("CIF (LC)"; Rec."LFS CIF Amount (LCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'CIF (LCY)';
                    ToolTip = 'Specifies the CIF (LCY)';
                }
                field("FOB (FCY) Per Unit"; Rec."LFS FOB Amount (FCY)")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the FOB (FCY) Per Unit field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("CIF (FCY) Per Unit"; Rec."LFS CIF Amount (FCY)")
                {
                    ToolTip = 'Specifies the value of the CIF (FCY) Per Unit field.';
                    ApplicationArea = All;
                    Editable = false;
                    trigger OnValidate()
                    begin
                        Rec.Validate("GST Assessable Value", Rec."LFS CIF Amount (FCY)");
                    end;
                }
                field("Freight Amt. FCY Per Unit"; Rec."LFS Freight Amount (FCY)")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Freight Amt. FCY Per Unit field.';
                    ApplicationArea = All;
                }
                field("Insurance Amt FCY Per Unit"; Rec."LFS Insurance Amount (FCY)")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Insurance Amt FCY Per Unit field.';
                    ApplicationArea = All;
                }

                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the ShortcutDimCode 3';
                    Visible = false;
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
                    ToolTip = 'Specifies the ShortcutDimCode 4';
                    Visible = false;
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard), Blocked = const(false));
                    CaptionClass = '1,2,4';
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the ShortcutDimCode 5';
                    Visible = false;
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
                    ToolTip = 'Specifies the ShortcutDimCode 6';
                    Visible = false;
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
                    ToolTip = 'Specifies the ShortcutDimCode 7';
                    Visible = false;
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
                    ToolTip = 'Specifies the ShortcutDimCode 8';
                    Visible = false;
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
                    ToolTip = 'Specifies the line number of document.';
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ToolTip = 'Specifies the value of the Order Address Code field.';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Buy-From GST Registration No"; Rec."Buy-From GST Registration No")
                {
                    ToolTip = 'Specifies the value of the Buy-From GST Registration No field.';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Bill to-Location(POS)"; Rec."Bill to-Location(POS)")
                {
                    ToolTip = 'Specifies the value of the Bill to-Location(POS) field.';
                    ApplicationArea = All;
                    Visible = false;
                }
            }
            group(Control39)
            {
                Caption = '';
                group(Control33)
                {
                    Caption = '';
                    field("Invoice Discount Amount"; TotalPurchaseLine."Inv. Discount Amount")
                    {
                        ApplicationArea = all;
                        Editable = InvDiscAmountEditable;
                        Caption = 'Invoice Discount Amount';
                        ToolTip = 'Specifies the Invoice Discount Amount';
                        AutoFormatType = 1;
                        AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                        trigger OnValidate()
                        var
                            PurchaseHeader: Record "Purchase Header";
                        begin
                            PurchaseHeader.GET(Rec."Document Type", Rec."Document No.");
                            PurchCalcDiscByType.ApplyInvDiscBasedOnAmt(TotalPurchaseLine."Inv. Discount Amount", PurchaseHeader);
                            CurrPage.UPDATE(FALSE);
                        end;
                    }
                    field("Invoice Disc. Pct."; PurchCalcDiscByType.GetVendInvoiceDiscountPct(Rec))
                    {
                        ApplicationArea = all;
                        Visible = true;
                        Editable = false;
                        Caption = 'Invoice Discount %';
                        ToolTip = 'Specifies the Invoice Discount %';
                        DecimalPlaces = 0 : 2;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                    }
                }
                group(Control15)
                {
                    Caption = '';
                    field("Total Amount Excl. VAT"; TotalPurchaseLine.Amount)
                    {
                        ApplicationArea = all;
                        Visible = false;
                        Editable = false;
                        Caption = 'Total Amount Excl. VAT';
                        ToolTip = 'Specifies the Total Amount Excl. VAT';
                        AutoFormatType = 1;
                        AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                        CaptionClass = DocumentTotals.GetTotalExclVATCaption(PurchHeader."Currency Code");
                        DrillDown = false;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                    }
                    field(RefreshTotals; RefreshMessageText)
                    {
                        ApplicationArea = all;
                        Enabled = RefreshMessageEnabled;
                        Editable = false;
                        ShowCaption = false;
                        DrillDown = true;
                        trigger OnDrillDown()
                        begin
                            DocumentTotals.PurchaseRedistributeInvoiceDiscountAmounts(Rec, VATAmount, TotalPurchaseLine);
                            DocumentTotals.PurchaseUpdateTotalsControls(
                              Rec, TotalPurchaseHeader, TotalPurchaseLine, RefreshMessageEnabled,
                              TotalAmountStyle, RefreshMessageText, InvDiscAmountEditable, VATAmount);
                        end;
                    }
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(SelectMultiItems)
            {
                AccessByPermission = TableData Item = R;
                ApplicationArea = Basic, Suite;
                Caption = 'Select items';
                Ellipsis = true;
                Image = NewItem;
                ToolTip = 'Add two or more items from the full list of your inventory items.';

                trigger OnAction()
                begin
                    Rec.SelectMultipleItems();
                end;
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                group("F&unctions")
                {
                    Caption = 'F&unctions';
                    Image = "Action";
                    action("E&xplode BOM")
                    {
                        AccessByPermission = TableData "BOM Component" = R;
                        ApplicationArea = Suite;
                        Caption = 'E&xplode BOM';
                        Image = ExplodeBOM;
                        Enabled = Rec.Type = Rec.Type::Item;
                        ToolTip = 'Add a line for each component on the bill of materials for the selected item. For example, this is useful for selling the parent item as a kit. CAUTION: The line for the parent item will be deleted and only its description will display. To undo this action, delete the component lines and add a line for the parent item again. This action is available only for lines that contain an item.';

                        trigger OnAction()
                        begin
                            ExplodeBOM();
                        end;
                    }
                    action(InsertExtTexts)
                    {
                        AccessByPermission = TableData "Extended Text Header" = R;
                        ApplicationArea = Suite;
                        Caption = 'Insert &Ext. Texts';
                        Image = Text;
                        ToolTip = 'Insert the extended item description that is set up for the item that is being processed on the line.';

                        trigger OnAction()
                        begin
                            InsertExtendedText(true);
                        end;
                    }
                    action(GetReceiptLines)
                    {
                        AccessByPermission = TableData "Purch. Rcpt. Header" = R;
                        ApplicationArea = Suite;
                        Caption = '&Get Receipt Lines';
                        Ellipsis = true;
                        Image = Receipt;
                        ToolTip = 'Select a posted purchase receipt for the item that you want to assign the item charge to.';

                        trigger OnAction()
                        begin
                            GetReceipt();
                            RedistributeTotalsOnAfterValidate();
                        end;
                    }
                    action(RedistributeAccAllocations)
                    {
                        ApplicationArea = All;
                        Caption = 'Redistribute Account Allocations';
                        Image = EditList;
                        ToolTip = 'Use this action to redistribute the account allocations for this line.';
                        trigger OnAction()
                        var
                            AllocAccManualOverride: Page "Redistribute Acc. Allocations";
                        begin
                            if ((Rec."Type" <> Rec."Type"::"Allocation Account") and (Rec."Selected Alloc. Account No." = '')) then
                                Error(ActionOnlyAllowedForAllocationAccountsErr);
                            AllocAccManualOverride.RunModal();
                        end;
                    }
                    action(ReplaceAllocationAccountWithLines)
                    {
                        ApplicationArea = All;
                        Caption = 'Generate lines from Allocation Account Line';
                        Image = CreateLinesFromJob;
                        ToolTip = 'Use this action to replace the Allocation Account line with the actual lines that would be generated from the line itself.';
                        trigger OnAction()
                        var
                            PurchaseAllocAccMgt: Codeunit "Purchase Alloc. Acc. Mgt.";
                        begin
                            if ((Rec."Type" <> Rec."Type"::"Allocation Account") and (Rec."Selected Alloc. Account No." = '')) then
                                Error(ActionOnlyAllowedForAllocationAccountsErr);

                            PurchaseAllocAccMgt.CreateLinesFromAllocationAccountLine(Rec);
                            Rec.Delete();
                            CurrPage.Update(false);
                        end;
                    }
                }
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    Enabled = Rec.Type = Rec.Type::Item;
                    action("Event")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Event';
                        Image = "Event";
                        ToolTip = 'View how the actual and the projected available balance of an item will develop over time according to supply and demand events.';

                        trigger OnAction()
                        // begin
                        //     ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByEvent())
                        // end;
                        var
                            PurchaseAvailabilityMgt: Codeunit "Purch. Availability Mgt.";
                        begin
                            PurchaseAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::"Event");
                        end;
                    }
                    action(Period)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Period';
                        Image = Period;
                        ToolTip = 'Show the projected quantity of the item over time according to time periods, such as day, week, or month.';

                        trigger OnAction()
                        // begin
                        //     ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByPeriod())
                        // end;
                        var
                            PurchaseAvailabilityMgt: Codeunit "Purch. Availability Mgt.";
                        begin
                            PurchaseAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::Period);
                        end;
                    }
                    action(Variant)
                    {
                        ApplicationArea = Planning;
                        Caption = 'Variant';
                        Image = ItemVariant;
                        ToolTip = 'View or edit the item''s variants. Instead of setting up each color of an item as a separate item, you can set up the various colors as variants of the item.';

                        trigger OnAction()
                        // begin
                        //     ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByVariant())
                        // end;
                        var
                            PurchaseAvailabilityMgt: Codeunit "Purch. Availability Mgt.";
                        begin
                            PurchaseAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::Variant);
                        end;
                    }
                    action(Location)
                    {
                        AccessByPermission = TableData Location = R;
                        ApplicationArea = Location;
                        Caption = 'Location';
                        Image = Warehouse;
                        ToolTip = 'View the actual and projected quantity of the item per location.';

                        trigger OnAction()
                        // begin
                        //     ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByLocation())
                        // end;
                        var
                            PurchaseAvailabilityMgt: Codeunit "Purch. Availability Mgt.";
                        begin
                            PurchaseAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::Location);
                        end;
                    }
                    action(Lot)
                    {
                        ApplicationArea = ItemTracking;
                        Caption = 'Lot';
                        Image = LotInfo;
                        RunObject = Page "Item Availability by Lot No.";
                        RunPageLink = "No." = field("No."),
                            "Location Filter" = field("Location Code"),
                            "Variant Filter" = field("Variant Code");
                        ToolTip = 'View the current and projected quantity of the item in each lot.';
                    }
                    action("BOM Level")
                    {
                        AccessByPermission = TableData "BOM Buffer" = R;
                        ApplicationArea = Assembly;
                        Caption = 'BOM Level';
                        Image = BOMLevel;
                        ToolTip = 'View availability figures for items on bills of materials that show how many units of a parent item you can make based on the availability of child items.';

                        trigger OnAction()
                        // begin
                        //     ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByBOM())
                        // end;
                        var
                            PurchaseAvailabilityMgt: Codeunit "Purch. Availability Mgt.";
                        begin
                            PurchaseAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::BOM);
                        end;
                    }
                }
                group("Related Information")
                {
                    Caption = 'Related Information';
                    action(Dimensions)
                    {
                        AccessByPermission = TableData Dimension = R;
                        ApplicationArea = Dimensions;
                        Caption = 'Dimensions';
                        Image = Dimensions;
                        ShortCutKey = 'Alt+D';
                        ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                        trigger OnAction()
                        begin
                            Rec.ShowDimensions();
                        end;
                    }
                    action("Co&mments")
                    {
                        ApplicationArea = Comments;
                        Caption = 'Co&mments';
                        Image = ViewComments;
                        ToolTip = 'View or add comments for the record.';

                        trigger OnAction()
                        begin
                            Rec.ShowLineComments();
                        end;
                    }
                    action(ItemChargeAssignment)
                    {
                        AccessByPermission = TableData "Item Charge" = R;
                        ApplicationArea = ItemCharges;
                        Caption = 'Item Charge &Assignment';
                        Image = ItemCosts;
                        Enabled = Rec.Type = Rec.Type::"Charge (Item)";
                        ToolTip = 'Record additional direct costs, for example for freight. This action is available only for Charge (Item) line types.';

                        trigger OnAction()
                        begin
                            Rec.ShowItemChargeAssgnt();
                        end;
                    }
                    action("Item &Tracking Lines")
                    {
                        ApplicationArea = ItemTracking;
                        Caption = 'Item &Tracking Lines';
                        Image = ItemTrackingLines;
                        ShortCutKey = 'Ctrl+Alt+I';
                        Enabled = Rec.Type = Rec.Type::Item;
                        ToolTip = 'View or edit serial and lot numbers for the selected item. This action is available only for lines that contain an item.';

                        trigger OnAction()
                        begin
                            Rec.OpenItemTrackingLines();
                        end;
                    }
                    action(DeferralSchedule)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Deferral Schedule';
                        Enabled = Rec."Deferral Code" <> '';
                        Image = PaymentPeriod;
                        ToolTip = 'View or edit the deferral schedule that governs how expenses incurred with this purchase document is deferred to different accounting periods when the document is posted.';

                        trigger OnAction()
                        begin
                            Rec.ShowDeferralSchedule();
                        end;
                    }
                    action(DocAttach)
                    {
                        ApplicationArea = All;
                        Caption = 'Attachments';
                        Image = Attach;
                        ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                        trigger OnAction()
                        var
                            DocumentAttachmentDetails: Page "Document Attachment Details";
                            RecRef: RecordRef;
                        begin
                            RecRef.GetTable(Rec);
                            DocumentAttachmentDetails.OpenForRecRef(RecRef);
                            DocumentAttachmentDetails.RunModal();
                        end;
                    }
                }
            }
            group(Errors)
            {
                Caption = 'Issues';
                Image = ErrorLog;
                Visible = BackgroundErrorCheck;
                ShowAs = SplitButton;

                action(ShowLinesWithErrors)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show Lines with Issues';
                    Image = Error;
                    Visible = BackgroundErrorCheck;
                    Enabled = not ShowAllLinesEnabled;
                    ToolTip = 'View a list of purchase lines that have issues before you post the document.';

                    trigger OnAction()
                    begin
                        Rec.SwitchLinesWithErrorsFilter(ShowAllLinesEnabled);
                    end;
                }
                action(ShowAllLines)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show All Lines';
                    Image = ExpandAll;
                    Visible = BackgroundErrorCheck;
                    Enabled = ShowAllLinesEnabled;
                    ToolTip = 'View all purchase lines, including lines with and without issues.';

                    trigger OnAction()
                    begin
                        Rec.SwitchLinesWithErrorsFilter(ShowAllLinesEnabled);
                    end;
                }
            }
            group("Page")
            {
                Caption = 'Page';

                action(EditInExcel)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Edit in Excel';
                    Image = Excel;
                    Visible = IsSaaSExcelAddinEnabled;
                    ToolTip = 'Send the data in the sub page to an Excel file for analysis or editing';
                    AccessByPermission = System "Allow Action Export To Excel" = X;

                    trigger OnAction()
                    var
                        EditinExcel: Codeunit "Edit in Excel";
                        EditinExcelFilters: Codeunit "Edit in Excel Filters";
                    begin
                        EditinExcelFilters.AddFieldV2('Document_No', Enum::"Edit in Excel Filter Type"::Equal, Rec."Document No.", Enum::"Edit in Excel Edm Type"::"Edm.String");

                        EditinExcel.EditPageInExcel(
                            'Purchase_InvoicePurchLines',
                            Page::"Purch. Invoice Subform",
                            EditinExcelFilters,
                            StrSubstNo(ExcelFileNameTxt, Rec."Document No."));
                    end;

                }
            }
            group(Exim)
            {
                action(Licenses)
                {
                    Caption = 'Multiple License';
                    ToolTip = 'Specifies the Multiple Licenses';
                    ApplicationArea = all;
                    Image = Task;
                    trigger OnAction()
                    var
                        EXIM_License2: Record "LFS EXIM Import License";
                        EXIM_licenseList: Page "LFS Import Licenses";
                    begin
                        if Rec."LFS License Type" <> Rec."LFS License Type"::RoDTEP then begin
                            EXIM_License2.Reset();
                            EXIM_License2.setrange("LFS Source No.", Rec."Document No.");
                            EXIM_License2.setrange("LFS Source line No.", Rec."Line No.");
                            EXIM_licenseList.SetTableView(EXIM_License2);
                            EXIM_licenseList.SetRecord(EXIM_License2);
                            EXIM_licenseList.run();
                        end
                        else
                            Message('License Type RoDTEP is selected for this import line');
                    end;

                }
            }
        }
    }


    trigger OnOpenPage()
    var
        DocumentErrorsMgt: Codeunit "Document Errors Mgt.";
        ServerSetting: Codeunit "Server Setting";
    begin
        IsSaaSExcelAddinEnabled := ServerSetting.GetIsSaasExcelAddinEnabled();
        BackgroundErrorCheck := DocumentErrorsMgt.BackgroundValidationEnabled();
    end;

    trigger OnAfterGetRecord()
    var

    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        TypeChosen := Rec.HasTypeToFillMandatotyFields();
        Rec."LFS EXIM Type" := Rec."LFS EXIM Type"::Import;
        CLEAR(DocumentTotals);
        EximCodeunit."LFS UpdateCustExhRatePurchase"(Rec);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.InitType();
        CLEAR(ShortcutDimCode);
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
    begin
        if (Rec.Quantity <> 0) AND Rec.ItemExists(Rec."No.") then begin
            COMMIT();
            if NOT ReservePurchLine.DeleteLineConfirm(Rec) then
                EXIT(FALSE);
            ReservePurchLine.DeleteLine(Rec);
        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if PurchHeader.GET(Rec."Document Type", Rec."Document No.") then;

        DocumentTotals.PurchaseUpdateTotalsControls(
          Rec, TotalPurchaseHeader, TotalPurchaseLine, RefreshMessageEnabled,
          TotalAmountStyle, RefreshMessageText, InvDiscAmountEditable, VATAmount);
    end;

    var
        PurchHeader: Record "Purchase Header";
        TotalPurchaseHeader: Record "Purchase Header";
        TotalPurchaseLine: Record "Purchase Line";
        DocumentTotals: Codeunit "Document Totals";
        eximcodeunit: Codeunit "LFS EXIM General Functions";
        // ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        // PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
        // PurchPriceCalcMgt: Codeunit "Price Calculation Mgt.";
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        BackgroundErrorCheck: Boolean;
        InvDiscAmountEditable: Boolean;
        IsSaaSExcelAddinEnabled: Boolean;
        RefreshMessageEnabled: Boolean;
        ShowAllLinesEnabled: Boolean;
        TypeChosen: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        // Text000Lbl: Label 'Unable to execute this function while in view only mode.';
        ExchRate: decimal;
        // UpdateAllowedVar: Boolean;
        VATAmount: Decimal;
        ActionOnlyAllowedForAllocationAccountsErr: Label 'This action is only available for lines that have Allocation Account set as Type.';
        ExcelFileNameTxt: Label 'Purchase Invoice %1 - Lines', Comment = '%1 = document number, ex. 10000';
        RefreshMessageText: Text;
        TotalAmountStyle: Text;

    procedure ApproveCalcInvDisc()
    begin
        Codeunit.RUN(Codeunit::"Purch.-Disc. (Yes/No)", Rec);
    end;

    procedure CalculateTAX()
    var
        CalculateTaxVar: Codeunit "Calculate Tax";
    begin
        CurrPage.SaveRecord();
        CalculateTaxVar.CallTaxEngineOnPurchaseLine(Rec, xRec);
    end;

    procedure ClearTotalPurchaseHeader();
    begin
        Clear(TotalPurchaseHeader);
    end;

    procedure exhchangeRateCalculation(): Decimal
    begin
        ExchRate := 0;
        PurchHeader.SetRange("Document Type", Rec."Document Type");
        PurchHeader.SetRange("No.", Rec."Document No.");
        if PurchHeader.FindFirst() then
            if PurchHeader."Currency Factor" <> 0 then
                ExchRate := 1 / PurchHeader."Currency Factor"
            else
                if PurchHeader."Currency Factor" = 0 then
                    ExchRate := 1;
        exit(ExchRate);
    end;

    procedure ForceTotalsCalculation()
    begin
        DocumentTotals.PurchaseDocTotalsNotUpToDate();
    end;

    // local procedure ItemChargeAssgnt()
    // begin
    //     Rec.ShowItemChargeAssgnt();
    // end;

    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.Update(SetSaveRecord);
    end;

    local procedure Allowitemtomodify()
    var
        ImportLicense: Record "LFS EXIM Import License";
    begin
        ImportLicense.SetRange("LFS Source No.", Rec."Document No.");
        ImportLicense.SetRange("LFS Source line No.", Rec."Line No.");
        if not ImportLicense.IsEmpty() then
            Error('License is already defined for this line.\Item cannot be edited.');
    end;

    local procedure AllowLineAmounttomodify()
    var
        ImportLicense: Record "LFS EXIM Import License";
    begin
        ImportLicense.SetRange("LFS Source No.", Rec."Document No.");
        ImportLicense.SetRange("LFS Source line No.", Rec."Line No.");
        if not ImportLicense.IsEmpty() then
            Error('License is already defined for this line.\Line Amount cannot be edited.');
    end;

    local procedure AllowQuantitytomodify()
    var
        ImportLicense: Record "LFS EXIM Import License";
        licenseQuantity: Decimal;
    begin
        ImportLicense.SetRange("LFS Source No.", Rec."Document No.");
        ImportLicense.SetRange("LFS Source line No.", Rec."Line No.");
        if ImportLicense.Findset() then
            repeat
                licenseQuantity += ImportLicense."LFS Quantity";
            until ImportLicense.Next() = 0;
        if licenseQuantity <> 0 then
            if (Rec.Quantity < licenseQuantity) or (rec.quantity > xRec.Quantity) then
                Error('License is already defined for this line.\License Quantity is %1. \Quantity cannot be edited.', licenseQuantity);

    end;

    local procedure AllowUnitCosttomodify()
    var
        ImportLicense: Record "LFS EXIM Import License";
    begin
        ImportLicense.SetRange("LFS Source No.", Rec."Document No.");
        ImportLicense.SetRange("LFS Source line No.", Rec."Line No.");
        if not ImportLicense.IsEmpty() then
            Error('License is already defined for this line.\Direct Unit cost cannot be edited.');
    end;

    // local procedure CalcInvDisc()
    // begin
    //     Codeunit.RUN(Codeunit::"Purch.-Calc.Discount", Rec);
    // end;

    local procedure ExplodeBOM()
    begin
        Codeunit.Run(Codeunit::"Purch.-Explode BOM", Rec);
    end;

    local procedure GetReceipt()
    begin
        Codeunit.Run(Codeunit::"Purch.-Get Receipt", Rec);
    end;

    local procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        if TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally) then begin
            CurrPage.SAVERECORD();
            TransferExtendedText.InsertPurchExtText(Rec);
        end;
        if TransferExtendedText.MakeUpdate() then
            UpdateForm(true);
    end;

    // procedure SetUpdateAllowed(UpdateAllowed: Boolean)
    // begin
    //     UpdateAllowedVar := UpdateAllowed;
    // end;

    // local procedure UpdateAllowed(): Boolean
    // begin
    //     if UpdateAllowedVar = FALSE then begin
    //         MESSAGE(Text000Lbl);
    //         EXIT(FALSE);
    //     end;
    //     EXIT(true);
    // end;

    // local procedure ShowPrices()
    // begin
    //     PurchHeader.GET(Rec."Document Type", Rec."Document No.");
    //     // CLEAR(PurchPriceCalcMgt);
    //     // PurchPriceCalcMgt.GetPurchLinePrice(PurchHeader, Rec);
    //     Rec.PickPrice();
    //     UpdateForm(true);
    // end;

    // local procedure ShowLineDisc()
    // begin
    //     PurchHeader.GET(Rec."Document Type", Rec."Document No.");
    //     // CLEAR(PurchPriceCalcMgt);
    //     // PurchPriceCalcMgt.GetPurchLineLineDisc(PurchHeader, Rec);
    //     Rec.PickDiscount();
    //     UpdateForm(true);
    // end;

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

    local procedure RedistributeTotalsOnAfterValidate()
    begin
        CurrPage.SAVERECORD();

        PurchHeader.GET(Rec."Document Type", Rec."Document No.");
        if DocumentTotals.PurchaseCheckNumberOfLinesLimit(PurchHeader) then
            DocumentTotals.PurchaseRedistributeInvoiceDiscountAmounts(Rec, VATAmount, TotalPurchaseLine);
        CurrPage.UPDATE();
    end;

    local procedure UpdateTaxAmount()
    var
        CalculateTaxs: Codeunit "Calculate Tax";
    begin
        CurrPage.SaveRecord();
        CalculateTaxs.CallTaxEngineOnPurchaseLine(Rec, xRec);
    end;
}
