namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.History;
using Microsoft.Sales.Comment;
using Microsoft.Utilities;
using Microsoft.Integration.Dataverse;
using Microsoft.EServices.EDocument;
using Microsoft.Foundation.Attachment;

page 72073 "LFS Posted Export Invoices"
{
    ApplicationArea = All;
    Caption = 'Posted Export Invoices';
    PageType = List;
    SourceTable = "Sales Invoice Header";
    UsageCategory = History;
    PromotedActionCategories = 'New,Process,Report,Invoice,Navigate';
    SourceTableView = where("LFS EXIM Type" = const(Export));
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the record.';
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer the invoice concerns.';
                    ApplicationArea = All;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Bill-to Name';
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ToolTip = 'Specifies the customer''s name.';
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the currency code of the invoice.';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the total amount on the sales invoice excluding VAT.';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        Rec.SETRANGE("No.");
                        PAGE.RUNMODAL(PAGE::"Posted Sales Invoice", Rec)
                    end;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ToolTip = 'Specifies the total amount on the sales invoice including VAT.';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        Rec.SETRANGE("No.");
                        PAGE.RUNMODAL(PAGE::"Posted Sales Invoice", Rec)
                    end;
                }
                // field("FOB Amount (FCY) LFSPL"; Rec."LFS FOB Amount (FCY) LFSPL")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the FOB Amount (FCY)';
                // }
                // field("FOB Amount (LCY)"; Rec."LFS FOB Amount (LCY)")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the FOB Amount (LCY)';
                // }
                // field("CIF Amount (FCY)"; Rec."LFS CIF Amount (FCY)")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the CIF Amount (FCY)';
                // }
                // field("CIF Amount (LCY)"; Rec."LFS CIF Amount (LCY)")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the CIF Amount (LCY)';
                // }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ToolTip = 'Specifies the postal code.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    ToolTip = 'Specifies the address country/region.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Order No."; Rec."Order No.")
                {
                    ToolTip = 'Specifies the number of the sales order that this invoice was posted from.';
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Transport Method';
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ToolTip = 'Specifies the name of the person you regularly contact when you communicate with the customer to whom the invoice was sent.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies the address on purchase orders shipped with a drop shipment directly from the vendor to a customer.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTip = 'Specifies the name of the customer that the items were shipped to.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ToolTip = 'Specifies the postal code.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country or region of the address.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ToolTip = 'Specifies the name of the person you regularly contact at the address that the items were shipped to.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the external document number that is entered on the sales header that this line was posted from.';
                    ApplicationArea = All;
                }
                field("GST Customer Type"; Rec."GST Customer Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the GST Customer Type';
                }
                field("GST Without Payment of Duty"; Rec."GST Without Payment of Duty")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the GST Without Payment of Duty';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the date on which the invoice was posted.';
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Specifies which salesperson is associated with the invoice.';
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Customer Posting Group';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the code for the location from which the items were shipped.';
                    ApplicationArea = All;
                    Visible = true;
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    ToolTip = 'Specifies how many times the document has been printed.';
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies when the posted sales invoice was created.';
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the sales document.';
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies when the posted sales invoice must be paid.';
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ToolTip = 'Specifies the payment discount percent granted if payment is made on or before the date in the Pmt. Discount Date field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ToolTip = 'Specifies the code that represents the shipment method for the invoice.';
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ToolTip = 'Specifies when items on the document are shipped or were shipped. A shipment date is usually calculated from a requested delivery date plus lead time.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Invoice Type"; Rec."Invoice Type")
                {
                    ToolTip = 'Specifies the Invoice type as per GST law.';
                    ApplicationArea = All;
                }
                field("Bill Of Export No."; REc."Bill Of Export No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Bill Of Export No.';
                }
                field("Bill Of Export Date"; Rec."Bill Of Export Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Bill Of Export Date';
                }
                field("GST Bill-to State Code"; Rec."GST Bill-to State Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the GST Bill-to State Code';
                }
                field("GST Ship-to State Code"; Rec."GST Ship-to State Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the GST Ship-to State Code';
                }
                field("Location State Code"; Rec."Location State Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Location State Code';
                }
                field("GST Reason Type"; rec."GST Reason Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the GST Reason Type';
                }
                field("Location GST Reg. No."; Rec."Location GST Reg. No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Location GST Reg. No.';
                }
                field("Customer GST Reg. No."; Rec."Customer GST Reg. No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Customer GST Reg. No.';
                }
                field("Ship-to GST Reg. No."; Rec."Ship-to GST Reg. No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Ship-to GST Reg. No.';
                }
                field("Distance (Km)"; Rec."Distance (Km)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Distance (Km)';
                }
                field("Vehicle Type"; Rec."Vehicle Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Vehicle Type';
                }
                field("E-Way Bill No."; Rec."E-Way Bill No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the E-Way Bill No.';
                }
                field(State; Rec.State)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the State';
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Vehicle No.';
                }
                field("Ship-to Customer"; Rec."Ship-to Customer")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Ship-to Customer';
                }
                field("Acknowledgement No."; Rec."Acknowledgement No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Acknowledgement No.';
                }
                field("IRN Hash"; Rec."IRN Hash")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the IRN Hash';
                }
                field("Acknowledgement Date"; Rec."Acknowledgement Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Acknowledgement Date';
                }
                field("E-Inv. Cancelled Date"; Rec."E-Inv. Cancelled Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the E-Inv. Cancelled Date';
                }
                field("Cancel Reason"; Rec."Cancel Reason")
                {
                    ToolTip = 'Specifies the Cancel Reason';
                    ApplicationArea = all;
                }
                field("Time of Removal"; Rec."Time of Removal")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Time of Removal';
                }
                field("Mode of Transport"; Rec."Mode of Transport")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Mode of Transport';
                }
                field("Port of Loading"; Rec."LFS Port of Loading")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the Port of Loading ';
                }
                field("Port of Discharge"; Rec."LFS Port of Discharge")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Port of Discharge';
                }
                field("Country of Final Destination"; Rec."LFS Country Fin Destination")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Country of Final Destination';
                }
                field("Final Destination"; Rec."LFS Final Destination")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Final Destination';
                }
                field("Country of Origin of Goods"; Rec."LFS Country Origin of Goods")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Country of Origin of Goods';
                }
                field("Inco Terms"; Rec."LFS Inco Terms")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Inco Terms';
                }
                field("Export Remark"; Rec."LFS Export Remark")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Batch Code';
                    Editable = false;
                    Caption = 'Batch Code';
                }
                field("Shipping Bill No."; Rec."LFS Shipping Bill No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Shipping Bill No.';
                }
                field("Shipping Bill Date"; Rec."LFS Shipping Bill Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Shipping Bill Date';
                }
                field("Pre Carriage"; Rec."LFS Pre Carriage")
                {
                    ToolTip = 'Specifies the Pre Carriage';
                    ApplicationArea = all;
                }
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
                // field("Late export order No."; Rec."LFS Late export order No.")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the Late export order No.';
                // }
                // field("Late export order date"; Rec."LFS Late export order date")
                // {
                //     ToolTip = 'Specifies the Late export order date';
                //     ApplicationArea = all;
                // }
                // field("DDB Value"; Rec."LFS DDB Value")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the DDB Value';
                // }
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
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = all;
                ShowFilter = false;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("&Invoice")
            {
                Caption = '&Invoice';
                Image = Invoice;
                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = EditLines;
                    ToolTip = 'Specifies the Card';
                    trigger OnAction()
                    begin
                        PAGE.RUN(PAGE::"Posted Sales Invoice", Rec)
                    end;
                }
                action(Statistics)
                {
                    ApplicationArea = All;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ShortcutKey = F7;
                    RunObject = page "Sales Invoice Statistics";
                    RunPageLink = "No." = field("No.");
                    ToolTip = 'Specifies the Statistics';
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = const("Posted Invoice"), "No." = field("No.");
                    ToolTip = 'Specifies the Comments';
                }

                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ShortcutKey = 'Shift+Ctrl+D';
                    ToolTip = 'Specifies the Dimensions';
                    trigger OnAction()
                    begin
                        Rec.ShowDimensions();
                    end;
                }
                action(IncomingDoc)
                {
                    ApplicationArea = All;
                    Caption = 'Incoming Document';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Specifies the Incoming Document';
                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        IncomingDocument.ShowCard(Rec."No.", Rec."Posting Date");
                    end;
                }
            }
            group(ActionGroupCRM)
            {
                Caption = 'Dynamics CRM';
                Visible = CRMIntegrationEnabled;
                action(CRMGotoInvoice)
                {
                    ApplicationArea = All;
                    Caption = 'Invoice';
                    Enabled = CRMIsCoupledToRecord;
                    ToolTip = 'Open the coupled Microsoft Dynamics CRM account.';
                    Image = CoupledInvoice;

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowCRMEntityFromRecordID(Rec.RECORDID);
                    end;
                }
            }
        }
        area(Navigation)
        {
            action(SendCustom)
            {
                ApplicationArea = All;
                Caption = 'Send';
                Image = SendToMultiple;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Ellipsis = true;
                ToolTip = 'Specifies the Send';
                trigger OnAction()
                begin
                    SalesInvHeader := Rec;
                    CurrPage.SETSELECTIONFILTER(SalesInvHeader);
                    SalesInvHeader.SendRecords();
                end;
            }
            action(Print)
            {
                ApplicationArea = All;
                Caption = '&Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                Ellipsis = true;
                ToolTip = 'Specifies the Print';
                trigger OnAction()
                begin
                    SalesInvHeader := Rec;
                    CurrPage.SETSELECTIONFILTER(SalesInvHeader);
                    SalesInvHeader.PrintRecords(true);
                end;
            }
            action(Email)
            {
                ApplicationArea = All;
                Caption = '&Email';
                Image = Email;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Specifies the Email';
                trigger OnAction()
                begin
                    SalesInvHeader := Rec;
                    CurrPage.SETSELECTIONFILTER(SalesInvHeader);
                    SalesInvHeader.EmailRecords(true);
                end;
            }
            action(Navigate)
            {
                ApplicationArea = All;
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ToolTip = 'Specifies the Navigate';
                trigger OnAction()
                begin
                    Rec.Navigate();
                end;
            }
            action(ActivityLog)
            {
                ApplicationArea = All;
                Caption = 'Activity Log';
                Image = Log;
                ToolTip = 'Specifies the Activity Log';
                trigger OnAction()
                var
                    ActivityLog: Record "Activity Log";
                begin
                    ActivityLog.ShowEntries(Rec.RECORDID);
                end;
            }
        }
    }
    // SalesInvoiceHeader: Record "Sales Invoice Header";
    // LicenseNo: Code[20];
    // ShipmentNo: Code[20];


    trigger OnOpenPage()
    var
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
    begin
        Rec.SetSecurityFilterOnRespCenter();
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled();
    end;

    trigger OnAfterGetRecord()
    // var
    //     SalesInvLineRec: Record "Sales Invoice Line";
    begin
        DocExchStatusStyle := Rec.GetDocExchStatusStyle();

        // Rec.CalcFields(Amount);
        // if (Rec."Shipment Method Code" = 'FOB') or (Rec."Shipment Method Code" = 'EXW') then
        //     Rec."LFS CIF Amount (FCY)" := Rec.Amount;
    end;

    trigger OnAfterGetCurrRecord()
    var
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
    begin
        DocExchStatusStyle := Rec.GetDocExchStatusStyle();
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CRMIsCoupledToRecord := CRMIntegrationEnabled AND CRMCouplingManagement.IsRecordCoupledToCRM(Rec.RECORDID);
    end;

    var
        SalesInvHeader: Record "Sales Invoice Header";
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        DocExchStatusStyle: Text;

    // local procedure ShowInvoiceTypeDoc(InvoiceType: Option Taxable,"Bill of Supply",Export,Supplementary,"Debit Notes")
    // begin
    //     Rec.SETRANGE(Rec."Invoice Type", InvoiceType);
    //     if Rec.Findset() then
    //         PAGE.RUN(PAGE::"Posted Sales Invoices", Rec);
    // end;
}