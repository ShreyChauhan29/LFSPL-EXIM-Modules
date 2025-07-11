namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.Document;
using System.Automation;
using Microsoft.Foundation.Attachment;
using Microsoft.Sales.Customer;
using Microsoft.EServices.EDocument;
using Microsoft.Finance.Dimension;
using Microsoft.Sales.Comment;
using Microsoft.Sales.Posting;
using System.Security.User;

page 72060 "LFS Export Sales Orders"
{
    ApplicationArea = All;
    Caption = 'Export Sales Orders';
    PageType = List;
    SourceTable = "Sales Header";
    UsageCategory = Lists;
    Editable = false;
    DeleteAllowed = false;
    CardPageId = "LFS Export Sales Order";
    SourceTableView = where("Document Type" = const(Order), "LFS EXIM Type" = filter(Export));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the estimate.';
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer who will receive the products and be billed by default.';
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ToolTip = 'Specifies the customer''s name.';
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies a document number that refers to the customer''s or vendor''s numbering system.';
                    ApplicationArea = All;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Sell-to Post Code';
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Sell-to Country/Region Code';
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Sell-to Contact';
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Bill-to Customer No.';
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Bill-to Name';
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Bill-to Post Code';
                }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Bill-to Country/Region Code';
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Bill-to Contact';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Posting Date';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Shortcut Dimension 1 Code';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Shortcut Dimension 2 Code';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Location Code';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Salesperson Code';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Currency Code';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Document Date';
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Requested Delivery Date';
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Campaign No.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Status';
                }
                field("Commission Agent"; Rec."LFS Commission Agent")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Commission Agent';
                }
                field("Comm. Amount"; Rec."LFS Comm. Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Comm. Amount';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Payment Terms Code';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Due Date';
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Shipment Method Code';
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Shipping Agent Code';
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Shipment Date';
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Shipping Advice';
                }
                field("Completely Shipped"; Rec."Completely Shipped")
                {
                    ToolTip = 'Specifies whether all the items on the order have been shipped or, in the case of inbound items, completely received.';
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            part("Attached Documents List"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Documents';
                UpdatePropagation = Both;
                SubPageLink = "Table ID" = const(Database::"Sales Header"),
                              "No." = field("No.");
            }
            part("Customer Statistics FactBox"; "Customer Statistics FactBox")
            {
                Visible = true;
                SubPageLink = "No." = field("Bill-to Customer No."), "Date Filter" = field("Date Filter");
            }
            part("Customer Details FactBox"; "Customer Details FactBox")
            {
                Visible = true;
                SubPageLink = "No." = field("Bill-to Customer No."), "Date Filter" = field("Date Filter");
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                Visible = false;
                ShowFilter = false;
            }
            systempart(Notes; Notes)
            {
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
                Image = Order;
                Caption = 'O&rder';
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    AccessByPermission = Tabledata Dimension = R;
                    Image = Dimensions;
                    ToolTip = 'Dimensions';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        rec.ShowDocDim();
                    end;
                }
                // action(Statistics)
                // {
                //     Caption = 'Statistics';
                //     ToolTip = 'Specifies the Statistics';
                //     Image = Statistics;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     ApplicationArea = ALL;

                //     trigger OnAction()
                //     begin
                //         Rec.OpenSalesOrderStatistics();
                //     end;
                // }
                action(SalesOrderStatistics)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statistics';
                    Enabled = Rec."No." <> '';
                    Image = Statistics;
                    ShortCutKey = 'F7';
                    Visible = true;
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';
                    RunObject = Page "Sales Order Statistics";
                    RunPageOnRec = true;
                }
                action(Approvals)
                {
                    Caption = 'A&pprovals';
                    ToolTip = 'Specifies the Approvals';
                    Image = Approvals;
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntries.SetRecordFilters(DATABASE::"Sales Header", Rec."Document Type",
                        rec."No.");
                        ApprovalEntries.RUN();
                    end;
                }
                action(Comments)
                {
                    Caption = 'Co&mments';
                    ToolTip = 'Specifies the Comments';
                    Image = ViewComments;
                    RunObject = page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No."), "Document Line No." = const(0);
                    ApplicationArea = ALL;
                }
            }
            group(Documents)
            {
                action(Shipments)
                {
                    Caption = 'S&hipments';
                    Image = Shipment;
                    ToolTip = 'Specifies the Shipments';
                    RunObject = page "LFS Posted Export Shipments";
                    RunPageView = sorting("Order No.");
                    RunPageLink = "Order No." = field("No."), "LFS Exim Type" = filter('Export');
                    ApplicationArea = all;
                }
                action(PostedSalesInvoices)
                {
                    Caption = 'Invoices';
                    ToolTip = 'Specifies the Invoices';
                    Image = Invoice;
                    RunObject = page "LFS Posted Export Invoices";
                    RunPageView = sorting("Order No.");
                    RunPageLink = "Order No." = field("No."), "LFS Exim Type" = filter('Export');
                    ApplicationArea = all;
                }
            }
        }
        area(Navigation)
        {
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action("Release.")
                {
                    Caption = 'Re&lease';
                    ToolTip = 'Specifies the Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        Rec.TestField(Rec."LFS Port of Discharge");
                        Rec.TestField(Rec."LFS Port of Loading");
                        Rec.TestField(Rec."LFS Country of Final Dest.");
                        Rec.TestField(Rec."LFS Country Origin Goods");
                        Rec.TestField(Rec."LFS Inco Terms");

                        ReleaseSalesDoc.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    Caption = 'Re&open';
                    ToolTip = 'Specifies the Reopen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
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
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    ToolTip = 'Specifies the SendApprovalRequest';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        I: Integer;
                    begin
                        Clear(I);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Cancel Approval Request';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post)
                {
                    Caption = 'P&ost';
                    ToolTip = 'Specifies the Post';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        Rec.TESTFIELD(Status, Rec.Status::Released);
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
                    PromotedCategory = Process;
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
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Post and Email';
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
                    Promoted = true;
                    PromotedCategory = Process;
                    Ellipsis = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Post and Batch';
                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Invoices", true, true, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action(PostAndSend)
                {
                    Caption = 'Post and &Send';
                    Image = PostSendTo;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Ellipsis = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Post and Send';
                    trigger OnAction()
                    begin
                        rec.SendToPosting(CODEUNIT::"Sales-Post and Send");
                    end;
                }
                action(RemoveFromJobQueue)
                {
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Remove From Job Queue';
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
                    PromotedCategory = Process;
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
    begin
        if UserMgt.GetSalesFilter() <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Center", UserMgt.GetSalesFilter());
            Rec.FilterGroup(0);
        end;

        Rec.SetRange("Date Filter", 0D, WorkDate() - 1);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        REc."LFS EXIM Type" := Rec."LFS EXIM Type"::Export;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        REc."LFS EXIM Type" := Rec."LFS EXIM Type"::Export;
    end;

    var
        SalesPostYesNo: Codeunit "Sales-Post (Yes/No)";
        UserMgt: Codeunit "User Setup Management";
        OpenApprovalEntriesExist: Boolean;

    procedure ShowPreview()
    begin
        SalesPostYesNo.Preview(Rec);
    end;

    // local procedure SetControlVisibility()
    // var
    //     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    // begin
    //     OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    // end;
}