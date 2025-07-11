namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.History;
using Microsoft.Inventory.Ledger;
using Microsoft.Foundation.Navigate;
using Microsoft.Finance.Dimension;

page 72093 "EXIM Posted Import Receipt Sub"
{
    ApplicationArea = All;
    Caption = 'EXIM Posted Import Receipt Sub';
    PageType = ListPart;
    SourceTable = "Purch. Rcpt. Line";
    Editable = false;
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
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
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
                    ToolTip = 'Specifies either the name of or a description of the item or general ledger account.';
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the code for the location where the receipt line is registered.';
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
                    ToolTip = 'Specifies the number of units of the item specified on the line.';
                    ApplicationArea = All;
                    BlankZero = true;
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
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ToolTip = 'Specifies the date that you want the vendor to deliver to the ship-to address. The value in the field is used to calculate the latest date you can order the items to have them delivered on the requested receipt date. if you do not need delivery on a specific date, you can leave the field blank.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ToolTip = 'Specifies the date the items were expected.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ToolTip = 'Specifies the date when the related order was created.';
                    ApplicationArea = All;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    ToolTip = 'Specifies a date formula for the amount of time it takes to replenish the item.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("GST Credit"; Rec."GST Credit")
                {
                    ToolTip = 'Specifies the value of the GST Credit field.';
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                field("GST Group Code"; Rec."GST Group Code")
                {
                    ToolTip = 'Specifies the value of the GST Group Code field.';
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                field("GST Group Type"; Rec."GST Group Type")
                {
                    ToolTip = 'Specifies the value of the GST Group Type field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    ToolTip = 'Specifies the value of the HSN/SAC Code field.';
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                field(Exempted; Rec.Exempted)
                {
                    ToolTip = 'Specifies the value of the Exempted field.';
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
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
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
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,3';
                    ToolTip = 'Specifies the Shortcut Dimension 3';
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
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the receipt number.';
                    ApplicationArea = All;
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
                action(OrderTracking)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Order &Tracking';
                    Image = OrderTracking;
                    ToolTip = 'Tracks the connection of a supply to its corresponding demand. This can help you find the original demand that created a specific production order or purchase order.';

                    trigger OnAction()
                    begin
                        ShowTracking();
                    end;
                }
                action("&Undo Receipt")
                {
                    ApplicationArea = Suite;
                    Caption = '&Undo Receipt';
                    Image = Undo;
                    ToolTip = 'Cancel the quantity posting on the selected posted receipt line. A corrective line is inserted under the selected receipt line. if the quantity was received in a warehouse receipt, then a corrective line is inserted in the posted warehouse receipt. The Quantity Received and Qty. Rcd. Not Invoiced fields on the related purchase order are set to zero.';

                    trigger OnAction()
                    begin
                        UndoReceiptLine();
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
                action(ItemInvoiceLines)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Invoice &Lines';
                    Image = ItemInvoice;
                    ToolTip = 'View posted purchase invoice lines for the item. ';

                    trigger OnAction()
                    begin
                        PageShowItemPurchInvLines();
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
            }
        }
    }
    var
        ShortcutDimCode: array[8] of Code[20];

    procedure ShowDocumentLineTracking()
    var
        DocumentLineTrackings: Page "Document Line Tracking";
        DocumentLineSourceType: Enum "Document Line Source Type";
    begin
        Clear(DocumentLineTrackings);
        DocumentLineTrackings.SetSourceDoc(DocumentLineSourceType::"Purchase Receipt", Rec."Document No.", Rec."Line No.", Rec."Blanket Order No.", Rec."Blanket Order Line No.", Rec."Order No.", Rec."Order Line No.");
        DocumentLineTrackings.RunModal();
    end;

    local procedure PageShowItemPurchInvLines()
    begin
        Rec.TESTFIELD(Type, Rec.Type::Item);
        Rec.ShowItemPurchInvLines();
    end;

    local procedure ShowTracking()
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        ItemLedgEntry1: Record "Item Ledger Entry";
        TrackingForm: Page "Order Tracking";
    begin
        Rec.TESTFIELD(Type, Rec.Type::Item);
        if Rec."Item Rcpt. Entry No." <> 0 then begin
            ItemLedgEntry.GET(Rec."Item Rcpt. Entry No.");
            TrackingForm.SetItemLedgEntry(ItemLedgEntry);
        end else
            TrackingForm.SetMultipleItemLedgEntries(ItemLedgEntry1,
              DATABASE::"Purch. Rcpt. Line", 0, Rec."Document No.", '', 0, Rec."Line No.");

        TrackingForm.RUNMODAL();
    end;

    local procedure UndoReceiptLine()
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
        PurchRcptLine.COPY(Rec);
        CurrPage.SETSELECTIONFILTER(PurchRcptLine);
        CODEUNIT.RUN(CODEUNIT::"Undo Purchase Receipt Line", PurchRcptLine);
    end;
}