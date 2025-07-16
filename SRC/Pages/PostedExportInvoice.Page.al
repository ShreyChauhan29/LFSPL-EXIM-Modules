namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.History;
using Microsoft.Foundation.Attachment;
using Microsoft.Bank.Setup;
using Microsoft.Finance.Currency;
using Microsoft.CRM.Outlook;
using Microsoft.Sales.Customer;
using Microsoft.Integration.Dataverse;
using System.Automation;
using Microsoft.Finance.Dimension;
using Microsoft.Sales.Comment;
using Microsoft.Sales.Document;
using Microsoft.Finance.GST.Sales;
using Microsoft.EServices.EDocument;
using Microsoft.Finance.TaxEngine.TaxTypeHandler;

page 72072 "LFS Posted Export Invoice"
{
    ApplicationArea = All;
    Caption = 'Posted Export Invoice';
    PageType = Document;
    SourceTable = "Sales Invoice Header";
    RefreshOnActivate = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the record.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer the invoice concerns.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                {
                    ToolTip = 'Specifies a unique identifier for the contact person at the customer the invoice was sent to.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    ToolTip = 'Specifies the address where the customer is located.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ToolTip = 'Specifies the postal code.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ToolTip = 'Specifies the address city.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ToolTip = 'Specifies the name of the contact person at the customer the invoice was sent to.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the date on which the invoice was posted.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies when the posted sales invoice was created.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                    Caption = 'Invoice Date';
                    ToolTip = 'Specifies the date when the order was created.';
                }
                field("Quote No."; Rec."Quote No.")
                {
                    ToolTip = 'Specifies the number of the sales quote document if a quote was used to start the sales process.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Order No."; Rec."Order No.")
                {
                    ToolTip = 'Specifies the number of the sales order that this invoice was posted from.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the external document number that is entered on the sales header that this line was posted from.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Specifies which salesperson is associated with the invoice.';
                    ApplicationArea = All;
                    Editable = false;
                }
                // field("DDB Value"; Rec."LFS DDB Value")
                // {
                //     ApplicationArea = all;
                //     Editable = true;
                //     Visible = false;
                //     ToolTip = 'Specifies the DDB Value';
                // }
                // field("FOB Amount (FCY) LFSPL"; Rec."LFS FOB Amount (FCY) LFSPL")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                //     ToolTip = 'Specifies the FOB Amount (FCY)';
                // }
                // field("FOB Amount (LCY)"; Rec."LFS FOB Amount (LCY)")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                //     ToolTip = 'Specifies the FOB Amount (LCY)';
                // }
                // field("CIF Amount (FCY)"; Rec."LFS CIF Amount (FCY)")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                //     ToolTip = 'Specifies the CIF Amount (FCY)';
                // }
                // field("CIF Amount (LCY)"; Rec."LFS CIF Amount (LCY)")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                //     ToolTip = 'Specifies the CIF Amount (LCY)';
                // }
            }
            group("Shipping Bill Details")
            {
                Visible = false;
                field("Shipping Bill No."; Rec."LFS Shipping Bill No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shipping Bill No.';
                }
                field("Shipping Bill Date"; Rec."LFS Shipping Bill Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shipping Bill Date';
                }
                // field("Late export order No."; Rec."LFS Late export order No.")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the Late export order No.';
                // }
                // field("Late export order date"; Rec."LFS Late export order date")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the Late export order date';
                // }
                // field("Bill of Lading No."; Rec."LFS Bill of Lading No.")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the Bill of Lading No.';
                // }
                // field("Bill of Lading Date"; Rec."LFS Bill of Lading Date")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the Bill of Lading Date';
                // }
            }
            part(SalesInvLines; "LFS EXIMPostedExportInvoiceSub")
            {
                ApplicationArea = all;
                SubPageLink = "Document No." = field("No.");
            }
            group(EXIM)
            {
                field("Port of Loading"; Rec."LFS Port of Loading")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Port of Loading';
                }
                field("Port of Discharge"; Rec."LFS Port of Discharge")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Port of Discharge';
                }
                field("Country of Final Destination"; Rec."LFS Country Fin Destination")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Country of Final Destination';
                }
                field("Final Destination"; Rec."LFS Final Destination")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the Final Destination';
                }
                field("Country of Origin of Goods"; Rec."LFS Country Origin of Goods")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Country of Origin of Goods';
                }
                field("Inco Terms"; Rec."LFS Inco Terms")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Inco Terms';
                }
                field("Shpping Line"; Rec."LFS Shpping Line")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Shpping Line';
                }
                field("Customs Bank Account"; Rec."LFS Customs Bank Account")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Customs Bank Account';
                }
                field("Commercial  Bank Account"; Rec."LFS Comm. Bank Account")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Commercial Bank Account';
                }
                field("Export Remark"; Rec."LFS Export Remark")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Batch Code';
                    ToolTip = 'Specifies the Export Remark';
                }
                field("Pre Carriage"; Rec."LFS Pre Carriage")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the Pre Carriage';
                }
                field("LFSPlaceofReceiptPre-Carriage"; Rec."LFSPlaceofReceiptPre-Carriage")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the Place of Receipt By Pre-Carriage';
                }
                field(ETA; Rec."LFS ETA")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the ETA';
                }
                field(ETD; Rec."LFS ETD")
                {
                    ApplicationArea = all;
                    Caption = 'ETD';
                    Editable = false;
                    ToolTip = 'Specifies the ETD';
                }
                // field("FTT No."; Rec."LFS FTT No.")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     Visible = false;
                //     ToolTip = 'Specifies the FTT No.';
                // }
                // field("FTT Date"; Rec."LFS FTT Date")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     Visible = false;
                //     ToolTip = 'Specifies the FTT Date';
                // }
                // field("BIN No."; Rec."LFS BIN No.")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     Visible = false;
                //     ToolTip = 'Specifies the BIN No.';
                // }
                // field("Additional Information"; Rec."LFS Additional Information")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the Additional Information';
                // }
            }
            group(Invoicing)
            {
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer that you send or sent the invoice or credit memo to.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                {
                    ToolTip = 'Specifies the number of the contact the invoice was sent to.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ToolTip = 'Specifies the name of the customer that the invoice was sent to.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    ToolTip = 'Specifies the address of the customer that the invoice was sent to.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ToolTip = 'Specifies the postal code.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                    ToolTip = 'Specifies the city of the customer on the sales document.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ToolTip = 'Specifies the name of the person you regularly contact when you communicate with the customer to whom the invoice was sent.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the sales document.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies when the posted sales invoice must be paid.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("LFS Lodgement Ref No"; Rec."LFS Lodgement Ref No")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies when the posted sales invoice must be paid.';
                }
            }
            group(Shipping)
            {
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies the address on purchase orders shipped with a drop shipment directly from the vendor to a customer.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTip = 'Specifies the name of the customer that the items were shipped to.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ToolTip = 'Specifies the address that the items on the invoice were shipped to.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ToolTip = 'Specifies the postal code.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ToolTip = 'Specifies the city of the customer on the sales document.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ToolTip = 'Specifies the name of the person you regularly contact at the address that the items were shipped to.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the code for the location from which the items were shipped.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ToolTip = 'Specifies the code that represents the shipment method for the invoice.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ToolTip = 'Specifies when items on the document are shipped or were shipped. A shipment date is usually calculated from a requested delivery date plus lead time.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ToolTip = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.';
                    ApplicationArea = All;
                }

            }
            group("Foreign Trace")
            {
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the currency code of the invoice.';
                    ApplicationArea = All;

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
                    ToolTip = 'Specifies the value of the Custom Currency Code field.';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Tax Information")
            {
                field("GST Bill-to State Code"; Rec."GST Bill-to State Code")
                {
                    ToolTip = 'Specifies the bill-to state code of the customer on the sales document.';
                    ApplicationArea = All;
                }
                field("GST Ship-to State Code"; Rec."GST Ship-to State Code")
                {
                    ToolTip = 'Specifies the ship-to state code of the customer on the sales document.';
                    ApplicationArea = All;
                }
                field("Location State Code"; Rec."Location State Code")
                {
                    ToolTip = 'Specifies the sate code mentioned of the location used on the sales document.';
                    ApplicationArea = All;
                }
                field("Nature of Supply"; Rec."Nature of Supply")
                {
                    ToolTip = 'Specifies the nature of GST transaction. For example, B2B/B2C.';
                    ApplicationArea = All;
                }
                field("GST Customer Type"; Rec."GST Customer Type")
                {
                    ToolTip = 'Specifies the type of the customer. For example, Registered, Unregistered, Export etc..';
                    ApplicationArea = All;
                }
                field("GST Without Payment of Duty"; Rec."GST Without Payment of Duty")
                {
                    ToolTip = 'Specifies if the invoice is a GST invoice with or without payment of duty.';
                    ApplicationArea = All;
                }
                field("Invoice Type"; Rec."Invoice Type")
                {
                    ToolTip = 'Specifies the Invoice type as per GST law.';
                    ApplicationArea = All;
                }
                field("Bill Of Export No."; Rec."Bill Of Export No.")
                {
                    ToolTip = 'Specifies the bill of export number. It is a document number which is submitted to custom department .';
                    ApplicationArea = All;
                }
                field("Bill Of Export Date"; Rec."Bill Of Export Date")
                {
                    ToolTip = 'Specifies the entry date defined in bill of export document.';
                    ApplicationArea = All;
                }
                field("E-Commerce Customer"; Rec."E-Commerce Customer")
                {
                    ToolTip = 'Specifies the customer number for which merchant id has to be recorded.';
                    ApplicationArea = All;
                }
                // field("E-Commerce Merchant Id"; Rec."E-Comm. Merchant Id")
                // {
                //     ToolTip = 'Specifies the merchant ID provided to customers by their payment processor.';
                //     ApplicationArea = All;
                // }
                field("E-Comm. Merchant Id"; Rec."E-Comm. Merchant Id")
                {
                    ToolTip = 'Specifies the merchant ID provided to customers by their payment processor.';
                    ApplicationArea = All;
                }
                field("E-Way Bill No."; Rec."E-Way Bill No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the E-Way Bill No.';
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Transport Method';
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ToolTip = 'Specifies the vehicle number on the sales document.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vehicle Type"; Rec."Vehicle Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Vehicle Type';
                }
                field("Distance (Km)"; Rec."Distance (Km)")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Distance (Km)';
                }
                field("Acknowledgement No."; REc."Acknowledgement No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Acknowledgement No.';
                    Visible = false;
                }
                field("Acknowledgement Date"; Rec."Acknowledgement Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Acknowledgement Date';
                    Visible = false;
                }
                field("IRN Hash"; Rec."IRN Hash")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the IRN Hash';
                    Visible = false;
                }
                field("E-Inv. Cancelled Date"; Rec."E-Inv. Cancelled Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the E-Inv. Cancelled Date';
                    Visible = false;
                }
                field("Cancel Reason"; Rec."Cancel Reason")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Cancel Reason';
                    Visible = false;
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
                SubPageLink = "Table ID" = const(Database::"Sales Invoice Header"),
                              "No." = field("No.");
            }
            part(TaxInformation; "Tax Information Factbox")
            {
                Provider = SalesInvLines;
                SubPageLink = "Table ID Filter" = const(113), "Document No. Filter" = field("Document No."), "Line No. Filter" = field("Line No.");
                ApplicationArea = All;
            }

            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = all;
                Visible = false;
                ShowFilter = false;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = all;
                Visible = true;
            }
            // part("LFS QR Codes"; "LFS Sales Invoice QR Code")
            // {
            //     Caption = 'QR Code';
            //     SubPageLink = "No." = field("No.");
            //     ApplicationArea = Basic, Suite;
            // }
        }
    }
    actions
    {
        area(navigation)
        {

            group(IRN)
            {

                action("Generate IRN")
                {
                    ApplicationArea = Basic, Suite;
                    Image = UpdateDescription;
                    ToolTip = 'Specifies the function which will generate IRN No.';
                    trigger OnAction()
                    var
                        eInvoiceManagement: Codeunit "e-Invoice Management";
                    begin
                        if eInvoiceManagement.IsGSTApplicable(Rec."No.", Database::"Sales Header") then begin
                            if Rec."GST Customer Type" in
                               [Rec."GST Customer Type"::Unregistered,
                                Rec."GST Customer Type"::" "]
                            then
                                Error(eInvoiceNotApplicableCustomerErr);

                            Clear(eInvoiceManagement);
                            eInvoiceManagement.GenerateIRN(Rec."No.", Database::"Sales Invoice Header");
                            CurrPage.Update();
                        end else
                            Error(eInvoiceNonGSTTransactionErr);
                    end;
                }
                action("Cancel E-Invoice")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Cancel;
                    ToolTip = 'Specifies the function through which cancelled Json file will be generated.';
                    trigger OnAction()
                    var
                        SalesInvHeader: Record "Sales Invoice Header";
                        eInvoiceJsonHandler: Codeunit "e-Invoice Json Handler";
                        eInvoiceManagement: Codeunit "e-Invoice Management";
                    begin
                        Rec.TestField("IRN Hash");
                        Rec.TestField("Cancel Reason");

                        if eInvoiceManagement.IsGSTApplicable(Rec."No.", Database::"Sales Invoice Header") then begin
                            SalesInvHeader.Reset();
                            SalesInvHeader.SetRange("No.", Rec."No.");
                            if SalesInvHeader.FindFirst() then begin
                                Clear(eInvoiceJsonHandler);
                                SalesInvHeader.Mark(true);
                                eInvoiceJsonHandler.SetSalesInvHeader(SalesInvHeader);
                                eInvoiceJsonHandler.GenerateCanceledInvoice();
                            end;
                        end else
                            Error(eInvoiceNonGSTTransactionErr);
                    end;
                }
            }


            group("&Invoice")
            {
                Caption = '&Invoice';
                Image = Invoice;
                action(Statistics)
                {
                    ApplicationArea = Suite;
                    Caption = 'Statistics';
                    Image = Statistics;
                    RunObject = Page "Sales Invoice Statistics";
                    RunPageLink = "No." = field("No.");
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';
                }
                action("Co&mments")
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
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
                separator(Action171)
                {
                }
                action(ChangePaymentService)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Change Payment Service';
                    Image = ElectronicPayment;
                    ToolTip = 'Change or add the payment service, such as PayPal Standard, that will be included on the sales document so the customer can quickly access the payment site.';
                    Visible = PaymentServiceVisible;

                    trigger OnAction()
                    var
                        PaymentServiceSetup: Record "Payment Service Setup";
                    begin
                        PaymentServiceSetup.ChangePaymentServicePostedInvoice(Rec);
                    end;
                }
            }
            group(ActionGroupCRM)
            {
                Caption = 'Dynamics 365 Sales';
                Visible = CRMIntegrationEnabled;
                action(CRMGotoInvoice)
                {
                    ApplicationArea = Suite;
                    Caption = 'Invoice';
                    Enabled = CRMIsCoupledToRecord;
                    Image = CoupledSalesInvoice;
                    ToolTip = 'Open the coupled Dynamics 365 Sales invoice.';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowCRMEntityFromRecordID(Rec.RecordId);
                    end;
                }
                action(CreateInCRM)
                {
                    ApplicationArea = Suite;
                    Caption = 'Create Invoice in Dynamics 365 Sales';
                    Enabled = NOT CRMIsCoupledToRecord;
                    Image = NewSalesInvoice;
                    ToolTip = 'Create a sales invoice in Dynamics 365 Sales that is connected to this posted sales invoice.';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.CreateNewRecordsInCRM(Rec.RecordId);
                    end;
                }
                action(ShowLog)
                {
                    ApplicationArea = Suite;
                    Caption = 'Synchronization Log';
                    Image = Log;
                    ToolTip = 'View integration synchronization jobs for the posted sales invoice table.';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowLog(Rec.RecordId);
                    end;
                }
            }
            group("EXIM actions")
            {
                Caption = 'EXIM';

                // action("LFS Dispatch Tax Invoice Export")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Dispatch Tax Invoice Export';
                //     ToolTip = 'Dispatch Tax Invoice Export';
                //     Image = Report;
                //     Visible = true;
                //     trigger OnAction()
                //     var
                //         SalesInvHeader: Record "Sales Invoice Header";
                //         DispatchTaxInvReport: Report "LFS DISPATCH TAX INV DOMESTIC";
                //     begin
                //         Clear(DispatchTaxInvReport);
                //         SalesInvHeader.Reset();
                //         SalesInvHeader.SetRange("No.", Rec."No.");
                //         if SalesInvHeader.FindFirst() then begin
                //             DispatchTaxInvReport.SetTableView(SalesInvHeader);
                //             DispatchTaxInvReport.RunModal();
                //         end;
                //     end;
                // }

                // action("Custom Invoice Report")
                // {
                //     ApplicationArea = All;
                //     Image = Report;
                //     Caption = 'Custom Invoice Report';
                //     ToolTip = 'Specifies the Custom Invoice Report';
                //     trigger OnAction()
                //     var
                //         SalesInvHeader: Record "Sales Invoice Header";
                //         CustomInvoice: Report "LFS Custom Invoice";
                //     begin
                //         Clear(CustomInvoice);
                //         SalesInvHeader.Reset();
                //         SalesInvHeader.SETRANGE(SalesInvHeader."No.", Rec."No.");
                //         CustomInvoice.SetTableView(SalesInvHeader);
                //         CustomInvoice.RunModal();
                //     end;
                // }
                // action("Custom Packing List Report")
                // {
                //     ApplicationArea = All;
                //     Image = Report;
                //     Caption = 'Custom Packing List';
                //     ToolTip = 'Specifies the Custom Packing List';
                //     trigger OnAction()
                //     var
                //         SalesInvHeader: Record "Sales Invoice Header";
                //         CustomPackingList: Report "LFS Custom Packing List New";
                //     begin
                //         Clear(CustomPackingList);
                //         SalesInvHeader.Reset();
                //         SalesInvHeader.SETRANGE(SalesInvHeader."No.", Rec."No.");
                //         CustomPackingList.SetTableView(SalesInvHeader);
                //         CustomPackingList.RunModal();
                //     end;
                // }
                // action("Commercial Invoice New")
                // {
                //     ApplicationArea = All;
                //     Image = Report;
                //     Caption = 'Commercial Invoice';
                //     ToolTip = 'Specifies the Commercial Invoice';
                //     trigger OnAction()
                //     var
                //         SalesInvHeader: Record "Sales Invoice Header";
                //         CommercialInv: Report "Commercial Invoice New";
                //     begin
                //         Clear(CommercialInv);
                //         SalesInvHeader.Reset();
                //         SalesInvHeader.SETRANGE(SalesInvHeader."No.", Rec."No.");
                //         CommercialInv.SetTableView(SalesInvHeader);
                //         CommercialInv.RunModal();
                //     end;
                // }
                // action("Final Packing List Report")
                // {
                //     ApplicationArea = All;
                //     Image = Report;
                //     Caption = 'Final Packing List';
                //     ToolTip = 'Specifies the Final Packing List Report';
                //     trigger OnAction()
                //     var
                //         SalesInvHeader: Record "Sales Invoice Header";
                //         FinalPackingList: Report "Final Packing List New";
                //     begin
                //         Clear(FinalPackingList);
                //         SalesInvHeader.Reset();
                //         SalesInvHeader.SETRANGE(SalesInvHeader."No.", Rec."No.");
                //         FinalPackingList.SetTableView(SalesInvHeader);
                //         FinalPackingList.RunModal();
                //     end;
                // }
                action("Export_Information")
                {
                    ApplicationArea = all;
                    Caption = 'Export Information';
                    ToolTip = 'Specifies the Export Information';
                    Image = View;
                    trigger OnAction()
                    var
                        Export: Record "LFS Posted Export Information";
                        exportInfor: Page "LFS Posted Export Information";
                    begin
                        export.SetRange("LFS Document Type", Export."LFS Document Type"::Invoice);
                        Export.SetRange("LFS Document No.", Rec."No.");
                        exportInfor.SetTableView(Export);
                        if Page.RunModal(Page::"LFS Posted Export Information", Export) = action::LookupOK then;
                    end;
                }
                // action("Commercial_Invoice_Report")
                // {
                //     ApplicationArea = All;
                //     Image = Report;
                //     Caption = 'Commercial Invoice Report';

                //     trigger OnAction()
                //     var
                //         SalesInvHeader: Record "Sales Invoice Header";
                //         CommercialInvoicePstExpInvReport: Report "LFSCommercialInv-PstdExpInv";
                //     begin
                //         Clear(CommercialInvoicePstExpInvReport);
                //         SalesInvHeader.Reset();
                //         SalesInvHeader.SETRANGE(SalesInvHeader."No.", Rec."No.");
                //         CommercialInvoicePstExpInvReport.SetTableView(SalesInvHeader);
                //         CommercialInvoicePstExpInvReport.RunModal();
                //     end;
                // }
                // action("Custom_Invoice_Report")
                // {
                //     ApplicationArea = All;
                //     Image = Report;
                //     Caption = 'Custom Invoice Report';
                //     trigger OnAction()
                //     var
                //         SalesInvHeader: Record "Sales Invoice Header";
                //         CustomInvoiceReport: Report "LFS Custom Invoice Report";
                //     begin
                //         Clear(CustomInvoiceReport);
                //         SalesInvHeader.Reset();
                //         SalesInvHeader.SETRANGE(SalesInvHeader."No.", Rec."No.");
                //         CustomInvoiceReport.SetTableView(SalesInvHeader);
                //         CustomInvoiceReport.RunModal();
                //     end;
                // }
                // action("Commercial_Packing_List_Report")
                // {
                //     ApplicationArea = All;
                //     Image = Report;
                //     Caption = 'Commercial Packing List Report';
                //     trigger OnAction()
                //     var
                //         SalesInvHeader: Record "Sales Invoice Header";
                //         CommercialPackingListReport: Report "LFSCommercialPackList-PosExInv";
                //     begin
                //         Clear(CommercialPackingListReport);
                //         SalesInvHeader.Reset();
                //         SalesInvHeader.SETRANGE(SalesInvHeader."No.", Rec."No.");
                //         CommercialPackingListReport.SetTableView(SalesInvHeader);
                //         CommercialPackingListReport.RunModal();
                //     end;
                // }
                // action("Custom_Packing_List")
                // {
                //     ApplicationArea = All;
                //     CaptionML = ENU = 'Custom Packing List', ENN = 'Custom Packing List';
                //     Image = Report;
                //     trigger OnAction()
                //     var
                //         SalesInvHeader: Record "Sales Invoice Header";
                //     begin
                //         SalesInvHeader.SetRange("No.", Rec."No.");
                //         if SalesInvHeader.FindFirst() then
                //             Report.RunModal(81209, true, true, SalesInvHeader);
                //     end;

                // }
                // action("Trading_Invoice")
                // {
                //     ApplicationArea = All;
                //     Image = Report;
                //     Caption = 'GST Invoice';
                //     trigger OnAction()
                //     var
                //         SalesInvHeader: Record "Sales Invoice Header";
                //         PostedTradingInvoice: Report "LFS Posted Trading Invoice";
                //     begin
                //         Clear(PostedTradingInvoice);
                //         SalesInvHeader.Reset();
                //         SalesInvHeader.SETRANGE(SalesInvHeader."No.", Rec."No.");
                //         PostedTradingInvoice.SetTableView(SalesInvHeader);
                //         PostedTradingInvoice.RunModal();
                //     end;
                // }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("&Track Package")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Track Package';
                    Image = ItemTracking;
                    ToolTip = 'Open the shipping agent''s tracking page to track the package. ';

                    trigger OnAction()
                    begin
                        Rec.StartTrackingSite();
                    end;
                }
            }
            action(SendCustom)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send';
                Ellipsis = true;
                Image = SendToMultiple;
                ToolTip = 'Prepare to send the document according to the customer''s sending profile, such as attached to an email. The Send document to window opens first so you can confirm or select a sending profile.';

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    SalesInvHeader := Rec;
                    CurrPage.SetSelectionFilter(SalesInvHeader);
                    SalesInvHeader.SendRecords();
                end;
            }
            action(Print)
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';
                Visible = NOT IsOfficeAddin;

                trigger OnAction()
                // var
                //     IsHandled: Boolean;
                begin
                    SalesInvHeader := Rec;
                    CurrPage.SetSelectionFilter(SalesInvHeader);
                    SalesInvHeader.PrintRecords(true);
                end;
            }
            action(Email)
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Email';
                Image = Email;
                ToolTip = 'Prepare to email the document. The Send Email window opens prefilled with the customer''s email address so you can add or edit information.';

                trigger OnAction()
                begin
                    SalesInvHeader := Rec;
                    CurrPage.SetSelectionFilter(SalesInvHeader);
                    SalesInvHeader.EmailRecords(true);
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
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    SalesInvoiceHeader := Rec;
                    SalesInvoiceHeader.SetRecFilter();
                    Rec.PrintToDocumentAttachment(SalesInvoiceHeader);
                end;
            }
            action("&Navigate")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Find entries...';
                Image = Navigate;
                ShortCutKey = 'Ctrl+Alt+Q';
                AboutTitle = 'Get detailed posting details';
                AboutText = 'Here, you can look up the ledger entries that were created when this invoice was posted, as well as any related documents.';
                ToolTip = 'Find entries and documents that exist for the document number and posting date on the selected document. (Formerly this action was named Navigate.)';
                Visible = NOT IsOfficeAddin;

                trigger OnAction()
                begin
                    Rec.Navigate();
                end;
            }
            action(ActivityLog)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Activity Log';
                Image = Log;
                ToolTip = 'View the status and any errors if the document was sent as an electronic document or OCR file through the document exchange service.';

                trigger OnAction()
                begin
                    Rec.ShowActivityLog();
                end;
            }
            action("Update Document")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Update Document';
                Image = Edit;
                ToolTip = 'Add new information that is relevant to the document, such as a payment reference. You can only edit a few fields because the document has already been posted.';

                trigger OnAction()
                var
                    PostedSalesInvUpdate: Page "Posted Sales Inv. - Update";
                begin
                    PostedSalesInvUpdate.LookupMode := true;
                    PostedSalesInvUpdate.SetRec(Rec);
                    PostedSalesInvUpdate.RunModal();
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
            group(Correct)
            {
                Caption = 'Correct';
                action(CorrectInvoice)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Correct';
                    Image = Undo;
                    AboutTitle = 'Correct an invoice';
                    AboutText = 'if you have to make adjustments to this invoice, you can post a correction or cancel the invoice entirely. In both cases, a credit memo is created to represent the adjustment you make.';
                    ToolTip = 'Reverse this posted invoice. A credit memo will be created and matched with the invoice, and the invoice will be canceled. Shipments for the invoice will be reversed. To create a new invoice with the same information, use the Copy function. When you copy an invoice, remember to post shipments for the new invoice.';
                    Visible = not Rec.Cancelled;

                    trigger OnAction()
                    var
                        CorrectPstdSalesInvYesNo: Codeunit "Correct PstdSalesInv (Yes/No)";
                    begin
                        if CorrectPstdSalesInvYesNo.CorrectInvoice(Rec) then
                            CurrPage.Close();
                    end;
                }
                action(CancelInvoice)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel';
                    Image = Cancel;
                    ToolTip = 'Create and post a sales credit memo that reverses this posted sales invoice. This posted sales invoice will be canceled.';
                    Visible = not Rec.Cancelled;

                    trigger OnAction()
                    var
                        CancelPstdSalesInvYesNo: Codeunit "Cancel PstdSalesInv (Yes/No)";
                    begin
                        if CancelPstdSalesInvYesNo.CancelInvoice(Rec) then
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
                        SalesHeader: Record "Sales Header";
                        CorrectPostedSalesInvoice: Codeunit "Correct Posted Sales Invoice";
                    // IsHandled: Boolean;
                    begin
                        if CorrectPostedSalesInvoice.CreateCreditMemoCopyDocument(Rec, SalesHeader) then begin
                            PAGE.Run(PAGE::"Sales Credit Memo", SalesHeader);
                            CurrPage.Close();
                        end;
                    end;
                }
                action(ShowCreditMemo)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show Canceled/Corrective Credit Memo';
                    Image = CreditMemo;
                    ToolTip = 'Open the posted sales credit memo that was created when you canceled the posted sales invoice. if the posted sales invoice is the result of a canceled sales credit memo, then the canceled sales credit memo will open.';
                    Visible = Rec.Cancelled or Rec.Corrective;

                    trigger OnAction()
                    begin
                        Rec.ShowCanceledOrCorrCrMemo();
                    end;
                }
            }
            group(Invoice)
            {
                Caption = 'Invoice';
                Image = Invoice;
                action(Customer)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer';
                    Image = Customer;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = field("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or edit detailed information about the customer.';
                }
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
                group(Category_Category5)
                {
                    Caption = 'Correct', Comment = 'Generated from the PromotedActionCategories property index 4.';
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
                actionref("&Navigate_Promoted"; "&Navigate")
                {
                }
                actionref("&Track Package_Promoted"; "&Track Package")
                {
                }
                actionref(ChangePaymentService_Promoted; ChangePaymentService)
                {
                }
            }
            group(Category_Category6)
            {
                Caption = 'Print/Send', Comment = 'Generated from the PromotedActionCategories property index 5.';

                actionref(Print_Promoted; Print)
                {
                }
                actionref(Email_Promoted; Email)
                {
                }
                actionref(AttachAsPDF_Promoted; AttachAsPDF)
                {
                }
                actionref(SendCustom_Promoted; SendCustom)
                {
                }
            }
            group(Category_Category4)
            {
                Caption = 'Invoice', Comment = 'Generated from the PromotedActionCategories property index 3.';

                actionref(Dimensions_Promoted; Dimensions)
                {
                }
                actionref(Statistics_Promoted; Statistics)
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
                actionref(ActivityLog_Promoted; ActivityLog)
                {
                }
                separator(Navigate_Separator)
                {
                }
                actionref(Customer_Promoted; Customer)
                {
                }
            }
            group("Category_Incoming Document")
            {
                Caption = 'Incoming Document';

                actionref(SelectIncomingDoc_Promoted; SelectIncomingDoc)
                {
                }
                actionref(IncomingDocAttachFile_Promoted; IncomingDocAttachFile)
                {
                }
                actionref(IncomingDocCard_Promoted; IncomingDocCard)
                {
                }
            }
            group(Category_Category8)
            {
                Caption = 'EXIM';
                actionref(Export_Information_Promoted; Export_Information)
                { }
                // actionref(Commercial_Invoice_Report_Promoted; Commercial_Invoice_Report)
                // { }
                // actionref(Custom_Invoice_Report_Promoted; Custom_Invoice_Report)
                // { }
                // actionref(Commercial_Packing_List_Promoted; Commercial_Packing_List_Report)
                // { }
                // actionref(Custom_Packing_List_Promoted; Custom_Packing_List)
                // { }
                // actionref(Trading_Invoice_Promoted; Trading_Invoice)
                // { }
                // actionref(DispatchTaxInvoiceDomestic; "LFS Dispatch Tax Invoice Export")
                // {
                // }
                // actionref(Custom_Invoice_Report_Promoted; "Custom Invoice Report")
                // { }
                // actionref(Custom_Packing_List_Promoted; "Custom Packing List Report")
                // { }
                // actionref(Commercial_Packing_List_Promoted; "Commercial Invoice New")
                // {
                // }
                // actionref(Final_Packing_List_Promoted; "Final Packing List Report")
                // {
                // }
            }
            group(Category_Category7)
            {
                Caption = 'Navigate', Comment = 'Generated from the PromotedActionCategories property index 6.';
            }
            group(Category_Report)
            {
                Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';
            }
            group(Category_Synchronize)
            {
                Caption = 'Synchronize';
                Visible = CRMIntegrationEnabled;

                actionref(CreateInCRM_Promoted; CreateInCRM)
                {
                }
                actionref(CRMGotoInvoice_Promoted; CRMGotoInvoice)
                {
                }
                actionref(ShowLog_Promoted; ShowLog)
                {
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        PaymentServiceSetup: Record "Payment Service Setup";
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        OfficeMgt: Codeunit "Office Management";
    begin
        Rec.SetSecurityFilterOnRespCenter();
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled();
        PaymentServiceVisible := PaymentServiceSetup.IsPaymentServiceVisible();
        IsOfficeAddin := OfficeMgt.IsAvailable();
    end;

    trigger OnAfterGetRecord()
    begin
        DocExchStatusStyle := Rec.GetDocExchStatusStyle();
    end;

    trigger OnAfterGetCurrRecord()
    var
        IncomingDocuments: Record "Incoming Document";
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
    begin
        HasIncomingDocument := IncomingDocuments.PostedDocExists(Rec."No.", Rec."Posting Date");
        DocExchStatusStyle := Rec.GetDocExchStatusStyle();
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CRMIsCoupledToRecord := CRMIntegrationEnabled AND CRMCouplingManagement.IsRecordCoupledToCRM(Rec.RECORDID);

    end;

    var

        SalesInvHeader: Record "Sales Invoice Header";


        ChangeExchangeRate: Page "Change Exchange Rate";
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        HasIncomingDocument: Boolean;
        IsOfficeAddin: Boolean;
        // SalesInvoiceHeader: Record "Sales Invoice Header";
        PaymentServiceVisible: Boolean;
        eInvoiceNonGSTTransactionErr: Label 'E-Invoicing is not applicable for Non-GST Transactions.';
        eInvoiceNotApplicableCustomerErr: Label 'E-Invoicing is not applicable for Unregistered, Export and Deemed Export Customers.';
        DocExchStatusStyle: Text;
}