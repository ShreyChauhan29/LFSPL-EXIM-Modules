namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.Document;
using Microsoft.Foundation.ExtendedText;
using Microsoft.Inventory.Location;
using Microsoft.Inventory.Setup;
using Microsoft.Finance.TaxBase;
using Microsoft.Foundation.Navigate;
using Microsoft.Purchases.Document;
using System.Environment.Configuration;
using Microsoft.Pricing.Calculation;
using Microsoft.Utilities;
using Microsoft.Sales.Setup;
using System.Integration.Excel;
using Microsoft.Purchases.History;
using Microsoft.Finance.AllocationAccount.Sales;
using Microsoft.Finance.AllocationAccount;
using Microsoft.Foundation.Attachment;
using Microsoft.Inventory.Item.Substitution;
using Microsoft.Inventory.Availability;
using Microsoft.Inventory.Item.Catalog;
using Microsoft.Inventory.BOM;
using Microsoft.Sales.Pricing;
using Microsoft.Inventory.Item;
using Microsoft.Finance.Dimension;
using Microsoft.Finance.Deferral;
using Microsoft.Warehouse.Structure;

page 72059 "LFS Export Sales Order Subform"
{
    ApplicationArea = All;
    Caption = 'Export Sales Order Subform';
    PageType = ListPart;
    SourceTable = "Sales Line";
    AutoSplitKey = true;
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;

    SourceTableView = where("Document Type" = FILTER(Order));
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
                        Clear(TypeChosen);
                        TypeOnAfterValidate();
                        TypeChosen := REc.HasTypeToFillMandatotyFields();
                        SetLocationCodeMandatory();
                    end;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the record.';
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies the variant of the item on the line.';
                    ApplicationArea = All;
                    Visible = true;

                    trigger OnValidate()
                    begin
                        VariantCodeOnAfterValidate();
                    end;
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
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the item or service on the line.';
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Unit of Measure Code';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the inventory location from which the items sold should be picked and where the inventory decrease is registered.';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        LocationCodeOnAfterValidate();
                        CalculateTAX();
                    end;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ToolTip = 'Specifies the bin where the items are picked or put away.';
                    ApplicationArea = All;
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
                field("Drop Shipment"; Rec."Drop Shipment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if your vendor ships the items directly to your customer.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when items on the document are shipped or were shipped. A shipment date is usually calculated from a requested delivery date plus lead time.';
                }

                field(Reserve; Rec.Reserve)
                {
                    ToolTip = 'Specifies whether a reservation can be made for items on this line.';
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        ReserveOnAfterValidate();
                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the quantity of the sales order line.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CalculateTAX();
                    end;
                }
                field("Qty. to Assemble to Order"; Rec."Qty. to Assemble to Order")
                {
                    Visible = false;
                    ToolTip = 'Specifies how many units of the blanket sales line quantity that you want to supply by assembly.';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        QtyToAsmToOrderOnAfterValidate();
                    end;

                    trigger OnDrillDown()
                    begin
                        rec.ShowAsmToOrderLines();
                    end;
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Purchase Order No. field.';
                    ApplicationArea = All;
                }
                field("License Type"; Rec."LFS License Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the License Type';
                }
                field("License No."; Rec."LFS License No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the License No.';
                }
                field("Reserved Quantity"; Rec."Reserved Quantity")
                {
                    Visible = false;
                    ToolTip = 'Specifies how many units of the item on the line have been reserved.';
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ToolTip = 'Specifies the name of the item or resource''s unit of measure, such as piece or hour.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    Visible = false;
                    ToolTip = 'Specifies the cost, in LCY, of one unit of the item or resource on the line.';
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the price for one unit on the sales line.';
                    ApplicationArea = All;
                }

                field("Line Amount"; Rec."Line Amount")
                {
                    ToolTip = 'Specifies the net amount, excluding any invoice discount amount, that must be paid for products on the line.';
                    ApplicationArea = All;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    Visible = false;
                    ToolTip = 'Specifies the discount percentage that is granted for the item on the line.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CalculateTAX();
                    end;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    Visible = false;
                    ToolTip = 'Specifies the discount amount that is granted for the item on the line.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CalculateTAX();
                    end;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    Visible = false;
                    ToolTip = 'Specifies the net weight of one unit of the item. In the sales statistics window, the net weight on the line is included in the total net weight of all the lines for the particular sales document.';
                    ApplicationArea = All;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    Visible = false;
                    ToolTip = 'Specifies the gross weight of one unit of the item. In the sales statistics window, the gross weight on the line is included in the total gross weight of all the lines for the particular sales document.';
                    ApplicationArea = All;
                }
                field("Prepayment %"; Rec."Prepayment %")
                {
                    Visible = false;
                    ToolTip = 'Specifies the prepayment percentage to use to calculate the prepayment for sales.';
                    ApplicationArea = All;


                }
                field("Prepmt. Line Amount"; Rec."Prepmt. Line Amount")
                {
                    Visible = false;
                    ToolTip = 'Specifies the prepayment amount of the line in the currency of the sales document if a prepayment percentage is specified for the sales line.';
                    ApplicationArea = All;


                }
                field("Prepmt. Amt. Inv."; Rec."Prepmt. Amt. Inv.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the prepayment amount that has already been invoiced to the customer for this sales line.';
                    ApplicationArea = All;


                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    Visible = false;
                    ToolTip = 'Specifies if the invoice line is included when the invoice discount is calculated.';
                    ApplicationArea = All;

                }

                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    ToolTip = 'Specifies the invoice discount amount for the line.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Qty. to Ship"; Rec."Qty. to Ship")
                {
                    ToolTip = 'Specifies the quantity of items that remain to be shipped.';
                    ApplicationArea = All;
                    BlankZero = true;

                    trigger OnValidate()
                    begin
                        if Rec."Qty. to Asm. to Order (Base)" <> 0 then begin
                            CurrPage.SAVERECORD();
                            CurrPage.UPDATE(FALSE);
                        end;
                    end;
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    ToolTip = 'Specifies how many units of the item on the line have been posted as shipped.';
                    ApplicationArea = All;
                    BlankZero = false;
                    QuickEntry = false;
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    ToolTip = 'Specifies the quantity that remains to be invoiced. It is calculated as Quantity - Qty. Invoiced.';
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ToolTip = 'Specifies how many units of the item on the line have been posted as invoiced.';
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("EXIM Type"; Rec."LFS EXIM Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the EXIM Type';
                }
                field("Prepmt Amt to Deduct"; Rec."Prepmt Amt to Deduct")
                {
                    ToolTip = 'Specifies the prepayment amount that has already been deducted from ordinary invoices posted for this sales order line.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Prepmt Amt Deducted"; Rec."Prepmt Amt Deducted")
                {
                    ToolTip = 'Specifies the prepayment amount that has already been deducted from ordinary invoices posted for this sales order line.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                    ToolTip = 'Specifies that you can assign item charges to this line.';
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
                field("Deferral Code"; Rec."Deferral Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the deferral template that governs how revenue earned with this sales document is deferred to the different accounting periods when the good or service was delivered.';
                    ApplicationArea = All;
                    Enabled = (Rec.Type <> Rec.Type::"Fixed Asset") AND (Rec.Type <> Rec.Type::" ");
                    TableRelation = "Deferral Template"."Deferral Code";
                }
                field("LFS FOB in USD"; Rec."LFS FOB in USD")
                {
                    ToolTip = 'Specifies the value of the FOB in USD field.', Comment = '%';
                }
                field("LFS FOB Currency Code"; Rec."LFS FOB Currency Code")
                {
                    ToolTip = 'Specifies the value of the FOB Currency Code field.', Comment = '%';
                }
                field("LFS FOB Currency Exchange Rate"; Rec."LFS FOB Currency Exchange Rate")
                {
                    ToolTip = 'Specifies the value of the FOB Currency Factor field.', Comment = '%';
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
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the HSN/SAC Code';
                    trigger OnValidate()
                    begin
                        CalculateTAX();
                    end;
                }
                field("GST Place Of Supply"; Rec."GST Place Of Supply")
                {
                    ToolTip = 'Specifies the GST Place of Supply. For example Bill-to Address, Ship-to Address, Location Address etc.';
                }
                field("LFS HS Code"; Rec."LFS HS Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the HS Code';
                }
                field("Incentive Type"; Rec."LFS Incentive Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Incentive Type';
                    trigger OnValidate()
                    var
                        license: Record "LFS EXIM Export License";
                    begin
                        license.setrange("LFS Source No.", Rec."Document No.");
                        license.setrange("LFS Source line No.", Rec."Line No.");
                        if not license.IsEmpty() then
                            if Rec."LFS Incentive Type" = Rec."LFS Incentive Type"::DDB then
                                error('Multiple Licenses are already defined for this document line');
                    end;
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
                // field("Category Type"; Rec."LFS Category Type")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                //     ToolTip = 'Specifies the Category Type';
                // }

                field("Claim DDB"; Rec."LFS Claim DDB")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Claim DDB';
                }
                // field("Currency Exch. Rate"; Rec."LFS Currency Exch. Rate")
                // {
                //     Visible = false;
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the Currency Exch. Rate';
                // }
                field("Custom Exch. Rate"; Rec."LFS Custom Exch. Rate")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Custom Exch. Rates';
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
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the Shortcut Dimension 3';
                    CaptionClass = '1,2,3';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    // Visible = DimVisible3;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,4';
                    ToolTip = 'Specifies the Shortcut Dimension 4';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    // Visible = DimVisible4;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the line number.';
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
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
                // field("No. & Kind Of PKDG"; Rec."LFS No. & Kind Of PKDG")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                //     ToolTip = 'Specifies the No. & Kind Of PKDG';
                // }
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
                    action(GetPrice)
                    {
                        AccessByPermission = TableData "Sales Price" = R;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Get Price';
                        Ellipsis = true;
                        Image = Price;
                        ToolTip = 'Insert the lowest possible price in the Unit Price field according to any special price that you have set up.';
                        Visible = not ExtendedPriceEnabled;
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Replaced by the new implementation (V16) of price calculation.';
                        ObsoleteTag = '17.0';

                        trigger OnAction()
                        begin
                            ShowPrices();
                        end;
                    }
                    action("Get Li&ne Discount")
                    {
                        AccessByPermission = TableData "Sales Line Discount" = R;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Get Li&ne Discount';
                        Ellipsis = true;
                        Image = LineDiscount;
                        ToolTip = 'Insert the best possible discount in the Line Discount field according to any special discounts that you have set up.';
                        Visible = not ExtendedPriceEnabled;
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Replaced by the new implementation (V16) of price calculation.';
                        ObsoleteTag = '17.0';

                        trigger OnAction()
                        begin
                            ShowLineDisc();
                        end;
                    }
                    action(GetPrices)
                    {
                        AccessByPermission = TableData "Sales Price Access" = R;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Get Price';
                        Ellipsis = true;
                        Image = Price;
                        Visible = ExtendedPriceEnabled;
                        ToolTip = 'Insert the lowest possible price in the Unit Price field according to any special price that you have set up.';

                        trigger OnAction()
                        begin
                            ShowPrices();
                        end;
                    }
                    action(GetLineDiscount)
                    {
                        AccessByPermission = TableData "Sales Discount Access" = R;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Get Li&ne Discount';
                        Ellipsis = true;
                        Image = LineDiscount;
                        Visible = ExtendedPriceEnabled;
                        ToolTip = 'Insert the best possible discount in the Line Discount field according to any special discounts that you have set up.';

                        trigger OnAction()
                        begin
                            ShowLineDisc();
                        end;
                    }
                    action(ExplodeBOM_Functions)
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
                        ApplicationArea = Basic, Suite;
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
                        Visible = AttachingLinesEnabled;
                        ToolTip = 'Attach the selected non-inventory product lines to a inventory item line in this sales order.';

                        trigger OnAction()
                        var
                            SelectedSalesLine: Record "Sales Line";
                        begin
                            CurrPage.SetSelectionFilter(SelectedSalesLine);
                            Rec.AttachToInventoryItemLine(SelectedSalesLine);
                        end;
                    }
                    action(Reserve1)
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
                        ApplicationArea = Basic, Suite;
                        Caption = 'Order &Tracking';
                        Image = OrderTracking;
                        Enabled = Rec.Type = Rec.Type::Item;
                        ToolTip = 'Track the connection of a supply to its corresponding demand for the selected item. This can help you find the original demand that created a specific production order or purchase order. This action is available only for lines that contain an item.';

                        trigger OnAction()
                        begin
                            ShowTracking();
                        end;
                    }
                    action("Select Nonstoc&k Items")
                    {
                        AccessByPermission = TableData "Nonstock Item" = R;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Select Ca&talog Items';
                        Image = NonStockItem;
                        ToolTip = 'View the list of catalog items that exist in the system. ';

                        trigger OnAction()
                        begin
                            ShowNonstockItems();
                        end;
                    }
                }
                group("Item Availability by")
                {
                    Enabled = Rec.Type = Rec.Type::Item;
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    action("<Action3>")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Event';
                        Image = "Event";
                        ToolTip = 'View how the actual and the projected available balance of an item will develop over time according to supply and demand events.';

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
                    action(ItemAvailabilityByPeriod)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Period';
                        Image = Period;
                        ToolTip = 'Show the projected quantity of the item over time according to time periods, such as day, week, or month.';

                        trigger OnAction()
                        // begin
                        //     ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByPeriod())
                        // end;
                        var
                            SalesAvailabilityMgt: Codeunit Microsoft.Sales.Document."Sales Availability Mgt.";
                        begin
                            SalesAvailabilityMgt.ShowItemAvailabilityFromSalesLine(Rec, "Item Availability Type"::Period);
                        end;
                    }
                    action(ItemAvailabilityByVariant)
                    {
                        ApplicationArea = Planning;
                        Caption = 'Variant';
                        Image = ItemVariant;
                        ToolTip = 'View or edit the item''s variants. Instead of setting up each color of an item as a separate item, you can set up the various colors as variants of the item.';

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
                    action(ItemAvailabilityByLocation)
                    {
                        AccessByPermission = TableData Location = R;
                        ApplicationArea = Location;
                        Caption = 'Location';
                        Image = Warehouse;
                        ToolTip = 'View the actual and projected quantity of the item per location.';

                        trigger OnAction()
                        // begin
                        //     ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByLocation())
                        // end;
                        var
                            SalesAvailabilityMgt: Codeunit Microsoft.Sales.Document."Sales Availability Mgt.";
                        begin
                            SalesAvailabilityMgt.ShowItemAvailabilityFromSalesLine(Rec, "Item Availability Type"::Location);
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
                        ToolTip = 'View the current and projected quantity of the item for each lot.';
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
                        //     ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByBOM())
                        // end;
                        var
                            SalesAvailabilityMgt: Codeunit Microsoft.Sales.Document."Sales Availability Mgt.";
                        begin
                            SalesAvailabilityMgt.ShowItemAvailabilityFromSalesLine(Rec, "Item Availability Type"::BOM);
                        end;
                    }
                    action(ItemAvailabilityByUnitOfMeasure)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Unit of Measure';
                        Image = UnitOfMeasure;
                        ToolTip = 'View the item''s availability by a unit of measure.';

                        trigger OnAction()
                        // begin
                        //     ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByUOM());
                        // end;
                        var
                            SalesAvailabilityMgt: Codeunit Microsoft.Sales.Document."Sales Availability Mgt.";
                        begin
                            SalesAvailabilityMgt.ShowItemAvailabilityFromSalesLine(Rec, "Item Availability Type"::UOM);
                        end;
                    }
                }
                group("Related Information")
                {
                    Caption = 'Related Information';
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
                    action(ItemTrackingLines)
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
                    action(SelectItemSubstitution)
                    {
                        AccessByPermission = TableData "Item Substitution" = R;
                        ApplicationArea = Suite;
                        Caption = 'Select Item Substitution';
                        Image = SelectItemSubstitution;
                        ToolTip = 'Select another item that has been set up to be sold instead of the original item if it is unavailable.';

                        trigger OnAction()
                        begin
                            CurrPage.SaveRecord();
                            Rec.ShowItemSub();
                            CurrPage.Update(true);
                            if (Rec.Reserve = Rec.Reserve::Always) and (Rec."No." <> xRec."No.") then begin
                                Rec.AutoReserve();
                                CurrPage.Update(false);
                            end;
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
                    action("Item Charge &Assignment")
                    {
                        AccessByPermission = TableData "Item Charge" = R;
                        ApplicationArea = ItemCharges;
                        Caption = 'Item Charge &Assignment';
                        Image = ItemCosts;
                        Enabled = Rec.Type = Rec.Type::"Charge (Item)";
                        ToolTip = 'Record additional direct costs, for example for freight. This action is available only for Charge (Item) line types.';

                        trigger OnAction()
                        begin
                            ItemChargeAssgnt();
                        end;
                    }
                    action(OrderPromising)
                    {
                        AccessByPermission = TableData "Order Promising Line" = R;
                        ApplicationArea = OrderPromising;
                        Caption = 'Order &Promising';
                        Image = OrderPromising;
                        ToolTip = 'Calculate the shipment and delivery dates based on the item''s known and expected availability dates, and then promise the dates to the customer.';

                        trigger OnAction()
                        begin
                            OrderPromisingLine();
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
                    group("Assemble to Order")
                    {
                        Caption = 'Assemble to Order';
                        Image = AssemblyBOM;
                        action(AssembleToOrderLines)
                        {
                            AccessByPermission = TableData "BOM Component" = R;
                            ApplicationArea = Assembly;
                            Image = AssemblyOrder;
                            Caption = 'Assemble-to-Order Lines';
                            ToolTip = 'View any linked assembly order lines if the documents represents an assemble-to-order sale.';

                            trigger OnAction()
                            begin
                                Rec.ShowAsmToOrderLines();
                            end;
                        }
                        action("Roll Up &Price")
                        {
                            AccessByPermission = TableData "BOM Component" = R;
                            ApplicationArea = Assembly;
                            Caption = 'Roll Up &Price';
                            Ellipsis = true;
                            Image = RollUpCosts;
                            ToolTip = 'Update the unit price of the assembly item according to any changes that you have made to the assembly components.';

                            trigger OnAction()
                            begin
                                Rec.RollupAsmPrice();
                                CalculateTotals();
                            end;
                        }
                        action("Roll Up &Cost")
                        {
                            AccessByPermission = TableData "BOM Component" = R;
                            ApplicationArea = Assembly;
                            Caption = 'Roll Up &Cost';
                            Ellipsis = true;
                            Image = RollUpCosts;
                            ToolTip = 'Update the unit cost of the assembly item according to any changes that you have made to the assembly components.';

                            trigger OnAction()
                            begin
                                Rec.RollUpAsmCost();
                                CalculateTotals();
                            end;
                        }
                    }
                    action(DocumentLineTracking)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Document &Line Tracking';
                        Image = Navigate;
                        ToolTip = 'View related open, posted, or archived documents or document lines. ';

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
                        ToolTip = 'View or edit the deferral schedule that governs how revenue made with this sales document is deferred to different accounting periods when the document is posted.';

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
                            SalesAllocAccMgt: Codeunit "Sales Alloc. Acc. Mgt.";
                        begin
                            if ((Rec."Type" <> Rec."Type"::"Allocation Account") and (Rec."Selected Alloc. Account No." = '')) then
                                Error(ActionOnlyAllowedForAllocationAccountsErr);

                            SalesAllocAccMgt.CreateLinesFromAllocationAccountLine(Rec);
                            Rec.Delete();
                            CurrPage.Update(false);
                        end;
                    }
                }
            }

            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment';
                    Image = Delivery;
                    action("Purchase &Order")
                    {
                        AccessByPermission = TableData "Purch. Rcpt. Header" = R;
                        ApplicationArea = Suite;
                        Caption = 'Purchase &Order';
                        Image = Document;
                        ToolTip = 'View the purchase order that is linked to the sales order, for drop shipment or special order.';

                        trigger OnAction()
                        begin
                            OpenPurchOrderForm();
                        end;
                    }
                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order';
                    Image = SpecialOrder;
                    action(OpenSpecialPurchaseOrder)
                    {
                        AccessByPermission = TableData "Purch. Rcpt. Header" = R;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase &Order';
                        Image = Document;
                        ToolTip = 'View the purchase order that is linked to the sales order, for drop shipment or special order.';

                        trigger OnAction()
                        begin
                            OpenSpecialPurchOrderForm();
                        end;
                    }
                }
                action(BlanketOrder)
                {
                    ApplicationArea = Suite;
                    Caption = 'Blanket Order';
                    Image = BlanketOrder;
                    ToolTip = 'View the blanket sales order.';

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                        BlanketSalesOrder: Page "Blanket Sales Order";
                    begin
                        Rec.TestField("Blanket Order No.");
                        SalesHeader.SetRange("No.", Rec."Blanket Order No.");
                        if not SalesHeader.IsEmpty() then begin
                            BlanketSalesOrder.SetTableView(SalesHeader);
                            BlanketSalesOrder.Editable := false;
                            BlanketSalesOrder.Run();
                        end;
                    end;
                }
            }
            group("Exim")
            {
                action("Packing List")
                {
                    ApplicationArea = all;
                    Caption = 'Packing List';
                    ToolTip = 'Specifies the Packing List';
                    Image = List;
                    trigger OnAction()
                    var
                        PackingList: Record "LFS EXIM Packing List Tab.";
                        PackingListPage: page "LFS EXIM Packing List";
                    begin
                        PackingList.SetRange("LFS Source Document No.", Rec."Document No.");
                        PackingList.SetRange("LFS Source Doc. Line No.", Rec."Line No.");
                        PackingList.setrange("LFS Source Order No.", Rec."Document No.");
                        PackingList.setrange("LFS Source Order Line No.", Rec."Line No.");
                        PackingList.setrange("LFS Source Document Type", PackingList."LFS Source Document Type"::"Sales Order");
                        PackingListPage.SetTableView(PackingList);
                        Page.RunModal(page::"LFS EXIM Packing List", PackingList);
                    end;
                }
                action(AssignFreightandInsurance)
                {
                    ApplicationArea = All;
                    Caption = 'Assign Freiight & Insurance';
                    Image = UpdateDescription;
                    ToolTip = 'Executes the Assign Freiight & Insurance action.';

                    trigger OnAction()
                    var
                        SalesHdr: Record "Sales Header";
                    begin
                        SalesHdr.Get(Rec."Document Type", Rec."Document No.");
                        SalesHdr.AssignFreightNIns(SalesHdr);
                    end;
                }
                action(MarkGSTOnAssessableValue)
                {
                    ApplicationArea = All;
                    Caption = 'Mark GST On Assessable Value';
                    Image = UpdateDescription;
                    ToolTip = 'Mark GST On Assessable Value';

                    trigger OnAction()
                    var
                        SalesHdr: Record "Sales Header";
                        SalesLine: Record "Sales Line";
                        CalculateTax: Codeunit "Calculate Tax";
                    begin
                        SalesHdr.Get(Rec."Document Type", Rec."Document No.");
                        SalesHdr.MarkGSTonAssessableValue();

                        //CurrPage.SaveRecord();
                        CurrPage.Update();
                        SalesLine.SetRange("Document Type", Rec."Document Type");
                        SalesLine.SetRange("Document No.", Rec."Document No.");
                        if SalesLine.FindSet() then
                            repeat
                                CalculateTax.CallTaxEngineOnSalesLine(SalesLine, xRec);
                                SalesLine.Modify();
                            until SalesLine.Next() = 0;
                        CurrPage.Update();
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
                    ToolTip = 'View a list of sales lines that have issues before you post the document.';

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
                    ToolTip = 'View all sales lines, including lines with and without issues.';

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
                            'Sales_Order_Line',
                            page::"Sales Order Subform",
                            EditinExcelFilters,
                            StrSubstNo(ExcelFileNameTxt, Rec."Document No."));
                    end;

                }
            }
        }
    }

    trigger OnInit()
    begin
        "Process Carried OutVisible" := true;
    end;

    trigger OnAfterGetRecord()
    var
        Eximcodeunit: Codeunit "LFS EXIM General Functions";
    begin
        rEC.ShowShortcutDimCode(ShortcutDimCode);
        rec."LFS EXIM Type" := Rec."LFS EXIM Type"::Export;
        EximCodeunit."LFS UpdateCustExhRateSales"(Rec);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."LFS Source No." := Rec."Document No.";
        Rec."LFS Source Line No." := Rec."Line No.";
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

    trigger OnOpenPage()
    var
        DocumentErrorsMgt: Codeunit "Document Errors Mgt.";
        PriceCalculationMgt: Codeunit "Price Calculation Mgt.";
        ServerSetting: Codeunit "Server Setting";
    begin
        ExtendedPriceEnabled := PriceCalculationMgt.IsExtendedPriceCalculationEnabled();
        IsSaaSExcelAddinEnabled := ServerSetting.GetIsSaasExcelAddinEnabled();
        BackgroundErrorCheck := DocumentErrorsMgt.BackgroundValidationEnabled();
        SuppressTotals := CurrentClientType() = ClientType::ODataV4;
        AttachingLinesEnabled :=
            SalesSetup."Auto Post Non-Invt. via Whse." = SalesSetup."Auto Post Non-Invt. via Whse."::"Attached/Assigned";
    end;

    var
        // TotalSalesLine: Record "Sales Line";
        // SalesHeader: Record "Sales Header";
        SalesSetup: Record "Sales & Receivables Setup";
        // UpdateInvDiscountQst: TextConst ENU = 'One or more lines have been invoiced. The discount distributed to invoiced lines will not be taken into account.\\Do you want to update the invoice discount?', ENN = 'One or more lines have been invoiced. The discount distributed to invoiced lines will not be taken into account.\\Do you want to update the invoice discount?';
        TotalSalesHeader: Record "Sales Header";
        TotalSalesLine: Record "Sales Line";
        DocumentTotals: Codeunit "Document Totals";
        // SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        AttachingLinesEnabled: Boolean;
        BackgroundErrorCheck: Boolean;
        // VATAmount: Decimal;
        ExtendedPriceEnabled: Boolean;
        IsSaaSExcelAddinEnabled: Boolean;
        ItemPanelVisible: Boolean;
        // licence_Boolean: Boolean;
        // RefreshMessageText: Text;
        // RefreshMessageEnabled: Boolean;
        // TotalAmountStyle: Text;
        // InvDiscAmountEditable: Boolean;
        LocationCodeMandatory: Boolean;
        // ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        // SalesCalcDiscByType: Codeunit "Sales - Calc Discount By Type";
        "Process Carried OutVisible": Boolean;
        ShowAllLinesEnabled: Boolean;
        // ItemChargeStyleExpression: Text;
        SuppressTotals: Boolean;
        TypeChosen: Boolean;
        ShortcutDimCode: array[8] OF Code[20];

        InvoiceDiscountAmount: Decimal;
        InvoiceDiscountPct: Decimal;
        VATAmount: Decimal;
        // InvoiceDiscountAmount: Decimal;
        // AmountWithDiscountAllowed: Decimal;
        ActionOnlyAllowedForAllocationAccountsErr: Label 'This action is only available for lines that have Allocation Account set as Type.';
        ExcelFileNameTxt: Label 'Sales Order %1 - Lines', Comment = '%1 = document number, ex. 10000';

        Text001Lbl: Label 'You cannot use the Explode BOM function because a prepayment of the sales order has been invoiced.';

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
        CalculateTaxs: Codeunit "Calculate Tax";
    begin
        CurrPage.SaveRecord();
        if (Rec."GST Group Code" <> '') and (Rec."HSN/SAC Code" <> '') then
            // begin
            // Rec.Validate("GST Place Of Supply");
            CalculateTaxs.CallTaxEngineOnSalesLine(Rec, xRec);
        // end;
    end;

    // local procedure UnitofMeasureCodeOnAfterValida()
    // begin
    //     if Rec.Reserve = Rec.Reserve::Always then begin
    //         CurrPage.SAVERECORD();
    //         Rec.AutoReserve();
    //         CurrPage.UPDATE(FALSE);
    //     end;
    // end;

    procedure CalculateTotals()
    begin
        if SuppressTotals then
            exit;

        DocumentTotals.SalesCheckIfDocumentChanged(Rec, xRec);
        DocumentTotals.RefreshSalesLine(Rec);
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
        if Rec."Prepmt. Amt. Inv." <> 0 then
            ERROR(Text001Lbl);
        CODEUNIT.RUN(CODEUNIT::"Sales-Explode BOM", Rec);
    end;

    procedure ForceTotalsCalculation()
    begin
        DocumentTotals.SalesDocTotalsNotUpToDate();
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

    procedure ItemChargeAssgnt()
    begin
        Rec.ShowItemChargeAssgnt();
    end;

    procedure MakeInvisibleLineControl()
    begin
        "Process Carried OutVisible" := FALSE;
    end;


    procedure MakeVisibleLineControl()
    begin
        "Process Carried OutVisible" := true;
    end;

    procedure OpenPurchOrderForm()
    var
        PurchHeader: Record "Purchase Header";
        PurchOrder: Page "Purchase Order";
    begin
        rEC.TESTFIELD("Purchase Order No.");
        PurchHeader.SETRANGE("No.", Rec."Purchase Order No.");
        PurchOrder.SETTABLEVIEW(PurchHeader);
        PurchOrder.EDITABLE := FALSE;
        PurchOrder.RUN();
    end;

    procedure OpenSpecialPurchOrderForm()
    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchHeader: Record "Purchase Header";
        PurchOrder: Page "Purchase Order";
    begin
        Rec.TESTFIELD("Special Order Purchase No.");
        PurchHeader.SETRANGE("No.", REc."Special Order Purchase No.");
        if NOT PurchHeader.ISEMPTY then begin
            PurchOrder.SETTABLEVIEW(PurchHeader);
            PurchOrder.EDITABLE := FALSE;
            PurchOrder.RUN();
        end else begin
            PurchRcptHeader.SETRANGE("Order No.", Rec."Special Order Purchase No.");
            if PurchRcptHeader.COUNT = 1 then
                PAGE.RUN(PAGE::"Posted Purchase Receipt", PurchRcptHeader)
            else
                PAGE.RUN(PAGE::"Posted Purchase Receipts", PurchRcptHeader);
        end;
    end;

    procedure OrderPromisingLine()
    var
        OrderPromisingLine1: Record "Order Promising Line";
        OrderPromisingLines: Page "Order Promising Lines";
    begin
        OrderPromisingLine1.SETRANGE("Source ID", Rec."Document No.");
        OrderPromisingLine1.SETRANGE("Source Line No.", Rec."Line No.");
        OrderPromisingLines.SetSource(OrderPromisingLine1."Source Type"::Sales);
        OrderPromisingLines.SETTABLEVIEW(OrderPromisingLine1);
        OrderPromisingLines.RUNMODAL();
    end;

    procedure ShowDocumentLineTracking()
    var
        DocumentLineTracking1: Page "Document Line Tracking";
        "Document Line Source Type": Enum "Document Line Source Type";
    begin
        Clear(DocumentLineTracking1);
        DocumentLineTracking1.SetSourceDoc("Document Line Source Type"::"Sales Order", Rec."Document No.", Rec."Line No.", Rec."Blanket Order No.", Rec."Blanket Order Line No.", '', 0);
        DocumentLineTracking1.RunModal();
    end;

    procedure ShowLineDisc()
    begin
        // SalesHeader.GET(Rec."Document Type", Rec."Document No.");
        // // CLEAR(SalesPriceCalcMgt);
        // // SalesPriceCalcMgt.GetSalesLineLineDisc(SalesHeader, Rec);
        // SalesLinePrice.SetLine(PriceType::Sale, SalesHeader, Rec);
        // PriceCalculationMgt.GetHandler(SalesLinePrice, PriceCalculation);
        Rec.PickDiscount();
        UpdateForm(true);
    end;

    procedure ShowNonstockItems()
    begin
        Rec.ShowNonstock();
    end;

    procedure ShowPrices()
    begin
        // SalesHeader.GET(Rec."Document Type", Rec."Document No.");
        // // CLEAR(SalesPriceCalcMgt);
        // // SalesPriceCalcMgt.GetSalesLinePrice(SalesHeader, Rec);
        // SalesLinePrice.SetLine(PriceType::Sale, SalesHeader, Rec);
        // PriceCalculationMgt.GetHandler(SalesLinePrice, PriceCalculation);
        Rec.PickPrice();
        UpdateForm(true);
    end;

    procedure ShowTracking()
    var
        TrackingForm: Page "Order Tracking";
    begin
        //Removing Warnings ++
        // TrackingForm.SetSalesLine(Rec);
        TrackingForm.SetVariantRec(Rec, Rec."No.", Rec."Outstanding Qty. (Base)", Rec."Shipment Date", Rec."Shipment Date");
        TrackingForm.RUNMODAL();
    end;

    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;

    local procedure LocationCodeOnAfterValidate()
    begin
        SaveAndAutoAsmToOrder();

        if (Rec.Reserve = Rec.Reserve::Always) AND
           (Rec."Outstanding Qty. (Base)" <> 0) AND
           (Rec."Location Code" <> xRec."Location Code")
        then begin
            CurrPage.SAVERECORD();
            Rec.AutoReserve();
            CurrPage.UPDATE(FALSE);
        end;
    end;

    // local procedure QuantityOnAfterValidate()
    // var
    //     UpdateIsDone: Boolean;
    // begin
    //     if Rec.Type = Rec.Type::Item then
    //         CASE Rec.Reserve OF
    //             Rec.Reserve::Always:
    //                 begin
    //                     CurrPage.SAVERECORD();
    //                     Rec.AutoReserve();
    //                     CurrPage.UPDATE(FALSE);
    //                     UpdateIsDone := true;
    //                 end;
    //             Rec.Reserve::Optional:
    //                 if (Rec.Quantity < xRec.Quantity) AND (xRec.Quantity > 0) then begin
    //                     CurrPage.SAVERECORD();
    //                     CurrPage.UPDATE(FALSE);
    //                     UpdateIsDone := true;
    //                 end;
    //         end;

    //     if (Rec.Type = Rec.Type::Item) AND
    //        (Rec.Quantity <> xRec.Quantity) AND
    //        NOT UpdateIsDone
    //     then
    //         CurrPage.UPDATE(true);
    // end;

    local procedure QtyToAsmToOrderOnAfterValidate()
    begin
        CurrPage.SAVERECORD();
        if REc.Reserve = Rec.Reserve::Always then
            Rec.AutoReserve();
        CurrPage.UPDATE(true);
    end;

    local procedure ReserveOnAfterValidate()
    begin
        if (Rec.Reserve = Rec.Reserve::Always) AND (Rec."Outstanding Qty. (Base)" <> 0) then begin
            CurrPage.SAVERECORD();
            Rec.AutoReserve();
            CurrPage.UPDATE(FALSE);
        end;
    end;

    // local procedure ShipmentDateOnAfterValidate()
    // begin
    //     if (Rec.Reserve = Rec.Reserve::Always) AND
    //         (Rec."Outstanding Qty. (Base)" <> 0) AND
    //         (Rec."Shipment Date" <> xRec."Shipment Date")
    //     then begin
    //         CurrPage.SAVERECORD();
    //         Rec.AutoReserve();
    //         CurrPage.UPDATE(FALSE);
    //     end else
    //         CurrPage.UPDATE(true);
    // end;

    local procedure SaveAndAutoAsmToOrder()
    begin
        if (Rec.Type = Rec.Type::Item) AND Rec.IsAsmToOrderRequired() then begin
            CurrPage.SAVERECORD();
            Rec.AutoAsmToOrder();
            CurrPage.UPDATE(FALSE);
        end;
    end;

    local procedure SetLocationCodeMandatory()
    var
        InventorySetup: Record "Inventory Setup";
    begin
        Clear(LocationCodeMandatory);
        InventorySetup.GET();
        LocationCodeMandatory := InventorySetup."Location Mandatory" AND (Rec.Type = Rec.Type::Item);
    end;

    local procedure TypeOnAfterValidate()
    begin
        Clear(ItemPanelVisible);
        ItemPanelVisible := Rec.Type = Rec.Type::Item;
    end;


    // local procedure CrossReferenceNoOnAfterValidat()
    // begin
    //     InsertExtendedText(FALSE);
    // end;

    local procedure VariantCodeOnAfterValidate()
    begin
        SaveAndAutoAsmToOrder();
    end;
}