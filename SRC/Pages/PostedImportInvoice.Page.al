namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.History;
using Microsoft.Purchases.Document;
using Microsoft.Purchases.Vendor;
using Microsoft.Finance.Currency;
using Microsoft.CRM.Outlook;
using Microsoft.Foundation.Attachment;
using System.Automation;
using Microsoft.Finance.Dimension;
using Microsoft.Purchases.Comment;
using Microsoft.EServices.EDocument;

page 72077 "LFS Posted Import Invoice"
{
    ApplicationArea = All;
    Caption = 'Posted Import Invoice';
    PageType = Document;
    SourceTable = "Purch. Inv. Header";
    DeleteAllowed = false;
    InsertAllowed = false;
    Permissions = TableData "Purch. Inv. Header" = rm;
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
                field("Buy-from Address"; REc."Buy-from Address")
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
                field("No. Printed"; Rec."No. Printed")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the No. Printed';
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
                field("Quote No."; Rec."Quote No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Quote No.';
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Order No.';
                }
                field("Pre-Assigned No."; Rec."Pre-Assigned No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Pre-Assigned No.';
                }
                field("Vendor Order No."; Rec."Vendor Order No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Vendor Order No.';
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the Vendor Invoice No.';
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
            }
            part(PurchInvLines; "LFSPostedPurch. ImpInvoiceSubf")
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
                    Editable = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the Pay-to Vendor No.';
                }
                field("Pay-to Contact No."; Rec."Pay-to Contact No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Pay-to Contact No.';
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Pay-to Name"';
                }
                field("Pay-to Address"; REc."Pay-to Address")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Pay-to Address';
                }
                field("Pay-to Address 2"; Rec."Pay-to Address 2")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Pay-to Address 2';
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Pay-to Post Code';
                }
                field("Pay-to City"; Rec."Pay-to City")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Pay-to City';
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Pay-to Contact';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Shortcut Dimension 1 Code';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Shortcut Dimension 2 Code';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the Payment Terms Code';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the Due Date';
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Payment Discount %';
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Pmt. Discount Date"';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Payment Method Code';
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Payment Reference';
                }
                field("Creditor No."; Rec."Creditor No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Creditor No.';
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Ship-to Name';
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Ship-to Address';
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Ship-to Address 2';
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Ship-to Post Code';
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Ship-to City';
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Ship-to Contact';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the Location Code';
                }
                field("Bill to-Location(POS)"; Rec."Bill to-Location(POS)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Bill to-Location(POS';
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Shipment Method Code';
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the Expected Receipt Date';
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
            }
            group(EXIM)
            {
                Caption = 'EXIM';
                Editable = false;
                field("EXIM Type"; Rec."LFS EXIM Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the EXIM Type';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    ToolTip = 'Specifies the Currency Code';
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
                field("Nature of Supply"; Rec."Nature of Supply")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Nature of Supply';
                }
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
            group("&Invoice")
            {
                Caption = '&Invoice';
                Image = Invoice;
                action(Statistics)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statistics';
                    Image = Statistics;
                    RunObject = Page "Purchase Invoice Statistics";
                    RunPageLink = "No." = field("No.");
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';
                }
                action("Co&mments")
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = const("Posted Invoice"),
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
            action(Print)
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';
                Visible = NOT IsOfficeAddin;

                trigger OnAction()
                begin
                    PurchInvHeader := Rec;
                    CurrPage.SetSelectionFilter(PurchInvHeader);
                    PurchInvHeader.PrintRecords(true);
                end;
            }
            action(AttachAsPDF)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Attach as PDF';
                Image = PrintAttachment;
                ToolTip = 'Create a PDF file and attach it to the document.';

                trigger OnAction()
                var
                    PurchInvHeader: Record "Purch. Inv. Header";
                begin
                    PurchInvHeader := Rec;
                    PurchInvHeader.SetRecFilter();
                    Rec.PrintToDocumentAttachment(PurchInvHeader);
                end;
            }
            group(Correct)
            {
                Caption = 'Correct';
                action(CorrectInvoice)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Correct';
                    Image = Undo;
                    ToolTip = 'Reverse this posted invoice. A credit memo will be created and matched with the invoice, and the invoice will be canceled. Shipments for the invoice will be reversed. To create a new invoice with the same information, use the Copy function. When you copy an invoice, remember to post shipments for the new invoice.';
                    Visible = not Rec.Cancelled;

                    trigger OnAction()
                    var
                        CorrectPstdPurchInvYesNo: Codeunit "Correct PstdPurchInv (Yes/No)";
                    begin
                        if CorrectPstdPurchInvYesNo.CorrectInvoice(Rec) then
                            CurrPage.Close();
                    end;
                }
                action(CancelInvoice)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel';
                    Image = Cancel;
                    ToolTip = 'Create and post a purchase credit memo that reverses this posted purchase invoice. This posted purchase invoice will be canceled.';
                    Visible = not Rec.Cancelled;

                    trigger OnAction()
                    var
                        CancelPstdPurchInvYesNo: Codeunit "Cancel PstdPurchInv (Yes/No)";
                    begin
                        if CancelPstdPurchInvYesNo.CancelInvoice(Rec) then
                            CurrPage.Close();
                    end;
                }
                action(CreateCreditMemo)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create Corrective Credit Memo';
                    Image = CreateCreditMemo;
                    ToolTip = 'Create a credit memo for this posted invoice that you complete and post manually to reverse the posted invoice.';

                    trigger OnAction()
                    var
                        PurchaseHeader: Record "Purchase Header";
                        CorrectPostedPurchInvoice: Codeunit "Correct Posted Purch. Invoice";
                    begin
                        if CorrectPostedPurchInvoice.CreateCreditMemoCopyDocument(Rec, PurchaseHeader) then begin
                            PAGE.Run(PAGE::"Purchase Credit Memo", PurchaseHeader);
                            CurrPage.Close();
                        end;
                    end;
                }
                action(ShowCreditMemo)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show Canceled/Corrective Credit Memo';
                    Image = CreditMemo;
                    ToolTip = 'Open the posted purchase credit memo that was created when you canceled the posted purchase invoice. if the posted purchase invoice is the result of a canceled purchase credit memo, then the canceled purchase credit memo will open.';
                    Visible = Rec.Cancelled or Rec.Corrective;

                    trigger OnAction()
                    begin
                        Rec.ShowCanceledOrCorrCrMemo();
                    end;
                }
            }
            group("Actions")
            {
                Caption = 'Actions';
                Image = Invoice;
                action(Vendor)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor';
                    Image = Vendor;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = field("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or edit detailed information about the vendor on the purchase document.';
                }
                action(Navigate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Find entries...';
                    Image = Navigate;
                    ShortCutKey = 'Ctrl+Alt+Q';
                    ToolTip = 'Find entries and documents that exist for the document number and posting date on the selected document. (Formerly this action was named Navigate.)';
                    Visible = NOT IsOfficeAddin;

                    trigger OnAction()
                    begin
                        Rec.Navigate();
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
            action("&Navigate")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Find entries...';
                Image = Navigate;
                ShortCutKey = 'Ctrl+Alt+Q';
                ToolTip = 'Find entries and documents that exist for the document number and posting date on the selected document. (Formerly this action was named Navigate.)';
                Visible = false;

                trigger OnAction()
                begin
                    Rec.Navigate();
                end;
            }
            group(IncomingDocument)
            {
                Caption = 'Incoming Document';
                Image = Documents;
                action(IncomingDocCard)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'View Incoming Document';
                    Enabled = HasIncomingDocument;
                    Image = ViewOrder;
                    ToolTip = 'View any incoming document records and file attachments that exist for the entry or document.';

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        IncomingDocument.ShowCard(Rec."No.", Rec."Posting Date");
                    end;
                }
                action(SelectIncomingDoc)
                {
                    AccessByPermission = TableData "Incoming Document" = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Select Incoming Document';
                    Enabled = NOT HasIncomingDocument;
                    Image = SelectLineToApply;
                    ToolTip = 'Select an incoming document record and file attachment that you want to link to the entry or document.';

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        IncomingDocument.SelectIncomingDocumentForPostedDocument(Rec."No.", Rec."Posting Date", Rec.RecordId);
                    end;
                }
                action(IncomingDocAttachFile)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create Incoming Document from File';
                    Ellipsis = true;
                    Enabled = NOT HasIncomingDocument;
                    Image = Attach;
                    ToolTip = 'Create an incoming document record by selecting a file to attach, and then link the incoming document record to the entry or document.';

                    trigger OnAction()
                    var
                        IncomingDocumentAttachment: Record "Incoming Document Attachment";
                    begin
                        IncomingDocumentAttachment.NewAttachmentFromPostedDocument(Rec."No.", Rec."Posting Date");
                    end;
                }
            }
            action("Update Document")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Update Document';
                Image = Edit;
                ToolTip = 'Add new information that is relevant to the document, such as a payment reference. You can only edit a few fields because the document has already been posted.';

                trigger OnAction()
                var
                    PostedPurchInvoiceUpdate: Page "Posted Purch. Invoice - Update";
                begin
                    PostedPurchInvoiceUpdate.LookupMode := true;
                    PostedPurchInvoiceUpdate.SetRec(Rec);
                    PostedPurchInvoiceUpdate.RunModal();
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

                actionref("Update Document_Promoted"; "Update Document")
                {
                }
                actionref(Navigate_Promoted; Navigate)
                {
                }
                group(Category_Category4)
                {
                    Caption = 'Correct', Comment = 'Generated from the PromotedActionCategories property index 3.';
                    ShowAs = SplitButton;

                    actionref(CorrectInvoice_Promoted; CorrectInvoice)
                    {
                    }
                    actionref(CancelInvoice_Promoted; CancelInvoice)
                    {
                    }
                    actionref(CreateCreditMemo_Promoted; CreateCreditMemo)
                    {
                    }
                    actionref(ShowCreditMemo_Promoted; ShowCreditMemo)
                    {
                    }
                }
            }
            group(Category_Category6)
            {
                Caption = 'Print/Send', Comment = 'Generated from the PromotedActionCategories property index 5.';

                actionref(Print_Promoted; Print)
                {
                }
                actionref(AttachAsPDF_Promoted; AttachAsPDF)
                {
                }
            }
            group(Category_Category5)
            {
                Caption = 'Invoice', Comment = 'Generated from the PromotedActionCategories property index 4.';

                actionref(Dimensions_Promoted; Dimensions)
                {
                }
                actionref(Statistics_Promoted; Statistics)
                {
                }
                actionref(DocAttach_Promoted; DocAttach)
                {
                }
                actionref(Approvals_Promoted; Approvals)
                {
                }
                actionref("&Navigate_Promoted"; "&Navigate")
                {
                    Visible = false;
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Action is being demoted based on overall low usage.';
                    ObsoleteTag = '21.0';
                }
                actionref("Co&mments_Promoted"; "Co&mments")
                {
                }

                separator(Navigate_Separator)
                {
                }

                actionref(Vendor_Promoted; Vendor)
                {
                }
            }
            group("Category_Incoming Document")
            {
                Caption = 'Incoming Document';

                actionref(IncomingDocAttachFile_Promoted; IncomingDocAttachFile)
                {
                }
                actionref(IncomingDocCard_Promoted; IncomingDocCard)
                {
                }
                actionref(SelectIncomingDoc_Promoted; SelectIncomingDoc)
                {
                }
            }
            group(Category_Category7)
            {
                Caption = 'Navigate', Comment = 'Generated from the PromotedActionCategories property index 6.';
            }
            group(Category_Report)
            {
                Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        IncomingDocuments: Record "Incoming Document";
    begin
        HasIncomingDocument := IncomingDocuments.PostedDocExists(Rec."No.", Rec."Posting Date");
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    trigger OnOpenPage()
    var
        OfficeMgt: Codeunit "Office Management";
    begin
        Rec.SetSecurityFilterOnRespCenter();
        if GuiAllowed() then
            IsOfficeAddin := OfficeMgt.IsAvailable();

    end;

    var
        PurchInvHeader: Record "Purch. Inv. Header";
        ChangeExchangeRate: Page "Change Exchange Rate";
        HasIncomingDocument: Boolean;
        IsOfficeAddin: Boolean;
}