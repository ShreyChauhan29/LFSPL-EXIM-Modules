namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.History;
using Microsoft.Inventory.BOM;
using Microsoft.Inventory.Ledger;
using Microsoft.Foundation.Navigate;
using Microsoft.Finance.Dimension;

page 72094 "LFS EXIM Posted Shpt. Subform"
{
    ApplicationArea = All;
    Caption = 'EXIM Posted Shpt. Subform';
    PageType = ListPart;
    SourceTable = "Sales Shipment Line";
    Editable = false;
    Permissions = tabledata "Sales Shipment Line" = rm;
    InsertAllowed = false;
    DeleteAllowed = false;
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
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies the variant of the item on the line.';
                    ApplicationArea = All;
                    Visible = true;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies either the name of or the description of the item, general ledger account or item charge.';
                    ApplicationArea = All;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ToolTip = 'Specifies the net weight of one unit of the item. In the sales statistics window, the net weight on the line is included in the total net weight of all the lines for the particular sales document.';
                    ApplicationArea = All;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ToolTip = 'Specifies the gross weight of one unit of the item. In the sales statistics window, the gross weight on the line is included in the total gross weight of all the lines for the particular sales document.';
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location in which the invoice line was registered.';
                    ApplicationArea = All;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ToolTip = 'Specifies the bin where the items are picked or put away.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the number of units of the item, general ledger account, or item charge on the line.';
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ToolTip = 'Specifies the name of the item or resource''s unit of measure, such as piece or hour.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ToolTip = 'Specifies how many units of the item on the line have been posted as invoiced.';
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Qty. Shipped Not Invoiced"; Rec."Qty. Shipped Not Invoiced")
                {
                    ToolTip = 'Specifies the quantity of the shipped item that has been posted as shipped but that has not yet been posted as invoiced.';
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ToolTip = 'Specifies the date that the customer has asked for the order to be delivered.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ToolTip = 'Specifies when items on the document are shipped or were shipped. A shipment date is usually calculated from a requested delivery date plus lead time.';
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    ToolTip = 'Specifies how long it takes from when the items are shipped from the warehouse to when they are delivered.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ToolTip = 'Specifies the number of the item ledger entry that the document or journal line is applied to.';
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
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    ToolTip = 'Specifies the value of the HSN/SAC Code field.';
                    ApplicationArea = All;
                }
                field("GST Group Code"; Rec."GST Group Code")
                {
                    ToolTip = 'Specifies the value of the GST Group Code field.';
                    ApplicationArea = All;
                }
                field("GST Group Type"; Rec."GST Group Type")
                {
                    ToolTip = 'Specifies the value of the GST Group Type field.';
                    ApplicationArea = All;
                }
                field("Unit Price Incl. of Tax"; Rec."Unit Price Incl. of Tax")
                {
                    ToolTip = 'Specifies the value of the Unit Price Incl. of Tax field.';
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the value of the Unit Price field.';
                    ApplicationArea = All;
                }
                field("Packing Details"; Rec."LFS Packing Details")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Packing Details of the line';
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
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Order Tra&cking")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Order Tra&cking';
                    Image = OrderTracking;
                    ToolTip = 'Tracks the connection of a supply to its corresponding demand. This can help you find the original demand that created a specific production order or purchase order.';

                    trigger OnAction()
                    begin
                        ShowTracking();
                    end;
                }
                action(UndoShipment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Undo Shipment';
                    Image = UndoShipment;
                    ToolTip = 'Withdraw the line from the shipment. This is useful for making corrections, because the line is not deleted. You can make changes and post it again.';

                    trigger OnAction()
                    begin
                        UndoShipmentPosting();
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
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
                action(Comments)
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
                action(ItemTrackingEntries)
                {
                    ApplicationArea = ItemTracking;
                    Caption = 'Item &Tracking Entries';
                    Image = ItemTrackingLedger;
                    ToolTip = 'View serial or lot numbers that are assigned to items.';

                    trigger OnAction()
                    begin
                        Rec.ShowItemTrackingLines();
                    end;
                }
                action("Assemble-to-Order")
                {
                    AccessByPermission = TableData "BOM Component" = R;
                    ApplicationArea = Assembly;
                    Image = AssemblyOrder;
                    Caption = 'Assemble-to-Order';
                    ToolTip = 'View the linked assembly order if the shipment was for an assemble-to-order sale.';

                    trigger OnAction()
                    begin
                        Rec.ShowAsmToOrder();
                    end;
                }
                action(ItemInvoiceLines)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Invoice &Lines';
                    Image = ItemInvoice;
                    ToolTip = 'View posted sales invoice lines for the item.';

                    trigger OnAction()
                    begin
                        PageShowItemSalesInvLines();
                    end;
                }
                action(DocumentLineTracking)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Document &Line Tracking';
                    Image = Navigate;
                    ToolTip = 'View related open, posted, or archived documents or document lines.';

                    trigger OnAction()
                    begin
                        ShowDocumentLineTracking();
                    end;
                }
                action("Packing List")
                {
                    ApplicationArea = All;
                    Image = Report;
                    // Promoted = true;
                    // PromotedCategory = Category4;
                    ToolTip = 'Specifies the Packing List';
                    trigger OnAction()
                    var
                        EXIMPackingLines: Record "LFS EXIM Posted Packing Table";
                        EXIMPackingLinespage: Page "LFS Posted Packing List";
                    begin
                        EXIMPackingLines.SetRange("LFS Posted Export Shipment", Rec."Document No.");
                        EXIMPackingLines.SetRange("LFS PostExShipmentLineNo.", Rec."Line No.");
                        EXIMPackingLinespage.SetTableView(EXIMPackingLines);
                        Page.RunModal(page::"LFS Posted Packing List", EXIMPackingLines);
                    end;
                }
            }
        }
    }
    var
        ShortcutDimCode: array[8] of Code[20];

    procedure ShowDocumentLineTracking()
    var
        DocumentLineTrackings: Page "Document Line Tracking";
        NewSourceDocType: Enum "Document Line Source Type";
    begin
        Clear(DocumentLineTrackings);
        DocumentLineTrackings.SetSourceDoc(
          NewSourceDocType::"Sales Shipment", Rec."Document No.", Rec."Line No.", Rec."Blanket Order No.", Rec."Blanket Order Line No.", Rec."Order No.", Rec."Order Line No.");
        DocumentLineTrackings.RunModal();
    end;

    local procedure PageShowItemSalesInvLines()
    begin
        Rec.TESTFIELD(Type, Rec.Type::Item);
        Rec.ShowItemSalesInvLines();
    end;

    local procedure ShowTracking()
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        ItemLedgEntry1: Record "Item Ledger Entry";
        TrackingForm: Page "Order Tracking";
    begin
        Rec.TESTFIELD(Type, Rec.Type::Item);
        if Rec."Item Shpt. Entry No." <> 0 then begin
            ItemLedgEntry.GET(Rec."Item Shpt. Entry No.");
            TrackingForm.SetItemLedgEntry(ItemLedgEntry);
        end else
            TrackingForm.SetMultipleItemLedgEntries(ItemLedgEntry1,
              DATABASE::"Sales Shipment Line", 0, Rec."Document No.", '', 0, Rec."Line No.");

        TrackingForm.RUNMODAL();
    end;

    local procedure UndoShipmentPosting()
    var
        SalesShptLine: Record "Sales Shipment Line";
    begin
        SalesShptLine.COPY(Rec);
        CurrPage.SETSELECTIONFILTER(SalesShptLine);
        CODEUNIT.RUN(CODEUNIT::"Undo Sales Shipment Line", SalesShptLine);
    end;
}