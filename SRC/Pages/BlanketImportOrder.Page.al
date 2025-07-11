namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.Document;
using Microsoft.Purchases.Vendor;
using Microsoft.Utilities;
using Microsoft.Finance.Currency;
using System.Security.User;
using System.Automation;

page 72086 "LFS Blanket Import Order"
{
    ApplicationArea = All;
    Caption = 'Blanket Import Order';
    PageType = Document;
    SourceTable = "Purchase Header";
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Process,Report,Approve';
    SourceTableView = where("Document Type" = filter("Blanket Order"));
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
                    ToolTip = 'Specifies the subcontracting order number.';
                    ApplicationArea = All;
                    Visible = DocNoVisible;
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
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
                field("Order Date"; Rec."Order Date")
                {
                    ToolTip = 'Specifies the order date of the document.';
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the document date of the document.';
                    ApplicationArea = All;
                }
                field("Vendor Order No."; Rec."Vendor Order No.")
                {
                    ToolTip = 'Specifies the vendor order number.';
                    ApplicationArea = All;
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ToolTip = 'Specifies the vendor order address, if any.';
                    ApplicationArea = All;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ToolTip = 'Specifies the assigned purchaser from the organization.';
                    ApplicationArea = All;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    ToolTip = 'Specifies the campaign number the document is linked to.';
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the responsibility center for the document.';
                    ApplicationArea = All;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ToolTip = 'Specifies the user id assigned to the document.';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the status of the document.';
                    ApplicationArea = All;
                }
            }
            part(PurchLines; "LFS EXIMBlanketImpOrderSubform")
            {
                ApplicationArea = all;
                SubPageLink = "Document No." = field("No.");
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
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ToolTip = 'Specifies the discount on payment, if any.';
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ToolTip = 'Specifies the discount amount of the payment as per discount percentage.';
                    ApplicationArea = All;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ToolTip = 'Specifies the method of payment.';
                    ApplicationArea = All;
                }
                field("On Hold"; Rec."On Hold")
                {
                    ToolTip = 'Specifies whether the document is on hold or not.';
                    ApplicationArea = All;
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ToolTip = 'Specifies if the Unit Price and Line Amount fields on document lines should be shown with or without VAT.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        PricesIncludingVATOnAfterValid();
                    end;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ToolTip = 'Specifies the VAT specification of the involved customer or vendor to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.';
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
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location code used in the document.';
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ToolTip = 'Specifies the shipment method code used in the document.';
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ToolTip = 'Specifies the date of expected receipt of the material.';
                    ApplicationArea = All;
                }
            }
            group("Foreign Trade")
            {
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the foreign currency code used in the document.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE();
                        PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);
                    end;

                    trigger OnAssistEdit()
                    begin
                        CLEAR(ChangeExchangeRate);
                        ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WORKDATE());
                        if ChangeExchangeRate.RUNMODAL() = ACTION::OK then begin
                            rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter());
                            CurrPage.UPDATE();
                        end;
                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("Custom Currency Code"; Rec."LFS Custom Currency Code")
                {
                    ToolTip = 'Specifies the value of the Custom Currency Code field.';
                    ApplicationArea = All;
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
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the transaction type of the document.';
                    ApplicationArea = All;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ToolTip = 'Specifies the transaction specification if any.';
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ToolTip = 'Specifies the transportation method mentioned in the document.';
                    ApplicationArea = All;
                }
                field("Entry Point"; Rec."Entry Point")
                {
                    ToolTip = 'Specifies the entry point.';
                    ApplicationArea = All;
                }
                field("Area"; Rec."Area")
                {
                    ToolTip = 'Specifies the area of the document.';
                    ApplicationArea = All;
                }
            }
            group("Tax Information")
            {
                field(Trading; Rec.Trading)
                {
                    ToolTip = 'Specifies the value of the Trading field.';
                    ApplicationArea = All;
                }
                field("Nature of Supply"; Rec."Nature of Supply")
                {
                    ToolTip = 'Specifies the nature of GST transaction. For example, B2B/B2C.';
                    ApplicationArea = All;
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
            }
            group("Import Order Management")
            {
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
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ToolTip = 'Specifies the vendor invoice number.';
                    ApplicationArea = All;
                }
            }
            group(EXIM)
            {
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
            }
        }
        area(FactBoxes)
        {
            part("Pending Approval FactBox"; "Pending Approval FactBox")
            {
                ApplicationArea = all;
                Visible = OpenApprovalEntriesExistForCurrUser;
                SubPageLink = "Table ID" = const(38), "Document Type" = field("Document Type"), "Document No." = field("No.");
            }
            part(ApprovalFactBox; "Approval FactBox")
            {
                ApplicationArea = all;
                Visible = false;
            }
            part("Vendor Details FactBox"; "Vendor Details FactBox")
            {
                ApplicationArea = all;
                Visible = true;
                SubPageLink = "No." = field("Buy-from Vendor No.");
            }
            part("Vendor Statistics FactBox"; "Vendor Statistics FactBox")
            {
                ApplicationArea = all;
                Visible = true;
                SubPageLink = "No." = field("Pay-to Vendor No.");
            }
            part("Purchase Line FactBox"; "Purchase Line FactBox")
            {
                ApplicationArea = all;
                Visible = false;
                Provider = PurchLines;
                SubPageLink = "Document Type" = field("Document Type"), "No." = field("No."), "Line No." = field("Line No.");
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = all;
                Visible = ShowWorkflowStatus;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = all;
                Visible = true;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if UserMgt.GetPurchasesFilter() <> '' then begin
            rec.FILTERGROUP(2);
            rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());
            rec.FILTERGROUP(0);
        end;

        SetDocNoVisible();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();
        rec."LFS EXIM Type" := rec."LFS EXIM Type"::Import;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD();
        EXIT(Rec.ConfirmDeletion());
    end;

    trigger OnAfterGetCurrRecord()
    begin
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RECORDID);
        CurrPage.ApprovalFactBox.PAGE.RefreshPage(Rec.RECORDID);
    end;

    var
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        UserMgt: Codeunit "User Setup Management";
        ChangeExchangeRate: Page "Change Exchange Rate";
        ChangeCustomExchangeRate: Page "LFSChange Custom Exchange Rate";
        DocNoVisible: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        ShowWorkflowStatus: Boolean;



    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        if Rec.GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." then
            if Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." then
                Rec.SETRANGE("Buy-from Vendor No.");
        CurrPage.UPDATE();
    end;



    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.Update();
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.Update();
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);
        //OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
    end;

    local procedure SetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
        DocType: Option Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::"Blanket Order", Rec."No.");
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(true);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(true);
    end;
}