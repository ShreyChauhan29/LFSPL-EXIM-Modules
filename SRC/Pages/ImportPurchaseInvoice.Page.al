namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.Document;
using System.Automation;
using Microsoft.Foundation.Reporting;
using Microsoft.Finance.GeneralLedger.Posting;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Purchases.History;
using Microsoft.Purchases.Setup;
using Microsoft.Utilities;
using Microsoft.Finance.Currency;
using Microsoft.CRM.Outlook;
using System.Security.User;
using Microsoft.Foundation.Enums;
using Microsoft.Purchases.Posting;
using Microsoft.Inventory.Tracking;
using Microsoft.Intercompany;
using Microsoft.Foundation.Attachment;
using Microsoft.Finance.Dimension;
using Microsoft.Purchases.Comment;
using Microsoft.Purchases.Payables;
using Microsoft.EServices.EDocument;
using Microsoft.Purchases.Vendor;
using Microsoft.Finance.TaxEngine.TaxTypeHandler;

page 72065 "LFS Import Purchase Invoice"
{
    ApplicationArea = All;
    Caption = 'Import Purchase Invoice';
    PageType = Document;
    SourceTable = "Purchase Header";
    RefreshOnActivate = true;
    SourceTableView = where("Document Type" = filter(Invoice), "LFS EXIM Type" = const(Import));
    DeleteAllowed = true;
    UsageCategory = None;

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
                    Importance = Promoted;
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
                    ShowMandatory = true;
                    Importance = Promoted;
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
                    Importance = Additional;
                }
                field("Buy-from Address 2"; Rec."Buy-from Address 2")
                {
                    ToolTip = 'Specifies the additional address of vendor.';
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    ToolTip = 'Specifies the post code of the vendor.';
                    ApplicationArea = All;
                    Importance = Additional;
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
                    Importance = Additional;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location code used in the document.';
                    ApplicationArea = All;
                    Importance = Promoted;

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
                    Importance = Promoted;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the document date of the document.';
                    ApplicationArea = All;
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ToolTip = 'Specifies the vendor invoice number.';
                    ApplicationArea = All;
                    ShowMandatory = VendorInvoiceNoMandatory;
                }
                field("Invoice Received Date"; Rec."Invoice Received Date")
                {
                    ApplicationArea = all;
                    Caption = 'Vendor Invoice Date';
                    ToolTip = 'Specifies the Vendor Invoice Date';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies the payment term used in the document.';
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies the due date of the order as per payment terms.';
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ToolTip = 'Specifies the date of expected receipt of the material.';
                    ApplicationArea = All;
                    Importance = Promoted;
                }

                field("Order Address Code"; Rec."Order Address Code")
                {
                    ToolTip = 'Specifies the vendor order address, if any.';
                    ApplicationArea = All;
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Posting Description';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the status of the document.';
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Posting No. Series"; Rec."Posting No. Series")
                {
                    ToolTip = 'Specifies the value of the Posting No. Series field.';
                    ApplicationArea = All;
                    Visible = false;
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
            part(ImportPurchLines; "LFS ImportPurch.InvoiceSubform")
            {
                ApplicationArea = all;
                SubPageLink = "Document No." = field("No.");
                UpdatePropagation = Both;
            }
            group(Invoicing)
            {
                Visible = false;
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ToolTip = 'Specifies the pay to vendor code used in the document.';
                    ApplicationArea = All;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        PaytoVendorNoOnAfterValidate();
                    end;
                }
                field("Pay-to Contact No."; Rec."Pay-to Contact No.")
                {
                    ToolTip = 'Specifies the contact number of the pay to vendor.';
                    ApplicationArea = All;
                    Importance = Additional;
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
                    Importance = Additional;
                }
                field("Pay-to Address 2"; Rec."Pay-to Address 2")
                {
                    ToolTip = 'Specifies the additional address of pay to vendor.';
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    ToolTip = 'Specifies the post code of the pay to vendor.';
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Pay-to City"; Rec."Pay-to City")
                {
                    ToolTip = 'Specifies the city of the pay to vendor.';
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ToolTip = 'Specifies the contact of the pay to vendor.';
                    ApplicationArea = All;
                }
            }
            group(Shipping)
            {
                Visible = false;
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
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ToolTip = 'Specifies the ship to city used for the document.';
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ToolTip = 'Specifies the ship to contact used for the document.';
                    ApplicationArea = All;
                }
                field("Bill to-Location(POS)"; Rec."Bill to-Location(POS)")
                {
                    Visible = false;
                    ToolTip = 'Specifies the Bill to Location Code which is considered as Place of Supply.';
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
                    Importance = Promoted;
                    Visible = false;

                    trigger OnAssistEdit()
                    begin
                        CLEAR(ChangeExchangeRate);
                        if Rec."Posting Date" <> 0D then
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date")
                        else
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WORKDATE());
                        if ChangeExchangeRate.RUNMODAL() = ACTION::OK then begin
                            REc.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter());
                            CurrPage.UPDATE();
                        end;
                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("Custom Currency Code"; Rec."LFS Custom Currency Code")
                {
                    ToolTip = 'Specifies the value of the Custom Currency Code field.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        rec."Currency Code" := Rec."LFS Custom Currency Code";
                        Rec.Validate("Currency Code");
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
                field("Transport Method"; Rec."Transport Method")
                {
                    ToolTip = 'Specifies the transportation method mentioned in the document.';
                    ApplicationArea = All;
                }
                field("Bill of Entry No."; Rec."Bill of Entry No.")
                {
                    ToolTip = 'Specifies the bill of entry number. It is a document number which is submitted to custom department .';
                    ApplicationArea = All;
                }
                field("Bill of Entry Date"; Rec."Bill of Entry Date")
                {
                    ToolTip = 'Specifies the entry date defined in bill of entry document.';
                    ApplicationArea = All;
                }
                field("Bill of Entry Value"; Rec."Bill of Entry Value")
                {
                    ToolTip = 'Specifies the values as mentioned in bill of entry document.';
                    ApplicationArea = All;
                }
            }
            group(Application)
            {
                Visible = false;
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    Visible = false;
                    ToolTip = 'Specifies the document type of the entry which will be applied with this document.';
                    ApplicationArea = All;
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the document number of the entry which will be applied with this document.';
                    ApplicationArea = All;
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    Visible = false;
                    ToolTip = 'Specifies the ID of entries that will be applied to when you choose the Apply Entries action.';
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
                    Editable = GSTLocRegNo;
                }
                field("GST Vendor Type"; Rec."GST Vendor Type")
                {
                    ToolTip = 'Specifies the vendor type for GST transaction';
                    ApplicationArea = All;
                }
                field("Invoice Type"; Rec."Invoice Type")
                {
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
                    Editable = false;
                }
                field("Order Address GST Reg. No."; Rec."Order Address GST Reg. No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the GST registration number of the mentioned order address in the transaction.';
                    ApplicationArea = All;
                }
                field("Vendor GST Reg. No."; Rec."Vendor GST Reg. No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the GST registration number of the Vendor specified on the journal line.';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
        area(FactBoxes)
        {
            part(TaxInformation; "Tax Information Factbox")
            {
                Provider = ImportPurchLines;
#pragma warning disable AL0603
                SubPageLink = "Table ID Filter" = const(39),
                              "Document Type Filter" = field("Document Type"),
                              "Document No. Filter" = field("Document No."),
                              "Line No. Filter" = field("Line No.");
#pragma warning restore AL0603
                ApplicationArea = All;
            }
            part("Pending Approval FactBox"; "Pending Approval FactBox")
            {
                ApplicationArea = all;
                Visible = OpenApprovalEntriesExistForCurrUser;
                SubPageLink = "Table ID" = const(38),
                                "Document Type" = field("Document Type"),
                                "Document No." = field("No.");
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
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = all;
                ShowFilter = false;
            }
            part("Vendor Statistics FactBox"; "Vendor Statistics FactBox")
            {
                ApplicationArea = all;
                Visible = true;
                SubPageLink = "No." = field("Pay-to Vendor No.");
            }
            part("Vendor Hist. Buy-from FactBox"; "Vendor Hist. Buy-from FactBox")
            {
                ApplicationArea = all;
                SubPageLink = "No." = field("Buy-from Vendor No.");
            }
            part("Vendor Hist. Pay-to FactBox"; "Vendor Hist. Pay-to FactBox")
            {
                ApplicationArea = all;
                SubPageLink = "No." = field("Pay-to Vendor No.");
                Visible = false;
            }
            part("Purchase Line FactBox"; "Purchase Line FactBox")
            {
                ApplicationArea = all;
                Visible = false;
                Provider = ImportPurchLines;
                SubPageLink = "Document Type" = field("Document Type"),
                              "Document No." = field("Document No."),
                              "Line No." = field("Line No.");
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = all;
                Visible = ShowWorkflowStatus;
                Enabled = false;
                Editable = false;
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
                // action(Statistics)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Statistics';
                //     Image = Statistics;
                //     ShortCutKey = 'F7';
                //     ToolTip = 'View statistical information, such as the value of posted entries, for the record.';

                //     trigger OnAction()
                //     begin
                //         Rec.OpenDocumentStatistics();
                //         CurrPage.ImportPurchLines.Page.ForceTotalsCalculation();
                //     end;
                // }
                // action(PurchaseStatistics)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Statistics';
                //     Enabled = Rec."No." <> '';
                //     Image = Statistics;
                //     ShortCutKey = 'F7';
                //     Visible = true;
                //     ToolTip = 'View statistical information, such as the value of posted entries, for the record.';
                //     RunObject = Page "Purchase Statistics";
                //     RunPageOnRec = true;
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
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor';
                    Enabled = Rec."Buy-from Vendor No." <> '';
                    Image = Vendor;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = field("Buy-from Vendor No."),
                                  "Date Filter" = field("Date Filter");
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or edit detailed information about the vendor on the purchase document.';
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
        }
        area(processing)
        {
            group(IncomingDocument)
            {
                Caption = 'Incoming Document';
                action(IncomingDocCard)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'View';
                    Enabled = HasIncomingDocument;
                    Image = ViewOrder;
                    ToolTip = 'View any incoming document records and file attachments that exist for the entry or document.';

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
                    ApplicationArea = Basic, Suite;
                    Caption = 'Select';
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
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create from File';
                    Ellipsis = true;
                    Enabled = (Rec."Incoming Document Entry No." = 0) and (Rec."No." <> '');
                    Image = Attach;
                    ToolTip = 'Create an incoming document record by selecting a file to attach, and then link the incoming document record to the entry or document.';
                    Visible = CreateIncomingDocumentVisible;

                    trigger OnAction()
                    var
                        IncomingDocumentAttachment: Record "Incoming Document Attachment";
                    begin
                        IncomingDocumentAttachment.NewAttachmentFromPurchaseDocument(Rec);
                    end;
                }
                action(IncomingDocEmailAttachment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create from Attachment';
                    Ellipsis = true;
                    Enabled = IncomingDocEmailAttachmentEnabled;
                    Image = SendElectronicDocument;
                    ToolTip = 'Create an incoming document record by selecting an attachment from outlook email, and then link the incoming document record to the entry or document.';
                    Visible = CreateIncomingDocFromEmailAttachment;

                    trigger OnAction()
                    begin
                        CurrPage.SaveRecord();
                        OfficeMgt.InitiateSendToIncomingDocumentsWithPurchaseHeaderLink(Rec, Rec."Buy-from Vendor No.");
                    end;
                }
                action(RemoveIncomingDoc)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Remove';
                    Enabled = HasIncomingDocument;
                    Image = RemoveLine;
                    ToolTip = 'Remove an external document that has been recorded, manually or automatically, and attached as a file to a document or ledger entry.';

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
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Image = Delegate;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = All;
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
            group(Release)
            {
                Caption = 'Release';
                action("Re&lease")
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Release the document to the Next() stage of processing. You must reopen the document before you can make changes to it.';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        DimensionCodeValidation();


                        ReleasePurchDoc.PerformManualRelease(Rec);
                        CurrPage.ImportPurchLines.PAGE.ClearTotalPurchaseHeader();
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&open';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = ReOpen;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                        CurrPage.ImportPurchLines.PAGE.ClearTotalPurchaseHeader();
                    end;
                }
                action("Reject IC Purchase Invoice")
                {
                    ApplicationArea = Intercompany;
                    Caption = 'Reject IC Purchase Invoice';
                    Enabled = RejectICPurchaseInvoiceEnabled;
                    Image = Cancel;
                    ToolTip = 'Deletes the invoice and sends the rejection to the company that created it.';

                    trigger OnAction()
                    var
                        ICInboxOutboxMgt: Codeunit ICInboxOutboxMgt;
                    begin
                        if not ICInboxOutboxMgt.IsPurchaseHeaderFromIncomingIC(Rec) then
                            exit;
                        if Confirm(SureToRejectMsg) then
                            ICInboxOutboxMgt.RejectAcceptedPurchaseHeader(Rec);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
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
                action(CalculateInvoiceDiscount)
                {
                    AccessByPermission = TableData "Vendor Invoice Disc." = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;
                    ToolTip = 'Calculate the invoice discount for the entire purchase invoice.';

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc();
                        PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                action("Create Tracking Information")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create Tracking Information';
                    Image = ItemTracking;
                    ToolTip = 'Create item tracking information for the entire purchase invoice.';

                    trigger OnAction()
                    var
                        ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
                    begin
                        ItemTrackingDocMgt.CreateTrackingInfo(DATABASE::"Purchase Header", Rec."Document Type".AsInteger(), Rec."No.");
                    end;
                }
                action(MoveNegativeLines)
                {
                    ApplicationArea = Basic, Suite;
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
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
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
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post1)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'P&ost';
                    Image = PostOrder;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction()
                    begin
                        DimensionCodeValidation();

                        VerifyTotal();
                        PostDocument(CODEUNIT::"Purch.-Post (Yes/No)", Enum::"Navigate After Posting"::"Posted Document");
                    end;
                }
                action(Preview)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    ShortCutKey = 'Ctrl+Alt+F9';
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                    trigger OnAction()
                    var
                        PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
                    begin
                        DimensionCodeValidation();

                        PurchPostYesNo.Preview(Rec);
                    end;
                }
                action(TestReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';

                    trigger OnAction()
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action(PostAndPrint)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    ShortCutKey = 'Shift+F9';
                    ToolTip = 'Finalize and print the document or journal. The values and quantities are posted to the related accounts.';
                    Visible = NOT IsOfficeAddin;

                    trigger OnAction()
                    begin
                        VerifyTotal();
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
                action(PostBatch)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    ToolTip = 'Post several documents at once. A report request window opens where you can specify which documents to post.';

                    trigger OnAction()
                    begin
                        VerifyTotal();
                        REPORT.RunModal(REPORT::"Batch Post Purchase Invoices", true, true, Rec);
                        CurrPage.Update(false);
                    end;
                }
                action(RemoveFromJobQueue)
                {
                    ApplicationArea = All;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    ToolTip = 'Remove the scheduled processing of this record from the job queue.';
                    Visible = Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled For Posting";

                    trigger OnAction()
                    begin
                        Rec.CancelBackgroundPosting();
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
                    actionref(PostAndNew_Promoted; PostAndNew)
                    {
                    }
                    actionref(PostAndPrint_Promoted; PostAndPrint)
                    {
                    }
                    actionref(PostBatch_Promoted; PostBatch)
                    {
                    }
                }
                group(Category_Category10)
                {
                    Caption = 'Release', Comment = 'Generated from the PromotedActionCategories property index 9.';
                    ShowAs = SplitButton;

                    actionref("Re&lease_Promoted"; "Re&lease")
                    {
                    }
                    actionref(Reopen_Promoted; Reopen)
                    {
                    }
                }
            }
            group(Category_Prepare)
            {
                Caption = 'Prepare';

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
                    actionref(IncomingDocEmailAttachment_Promoted; IncomingDocEmailAttachment)
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
            group(Category_Category8)
            {
                Caption = 'Request Approval', Comment = 'Generated from the PromotedActionCategories property index 7.';

                actionref(SendApprovalRequest_Promoted; SendApprovalRequest)
                {
                }
                actionref(CancelApprovalRequest_Promoted; CancelApprovalRequest)
                {
                }
            }
            group(Category_Category5)
            {
                Caption = 'Invoice', Comment = 'Generated from the PromotedActionCategories property index 4.';

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
                actionref(Vendor_Promoted; Vendor)
                {
                }
            }
            group(Category_Category7)
            {
                Caption = 'View', Comment = 'Generated from the PromotedActionCategories property index 6.';
            }
            group(Category_Category9)
            {
                Caption = 'Incoming Document', Comment = 'Generated from the PromotedActionCategories property index 8.';

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
    begin
        SetDocNoVisible();

        if UserMgt.GetPurchasesFilter() <> '' then begin
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FILTERGROUP(0);
        end;
        CreateIncomingDocumentVisible := not OfficeMgt.IsOutlookMobileApp();
        CreateIncomingDocFromEmailAttachment := OfficeMgt.OCRAvailable();
        IsOfficeAddin := OfficeMgt.IsAvailable();
        if (Rec."No." <> '') and (Rec."Buy-from Vendor No." = '') then
            DocumentIsPosted := (not Rec.Get(Rec."Document Type", Rec."No."));
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        REc."LFS EXIM Type" := Rec."LFS EXIM Type"::Import;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD();
        EXIT(Rec.ConfirmDeletion());
    end;

    trigger OnAfterGetRecord()
    var
        ICInboxOutboxMgt: Codeunit ICInboxOutboxMgt;
    begin
        RejectICPurchaseInvoiceEnabled := ICInboxOutboxMgt.IsPurchaseHeaderFromIncomingIC(Rec);
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RECORDID);
        CurrPage.ApprovalFactBox.PAGE.RefreshPage(Rec.RECORDID);
    end;

    var
        MoveNegPurchLines: Report "Move Negative Purchase Lines";
        OfficeMgt: Codeunit "Office Management";
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        ChangeExchangeRate: Page "Change Exchange Rate";
        ChangeCustomExchangeRate: Page "LFSChange Custom Exchange Rate";
        CanCancelApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CreateIncomingDocFromEmailAttachment: Boolean;
        CreateIncomingDocumentVisible: Boolean;
        DocNoVisible: Boolean;
        DocumentIsPosted: Boolean;
        GSTLocRegNo: Boolean;
        // CopyPurchDoc: Report "Copy Purchase Document";
        // PurchLine: Record "Purchase Line";
        HasIncomingDocument: Boolean;
        IncomingDocEmailAttachmentEnabled: Boolean;
        IsOfficeAddin: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        // IsRateChangeEnabled: Boolean;
        RejectICPurchaseInvoiceEnabled: Boolean;
        ShowWorkflowStatus: Boolean;
        VendorInvoiceNoMandatory: Boolean;
        OpenPostedPurchaseInvQst: Label 'The invoice is posted as number %1 and moved to the Posted Purchase Invoices window.\\Do you want to open the posted invoice?', Comment = '%1 = posted document number';
        SureToRejectMsg: Label 'Rejecting this invoice will remove it from your company and send it back to the partner company.\\ Do you want to continue?';
        TotalsMismatchErr: Label 'The invoice cannot be posted because the total is different from the total on the related incoming document.';

    Procedure DimensionCodeValidation()
    var
    begin
        Rec.TestField("Shortcut Dimension 1 Code");
        Rec.TestField("Shortcut Dimension 2 Code");
    end;

    // local procedure SetControlAppearance()
    // var
    //     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    //     WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    // begin
    //     HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
    //     SetExtDocNoMandatoryCondition();
    //     IncomingDocEmailAttachmentEnabled := OfficeMgt.EmailHasAttachments();
    //     OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);
    //     OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(REc.RECORDID);
    //     WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);

    // end;

    // local procedure CheckMultipleLicenseTotalQty()
    // var
    //     PurchLine: Record "Purchase Line";
    //     purchline2: Record "Purchase Line";
    //     purchline3: Record "Purchase Line";
    //     EXIM_License: Record "LFS EXIM Import License";
    //     EXImLicense2: Record "LFS EXIM Import License";
    //     EximLicense1: Record "LFS EXIM Import License";
    //     EXIMlicense3: Record "LFS EXIM Import License";
    //     RodtepLicense: Record "LFS Rodtep License Header";
    //     // EximIOdetails: Record "LFS EXIM License IO Details";
    //     sumQty: Decimal;
    //     TotalQty: Decimal;
    //     Consumption: Decimal;
    // begin
    //     PurchLine.SetRange("Document No.", Rec."No.");
    //     PurchLine.SetRange("Document Type", Rec."Document Type");
    //     if PurchLine.Findset() then
    //         repeat
    //             sumQty := 0;
    //             EXIM_License.SetRange("LFS Source No.", PurchLine."Document No.");
    //             EXIM_License.SetRange("LFS Source line No.", PurchLine."Line No.");
    //             EXIM_License.SetFilter("LFS License Type", '<>%1', EXIM_License."LFS License Type"::RoDTEP);
    //             if EXIM_License.Findset() then
    //                 repeat
    //                     sumQty += EXIM_License."LFS Quantity";
    //                 until EXIM_License.Next() = 0;
    //             if (sumQty > PurchLine.Quantity) then
    //                 Error('Total License Quantity should not exceed the document line quantity');
    //         until PurchLine.Next() = 0;

    //     purchline2.SetRange("Document No.", Rec."No.");
    //     purchline2.SetRange("Document Type", Rec."Document Type");
    //     if purchline2.Findset() then
    //         repeat
    //             TotalQty := 0;
    //             EXImLicense2.SetRange("LFS Source No.", purchline2."Document No.");
    //             EXImLicense2.SetRange("LFS Source line No.", purchline2."Line No.");
    //             EXImLicense2.Setrange("LFS License Type", EXImLicense2."LFS License Type"::RoDTEP);
    //             if EXImLicense2.Findset() then
    //                 repeat
    //                     TotalQty += EXImLicense2."LFS RoDTEP Consump Value";
    //                 until EXImLicense2.Next() = 0;
    //             if (TotalQty > purchline2."LFS Import Duties Amt. (LCY)") then
    //                 Error('Total License Quantity should not exceed the Line Import Duties');
    //         until purchline2.Next() = 0;

    //     purchline3.SetRange("Document No.", Rec."No.");
    //     purchline3.SetRange("Document Type", Rec."Document Type");
    //     if purchline3.Findset() then
    //         repeat
    //             Consumption := 0;
    //             EXImLicense1.SetRange("LFS Source No.", purchline3."Document No.");
    //             EXImLicense1.Setrange("LFS License Type", EXImLicense1."LFS License Type"::RoDTEP);
    //             if EXImLicense1.Findset() then
    //                 repeat
    //                     Consumption := 0;
    //                     EXIMlicense3.SetRange("LFS License No.", EximLicense1."LFS License No.");
    //                     if EXIMlicense3.Findset() then begin
    //                         repeat
    //                             Consumption += EXIMlicense3."LFS RoDTEP Consump Value";
    //                         until EXIMlicense3.Next() = 0;
    //                         RodtepLicense.SetRange(RodtepLicense."LFS No.", EXIMlicense3."LFS License No.");
    //                         if RodtepLicense.FindFirst() then
    //                             if Consumption > RodtepLicense."LFS Balance LCY" then
    //                                 Error('Balance is insufficient for the license %1', EXIMlicense3."LFS License No.");
    //                     end;
    //                 until EXImLicense1.Next() = 0;
    //         until purchline3.Next() = 0;
    // end;

    procedure InsertDDBRODTepEntryForImport(var PurchInvHeader: Record "Purch. Inv. Header")
    var
        recGenJnlLine: Record "Gen. Journal Line";
        MultipleLicense: Record "LFS EXIM Posted Import Licence";
        EximSetup: Record "LFS EXIM Setup";
        RODTEPAmount: Decimal;
        GenJnlLineNo: Integer;
    begin
        RODTEPAmount := 0;
        MultipleLicense.Reset();
        MultipleLicense.SetRange("LFS Source No.", PurchInvHeader."No.");
        MultipleLicense.SetRange("LFS Source Type", MultipleLicense."LFS Source Type"::Invoice);
        if MultipleLicense.Findset() then
            repeat
                RODTEPAmount += MultipleLicense."LFS RoDTEP Consump Value";
            until MultipleLicense.Next() = 0;
        if RODTEPAmount <> 0 then
            if PurchInvHeader."LFS EXIM Type" = PurchInvHeader."LFS EXIM Type"::Import then begin
                RODTEPAmount := 0;
                EximSetup.Get();
                recGenJnlLine.SetFilter("Journal Batch Name", '%1', EximSetup."LFS Rdp Cons Batch Name");
                if recGenJnlLine.FindLast() then
                    GenJnlLineNo := 10000 + recGenJnlLine."Line No.";
                recGenJnlLine.Reset();
                recGenJnlLine.Init();
                recGenJnlLine."Line No." := GenJnlLineNo;
                recGenJnlLine.Validate("Journal Template Name", EximSetup."LFS Rdp cons. Jour. Temp. Name");
                recGenJnlLine.Validate("Journal Batch Name", EximSetup."LFS Rdp Cons Batch Name");
                recGenJnlLine.Validate("Document No.", PurchInvHeader."No." + '_RT');
                recGenJnlLine.Validate("Posting Date", PurchInvHeader."Posting Date");
                recGenJnlLine.Validate("Account Type", recGenJnlLine."account type"::"G/L Account");
                recGenJnlLine.Validate("Account No.", EximSetup."LFS Rdp Cons Account No.");
                MultipleLicense.Reset();
                MultipleLicense.SetRange("LFS Source No.", PurchInvHeader."No.");
                MultipleLicense.SetRange("LFS Source Type", MultipleLicense."LFS Source Type"::Invoice);
                if MultipleLicense.Findset() then
                    repeat
                        RODTEPAmount += MultipleLicense."LFS RoDTEP Consump Value";
                    until MultipleLicense.Next() = 0;
                recGenJnlLine.Validate(Amount, RODTEPAmount);
                recGenJnlLine.Validate("Bal. Account Type", recGenJnlLine."bal. account type"::"G/L Account");
                recGenJnlLine.Validate("Bal. Account No.", EximSetup."LFS Rdp Cons Bal Acc. Num");
                recGenJnlLine.Validate("External Document No.", PurchInvHeader."Bill of Entry No.");
                if recGenJnlLine.Insert() then
                    Message('The RoDTEP entry is created with Doc. No. %1', PurchInvHeader."No." + '_RT');
                if EximSetup."LFS Cons GL Ent Auto Post" = true then
                    recGenJnlLine.SendToPosting(Codeunit::"Gen. Jnl.-Post");
            end;
    end;

    protected procedure VerifyTotal()
    // var
    //     IsHandled: Boolean;
    begin
        if not Rec.IsTotalValid() then
            Error(TotalsMismatchErr);
    end;

    // local procedure Post(PostingCodeunitID: Integer)
    // begin
    //     Rec.SendToPosting(PostingCodeunitID);
    //     if Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting" then
    //         CurrPage.CLOSE();
    //     CurrPage.UPDATE(FALSE);
    // end;



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

    local procedure PostDocument(PostingCodeunitID: Integer; Navigate: Enum "Navigate After Posting")
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchaseHeader: Record "Purchase Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        IsScheduledPosting: Boolean;
        PreAssignedNo: Code[20];
        xLastPostingNo: Code[20];
    // IsHandled: Boolean;
    begin
        LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);
        PreAssignedNo := Rec."No.";
        xLastPostingNo := Rec."Last Posting No.";

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
                if IsOfficeAddin then begin
                    if (Rec."Last Posting No." <> '') and (Rec."Last Posting No." <> xLastPostingNo) then
                        PurchInvHeader.SetRange("No.", Rec."Last Posting No.")
                    else
                        PurchInvHeader.SetRange("Pre-Assigned No.", PreAssignedNo);
                    PurchInvHeader.SetRange("Order No.", '');
                    if PurchInvHeader.FindFirst() then
                        PAGE.Run(PAGE::"Posted Purchase Invoice", PurchInvHeader);
                end else
                    if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode()) then
                        ShowPostedConfirmationMessage(PreAssignedNo, xLastPostingNo);
            Enum::"Navigate After Posting"::"New Document":
                if DocumentIsPosted then begin
                    Clear(PurchaseHeader);
                    PurchaseHeader.Init();
                    PurchaseHeader.Validate("Document Type", PurchaseHeader."Document Type"::Invoice);
                    PurchaseHeader.Insert(true);
                    PAGE.Run(PAGE::"Purchase Invoice", PurchaseHeader);
                end;
        end;
    end;

    // local procedure PricesIncludingVATOnAfterValid()
    // begin
    //     CurrPage.Update();
    // end;

    local procedure SetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
        DocType: Option Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        Clear(DocNoVisible);
        DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::Invoice, Rec."No.");
    end;

    local procedure SetExtDocNoMandatoryCondition()
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
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

    local procedure ShowPostedConfirmationMessage(PreAssignedNo: Code[20]; xLastPostingNo: Code[20])
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        if (Rec."Last Posting No." <> '') and (Rec."Last Posting No." <> xLastPostingNo) then
            PurchInvHeader.SetRange("No.", Rec."Last Posting No.")
        else begin
            PurchInvHeader.SetRange("Pre-Assigned No.", PreAssignedNo);
            PurchInvHeader.SetRange("Order No.", '');
        end;
        if PurchInvHeader.FindFirst() then
            if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedPurchaseInvQst, PurchInvHeader."No."),
                 InstructionMgt.ShowPostedConfirmationMessageCode())
            then
                InstructionMgt.ShowPostedDocument(PurchInvHeader, Page::"Purchase Invoice");
    end;
}