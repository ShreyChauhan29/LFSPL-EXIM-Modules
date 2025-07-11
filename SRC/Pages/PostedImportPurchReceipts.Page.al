namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.History;
using Microsoft.Finance.Dimension;
using Microsoft.Purchases.Comment;
using Microsoft.Sales.History;

page 72081 "LFS Posted ImportPurchReceipts"
{
    ApplicationArea = All;
    Caption = 'Posted ImportPurchReceipts';
    PageType = List;
    SourceTable = "Purch. Rcpt. Header";
    UsageCategory = History;
    Editable = false;
    Permissions = tabledata "Sales Shipment Header" = rimd, tabledata "Sales Shipment Line" = rimd;
    CardPageId = "LFS Posted Import PurchReceipt";
    SourceTableView = where("LFS EXIM Type" = filter(Import));
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of a general ledger account, item, additional cost, or fixed asset, depending on what you selected in the Type field.';
                    ApplicationArea = All;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ToolTip = 'Specifies the name of the vendor who delivered the items.';
                    ApplicationArea = All;
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ToolTip = 'Specifies the order address of the related vendor.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ToolTip = 'Specifies the name of the vendor who delivered the items.';
                    ApplicationArea = All;
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    ToolTip = 'Specifies the post code of the vendor who delivered the items.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                {
                    ToolTip = 'Specifies the country or region of the address.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ToolTip = 'Specifies the name of the contact person at the vendor who delivered the items.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ToolTip = 'Specifies the number of the vendor that you received the invoice from.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ToolTip = 'Specifies the name of the vendor who you received the invoice from.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    ToolTip = 'Specifies the post code of the vendor that you received the invoice from.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country or region of the vendor on the purchase document.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ToolTip = 'Specifies the contact person at the vendor that you received the invoice from.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Order No."; Rec."Order No.")
                {
                    ToolTip = 'Specifies the line number of the order that created the entry.';
                    ApplicationArea = All;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies a code for an alternate shipment address if you want to ship to another address than the one that has been entered automatically. This field is also used in case of drop shipment.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTip = 'Specifies the name of the customer that items on the purchase order were shipped to, as a drop shipment.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ToolTip = 'Specifies the post code that items on the purchase order were shipped to, as a drop shipment.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country or region of the ship-to address.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ToolTip = 'Specifies the contact person at the customer that items on the purchase order were shipped to, as a drop shipment.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the posting date of the record.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ToolTip = 'Specifies which purchaser is assigned to the vendor.';
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
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies a code for the location where you want the items to be placed when they are received.';
                    ApplicationArea = All;
                    Visible = true;
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    ToolTip = 'Specifies how many times the document has been printed.';
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the date when the purchase document was created.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ToolTip = 'Specifies the delivery conditions of the related shipment, such as free on board (FOB).';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ToolTip = 'Specifies the value of the Order Date field.';
                    ApplicationArea = All;
                }
                field("Bill of Entry No."; Rec."Bill of Entry No.")
                {
                    ToolTip = 'Specifies the Bill of Entry No.';
                    ApplicationArea = All;
                }
                field("Bill of Entry Date"; Rec."Bill of Entry Date")
                {
                    ToolTip = 'Specifies the Bill of Entry Date';
                    ApplicationArea = All;
                }
                field("Inco Terms"; Rec."LFS Inco Terms")
                {
                    ToolTip = 'Specifies the Inco Terms';
                    ApplicationArea = All;
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
        area(Processing)
        {
            group(Receipt)
            {
                Caption = '&Receipt';
                Image = Receipt;
                action(Statistics)
                {
                    ApplicationArea = All;
                    Caption = 'Statistics';
                    ToolTip = 'Specifies the Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Purchase Receipt Statistics";
                    RunPageLink = "No." = field("No.");

                }
                action(Comments)
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    ToolTip = 'Specifies the Comments';
                    Image = ViewComments;
                    RunObject = page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = const(Receipt), "No." = field("No.");

                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    ToolTip = 'Specifies the Dimensions';
                    AccessByPermission = tabledata Dimension = R;
                    Image = Dimensions;
                    ShortcutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions();
                    end;
                }
            }
        }
        area(Navigation)
        {
            action(Print)
            {
                ApplicationArea = All;
                Caption = '&Print';
                ToolTip = 'Specifies the Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Ellipsis = true;

                trigger OnAction()
                var
                    PurchRcptHeader: Record "Purch. Rcpt. Header";
                begin
                    CurrPage.SETSELECTIONFILTER(PurchRcptHeader);
                    PurchRcptHeader.PrintRecords(true);
                end;
            }
            action("&Navigate")
            {
                ApplicationArea = All;
                Caption = '&Navigate';
                ToolTip = 'Specifies the Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.Navigate();
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetSecurityFilterOnRespCenter();
    end;
}
