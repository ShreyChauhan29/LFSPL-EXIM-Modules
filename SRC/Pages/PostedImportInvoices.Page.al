namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.History;
using Microsoft.Purchases.Comment;
using Microsoft.EServices.EDocument;

page 72078 "LFS Posted Import Invoices"
{
    ApplicationArea = All;
    Caption = 'Posted Import Invoices';
    PageType = List;
    SourceTable = "Purch. Inv. Header";
    UsageCategory = History;
    CardPageID = "LFS Posted Import Invoice";
    DeleteAllowed = false;
    Editable = false;
    SourceTableView = where("LFS EXIM Type" = FILTER(Import));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the No.';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Buy-from Vendor No.';
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Order Address Code';
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Buy-from Vendor Name';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Currency Code';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Amount';

                    trigger OnDrillDown()
                    begin
                        Rec.SETRANGE("No.");
                        PAGE.RUNMODAL(PAGE::"Posted Purchase Invoice", Rec)
                    end;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    applicationArea = all;
                    ToolTip = 'Specifies the Amount Including VAT';
                    trigger OnDrillDown()
                    begin
                        Rec.SETRANGE("No.");
                        PAGE.RUNMODAL(PAGE::"Posted Purchase Invoice", Rec)
                    end;
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    applicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Buy-from Post Code';
                }
                field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                {
                    applicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Buy-from Country/Region Code';
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    applicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Buy-from Contact';
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    applicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Pay-to Vendor No.';
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    applicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Pay-to Name';
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    applicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Pay-to Post Code';
                }
                field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
                {
                    applicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Pay-to Country/Region Code';
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    applicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Pay-to Contact';
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Ship-to Code';
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Ship-to Name';
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Ship-to Post Code';
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Ship-to Country/Region Code';
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Order No.';
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Ship-to Contact';
                }
                field("Posting Date"; REc."Posting Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Posting Date';
                }
                field("Purchaser Code"; rec."Purchaser Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Purchaser Code';
                }
                field("Shortcut Dimension 1 Code"; REc."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Shortcut Dimension 1 Code';
                }
                field("Shortcut Dimension 2 Code"; REc."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Shortcut Dimension 2 Code';
                }
                field("Location Code"; REc."Location Code")
                {
                    ApplicationArea = All;
                    Visible = true;
                    ToolTip = 'Specifies the Location Code';
                }
                field("No. Printed"; REc."No. Printed")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the No. Printed';
                }
                field("Document Date"; REc."Document Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Document Date';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Payment Terms Code';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Due Date';
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Payment Discount %';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Payment Method Code';
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Shipment Method Code';
                }
                field("FOB Amount (FCY)"; Rec."LFS FOB Amount (FCY)")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the FOB Amount (FCY)';
                }
                field("FOB Amount (LCY)"; Rec."LFS FOB Amount (LCY)")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the FOB Amount (LCY)';
                }
                field("CIF Amount (FCY)"; Rec."LFS CIF Amount (FCY)")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the CIF Amount (FCY)';
                }
                field("CIF Amount (LCY)"; Rec."LFS CIF Amount (LCY)")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the CIF Amount (LCY)';
                }
                field("Bill of Entry No."; Rec."Bill of Entry No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Bill of Entry No.';
                }
                field("Bill of Entry Date"; Rec."Bill of Entry Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Bill of Entry Date';
                }
                field("Inco Terms"; Rec."LFS Inco Terms")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Inco Terms';
                }
            }
        }
        area(factboxes)
        {
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = all;
                ShowFilter = false;
            }
            systempart(Links; Links)
            {
                ApplicationArea = all;
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = all;
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Invoice")
            {
                Caption = '&Invoice';
                Image = Invoice;
                action(Statistics)
                {
                    ApplicationArea = all;
                    Caption = 'Statistics';
                    ToolTip = 'Specifies the Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purchase Invoice Statistics";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = all;
                    Caption = 'Co&mments';
                    ToolTip = 'Specifies the Comments';
                    Image = ViewComments;
                    RunObject = page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = const("Posted Invoice"),
                                  "No." = FIELD("No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = all;
                    AccessByPermission = TableData 348 = R;
                    Caption = 'Dimensions';
                    ToolTip = 'Specifies the Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions();
                    end;
                }
                action(IncomingDoc)
                {
                    ApplicationArea = all;
                    AccessByPermission = TableData 130 = R;
                    Caption = 'Incoming Document';
                    ToolTip = 'Specifies the Incoming Document';
                    Image = Document;

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        IncomingDocument.ShowCard(Rec."No.", Rec."Posting Date");
                    end;
                }
            }
        }
        area(processing)
        {
            action("&Print")
            {
                ApplicationArea = all;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Specifies the Print';
                trigger OnAction()
                var
                    PurchInvHeader: Record "Purch. Inv. Header";
                begin
                    CurrPage.SETSELECTIONFILTER(PurchInvHeader);
                    PurchInvHeader.PrintRecords(true);
                end;
            }
            action("&Navigate")
            {
                ApplicationArea = all;
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Specifies the Navigate';
                trigger OnAction()
                begin
                    Rec.Navigate();
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    trigger OnOpenPage()
    begin
        Rec.SetSecurityFilterOnRespCenter();
    end;
}