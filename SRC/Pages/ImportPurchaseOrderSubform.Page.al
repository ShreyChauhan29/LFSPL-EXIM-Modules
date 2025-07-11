namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.Document;
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

page 72069 "LFS ImportPurchaseOrderSubform"
{
    ApplicationArea = All;
    Caption = 'ImportPurchaseOrderSubform';
    PageType = ListPart;
    SourceTable = "Purchase Line";
    SourceTableView = where("Document Type" = filter(Order));
    DelayedInsert = true;
    MultipleNewLines = true;
    AutoSplitKey = true;

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
                        Clear(TypeChosen);
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
                    trigger OnValidate()
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the IC partner code this order is linked to.';
                    ApplicationArea = All;
                }
                field("IC Partner Ref. Type"; Rec."IC Partner Ref. Type")
                {
                    Visible = false;
                    ToolTip = 'Specifies the IC partner reference number this order is linked to.';
                    ApplicationArea = All;
                }
                field("IC Partner Reference"; Rec."IC Partner Reference")
                {
                    Visible = false;
                    ToolTip = 'Specifies the IC pPartner reference this order is linked to.';
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    // Visible = false;
                    ToolTip = 'Specifies the variant code of the item of this line.';
                    ApplicationArea = All;
                }
                field(Nonstock; Rec.Nonstock)
                {
                    Visible = false;
                    ToolTip = 'Specifies if the item of this line is non stock item';
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    Visible = false;
                    ToolTip = 'Specifies the VAT product posting group of the item this order is linked to.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description.';
                    ApplicationArea = All;
                }
                field("Drop Shipment"; Rec."Drop Shipment")
                {
                    Visible = false;
                    ToolTip = 'Specifies the if drop shipment is applicable in this line.';
                    ApplicationArea = All;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the return reason code this order is linked to.';
                    ApplicationArea = All;
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
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the to total quantity of ordered finished material.';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate();
                        EximCodeunit."LFS UpdateCustExhRatePurchase"(Rec);
                    end;
                }
                field("Reserved Quantity"; Rec."Reserved Quantity")
                {
                    Visible = false;
                    ToolTip = 'Specifies the reserved quantity of this line.';
                    ApplicationArea = All;
                }
                field("Job Remaining Qty."; Rec."Job Remaining Qty.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the quantity that remains to complete a job.';
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
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ToolTip = 'Specifies the unit of measure of the item of this line.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ToolTip = 'Specifies the direct unit cost of this line.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate();
                        Rec.Validate("LFS FOB Amount (FCY)", Rec."Line Amount");
                        Rec.Modify();
                    end;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    Visible = false;
                    ToolTip = 'Specifies the indirect unit cost % of this line.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    Visible = false;
                    ToolTip = 'Specifies the unit cost (LCY) of this line.';
                    ApplicationArea = All;
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
                field("Line Amount"; Rec."Line Amount")
                {
                    ToolTip = 'Specifies the line amount of this line.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ToolTip = 'Specifies the line discount % of this line.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ToolTip = 'Specifies the line discount amount of this line.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Qty. to Receive"; Rec."Qty. to Receive")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Qty. to Receive';
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Quantity Received';
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Qty. to Invoice';
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the ';
                }
                field("Prepayment %"; Rec."Prepayment %")
                {
                    Visible = false;
                    ToolTip = 'Specifies the prepayment % of this line.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Prepmt. Line Amount"; Rec."Prepmt. Line Amount")
                {
                    Visible = false;
                    ToolTip = 'Specifies the prepayment amount of the line in the currency of the purchase document if a prepayment percentage is specified for the purchase line.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Prepmt. Amt. Inv."; Rec."Prepmt. Amt. Inv.")
                {
                    Visible = false;
                    ToolTip = 'Specifies if this is prepayment amount invoice line.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    Visible = false;
                    ToolTip = 'Specifies if invoice discount is allowed in this line.';
                    ApplicationArea = All;
                }
                field("Qty. to Assign"; Rec."Qty. to Assign")
                {
                    Visible = false;
                    ToolTip = 'Specifies the quantity that needs to be assigned.';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        CurrPage.SaveRecord();
                        Rec.ShowItemChargeAssgnt();
                        UpdateForm(false);
                    end;
                }
                field("Qty. Assigned"; Rec."Qty. Assigned")
                {
                    Visible = false;
                    ToolTip = 'Specifies the quantity assigned.';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        CurrPage.SaveRecord();
                        Rec.ShowItemChargeAssgnt();
                        UpdateForm(false);
                    end;
                }
                field("Custom Duty Amount"; Rec."Custom Duty Amount")
                {
                    ToolTip = 'Specifies the custom duty amount  on the transfer line.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec."LFS Import Duties Amt. (LCY)" := Rec."Custom Duty Amount" * Rec."LFS Custom Exch. Rate";
                        CalculateTAX();
                    end;
                }
                field("GST Assessable Value"; Rec."GST Assessable Value")
                {
                    ToolTip = 'Specifies the assessable value on which GST will be calculated in case of import purchase.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CalculateTAX();
                    end;
                }
                field("GST Credit"; Rec."GST Credit")
                {
                    ToolTip = 'Specifies if the GST Credit has to be availed or not.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
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
                field("GST Jurisdiction Type"; Rec."GST Jurisdiction Type")
                {
                    ToolTip = 'Specifies the type related to GST jurisdiction. For example, interstate/intrastate.';
                    ApplicationArea = All;
                }
                field(Supplementary; Rec.Supplementary)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Supplementary field.';
                    ApplicationArea = All;
                }
                field("Source Document Type"; Rec."Source Document Type")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Source Document Type field.';
                    ApplicationArea = All;
                }
                field("Source Document No."; Rec."Source Document No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Source Document No. field.';
                    ApplicationArea = All;
                }
                field("Job No."; Rec."Job No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the job number this order is linked to.';
                    ApplicationArea = All;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the job task number this order is linked to.';
                    ApplicationArea = All;
                }
                field("Job Planning Line No."; Rec."Job Planning Line No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the job planning line number that the usage should be linked to when the job journal is posted. You can only link to job planning lines that have the Apply Usage Link option enabled.';
                    ApplicationArea = All;
                }
                field("Job Line Type"; Rec."Job Line Type")
                {
                    Visible = false;
                    ToolTip = 'Specifies the job line type this order is linked to.';
                    ApplicationArea = All;
                }
                field("Job Unit Price"; Rec."Job Unit Price")
                {
                    Visible = false;
                    ToolTip = 'Specifies the job unit price of this order.';
                    ApplicationArea = All;
                }
                field("Job Line Amount"; Rec."Job Line Amount")
                {
                    Visible = false;
                    ToolTip = 'Specifies the job line amount of this order.';
                    ApplicationArea = All;
                }
                field("Job Line Discount Amount"; Rec."Job Line Discount Amount")
                {
                    Visible = false;
                    ToolTip = 'Specifies the job line discount amount of this order.';
                    ApplicationArea = All;
                }
                field("Job Line Discount %"; Rec."Job Line Discount %")
                {
                    Visible = false;
                    ToolTip = 'Specifies the job line discount % of this order.';
                    ApplicationArea = All;
                }
                field("Job Total Price"; Rec."Job Total Price")
                {
                    Visible = false;
                    ToolTip = 'Specifies the job total price of this order.';
                    ApplicationArea = All;
                }
                field("Job Unit Price (LCY)"; Rec."Job Unit Price (LCY)")
                {
                    Visible = false;
                    ToolTip = 'Specifies the job unit price (LCY) of this order.';
                    ApplicationArea = All;
                }
                field("Job Total Price (LCY)"; Rec."Job Total Price (LCY)")
                {
                    Visible = false;
                    ToolTip = 'Specifies the job total price (LCY) of this order.';
                    ApplicationArea = All;
                }
                field("Job Line Amount (LCY)"; Rec."Job Line Amount (LCY)")
                {
                    Visible = false;
                    ToolTip = 'Specifies the job line amount (LCY) of this order.';
                    ApplicationArea = All;
                }
                field("Job Line Disc. Amount (LCY)"; Rec."Job Line Disc. Amount (LCY)")
                {
                    Visible = false;
                    ToolTip = 'Specifies the job line discount amount (LCY) of this order.';
                    ApplicationArea = All;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ToolTip = 'Specifies the requested receipt date of this order.';
                    ApplicationArea = All;
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    Visible = false;
                    ToolTip = 'Specifies the promised receipt date of this order.';
                    ApplicationArea = All;
                }
                field("Planned Receipt Date"; Rec."Planned Receipt Date")
                {
                    Visible = false;
                    ToolTip = 'Specifies the planned receipt date of this order.';
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ToolTip = 'Specifies the expected receipt date of this order.';
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ToolTip = 'Specifies the order date of this order.';
                    ApplicationArea = All;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    ToolTip = 'Specifies the lead time calculation of this order.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Planning Flexibility"; Rec."Planning Flexibility")
                {
                    ToolTip = 'Specifies the planning flexibility of this order.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the production order number this order is linked to.';
                    ApplicationArea = All;
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the released production order line number.';
                    ApplicationArea = All;
                }
                field("Operation No."; Rec."Operation No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the operation number linked with the subcontracting order.';
                    ApplicationArea = All;
                }
                field("Work Center No."; Rec."Work Center No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the work center number linked with the subcontracting order.';
                    ApplicationArea = All;
                }
                field(Finished; Rec.Finished)
                {
                    Visible = false;
                    ToolTip = 'Specifies the subcontrcting order is in finished state.';
                    ApplicationArea = All;
                }
                field("Whse. Outstanding Qty. (Base)"; Rec."Whse. Outstanding Qty. (Base)")
                {
                    Visible = false;
                    ToolTip = 'Specifies the warehouse outstanding quantity (Base).';
                    ApplicationArea = All;
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    Visible = false;
                    ToolTip = 'Specifies the Inbound Warehouse Handling Time.';
                    ApplicationArea = All;
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the blanket order number this order is linked to.';
                    ApplicationArea = All;
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the blanket order line number this order is linked to.';
                    ApplicationArea = All;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    Visible = false;
                    ToolTip = 'Specifies the apply to item entry this order is linked to.';
                    ApplicationArea = All;
                }
                field("Deferral Code"; Rec."Deferral Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the deferral template that governs how expenses paid with this purchase document are deferred to the different accounting periods when the expenses were incurred.';
                    ApplicationArea = All;
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Order Address Code field.';
                    ApplicationArea = All;
                }
                field("Buy-From GST Registration No"; Rec."Buy-From GST Registration No")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Buy-From GST Registration No field.';
                    ApplicationArea = All;
                }
                field("Bill to-Location(POS)"; Rec."Bill to-Location(POS)")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Bill to-Location(POS) field.';
                    ApplicationArea = All;
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
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.', Comment = '%';
                    CaptionClass = '1,2,3';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field(ShortcutDimCode4; ShortcutDimCode[4])
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.', Comment = '%';
                    CaptionClass = '1,2,4';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
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
                field("CIF (LCY)"; Rec."LFS CIF Amount (LCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'CIF (LCY)';
                    ToolTip = 'Specifies the CIF (LCY)';
                }
                field("FOB (FCY) Per Unit"; Rec."LFS FOB Amount (FCY)")
                {
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
                        Rec."GST Assessable Value" := Rec."LFS CIF Amount (FCY)";
                    end;
                }
                field("Freight Amt. FCY Per Unit"; Rec."LFS Freight Amount (FCY)")
                {
                    ToolTip = 'Specifies the value of the Freight Amt. FCY Per Unit field.';
                    ApplicationArea = All;
                }
                field("Insurance Amt FCY Per Unit"; Rec."LFS Insurance Amount (FCY)")
                {
                    ToolTip = 'Specifies the value of the Insurance Amt FCY Per Unit field.';
                    ApplicationArea = All;
                }
                field("Import Duties LCY Per Unit"; Rec."LFS Import Duties Amt. (LCY)")
                {
                    ToolTip = 'Specifies the value of the Import Duties LCY Per Unit field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Custom Exch. Rate"; Rec."LFS Custom Exch. Rate")
                {
                    ToolTip = 'Specifies the value of the Custom Exch. Rate field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the ShortcutDimCode 3';
                    visible = false;
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
                    visible = false;
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
                    visible = false;
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
                    visible = false;
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
                    visible = false;
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
                    visible = false;
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8), "Dimension Value Type" = const(Standard), Blocked = const(false));
                    CaptionClass = '1,2,8';
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
            }
            group(Control43)
            {
                Visible = false;

                group(Control37)
                {
                    field("Invoice Discount Amount"; TotalPurchaseHeader."Currency Code")
                    {
                        ApplicationArea = all;
                        Editable = InvDiscAmountEditable;
                        Caption = 'Invoice Discount Amount';
                        ToolTip = 'Specifies the Invoice Discount Amount';
                        AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                        AutoFormatType = 1;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;

                        trigger OnValidate()
                        var
                            PurchaseHeader: Record "Purchase Header";
                        begin
                            PurchaseHeader.GET(Rec."Document Type", Rec."Document No.");
                            if PurchaseHeader.InvoicedLineExists() then
                                if NOT CONFIRM(UpdateInvDiscountQstLbl, FALSE) then
                                    EXIT;

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
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                        DecimalPlaces = 0 : 2;
                    }
                }
                group(Control19)
                {
                    field("Total Amount Excl. VAT"; TotalPurchaseLine.Amount)
                    {
                        ApplicationArea = all;
                        Visible = false;
                        Editable = false;
                        Caption = 'Total Amount Excl. VAT';
                        ToolTip = 'Specifies the ';
                        AutoFormatType = 1;
                        AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                        CaptionClass = DocumentTotals.GetTotalExclVATCaption(PurchHeader."Currency Code");
                        DrillDown = false;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                    }
                    field("Total VAT Amount"; VATAmount)
                    {
                        ApplicationArea = all;
                        Visible = false;
                        Editable = false;
                        Caption = 'Total VAT';
                        ToolTip = 'Specifies the Total VAT Amount';
                        AutoFormatType = 1;
                        AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                        CaptionClass = DocumentTotals.GetTotalVATCaption(PurchHeader."Currency Code");
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                    }
                    field("Total Amount Incl. VAT"; TotalPurchaseHeader."Amount Including VAT")
                    {
                        ApplicationArea = all;
                        Visible = false;
                        Editable = false;
                        Caption = 'Total Amount Incl. VAT';
                        ToolTip = 'Specifies the Total Amount Incl. VAT';
                        AutoFormatType = 1;
                        AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                        CaptionClass = DocumentTotals.GetTotalInclVATCaption(PurchHeader."Currency Code");
                        StyleExpr = TotalAmountStyle;
                    }
                    field("RefreshTotals"; RefreshMessageText)
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
                action("Reservation Entries")
                {
                    AccessByPermission = TableData Item = R;
                    ApplicationArea = Reservation;
                    Caption = 'Reservation Entries';
                    Image = ReservationLedger;
                    Enabled = Rec.Type = Rec.Type::Item;
                    ToolTip = 'View all reservation entries for the selected item. This action is available only for lines that contain an item.';

                    trigger OnAction()
                    begin
                        Rec.ShowReservationEntries(true);
                    end;
                }
                action("Item Tracking Lines")
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
                action(DocumentLineTracking)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Document &Line Tracking';
                    ToolTip = 'View related open, posted, or archived documents or document lines.';
                    Image = OrderTracking;
                    trigger OnAction()
                    begin
                        ShowDocumentLineTracking();
                    end;
                }
                action(DeferralSchedule)
                {
                    ApplicationArea = Suite;
                    Caption = 'Deferral Schedule';
                    Enabled = Rec."Deferral Code" <> '';
                    Image = PaymentPeriod;
                    ToolTip = 'View or edit the deferral schedule that governs how revenue made with this purchase document is deferred to different accounting periods when the document is posted.';

                    trigger OnAction()
                    begin
                        Rec.ShowDeferralSchedule();
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
                action("Insert Ext. Texts")
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
                action("Attach to Inventory Item Line")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Attach to inventory item line';
                    Image = Allocations;
                    ToolTip = 'Attach the selected non-inventory product lines to a inventory item line in this purchase order.';

                    trigger OnAction()
                    var
                        SelectedPurchLine: Record "Purchase Line";
                    begin
                        CurrPage.SetSelectionFilter(SelectedPurchLine);
                        AttachToInventoryItemLine(SelectedPurchLine);
                    end;
                }
                action(Reserve)
                {
                    ApplicationArea = Reservation;
                    Caption = '&Reserve';
                    Ellipsis = true;
                    Image = Reserve;
                    Enabled = Rec.Type = Rec.Type::Item;
                    ToolTip = 'Reserve the quantity of the selected item that is required on the document line from which you opened this page. This action is available only for lines that contain an item.';

                    trigger OnAction()
                    begin
                        Rec.Find();
                        Rec.ShowReservation();
                    end;
                }
                action(OrderTracking)
                {
                    ApplicationArea = Suite;
                    Caption = 'Order &Tracking';
                    Image = OrderTracking;
                    Enabled = Rec.Type = Rec.Type::Item;
                    ToolTip = 'Track the connection of a supply to its corresponding demand for the selected item. This can help you find the original demand that created a specific production order or purchase order. This action is available only for lines that contain an item.';

                    trigger OnAction()
                    begin
                        ShowTracking();
                    end;
                }

                // action("Technical Specification")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the Technical Specification';
                //     RunObject = page techsp;
                //     RunPageLink = "LFS Indent No" = field("LFS Indent Doc No."), "LFS Indent Line" = field("LFS Indent Doc Line No.");
                // }
            }
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment';
                    Image = Delivery;
                    action("Sales &Order")
                    {
                        AccessByPermission = TableData "Sales Shipment Header" = R;
                        ApplicationArea = Suite;
                        Caption = 'Sales &Order';
                        Image = Document;
                        ToolTip = 'View the sales order that is the source of the line. This applies only to drop shipments and special orders.';

                        trigger OnAction()
                        begin
                            OpenSalesOrderForm();
                        end;
                    }
                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order';
                    Image = SpecialOrder;
                    action(Action1901038504)
                    {
                        AccessByPermission = TableData "Sales Shipment Header" = R;
                        ApplicationArea = Suite;
                        Caption = 'Sales &Order';
                        Image = Document;
                        ToolTip = 'View the sales order that is the source of the line. This applies only to drop shipments and special orders.';

                        trigger OnAction()
                        begin
                            OpenSpecOrderSalesOrderForm();
                        end;
                    }
                }
                action(BlanketOrder)
                {
                    ApplicationArea = Suite;
                    Caption = 'Blanket Order';
                    Image = BlanketOrder;
                    ToolTip = 'View the blanket purchase order.';

                    trigger OnAction()
                    var
                        PurchaseHeader: Record "Purchase Header";
                        BlanketPurchaseOrder: Page "Blanket Purchase Order";
                    begin
                        Rec.TestField("Blanket Order No.");
                        PurchaseHeader.SetRange("No.", Rec."Blanket Order No.");
                        if not PurchaseHeader.IsEmpty() then begin
                            BlanketPurchaseOrder.SetTableView(PurchaseHeader);
                            BlanketPurchaseOrder.Editable := false;
                            BlanketPurchaseOrder.Run();
                        end;
                    end;
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
                            'Purchase_Order_Line',
                            Page::"Purchase Order Subform",
                            EditinExcelFilters,
                            StrSubstNo(ExcelFileNameTxt, Rec."Document No."));
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
        BackgroundErrorCheck := DocumentErrorsMgt.BackgroundValidationEnabled();
        IsSaaSExcelAddinEnabled := ServerSetting.GetIsSaasExcelAddinEnabled();
    end;

    trigger OnAfterGetRecord()
    var

    begin
        TypeChosen := Rec.HasTypeToFillMandatotyFields();
        CLEAR(DocumentTotals);
        Rec."LFS EXIM Type" := Rec."LFS EXIM Type"::Import;
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
        EximCodeunit: Codeunit "LFS EXIM General Functions";
        // ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        // PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        BackgroundErrorCheck: Boolean;
        InvDiscAmountEditable: Boolean;
        IsSaaSExcelAddinEnabled: Boolean;
        RefreshMessageEnabled: Boolean;
        ShowAllLinesEnabled: Boolean;
        TypeChosen: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        // UpdateAllowedVar: Boolean;
        VATAmount: Decimal;
        ActionOnlyAllowedForAllocationAccountsErr: Label 'This action is only available for lines that have Allocation Account set as Type.';
        ExcelFileNameTxt: Label 'Purchase Order %1 - Lines', Comment = '%1 = document number, ex. 10000';

        Text001Lbl: Label 'You cannot use the Explode BOM function because a prepayment of the purchase order has been invoiced.';
        // Text000Lbl: Label 'Unable to run this function while in View mode.';
        UpdateInvDiscountQstLbl: Label 'One or more lines have been invoiced. The discount distributed to invoiced lines will not be taken into account.\\Do you want to update the invoice discount?';
        RefreshMessageText: Text;
        TotalAmountStyle: Text;

    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Disc. (Yes/No)", Rec);
    end;

    procedure CalculateTAX()
    var
        CalculateTax1: Codeunit "Calculate Tax";
    begin
        CurrPage.SaveRecord();
        CalculateTax1.CallTaxEngineOnPurchaseLine(Rec, xRec);
    end;

    procedure ClearTotalPurchaseHeader();
    begin
        Clear(TotalPurchaseHeader);
    end;

    procedure ForceTotalsCalculation()
    begin
        DocumentTotals.PurchaseDocTotalsNotUpToDate();
    end;

    // local procedure CrossReferenceNoOnAfterValidat()
    // begin
    //     InsertExtendedText(false);
    // end;

    procedure ShowDocumentLineTracking()
    var
        DocumentLineTrackings: Page "Document Line Tracking";
        DocumentLineSourceType: Enum "Document Line Source Type";
    begin
        Clear(DocumentLineTrackings);
        DocumentLineTrackings.SetSourceDoc(DocumentLineSourceType::"Purchase Order", Rec."Document No.", Rec."Line No.", Rec."Blanket Order No.", Rec."Blanket Order Line No.", '', 0);
        DocumentLineTrackings.RunModal();
    end;

    procedure ShowTracking()
    var
        TrackingForm: Page "Order Tracking";
    begin
        //Removing Warnings ++
        // TrackingForm.SetPurchLine(Rec);
        TrackingForm.SetVariantRec(Rec, Rec."No.", Rec."Outstanding Qty. (Base)", Rec."Expected Receipt Date", Rec."Expected Receipt Date");
        TrackingForm.RUNMODAL();
    end;

    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.Update(SetSaveRecord);
    end;

    local procedure AttachToInventoryItemLine(var SelectedPurchLine: Record "Purchase Line")
    var
        InvtItemPurchLine: Record "Purchase Line";
        TempPurchaseLine: Record "Purchase Line" temporary;
    // IsHandled: Boolean;
    begin
        SelectedPurchLine.SetFilter(Type, '>%1', SelectedPurchLine.Type::" ");
        SelectedPurchLine.SetFilter(Quantity, '<>0');
        if not SelectedPurchLine.Findset() then
            exit;

        InvtItemPurchLine.SetRange("Document Type", SelectedPurchLine."Document Type");
        InvtItemPurchLine.SetRange("Document No.", SelectedPurchLine."Document No.");
        InvtItemPurchLine.SetRange(Type, SelectedPurchLine.Type::Item);
        InvtItemPurchLine.SetRange("Attached to Line No.", 0);
        if InvtItemPurchLine.Findset() then
            repeat
                if InvtItemPurchLine.IsInventoriableItem() then begin
                    TempPurchaseLine := InvtItemPurchLine;
                    TempPurchaseLine.Insert();
                end;
            until InvtItemPurchLine.Next() = 0;

        if PAGE.RunModal(PAGE::"Purchase Lines", TempPurchaseLine) = ACTION::LookupOK then
            if TempPurchaseLine."Line No." <> 0 then
                repeat
                    if not SelectedPurchLine.IsInventoriableItem() then begin
                        SelectedPurchLine."Attached to Line No." := TempPurchaseLine."Line No.";
                        SelectedPurchLine.Modify();
                    end;
                until SelectedPurchLine.Next() = 0;
    end;

    // local procedure CalcInvDisc()
    // begin
    //     CODEUNIT.RUN(CODEUNIT::"Purch.-Calc.Discount", Rec);
    // end;

    local procedure ExplodeBOM()
    begin
        if Rec."Prepmt. Amt. Inv." <> 0 then
            ERROR(Text001Lbl);
        CODEUNIT.RUN(CODEUNIT::"Purch.-Explode BOM", Rec);
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

    local procedure OpenSalesOrderForm()
    var
        SalesHeader: Record "Sales Header";
        SalesOrder: Page "Sales Order";
    begin
        Rec.TESTFIELD("Sales Order No.");
        SalesHeader.SETRANGE("No.", Rec."Sales Order No.");
        SalesOrder.SETTABLEVIEW(SalesHeader);
        SalesOrder.EDITABLE := FALSE;
        SalesOrder.RUN();
    end;

    local procedure OpenSpecOrderSalesOrderForm()
    var
        SalesHeader: Record "Sales Header";
        SalesOrder: Page "Sales Order";
    begin
        Rec.TESTFIELD("Special Order Sales No.");
        SalesHeader.SETRANGE("No.", Rec."Special Order Sales No.");
        SalesOrder.SETTABLEVIEW(SalesHeader);
        SalesOrder.EDITABLE := FALSE;
        SalesOrder.RUN();
    end;

    local procedure RedistributeTotalsOnAfterValidate()
    begin
        CurrPage.SAVERECORD();

        PurchHeader.GET(Rec."Document Type", Rec."Document No.");
        if DocumentTotals.PurchaseCheckNumberOfLinesLimit(PurchHeader) then
            DocumentTotals.PurchaseRedistributeInvoiceDiscountAmounts(Rec, VATAmount, TotalPurchaseLine);
        CurrPage.UPDATE();
    end;
}