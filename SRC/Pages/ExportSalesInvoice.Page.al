namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.Document;
using Microsoft.Purchases.Vendor;
using Microsoft.Sales.Comment;
using Microsoft.CRM.Outlook;
using Microsoft.Finance.GeneralLedger.Posting;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Sales.History;
using Microsoft.Sales.Setup;
using Microsoft.Finance.Currency;
using Microsoft.Foundation.Address;
using System.Security.User;
using Microsoft.Utilities;
using Microsoft.Foundation.Reporting;
using Microsoft.Foundation.Enums;
using Microsoft.Sales.Posting;
using Microsoft.Sales.Pricing;
using Microsoft.Purchases.Document;
using Microsoft.Intercompany;
using Microsoft.Finance.Dimension;
using Microsoft.Projects.Resources.Resource;
using Microsoft.EServices.EDocument;
using Microsoft.Inventory.Item;
using System.Automation;
using Microsoft.Foundation.Attachment;
using Microsoft.Finance.TaxEngine.TaxTypeHandler;
using Microsoft.Finance.GST.Sales;
using Microsoft.Sales.Customer;

page 72055 "LFS Export Sales Invoice"
{
    ApplicationArea = All;
    Caption = 'Export Sales Invoice';
    PageType = Document;
    SourceTable = "Sales Header";
    RefreshOnActivate = true;
    SourceTableView = where("Document Type" = filter(Invoice), "LFS EXIM Type" = const(Export));
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
                    ToolTip = 'Specifies the number of the estimate.';
                    ApplicationArea = All;
                    Importance = Promoted;
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEditExport(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer who will receive the products and be billed by default.';
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Importance = Promoted;
                    trigger OnValidate()
                    begin
                        SelltoCustomerNoOnAfterValidat();
                    end;
                }
                field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                {
                    ToolTip = 'Specifies the number of the contact person at the customer.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if Rec.GETFILTER("Sell-to Contact No.") = xRec."Sell-to Contact No." then
                            if Rec."Sell-to Contact No." <> xRec."Sell-to Contact No." then
                                Rec.SETRANGE("Sell-to Contact No.");
                    end;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ToolTip = 'Specifies the customer''s name.';
                    ApplicationArea = All;
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    ToolTip = 'Specifies the address where the customer is located.';
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ToolTip = 'Specifies the postal code.';
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ToolTip = 'Specifies the address city.';
                    ApplicationArea = All;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ToolTip = 'Specifies the name of the contact person at the customer.';
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location from where inventory items to the customer on the sales document are to be shipped by default.';
                    ApplicationArea = All;
                    // trigger OnValidate()
                    // begin
                    //     SetLocGSTRegNoEditable();
                    // end;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV();
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV();
                    end;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the date when the posting of the sales document will be recorded.';
                    ApplicationArea = All;
                    Importance = Promoted;
                    trigger OnValidate()
                    var
                        SalesLine: Record "Sales Line";
                    begin
                        CurrPage.Update(true);
                        SalesLine.SetRange("Document No.", Rec."No.");
                        SalesLine.SetRange("Document Type", Rec."Document Type");
                        if SalesLine.FindSet() then
                            repeat
                                SalesLine.CalculateRoDTEPandDDB();
                            until SalesLine.Next() = 0;
                    end;
                    // trigger OnValidate()
                    // var
                    //     Salesline: Record "Sales Line";
                    //     salesline2: record "Sales Line";
                    //     ddbsetup: record "LFS EXIM DDB Rate Setup";
                    //     rodtepsetup: record "LFS EXIM RoDTEP Rate Setup";
                    // begin
                    //     Salesline.SetRange("Document Type", Rec."Document Type");
                    //     Salesline.SetRange("Document No.", Rec."No.");
                    //     if Salesline.Findset() then
                    //         repeat
                    //             salesline.validate("LFS Freight Value (FCY)");
                    //             Salesline.validate("LFS Insurance Value (FCY)");
                    //             if (Salesline."LFS Incentive Type" = Salesline."LFS Incentive Type"::DDB) and (Salesline.type = salesline.type::item) then begin
                    //                 ddbSetup.SETfilter("LFS Starting Date", '<=%1', rec."Posting Date");
                    //                 ddbSetup.SETRANGE("LFS Item Code", Salesline."No.");
                    //                 ddbSetup.SETRANGE("LFS Unit of Measure Code", Salesline."Unit of Measure Code");
                    //                 ddbsetup.SetCurrentKey("LFS Starting Date");
                    //                 if ddbSetup.FindLast() then begin
                    //                     salesline2.Reset();
                    //                     salesline2.SetRange("Document Type", Salesline."Document Type");
                    //                     salesline2.SetRange("Document No.", Salesline."Document No.");
                    //                     salesline2.setrange("Line No.", Salesline."Line No.");
                    //                     if salesline2.FindFirst() then begin
                    //                         salesline2."LFS DDB Rate" := ddbSetup."LFS DDB Rate";
                    //                         salesline2."LFS DDB Value (LCY)" := (Salesline."LFS FOB Amount (LCY)" - Salesline."LFS Freight Value (LCY)" - salesline."LFS Insurance Value (LCY)") * ddbSetup."LFS DDB Rate" / 100;
                    //                         Salesline2.Modify();
                    //                     end;
                    //                 end
                    //                 else   +
                    //                     if Salesline."HSN/SAC Code" <> '' then begin
                    //                         ddbSetup.SETfilter("LFS Starting Date", '<=%1', rec."Posting Date");
                    //                         ddbSetup.SETRANGE("LFS HSN No.", Salesline."HSN/SAC Code");
                    //                         ddbSetup.SETRANGE("LFS Unit of Measure Code", Salesline."Unit of Measure Code");
                    //                         ddbsetup.SetCurrentKey("LFS Starting Date");
                    //                         if ddbSetup.FindLast() then begin
                    //                             salesline2.Reset();
                    //                             salesline2.SetRange("Document Type", Salesline."Document Type");
                    //                             salesline2.SetRange("Document No.", Salesline."Document No.");
                    //                             salesline2.setrange("Line No.", Salesline."Line No.");
                    //                             if salesline2.FindFirst() then begin
                    //                                 salesline2."LFS DDB Rate" := ddbSetup."LFS DDB Rate";
                    //                                 salesline2."LFS DDB Value (LCY)" := (Salesline."LFS FOB Amount (LCY)" - Salesline."LFS Freight Value (LCY)" - salesline."LFS Insurance Value (LCY)") * ddbSetup."LFS DDB Rate" / 100;
                    //                                 Salesline2.Modify();
                    //                             end;
                    //                         end;
                    //                     end;  

                    //                 rodtepsetup.SetFilter("LFS Starting Date", '<=%1', Rec."Posting Date");
                    //                 rodtepsetup.setrange("LFS Item Code", Salesline."No.");
                    //                 rodtepsetup.setfilter(LFS block, '<>%1', true);
                    //                 rodtepsetup.SetCurrentKey("LFS Starting Date");
                    //                 if rodtepsetup.FindLast() then begin
                    //                     salesline2.Reset();
                    //                     salesline2.SetRange("Document Type", Salesline."Document Type");
                    //                     salesline2.SetRange("Document No.", Salesline."Document No.");
                    //                     salesline2.setrange("Line No.", Salesline."Line No.");
                    //                     if salesline2.FindFirst() then begin
                    //                         salesline2."LFS RoDTEP Rebate Rate %" := rodtepsetup."LFS RoDTEP Rebate Rate %";
                    //                         salesline2."LFS RoDTEP Rebate Value" := (Salesline."LFS FOB Amount (LCY)" - Salesline."LFS Freight Value (LCY)" - Salesline."LFS Insurance Value (LCY)") * rodtepsetup."LFS RoDTEP Rebate Rate %" / 100;
                    //                         Salesline2.Modify();
                    //                     end;
                    //                 end
                    //                 else
                    //                     if Salesline."HSN/SAC Code" <> '' then begin   
                    //                         rodtepsetup.SetFilter("LFS Starting Date", '<=%1', Rec."Posting Date");
                    //                         rodtepsetup.setrange("LFS HSN No.", Salesline."HSN/SAC Code");
                    //                         rodtepsetup.setfilter(LFS block, '<>%1', true);
                    //                         rodtepsetup.SetCurrentKey("LFS Starting Date");
                    //                         if rodtepsetup.FindLast() then begin
                    //                             salesline2.Reset();
                    //                             salesline2.SetRange("Document Type", Salesline."Document Type");
                    //                             salesline2.SetRange("Document No.", Salesline."Document No.");
                    //                             salesline2.setrange("Line No.", Salesline."Line No.");
                    //                             if salesline2.FindFirst() then begin
                    //                                 salesline2."LFS RoDTEP Rebate Rate %" := rodtepsetup."LFS RoDTEP Rebate Rate %";
                    //                                 salesline2."LFS RoDTEP Rebate Value" := (Salesline."LFS FOB Amount (LCY)" - Salesline."LFS Freight Value (LCY)" - Salesline."LFS Insurance Value (LCY)") * rodtepsetup."LFS RoDTEP Rebate Rate %" / 100;
                    //                                 Salesline2.Modify();
                    //                             end;
                    //                         end
                    //                     end;  
                    //             end;
                    //         until Salesline.Next() = 0;
                    // end;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies when the sales invoice was created.';
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                    Caption = 'Invoice Date';
                    ToolTip = 'Specifies the date when the order was created.';
                }
                field("Incoming Document Entry No."; Rec."Incoming Document Entry No.")
                {
                    ToolTip = 'Specifies the number of the incoming document that this sales document is created for.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Caption = 'Customer Order No.';
                    ToolTip = 'Specifies a document number that refers to the customer''s or vendor''s numbering system.';
                    ApplicationArea = All;
                    ShowMandatory = ExternalDocNoMandatory;
                    Importance = Promoted;
                }

                field("Your Reference Date"; Rec."LFS Your Reference Date")
                {
                    ApplicationArea = all;
                    Caption = 'Customer Order Date';
                    ToolTip = 'Specifies the Reference Date';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount.';
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies when the sales invoice must be paid.';
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Specifies the name of the salesperson who is assigned to the customer.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        SalespersonCodeOnAfterValidate();
                    end;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies whether the document is open, waiting to be approved, has been invoiced for prepayment, or has been released to the Next() stage of processing.';
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Posting No. Series"; Rec."Posting No. Series")
                {
                    ToolTip = 'Specifies the value of the Posting No. Series field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Posting No."; rec."Posting No.")
                {
                    ApplicationArea = All;
                    Visible = true;
                    ToolTip = 'Specifies the Posting No.';
                }
                field("Shortcut Dim Update"; rec."LFS Shortcut Dim Update")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shortcut Dim Update';
                }
                field(Carrier; REc."LFS Carrier")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Carrier';
                }
                field("Your Reference"; Rec."Your Reference")//sv
                {
                    ApplicationArea = all;
                    Caption = 'Other Reference';
                    ToolTip = 'Specifies the Other Reference';
                }

                field("DDB Value"; Rec."LFS DDB Value")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the DDB Value';
                }
                field("FOB Amount (FCY) LFSPL"; Rec."LFS FOB Amount (FCY) LFSPL")
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

                field("Commission Agent"; Rec."LFS Commission Agent")
                {
                    ApplicationArea = all;
                    TableRelation = Vendor."No.";
                    ToolTip = 'Specifies the Commission Agent';
                }
                field("Comm. Amount"; Rec."LFS Comm. Amount")
                {
                    ApplicationArea = all;
                    MinValue = 0;
                    ToolTip = 'Specifies the Comm. Amount';
                }
                field("LFS Commission %"; Rec."LFS Commission %")
                {
                    ApplicationArea = all;
                    MinValue = 0;
                    ToolTip = 'Specifies the Commission %';
                }
                field("LFS Type"; Rec."LFS FOB CIF Calc. Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Type';
                }
                group("Work Description")
                {
                    Caption = 'Work Description';
                    field(WorkDescription; WorkDescription)
                    {
                        ApplicationArea = all;
                        Importance = Additional;
                        MultiLine = true;
                        Caption = 'Work Description';
                        ToolTip = 'Specifies the products or service being offered';
                        trigger OnValidate()
                        begin
                            Rec.SetWorkDescription(WorkDescription);
                        end;
                    }
                }
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
                field("Late export order No."; Rec."LFS Late export order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Late export order No.';

                }
                field("Late export order date"; Rec."LFS Late export order date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Late export order date';
                }
                field("Bill No."; Rec."LFS Bill No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Bill No.';
                }
                field("Bill Date"; Rec."LFS Bill Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Bill Date';
                }
            }
            part(SalesLines; "LFS Export Sales Inv. Subform")
            {
                ApplicationArea = all;
                SubPageLink = "Document No." = field("No."), "Document Type" = field("Document Type");
            }
            group(EXIM)
            {
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the currency that is used on the entry.';
                    ApplicationArea = All;
                    Importance = Promoted;
                    Visible = false;
                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE();
                        SalesCalcDiscountByType.ApplyDefaultInvoiceDiscount(0, Rec);
                    end;

                    trigger OnAssistEdit()
                    begin
                        CLEAR(ChangeExchangeRate);
                        if Rec."Posting Date" <> 0D then
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date")
                        else
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WORKDATE());
                        if ChangeExchangeRate.RUNMODAL() = ACTION::OK then begin
                            Rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter());
                            CurrPage.UPDATE();
                        end;
                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("Custom Currency Code"; Rec."LFS Custom Currency Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Custom Currency Code';
                    trigger OnValidate()
                    begin
                        rec.Validate("Currency Code", Rec."LFS Custom Currency Code");
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
                    ApplicationArea = All;
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
                field("Shipping Line"; Rec."LFS Shipping Line")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Shipping Line';
                }
                field("Customs Bank Account"; Rec."LFS Customs Bank Account")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Customs Bank Account';
                }
                field("Commercial Bank Account"; Rec."LFS Commercial Bank Account")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Commercial Bank Account';
                }
                // field("Export Remark"; Rec."LFS Export Remark")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Batch Code';
                //     ToolTip = 'Specifies the Batch Code';
                // }
                field("Pre Carriage"; Rec."LFS Pre Carriage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Pre Carriage';
                }
                field("LFSPlaceofReceiptPre-Carriage"; Rec."LFSPlaceofReceiptPre-Carriage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Place of Receipt By Pre-Carriage';
                }
                field(ETA; Rec."LFS ETA")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the ETA';
                }
                field(ETD; Rec."LFS ETD")
                {
                    ApplicationArea = all;
                    Caption = 'EDD';
                    ToolTip = 'Specifies the EDD';
                }
                field("FTT No."; Rec."LFS FTT No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the FTT No.';
                }
                field("FTT Date"; Rec."LFS FTT Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the FTT Date';
                }
                field("BIN No."; Rec."LFS BIN No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the BIN No.';
                }
            }
            group(Invoicing)
            {
                Visible = false;
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer that you send or sent the invoice or credit memo to.';
                    ApplicationArea = All;
                    Importance = Promoted;
                    trigger OnValidate()
                    begin
                        BilltoCustomerNoOnAfterValidat();
                    end;
                }
                field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                {
                    ToolTip = 'Specifies the number of the contact person at the billing address.';
                    ApplicationArea = All;

                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ToolTip = 'Specifies the customer to whom you will send the invoice, when different from the customer that you are selling to.';
                    ApplicationArea = All;
                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    ToolTip = 'Specifies the address of the customer that you will send the invoice to.';
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                    ToolTip = 'Specifies an additional part of the billing address.';
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ToolTip = 'Specifies the postal code of the billing address.';
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                    ToolTip = 'Specifies the city of the billing address.';
                    ApplicationArea = All;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ToolTip = 'Specifies the name of the contact person at the billing address';
                    ApplicationArea = All;
                    Importance = Additional;
                }
            }
            group(Shipping)
            {
                // CaptionML = ENU = 'Shipping', ENN = 'Shipping';
                // field("Ship-to Code"; Rec."Ship-to Code")
                // {
                //     ToolTip = 'Specifies the code for another shipment address than the customer''s own address, which is entered by default.';
                //     ApplicationArea = All;
                //     Importance = Promoted;
                // }
                // field("Ship-to Name"; Rec."Ship-to Name")
                // {
                //     ToolTip = 'Specifies the name that products on the sales document will be shipped to.';
                //     ApplicationArea = All;
                // }
                // field("Ship-to Address"; Rec."Ship-to Address")
                // {
                //     ToolTip = 'Specifies the address that products on the sales document will be shipped to. By default, the field is filled with the value in the Address field on the customer card or with the value in the Address field in the Ship-to Address window.';
                //     ApplicationArea = All;
                //     Importance = Additional;
                // }
                // field("Ship-to Address 2"; Rec."Ship-to Address 2")
                // {
                //     ToolTip = 'Specifies an additional part of the shipping address.';
                //     ApplicationArea = All;
                //     Importance = Additional;
                // }
                // field("Ship-to Post Code"; Rec."Ship-to Post Code")
                // {
                //     ToolTip = 'Specifies the postal code of the shipping address.';
                //     ApplicationArea = All;
                //     Importance = Additional;
                // }
                // field("Ship-to City"; Rec."Ship-to City")
                // {
                //     ToolTip = 'Specifies the city of the shipping address.';
                //     ApplicationArea = All;
                // }
                // field("Ship-to Contact"; Rec."Ship-to Contact")
                // {
                //     ToolTip = 'Specifies the name of the contact person at the address that products on the sales document will be shipped to.';
                //     ApplicationArea = All;
                //     Importance = Additional;
                // }
                // field("Shipment Method Code"; Rec."Shipment Method Code")
                // {
                //     ToolTip = 'Specifies how items on the sales document are shipped to the customer.';
                //     ApplicationArea = All;
                // }
                // field("Shipping Agent Code"; Rec."Shipping Agent Code")
                // {
                //     ToolTip = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.';
                //     ApplicationArea = All;
                // }
                // field("Package Tracking No."; Rec."Package Tracking No.")
                // {
                //     ToolTip = 'Specifies the shipping agent''s package number.';
                //     ApplicationArea = All;
                //     Importance = Additional;
                // }
                // field("Shipment Date"; Rec."Shipment Date")
                // {
                //     ToolTip = 'Specifies when items on the document are shipped or were shipped. A shipment date is usually calculated from a requested delivery date plus lead time.';
                //     ApplicationArea = All;
                //     Importance = Promoted;
                // }
                // field("Time of Removal"; Rec."Time of Removal")
                // {
                //     ApplicationArea = all;
                //     CaptionML = ENU = 'Time of Removal', ENN = 'Time of Removal';
                // }
                // field("Mode of Transport"; Rec."Mode of Transport")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                //     CaptionML = ENU = 'Mode of Transport', ENN = 'Mode of Transport';
                // }
                // field("Transport Method"; Rec."Transport Method")
                // {
                //     ApplicationArea = all;
                // }
                Caption = 'Shipping and Billing';

                group(Control91)
                {
                    ShowCaption = false;
                    group(Control90)
                    {
                        ShowCaption = false;
                        field(ShippingOptions; ShipToOptions)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Ship-to';
                            ToolTip = 'Specifies the address that the products on the sales document are shipped to. Default (Sell-to Address): The same as the customer''s sell-to address. Alternate Ship-to Address: One of the customer''s alternate ship-to addresses. Custom Address: Any ship-to address that you specify in the fields below.';

                            trigger OnValidate()
                            var
                                ShipToAddress: Record "Ship-to Address";
                                ShipToAddressList: Page "Ship-to Address List";
                                IsHandled: Boolean;
                            begin
                                IsHandled := false;
                                if IsHandled then
                                    exit;
                                Clear(IsShipToCountyVisible);
                                case ShipToOptions of
                                    ShipToOptions::"Default (Sell-to Address)":
                                        begin
                                            Rec.Validate("Ship-to Code", '');
                                            Rec.CopySellToAddressToShipToAddress();
                                        end;
                                    ShipToOptions::"Alternate Shipping Address":
                                        begin
                                            ShipToAddress.SetRange("Customer No.", Rec."Sell-to Customer No.");
                                            ShipToAddressList.LookupMode := true;
                                            ShipToAddressList.SetTableView(ShipToAddress);

                                            if ShipToAddressList.RunModal() = ACTION::LookupOK then begin
                                                ShipToAddressList.GetRecord(ShipToAddress);
                                                Rec.Validate("Ship-to Code", ShipToAddress.Code);
                                                IsShipToCountyVisible := FormatAddress.UseCounty(ShipToAddress."Country/Region Code");
                                            end else
                                                ShipToOptions := ShipToOptions::"Custom Address";
                                        end;
                                    ShipToOptions::"Custom Address":
                                        begin
                                            Rec.Validate("Ship-to Code", '');
                                            IsShipToCountyVisible := FormatAddress.UseCounty(Rec."Ship-to Country/Region Code");
                                        end;
                                end;
                            end;
                        }
                        group(Control4)
                        {
                            ShowCaption = false;
                            Visible = not (ShipToOptions = ShipToOptions::"Default (Sell-to Address)");
                            field("Ship-to Code"; Rec."Ship-to Code")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Code';
                                Editable = ShipToOptions = ShipToOptions::"Alternate Shipping Address";
                                Importance = Promoted;
                                ToolTip = 'Specifies the code for another shipment address than the customer''s own address, which is entered by default.';

                                trigger OnValidate()
                                var
                                    ShipToAddress: Record "Ship-to Address";
                                begin
                                    if (xRec."Ship-to Code" <> '') and (Rec."Ship-to Code" = '') then
                                        Error(EmptyShipToCodeErr);
                                    if Rec."Ship-to Code" <> '' then begin
                                        ShipToAddress.Get(Rec."Sell-to Customer No.", Rec."Ship-to Code");
                                        IsShipToCountyVisible := FormatAddress.UseCounty(ShipToAddress."Country/Region Code");
                                    end else
                                        IsShipToCountyVisible := false;
                                end;
                            }
                            field("Ship-to Name"; Rec."Ship-to Name")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Name';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                ToolTip = 'Specifies the name that products on the sales document will be shipped to.';
                            }
                            field("Ship-to Address"; Rec."Ship-to Address")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Address';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                QuickEntry = false;
                                ToolTip = 'Specifies the address that products on the sales document will be shipped to.';
                            }
                            field("Ship-to Address 2"; Rec."Ship-to Address 2")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Address 2';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                QuickEntry = false;
                                ToolTip = 'Specifies additional address information.';
                            }
                            field("Ship-to City"; Rec."Ship-to City")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'City';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                QuickEntry = false;
                                ToolTip = 'Specifies the city of the customer on the sales document.';
                            }
                            group(Control297)
                            {
                                ShowCaption = false;
                                field("Ship-to County"; Rec."Ship-to County")
                                {
                                    ApplicationArea = Basic, Suite;
                                    Caption = 'County';
                                    Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                    QuickEntry = false;
                                    ToolTip = 'Specifies the state, province or county of the address.';
                                }
                            }
                            field("Ship-to Post Code"; Rec."Ship-to Post Code")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Post Code';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                QuickEntry = false;
                                ToolTip = 'Specifies the postal code.';
                            }
                            field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Country/Region';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                                QuickEntry = false;
                                ToolTip = 'Specifies the customer''s country/region.';
                            }
                        }
                        field("Ship-to Contact"; Rec."Ship-to Contact")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Contact';
                            ToolTip = 'Specifies the name of the contact person at the address that products on the sales document will be shipped to.';
                        }
                    }
                    group("Shipment Method")
                    {
                        Caption = 'Shipment Method';
                        field("Shipment Method Code"; Rec."Shipment Method Code")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Code';
                            Importance = Additional;
                            ToolTip = 'Specifies how items on the sales document are shipped to the customer.';
                        }
                        field("Shipping Agent Code"; Rec."Shipping Agent Code")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Agent';
                            Importance = Additional;
                            ToolTip = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.';
                        }
                        field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Agent Service';
                            Importance = Additional;
                            ToolTip = 'Specifies the code that represents the default shipping agent service you are using for this sales order.';
                        }
                        field("Package Tracking No."; Rec."Package Tracking No.")
                        {
                            ApplicationArea = Suite;
                            Importance = Additional;
                            ToolTip = 'Specifies the shipping agent''s package number.';
                        }
                    }
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = all;
                    Caption = 'Vehicle No.';
                    ToolTip = 'Specifies the Vehicle No.';
                }
                field("Vehicle Type"; Rec."Vehicle Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Vehicle Type';
                }
                field("Distance (Km)"; Rec."Distance (Km)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Distance (Km)';
                }
                field("Exit Point"; Rec."Exit Point")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Exit Point';
                    trigger OnValidate()
                    begin
                        Rec."LFS Port of Loading" := Rec."Exit Point";
                    end;
                }
                field("Bill Of Export No."; Rec."Bill Of Export No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bill of export number. It is a document number which is submitted to custom department .';
                }
                field("Bill Of Export Date"; Rec."Bill Of Export Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the entry date defined in bill of export document.';
                }
            }
            group(Application)
            {
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the type of the posted document that this document line will be applied to.';
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the posted document that this document line will be applied to.';
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the ID of the entries of the entries that will be applied to when you choose the Apply entries Action.';
                }
            }
            group("Tax Information")
            {
                Caption = 'Tax Information';
                field("GST Bill-to State Code"; Rec."GST Bill-to State Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the GST Bill-to State Code';
                    // Visible = false;
                }
                field("GST Ship-to State Code"; Rec."GST Ship-to State Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the GST Ship-to State Code';
                    // Visible = false;
                }
                field("Location State Code"; Rec."Location State Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Location State Code';
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
                    // Visible = false;
                }
                field("Ship-to GST Reg. No."; Rec."Ship-to GST Reg. No.")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the Ship-to GST Reg. No.';
                    // Visible = false;
                }
                field("Nature of Supply"; Rec."Nature of Supply")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Nature of Supply';
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
                    trigger OnValidate()
                    var
                        GSTSalesValidation: Codeunit "GST Sales Validation";
                    begin
                        CurrPage.SaveRecord();
                        GSTSalesValidation.CallTaxEngineOnSalesHeader(Rec);
                    end;
                }
                field("Invoice Type"; Rec."Invoice Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Invoice Type';
                }
                field("E-Commerce Customer"; Rec."E-Commerce Customer")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the E-Commerce Customer';
                    // Visible = false;
                }
                // field("E-Commerce Merchant Id"; Rec."E-Comm. Merchant Id")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the E-Commerce Merchant Id';
                //     // Visible = false;
                // }
                field("E-Comm. Merchant Id"; Rec."E-Comm. Merchant Id")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the customer number for which merchant id has to be recorded.';
                }
                field("Reference Invoice No."; Rec."Reference Invoice No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the Reference Invoice number.';
                }
                field("GST Invoice"; Rec."GST Invoice")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if GST is applicable.';
                }
                field("POS Out Of India"; Rec."POS Out Of India")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if the place of supply of invoice is out of India.';

                    trigger OnValidate()
                    var
                        GSTSalesValidation: Codeunit "GST Sales Validation";
                    begin
                        GSTSalesValidation.CallTaxEngineOnSalesHeader(Rec);
                    end;
                }
                field("Ship-to GST Customer Type"; Rec."Ship-to GST Customer Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the type of the customer. For example, Registered/Unregistered/Export etc.';
                }
                field("Rate Change Applicable"; Rec."Rate Change Applicable")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if rate change is applicable on the sales document.';
                }
                field("Supply Finish Date"; Rec."Supply Finish Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the supply finish date. For example, Before rate change/After rate change.';
                }
                field("Payment Date"; Rec."Payment Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the payment date. For example, Before rate change/After rate change.';
                }
                field(Trading; Rec.Trading)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if trading is applicable.';
                }
                field("Date of Removal"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Date of Removal';
                    ToolTip = 'Specifies the date of removal.';
                }
                field("Post GST to Customer"; Rec."Post GST to Customer")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if the GST amount post to Customer';
                    trigger OnValidate()
                    var
                        GSTSalesValidation: Codeunit "GST Sales Validation";
                    begin
                        CurrPage.SaveRecord();
                        GSTSalesValidation.CallTaxEngineOnSalesHeader(Rec);
                    end;
                }
                field("IRN Hash"; Rec."IRN Hash")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the IRN Hash field.', Comment = '%';
                }
                field("Acknowledgement No."; Rec."Acknowledgement No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Acknowledgement No. field.', Comment = '%';
                }
                field("Acknowledgement Date"; Rec."Acknowledgement Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Acknowledgement Date field.', Comment = '%';
                }
                field("Cancel Reason"; Rec."Cancel Reason")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cancel Reason field.', Comment = '%';
                }
                field("E-Inv. Cancelled Date"; Rec."E-Inv. Cancelled Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the E-Inv. Cancelled Date Reason field.', Comment = '%';
                }
            }
        }
        area(FactBoxes)
        {
            part(TaxInformation; "Tax Information Factbox")
            {
                Provider = SalesLines;
#pragma warning disable AL0603
                SubPageLink = "Table ID Filter" = const(37), "Document Type Filter" = field("Document Type"), "Document No. Filter" = field("Document No."), "Line No. Filter" = field("Line No.");
#pragma warning restore AL0603
                ApplicationArea = all;
            }
            part("Attached Documents List"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Documents';
                UpdatePropagation = Both;
                SubPageLink = "Table ID" = const(Database::"Sales Header"),
                              "No." = field("No."),
                              "Document Type" = field("Document Type");

            }
            part("Pending Approval FactBox"; "Pending Approval FactBox")
            {
                ApplicationArea = all;
                Visible = OpenApprovalEntriesExistForCurrUser;
                SubPageLink = "Table ID" = const(36), "Document Type" = field("Document Type"), "Document No." = field("No.");
            }
            part("Sales Hist. Sell-to FactBox"; "Sales Hist. Sell-to FactBox")
            {
                ApplicationArea = all;
                Visible = false;
                SubPageLink = "No." = field("Sell-to Customer No.");
            }
            part("Sales Hist. Bill-to FactBox"; "Sales Hist. Bill-to FactBox")
            {
                ApplicationArea = all;
                Visible = false;
                SubPageLink = "No." = field("Bill-to Customer No.");
            }
            part("QR Code"; "LFS Sales Order QR Code")
            {
                Caption = 'QR Code';
                SubPageLink = "No." = field("No.");
                ApplicationArea = Basic, Suite;
            }
            part("Customer Statistics FactBox"; "Customer Statistics FactBox")
            {
                ApplicationArea = all;
                Visible = true;
                SubPageLink = "No." = field("Bill-to Customer No.");
            }
            part("Customer Details FactBox"; "Customer Details FactBox")
            {
                ApplicationArea = all;
                Visible = true;
                SubPageLink = "No." = field("Sell-to Customer No.");
            }
            part("Sales Line FactBox"; "Sales Line FactBox")
            {
                ApplicationArea = all;
                Visible = false;
            }
            part("Item Invoicing FactBox"; "Item Invoicing FactBox")
            {
                ApplicationArea = all;
                Visible = true;
                SubPageLink = "No." = field("No.");
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = all;
                Visible = false;
                ShowFilter = false;
            }
            part(ApprovalFactBox; "Approval FactBox")
            {
                ApplicationArea = all;
                Visible = false;
            }
            part("Resource Details FactBox"; "Resource Details FactBox")
            {
                ApplicationArea = all;
                Visible = false;
                SubPageLink = "No." = field("No.");
            }
            part(WorkFlowStatus; "Workflow Status FactBox")
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
                //     Enabled = Rec."No." <> '';
                //     Image = Statistics;
                //     ShortCutKey = 'F7';
                //     ToolTip = 'View statistical information, such as the value of posted entries, for the record.';

                //     trigger OnAction()
                //     begin
                //         Rec.OpenDocumentStatistics();
                //         CurrPage.SalesLines.Page.ForceTotalsCalculation();
                //     end;
                // }
                action(SalesStatistics)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statistics';
                    Enabled = Rec."No." <> '';
                    Image = Statistics;
                    ShortCutKey = 'F7';
                    Visible = true;
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';
                    RunObject = Page "Sales Statistics";
                    RunPageOnRec = true;
                }
                action("Co&mments")
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = field("Document Type"),
                                  "No." = field("No."),
                                  "Document Line No." = const(0);
                    ToolTip = 'View or add comments for the record.';
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
                        ApprovalsMgmt.OpenApprovalsSales(Rec);
                    end;
                }
                action(Function_CustomerCard)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer';
                    Enabled = IsCustomerOrContactNotEmpty;
                    Image = Customer;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = field("Sell-to Customer No."),
                                  "Date Filter" = field("Date Filter");
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or edit detailed information about the customer on the sales document.';
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
            group("Exim1")
            {
                Caption = 'Exim';
                Image = Action;
                action("Export_Information")
                {
                    ApplicationArea = all;
                    Caption = 'Export Information';
                    ToolTip = 'Export Information';
                    Image = ViewDetails;
                    trigger OnAction()
                    var
                        Export: Record "LFS Export Information Header";
                        exportInfor: Page "LFS Export Information";
                    begin
                        export.SetRange("LFS Document Type", Rec."Document Type");
                        Export.SetRange("LFS Document No.", Rec."No.");
                        exportInfor.SetTableView(Export);
                        Page.RunModal(Page::"LFS Export Information", Export);
                    end;
                }
                // action("LFS Dispatch Tax Invoice Export")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Dispatch Tax Invoice Export';
                //     ToolTip = 'Dispatch Tax Invoice Export';
                //     Image = Report;
                //     Visible = true;
                //     trigger OnAction()
                //     var
                //         SalesHeader: Record "Sales Header";
                //         DispatchTaxInvReport: Report DispatchTaxInvoiceExport;
                //     begin
                //         Clear(DispatchTaxInvReport);
                //         SalesHeader.Reset();
                //         SalesHeader.SetRange("No.", Rec."No.");
                //         if SalesHeader.FindFirst() then begin
                //             DispatchTaxInvReport.SetTableView(SalesHeader);
                //             DispatchTaxInvReport.RunModal();
                //         end;
                //     end;
                // }
                // action("LFS Export Comm. Draft Invoice Report")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Custom Draft Invoice';
                //     ToolTip = 'Specifies the Export Custom Draft Invoice';
                //     Enabled = Rec.Status = Rec.Status::Released;
                //     Image = Report;
                //     trigger OnAction()
                //     var
                //         SalesHeader: Record "Sales Header";
                //         ExportCommDraftInvoice: Report "LFS Export Comm. Draft Invoice";
                //     begin
                //         Clear(ExportCommDraftInvoice);
                //         SalesHeader.SetRange("No.", Rec."No.");
                //         if SalesHeader.FindFirst() then begin
                //             ExportCommDraftInvoice.SetTableView(SalesHeader);
                //             ExportCommDraftInvoice.RunModal();
                //         end;
                //     end;
                // }
                // action("LFS Export Comm. Draft Packing List Report")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Custom Draft Packing List';
                //     ToolTip = 'Specifies the Export Custom Draft Packing List';
                //     Enabled = Rec.Status = Rec.Status::Released;
                //     Image = Report;
                //     trigger OnAction()
                //     var
                //         SalesHeader: Record "Sales Header";
                //         ExportCommDraftPackingList: Report "LFSExport Comm Draft Pack List";
                //     begin
                //         Clear(ExportCommDraftPackingList);
                //         SalesHeader.SetRange("No.", Rec."No.");
                //         if SalesHeader.FindFirst() then begin
                //             ExportCommDraftPackingList.SetTableView(SalesHeader);
                //             ExportCommDraftPackingList.RunModal();
                //         end;
                //     end;
                // }
                // action("LFS Export Draft Invoice Report")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Export Draft Invoice';
                //     ToolTip = 'Export Draft Invoice';
                //     Image = Report;
                //     Visible = false;
                //     trigger OnAction()
                //     var
                //         SalesHeader: Record "Sales Header";
                //         ExportDraftInvoice: Report "LFS Export Draft Invoice";
                //     begin
                //         Clear(ExportDraftInvoice);
                //         SalesHeader.SetRange("No.", Rec."No.");
                //         if SalesHeader.FindFirst() then begin
                //             ExportDraftInvoice.SetTableView(SalesHeader);
                //             ExportDraftInvoice.RunModal();
                //         end;
                //     end;
                // }
                // action("LFS Export Draft Packing List Report")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Export Draft Packing List';
                //     ToolTip = 'Specifies the Export Draft Packing List';
                //     Visible = false;
                //     Image = Report;
                //     trigger OnAction()
                //     var
                //         SalesHeader: Record "Sales Header";
                //         ExportDraftPackingList: Report "LFS Export Draft Packing List";
                //     begin
                //         Clear(ExportDraftPackingList);
                //         SalesHeader.SetRange("No.", Rec."No.");
                //         if SalesHeader.FindFirst() then begin
                //             ExportDraftPackingList.SetTableView(SalesHeader);
                //             ExportDraftPackingList.RunModal();
                //         end;
                //     end;
                // }
                // action("LFS Export Comm. Draft Invoice Report")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Export Custom Draft Invoice';
                //     ToolTip = 'Specifies the Export Custom Draft Invoice';
                //     Enabled = Rec.Status = Rec.Status::Released;
                //     Image = Report;
                //     trigger OnAction()
                //     var
                //         SalesHeader: Record "Sales Header";
                //         ExportCommDraftInvoice: Report "LFS Export Comm. Draft Invoice";
                //     begin
                //         Clear(ExportCommDraftInvoice);
                //         SalesHeader.SetRange("No.", Rec."No.");
                //         if SalesHeader.FindFirst() then begin
                //             ExportCommDraftInvoice.SetTableView(SalesHeader);
                //             ExportCommDraftInvoice.RunModal();
                //         end;
                //     end;
                // }
                // action("LFS Export Comm. Draft Packing List Report")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Export Custom Draft Packing List';
                //     ToolTip = 'Specifies the Export Custom Draft Packing List';
                //     Enabled = Rec.Status = Rec.Status::Released;
                //     Image = Report;
                //     trigger OnAction()
                //     var
                //         SalesHeader: Record "Sales Header";
                //         ExportCommDraftPackingList: Report "LFSExport Comm Draft Pack List";
                //     begin
                //         Clear(ExportCommDraftPackingList);
                //         SalesHeader.SetRange("No.", Rec."No.");
                //         if SalesHeader.FindFirst() then begin
                //             ExportCommDraftPackingList.SetTableView(SalesHeader);
                //             ExportCommDraftPackingList.RunModal();
                //         end;
                //     end;
                // }
            }


            group(History)
            {
                Caption = 'History';
                action(PageInteractionLogEntries)
                {
                    ApplicationArea = Suite;
                    Caption = 'Interaction Log E&ntries';
                    Image = InteractionLog;
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View a list of interaction log entries related to this document.';
                    trigger OnAction()
                    begin
                        Rec.ShowInteractionLogEntries();
                    end;
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
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    trigger OnAction()
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
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
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
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
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
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
            group(Action9)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&lease';
                    Enabled = IsCustomerOrContactNotEmpty;
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Release the document to the Next() stage of processing. You must reopen the document before you can make changes to it.';
                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        DimensionCodeValidation();
                        Rec.TestField(Rec."Posting No.");
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                        CurrPage.SalesLines.PAGE.ClearTotalSalesHeader();
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
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                        CurrPage.SalesLines.PAGE.ClearTotalSalesHeader();
                    end;
                }
                action("Reject IC Sales Invoice")
                {
                    ApplicationArea = Intercompany;
                    Caption = 'Reject IC Sales Invoice';
                    Enabled = RejectICSalesInvoiceEnabled;
                    Image = Cancel;
                    ToolTip = 'Deletes the invoice and sends the rejection to the company that created it.';
                    trigger OnAction()
                    var
                        ICInboxOutboxMgt: Codeunit ICInboxOutboxMgt;
                    begin
                        if not ICInboxOutboxMgt.IsSalesHeaderFromIncomingIC(Rec) then
                            exit;
                        if Confirm(SureToRejectMsg) then
                            ICInboxOutboxMgt.RejectAcceptedSalesHeader(Rec);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(CreatePurchaseInvoice)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create Purchase Invoice';
                    Image = NewPurchaseInvoice;
                    ToolTip = 'Create a new purchase invoice to buy all the items that are required by the sales document, even if some of the items are already available.';
                    trigger OnAction()
                    var
                        SelectedSalesLine: Record "Sales Line";
                        PurchDocFromSalesDoc: Codeunit "Purch. Doc. From Sales Doc.";
                    begin
                        CurrPage.SalesLines.PAGE.SetSelectionFilter(SelectedSalesLine);
                        PurchDocFromSalesDoc.CreatePurchaseInvoice(Rec, SelectedSalesLine);
                    end;
                }
                action(GetRecurringSalesLines)
                {
                    ApplicationArea = Suite;
                    Caption = 'Get Recurring Sales Lines';
                    Ellipsis = true;
                    Enabled = IsCustomerOrContactNotEmpty;
                    Image = CustomerCode;
                    ToolTip = 'Insert sales document lines that you have set up for the customer as recurring. Recurring sales lines could be for a monthly replenishment order or a fixed freight expense.';
                    trigger OnAction()
                    var
                        StdCustSalesCode: Record "Standard Customer Sales Code";
                    begin
                        StdCustSalesCode.InsertSalesLines(Rec);
                    end;
                }
                action(CalculateInvoiceDiscount)
                {
                    AccessByPermission = TableData "Cust. Invoice Disc." = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Calculate &Invoice Discount';
                    Enabled = IsCustomerOrContactNotEmpty;
                    Image = CalculateInvoiceDiscount;
                    ToolTip = 'Calculate the invoice discount for the entire sales document when all sales invoice lines are entered.';
                    trigger OnAction()
                    begin
                        SalesCalcDiscountByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                action(CopyDocument)
                {
                    ApplicationArea = Suite;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Enabled = Rec."No." <> '';
                    Image = CopyDocument;
                    ToolTip = 'Copy document lines and header information from another sales document to this document. You can copy a posted sales invoice into a new sales invoice to quickly create a similar document.';
                    trigger OnAction()
                    begin
                        Rec.CopyDocument();
                        if Rec.Get(Rec."Document Type", Rec."No.") then;
                        CurrPage.SalesLines.Page.ForceTotalsCalculation();
                        CurrPage.Update();
                    end;
                }

                action("Move Negative Lines")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Image = MoveNegativeLines;
                    ToolTip = 'Prepare to create a replacement sales order in a sales return process.';
                    trigger OnAction()
                    begin
                        Clear(MoveNegSalesLines);
                        MoveNegSalesLines.SetSalesHeader(Rec);
                        MoveNegSalesLines.RunModal();
                        MoveNegSalesLines.ShowDocument();
                    end;
                }
                group("Incoming Document")
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
                            IncomingDocument.ShowCardFromEntryNo(Rec."Incoming Document Entry No.");
                        end;
                    }
                    action(SelectIncomingDoc)
                    {
                        AccessByPermission = TableData "Incoming Document" = R;
                        ApplicationArea = Basic, Suite;
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
                            IncomingDocumentAttachment.NewAttachmentFromSalesDocument(Rec);
                        end;
                    }
                    action(RemoveIncomingDoc)
                    {
                        ApplicationArea = Basic, Suite;
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
                    begin
                        DimensionCodeValidation();
                        Rec.TestField(Rec."Posting No.");
                        if ApprovalsMgmt.CheckSalesApprovalPossible(Rec) then
                            ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
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
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'P&ost';
                    Image = PostOrder;
                    ShortCutKey = 'F9';
                    AboutTitle = 'When all is set, you post';
                    AboutText = 'After entering the sales lines and other information, you post the invoice to make it count.? After posting, the sales invoice is moved to the Posted Sales Invoices list.';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';
                    trigger OnAction()
                    begin
                        DimensionCodeValidation();
                        Rec.TestField(Rec."Posting No.");
                        PostDocument(CODEUNIT::"Sales-Post (Yes/No)", Enum::"Navigate After Posting"::"Posted Document");
                    end;
                }
                action(PostAndNew)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post and New';
                    Ellipsis = true;
                    Image = PostOrder;
                    ShortCutKey = 'Alt+F9';
                    ToolTip = 'Post the sales document and create a new, empty one.';
                    trigger OnAction()
                    begin
                        PostDocument(CODEUNIT::"Sales-Post (Yes/No)", Enum::"Navigate After Posting"::"New Document");
                    end;
                }
                action(PostAndSend)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post and &Send';
                    Ellipsis = true;
                    Image = PostSendTo;
                    ToolTip = 'Finalize and prepare to send the document according to the customer''s sending profile, such as attached to an email. The Send document to window opens first so you can confirm or select a sending profile.';
                    trigger OnAction()
                    begin
                        PostDocument(CODEUNIT::"Sales-Post and Send", Enum::"Navigate After Posting"::"Do Nothing");
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
                    begin
                        DimensionCodeValidation();
                        Rec.TestField(Rec."Posting No.");
                        ShowPreview();
                    end;
                }
                action(DraftInvoice)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Draft Invoice';
                    Ellipsis = true;
                    Image = ViewPostedOrder;
                    ToolTip = 'View or print the sales invoice as a draft before you perform the actual posting.';
                    trigger OnAction()
                    var
                        DocumentPrint: Codeunit "Document-Print";
                    begin
                        DocumentPrint.PrintSalesHeader(Rec);
                    end;
                }
                action(ProformaInvoice)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pro Forma Invoice';
                    Ellipsis = true;
                    Image = ViewPostedOrder;
                    ToolTip = 'View or print the pro forma sales invoice.';
                    trigger OnAction()
                    var
                        DocumentPrint: Codeunit "Document-Print";
                    begin
                        DocumentPrint.PrintProformaSalesInvoice(Rec);
                    end;
                }
                action("Test Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';
                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("Remove From Job Queue")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    ToolTip = 'Remove the scheduled processing of this record from the job queue.';
                    trigger OnAction()
                    begin
                        Rec.CancelBackgroundPosting();
                    end;
                }
                action(PrintToAttachment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Attach as PDF';
                    Ellipsis = true;
                    Image = PrintAttachment;
                    ToolTip = 'Create a PDF file and attach it to the document.';
                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                        DocumentPrint: Codeunit "Document-Print";
                    begin
                        SalesHeader := Rec;
                        SalesHeader.SetRecFilter();
                        DocumentPrint.PrintSalesInvoiceToDocumentAttachment(SalesHeader, DocumentPrint.GetSalesInvoicePrintToAttachmentOption(Rec));
                    end;
                }
            }
            group("E-Invoice")
            {
                Caption = 'E-Invoice';
                action("Generate LFS IRN")
                {
                    Caption = 'Generate IRN';
                    Image = RegisteredDocs;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Generate IRN';
                    trigger OnAction();
                    begin
                        Clear(EInvApi);
                        Rec.TestField("IRN Hash", '');

                        EInvApi.GenerateIRN(Rec."No.", 6, Rec."Location GST Reg. No.");
                    end;
                }
                action("Cancel IRN")
                {
                    Image = Cancel;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Cancel IRN';
                    trigger OnAction();
                    begin
                        Clear(EInvApi);
                        rec.TestField("Cancel Reason");
                        EInvApi.CancelIRN(rec."No.", 4, rec."Location GST Reg. No.", Format(rec."Cancel Reason"));
                    end;
                }
                action("Fetch IRN Details")
                {
                    Image = GetSourceDoc;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Fetch IRN Details';
                    trigger OnAction();
                    begin
                        Clear(EInvApi);
                        Rec.TestField("IRN Hash", '');
                        // EInvApi.FetchIRN(rec."No.", 1, rec."Posting Date", Rec."Location GST Reg. No.");
                        EInvApi.FetchIRNExport(rec."No.", 1, rec."Posting Date", Rec."Location GST Reg. No.", Rec."Posting No.");
                    end;
                }
            }
        }


        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';
                group(Category_Category5)
                {
                    Caption = 'Posting', Comment = 'Generated from the PromotedActionCategories property index 4.';
                    ShowAs = SplitButton;
                    actionref(Post_Promoted; Post)
                    {
                    }
                    actionref(PostAndSend_Promoted; PostAndSend)
                    {
                    }
                    actionref(Preview_Promoted; Preview)
                    {
                    }
                    actionref(PostAndNew_Promoted; PostAndNew)
                    {
                    }
                }
                group(Category_Category8)
                {
                    Caption = 'Release', Comment = 'Generated from the PromotedActionCategories property index 7.';
                    ShowAs = SplitButton;
                    actionref(Release_Promoted; Release)
                    {
                    }
                    actionref(Reopen_Promoted; Reopen)
                    {
                    }
                }
            }
            group(Category_Category6)
            {
                Caption = 'Prepare', Comment = 'Generated from the PromotedActionCategories property index 5.';
                actionref(CopyDocument_Promoted; CopyDocument)
                {
                }
                actionref(GetRecurringSalesLines_Promoted; GetRecurringSalesLines)
                {
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
                    actionref(RemoveIncomingDoc_Promoted; RemoveIncomingDoc)
                    {
                    }
                }
                actionref(CalculateInvoiceDiscount_Promoted; CalculateInvoiceDiscount)
                {
                }
                actionref("Move Negative Lines_Promoted"; "Move Negative Lines")
                {
                }
            }
            group(Category_PrintSend)
            {
                Caption = 'Print/Send';
                actionref(DraftInvoice_Promoted; DraftInvoice)
                {
                }
                actionref(ProformaInvoice_Promoted; ProformaInvoice)
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
            group(Category_Category7)
            {
                Caption = 'Invoice', Comment = 'Generated from the PromotedActionCategories property index 6.';
                actionref(Dimensions_Promoted; Dimensions)
                {
                }
                actionref(Statistics_Promoted; SalesStatistics)
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
                actionref(Function_CustomerCard_Promoted; Function_CustomerCard)
                {
                }
            }
            group(Category_Category13)
            {
                Caption = 'EXIM';
                actionref(Export_Information_promoted; Export_Information)
                { }
                // actionref(DispatchTaxInvoiceExport; "LFS Dispatch Tax Invoice Export")
                // {
                // }
                // actionref(ExportDraftInvocie_Promoted; "LFS Export Comm. Draft Invoice Report")
                // {
                // }
                // actionref(ExportDraftPAcking; "LFS Export Comm. Draft Packing List Report")
                // {
                // }
            }
            // group(Category_Category12)
            // {
            // }
            // group(Category_Category10)
            // {
            //     Caption = 'View', Comment = 'Generated from the PromotedActionCategories property index 9.';
            // }
            // group(Category_Category11)
            // {
            //     Caption = 'EXIM', Comment = 'Generated from the PromotedActionCategories property index 10.';
            //     // Caption = '';
            // }
            // group(Category_Report)
            // {
            //     Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';
            // }
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
        if UserMgt.GetSalesFilter() <> '' then begin
            Rec.FILTERGROUP(2);
            Rec.SETRANGE(Rec."Responsibility Center", UserMgt.GetSalesFilter());
            Rec.FILTERGROUP(0);
        end;
        RejectICSalesInvoiceEnabled := ICInboxOutboxMgt.IsSalesHeaderFromIncomingIC(Rec);
    end;

    trigger OnAfterGetRecord()
    var
        ICInboxOutboxMgt: Codeunit ICInboxOutboxMgt;
    begin
        WorkDescription := Rec.GetWorkDescription();
        RejectICSalesInvoiceEnabled := ICInboxOutboxMgt.IsSalesHeaderFromIncomingIC(Rec);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."LFS EXIM Type" := Rec."LFS EXIM Type"::Export;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD();
        EXIT(Rec.ConfirmDeletion());
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RECORDID);
        CurrPage.ApprovalFactBox.PAGE.RefreshPage(Rec.RECORDID);
        SetControlAppearance();
    end;

    var
        MoveNegSalesLines: Report "Move Negative Sales Lines";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EInvApi: Codeunit "EXIM EInvoiceAPI";
        FormatAddress: Codeunit "Format Address";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";

        SalesCalcDiscountByType: Codeunit "Sales - Calc Discount By Type";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        ChangeExchangeRate: Page "Change Exchange Rate";
        ChangeCustomExchangeRate: Page "LFSChange Custom Exchange Rate";
        CanCancelApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanRequestApprovalForFlow: Boolean;
        DocumentIsPosted: Boolean;
        ExternalDocNoMandatory: Boolean;
        HasIncomingDocument: Boolean;
        IsCustomerOrContactNotEmpty: Boolean;
        IsShipToCountyVisible: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        RejectICSalesInvoiceEnabled: Boolean;
        ShowWorkflowStatus: Boolean;
        ShipToOptions: Enum "Sales Ship-to Options";
        EmptyShipToCodeErr: Label 'The Code field can only be empty if you select Custom Address in the Ship-to field.';
        OpenPostedSalesInvQst: Label 'The invoice is posted as number %1 and moved to the Posted Sales Invoices window.\\Do you want to open the posted invoice?', Comment = '%1 = posted document number';
        SureToRejectMsg: Label 'Rejecting this order will remove it from your company and send it back to the partner company.\\Do you want to continue?';
        WorkDescription: Text;

    Procedure DimensionCodeValidation()
    var
    begin
        Rec.TestField("Shortcut Dimension 1 Code");
        Rec.TestField("Shortcut Dimension 2 Code");
    end;

    // local procedure SetLocGSTRegNoEditable()
    // begin

    // end;

    // local procedure CheckMultipleLicenseTotalQty()
    // var
    //     SalesLine: Record "Sales Line";
    //     EXIM_License: Record "LFS EXIM Export License";
    //     sumQty: Decimal;
    // begin

    //     SalesLine.SetRange("Document No.", Rec."No.");
    //     SalesLine.SetRange("Document Type", Rec."Document Type");
    //     if SalesLine.Findset() then
    //         repeat
    //             sumQty := 0;
    //             EXIM_License.SetRange("LFS Source No.", SalesLine."Document No.");
    //             EXIM_License.SetRange("LFS Source line No.", SalesLine."Line No.");
    //             if EXIM_License.Findset() then
    //                 repeat
    //                     sumQty += EXIM_License."LFS Quantity";
    //                 until EXIM_License.Next() = 0;

    //             if (sumQty > SalesLine.Quantity) then
    //                 Error('Total License quantity should not exceed the document line quantity');
    //         until SalesLine.Next() = 0;
    // end;

    procedure InsertDDBRODTepEntry(var SalesInvoiceHeader1: record "Sales Invoice Header")
    var
        recGenJnlLine: Record "Gen. Journal Line";
        EximSetup: Record "LFS EXIM Setup";
        SalesInvHeader: Record "Sales Invoice Header";
        SaleInvline: Record "Sales Invoice Line";
        SalesInvLine: Record "Sales Invoice Line";
        DDAmount: Decimal;
        RODTEPAmount: Decimal;
        GenJnlLineNo: Integer;
    begin
        if SalesInvoiceHeader1."LFS EXIM Type" = SalesInvoiceHeader1."LFS EXIM Type"::Export then begin
            SaleInvline.Reset();
            SaleInvline.SetRange("Document No.", SalesInvoiceHeader1."No.");
            SaleInvline.SetRange("LFS Incentive Type", SaleInvline."LFS Incentive Type"::DDB);
            if SaleInvline.FindFirst() then begin
                // if SaleInvline.Findset() then begin
                DDAmount := 0;
                EximSetup.Get();
                if EximSetup."LFS DDB Batch Name" <> '' then begin
                    recGenJnlLine.SetFilter("Journal Batch Name", '%1', EximSetup."LFS DDB Batch Name");
                    if recGenJnlLine.FindLast() then
                        GenJnlLineNo := 10000 + recGenJnlLine."Line No.";
                end;
                recGenJnlLine.Reset();
                recGenJnlLine.Init();
                recGenJnlLine."Line No." := GenJnlLineNo;
                recGenJnlLine.Validate("Journal Template Name", EximSetup."LFS DDB Jour. Template Name");
                recGenJnlLine.Validate("Journal Batch Name", EximSetup."LFS DDB Batch Name");
                recGenJnlLine.Validate("Document No.", SalesInvoiceHeader1."No." + '_DDB');
                recGenJnlLine.Validate("Posting Date", SalesInvoiceHeader1."Posting Date");
                recGenJnlLine.Validate("Account Type", recGenJnlLine."account type"::"G/L Account");
                recGenJnlLine.Validate("Account No.", EximSetup."LFS DDB Debit A/c No.");
                SalesInvLine.Reset();
                SalesInvLine.SetRange("Document No.", SalesInvoiceHeader1."No.");
                if SalesInvLine.Findset() then
                    repeat
                        DDAmount += SalesInvLine."LFS DDB Value (LCY)";
                    until SalesInvLine.Next() = 0;
                recGenJnlLine.Validate(Amount, DDAmount);
                recGenJnlLine.Validate("Bal. Account Type", recGenJnlLine."bal. account type"::"G/L Account");
                recGenJnlLine.Validate("Bal. Account No.", EximSetup."LFS DDB Credit A/c No.");
                recGenJnlLine.Validate("External Document No.", SalesInvoiceHeader1."Bill Of Export No.");
                recGenJnlLine.Validate("Location Code", SalesInvoiceHeader1."Location Code");
                recGenJnlLine.Validate("Shortcut Dimension 1 Code", SalesInvoiceHeader1."Shortcut Dimension 1 Code");
                recGenJnlLine.Validate("Shortcut Dimension 2 Code", SalesInvoiceHeader1."Shortcut Dimension 2 Code");
                if recGenJnlLine.Insert() then
                    Message('The Duty Drawback entry is created with Doc. No. %1', SalesInvHeader."No." + '_DD');
                if EximSetup."LFS DDB GL Ent Auto Post" = true then
                    recGenJnlLine.SendToPosting(Codeunit::"Gen. Jnl.-Post");
            end;
        end;
        SaleInvline.Reset();
        SaleInvline.SetRange("Document No.", SalesInvoiceHeader1."No.");
        SaleInvline.Setfilter("LFS RoDTEP Rebate Value", '<>%1', 0);
        if not SaleInvline.IsEmpty() then begin
            // if SaleInvline.Findset() then begin
            RODTEPAmount := 0;
            EximSetup.Get();
            recGenJnlLine.SetFilter("Journal Batch Name", '%1', EximSetup."LFS Rdp Batch Name");
            if recGenJnlLine.FindLast() then
                GenJnlLineNo := 10000 + recGenJnlLine."Line No.";

            recGenJnlLine.Reset();

            recGenJnlLine.Init();
            recGenJnlLine."Line No." := GenJnlLineNo;
            recGenJnlLine.Validate("Journal Template Name", EximSetup."LFS Rdp Jour. Template Name");
            recGenJnlLine.Validate("Journal Batch Name", EximSetup."LFS Rdp Batch Name");
            recGenJnlLine.Validate("Document No.", SalesInvoiceHeader1."No." + '_RT');
            recGenJnlLine.Validate("Posting Date", SalesInvoiceHeader1."Posting Date");
            recGenJnlLine.Validate("Account Type", recGenJnlLine."account type"::"G/L Account");
            recGenJnlLine.Validate("Account No.", EximSetup."LFS RoDTEP Debit A/c No.");
            SalesInvLine.Reset();
            SalesInvLine.SetRange("Document No.", SalesInvoiceHeader1."No.");
            if SalesInvLine.Findset() then
                repeat
                    RODTEPAmount += SalesInvLine."LFS RoDTEP Rebate Value";
                until SalesInvLine.Next() = 0;
            recGenJnlLine.Validate(Amount, RODTEPAmount);
            recGenJnlLine.Validate("Bal. Account Type", recGenJnlLine."bal. account type"::"G/L Account");
            recGenJnlLine.Validate("Bal. Account No.", EximSetup."LFS RoDTEP Credit A/c No.");
            recGenJnlLine.Validate("External Document No.", Rec."Bill Of Export No.");
            recGenJnlLine.Validate("Location Code", SalesInvoiceHeader1."Location Code");
            recGenJnlLine.Validate("Shortcut Dimension 1 Code", SalesInvoiceHeader1."Shortcut Dimension 1 Code");
            recGenJnlLine.Validate("Shortcut Dimension 2 Code", SalesInvoiceHeader1."Shortcut Dimension 2 Code");
            if recGenJnlLine.Insert() then
                Message('The RoDTEP entry is created with Doc. No. %1', SalesInvoiceHeader1."No." + '_RT');
            if EximSetup."LFS RoDTEP GL Ent Auto Post" = true then
                recGenJnlLine.SendToPosting(Codeunit::"Gen. Jnl.-Post");
            // until SaleInvline.Next() = 0;
        end;
    end;

    procedure InsertDDBRODTepEntryCreditMemo(var SalesCreditMemoHeader1: record "Sales Cr.Memo Header")
    var
        recGenJnlLine: Record "Gen. Journal Line";
        EximSetup: Record "LFS EXIM Setup";
        SaleCreditmemoline: Record "Sales Cr.Memo Line";
        SalesCreditMemoLine: Record "Sales Cr.Memo Line";
        DDAmount: Decimal;
        RODTEPAmount: Decimal;
        GenJnlLineNo: Integer;
    begin
        SaleCreditmemoline.Reset();
        SaleCreditmemoline.SetRange("Document No.", SalesCreditMemoHeader1."No.");
        SaleCreditmemoline.SetRange("LFS Incentive Type", SaleCreditmemoline."LFS Incentive Type"::DDB);
        if SaleCreditmemoline.Findset() then begin
            DDAmount := 0;
            EximSetup.Get();
            if EximSetup."LFS DDB Batch Name" <> '' then begin
                recGenJnlLine.SetFilter("Journal Batch Name", '%1', EximSetup."LFS DDB Batch Name");
                if recGenJnlLine.FindLast() then
                    GenJnlLineNo := 10000 + recGenJnlLine."Line No.";
            end;
            recGenJnlLine.Reset();
            recGenJnlLine.Init();
            recGenJnlLine."Line No." := GenJnlLineNo;
            recGenJnlLine.Validate("Journal Template Name", EximSetup."LFS DDB Jour. Template Name");
            recGenJnlLine.Validate("Journal Batch Name", EximSetup."LFS DDB Batch Name");
            recGenJnlLine.Validate("Document No.", SalesCreditMemoHeader1."No." + '_DDB');
            recGenJnlLine.Validate("Posting Date", SalesCreditMemoHeader1."Posting Date");
            recGenJnlLine.Validate("Account Type", recGenJnlLine."account type"::"G/L Account");
            recGenJnlLine.Validate("Account No.", EximSetup."LFS DDB Debit A/c No.");
            SalesCreditMemoLine.Reset();
            SalesCreditMemoLine.SetRange("Document No.", SalesCreditMemoHeader1."No.");
            if SalesCreditMemoLine.Findset() then
                repeat
                    DDAmount += SalesCreditMemoLine."LFS DDB Value (LCY)";
                until SalesCreditMemoLine.Next() = 0;
            recGenJnlLine.Validate(Amount, DDAmount);
            recGenJnlLine.Validate("Bal. Account Type", recGenJnlLine."bal. account type"::"G/L Account");
            recGenJnlLine.Validate("Bal. Account No.", EximSetup."LFS DDB Credit A/c No.");
            recGenJnlLine.Validate("External Document No.", SalesCreditMemoHeader1."Bill Of Export No.");
            if recGenJnlLine.Insert() then
                Message('The Duty Drawback entry is created with Doc. No. %1', SalesCreditMemoLine."No." + '_DD');
            if EximSetup."LFS DDB GL Ent Auto Post" = true then
                recGenJnlLine.SendToPosting(Codeunit::"Gen. Jnl.-Post");
        end;
        SaleCreditmemoline.Reset();
        SaleCreditmemoline.SetRange("Document No.", SalesCreditMemoHeader1."No.");
        SaleCreditmemoline.Setfilter("LFS RoDTEP Rebate Value", '<>%1', 0);
        if SaleCreditmemoline.Findset() then
            repeat
                RODTEPAmount := 0;
                EximSetup.Get();
                recGenJnlLine.SetFilter("Journal Batch Name", '%1', EximSetup."LFS Rdp Batch Name");
                if recGenJnlLine.FindLast() then
                    GenJnlLineNo := 10000 + recGenJnlLine."Line No.";

                recGenJnlLine.Reset();

                recGenJnlLine.Init();
                recGenJnlLine."Line No." := GenJnlLineNo;
                recGenJnlLine.Validate("Journal Template Name", EximSetup."LFS Rdp Jour. Template Name");
                recGenJnlLine.Validate("Journal Batch Name", EximSetup."LFS Rdp Batch Name");
                recGenJnlLine.Validate("Document No.", SalesCreditMemoHeader1."No." + '_RT');
                recGenJnlLine.Validate("Posting Date", SalesCreditMemoHeader1."Posting Date");
                recGenJnlLine.Validate("Account Type", recGenJnlLine."account type"::"G/L Account");
                recGenJnlLine.Validate("Account No.", EximSetup."LFS RoDTEP Debit A/c No.");
                SalesCreditMemoLine.Reset();
                SalesCreditMemoLine.SetRange("Document No.", SalesCreditMemoHeader1."No.");
                if SalesCreditMemoLine.Findset() then
                    repeat
                        RODTEPAmount += SalesCreditMemoLine."LFS RoDTEP Rebate Value";
                    until SalesCreditMemoLine.Next() = 0;
                recGenJnlLine.Validate(Amount, RODTEPAmount);
                recGenJnlLine.Validate("Bal. Account Type", recGenJnlLine."bal. account type"::"G/L Account");
                recGenJnlLine.Validate("Bal. Account No.", EximSetup."LFS RoDTEP Credit A/c No.");
                recGenJnlLine.Validate("External Document No.", Rec."Bill Of Export No.");
                if recGenJnlLine.Insert() then
                    Message('The RoDTEP entry is created with Doc. No. %1', SalesCreditMemoHeader1."No." + '_RT');
                if EximSetup."LFS RoDTEP GL Ent Auto Post" = true then
                    recGenJnlLine.SendToPosting(Codeunit::"Gen. Jnl.-Post");

            until SaleCreditmemoline.Next() = 0;
    end;

    procedure InsertRODTepConsumptionEntryForDomesticSales(var SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        recGenJnlLine: Record "Gen. Journal Line";
        MultipleLicense: Record "LFS EXIM Posted Export Licence";
        EximSetup: Record "LFS EXIM Setup";
        RODTEPAmount: Decimal;
        GenJnlLineNo: Integer;
    begin
        RODTEPAmount := 0;
        MultipleLicense.Reset();
        MultipleLicense.SetRange("LFS Source No.", SalesInvoiceHeader."No.");
        MultipleLicense.SetRange("LFS Source Type", MultipleLicense."LFS Source Type"::Invoice);
        if MultipleLicense.Findset() then
            repeat
                RODTEPAmount += MultipleLicense."LFS RoDTEP Consump Value";
            until MultipleLicense.Next() = 0;
        if RODTEPAmount <> 0 then
            if SalesInvoiceHeader."LFS EXIM Type" = SalesInvoiceHeader."LFS EXIM Type"::" " then begin
                RODTEPAmount := 0;
                EximSetup.Get();
                recGenJnlLine.SetFilter("Journal Batch Name", '%1', EximSetup."LFS RdpDomesticConsBatchName");
                if recGenJnlLine.FindLast() then
                    GenJnlLineNo := 10000 + recGenJnlLine."Line No.";
                recGenJnlLine.Reset();
                recGenJnlLine.Init();
                recGenJnlLine."Line No." := GenJnlLineNo;
                recGenJnlLine.Validate("Journal Template Name", EximSetup."LFS RdpDomesticJourTempName");
                recGenJnlLine.Validate("Journal Batch Name", EximSetup."LFS RdpDomesticConsBatchName");
                recGenJnlLine.Validate("Document No.", SalesInvoiceHeader."No." + '_RTC');
                recGenJnlLine.Validate("Posting Date", SalesInvoiceHeader."Posting Date");
                recGenJnlLine.Validate("Account Type", recGenJnlLine."account type"::"G/L Account");
                recGenJnlLine.Validate("Account No.", EximSetup."LFSEXRdpDomesticConsAccountNo.");
                MultipleLicense.Reset();
                MultipleLicense.SetRange("LFS Source No.", SalesInvoiceHeader."No.");
                MultipleLicense.SetRange("LFS Source Type", MultipleLicense."LFS Source Type"::Invoice);
                if MultipleLicense.Findset() then
                    repeat
                        RODTEPAmount += MultipleLicense."LFS RoDTEP Consump Value";
                    until MultipleLicense.Next() = 0;
                recGenJnlLine.Validate(Amount, RODTEPAmount);
                recGenJnlLine.Validate("Bal. Account Type", recGenJnlLine."bal. account type"::"G/L Account");
                recGenJnlLine.Validate("Bal. Account No.", EximSetup."LFS RdpDomesticConsBalAccNum");
                // recGenJnlLine.Validate("External Document No.", SalesInvoiceHeader."Bill of Entry No.");
                if recGenJnlLine.Insert() then
                    Message('The RoDTEP entry is created with Doc. No. %1', SalesInvoiceHeader."No." + '_RTC');
                if EximSetup."LFS ConsDomesticGLEntAutoPost" = true then
                    recGenJnlLine.SendToPosting(Codeunit::"Gen. Jnl.-Post");
            end;
    end;

    procedure InsertRODTepConsumptionEntryForSalesCreditMemo(var SalesCreditMemoHeader: Record "Sales Cr.Memo Header")
    var
        recGenJnlLine: Record "Gen. Journal Line";
        MultipleLicense: Record "LFS EXIM Posted Export Licence";
        EximSetup: Record "LFS EXIM Setup";
        RODTEPAmount: Decimal;
        GenJnlLineNo: Integer;
    begin
        RODTEPAmount := 0;
        MultipleLicense.Reset();
        MultipleLicense.SetRange("LFS Source No.", SalesCreditMemoHeader."No.");
        MultipleLicense.SetRange("LFS Source Type", MultipleLicense."LFS Source Type"::"Credit Memo");
        if MultipleLicense.Findset() then
            repeat
                RODTEPAmount += -MultipleLicense."LFS RoDTEP Consump Value";
            until MultipleLicense.Next() = 0;
        if RODTEPAmount < 0 then
            if SalesCreditMemoHeader."LFS EXIM Type" = SalesCreditMemoHeader."LFS EXIM Type"::" " then begin
                RODTEPAmount := 0;
                EximSetup.Get();
                recGenJnlLine.SetFilter("Journal Batch Name", '%1', EximSetup."LFS RdpDomesticConsBatchName");
                if recGenJnlLine.FindLast() then
                    GenJnlLineNo := 10000 + recGenJnlLine."Line No.";
                recGenJnlLine.Reset();
                recGenJnlLine.Init();
                recGenJnlLine."Line No." := GenJnlLineNo;
                recGenJnlLine.Validate("Journal Template Name", EximSetup."LFS RdpDomesticJourTempName");
                recGenJnlLine.Validate("Journal Batch Name", EximSetup."LFS RdpDomesticConsBatchName");
                recGenJnlLine.Validate("Document No.", SalesCreditMemoHeader."No." + '_RTC');
                recGenJnlLine.Validate("Posting Date", SalesCreditMemoHeader."Posting Date");
                recGenJnlLine.Validate("Account Type", recGenJnlLine."account type"::"G/L Account");
                recGenJnlLine.Validate("Account No.", EximSetup."LFSEXRdpDomesticConsAccountNo.");
                recGenJnlLine.Validate(Amount, RODTEPAmount);
                recGenJnlLine.Validate("Bal. Account Type", recGenJnlLine."bal. account type"::"G/L Account");
                recGenJnlLine.Validate("Bal. Account No.", EximSetup."LFS RdpDomesticConsBalAccNum");
                // recGenJnlLine.Validate("External Document No.", SalesInvoiceHeader."Bill of Entry No.");
                if recGenJnlLine.Insert() then
                    Message('The RoDTEP entry is created with Doc. No. %1', SalesCreditMemoHeader."No." + '_RTC');
                if EximSetup."LFS ConsDomesticGLEntAutoPost" = true then
                    recGenJnlLine.SendToPosting(Codeunit::"Gen. Jnl.-Post");
            end;
    end;

    local procedure BilltoCustomerNoOnAfterValidat()
    begin
        CurrPage.Update();
    end;

    local procedure PostDocument(PostingCodeunitID: Integer; Navigate: Enum "Navigate After Posting")
    var
        SalesHeader: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
        OfficeMgt: Codeunit "Office Management";
        IsScheduledPosting: Boolean;
        PreAssignedNo: Code[20];
        xLastPostingNo: Code[20];
    begin
        LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);
        PreAssignedNo := Rec."No.";
        xLastPostingNo := Rec."Last Posting No.";

        Rec.SendToPosting(PostingCodeunitID);

        IsScheduledPosting := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        DocumentIsPosted := (not SalesHeader.Get(Rec."Document Type", Rec."No.")) or IsScheduledPosting;

        if IsScheduledPosting then
            CurrPage.Close();
        CurrPage.Update(false);


        if PostingCodeunitID <> CODEUNIT::"Sales-Post (Yes/No)" then
            exit;

        if OfficeMgt.IsAvailable() then begin
            if (Rec."Last Posting No." <> '') and (Rec."Last Posting No." <> xLastPostingNo) then
                SalesInvoiceHeader.SetRange("No.", Rec."Last Posting No.")
            else begin
                SalesInvoiceHeader.SetCurrentKey("Pre-Assigned No.");
                SalesInvoiceHeader.SetRange("Pre-Assigned No.", PreAssignedNo);
            end;
            if SalesInvoiceHeader.FindFirst() then
                PAGE.Run(PAGE::"Posted Sales Invoice", SalesInvoiceHeader);
        end else
            case Navigate of
                Enum::"Navigate After Posting"::"Posted Document":
                    if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode()) then
                        ShowPostedConfirmationMessage(PreAssignedNo, xLastPostingNo);
                Enum::"Navigate After Posting"::"New Document":
                    if DocumentIsPosted then begin
                        SalesHeader.Init();
                        SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Invoice);
                        SalesHeader.Insert(true);
                        PAGE.Run(PAGE::"Sales Invoice", SalesHeader);
                    end;
            end;
    end;

    local procedure SalespersonCodeOnAfterValidate()
    begin
    end;

    local procedure SelltoCustomerNoOnAfterValidat()
    begin
        if Rec.GETFILTER("Sell-to Customer No.") = xRec."Sell-to Customer No." then
            if Rec."Sell-to Customer No." <> xRec."Sell-to Customer No." then
                Rec.SETRANGE("Sell-to Customer No.");
        CurrPage.UPDATE();
    end;

    local procedure SetControlAppearance()
    var
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        SetExtDocNoMandatoryCondition();

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
        IsCustomerOrContactNotEmpty := (Rec."Sell-to Customer No." <> '') or (Rec."Sell-to Contact No." <> '');
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
    end;

    local procedure SetExtDocNoMandatoryCondition()
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        SalesReceivablesSetup.GET();
        ExternalDocNoMandatory := SalesReceivablesSetup."Ext. Doc. No. Mandatory"

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
        SalesInvoiceHeader: Record "Sales Invoice Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        if (Rec."Last Posting No." <> '') and (Rec."Last Posting No." <> xLastPostingNo) then
            SalesInvoiceHeader.SetRange("No.", Rec."Last Posting No.")
        else begin
            SalesInvoiceHeader.SetCurrentKey("Pre-Assigned No.");
            SalesInvoiceHeader.SetRange("Pre-Assigned No.", PreAssignedNo);
        end;
        if SalesInvoiceHeader.FindFirst() then
            if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedSalesInvQst, SalesInvoiceHeader."No."),
                 InstructionMgt.ShowPostedConfirmationMessageCode())
            then
                InstructionMgt.ShowPostedDocument(SalesInvoiceHeader, Page::"Sales Invoice");
    end;

    local procedure ShowPreview()
    var
        SalesPostYesNo: Codeunit "Sales-Post (Yes/No)";
    begin
        SalesPostYesNo.Preview(Rec);
    end;
}