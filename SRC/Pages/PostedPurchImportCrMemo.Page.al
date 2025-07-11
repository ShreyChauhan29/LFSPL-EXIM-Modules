namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.History;
using Microsoft.Purchases.Comment;
using Microsoft.Finance.Dimension;
using Microsoft.EServices.EDocument;
using Microsoft.Finance.Currency;

page 72083 "LFS Posted Purch.ImportCr.Memo"
{
    ApplicationArea = All;
    Caption = 'Posted Purch.ImportCr.Memo';
    PageType = Document;
    SourceTable = "Purch. Cr. Memo Hdr.";
    DeleteAllowed = false;
    InsertAllowed = false;
    RefreshOnActivate = true;
    SourceTableView = where("LFS EXIM Type" = FILTER(Import));
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the No.';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the Buy-from Vendor No.';
                }
                field("Buy-from Contact No."; Rec."Buy-from Contact No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Buy-from Contact No.';
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Buy-from Vendor Name';
                }
                field("Buy-from Address"; Rec."Buy-from Address")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Buy-from Address';
                }
                field("Buy-from Address 2"; Rec."Buy-from Address 2")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Buy-from Address 2';
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Buy-from Post Code';
                }
                field("Buy-from City"; Rec."Buy-from City")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Buy-from City';
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Buy-from Contact';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the Posting Date';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Document Date';
                }
                field("Pre-Assigned No."; Rec."Pre-Assigned No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Pre-Assigned No.';
                }
                field("Vendor Cr. Memo No."; Rec."Vendor Cr. Memo No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the Vendor Cr. Memo No.';
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Order Address Code';
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Purchaser Code';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Responsibility Center';
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the No. Printed';
                }
            }
            part(PurchCrMemoLines; "Posted Purch. Cr. Memo Subform")
            {
                ApplicationArea = all;
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Pay-to Vendor No.';
                    Editable = false;
                    Importance = Promoted;
                }
                field("Pay-to Contact No."; Rec."Pay-to Contact No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Pay-to Contact No.';
                    Editable = false;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Pay-to Name';
                    Editable = false;
                }
                field("Pay-to Address"; Rec."Pay-to Address")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Pay-to Address';
                    Editable = false;
                }
                field("Pay-to Address 2"; Rec."Pay-to Address 2")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Pay-to Address 2';
                    Editable = false;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Pay-to Post Code';
                    Editable = false;
                }
                field("Pay-to City"; Rec."Pay-to City")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Pay-to City';
                    Editable = false;
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Pay-to Contact';
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Shortcut Dimension 1 Code';
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Shortcut Dimension 2 Code';
                    Editable = false;
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Applies-to Doc. Type';
                    Editable = false;
                    Importance = Promoted;
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Applies-to Doc. No.';
                    Editable = false;
                    Importance = Promoted;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Ship-to Name';
                    Editable = false;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Ship-to Address';
                    Editable = false;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Ship-to Address 2';
                    Editable = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Ship-to Post Code';
                    Editable = false;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Ship-to City';
                    Editable = false;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Ship-to Contact';
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Location Code';
                    Editable = false;
                    Importance = Promoted;
                }
                field("E-Way Bill No."; Rec."E-Way Bill No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the E-Way Bill No.';
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Vehicle No.';
                }
                field("Bill to-Location(POS)"; Rec."Bill to-Location(POS)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Bill to-Location(POS)';
                }
            }
            group(EXIM)
            {
                Caption = 'EXIM';
                field("EXIM Type"; Rec."LFS EXIM Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the EXIM Type';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Currency Code';
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date");
                        ChangeExchangeRate.EDITABLE(FALSE);
                        if ChangeExchangeRate.RUNMODAL() = ACTION::OK then begin
                            Rec."Currency Factor" := ChangeExchangeRate.GetParameter();
                            Rec.MODIFY();
                        end;
                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("Custom Currency Code"; Rec."LFS Custom Currency Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Custom Currency Code';
                }
                field("Port of Loading"; Rec."LFS Port of Loading")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Port of Loading';
                }
                field("Port of Discharge"; Rec."LFS Port of Discharge")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Port of Discharge';
                }
                field("Country of Final Destination"; Rec."LFS Country of Final Dest.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Country of Final Destination';
                }
                field("Final Destination"; Rec."LFS Final Destination")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Final Destination';
                }
                field("Country of Origin of Goods"; Rec."LFS Country Origin Goods")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Country of Origin of Goods';
                }
                field("Inco Terms"; Rec."LFS Inco Terms")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Inco Terms';
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Transport Method';
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
                field("Bill of Entry Value"; Rec."Bill of Entry Value")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Bill of Entry Value';
                }
            }
            group("Tax Information")
            {
                Caption = 'Tax Information';
                field("GST Vendor Type"; Rec."GST Vendor Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the GST Vendor Type';
                }
                field("Invoice Type"; Rec."Invoice Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Invoice Type';
                }
                field("Associated Enterprises"; Rec."Associated Enterprises")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Associated Enterprises';
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
                    Caption = 'Statistics';
                    ToolTip = 'Specifies the Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purch. Credit Memo Statistics";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'F7';
                    ApplicationArea = all;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    ToolTip = 'Specifies the Comments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = const("Posted Credit Memo"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = const(0);
                    ApplicationArea = all;
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions';
                    ToolTip = 'Specifies the Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = all;
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
                Caption = '&Print';
                ToolTip = 'Specifies the Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(PurchCrMemoHeader);
                    PurchCrMemoHeader.PrintRecords(true);
                end;
            }
            action("&Navigate")
            {
                Caption = '&Navigate';
                ToolTip = 'Specifies the Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    REc.Navigate();
                end;
            }
            group(IncomingDocument)
            {
                Caption = 'Incoming Document';
                Image = Documents;

                action(IncomingDocCard)
                {
                    Caption = 'View Incoming Document';
                    ToolTip = 'Specifies the View Incoming Document';
                    Enabled = HasIncomingDocument;
                    Image = ViewOrder;
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        IncomingDocument.ShowCard(Rec."No.", Rec."Posting Date");
                    end;
                }
                // action(SelectIncomingDoc)
                // {
                //     AccessByPermission = TableData 130 = R;
                //     Caption = 'Select Incoming Document';
                //     Enabled = NOT HasIncomingDocument;
                //     Image = SelectLineToApply;
                //     ApplicationArea = all;
                //     trigger OnAction()
                //     var
                //         IncomingDocument: Record "Incoming Document";
                //     begin
                //     end;
                // }
                action(IncomingDocAttachFile)
                {
                    Caption = 'Create Incoming Document from File';
                    Ellipsis = true;
                    Enabled = NOT HasIncomingDocument;
                    ToolTip = 'Specifies the Create Incoming Document from File';
                    Image = Attach;
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        IncomingDocumentAttachment: Record "Incoming Document Attachment";
                    begin
                        IncomingDocumentAttachment.NewAttachmentFromPostedDocument(Rec."No.", Rec."Posting Date");
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        IncomingDocument1: Record "Incoming Document";
    begin
        HasIncomingDocument := IncomingDocument1.PostedDocExists(Rec."No.", Rec."Posting Date");
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    trigger OnOpenPage()
    begin
        Rec.SetSecurityFilterOnRespCenter();
    end;

    var
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        ChangeExchangeRate: Page "Change Exchange Rate";
        HasIncomingDocument: Boolean;
}