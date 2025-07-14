namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.Document;
using Microsoft.Pricing.PriceList;
using Microsoft.Finance.GST.StockTransfer;
using Microsoft.Inventory.BOM;
using Microsoft.Finance.Dimension;
using Microsoft.Sales.History;
using Microsoft.Inventory.Location;
using Microsoft.Foundation.ExtendedText;
using Microsoft.Utilities;
using Microsoft.Inventory.Availability;

page 72089 "LFSEXIMBlanketExp.OrderSubform"
{
    ApplicationArea = All;
    Caption = 'EXIMBlanketExp.OrderSubform';
    PageType = ListPart;
    SourceTable = "Sales Line";
    SourceTableView = where("Document Type" = filter("Blanket Order"), "LFS EXIM Type" = filter(Export));
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
                    ToolTip = 'Specifies the line type.';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        NoOnAfterValidate();
                        if xRec."No." <> '' then
                            RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the record.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate();
                        if xRec."No." <> '' then
                            RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies the variant of the item on the line.';
                    ApplicationArea = All;
                    Visible = false;
                    trigger OnValidate()
                    begin
                        VariantCodeOnAfterValidate();
                    end;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ToolTip = 'Specifies the VAT specification of the involved item or resource to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.';
                    ApplicationArea = All;
                    Visible = false;
                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the item or service on the line.';
                    ApplicationArea = All;
                }
                field("Price Inclusive of Tax"; Rec."Price Inclusive of Tax")
                {
                    ToolTip = 'Specifies if the price in inclusive of tax for the line.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unit Price Incl. of Tax"; Rec."Unit Price Incl. of Tax")
                {
                    ToolTip = 'Specifies unit prices are inclusive of tax on the line.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the inventory location from which the items sold should be picked and where the inventory decrease is registered.';
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the quantity of the sales order line.';
                    ApplicationArea = All;
                    BlankZero = true;
                    trigger OnValidate()
                    begin
                        QuantityOnAfterValidate();
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Qty. to Assemble to Order"; Rec."Qty. to Assemble to Order")
                {
                    ToolTip = 'Specifies how many units of the blanket sales line quantity that you want to supply by assembly.';
                    ApplicationArea = All;
                    Visible = false;
                    trigger OnValidate()
                    begin
                        CurrPage.SAVERECORD();
                        CurrPage.UPDATE(true);
                    end;

                    trigger OnDrillDown()
                    begin
                        Rec.ShowAsmToOrderLines();
                    end;
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                    ToolTip = 'Specifies which work type the resource applies to when the sale is related to a job.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        UnitofMeasureCodeOnAfterValida();
                        RedistributeTotalsOnAfterValidate();
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
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the price for one unit on the sales line.';
                    ApplicationArea = All;
                    BlankZero = true;
                    trigger OnValidate()
                    begin
                        Rec.TESTFIELD("Price Inclusive of Tax", FALSE);
                        RedistributeTotalsOnAfterValidate();
                    end;

                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ToolTip = 'Specifies the net amount, excluding any invoice discount amount, that must be paid for products on the line.';
                    ApplicationArea = All;
                    BlankZero = true;
                    trigger OnValidate()
                    begin
                        Rec.TESTFIELD("Price Inclusive of Tax", FALSE);
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ToolTip = 'Specifies the discount percentage that is granted for the item on the line.';
                    ApplicationArea = All;
                    BlankZero = true;
                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ToolTip = 'Specifies the discount amount that is granted for the item on the line.';
                    ApplicationArea = All;
                    Visible = false;
                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ToolTip = 'Specifies if the invoice line is included when the invoice discount is calculated.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Qty. to Ship"; Rec."Qty. to Ship")
                {
                    ToolTip = 'Specifies the quantity of items that remain to be shipped.';
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    ToolTip = 'Specifies how many units of the item on the line have been posted as shipped.';
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ToolTip = 'Specifies how many units of the item on the line have been posted as invoiced.';
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ToolTip = 'Specifies when items on the document are shipped or were shipped. A shipment date is usually calculated from a requested delivery date plus lead time.';
                    ApplicationArea = All;
                }
                field("GST Place Of Supply"; Rec."GST Place Of Supply")
                {
                    ToolTip = 'Specifies the GST Place of Supply. For example Bill-to Address, Ship-to Address, Location Address etc.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("GST Group Code"; Rec."GST Group Code")
                {
                    ToolTip = 'Specifies an identifier for the GST group used to calculate and post GST.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("GST Group Type"; Rec."GST Group Type")
                {
                    ToolTip = 'Specifies if the GST group is assigned for goods or service.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    ToolTip = 'Specifies the HSN/SAC code for the calculation of GST on Sales line.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Invoice Type"; Rec."Invoice Type")
                {
                    ToolTip = 'Specifies the value of the Invoice Type field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Exempted; Rec.Exempted)
                {
                    ToolTip = 'Specifies if the line is exempted from GST.';
                    ApplicationArea = All;
                    Visible = false;
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
                field("Incentive Type"; Rec."LFS Incentive Type")
                {
                    ToolTip = 'Specifies the value of the Incentive Type field.';
                    ApplicationArea = All;
                }
                field("FOB (FCY) Per Unit"; Rec."LFS FOB Amount (FCY)")
                {
                    ToolTip = 'Specifies the value of the FOB (FCY) Per Unit field.';
                    ApplicationArea = All;
                }
                field("CIF (FCY) Per Unit"; Rec."LFS CIF Amount (FCY)")
                {
                    ToolTip = 'Specifies the value of the CIF (FCY) Per Unit field.';
                    ApplicationArea = All;
                }
                field("No. of Container"; Rec."LFS No. of Container")
                {
                    ToolTip = 'Specifies the value of the No. of Container field.';
                    ApplicationArea = All;
                }
                // field("Freight Type"; Rec."LFS Freight Type")
                // {
                //     ToolTip = 'Specifies the value of the Freight Type field.';
                //     ApplicationArea = All;
                // }
                field("Freight Value Per Type (LCY)"; Rec."LFS Freight Value (LCY)")
                {
                    ToolTip = 'Specifies the value of the Freight Value Per Type (LCY) field.';
                    ApplicationArea = All;
                }
                field("Freight Value Per Type (FCY)"; Rec."LFS Freight Value (FCY)")
                {
                    ToolTip = 'Specifies the value of the Freight Value Per Type (FCY) field.';
                    ApplicationArea = All;
                }
                // field("Insurance Type"; Rec."LFS Insurance Type")
                // {
                //     ToolTip = 'Specifies the value of the Insurance Type field.';
                //     ApplicationArea = All;
                // }
                field("Insurance Value Per Type (LCY)"; Rec."LFS Insurance Value (LCY)")
                {
                    ToolTip = 'Specifies the value of the Insurance Value Per Type (LCY) field.';
                    ApplicationArea = All;
                }
                field("Insurance Value Per Type (FCY)"; Rec."LFS Insurance Value (FCY)")
                {
                    ToolTip = 'Specifies the value of the Insurance Value Per Type (FCY) field.';
                    ApplicationArea = All;
                }
                // field("Category Type"; Rec."LFS Category Type")
                // {
                //     ToolTip = 'Specifies the value of the Category Type field.';
                //     ApplicationArea = All;
                // }
                // field("EXIM Remark"; Rec."LFS EXIM Remark")
                // {
                //     ToolTip = 'Specifies the value of the EXIM Remark field.';
                //     ApplicationArea = All;
                // }
                field("Packing List No."; Rec."LFS Packing List No.")
                {
                    ToolTip = 'Specifies the value of the Packing List No. field.';
                    ApplicationArea = All;
                }
                field("Claim DDB"; Rec."LFS Claim DDB")
                {
                    ToolTip = 'Specifies the value of the Claim DDB field.';
                    ApplicationArea = All;
                }
                field("Currency Exch. Rate"; Rec."LFS Currency Exch. Rate")
                {
                    ToolTip = 'Specifies the value of the Currency Exch. Rate field.';
                    ApplicationArea = All;
                }
                field("Custom Exch. Rate"; Rec."LFS Custom Exch. Rate")
                {
                    ToolTip = 'Specifies the value of the Custom Exch. Rate field.';
                    ApplicationArea = All;
                }
                field("EXIM Item Group"; Rec."LFS EXIM Item Group")
                {
                    ToolTip = 'Specifies the value of the EXIM Item Group field.';
                    ApplicationArea = All;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the ShortcutDimCode 3';
                    CaptionClass = '1,2,3';
                    trigger OnValidate()
                    begin
                        ValidateSaveShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the ShortcutDimCode 4';
                    CaptionClass = '1,2,4';
                    trigger OnValidate()
                    begin
                        ValidateSaveShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the ShortcutDimCode 5';
                    Visible = false;
                    CaptionClass = '1,2,5';
                    trigger OnValidate()
                    begin
                        ValidateSaveShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the ShortcutDimCode 6';
                    CaptionClass = '1,2,6';
                    trigger OnValidate()
                    begin
                        ValidateSaveShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the ShortcutDimCode 7';
                    CaptionClass = '1,2,7';
                    trigger OnValidate()
                    begin
                        ValidateSaveShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the ShortcutDimCode 8';
                    CaptionClass = '1,2,8';
                    trigger OnValidate()
                    begin
                        ValidateSaveShortcutDimCode(8, ShortcutDimCode[8]);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
            }
            group(Control53)
            {
                group(Control49)
                {
                    field("Invoice Discount Amount"; TotalSalesLine."Inv. Discount Amount")
                    {
                        ApplicationArea = all;
                        Editable = InvDiscAmountEditable;
                        Caption = 'Invoice Discount Amount';
                        ToolTip = 'Specifies the Invoice Discount Amount';
                        AutoFormatType = 1;
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
                        ToolTip = 'Specifies the Invoice Discount %';
                        DecimalPlaces = 0 : 2;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                    }
                }
                group(Control35)
                {
                    field("Total Amount Excl. VAT"; TotalSalesLine.Amount)
                    {
                        ApplicationArea = all;
                        Editable = false;
                        Caption = 'Total Amount Excl. VAT';
                        ToolTip = 'Specifies the Total Amount Excl. VAT';
                        AutoFormatType = 1;
                        AutoFormatExpression = TotalSalesHeader."Currency Code";
                        CaptionClass = DocumentTotals.GetTotalExclVATCaption(SalesHeader."Currency Code");
                        DrillDown = false;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                    }
                    field("Total Amount Incl. VAT"; TotalSalesLine."Amount Including VAT")
                    {
                        ApplicationArea = all;
                        Editable = false;
                        Caption = 'Total Amount Incl. VAT';
                        ToolTip = 'Specifies the Total Amount Incl. VAT';
                        AutoFormatType = 1;
                        AutoFormatExpression = TotalSalesLine."Currency Code";
                        CaptionClass = DocumentTotals.GetTotalInclVATCaption(SalesHeader."Currency Code");
                        StyleExpr = TotalAmountStyle;
                    }
                    field(RefreshTotals; RefreshMessageText)
                    {
                        ApplicationArea = all;
                        Enabled = RefreshMessageEnabled;
                        Editable = false;
                        ShowCaption = false;
                        trigger OnDrillDown()
                        begin
                            DocumentTotals.SalesRedistributeInvoiceDiscountAmounts(Rec, VATAmount, TotalSalesLine);
                            DocumentTotals.SalesUpdateTotalsControls(
                              Rec, TotalSalesHeader, TotalSalesLine, RefreshMessageEnabled,
                              TotalAmountStyle, RefreshMessageText, InvDiscAmountEditable, CurrPage.EDITABLE, VATAmount);
                        end;
                    }
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group("&Line")
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
                        Image = "Event";
                        ToolTip = 'Specifies the Event';
                        trigger OnAction()
                        // begin
                        //     ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByEvent)
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
                        Image = Period;
                        ToolTip = 'Specifies the Period';
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
                        Image = ItemVariant;
                        ToolTip = 'Specifies the Variant';
                        trigger OnAction()
                        // begin
                        //     ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByVariant)
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
                        AccessByPermission = tabledata Location = R;
                        Image = Warehouse;
                        ToolTip = 'Specifies the Location';
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
                        Image = BOMLevel;
                        ToolTip = 'Specifies the BOM Level';
                        trigger OnAction()
                        var
                            SalesAvailabilityMgt: Codeunit Microsoft.Sales.Document."Sales Availability Mgt.";
                        begin
                            SalesAvailabilityMgt.ShowItemAvailabilityFromSalesLine(Rec, "Item Availability Type"::BOM);
                        end;
                    }
                }
                group(UnpostedLines)
                {
                    Caption = 'Unposted Lines';
                    Image = Order;
                    action(Orders)
                    {
                        ApplicationArea = All;
                        Caption = 'Orders';
                        Image = Document;
                        ToolTip = 'Specifies the Orders';
                        trigger OnAction()
                        begin
                            ShowOrders();
                        end;
                    }
                    action(Invoices)
                    {
                        ApplicationArea = All;
                        Caption = 'Invoices';
                        Image = Invoice;
                        ToolTip = 'Specifies the Invoices';
                        trigger OnAction()
                        begin
                            ShowInvoices();
                        end;
                    }
                    action(ReturnOrders)
                    {
                        ApplicationArea = All;
                        Caption = 'Return Orders';
                        AccessByPermission = tabledata "Return Receipt Header" = R;
                        Image = ReturnOrder;
                        ToolTip = 'Specifies the Return Orders';
                        trigger OnAction()
                        begin
                            ShowReturnOrders();
                        end;
                    }
                    action(CrediteMemos)
                    {
                        ApplicationArea = All;
                        Caption = 'Credit Memos';
                        Image = CreditMemo;
                        ToolTip = 'Specifies the Credit Memos';
                        trigger OnAction()
                        begin
                            ShowCreditMemos();
                        end;
                    }
                }
                group(Posted)
                {
                    Caption = 'Posted Lines';
                    Image = Post;
                    action(Shipments)
                    {
                        ApplicationArea = All;
                        Caption = 'Shipments';
                        Image = Shipment;
                        ToolTip = 'Specifies the Shipments';
                        trigger OnAction()
                        begin
                            ShowPostedOrders();
                        end;
                    }
                    action(In_voices)
                    {
                        ApplicationArea = All;
                        Caption = 'Invoices';
                        Image = Invoice;
                        ToolTip = 'Specifies the Invoices';
                        trigger OnAction()
                        begin
                            ShowPostedInvoices();
                        end;
                    }
                    action(ReturnReceipts)
                    {
                        ApplicationArea = All;
                        Caption = 'Return Receipts';
                        AccessByPermission = tabledata "Return Receipt Header" = R;
                        Image = ReturnReceipt;
                        ToolTip = 'Specifies the Return Receipts';
                        trigger OnAction()
                        begin
                            ShowPostedReturnReceipts();
                        end;
                    }
                    action(CreditMemos)
                    {
                        ApplicationArea = All;
                        Caption = 'Credit Memos';
                        Image = CreditMemo;
                        ToolTip = 'Specifies the Credit Memos';
                        trigger OnAction()
                        begin
                            ShowPostedCreditMemos();
                        end;
                    }
                }

                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    AccessByPermission = tabledata Dimension = R;
                    Image = Dimensions;
                    ShortcutKey = 'Shift+Ctrl+D';
                    ToolTip = 'Specifies the Dimensions';
                    trigger OnAction()
                    begin
                        Rec.ShowDimensions()
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    ToolTip = 'Specifies the Comments';
                    trigger OnAction()
                    begin
                        Rec.ShowLineComments();
                    end;
                }
                group(AssembleToOrder)
                {
                    Caption = 'Assemble to Order';
                    Image = AssemblyBOM;
                    action(AssembleToOrderLines)
                    {
                        ApplicationArea = All;
                        Caption = 'Assemble-to-Order Lines';
                        AccessByPermission = tabledata "BOM Component" = R;
                        ToolTip = 'Specifies the Assemble-to-Order Lines';
                        Image = AssemblyOrder;
                        trigger OnAction()
                        begin
                            Rec.ShowAsmToOrderLines();
                        end;
                    }
                    action(RollUpPrice)
                    {
                        ApplicationArea = All;
                        Caption = 'Roll Up &Price';
                        AccessByPermission = tabledata "BOM Component" = R;
                        Ellipsis = true;
                        ToolTip = 'Specifies the Roll Up Price';
                        Image = RollUpCosts;
                        trigger OnAction()
                        begin
                            Rec.RollupAsmPrice();
                        end;
                    }
                    action(RollUpCost)
                    {
                        ApplicationArea = All;
                        Caption = 'Roll Up &Cost';
                        AccessByPermission = tabledata "BOM Component" = R;
                        Ellipsis = true;
                        ToolTip = 'Specifies the Roll Up Cost';
                        Image = RollUpCosts;
                        trigger OnAction()
                        begin
                            Rec.RollUpAsmCost();
                        end;
                    }
                }
                // action("Str&ucture")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Str&ucture Details';
                //     Image = Hierarchy;
                // }
                action("DetailedGSTEntryBuffer")
                {
                    ApplicationArea = All;
                    Image = Entries;
                    Caption = 'Detailed GST Entry Buffer';
                    ToolTip = 'Specifies the Detailed GST Entry Buffer';
                    RunObject = page "Detailed GST Entry Buffer";
                    RunPageLink = "Document Type" = field("Document Type"), "Document No." = field("Document No."), "Line No." = field("Line No.");

                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = Action;
                action(GetPrice)
                {
                    ApplicationArea = All;
                    Caption = 'Get &Price';
                    AccessByPermission = tabledata "Price List Line" = R;
                    Image = Price;
                    Ellipsis = true;
                    ToolTip = 'Specifies the Get Price';
                    trigger OnAction()
                    begin
                        ShowPrices();
                    end;
                }
                action(GetLineDisc)
                {
                    ApplicationArea = All;
                    Caption = 'Get Li&ne Discount';
                    AccessByPermission = tabledata "Price List Line" = R;
                    Image = LineDiscount;
                    Ellipsis = true;
                    ToolTip = 'Specifies the Get Line Discount';
                    trigger OnAction()
                    begin
                        ShowLineDisc();
                    end;
                }
                action(E_xplodeBOM)
                {
                    ApplicationArea = All;
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                    ToolTip = 'Specifies the Explode BOM';
                    trigger OnAction()
                    begin
                        ExplodeBOM();
                    end;
                }
                action(InsertExtTexts)
                {
                    ApplicationArea = All;
                    Caption = 'Insert &Ext. Texts';
                    AccessByPermission = tabledata "Extended Text Header" = R;
                    Image = Text;
                    ToolTip = 'Specifies the Insert &Ext. Texts';
                    trigger OnAction()
                    begin
                        InsertExtendedText(true);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        CLEAR(DocumentTotals);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.InitType();
        CLEAR(ShortcutDimCode);
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if SalesHeader.GET(Rec."Document Type", Rec."Document No.") then;

        DocumentTotals.SalesUpdateTotalsControls(
          Rec, TotalSalesHeader, TotalSalesLine, RefreshMessageEnabled,
          TotalAmountStyle, RefreshMessageText, InvDiscAmountEditable, CurrPage.EDITABLE, VATAmount);
    end;

    var
        SalesHeader: Record "Sales Header";
        TotalSalesHeader: Record "Sales Header";
        CurrentSalesLine: Record "Sales Line";
        SalesLine: Record "Sales Line";
        TotalSalesLine: Record "Sales Line";
        DocumentTotals: Codeunit "Document Totals";
        // SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        // SalesPriceCalcMgt: Codeunit "Price Calculation - V16";
        // ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        SalesCalcDiscByType: Codeunit "Sales - Calc Discount By Type";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        InvDiscAmountEditable: Boolean;
        RefreshMessageEnabled: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        VATAmount: Decimal;
        RefreshMessageText: Text;
        TotalAmountStyle: Text;

    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Disc. (Yes/No)", Rec);
    end;

    procedure ShowStrOrderDetailsPITForm()
    begin
    end;

    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;

    // local procedure CalcInvDisc()
    // begin
    //     CODEUNIT.RUN(CODEUNIT::"Sales-Calc. Discount", Rec);
    // end;

    local procedure ExplodeBOM()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Explode BOM", Rec);
    end;

    local procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        if TransferExtendedText.SalesCheckIfAnyExtText(Rec, Unconditionally) then begin
            CurrPage.SAVERECORD();
            COMMIT();
            TransferExtendedText.InsertSalesExtText(Rec);
        end;
        if TransferExtendedText.MakeUpdate() then
            UpdateForm(true);
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(FALSE);

        SaveAndAutoAsmToOrder();
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

        if (Rec.Type = Rec.Type::Item) AND
           (Rec.Quantity <> xRec.Quantity)
        then
            CurrPage.UPDATE(true);
    end;

    local procedure RedistributeTotalsOnAfterValidate()
    begin
        CurrPage.SAVERECORD();

        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
        if DocumentTotals.SalesCheckNumberOfLinesLimit(SalesHeader) then
            DocumentTotals.SalesRedistributeInvoiceDiscountAmounts(Rec, VATAmount, TotalSalesLine);
        CurrPage.UPDATE();
    end;

    local procedure SaveAndAutoAsmToOrder()
    begin
        if (Rec.Type = Rec.Type::Item) AND Rec.IsAsmToOrderRequired() then begin
            CurrPage.SAVERECORD();
            Rec.AutoAsmToOrder();
            CurrPage.UPDATE(FALSE);
        end;
    end;

    local procedure ShowCreditMemos()
    begin
        CurrentSalesLine := Rec;
        SalesLine.Reset();
        SalesLine.SETCURRENTKEY("Document Type", "Blanket Order No.", "Blanket Order Line No.");
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::"Credit Memo");
        SalesLine.SETRANGE("Blanket Order No.", CurrentSalesLine."Document No.");
        SalesLine.SETRANGE("Blanket Order Line No.", CurrentSalesLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Sales Lines", SalesLine);
    end;

    local procedure ShowInvoices()
    begin
        CurrentSalesLine := Rec;
        SalesLine.Reset();
        SalesLine.SETCURRENTKEY("Document Type", "Blanket Order No.", "Blanket Order Line No.");
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Invoice);
        SalesLine.SETRANGE("Blanket Order No.", CurrentSalesLine."Document No.");
        SalesLine.SETRANGE("Blanket Order Line No.", CurrentSalesLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Sales Lines", SalesLine);
    end;

    local procedure ShowLineDisc()
    begin
        // CurrentSalesLine := Rec;
        // SalesLine.Reset();
        // SalesLine.SETCURRENTKEY("Document Type", "Blanket Order No.", "Blanket Order Line No.");
        // SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        // SalesLine.SETRANGE("Blanket Order No.", CurrentSalesLine."Document No.");
        // SalesLine.SETRANGE("Blanket Order Line No.", CurrentSalesLine."Line No.");
        // PAGE.RUNMODAL(PAGE::"Sales Lines", SalesLine);
        Rec.PickDiscount();
        UpdateForm(true);
    end;

    local procedure ShowOrders()
    begin
        CurrentSalesLine := Rec;
        SalesLine.Reset();
        SalesLine.SETCURRENTKEY("Document Type", "Blanket Order No.", "Blanket Order Line No.");
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SETRANGE("Blanket Order No.", CurrentSalesLine."Document No.");
        SalesLine.SETRANGE("Blanket Order Line No.", CurrentSalesLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Sales Lines", SalesLine);
    end;

    local procedure ShowPostedCreditMemos()
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
    begin
        CurrentSalesLine := Rec;
        SalesCrMemoLine.Reset();
        SalesCrMemoLine.SETCURRENTKEY("Blanket Order No.", "Blanket Order Line No.");
        SalesCrMemoLine.SETRANGE("Blanket Order No.", CurrentSalesLine."Document No.");
        SalesCrMemoLine.SETRANGE("Blanket Order Line No.", CurrentSalesLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Posted Sales Credit Memo Lines", SalesCrMemoLine);
    end;

    local procedure ShowPostedInvoices()
    var
        SalesInvLine: Record "Sales Invoice Line";
    begin
        CurrentSalesLine := Rec;
        SalesInvLine.Reset();
        SalesInvLine.SETCURRENTKEY("Blanket Order No.", "Blanket Order Line No.");
        SalesInvLine.SETRANGE("Blanket Order No.", CurrentSalesLine."Document No.");
        SalesInvLine.SETRANGE("Blanket Order Line No.", CurrentSalesLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Posted Sales Invoice Lines", SalesInvLine);
    end;

    local procedure ShowPostedOrders()
    var
        SaleShptLine: Record "Sales Shipment Line";
    begin
        CurrentSalesLine := Rec;
        SaleShptLine.Reset();
        SaleShptLine.SETCURRENTKEY("Blanket Order No.", "Blanket Order Line No.");
        SaleShptLine.SETRANGE("Blanket Order No.", CurrentSalesLine."Document No.");
        SaleShptLine.SETRANGE("Blanket Order Line No.", CurrentSalesLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Posted Sales Shipment Lines", SaleShptLine);
    end;

    local procedure ShowPostedReturnReceipts()
    var
        ReturnRcptLine: Record "Return Receipt Line";
    begin
        CurrentSalesLine := Rec;
        ReturnRcptLine.Reset();
        ReturnRcptLine.SETCURRENTKEY("Blanket Order No.", "Blanket Order Line No.");
        ReturnRcptLine.SETRANGE("Blanket Order No.", CurrentSalesLine."Document No.");
        ReturnRcptLine.SETRANGE("Blanket Order Line No.", CurrentSalesLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Posted Return Receipt Lines", ReturnRcptLine);
    end;

    local procedure ShowPrices()
    begin
        //     SalesHeader.GET(Rec."Document Type", Rec."Document No.");
        //     CLEAR(SalesPriceCalcMgt);
        //     SalesPriceCalcMgt.GetSalesLinePrice(SalesHeader, Rec);
        Rec.PickPrice();
        UpdateForm(true);
    end;

    local procedure ShowReturnOrders()
    begin
        CurrentSalesLine := Rec;
        SalesLine.Reset();
        SalesLine.SETCURRENTKEY("Document Type", "Blanket Order No.", "Blanket Order Line No.");
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::"Return Order");
        SalesLine.SETRANGE("Blanket Order No.", CurrentSalesLine."Document No.");
        SalesLine.SETRANGE("Blanket Order Line No.", CurrentSalesLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Sales Lines", SalesLine);
    end;

    local procedure UnitofMeasureCodeOnAfterValida()
    begin
        if Rec.Reserve = Rec.Reserve::Always then begin
            CurrPage.SAVERECORD();
            Rec.AutoReserve();
        end;
    end;

    local procedure ValidateSaveShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCodes: Code[20])
    begin
        Rec.ValidateShortcutDimCode(FieldNumber, ShortcutDimCodes);
        CurrPage.SAVERECORD();
    end;

    local procedure VariantCodeOnAfterValidate()
    begin
        SaveAndAutoAsmToOrder();
    end;
}
