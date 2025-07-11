namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Purchases.History;
using Microsoft.Finance.Dimension;
using Microsoft.Purchases.Comment;
using Microsoft.EServices.EDocument;

page 72084 "LFS PostedPurch.ImportCr.Memos"
{
    ApplicationArea = All;
    Caption = 'PostedPurch.ImportCr.Memos';
    PageType = List;
    UsageCategory = History;
    CardPageID = "Posted Purchase Credit Memo";
    DeleteAllowed = false;
    Editable = false;
    SourceTable = "Purch. Cr. Memo Hdr.";
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
                        PAGE.RUNMODAL(PAGE::"Posted Purchase Credit Memo", Rec)
                    end;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Amount Including VAT';
                    trigger OnDrillDown()
                    begin
                        Rec.SETRANGE("No.");
                        PAGE.RUNMODAL(PAGE::"Posted Purchase Credit Memo", Rec)
                    end;
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Buy-from Post Code';
                }
                field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Buy-from Country/Region Code';
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Buy-from Contact';
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Pay-to Vendor No.';
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Pay-to Name';
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Pay-to Post Code';
                }
                field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Pay-to Country/Region Code';
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Pay-to Contact';
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Ship-to Code';
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Ship-to Name';
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Ship-to Post Code';
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Ship-to Country/Region Code';
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Ship-to Contact';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Posting Date';
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Purchaser Code';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Shortcut Dimension 1 Code';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Shortcut Dimension 2 Code';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    Visible = true;
                    ToolTip = 'Specifies the Location Code';
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the No. Printed';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Document Date';
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Applies-to Doc. Type';
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
            group("&Cr. Memo")
            {
                Caption = '&Cr. Memo';
                Image = CreditMemo;
                action(Statistics)
                {
                    ApplicationArea = all;
                    Caption = 'Statistics';
                    ToolTip = 'Specifies the Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purch. Credit Memo Statistics";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = all;
                    Caption = 'Co&mments';
                    ToolTip = 'Specifies the Comments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = const("Posted Credit Memo"),
                                  "No." = FIELD("No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = all;
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'Specifies the Dimensions';
                    trigger OnAction()
                    begin
                        Rec.ShowDimensions();
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
                    PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
                begin
                    CurrPage.SETSELECTIONFILTER(PurchCrMemoHdr);
                    PurchCrMemoHdr.PrintRecords(true);
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