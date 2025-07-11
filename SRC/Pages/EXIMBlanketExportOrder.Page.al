namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.Document;
using Microsoft.Finance.GST.Sales;
using Microsoft.Projects.Resources.Resource;
using Microsoft.Foundation.Reporting;
using Microsoft.Utilities;
using Microsoft.Finance.Currency;
using Microsoft.Foundation.Address;
using System.Security.User;
using Microsoft.Sales.Pricing;
using Microsoft.Finance.Dimension;
using Microsoft.Sales.Comment;
using System.Automation;
using Microsoft.Sales.Customer;

page 72090 "LFS EXIM Blanket Export Order"
{
    ApplicationArea = All;
    Caption = 'EXIM Blanket Export Order';
    PageType = Document;
    SourceTable = "Sales Header";
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Process,Report,Approve';
    SourceTableView = where("Document Type" = filter("Blanket Order"));
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the No.';
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
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                    ApplicationArea = All;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ToolTip = 'Specifies the postal code.';
                    ApplicationArea = All;
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
                field("Order Date"; Rec."Order Date")
                {
                    ToolTip = 'Specifies the date when the order was created.';
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies when the sales invoice was created.';
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies a document number that refers to the customer''s or vendor''s numbering system.';
                    ApplicationArea = All;
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
                field("Campaign No."; Rec."Campaign No.")
                {
                    ToolTip = 'Specifies the number of the campaign that the document is linked to.';
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the code of the responsibility center, such as a distribution hub, that is associated with the involved user, company, customer, or vendor.';
                    ApplicationArea = All;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies whether the document is open, waiting to be approved, has been invoiced for prepayment, or has been released to the Next() stage of processing.';
                    ApplicationArea = All;
                }
            }
            part(SalesLines; "LFSEXIMBlanketExp.OrderSubform")
            {
                ApplicationArea = all;
                SubPageLink = "Document No." = field("No.");
                UpdatePropagation = Both;
            }
            group(Invoicing)
            {
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer that you send or sent the invoice or credit memo to.';
                    ApplicationArea = All;

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
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                    ToolTip = 'Specifies an additional part of the billing address.';
                    ApplicationArea = All;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ToolTip = 'Specifies the postal code of the billing address.';
                    ApplicationArea = All;
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
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount.';
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies when the sales invoice must be paid.';
                    ApplicationArea = All;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ToolTip = 'Specifies the payment discount percentage that is granted if the customer pays on or before the date entered in the Pmt. Discount Date field. The discount percentage is specified in the Payment Terms Code field.';
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ToolTip = 'Specifies the date on which the amount in the entry must be paid for a payment discount to be granted.';
                    ApplicationArea = All;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ToolTip = 'Specifies how to make payment, such as with bank transfer, cash, or check.';
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
            }
            group("Foreign Trade")
            {
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the currency that is used on the entry.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE();
                        SalesCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);
                    end;

                    trigger OnAssistEdit()
                    begin
                        CLEAR(ChangeExchangeRate);
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
                field("EU 3-Party Trade"; Rec."EU 3-Party Trade")
                {
                    ToolTip = 'Specifies if the transaction is related to trade with a third party within the EU.';
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the type of transaction that the document represents, for the purpose of reporting to INTRASTAT.';
                    ApplicationArea = All;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ToolTip = 'Specifies a specification of the document''s transaction, for the purpose of reporting to INTRASTAT.';
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ToolTip = 'Specifies the transport method, for the purpose of reporting to INTRASTAT.';
                    ApplicationArea = All;
                }
                field("Exit Point"; Rec."Exit Point")
                {
                    ToolTip = 'Specifies the point of exit through which you ship the items out of your country/region, for reporting to Intrastat.';
                    ApplicationArea = All;
                }
                field("Area"; Rec."Area")
                {
                    ToolTip = 'Specifies the country or region of origin for the purpose of Intrastat reporting.';
                    ApplicationArea = All;
                }
            }
            group("Tax Information")
            {
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
                field("Vehicle Type"; Rec."Vehicle Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the vehicle type on the sales document. For example, Regular/ODC.  ';
                }
                field("Distance (Km)"; Rec."Distance (Km)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the distance on the sales document.';
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
            }
            group(EXIM)
            {
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
                field("Export Remark"; Rec."LFS Export Remark")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Export Remark';
                }
                field("Shpping Line"; Rec."LFS Shipping Line")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Shpping Line';
                }
            }
        }
        area(FactBoxes)
        {
            part("Pending Approval FactBox"; "Pending Approval FactBox")
            {
                ApplicationArea = all;
                Visible = OpenApprovalEntriesExistForCurrUser;
                SubPageLink = "Table ID" = const(36), "Document Type" = field("Document Type"), "Document No." = field("No.");
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
                Provider = SalesLines;
                SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No."), "Line No." = FIELD("Line No.");
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
                Provider = SalesLines;
                SubPageLink = "No." = field("No.");
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
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = Order;
                // action(Statistics)
                // {
                //     ApplicationArea = All;
                //     Caption = 'Statistics';
                //     Image = Statistics;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     ShortcutKey = F7;
                //     ToolTip = 'Specifies the Statistics';
                //     trigger OnAction()
                //     begin
                //         Rec.OpenSalesOrderStatistics();
                //         SalesCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
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
                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = EditLines;
                    ShortcutKey = 'Shift+F7';
                    RunObject = page "Customer Card";
                    RunPageLink = "No." = field("Sell-to Customer No.");
                    ToolTip = 'Specifies the Card';

                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = const("Blanket Order"), "No." = field("No."), "Document Line No." = const(0);
                    ToolTip = 'Specifies the Comments';
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    AccessByPermission = tabledata Dimension = R;
                    Image = Dimensions;
                    ShortcutKey = 'Shift+Ctrl+D';
                    ToolTip = 'Specifies the Dimensions';
                    trigger OnAction()
                    begin
                        Rec.ShowDocDim();
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = All;
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'Specifies the Approvals';
                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntries.RUN();
                    end;
                }
            }

            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Structure)
                {
                    ApplicationArea = All;
                    Caption = 'Structure';
                    Image = Hierarchy;
                    ToolTip = 'Specifies the Structure';
                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.ShowStrOrderDetailsPITForm();
                    end;
                }
            }
        }
        area(Navigation)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Specifies the Approve';
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Specifies the Reject';
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Specifies the Delegate';
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Specifies the Comments';
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = Action;
                action(CalculateInvoiceDiscount)
                {
                    ApplicationArea = All;
                    Caption = 'Calculate &Invoice Discount';
                    AccessByPermission = tabledata "Cust. Invoice Disc." = R;
                    ToolTip = 'Specifies the Calculate &Invoice Discount';
                    Image = Discount;
                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc();
                        SalesCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                action(CopyDocument)
                {
                    ApplicationArea = All;
                    Caption = 'Copy Document';
                    Image = CopyDocument;
                    Ellipsis = true;
                    ToolTip = 'Specifies the Copy Document';
                    trigger OnAction()
                    begin
                        CopySalesDoc.SetSalesHeader(Rec);
                        CopySalesDoc.RUNMODAL();
                        CLEAR(CopySalesDoc);
                    end;
                }
                action(Release)
                {
                    ApplicationArea = All;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortcutKey = 'Ctrl+F9';
                    ToolTip = 'Specifies the Release';
                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        MESSAGE('Custom Exchange Rate is %1 and RBI Rate is %2', ROUND(1 / Rec."LFS Custom Currency Factor"), ROUND(1 / Rec."Currency Factor"));
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = All;
                    Caption = 'Re&open';
                    Image = ReOpen;
                    ToolTip = 'Specifies the Reopen';
                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }
            }
            action(MakeOrder)
            {
                ApplicationArea = All;
                Caption = 'Make &Order';
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Specifies the Make Order';
                PromotedOnly = true;
                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then
                        CODEUNIT.RUN(CODEUNIT::"Blnkt Sales Ord. to Ord. (Y/N)", Rec);
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
                    DocPrint.PrintSalesHeader(Rec);
                end;
            }
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = All;
                    Caption = 'Send A&pproval Request';
                    ToolTip = 'Specifies the Send A&pproval Request';
                    Enabled = not OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Enabled = OpenApprovalEntriesExist;
                    ToolTip = 'Specifies the Cancel Approval Re&quest';
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if UserMgt.GetSalesFilter() <> '' then begin
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetSalesFilter());
            Rec.FILTERGROUP(0);
        end;

        SetDocNoVisible();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetSalesFilter();
        Rec."LFS EXIM Type" := Rec."LFS EXIM Type"::Export;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.CheckCreditMaxBeforeInsert();
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
        // SalesLine: Record "Sales Line";
        CopySalesDoc: Report "Copy Sales Document";
        DocPrint: Codeunit "Document-Print";
        FormatAddress: Codeunit "Format Address";
        SalesCalcDiscByType: Codeunit "Sales - Calc Discount By Type";
        UserMgt: Codeunit "User Setup Management";
        ChangeExchangeRate: Page "Change Exchange Rate";
        ChangeCustomExchangeRate: Page "LFSChange Custom Exchange Rate";
        // SalesSetup: Record "Sales & Receivables Setup";
        DocNoVisible: Boolean;
        IsShipToCountyVisible: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        ShowWorkflowStatus: Boolean;
        ShipToOptions: Enum "Sales Ship-to Options";
        EmptyShipToCodeErr: Label 'The Code field can only be empty if you select Custom Address in the Ship-to field.';

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.SalesLines.PAGE.ApproveCalcInvDisc();
    end;

    local procedure BilltoCustomerNoOnAfterValidat()
    begin
        CurrPage.Update();
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.Update();
    end;

    local procedure SalespersonCodeOnAfterValidate()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(true);
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
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
    end;

    local procedure SetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
        DocType: Option Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        Clear(DocNoVisible);
        DocNoVisible := DocumentNoVisibility.SalesDocumentNoIsVisible(DocType::"Blanket Order", Rec."No.");
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.SalesLines.Page.UpdateForm(true);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.SalesLines.Page.UpdateForm(true);
    end;
}
