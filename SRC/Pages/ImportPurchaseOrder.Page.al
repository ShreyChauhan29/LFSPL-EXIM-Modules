namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.Document;
using System.Automation;
using Microsoft.Warehouse.Request;
using Microsoft.Intercompany;
using Microsoft.Purchases.Setup;
using Microsoft.Finance.Currency;
using Microsoft.Utilities;
using System.Security.User;
using Microsoft.Foundation.Reporting;
using Microsoft.Foundation.Enums;
using Microsoft.Purchases.Posting;
using Microsoft.Warehouse.InventoryDocument;
using Microsoft.Inventory.Tracking;
using Microsoft.Inventory;
using Microsoft.Sales.History;
using Microsoft.Warehouse.Document;
using Microsoft.Warehouse.Activity;
using Microsoft.Purchases.History;
using Microsoft.Purchases.Comment;
using Microsoft.Finance.Dimension;
using Microsoft.Foundation.Attachment;
using Microsoft.Purchases.Payables;
using Microsoft.EServices.EDocument;
using Microsoft.Purchases.Vendor;
using Microsoft.Inventory.Item;
using Microsoft.Finance.TaxEngine.TaxTypeHandler;

page 72067 "LFS Import Purchase Order"
{
    ApplicationArea = All;
    Caption = 'Import Purchase Order';
    PageType = Document;
    SourceTable = "Purchase Header";
    RefreshOnActivate = true;
    SourceTableView = where("Document Type" = FILTER(Order), Subcontracting = FILTER(false), "LFS EXIM Type" = filter(Import));
    DeleteAllowed = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the subcontracting order number.';
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEditImport(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ToolTip = 'Specifies the subcontracting vendor number the order belongs to.';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        BuyfromVendorNoOnAfterValidate();
                    end;
                }
                field("Buy-from Contact No."; Rec."Buy-from Contact No.")
                {
                    ToolTip = 'Specifies the contact number of the vendor.';
                    ApplicationArea = All;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ToolTip = 'Specifies the vendor name.';
                    ApplicationArea = All;
                }
                field("Buy-from Address"; Rec."Buy-from Address")
                {
                    ToolTip = 'Specifies the vendor address.';
                    ApplicationArea = All;
                }
                field("Buy-from Address 2"; Rec."Buy-from Address 2")
                {
                    ToolTip = 'Specifies the additional address of vendor.';
                    ApplicationArea = All;
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    ToolTip = 'Specifies the post code of the vendor.';
                    ApplicationArea = All;
                }
                field("Buy-from City"; Rec."Buy-from City")
                {
                    ToolTip = 'Specifies the city of the vendor.';
                    ApplicationArea = All;
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ToolTip = 'Specifies the contact of the vendor.';
                    ApplicationArea = All;
                }
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    ToolTip = 'Specifies the total number of versions created for the order.';
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location code used in the document.';
                    ApplicationArea = All;

                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Secifies the shortcut dimension 1 code.';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV();
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the Shortcut Dimension 2 Code.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV();
                    end;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the posting date of the entry.';
                    ApplicationArea = All;
                }
                field("Vendor Order No."; Rec."Vendor Order No.")
                {
                    ToolTip = 'Specifies the vendor order number.';
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ToolTip = 'Specifies the order date of the document.';
                    ApplicationArea = All;
                }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the vendor shipment number.';
                    ApplicationArea = All;
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the vendor invoice number.';
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the document date of the document.';
                    ApplicationArea = All;
                }
                field("Quote No."; Rec."Quote No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the quote number for the purchase order.';
                    ApplicationArea = All;
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ToolTip = 'Specifies the vendor order address, if any.';
                    ApplicationArea = All;
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    Visible = false;
                    ToolTip = 'Specifies additional posting information for the document. After you post the document, the description can add detail to vendor and customer ledger entries.';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the status of the document.';
                    ApplicationArea = All;
                }
                field("Receiving No. Series"; Rec."Receiving No. Series")
                {
                    ToolTip = 'Specifies the value of the Receiving No. Series field.';
                    ApplicationArea = All;
                    Visible = false;
                }
            }
            part(ImportPurchLines; "LFS ImportPurchaseOrderSubform")
            {
                ApplicationArea = all;
                SubPageLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                UpdatePropagation = Both;
            }
            group(Invoicing)
            {
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ToolTip = 'Specifies the pay to vendor code used in the document.';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        PaytoVendorNoOnAfterValidate();
                    end;
                }
                field("Pay-to Contact No."; Rec."Pay-to Contact No.")
                {
                    ToolTip = 'Specifies the contact number of the pay to vendor.';
                    ApplicationArea = All;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ToolTip = 'Specifies the name of the pay to vendor.';
                    ApplicationArea = All;
                }
                field("Pay-to Address"; Rec."Pay-to Address")
                {
                    ToolTip = 'Specifies the address of pay to vendor.';
                    ApplicationArea = All;
                }
                field("Pay-to Address 2"; Rec."Pay-to Address 2")
                {
                    ToolTip = 'Specifies the additional address of pay to vendor.';
                    ApplicationArea = All;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    ToolTip = 'Specifies the post code of the pay to vendor.';
                    ApplicationArea = All;
                }
                field("Pay-to City"; Rec."Pay-to City")
                {
                    ToolTip = 'Specifies the city of the pay to vendor.';
                    ApplicationArea = All;
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ToolTip = 'Specifies the contact of the pay to vendor.';
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies the payment term used in the document.';
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies the due date of the order as per payment terms.';
                    ApplicationArea = All;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ToolTip = 'Specifies the method of payment.';
                    ApplicationArea = All;
                }
            }
            group(Shipping)
            {
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTip = 'Specifies the ship to name used for the document.';
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ToolTip = 'Specifies the ship to address used for the document.';
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ToolTip = 'Specifies the additional address used for the document.';
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ToolTip = 'Specifies the ship to post code used for the document.';
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ToolTip = 'Specifies the ship to contact used for the document.';
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ToolTip = 'Specifies the ship to city used for the document.';
                    ApplicationArea = All;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ToolTip = 'Specifies the date by which delivery of finished good requested by company.';
                    ApplicationArea = All;
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    ToolTip = 'Specifies the date by which delivery of finished good promised by vendor.';
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ToolTip = 'Specifies the date of expected receipt of the material.';
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the customer code.';
                    ApplicationArea = All;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies the ship to code used for the document.';
                    ApplicationArea = All;
                }
                field("Bill to-Location(POS)"; Rec."Bill to-Location(POS)")
                {
                    Visible = false;
                    ToolTip = 'Specifies the Bill to Location Code which is considered as Place of Supply.';
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ToolTip = 'Specifies the Transport Method which is considered as Place of Supply.';
                    ApplicationArea = All;

                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ToolTip = 'Specifies the Shipment Method Code which is considered as Place of Supply.';
                    ApplicationArea = All;
                }
            }
            group(EXIM)
            {
                field("EXIM Type"; Rec."LFS EXIM Type")
                {
                    ToolTip = 'Specifies the value of the EXIM Type field.';
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the foreign currency code used in the document.';
                    ApplicationArea = All;
                    // Visible = false;
                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE();
                        PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);
                        Rec."LFS Custom Currency Code" := Rec."Currency Code";
                        Rec.Validate("LFS Custom Currency Code");
                    end;

                    trigger OnAssistEdit()
                    begin
                        CLEAR(ChangeExchangeRate);
                        CLEAR(ChangeCustomExchangeRate);
                        if Rec."Posting Date" <> 0D then
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date")
                        else
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WORKDATE());
                        if ChangeExchangeRate.RUNMODAL() = ACTION::OK then begin
                            Rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter());
                            Rec.VALIDATE("LFS Custom Currency Factor", Rec."Currency Factor");
                            CurrPage.UPDATE();
                        end;
                        CLEAR(ChangeExchangeRate);
                        CLEAR(ChangeCustomExchangeRate);
                    end;
                }
                field("Custom Currency Code"; Rec."LFS Custom Currency Code")
                {
                    ToolTip = 'Specifies the value of the Custom Currency Code field.';
                    ApplicationArea = All;
                    Caption = 'Custom Currency Code';
                    Visible = false;
                    trigger OnValidate()
                    begin
                        rec."Currency Code" := Rec."LFS Custom Currency Code";
                        // Rec.Validate("Currency Code");
                    end;

                    trigger OnAssistEdit()
                    begin
                        CLEAR(ChangeCustomExchangeRate);
                        if Rec."Posting Date" <> 0D then
                            ChangeCustomExchangeRate.SetParameter(Rec."LFS Custom Currency Code", Rec."LFS Custom Currency Factor", Rec."Posting Date", Rec."LFS EXIM Type")
                        else
                            ChangeCustomExchangeRate.SetParameter(Rec."LFS Custom Currency Code", Rec."LFS Custom Currency Factor", WORKDATE(), Rec."LFS EXIM Type");
                        if ChangeCustomExchangeRate.RUNMODAL() = ACTION::OK then begin
                            Rec.VALIDATE("LFS Custom Currency Factor", ChangeCustomExchangeRate.GetParameter());
                            CurrPage.UPDATE();
                        end;
                        CLEAR(ChangeCustomExchangeRate);
                    end;
                }
                field("Port of Loading"; Rec."LFS Port of Loading")
                {
                    ToolTip = 'Specifies the value of the Port of Loading field.';
                    ApplicationArea = All;
                }
                field("Port of Discharge"; Rec."LFS Port of Discharge")
                {
                    ToolTip = 'Specifies the value of the Port of Discharge field.';
                    ApplicationArea = All;
                }
                field("Country of Final Destination"; Rec."LFS Country of Final Dest.")
                {
                    ToolTip = 'Specifies the value of the Country of Final Destination field.';
                    ApplicationArea = All;
                }
                field("Final Destination"; Rec."LFS Final Destination")
                {
                    ToolTip = 'Specifies the value of the Final Destination field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Country of Origin of Goods"; Rec."LFS Country Origin Goods")
                {
                    ToolTip = 'Specifies the value of the Country of Origin of Goods field.';
                    ApplicationArea = All;
                }
                field("Inco Terms"; Rec."LFS Inco Terms")
                {
                    ToolTip = 'Specifies the value of the Inco Terms field.';
                    ApplicationArea = All;
                }
                field("Bill of Entry No."; Rec."Bill of Entry No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the bill of entry number. It is a document number which is submitted to custom department .';
                    ApplicationArea = All;
                }
                field("Bill of Entry Date"; Rec."Bill of Entry Date")
                {
                    Visible = false;
                    ToolTip = 'Specifies the entry date defined in bill of entry document.';
                    ApplicationArea = All;
                }
                field("Bill of Entry Value"; Rec."Bill of Entry Value")
                {
                    Visible = false;
                    ToolTip = 'Specifies the values as mentioned in bill of entry document.';
                    ApplicationArea = All;
                }
            }
            group("Tax Information")
            {
                field("Location State Code"; Rec."Location State Code")
                {
                    ToolTip = 'Specifies the state code mentioned in location used in the transaction.';
                    ApplicationArea = All;
                }
                field("Location GST Reg. No."; Rec."Location GST Reg. No.")
                {
                    ToolTip = 'Specifies the GST Registration number of the Location specified on the journal line.';
                    ApplicationArea = All;
                }
                field("GST Vendor Type"; Rec."GST Vendor Type")
                {
                    ToolTip = 'Specifies the vendor type for GST transaction';
                    ApplicationArea = All;
                }
                field("Invoice Type"; Rec."Invoice Type")
                {
                    Visible = false;
                    ToolTip = 'Specifies the type of the quote created. For example, Self Invoice/Debit Note/Supplementary/Non-GST.';
                    ApplicationArea = All;
                }
                field("GST Input Service Distribution"; Rec."GST Input Service Distribution")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the GST Input Service Distribution field.';
                    ApplicationArea = All;
                }
                field("Associated Enterprises"; Rec."Associated Enterprises")
                {
                    Visible = false;
                    ToolTip = 'Specifies that an import transaction of services from companys Associates Vendor';
                    ApplicationArea = All;
                }
                field("GST Order Address State"; Rec."GST Order Address State")
                {
                    Visible = false;
                    ToolTip = 'Specifies the state code of the mentioned order address in the transaction.';
                    ApplicationArea = All;
                }
                field("Order Address GST Reg. No."; Rec."Order Address GST Reg. No.")
                {
                    ToolTip = 'Specifies the GST registration number of the mentioned order address in the transaction.';
                    ApplicationArea = All;
                }
                field("Vendor GST Reg. No."; Rec."Vendor GST Reg. No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the GST registration number of the Vendor specified on the journal line.';
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            part(TaxInformation; "Tax Information Factbox")
            {
                Provider = ImportPurchLines;
#pragma warning disable AL0603
                SubPageLink = "Table ID Filter" = const(39), "Document Type Filter" = field("Document Type"), "Document No. Filter" = field("Document No."), "Line No. Filter" = field("Line No.");
#pragma warning restore AL0603
                ApplicationArea = all;
            }
            part("Pending Approval FactBox"; "Pending Approval FactBox")
            {
                ApplicationArea = all;
                Visible = OpenApprovalEntriesExistForCurrUser;
                SubPageLink = "Table ID" = const(38), "Document Type" = field("Document Type"), "Document No." = field("No.");
            }
            part("Item Replenishment FactBox"; "Item Replenishment FactBox")
            {
                ApplicationArea = all;
                Visible = false;
                SubPageLink = "No." = field("No.");
            }
            part(ApprovalFactBox; "Approval FactBox")
            {
                ApplicationArea = all;
                Visible = false;
            }
            part("Vendor Details FactBox"; "Vendor Details FactBox")
            {
                ApplicationArea = all;
                Visible = false;
                SubPageLink = "No." = field("Buy-from Vendor No.");
            }
            part("Vendor Statistics FactBox"; "Vendor Statistics FactBox")
            {
                ApplicationArea = all;
                Visible = true;
                SubPageLink = "No." = field("Pay-to Vendor No.");
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = all;
                Visible = false;
                ShowFilter = false;
            }
            part("Vendor Hist. Buy-from FactBox"; "Vendor Hist. Buy-from FactBox")
            {
                ApplicationArea = all;
                Visible = true;
                SubPageLink = "No." = field("Buy-from Vendor No.");
            }
            part("Vendor Hist. Pay-to FactBox"; "Vendor Hist. Pay-to FactBox")
            {
                ApplicationArea = all;
                Visible = false;
                SubPageLink = "No." = field("Pay-to Vendor No.");
            }
            part("Purchase Line FactBox"; "Purchase Line FactBox")
            {
                ApplicationArea = all;
                Provider = ImportPurchLines;
                SubPageLink = "Document Type" = field("Document Type"), "Document No." = field("Document No."), "Line No." = field("Line No.");
            }
            part("Attached Documents"; "Doc. Attachment List Factbox")//Removing Warnings ++
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Purchase Header"),
                              "No." = field("No."),
                              "Document Type" = field("Document Type");
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Enabled = Rec."No." <> '';
                    Image = Dimensions;
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim();
                        CurrPage.SaveRecord();
                    end;
                }
                // action(Statistics)
                // {
                //     ApplicationArea = Suite;
                //     Caption = 'Statistics';
                //     Image = Statistics;
                //     ShortCutKey = 'F7';
                //     ToolTip = 'View statistical information, such as the value of posted entries, for the record.';

                //     trigger OnAction()
                //     begin
                //         Rec.OpenPurchaseOrderStatistics();
                //         CurrPage.ImportPurchLines.Page.ForceTotalsCalculation();
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
                action(Vendor)
                {
                    ApplicationArea = Suite;
                    Caption = 'Vendor';
                    Enabled = Rec."Buy-from Vendor No." <> '';
                    Image = Vendor;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = field("Buy-from Vendor No."),
                                  "Date Filter" = field("Date Filter");
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or edit detailed information about the vendor on the purchase document.';
                }
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalsPurchase(Rec);
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = field("Document Type"),
                                  "No." = field("No."),
                                  "Document Line No." = const(0);
                    ToolTip = 'View or add comments for the record.';
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
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action(Receipts)
                {
                    ApplicationArea = Suite;
                    Caption = 'Receipts';
                    Image = PostedReceipts;
                    RunObject = Page "Posted Purchase Receipt";
                    RunPageLink = "Order No." = field("No.");
                    RunPageView = sorting("Order No.");
                    ToolTip = 'View a list of posted purchase receipts for the order.';
                }
                action(Invoices)
                {
                    ApplicationArea = Suite;
                    Caption = 'Invoices';
                    Image = Invoice;
                    ToolTip = 'View a list of ongoing purchase invoices for the order.';

                    trigger OnAction()
                    var
                        TempPurchInvHeader: Record "Purch. Inv. Header" temporary;
                        PurchGetReceipt: Codeunit "Purch.-Get Receipt";
                    begin
                        PurchGetReceipt.GetPurchOrderInvoices(TempPurchInvHeader, Rec."No.");
                        Page.Run(Page::"Posted Purchase Invoices", TempPurchInvHeader);
                    end;
                }
                action(PostedPrepaymentInvoices)
                {
                    ApplicationArea = Prepayments;
                    Caption = 'Prepa&yment Invoices';
                    Image = PrepaymentInvoice;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Prepayment Order No." = field("No.");
                    RunPageView = sorting("Prepayment Order No.");
                    ToolTip = 'View related posted purchase invoices that involve a prepayment.';
                }
                action(PostedPrepaymentCrMemos)
                {
                    ApplicationArea = Prepayments;
                    Caption = 'Prepayment Credi&t Memos';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page "Posted Purchase Credit Memos";
                    RunPageLink = "Prepayment Order No." = field("No.");
                    RunPageView = sorting("Prepayment Order No.");
                    ToolTip = 'View related posted purchase credit memos that involve a prepayment.';
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("In&vt. Put-away/Pick Lines")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = const("Purchase Order"),
                                  "Source No." = field("No.");
                    RunPageView = sorting("Source Document", "Source No.", "Location Code");
                    ToolTip = 'View items that are inbound or outbound on inventory put-away or inventory pick documents for the purchase order.';
                }
                action("Whse. Receipt Lines")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Whse. Receipt Lines';
                    Image = ReceiptLines;
                    RunObject = Page "Whse. Receipt Lines";
#pragma warning disable AL0603
                    RunPageLink = "Source Type" = const(39),
                                  "Source Subtype" = field("Document Type"),
                                  "Source No." = field("No.");
#pragma warning restore AL0603,
                    RunPageView = sorting("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                    ToolTip = 'View ongoing warehouse receipts for the document, in advanced warehouse configurations.';
                }
                action("Whse. Put-away Lines")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Warehouse Put-away Lines';
                    Image = PutawayLines;
                    RunObject = page "Warehouse Activity Lines";
                    RunPageLink = "Source Document" = const("Purchase Order"), "Source No." = field("No.");
                    RunPageView = sorting("Source Type", "Source Subtype", "Source No.");
                    ToolTip = 'View items that are inbound on warehouse put-away documents for the purchase order.';
                }
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment';
                    Image = Delivery;
                    action(Warehouse_GetSalesOrder)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Get &Sales Order';
                        Image = "Order";
                        RunObject = Codeunit "Purch.-Get Drop Shpt.";
                        ToolTip = 'Select the sales order that must be linked to the purchase order, for drop shipment or special order. ';
                    }
                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order';
                    Image = SpecialOrder;
                    action("Get &Sales Order")
                    {
                        AccessByPermission = TableData "Sales Shipment Header" = R;
                        ApplicationArea = Suite;
                        Caption = 'Get &Sales Order';
                        Image = "Order";
                        ToolTip = 'Select the sales order that must be linked to the purchase order, for drop shipment or special order. ';

                        trigger OnAction()
                        var
                            PurchHeader: Record "Purchase Header";
                            DistIntegration: Codeunit "Dist. Integration";
                        begin
                            PurchHeader.Copy(Rec);
                            DistIntegration.GetSpecialOrders(PurchHeader);
                            Rec := PurchHeader;
                        end;
                    }
                }
            }
        }
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    ToolTip = 'Reject the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    ToolTip = 'Delegate the requested changes to the substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
            group(Action13)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Release the document to the Next() stage of processing. You must reopen the document before you can make changes to it.';

                    trigger OnAction()
                    begin
                        // QualityVendorSampleValidation(Rec);
                        DimensionCodeValidation();
                        PerformManualRelease();
                        CurrPage.ImportPurchLines.PAGE.ClearTotalPurchaseHeader();
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&open';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = ReOpen;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                        CurrPage.ImportPurchLines.PAGE.ClearTotalPurchaseHeader();
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(CalculateInvoiceDiscount)
                {
                    AccessByPermission = TableData "Vendor Invoice Disc." = R;
                    ApplicationArea = Suite;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;
                    ToolTip = 'Calculate the discount that can be granted based on all lines in the purchase document.';

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc();
                        PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                action(GetRecurringPurchaseLines)
                {
                    ApplicationArea = Suite;
                    Caption = 'Get Recurring Purchase Lines';
                    Ellipsis = true;
                    Image = VendorCode;
                    ToolTip = 'Insert purchase document lines that you have set up for the vendor as recurring. Recurring purchase lines could be for a monthly replenishment order or a fixed freight expense.';

                    trigger OnAction()
                    var
                        StdVendPurchCode: Record "Standard Vendor Purchase Code";
                    begin
                        StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }
                action("Create Tracking Information")
                {
                    ApplicationArea = ItemTracking;
                    Caption = 'Create Tracking Information';
                    Image = ItemTracking;
                    ToolTip = 'Create item tracking information for the entire purchase order.';

                    trigger OnAction()
                    var
                        ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
                    begin
                        ItemTrackingDocMgt.CreateTrackingInfo(DATABASE::"Purchase Header", Rec."Document Type".AsInteger(), Rec."No.");
                    end;
                }
                action(CopyDocument)
                {
                    ApplicationArea = Suite;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Enabled = Rec."No." <> '';
                    Image = CopyDocument;
                    ToolTip = 'Copy document lines and header information from another purchase document to this document. You can copy a posted purchase invoice into a new purchase invoice to quickly create a similar document.';

                    trigger OnAction()
                    begin
                        Rec.CopyDocument();
                        if Rec.Get(Rec."Document Type", Rec."No.") then;
                        CurrPage.ImportPurchLines.Page.ForceTotalsCalculation();
                        CurrPage.Update();
                    end;
                }
                action(MoveNegativeLines)
                {
                    ApplicationArea = Suite;
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Image = MoveNegativeLines;
                    ToolTip = 'Prepare to create a replacement purchase order in a purchase return process.';

                    trigger OnAction()
                    begin
                        Clear(MoveNegPurchLines);
                        MoveNegPurchLines.SetPurchHeader(Rec);
                        MoveNegPurchLines.RunModal();
                        MoveNegPurchLines.ShowDocument();
                    end;
                }
                group(Action225)
                {
                    Caption = 'Dr&op Shipment';
                    Image = Delivery;
                    action(Functions_GetSalesOrder)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Get &Sales Order';
                        Image = "Order";
                        RunObject = Codeunit "Purch.-Get Drop Shpt.";
                        ToolTip = 'Select the sales order that must be linked to the purchase order, for drop shipment or special order. ';
                    }
                }
                group(Action186)
                {
                    Caption = 'Speci&al Order';
                    Image = SpecialOrder;
                    action(Action187)
                    {
                        AccessByPermission = TableData "Sales Shipment Header" = R;
                        ApplicationArea = Suite;
                        Caption = 'Get &Sales Order';
                        Image = "Order";
                        ToolTip = 'Select the sales order that must be linked to the purchase order, for drop shipment or special order. ';

                        trigger OnAction()
                        var
                            PurchHeader: Record "Purchase Header";
                            DistIntegration: Codeunit "Dist. Integration";
                        begin
                            PurchHeader.Copy(Rec);
                            DistIntegration.GetSpecialOrders(PurchHeader);
                            Rec := PurchHeader;
                        end;
                    }
                }
                action("Archive Document")
                {
                    ApplicationArea = Suite;
                    Caption = 'Archi&ve Document';
                    Image = Archive;
                    ToolTip = 'Send the document to the archive, for example because it is too soon to delete it. Later, you delete or reprocess the archived document.';

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.Update(false);
                    end;
                }


                group(IncomingDocument)
                {
                    Caption = 'Incoming Document';
                    Image = Documents;
                    action(IncomingDocCard)
                    {
                        ApplicationArea = Suite;
                        Caption = 'View Incoming Document';
                        Enabled = HasIncomingDocument;
                        Image = ViewOrder;
                        ToolTip = 'View any incoming document records and file attachments that exist for the entry or document, for example for auditing purposes';

                        trigger OnAction()
                        var
                            IncomingDocument: Record "Incoming Document";
                        begin
                            IncomingDocument.ShowCardFromEntryNo(Rec."Incoming Document Entry No.");
                        end;
                    }
                    action(SelectIncomingDoc)
                    {
                        AccessByPermission = TableData "Incoming Document" = R;
                        ApplicationArea = Suite;
                        Caption = 'Select Incoming Document';
                        Image = SelectLineToApply;
                        ToolTip = 'Select an incoming document record and file attachment that you want to link to the entry or document.';

                        trigger OnAction()
                        var
                            IncomingDocument: Record "Incoming Document";
                        begin
                            Rec.Validate("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument(Rec."Incoming Document Entry No.", Rec.RecordId));
                        end;
                    }
                    action(IncomingDocAttachFile)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Create Incoming Document from File';
                        Ellipsis = true;
                        Enabled = (Rec."Incoming Document Entry No." = 0) and (Rec."No." <> '');
                        Image = Attach;
                        ToolTip = 'Create an incoming document from a file that you select from the disk. The file will be attached to the incoming document record.';

                        trigger OnAction()
                        var
                            IncomingDocumentAttachment: Record "Incoming Document Attachment";
                        begin
                            IncomingDocumentAttachment.NewAttachmentFromPurchaseDocument(Rec);
                        end;
                    }
                    action(RemoveIncomingDoc)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Remove Incoming Document';
                        Enabled = HasIncomingDocument;
                        Image = RemoveLine;
                        ToolTip = 'Remove any incoming document records and file attachments.';

                        trigger OnAction()
                        var
                            IncomingDocument: Record "Incoming Document";
                        begin
                            if IncomingDocument.Get(Rec."Incoming Document Entry No.") then
                                IncomingDocument.RemoveLinkToRelatedRecord();
                            Rec."Incoming Document Entry No." := 0;
                            Rec.Modify(true);
                        end;
                    }
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        // QualityVendorSampleValidation(Rec);
                        DimensionCodeValidation();

                        if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
                            ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord OR CanCancelApprovalForFlow;
                    Image = CancelApprovalRequest;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    end;
                }


            }
            group(Reports)
            {
                // action("Import Purchase Order")
                // {
                //     Caption = 'Import Purchase Order';
                //     // Promoted = true;
                //     // PromotedCategory = Process;
                //     // PromotedIsBig = true;
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
            group(Action17)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("Create &Whse. Receipt")
                {
                    AccessByPermission = TableData "Warehouse Receipt Header" = R;
                    ApplicationArea = Warehouse;
                    Caption = 'Create &Whse. Receipt';
                    Image = NewReceipt;
                    ToolTip = 'Create a warehouse receipt to start a receive and put-away process according to an advanced warehouse configuration.';

                    trigger OnAction()
                    var
                        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
                    begin
                        PerformManualRelease();
                        GetSourceDocInbound.CreateFromPurchOrder(Rec);

                        if not Rec.Find('=><') then
                            Rec.Init();
                    end;
                }
                action("Create Inventor&y Put-away/Pick")
                {
                    AccessByPermission = TableData "Posted Invt. Put-away Header" = R;
                    ApplicationArea = Warehouse;
                    Caption = 'Create Inventor&y Put-away/Pick';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;
                    ToolTip = 'Create an inventory put-away or inventory pick to handle items on the document according to a basic warehouse configuration that does not require warehouse receipt or shipment documents.';

                    trigger OnAction()
                    begin
                        PerformManualRelease();
                        Rec.CreateInvtPutAwayPick();

                        if not Rec.Find('=><') then
                            Rec.Init();
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post1)
                {
                    ApplicationArea = Suite;
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction()
                    begin
                        DimensionCodeValidation();
                        // QualityVendorSampleValidation(Rec);
                        PostDocument(CODEUNIT::"Purch.-Post (Yes/No)", Enum::"Navigate After Posting"::"Posted Document");
                    end;
                }
                action(Preview)
                {
                    ApplicationArea = Suite;
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    ShortCutKey = 'Ctrl+Alt+F9';
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                    trigger OnAction()
                    begin
                        DimensionCodeValidation();

                        ShowPreview();
                    end;
                }
                action("Post and &Print")
                {
                    ApplicationArea = Suite;
                    Caption = 'Post and &Print';
                    Ellipsis = true;
                    Image = PostPrint;
                    ShortCutKey = 'Shift+F9';
                    ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';

                    trigger OnAction()
                    begin
                        PostDocument(CODEUNIT::"Purch.-Post + Print", Enum::"Navigate After Posting"::"Do Nothing");
                    end;
                }
                action(PostAndNew)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post and New';
                    Ellipsis = true;
                    Image = PostOrder;
                    ShortCutKey = 'Alt+F9';
                    ToolTip = 'Post the purchase document and create a new, empty one.';

                    trigger OnAction()
                    begin
                        PostDocument(CODEUNIT::"Purch.-Post (Yes/No)", Enum::"Navigate After Posting"::"New Document");
                    end;
                }
                action("Test Report")
                {
                    ApplicationArea = Suite;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';

                    trigger OnAction()
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action("Post &Batch")
                {
                    ApplicationArea = Suite;
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    ToolTip = 'Post several documents at once. A report request window opens where you can specify which documents to post.';

                    trigger OnAction()
                    begin
                        REPORT.RunModal(REPORT::"Batch Post Purchase Orders", true, true, Rec);
                        CurrPage.Update(false);
                    end;
                }
                action("Remove From Job Queue")
                {
                    ApplicationArea = Suite;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    ToolTip = 'Remove the scheduled processing of this record from the job queue.';
                    Visible = JobQueueVisible;

                    trigger OnAction()
                    begin
                        Rec.CancelBackgroundPosting();
                    end;
                }
                group("Prepa&yment")
                {
                    Caption = 'Prepa&yment';
                    Image = Prepayment;
                    action("Prepayment Test &Report")
                    {
                        ApplicationArea = Prepayments;
                        Caption = 'Prepayment Test &Report';
                        Ellipsis = true;
                        Image = PrepaymentSimulation;
                        ToolTip = 'Preview the prepayment transactions that will results from posting the purchase document as invoiced.';

                        trigger OnAction()
                        begin
                            ReportPrint.PrintPurchHeaderPrepmt(Rec);
                        end;
                    }
                    action(PostPrepaymentInvoice)
                    {
                        ApplicationArea = Prepayments;
                        Caption = 'Post Prepayment &Invoice';
                        Ellipsis = true;
                        Image = PrepaymentPost;
                        ToolTip = 'Post the specified prepayment information. ';

                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
                                PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec, false);
                        end;
                    }
                    action("Post and Print Prepmt. Invoic&e")
                    {
                        ApplicationArea = Prepayments;
                        Caption = 'Post and Print Prepmt. Invoic&e';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;
                        ToolTip = 'Post the specified prepayment information and print the related report. ';

                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
                                PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec, true);
                        end;
                    }
                    action(PreviewPrepmtInvoicePosting)
                    {
                        ApplicationArea = Prepayments;
                        Caption = 'Preview Prepmt. Invoice Posting';
                        Image = ViewPostedOrder;
                        ToolTip = 'Review the different types of entries that will be created when you post the prepayment invoice.';

                        trigger OnAction()
                        begin
                            ShowPrepmtInvoicePreview();
                        end;
                    }
                    action(PostPrepaymentCreditMemo)
                    {
                        ApplicationArea = Prepayments;
                        Caption = 'Post Prepayment &Credit Memo';
                        Ellipsis = true;
                        Image = PrepaymentPost;
                        ToolTip = 'Create and post a credit memo for the specified prepayment information.';

                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
                                PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec, false);
                        end;
                    }
                    action("Post and Print Prepmt. Cr. Mem&o")
                    {
                        ApplicationArea = Prepayments;
                        Caption = 'Post and Print Prepmt. Cr. Mem&o';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;
                        ToolTip = 'Create and post a credit memo for the specified prepayment information and print the related report.';

                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
                                PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec, true);
                        end;
                    }
                    action(PreviewPrepmtCrMemoPosting)
                    {
                        ApplicationArea = Prepayments;
                        Caption = 'Preview Prepmt. Cr. Memo Posting';
                        Image = ViewPostedOrder;
                        ToolTip = 'Review the different types of entries that will be created when you post the prepayment credit memo.';

                        trigger OnAction()
                        begin
                            ShowPrepmtCrMemoPreview();
                        end;
                    }
                }
            }
            group(Print)
            {
                Caption = 'Print';
                Image = Print;
                action("&Print")
                {
                    ApplicationArea = Suite;
                    Caption = '&Print';
                    Ellipsis = true;
                    Image = Print;
                    ToolTip = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.';

                    trigger OnAction()
                    var
                        PurchaseHeader: Record "Purchase Header";
                    begin
                        PurchaseHeader := Rec;
                        CurrPage.SetSelectionFilter(PurchaseHeader);
                        PurchaseHeader.PrintRecords(true);
                    end;
                }
                action(SendCustom)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send';
                    Ellipsis = true;
                    Image = SendToMultiple;
                    ToolTip = 'Prepare to send the document according to the vendor''s sending profile, such as attached to an email. The Send document to window opens first so you can confirm or select a sending profile.';

                    trigger OnAction()
                    var
                        PurchaseHeader: Record "Purchase Header";
                    begin
                        PurchaseHeader := Rec;
                        CurrPage.SetSelectionFilter(PurchaseHeader);
                        PurchaseHeader.SendRecords();
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
                        PurchaseHeader: Record "Purchase Header";
                        DocPrint: Codeunit "Document-Print";
                    begin
                        PurchaseHeader := Rec;
                        PurchaseHeader.SetRecFilter();
                        DocPrint.PrintPurchaseHeaderToDocumentAttachment(PurchaseHeader);
                    end;
                }


            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

                group(Category_Category6)
                {
                    Caption = 'Posting', Comment = 'Generated from the PromotedActionCategories property index 5.';
                    ShowAs = SplitButton;

                    actionref(Post_Promoted; Post1)
                    {
                    }
                    actionref(Preview_Promoted; Preview)
                    {
                    }
                    actionref("Post and &Print_Promoted"; "Post and &Print")
                    {
                    }
                    actionref(PostAndNew_Promoted; PostAndNew)
                    {
                    }
                    actionref("Post &Batch_Promoted"; "Post &Batch")
                    {
                    }
                }
                group(Category_Category5)
                {
                    Caption = 'Release', Comment = 'Generated from the PromotedActionCategories property index 4.';
                    ShowAs = SplitButton;

                    actionref(Release_Promoted; Release)
                    {
                    }
                    actionref(Reopen_Promoted; Reopen)
                    {
                    }
                }
                actionref("Create &Whse. Receipt_Promoted"; "Create &Whse. Receipt")
                {
                }
                actionref("Create Inventor&y Put-away/Pick_Promoted"; "Create Inventor&y Put-away/Pick")
                {
                }

                actionref("Archive Document_Promoted"; "Archive Document")
                {
                }
                // actionref("ImportPurchOrder"; "Import Purchase Order")
                // {
                // }
            }
            group(Category_Category7)
            {
                Caption = 'Prepare', Comment = 'Generated from the PromotedActionCategories property index 6.';

                actionref(CopyDocument_Promoted; CopyDocument)
                {
                }
                actionref(GetRecurringPurchaseLines_Promoted; GetRecurringPurchaseLines)
                {
                }
                group("Category_Incoming Document")
                {
                    Caption = 'Incoming Document';

                    actionref(IncomingDocAttachFile_Promoted; IncomingDocAttachFile)
                    {
                    }
                    actionref(SelectIncomingDoc_Promoted; SelectIncomingDoc)
                    {
                    }
                    actionref(IncomingDocCard_Promoted; IncomingDocCard)
                    {
                    }
                    actionref(RemoveIncomingDoc_Promoted; RemoveIncomingDoc)
                    {
                    }
                }
                actionref(CalculateInvoiceDiscount_Promoted; CalculateInvoiceDiscount)
                {
                }
                actionref(MoveNegativeLines_Promoted; MoveNegativeLines)
                {
                }
            }
            group(Category_Category4)
            {
                Caption = 'Approve', Comment = 'Generated from the PromotedActionCategories property index 3.';

                actionref(Approve_Promoted; Approve)
                {
                }
                actionref(Reject_Promoted; Reject)
                {
                }
                actionref(Comment_Promoted; Comment)
                {
                }
                actionref(Delegate_Promoted; Delegate)
                {
                }
            }
            group(Category_Category10)
            {
                Caption = 'Print/Send', Comment = 'Generated from the PromotedActionCategories property index 9.';

                actionref("&Print_Promoted"; "&Print")
                {
                }
                actionref(SendCustom_Promoted; SendCustom)
                {
                }
                actionref(AttachAsPDF_Promoted; AttachAsPDF)
                {
                }

            }
            group(Category_Category9)
            {
                Caption = 'Request Approval', Comment = 'Generated from the PromotedActionCategories property index 8.';

                actionref(SendApprovalRequest_Promoted; SendApprovalRequest)
                {
                }
                actionref(CancelApprovalRequest_Promoted; CancelApprovalRequest)
                {
                }
            }
            group(Category_Category8)
            {
                Caption = 'Order', Comment = 'Generated from the PromotedActionCategories property index 7.';

                actionref(Dimensions_Promoted; Dimensions)
                {
                }
                actionref(Statistics_Promoted; PurchaseStatistics)
                {
                }
                actionref("Co&mments_Promoted"; "Co&mments")
                {
                }
                actionref(DocAttach_Promoted; DocAttach)
                {
                }
                actionref(Approvals_Promoted; Approvals)
                {
                }
                separator(Navigate_Separator)
                {
                }
                actionref(Invoices_Promoted; Invoices)
                {
                }
                actionref(Vendor_Promoted; Vendor)
                {
                }
                actionref(Receipts_Promoted; Receipts)
                {
                }
                actionref(PostedPrepaymentInvoices_Promoted; PostedPrepaymentInvoices)
                {
                }
                actionref(PostedPrepaymentCrMemos_Promoted; PostedPrepaymentCrMemos)
                {
                }
            }
            group(Category_Category11)
            {
                Caption = 'Navigate', Comment = 'Generated from the PromotedActionCategories property index 10.';
            }
            group(Category_Report)
            {
                Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';
            }
        }

    }


    trigger OnInit()
    begin
        SetExtDocNoMandatoryCondition();
    end;

    trigger OnOpenPage()
    var
        ICInboxOutboxMgt: Codeunit ICInboxOutboxMgt;
    begin
        Clear(RejectICPurchaseOrderEnabled);
        if UserMgt.GetPurchasesFilter() <> '' then begin
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FILTERGROUP(0);
        end;
        RejectICPurchaseOrderEnabled := ICInboxOutboxMgt.IsPurchaseHeaderFromIncomingIC(Rec);
    end;

    trigger OnAfterGetRecord()
    var
        ICInboxOutboxMgt: Codeunit ICInboxOutboxMgt;
    begin
        SetControlAppearance();
        RejectICPurchaseOrderEnabled := ICInboxOutboxMgt.IsPurchaseHeaderFromIncomingIC(Rec);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."LFS EXIM Type" := Rec."LFS EXIM Type"::Import;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD();
        EXIT(Rec.ConfirmDeletion());
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    var
        // PurchSetup: Record "Purchases & Payables Setup";
        MoveNegPurchLines: Report "Move Negative Purchase Lines";
        ArchiveManagement: Codeunit ArchiveManagement;
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        ChangeExchangeRate: Page "Change Exchange Rate";
        ChangeCustomExchangeRate: Page "LFSChange Custom Exchange Rate";
        CanCancelApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanRequestApprovalForFlow: Boolean;
        DocumentIsPosted: Boolean;
        HasIncomingDocument: Boolean;
        // CopyPurchDoc: Report "Copy Purchase Document";
        // DocPrint: Codeunit "Document-Print";
        // PurchLine: Record "Purchase Line";
        JobQueueVisible: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        // ShowWorkflowStatus: Boolean;
        // GSTLocRegNo: Boolean;
        // IsRateChangeEnabled: Boolean;
        RejectICPurchaseOrderEnabled: Boolean;
        // DocNoVisible: Boolean;
        VendorInvoiceNoMandatory: Boolean;
        OpenPostedPurchaseOrderQst: Label 'The order is posted as number %1 and moved to the Posted Purchase Invoices window.\\Do you want to open the posted invoice?', Comment = '%1 = posted document number';

    //     local procedure Post(PostingCodeunitID: Integer)
    //     begin
    //         Rec.SendToPosting(PostingCodeunitID);
    //         if Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting" then
    //             CurrPage.CLOSE();
    //         CurrPage.UPDATE(FALSE);
    //     end;

    Procedure DimensionCodeValidation()
    var
    begin
        Rec.TestField("Shortcut Dimension 1 Code");
        Rec.TestField("Shortcut Dimension 2 Code");
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.ImportPurchLines.PAGE.ApproveCalcInvDisc();
    end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        if Rec.GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." then
            if Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." then
                Rec.SETRANGE("Buy-from Vendor No.");
        CurrPage.UPDATE();
    end;

    // local procedure PurchaserCodeOnAfterValidate()
    // begin
    //     CurrPage.ImportPurchLines.PAGE.UpdateForm(true);
    // end;

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.Update();
    end;

    // local procedure CheckMultipleLicenseTotalQty()
    // var
    //     PurchLine: Record "Purchase Line";
    //     EXIM_License: Record "LFS EXIM Import License";
    //     // EximLicense1: Record "LFS EXIM Import License";
    //     // eximLicenseHeader: Record "LFS EXIM  License Header";
    //     sumQty: Decimal;
    // begin
    //     PurchLine.SetRange("Document No.", Rec."No.");
    //     PurchLine.SetRange("Document Type", Rec."Document Type");
    //     if PurchLine.Findset() then
    //         repeat
    //             sumQty := 0;
    //             EXIM_License.SetRange("LFS Source No.", PurchLine."Document No.");
    //             EXIM_License.SetRange("LFS Source line No.", PurchLine."Line No.");
    //             if EXIM_License.Findset() then
    //                 repeat
    //                     sumQty += EXIM_License."LFS Quantity";
    //                 until EXIM_License.Next() = 0;
    //             if (sumQty > PurchLine.Quantity) then
    //                 Error('Total License Quantity should not exceed the document line quantity');
    //         until PurchLine.Next() = 0;
    // end;

    local procedure PerformManualRelease()
    var
        ReleasePurchDoc: Codeunit "Release Purchase Document";
    begin
        if Rec.Status <> Rec.Status::Released then begin
            ReleasePurchDoc.PerformManualRelease(Rec);
            Commit();
        end;
    end;

    local procedure PostDocument(PostingCodeunitID: Integer; Navigate: Enum "Navigate After Posting")
    var
        PurchaseHeader: Record "Purchase Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        IsScheduledPosting: Boolean;
    // IsHandled: Boolean;
    begin
        LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);

        Rec.SendToPosting(PostingCodeunitID);

        IsScheduledPosting := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        DocumentIsPosted := (not PurchaseHeader.Get(Rec."Document Type", Rec."No.")) or IsScheduledPosting;

        if IsScheduledPosting then
            CurrPage.Close();
        CurrPage.Update(false);

        if PostingCodeunitID <> CODEUNIT::"Purch.-Post (Yes/No)" then
            exit;

        case Navigate of
            Enum::"Navigate After Posting"::"Posted Document":
                begin
                    if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode()) then
                        ShowPostedConfirmationMessage();

                    if IsScheduledPosting or DocumentIsPosted then
                        CurrPage.Close();
                end;
            Enum::"Navigate After Posting"::"New Document":
                if DocumentIsPosted then begin
                    Clear(PurchaseHeader);
                    PurchaseHeader.Init();
                    PurchaseHeader.Validate("Document Type", PurchaseHeader."Document Type"::Order);
                    PurchaseHeader.Insert(true);
                    PAGE.Run(PAGE::"Purchase Order", PurchaseHeader);
                end;
        end;
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        JobQueueVisible := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        SetExtDocNoMandatoryCondition();
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId());
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId(), CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;

    // local procedure PricesIncludingVATOnAfterValid()
    // begin
    //     CurrPage.Update();
    // end;
    // local procedure Prepayment37OnAfterValidate()
    // begin
    //     CurrPage.Update();
    // end;

    // local procedure SetDocNoVisible()
    // var
    //     DocumentNoVisibility: Codeunit DocumentNoVisibility;
    //     DocType: Option Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    // begin
    //     Clear(DocNoVisible);
    //     DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::Order, Rec."No.");
    // end;

    local procedure SetExtDocNoMandatoryCondition()
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        Clear(VendorInvoiceNoMandatory);
        PurchasesPayablesSetup.GET();
        VendorInvoiceNoMandatory := PurchasesPayablesSetup."Ext. Doc. No. Mandatory"
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.Update();
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.Update();
    end;

    local procedure ShowPostedConfirmationMessage()
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        OrderPurchaseHeader: Record "Purchase Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    // ICFeedback: Codeunit "IC Feedback";
    begin
        if not OrderPurchaseHeader.Get(Rec."Document Type", Rec."No.") then begin
            PurchInvHeader.SetRange("No.", Rec."Last Posting No.");
            if PurchInvHeader.FindFirst() then
                if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedPurchaseOrderQst, PurchInvHeader."No."),
                     InstructionMgt.ShowPostedConfirmationMessageCode())
                then
                    InstructionMgt.ShowPostedDocument(PurchInvHeader, Page::"Purchase Order");
        end;
    end;

    local procedure ShowPrepmtCrMemoPreview()
    var
        PurchPostPrepmtYesNo: Codeunit "Purch.-Post Prepmt. (Yes/No)";
    begin
        PurchPostPrepmtYesNo.Preview(Rec, 3);
    end;

    local procedure ShowPrepmtInvoicePreview()
    var
        PurchPostPrepmtYesNo: Codeunit "Purch.-Post Prepmt. (Yes/No)";
    begin
        PurchPostPrepmtYesNo.Preview(Rec, 2);
    end;

    local procedure ShowPreview()
    var
        PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
    begin
        PurchPostYesNo.Preview(Rec);
    end;
}