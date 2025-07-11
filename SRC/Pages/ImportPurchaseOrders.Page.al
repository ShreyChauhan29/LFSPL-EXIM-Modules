namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.Document;
using System.Security.AccessControl;
using Microsoft.Foundation.Reporting;
using Microsoft.EServices.EDocument;
using Microsoft.Purchases.Vendor;
using Microsoft.Finance.Dimension;
using Microsoft.Purchases.Comment;
using Microsoft.Purchases.Posting;
using Microsoft.Purchases.Setup;
using System.Automation;

page 72068 "LFS Import Purchase Orders"
{
    ApplicationArea = All;
    Caption = 'Import Purchase Orders';
    PageType = List;
    SourceTable = "Purchase Header";
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "LFS Import Purchase Order";
    SourceTableView = where("Document Type" = const(Order), Subcontracting = const(false), "LFS EXIM Type" = const(Import));
    DeleteAllowed = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the subcontracting order number.';
                    ApplicationArea = All;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ToolTip = 'Specifies the subcontracting vendor number the order belongs to.';
                    ApplicationArea = All;
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ToolTip = 'Specifies the vendor order address, if any.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ToolTip = 'Specifies the vendor name.';
                    ApplicationArea = All;
                }
                field("Vendor Authorization No."; Rec."Vendor Authorization No.")
                {
                    ToolTip = 'Specifies the authorization number given by the vendor, if any.';
                    ApplicationArea = All;
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    ToolTip = 'Specifies the post code of the vendor.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region code of the vendor.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ToolTip = 'Specifies the contact of the vendor.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ToolTip = 'Specifies the pay to vendor code used in the document.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ToolTip = 'Specifies the name of the pay to vendor.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    ToolTip = 'Specifies the post code of the pay to vendor.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region code of the pay to vendor.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ToolTip = 'Specifies the contact of the pay to vendor.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies the ship to code used for the document.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTip = 'Specifies the ship to name used for the document.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ToolTip = 'Specifies the ship to post code used for the document.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region code of the ship to code.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ToolTip = 'Specifies the ship to contact used for the document.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the posting date of the entry.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Secifies the shortcut dimension 1 code.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the Shortcut Dimension 2 Code.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location code used in the document.';
                    ApplicationArea = All;
                    Visible = true;
                }
                field(SystemCreatedBy; GetNameFromSystemId(Rec.SystemCreatedBy))
                {
                    ToolTip = 'Specifies the user who has created';
                    ApplicationArea = all;
                    Caption = 'Created By';
                    Editable = false;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the user created Date and Time';
                    ApplicationArea = all;
                    Caption = 'Created At';
                    Editable = false;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ToolTip = 'Specifies the assigned purchaser from the organization.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the foreign currency code used in the document.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the document date of the document.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the status of the document.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies the payment term used in the document.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies the due date of the order as per payment terms.';
                    ApplicationArea = All;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ToolTip = 'Specifies the discount on payment, if any.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ToolTip = 'Specifies the date by which delivery of finished good requested by company.';
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
        area(FactBoxes)
        {
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = all;
                Visible = false;
                ShowFilter = false;
            }
            part("Vendor Details FactBox"; "Vendor Details FactBox")
            {
                ApplicationArea = all;
                Visible = true;
                SubPageLink = "No." = field("Buy-from Vendor No."), "Date Filter" = field("Date Filter");
            }
            systempart(Links; Links)
            {
                ApplicationArea = all;
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group(Order)
            {
                Caption = 'O&rder';
                Image = Order;

                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    ToolTip = 'Specifies the Dimensions';
                    AccessByPermission = TableData Dimension = R;
                    Image = Dimensions;
                    Promoted = true;
                    PromotedIsBig = false;
                    ShortcutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim();
                    end;
                }
                // action(Statistics)
                // {
                //     ApplicationArea = All;
                //     Caption = 'Statistics';
                //     ToolTip = 'Specifies the Statistics';
                //     Image = Statistics;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     PromotedIsBig = true;
                //     ShortcutKey = 'F7';

                //     trigger OnAction()
                //     begin
                //         Rec.OpenPurchaseOrderStatistics();
                //     end;
                // }
                action(PurchaseStatistics)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statistics';
                    Enabled = Rec."No." <> '';
                    Image = Statistics;
                    ShortCutKey = 'F7';
                    Visible = true;
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';
                    RunObject = Page "Purchase Statistics";
                    RunPageOnRec = true;
                }
                action(Comments)
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    ToolTip = 'Specifies the Comments';
                    Image = ViewComments;
                    RunObject = page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No."), "Document Line No." = const(0);
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Document;
                action(Receipts)
                {
                    ApplicationArea = All;
                    Caption = 'Receipts';
                    ToolTip = 'Specifies the Receipts';
                    Image = PostedReceipt;
                    Promoted = true;
                    PromotedIsBig = false;
                    RunObject = page "LFS Posted ImportPurchReceipts";
                    RunPageView = sorting("Order No.");
                    RunPageLink = "Order No." = field("No."), "LFS EXIM Type" = filter('Import');
                }
                action(PostedPurchaseInvoices)
                {
                    ApplicationArea = All;
                    Caption = 'Invoices';
                    ToolTip = 'Specifies the Invoices';
                    Image = Invoice;
                    Promoted = true;
                    PromotedIsBig = false;
                    PromotedOnly = true;
                    RunObject = page "LFS Posted Import Invoices";
                    RunPageView = sorting("Order No.");
                    RunPageLink = "Order No." = field("No."), "LFS EXIM Type" = filter('Import');
                }
            }
        }
        area(Navigation)
        {
            group(Generals)
            {
                Caption = 'General';
                Image = Print;

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
                    begin
                        DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Releases)
                {
                    ApplicationArea = All;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortcutKey = 'Ctrl+F9';
                    ToolTip = 'Specifies the Releases';
                    trigger OnAction()
                    var
                        I: Integer;
                    begin
                        Clear(I);
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = All;
                    Caption = 'Re&open';
                    ToolTip = 'Specifies the Reopen';
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
            }
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = All;
                    Caption = 'Send A&pproval Request';
                    Enabled = not OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    ToolTip = 'Specifies the Send Approval Request';
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    ToolTip = 'Specifies the Cancel Approval Request';
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                    end;
                }
            }
            group(Posting)
            {
                Caption = 'P&osting';
                Image = Post;
                action(TestReport)
                {
                    ApplicationArea = All;
                    Caption = 'Test Report';
                    Image = TestReport;
                    Visible = false;
                    Ellipsis = true;
                    ToolTip = 'Specifies the Test Report';
                    trigger OnAction()
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action(Post)
                {
                    ApplicationArea = All;
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Ellipsis = true;
                    ShortcutKey = 'F9';
                    ToolTip = 'Specifies the Post';
                    trigger OnAction()
                    begin
                        Rec.TESTFIELD(Status, Rec.Status::Released);
                        Rec.SendToPosting(CODEUNIT::"Purch.-Post (Yes/No)");
                    end;
                }
                action(Preview)
                {
                    ApplicationArea = All;
                    Caption = 'Preview Posting';
                    Visible = true;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Ellipsis = true;
                    Image = ViewPostedOrder;
                    ToolTip = 'Specifies the Preview Posting';
                    trigger OnAction()
                    var
                        PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
                    begin
                        PurchPostYesNo.Preview(Rec);
                    end;
                }
                action(PostAndPrint)
                {
                    ApplicationArea = All;
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Ellipsis = true;
                    ShortcutKey = 'Shift+F9';
                    ToolTip = 'Specifies the Post and Print';
                    trigger OnAction()
                    begin
                        Rec.SendToPosting(CODEUNIT::"Purch.-Post + Print");
                    end;
                }
                action(PostBatch)
                {
                    ApplicationArea = All;
                    Caption = 'Post &Batch';
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;
                    Ellipsis = true;
                    ToolTip = 'Specifies the Post Batch';
                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Purchase Orders", true, true, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action(RemoveFromJobQueue)
                {
                    ApplicationArea = All;
                    Caption = 'Remove From Job Queue';
                    Visible = JobQueueActive;
                    Image = RemoveLine;
                    ToolTip = 'Specifies the sRemove From Job Queue';
                    trigger OnAction()
                    begin
                        Rec.CancelBackgroundPosting();
                    end;
                }
                // action("Import Purchase Order")
                // {
                //     Caption = 'Import Purchase Order';
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     PromotedIsBig = true;
                //     ApplicationArea = ALL;
                //     Image = Report;
                //     ToolTip = 'Specifies the Import Purchase Order';
                //     trigger OnAction()
                //     var
                //         PurchaseHdr: Record "Purchase Header";
                //         ImportPurchOrder: Report "Import Purchase Order";
                //     begin
                //         Clear(ImportPurchOrder);
                //         PurchaseHdr.SetCurrentkey("No.");
                //         PurchaseHdr.SetRange("No.", Rec."No.");
                //         if PurchaseHdr.FindFirst() then begin
                //             ImportPurchOrder.SetTableview(PurchaseHdr);
                //             ImportPurchOrder.RunModal();
                //         end;
                //     end;
                // }
            }
        }
    }

    trigger OnOpenPage()
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        Rec.SetSecurityFilterOnRespCenter();

        JobQueueActive := PurchasesPayablesSetup.JobQueueActive()
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance();
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    var
        DocPrint: Codeunit "Document-Print";
        ReportPrint: Codeunit "Test Report-Print";
        JobQueueActive: Boolean;
        OpenApprovalEntriesExist: Boolean;

    procedure GetNameFromSystemId(SystemId: Guid): Code[50]
    var
        User: Record User;
    begin
        if User.Get(SystemId) then
            exit(User."User Name");
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
    end;
}