namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.History;
using System.Automation;
using Microsoft.Finance.Dimension;
using Microsoft.Purchases.Comment;

page 72080 "LFS Posted Import PurchReceipt"
{
    ApplicationArea = All;
    Caption = 'Posted Import PurchReceipt';
    PageType = Document;
    SourceTable = "Purch. Rcpt. Header";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of a general ledger account, item, additional cost, or fixed asset, depending on what you selected in the Type field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ToolTip = 'Specifies the name of the vendor who delivered the items.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Buy-from Contact No."; Rec."Buy-from Contact No.")
                {
                    ToolTip = 'Specifies the number of the contact person at the vendor who delivered the items.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ToolTip = 'Specifies the name of the vendor who delivered the items.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Buy-from Address"; Rec."Buy-from Address")
                {
                    ToolTip = 'Specifies the address of the vendor who delivered the items.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Buy-from Address 2"; Rec."Buy-from Address 2")
                {
                    ToolTip = 'Specifies an additional part of the address of the vendor who delivered the items.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Buy-from City"; Rec."Buy-from City")
                {
                    ToolTip = 'Specifies the city of the vendor who delivered the items.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    ToolTip = 'Specifies the post code of the vendor who delivered the items.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ToolTip = 'Specifies the name of the contact person at the vendor who delivered the items.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    ToolTip = 'Specifies how many times the document has been printed.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the posting date of the record.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the date when the purchase document was created.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ToolTip = 'Specifies the date that you want the vendor to deliver to the ship-to address. The value in the field is used to calculate the latest date you can order the items to have them delivered on the requested receipt date. if you do not need delivery on a specific date, you can leave the field blank.';
                    ApplicationArea = All;
                }
                field("Quote No."; Rec."Quote No.")
                {
                    ToolTip = 'Specifies the quote number for the posted purchase receipt.';
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    ToolTip = 'Specifies the line number of the order that created the entry.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor Order No."; Rec."Vendor Order No.")
                {
                    ToolTip = 'Specifies the vendor''s order number.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                {
                    ToolTip = 'Specifies the vendor''s shipment number. It is inserted in the corresponding field on the source document during posting.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ToolTip = 'Specifies the order address of the related vendor.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ToolTip = 'Specifies which purchaser is assigned to the vendor.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("GST Vendor Type"; Rec."GST Vendor Type")
                {
                    ToolTip = 'Specifies the value of the GST Vendor Type field.';
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Bill of Entry No."; Rec."Bill of Entry No.")
                {
                    ToolTip = 'Specifies the value of the Bill of Entry No. field.';
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Bill of Entry Date"; Rec."Bill of Entry Date")
                {
                    ToolTip = 'Specifies the value of the Bill of Entry Date field.';
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Bill of Entry Value"; Rec."Bill of Entry Value")
                {
                    ToolTip = 'Specifies the value of the Bill of Entry Value field.';
                    ApplicationArea = All;
                    Importance = Additional;
                }
            }
            part(PurchReceiptLines; "EXIM Posted Import Receipt Sub")
            {
                ApplicationArea = all;
                SubPageLink = "Document No." = field("No.");
            }
            group(Invoicing)
            {
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ToolTip = 'Specifies the number of the vendor that you received the invoice from.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Pay-to Contact no."; Rec."Pay-to Contact no.")
                {
                    ToolTip = 'Specifies the number of the person to contact about an invoice from this vendor.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ToolTip = 'Specifies the name of the vendor who you received the invoice from.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Pay-to Address"; Rec."Pay-to Address")
                {
                    ToolTip = 'Specifies the address of the vendor that you received the invoice from.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Pay-to Address 2"; Rec."Pay-to Address 2")
                {
                    ToolTip = 'Specifies an additional part of the address of the vendor that the invoice was received from.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    ToolTip = 'Specifies the post code of the vendor that you received the invoice from.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Pay-to City"; Rec."Pay-to City")
                {
                    ToolTip = 'Specifies the city of the vendor that you received the invoice from.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ToolTip = 'Specifies the contact person at the vendor that you received the invoice from.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group(Shipping)
            {
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTip = 'Specifies the name of the customer that items on the purchase order were shipped to, as a drop shipment.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ToolTip = 'Specifies the address that items on the purchase order were shipped to, as a drop shipment..';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ToolTip = 'Specifies an additional part of the ship-to address, in case it is a long address.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ToolTip = 'Specifies the post code that items on the purchase order were shipped to, as a drop shipment.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ToolTip = 'Specifies the city of the address that the items are shipped to.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ToolTip = 'Specifies the contact person at the customer that items on the purchase order were shipped to, as a drop shipment.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies a code for the location where you want the items to be placed when they are received.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ToolTip = 'Specifies the delivery conditions of the related shipment, such as free on board (FOB).';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    ToolTip = 'Specifies a date formula for the amount of time it takes to replenish the item.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ToolTip = 'Specifies the date you expect the items to be available in your warehouse. if you leave the field blank, it will be calculated as follows: Planned Receipt Date + Safety Lead Time + Inbound Warehouse Handling Time = Expected Receipt Date.';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Notes; Notes)
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("&Receipt")
            {
                Caption = '&Receipt';
                Image = Receipt;
                action(Statistics)
                {
                    ApplicationArea = Suite;
                    Caption = 'Statistics';
                    Image = Statistics;
                    RunObject = Page "Purchase Receipt Statistics";
                    RunPageLink = "No." = field("No.");
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';
                }
                action("Co&mments")
                {
                    ApplicationArea = Suite;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = const(Receipt),
                                  "No." = field("No."),
                                  "Document Line No." = const(0);
                    ToolTip = 'View or add comments for the record.';
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
                action(Approvals)
                {
                    AccessByPermission = TableData "Posted Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ShowPostedApprovalEntries(Rec.RecordId);
                    end;
                }
            }
        }
        area(processing)
        {
            action("&Print")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                begin
                    PurchRcptHeader := Rec;
                    CurrPage.SetSelectionFilter(PurchRcptHeader);
                    PurchRcptHeader.PrintRecords(true);
                end;
            }
            action("&Navigate")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Find entries...';
                Image = Navigate;
                ShortCutKey = 'Ctrl+Alt+Q';
                ToolTip = 'Find entries and documents that exist for the document number and posting date on the selected document. (Formerly this action was named Navigate.)';

                trigger OnAction()
                begin
                    Rec.Navigate();
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

                actionref("&Print_Promoted"; "&Print")
                {
                }
                actionref("&Navigate_Promoted"; "&Navigate")
                {
                }
            }
            group(Category_Category5)
            {
                Caption = 'Print/Send', Comment = 'Generated from the PromotedActionCategories property index 4.';

            }
            group(Category_Category4)
            {
                Caption = 'Receipt', Comment = 'Generated from the PromotedActionCategories property index 3.';

                actionref(Dimensions_Promoted; Dimensions)
                {
                }
                actionref(Statistics_Promoted; Statistics)
                {
                }
                actionref(Approvals_Promoted; Approvals)
                {
                }
                actionref("Co&mments_Promoted"; "Co&mments")
                {
                }
            }
            group(Category_Report)
            {
                Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetSecurityFilterOnRespCenter();
    end;

    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
}