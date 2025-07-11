namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.Document;
using Microsoft.Foundation.Reporting;
using Microsoft.Sales.Setup;
using Microsoft.Sales.Posting;
using System.Automation;
using Microsoft.Sales.Comment;
using Microsoft.EServices.EDocument;
using Microsoft.Sales.Customer;
using Microsoft.Foundation.Attachment;

page 72057 "LFS Export Sales Invoices"
{
    ApplicationArea = All;
    Caption = 'Export Sales Invoices';
    PageType = List;
    SourceTable = "Sales Header";
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "LFS Export Sales Invoice";
    PromotedActionCategories = 'New,Process,Report,Release,Posting,Invoice,Request Approval';
    SourceTableView = where("Document Type" = const(Invoice), "LFS EXIM Type" = const(Export));
    DeleteAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the estimate.';
                }

                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the customer who will receive the products and be billed by default.';
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer''s name.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a document number that refers to the customer''s or vendor''s numbering system.';
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the postal code.';
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the country/region code of the customer''s main address.';
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the contact person at the customer.';
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the customer that you send or sent the invoice or credit memo to.';
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer to whom you will send the invoice, when different from the customer that you are selling to.';
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the postal code of the billing address.';
                }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the country/region code of the customer''s billing address.';
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the contact person at the billing address';
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for another shipment address than the customer''s own address, which is entered by default.';
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name that products on the sales document will be shipped to.';
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the postal code.';
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer''s country/region.';
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the contact person at the address that products on the sales document will be shipped to.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of removal.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the location from where inventory items to the customer on the sales document are to be shipped by default.';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the salesperson who is assigned to the customer.';
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the currency that is used on the entry.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the sales invoice was created.';
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the campaign that the document is linked to.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the document is open, waiting to be approved, has been invoiced for prepayment, or has been released to the Next() stage of processing.';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the sales invoice must be paid.';
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the payment discount percentage that is granted if the customer pays on or before the date entered in the Pmt. Discount Date field. The discount percentage is specified in the Payment Terms Code field.';
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how items on the sales document are shipped to the customer.';
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when items on the document are shipped or were shipped. A shipment date is usually calculated from a requested delivery date plus lead time.';
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of a job queue entry or task that handles the posting of sales invoices.';
                }

            }
        }
        area(Factboxes)
        {
            part("Attached Documents List"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Documents';
                UpdatePropagation = Both;
                SubPageLink = "Table ID" = const(Database::"Sales Header"),
                              "No." = field("No."),
                              "Document Type" = field("Document Type");

            }
            part("Customer Statistics FactBox"; "Customer Statistics FactBox")
            {
                Visible = true;
                SubPageLink = "No." = field("Bill-to Customer No."), "Date Filter" = field("Date Filter");
                ApplicationArea = all;
            }
            part("Customer Details FactBox"; "Customer Details FactBox")
            {
                Visible = true;
                SubPageLink = "No." = field("Bill-to Customer No."), "Date Filter" = field("Date Filter");
                ApplicationArea = all;
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                Visible = false;
                ShowFilter = false;
                ApplicationArea = all;
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
        area(Processing)
        {
            group(Invoice)
            {
                Caption = '&Invoice';
                Image = Invoice;
                action(Statistics)
                {
                    ApplicationArea = All;
                    Caption = 'Statistics';
                    ToolTip = 'Specifies the Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ShortcutKey = F7;

                    trigger OnAction();
                    begin
                        Rec.CalcInvDiscForHeader();
                        COMMIT();
                        PAGE.RUNMODAL(PAGE::"Sales Statistics", Rec);
                    end;
                }
                action(Comments)
                {
                    Caption = 'Co&mments';
                    ToolTip = 'Specifies the Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No."), "Document Line No." = const(0);
                    ApplicationArea = all;
                }
                action(Dimension)
                {
                    Caption = 'Dimensions';
                    ToolTip = 'Specifies the Dimension';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin

                        rec.ShowDocDim();
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'Specifies the Approvals';
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntries.SetRecordFilters(DATABASE::"Sales Header", Rec."Document Type", Rec."No.");
                        ApprovalEntries.RUN();
                    end;
                }
            }
        }
        area(Navigation)
        {
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action("Releases")
                {
                    Caption = 'Re&lease';
                    ToolTip = 'Specifies the Releases';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        Rec.TESTFIELD("LFS Port of Discharge");
                        Rec.TESTFIELD("LFS Port of Loading");
                        Rec.TESTFIELD("LFS Country of Final Dest.");
                        Rec.TESTFIELD("LFS Country Origin Goods");
                        Rec.TESTFIELD("LFS Inco Terms");

                        ReleaseSalesDoc.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    Caption = 'Re&open';
                    ToolTip = 'Specifies the Reopen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = Action;
                action(SendApprovalRequest)
                {
                    ApplicationArea = ALL;
                    Enabled = NOT OpenApprovalEntriesExist;
                    ToolTip = 'Specifies the SendApprovalRequest';
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;

                    trigger OnAction()
                    var
                        // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        myInteger: Integer;
                    begin
                        Clear(myInteger);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Enabled = OpenApprovalEntriesExist;
                    Caption = 'Cancel Approval Re&quest';
                    ToolTip = 'Specifies the CancelApprovalRequest';
                    Image = Cancel;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                    end;
                }
            }
            group(Posting)
            {
                Caption = 'P&osting';
                Image = Post;
                action(TestReport)
                {
                    Caption = 'Test Report';
                    Image = TestReport;
                    ToolTip = 'Specifies the Test Report';
                    Ellipsis = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action(Post)
                {
                    Caption = 'P&ost';
                    Image = PostOrder;
                    ToolTip = 'Specifies the Post';
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ShortcutKey = F9;
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        Rec.TESTFIELD("LFS Port of Discharge");
                        Rec.TESTFIELD("LFS Port of Loading");
                        Rec.TESTFIELD("LFS Country of Final Dest.");
                        Rec.TESTFIELD("LFS Country Origin Goods");
                        Rec.TESTFIELD("LFS Inco Terms");
                        MESSAGE('Custom Exchange Rate is %1 and RBI Rate is %2', ROUND(1 / Rec."LFS Custom Currency Factor"), ROUND(1 / Rec."Currency Factor"));
                        Rec.SendToPosting(CODEUNIT::"Sales-Post (Yes/No)");

                    end;
                }
                action("Post and Print")
                {
                    Image = PostPrint;
                    ToolTip = 'Specifies the Post and Print';
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        Rec.SendToPosting(CODEUNIT::"Sales-Post + Print");
                    end;
                }
                action("Post and Email")
                {
                    Image = PostMail;
                    ToolTip = 'Specifies the Post and Email';
                    Promoted = true;
                    PromotedCategory = Category5;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        SalesPostPrint: Codeunit "Sales-Post + Print";
                    begin
                        SalesPostPrint.PostAndEmail(Rec);
                    end;
                }
                action("Post and Batch")
                {
                    Image = PostBatch;
                    ToolTip = 'Specifies the Post and Batch';
                    Promoted = true;
                    PromotedCategory = Category5;
                    Ellipsis = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Invoices", true, true, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action(PostAndSend)
                {
                    Caption = 'Post and &Send';
                    ToolTip = 'Specifies the PostAndSend';
                    Image = PostSendTo;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Ellipsis = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        rec.SendToPosting(CODEUNIT::"Sales-Post and Send");
                    end;
                }
                action(RemoveFromJobQueue)
                {
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    ToolTip = 'Specifies the RemoveFromJobQueue';
                    Promoted = true;
                    PromotedCategory = Category5;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        Rec.CancelBackgroundPosting();
                    end;
                }
                action(Preview)
                {
                    Caption = 'Preview Posting';
                    ToolTip = 'Specifies the Preview';
                    Image = ViewPostedOrder;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Ellipsis = true;
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        ShowPreview();
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        Clear(JobQueueActive);
        Rec.SetSecurityFilterOnRespCenter();
        JobQueueActive := SalesSetup.JobQueueActive();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance();
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    var
        ReportPrint: Codeunit "Test Report-Print";
        JobQueueActive: Boolean;
        OpenApprovalEntriesExist: Boolean;

    procedure ShowPreview()
    var
        SalesPostYesNo: Codeunit "Sales-Post (Yes/No)";
    begin
        SalesPostYesNo.Preview(Rec);
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;
}