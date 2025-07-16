namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.Document;
using Microsoft.Finance.GST.Sales;
using Microsoft.Inventory.Item;
using Microsoft.Finance.Dimension;
using Microsoft.Inventory.BOM;
using Microsoft.CRM.Outlook;
using Microsoft.Integration.D365Sales;
using Microsoft.Finance.Currency;
using Microsoft.Utilities;
using System.Security.User;
using Microsoft.Foundation.Address;
using Microsoft.Foundation.Reporting;
using Microsoft.Foundation.Enums;
using Microsoft.Sales.Posting;
using Microsoft.Warehouse.Request;
using Microsoft.Warehouse.InventoryDocument;
using Microsoft.Inventory.Requisition;
using Microsoft.Inventory.Availability;
using Microsoft.Intercompany;
using Microsoft.Intercompany.GLAccount;
using Microsoft.Sales.Pricing;
using Microsoft.Purchases.Document;
using Microsoft.Sales.Setup;
using Microsoft.Warehouse.Document;
using Microsoft.Warehouse.Activity;
using Microsoft.Sales.History;
using Microsoft.Integration.Dataverse;
using Microsoft.Assembly.Document;
using Microsoft.Sales.Comment;
using Microsoft.Foundation.Attachment;
using Microsoft.Warehouse.Setup;
using Microsoft.Projects.Resources.Resource;
using Microsoft.EServices.EDocument;
using System.Automation;
using Microsoft.Finance.TaxEngine.TaxTypeHandler;
using Microsoft.Sales.Customer;
using Microsoft.Purchases.Vendor;

page 72058 "LFS Export Sales Order"
{
    ApplicationArea = All;
    Caption = 'Export Sales Order';
    PageType = Document;
    SourceTable = "Sales Header";
    RefreshOnActivate = true;
    SourceTableView = where("Document Type" = filter(Order), "LFS EXIM Type" = const(Export));
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
                    Importance = Additional;
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
                    QuickEntry = false;
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
                    QuickEntry = false;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ToolTip = 'Specifies the name of the contact person at the customer.';
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    ToolTip = 'Specifies the number of archived versions for this document.';
                    ApplicationArea = All;
                    Importance = Additional;
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
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the date when the posting of the sales document will be recorded.';
                    ApplicationArea = All;
                    QuickEntry = false;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ToolTip = 'Specifies the date when the order was created.';
                    ApplicationArea = All;
                    QuickEntry = false;
                    Importance = Promoted;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies when the sales invoice was created.';
                    ApplicationArea = All;
                    QuickEntry = false;
                }
                field("Quote No."; Rec."Quote No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the number of the sales quote that the sales order was created from. You can track the number to sales quote documents that you have printed, saved, or emailed.';
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Caption = 'Customer Order No.';
                    ShowMandatory = ExternalDocNoMandatory;
                    Importance = Promoted;
                    ToolTip = 'Specifies a document number that refers to the customer''s or vendor''s numbering system.';
                    ApplicationArea = All;
                }
                // field("Your Reference Date"; Rec."LFS Your Reference Date")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Customer Order Date';
                //     ToolTip = 'Specifies the Customer Order Date';
                // }
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = All;
                    Caption = 'Other Reference''s';
                    ToolTip = 'Specifies the Other Reference''s';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Specifies the name of the salesperson who is assigned to the customer.';
                    ApplicationArea = All;
                    QuickEntry = false;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ToolTip = 'Specifies the date that the customer has asked for the order to be delivered.';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies whether the document is open, waiting to be approved, has been invoiced for prepayment, or has been released to the Next() stage of processing.';
                    ApplicationArea = All;
                    QuickEntry = false;
                    Importance = Promoted;
                }
                field("Posting No."; Rec."Posting No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Posting No.';
                    Editable = Rec.Status = Rec.Status::Released;
                }
                field("Shipping No. Series"; Rec."Shipping No. Series")
                {
                    ToolTip = 'Specifies the value of the Shipping No. Series field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Posting No. Series"; Rec."Posting No. Series")
                {
                    ToolTip = 'Specifies the value of the Posting No. Series field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Exit Point"; Rec."Exit Point")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Exit Point';
                    trigger OnValidate()
                    begin
                        Rec."LFS Port of Loading" := Rec."Exit Point";
                    end;
                }
                // field("Commission Agent"; Rec."LFS Commission Agent")
                // {
                //     ApplicationArea = all;
                //     TableRelation = Vendor."No.";
                //     ToolTip = 'Specifies the Commission Agent';
                // }
                // field("Comm. Amount"; Rec."LFS Comm. Amount")
                // {
                //     ApplicationArea = all;
                //     MinValue = 0;
                //     ToolTip = 'Specifies the Comm. Amount';
                // }
                // field("LFS Commission %"; Rec."LFS Commission %")
                // {
                //     ApplicationArea = all;
                //     MinValue = 0;
                //     ToolTip = 'Specifies the Commission %';
                // }
                field("LFS ExpType"; Rec."LFS FOB CIF Calc. Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Inco Terms Type';
                }
                group("Work Description")
                {
                    Caption = 'Work Description';
                    field(WorkDescription; WorkDescription)
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                        ToolTip = 'Specifies the products or service being offered.';

                        trigger OnValidate()
                        begin
                            Rec.SetWorkDescription(WorkDescription);
                        end;
                    }
                }
                // field("Work Description"; Rec."Work Description")
                // {
                //     ToolTip = 'Specifies the value of the Work Description field.', Comment = '%';
                // }
                // field("LFS Export Remark"; Rec."LFS Export Remark")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Export Remark';
                // }
                field("LFS Dispatch Date"; Rec."LFS Dispatch Date")
                {
                    ApplicationArea = all;
                    Caption = 'Dispatch Date';
                    ToolTip = 'Dispatch Date';
                }
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
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", REc."Currency Factor", Rec."Posting Date")
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
                    Caption = 'Currency Code';
                    ToolTip = 'Specifies the Currency Code';
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
                field("Shpping Line"; Rec."LFS Shipping Line")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Shpping Line';
                }
                field("Customs Bank Account"; Rec."LFS Customs Bank Account")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Customs Bank Account';
                }
                field("Commercial  Bank Account"; Rec."LFS Commercial Bank Account")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Commercial Bank Account';
                }
                // field("Export Remark"; Rec."LFS Export Remark")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                //     ToolTip = 'Specifies the Export Remark';
                // }
                field("Pre Carriage"; Rec."LFS Pre Carriage")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Pre Carriage';
                }
                field("LFSPlaceofReceiptPre-Carriage"; Rec."LFSPlaceofReceiptPre-Carriage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Place of Receipt By Pre-Carriage';
                }
                // field("FTT No."; Rec."LFS FTT No.")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                //     ToolTip = 'Specifies the FTT No.';
                // }
                // field("FTT Date"; Rec."LFS FTT Date")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                //     ToolTip = 'Specifies the FTT Date';
                // }
                // field("BIN No."; Rec."LFS BIN No.")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                //     ToolTip = 'Specifies the BIN No.';
                // }
                field(ETA; Rec."LFS ETA")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the ETA';
                }
                field(ETD; Rec."LFS ETD")
                {
                    ApplicationArea = all;
                    Caption = 'EDD';
                    Visible = false;
                    ToolTip = 'Specifies the ETD';
                }
                // field("Additional Information"; Rec."LFS Additional Information")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                //     ToolTip = 'Specifies the Additional Information';
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
                // field("bill No."; Rec."LFS bill No.")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Bill No.';
                //     ToolTip = 'Specifies the Bill No.';
                // }
                // field("bill Date"; Rec."LFS bill Date")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Bill Date';
                //     ToolTip = 'Specifies the Bill Date';
                // }
            }
            part(SalesLines; "LFS Export Sales Order Subform")
            {
                ApplicationArea = all;
                Enabled = Rec."Sell-to Customer No." <> '';
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }
            group(Invoicing)
            {
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
                    Importance = Additional;
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
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    // Visible = false;
                    ToolTip = 'Specifies the type of the posted document that this document or journal line will be applied to when you post, for example to register payment.';
                    ApplicationArea = All;
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    // Visible = false;
                    ToolTip = 'Specifies the number of the posted document that this document or journal line will be applied to when you post, for example to register payment.';
                    ApplicationArea = All;
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    Visible = false;
                    ToolTip = 'Specifies the ID of entries that will be applied to when you choose the Apply Entries action.';
                    ApplicationArea = All;
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
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ToolTip = 'Specifies how to make payment, such as with bank transfer, cash, or check.';
                    ApplicationArea = All;
                }
                // field("LFS Notify Party 1"; Rec."LFS Notify Party 1")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the Notifying Parties values.';
                // }
                // field("LFS Notify Party 2"; Rec."LFS Notify Party 2")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the Notifying Parties values.';
                // }
                // field("LFS Notify Party 3"; Rec."LFS Notify Party 3")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the Notifying Parties values.';
                // }
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
#pragma warning disable AL0432
                        field("Package Tracking No."; Rec."Package Tracking No.")
#pragma warning restore AL0432
                        {
                            ApplicationArea = Suite;
                            Importance = Additional;
                            ToolTip = 'Specifies the shipping agent''s package number.';
                        }
                    }
                }
            }
            group("Tax Information")
            {
                Caption = 'Tax Information';
                field("GST Bill-to State Code"; Rec."GST Bill-to State Code")
                {
                    ApplicationArea = all;
                    // Visible = false;
                    ToolTip = 'Specifies the GST Bill-to State Code';
                }
                field("GST Ship-to State Code"; Rec."GST Ship-to State Code")
                {
                    ApplicationArea = all;
                    // Visible = false;
                    ToolTip = 'Specifies the GST Ship-to State Code';
                }
                field("Location State Code"; Rec."Location State Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Location State Code';
                }
                field("Location GST Reg. No."; Rec."Location GST Reg. No.")
                {
                    ApplicationArea = all;
                    Editable = GSTLocRegNo;
                    ToolTip = 'Specifies the Location GST Reg. No.';
                }
                field("Customer GST Reg. No."; Rec."Customer GST Reg. No.")
                {
                    ApplicationArea = all;
                    // Visible = false;
                    ToolTip = 'Specifies the Customer GST Reg. No.';
                }
                field("Ship-to GST Reg. No."; Rec."Ship-to GST Reg. No.")
                {
                    ApplicationArea = ALL;
                    // Visible = false;
                    ToolTip = 'Specifies the Ship-to GST Reg. No.';
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
            part("Pending Approval FactBox"; "Pending Approval FactBox")
            {
                ApplicationArea = all;
                Visible = OpenApprovalEntriesExistForCurrUser;
                SubPageLink = "Table ID" = const(36), "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
            }
            part("Sales Hist. Sell-to FactBox"; "Sales Hist. Sell-to FactBox")
            {
                ApplicationArea = all;
                Visible = true;
                SubPageLink = "No." = field("Sell-to Customer No.");
            }
            part("Customer Statistics FactBox"; "Customer Statistics FactBox")
            {
                ApplicationArea = all;
                Visible = false;
                SubPageLink = "No." = field("Bill-to Customer No.");
            }
            part("Customer Details FactBox"; "Customer Details FactBox")
            {
                ApplicationArea = all;
                Visible = false;
                SubPageLink = "No." = field("Sell-to Customer No.");
            }
            part("Sales Line FactBox"; "Sales Line FactBox")
            {
                ApplicationArea = all;
                Visible = true;
            }
            part("Item Invoicing FactBox"; "Item Invoicing FactBox")
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
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = all;
                ShowFilter = false;
            }
            part("Resource Details FactBox"; "Resource Details FactBox")
            {
                ApplicationArea = all;
                Visible = false;
                SubPageLink = "No." = field("No.");
            }
            part("Item Warehouse FactBox"; "Item Warehouse FactBox")
            {
                ApplicationArea = all;
                Visible = false;
                SubPageLink = "No." = field("No.");
            }
            part("Sales Hist. Bill-to FactBox"; "Sales Hist. Bill-to FactBox")
            {
                ApplicationArea = all;
                Visible = false;
                SubPageLink = "No." = field("Bill-to Customer No.");
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = all;
                Visible = ShowWorkflowStatus;
                Enabled = false;
                Editable = false;
                ShowFilter = false;
            }
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Sales Header"),
                              "No." = field("No."),
                              "Document Type" = field("Document Type");
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
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                // action(Statistics)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Statistics';
                //     Image = Statistics;
                //     ShortCutKey = 'F7';
                //     ToolTip = 'View statistical information, such as the value of posted entries, for the record.';

                //     trigger OnAction()
                //     var
                //     // Handled: Boolean;
                //     begin
                //         Rec.OpenSalesOrderStatistics();
                //         CurrPage.SalesLines.Page.ForceTotalsCalculation();
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
                action(Customer)
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
                action(AssemblyOrders)
                {
                    AccessByPermission = TableData "BOM Component" = R;
                    ApplicationArea = Assembly;
                    Caption = 'Assembly Orders';
                    Image = AssemblyOrder;
                    ToolTip = 'View ongoing assembly orders related to the sales order. ';

                    trigger OnAction()
                    var
                        AssembleToOrderLink: Record "Assemble-to-Order Link";
                    begin
                        AssembleToOrderLink.ShowAsmOrders(Rec);
                    end;
                }
                action(DocAttach)
                {
                    ApplicationArea = Basic, Suite;
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
            group(ActionGroupCRM)
            {
                Caption = 'Dynamics 365 Sales';
                Visible = CRMIntegrationEnabled;
                action(CRMGoToSalesOrder)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Order';
                    Enabled = CRMIntegrationEnabled AND CRMIsCoupledToRecord;
                    Image = CoupledOrder;
                    ToolTip = 'View the selected sales order.';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowCRMEntityFromRecordID(Rec.RecordId);
                    end;
                }
                action(CRMSynchronizeNow)
                {
                    AccessByPermission = TableData "CRM Integration Record" = IM;
                    ApplicationArea = Suite;
                    Caption = 'Synchronize';
                    Image = Refresh;
                    ToolTip = 'Send updated data to Dynamics 365 Sales.';
                    Enabled = IsBidirectionalSyncEnabled and (Rec.Status = Rec.Status::Released);

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.UpdateOneNow(Rec.RecordId);
                    end;
                }
                group(Coupling)
                {
                    Caption = 'Coupling', Comment = 'Coupling is a noun';
                    Image = LinkAccount;
                    ToolTip = 'Create, change, or delete a coupling between the Business Central record and a Dynamics 365 Sales record.';
                    Enabled = IsBidirectionalSyncEnabled and (Rec.Status = Rec.Status::Released);
                    action(ManageCRMCoupling)
                    {
                        AccessByPermission = TableData "CRM Integration Record" = IM;
                        ApplicationArea = Suite;
                        Caption = 'Set Up Coupling';
                        Image = LinkAccount;
                        ToolTip = 'Create or modify the coupling to a Dynamics 365 Sales order.';

                        trigger OnAction()
                        var
                            CRMIntegrationManagement: Codeunit "CRM Integration Management";
                        begin
                            CRMIntegrationManagement.DefineCoupling(Rec.RecordId);
                        end;
                    }
                    action(DeleteCRMCoupling)
                    {
                        AccessByPermission = TableData "CRM Integration Record" = D;
                        ApplicationArea = Suite;
                        Caption = 'Delete Coupling';
                        Enabled = CRMIsCoupledToRecord;
                        Image = UnLinkAccount;
                        ToolTip = 'Delete the coupling to a Dynamics 365 Sales order.';

                        trigger OnAction()
                        var
                            SalesHeader: Record "Sales Header";
                            CRMCouplingManagement: Codeunit "CRM Coupling Management";
                            RecRef: RecordRef;
                        begin
                            CurrPage.SetSelectionFilter(SalesHeader);
                            RecRef.GetTable(SalesHeader);
                            CRMCouplingManagement.RemoveCoupling(RecRef);
                        end;
                    }
                }
                action(ShowLog)
                {
                    ApplicationArea = Suite;
                    Caption = 'Synchronization Log';
                    Image = Log;
                    ToolTip = 'View integration synchronization jobs for the sales order table.';
                    Enabled = IsBidirectionalSyncEnabled and (Rec.Status = Rec.Status::Released);

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowLog(Rec.RecordId);
                    end;
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action("S&hipments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'S&hipments';
                    Image = Shipment;
                    RunObject = Page "Posted Sales Shipment";
                    RunPageLink = "Order No." = field("No.");
                    RunPageView = sorting("Order No.");
                    ToolTip = 'View related posted sales shipments.';
                }
                action(Invoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Invoices';
                    Image = Invoice;
                    ToolTip = 'View a list of ongoing sales invoices for the order.';

                    trigger OnAction()
                    var
                        TempSalesInvoiceHeader: Record "Sales Invoice Header" temporary;
                        SalesGetShipment: Codeunit "Sales-Get Shipment";
                    begin
                        SalesGetShipment.GetSalesOrderInvoices(TempSalesInvoiceHeader, Rec."No.");
                        Page.Run(Page::"Posted Sales Invoices", TempSalesInvoiceHeader);
                    end;
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
                    RunPageLink = "Source Document" = const("Sales Order"),
                                  "Source No." = field("No.");
                    RunPageView = sorting("Source Document", "Source No.", "Location Code");
                    ToolTip = 'View items that are inbound or outbound on inventory put-away or inventory pick documents for the sales order.';
                }
                action("Warehouse Shipment Lines")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Warehouse Shipment Lines';
                    Image = ShipmentLines;
                    RunObject = Page "Whse. Shipment Lines";
#pragma warning disable AL0603
                    RunPageLink = "Source Type" = const(37), "Source Subtype" = field("Document Type"), "Source No." = field("No.");
#pragma warning restore AL0603
                    RunPageView = sorting("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                    ToolTip = 'View ongoing warehouse shipments for the document, in advanced warehouse configurations.';
                }
                action("Whse. Pick Lines")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Warehouse Pick Lines';
                    Image = PickLines;
                    RunObject = page "Warehouse Activity Lines";
                    RunPageLink = "Source Document" = const("Sales Order"), "Source No." = field("No.");
                    RunPageView = sorting("Source Type", "Source Subtype", "Source No.");
                    ToolTip = 'View items that are outbound on warehouse pick documents for the sales order.';
                }
            }
            group(Prepayment)
            {
                Caption = 'Prepayment';
                Image = Prepayment;
                action(PagePostedSalesPrepaymentInvoices)
                {
                    ApplicationArea = Prepayments;
                    Caption = 'Prepa&yment Invoices';
                    Image = PrepaymentInvoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Prepayment Order No." = field("No.");
                    RunPageView = sorting("Prepayment Order No.");
                    ToolTip = 'View related posted sales invoices that involve a prepayment. ';
                }
                action(PagePostedSalesPrepaymentCrMemos)
                {
                    ApplicationArea = Prepayments;
                    Caption = 'Prepayment Credi&t Memos';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page "Posted Sales Credit Memos";
                    RunPageLink = "Prepayment Order No." = field("No.");
                    RunPageView = sorting("Prepayment Order No.");
                    ToolTip = 'View related posted sales credit memos that involve a prepayment. ';
                }
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
            group(Exim1)
            {
                Caption = 'EXIM';
                action("Export_Information")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Export Information';
                    ToolTip = 'Specifies the Export Information';
                    Image = ViewDetails;
                    trigger OnAction()
                    var
                        Export: Record "LFS Export Information Header";
                        exportInfor: Page "LFS Export Information";
                    begin
                        export.SetRange("LFS Document Type", Rec."Document Type");
                        Export.SetRange("LFS Document No.", Rec."No.");
                        exportInfor.SetTableView(Export);
                        if Page.RunModal(Page::"LFS Export Information", Export) = action::LookupOK then begin
                            Export."LFS Document Type" := rec."Document Type";
                            Export."LFS Document No." := Rec."No.";
                        end;
                    end;
                }
                action("LFS Export Draft Invoice Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Commercial Draft Invoice';
                    ToolTip = 'Specifies the Export Draft Invoice';
                    // Enabled = Rec.Status = Rec.Status::Released;
                    Image = Report;
                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                        ExportDraftInvoice: Report "LFS Export Draft Invoice";
                    begin
                        Clear(ExportDraftInvoice);
                        SalesHeader.SetRange("No.", Rec."No.");
                        if SalesHeader.FindFirst() then begin
                            ExportDraftInvoice.SetTableView(SalesHeader);
                            ExportDraftInvoice.RunModal();
                        end;
                    end;
                }
                action("LFS Export Draft Packing List Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Commercial Draft Packing List';
                    ToolTip = 'Specifies the Export Draft Packing List';
                    // Enabled = Rec.Status = Rec.Status::Released;
                    Image = Report;
                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                        ExportDraftPackingList: Report "LFS Export Draft Packing List";
                    begin
                        Clear(ExportDraftPackingList);
                        SalesHeader.SetRange("No.", Rec."No.");
                        if SalesHeader.FindFirst() then begin
                            ExportDraftPackingList.SetTableView(SalesHeader);
                            ExportDraftPackingList.RunModal();
                        end;
                    end;
                }

                // action("LFS Work Order Report")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Work Order Report';
                //     ToolTip = 'Specifies the Work Order Report';
                //     Enabled = Rec.Status = Rec.Status::Released;
                //     Visible = false;
                //     Image = Report;
                //     trigger OnAction()
                //     var
                //         SalesHeader: Record "Sales Header";
                //         WorkOrderReport: Report "LFS WORK ORDER Report";
                //     begin
                //         Clear(WorkOrderReport);
                //         SalesHeader.SetRange("No.", Rec."No.");
                //         if SalesHeader.FindFirst() then begin
                //             WorkOrderReport.SetTableView(SalesHeader);
                //             WorkOrderReport.RunModal();
                //         end;
                //     end;
                // }
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
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
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
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
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
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
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
            group(Action21)
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
                        DimensionCodeValidation();
                        Rec.PerformManualRelease();
                        CurrPage.SalesLines.PAGE.ClearTotalSalesHeader();
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Basic, Suite;
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
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                group("Create Purchase Document")
                {
                    Caption = 'Create Purchase Document';
                    Image = NewPurchaseInvoice;
                    ToolTip = 'Create a new purchase document so you can buy items from a vendor.';
                    action(CreatePurchaseOrder)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Create Purchase Orders';
                        Image = Document;
                        ToolTip = 'Create one or more new purchase orders to buy the items that are required by this sales document, minus any quantity that is already available.';

                        trigger OnAction()
                        var
                            PurchDocFromSalesDoc: Codeunit "Purch. Doc. From Sales Doc.";
                        begin
                            PurchDocFromSalesDoc.CreatePurchaseOrder(Rec);
                        end;
                    }
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
                }
                action(CalculateInvoiceDiscount)
                {
                    AccessByPermission = TableData "Cust. Invoice Disc." = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;
                    ToolTip = 'Calculate the invoice discount that applies to the sales order.';

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc();
                        SalesCalcDiscountByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                action(GetRecurringSalesLines)
                {
                    ApplicationArea = Suite;
                    Caption = 'Get Recurring Sales Lines';
                    Ellipsis = true;
                    Image = CustomerCode;
                    ToolTip = 'Insert sales document lines that you have set up for the customer as recurring. Recurring sales lines could be for a monthly replenishment order or a fixed freight expense.';

                    trigger OnAction()
                    var
                        StdCustSalesCode: Record "Standard Customer Sales Code";
                    begin
                        StdCustSalesCode.InsertSalesLines(Rec);
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

                action(MoveNegativeLines)
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
                action("Archive Document")
                {
                    ApplicationArea = Suite;
                    Caption = 'Archi&ve Document';
                    Image = Archive;
                    ToolTip = 'Send the document to the archive, for example because it is too soon to delete it. Later, you delete or reprocess the archived document.';

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchiveSalesDocument(Rec);
                        CurrPage.Update(false);
                    end;
                }
                action("Send IC Sales Order")
                {
                    AccessByPermission = TableData "IC G/L Account" = R;
                    ApplicationArea = Intercompany;
                    Caption = 'Send IC Sales Order';
                    Image = IntercompanyOrder;
                    ToolTip = 'Send the sales order to the intercompany outbox or directly to the intercompany partner if automatic transaction sending is enabled.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
                    // ICFeedback: Codeunit "IC Feedback";
                    begin
                        Rec.TestField("IC Direction", Rec."IC Direction"::Outgoing);
                        if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then
                            ICInOutboxMgt.SendSalesDoc(Rec, false);
                    end;
                }
                action("Reject IC Sales Order")
                {
                    ApplicationArea = Intercompany;
                    Caption = 'Reject IC Sales Order';
                    Enabled = RejectICSalesOrderEnabled;
                    Image = Cancel;
                    ToolTip = 'Deletes the order and sends the rejection to the company that created it.';

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
            group(Plan)
            {
                Caption = 'Plan';
                Image = Planning;
                action(OrderPromising)
                {
                    AccessByPermission = TableData "Order Promising Line" = R;
                    ApplicationArea = OrderPromising;
                    Caption = 'Order &Promising';
                    Image = OrderPromising;
                    ToolTip = 'Calculate the shipment and delivery dates based on the item''s known and expected availability dates, and then promise the dates to the customer.';

                    trigger OnAction()
                    var
                        TempOrderPromisingLine: Record "Order Promising Line" temporary;
                    begin
                        TempOrderPromisingLine.SetRange("Source Type", Rec."Document Type");
                        TempOrderPromisingLine.SetRange("Source ID", Rec."No.");
                        PAGE.RunModal(PAGE::"Order Promising Lines", TempOrderPromisingLine);
                    end;
                }
                action("Demand Overview")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Demand Overview';
                    Image = Forecast;
                    ToolTip = 'Get an overview of demand for your items when planning sales, production, jobs, or service management and when they will be available.';

                    trigger OnAction()
                    var
                        DemandOverview: Page "Demand Overview";
                        DemandOrderSourceType: Enum "Demand Order Source Type";
                    begin
                        DemandOverview.SetCalculationParameter(true);
                        // DemandOverview.Initialize(0D, 1, Rec."No.", '', '');
                        DemandOverview.SetParameters(0D, DemandOrderSourceType::"Production Demand", Rec."No.", '', '');
                        DemandOverview.RunModal();
                    end;
                }
                action("Pla&nning")
                {
                    ApplicationArea = Planning;
                    Caption = 'Pla&nning';
                    Image = Planning;
                    ToolTip = 'Open a tool for manual supply planning that displays all new demand along with availability information and suggestions for supply. It provides the visibility and tools needed to plan for demand from sales lines and component lines and then create different types of supply orders directly.';

                    trigger OnAction()
                    var
                        SalesPlanForm: Page "Sales Order Planning";
                    begin
                        SalesPlanForm.SetSalesOrder(Rec."No.");
                        SalesPlanForm.RunModal();
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
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
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    end;
                }
            }
            group(Action3)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("Create Inventor&y Put-away/Pick")
                {
                    AccessByPermission = TableData "Posted Invt. Pick Header" = R;
                    ApplicationArea = Warehouse;
                    Caption = 'Create Inventor&y Put-away/Pick';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;
                    ToolTip = 'Create an inventory put-away or inventory pick to handle items on the document according to a basic warehouse configuration that does not require warehouse receipt or shipment documents.';

                    trigger OnAction()
                    begin
                        Rec.PerformManualRelease();
                        Rec.CreateInvtPutAwayPick();

                        if not Rec.Find('=><') then
                            Rec.Init();
                    end;
                }
                action("Create &Warehouse Shipment")
                {
                    AccessByPermission = TableData "Warehouse Shipment Header" = R;
                    ApplicationArea = Warehouse;
                    Caption = 'Create &Warehouse Shipment';
                    Image = NewShipment;
                    ToolTip = 'Create a warehouse shipment to start a pick a ship process according to an advanced warehouse configuration.';

                    trigger OnAction()
                    var
                        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    begin
                        Rec.PerformManualRelease();
                        GetSourceDocOutbound.CreateFromSalesOrder(Rec);

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
                    ApplicationArea = Basic, Suite;
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    AboutTitle = 'Posting the order';
                    AboutText = 'Posting will ship or invoice the quantities on the order, or both. **Post** and **Send** can save the order as a file, print it, or attach it to an email, all in one go.';

                    trigger OnAction()
                    begin
                        Rec.TestField(Rec."Posting No.");
                        DimensionCodeValidation();
                        PackingListValidation();
                        PostSalesOrder(CODEUNIT::"Sales-Post (Yes/No)", Enum::"Navigate After Posting"::"Posted Document");
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
                        PostSalesOrder(CODEUNIT::"Sales-Post (Yes/No)", Enum::"Navigate After Posting"::"New Document");
                    end;
                }
                action(PostAndSend)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post and Send';
                    Ellipsis = true;
                    Image = PostMail;
                    ToolTip = 'Finalize and prepare to send the document according to the customer''s sending profile, such as attached to an email. The Send document to window opens first so you can confirm or select a sending profile.';

                    trigger OnAction()
                    begin
                        PostSalesOrder(CODEUNIT::"Sales-Post and Send", Enum::"Navigate After Posting"::"Do Nothing");
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
                    ApplicationArea = All;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    ToolTip = 'Remove the scheduled processing of this record from the job queue.';
                    Visible = JobQueueVisible;

                    trigger OnAction()
                    begin
                        Rec.CancelBackgroundPosting();
                    end;
                }
                action(PreviewPosting)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    ShortCutKey = 'Ctrl+Alt+F9';
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                    trigger OnAction()
                    begin
                        Rec.TestField(Rec."Posting No.");
                        DimensionCodeValidation();
                        PackingListValidation();
                        ShowPreview();
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
                    begin
                        DocPrint.PrintProformaSalesInvoice(Rec);
                    end;
                }
                group("Prepa&yment")
                {
                    Caption = 'Prepa&yment';
                    Image = Prepayment;
                    action("Prepayment &Test Report")
                    {
                        ApplicationArea = Prepayments;
                        Caption = 'Prepayment &Test Report';
                        Ellipsis = true;
                        Image = PrepaymentSimulation;
                        ToolTip = 'Preview the prepayment transactions that will results from posting the sales document as invoiced. ';

                        trigger OnAction()
                        begin
                            ReportPrint.PrintSalesHeaderPrepmt(Rec);
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
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                            if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then
                                SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec, false);
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
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                            if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then
                                SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec, true);
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
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                            if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then
                                SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec, false);
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
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                            if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then
                                SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec, true);
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
            group("&Print")
            {
                Caption = '&Print';
                Image = Print;
                action("Work Order")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Work Order';
                    Ellipsis = true;
                    Image = Print;
                    ToolTip = 'Prepare to registers actual item quantities or time used in connection with the sales order. For example, the document can be used by staff who perform any kind of processing work in connection with the sales order. It can also be exported to Excel if you need to process the sales line data further.';

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Work Order");
                    end;
                }
                action("Pick Instruction")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Pick Instruction';
                    Image = Print;
                    ToolTip = 'Print a picking list that shows which items to pick and ship for the sales order. if an item is assembled to order, then the report includes rows for the assembly components that must be picked. Use this report as a pick instruction to employees in charge of picking sales items or assembly components for the sales order.';

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Pick Instruction");
                    end;
                }
            }
            group("&Order Confirmation")
            {
                Caption = '&Order Confirmation';
                Image = Email;
                action(SendEmailConfirmation)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Email Confirmation';
                    Ellipsis = true;
                    Image = Email;
                    ToolTip = 'Send a sales order confirmation by email. The attachment is sent as a .pdf.';

                    trigger OnAction()
                    begin
                        DocPrint.EmailSalesHeader(Rec);
                    end;
                }
                group(Action96)
                {
                    action("Print Confirmation")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Print Confirmation';
                        Ellipsis = true;
                        Image = Print;
                        ToolTip = 'Print a sales order confirmation.';
                        Visible = NOT IsOfficeHost;

                        trigger OnAction()
                        begin
                            DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
                        end;
                    }
                    action(AttachAsPDF)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Attach as PDF';
                        Ellipsis = true;
                        Image = PrintAttachment;
                        ToolTip = 'Create a PDF file and attach it to the document.';

                        trigger OnAction()
                        var
                            SalesHeader: Record "Sales Header";
                        begin
                            SalesHeader := Rec;
                            SalesHeader.SetRecFilter();
                            DocPrint.PrintSalesOrderToDocumentAttachment(SalesHeader, DocPrint.GetSalesOrderPrintToAttachmentOption(Rec));
                        end;
                    }
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
                    actionref(PostAndSend_Promoted; PostAndSend)
                    {
                    }
                    actionref(PreviewPosting_Promoted; PreviewPosting)
                    {
                    }
                    actionref(PostAndNew_Promoted; PostAndNew)
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
                actionref("Create &Warehouse Shipment_Promoted"; "Create &Warehouse Shipment")
                {
                }
                actionref("Create Inventor&y Put-away/Pick_Promoted"; "Create Inventor&y Put-away/Pick")
                {
                }
                actionref("Archive Document_Promoted"; "Archive Document")
                {
                }
            }
            group(Category_Category7)
            {
                Caption = 'Prepare', Comment = 'Generated from the PromotedActionCategories property index 6.';

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
            group(Category_Category11)
            {
                Caption = 'Print/Send', Comment = 'Generated from the PromotedActionCategories property index 10.';

                actionref(SendEmailConfirmation_Promoted; SendEmailConfirmation)
                {
                }
                actionref("Print Confirmation_Promoted"; "Print Confirmation")
                {
                }
                actionref("Pick Instruction_Promoted"; "Pick Instruction")
                {
                }
                actionref(AttachAsPDF_Promoted; AttachAsPDF)
                {
                }
                actionref("Work Order_Promoted"; "Work Order")
                {
                }
                actionref(ProformaInvoice_Promoted; ProformaInvoice)
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
                actionref(Statistics_Promoted; SalesOrderStatistics)
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
                actionref(Customer_Promoted; Customer)
                {
                }
                actionref("S&hipments_Promoted"; "S&hipments")
                {
                }
            }
            group(Category_Category13)
            {
                Caption = 'EXIM';
                actionref(Export_Information_promoted; Export_Information)
                { }
                actionref(ExportDraftInvocie_Promoted; "LFS Export Draft Invoice Report")
                {
                }
                actionref(ExportDraftPAcking; "LFS Export Draft Packing List Report")
                {
                }
                // actionref(ExportCommDraftInvoice; "LFS Export Comm. Draft Invoice Report")
                // {
                // }
                // actionref(ExportCommDraftPAcking; "LFS Export Comm. Draft Packing List Report")
                // {
                // }
                // actionref(WorkOrderReport_Promoted; "LFS Work Order Report")
                // { }
            }
            group(Category_Category10)
            {
                Caption = 'History', Comment = 'Generated from the PromotedActionCategories property index 9.';
            }
            group(Category_Category12)
            {
                Caption = 'Navigate', Comment = 'Generated from the PromotedActionCategories property index 11.';
            }
            group(Category_Report)
            {
                Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';
            }
            group(Category_Synchronize)
            {
                Caption = 'Synchronize';
                Visible = CRMIntegrationEnabled;

                actionref(CRMGoToSalesOrder_Promoted; CRMGoToSalesOrder)
                {
                }
                group(Category_Coupling)
                {
                    Caption = 'Coupling';
                    ShowAs = SplitButton;

                    actionref(ManageCRMCoupling_Promoted; ManageCRMCoupling)
                    {
                    }
                    actionref(DeleteCRMCoupling_Promoted; DeleteCRMCoupling)
                    {
                    }
                }
                actionref(ShowLog_Promoted; ShowLog)
                {
                }
                actionref(CRMSynchronizeNow_Promoted; CRMSynchronizeNow)
                {
                }
            }
        }
    }

    trigger OnInit()
    begin
        Clear(ReturnOrderNoVisible);
        ReturnOrderNoVisible := true;
        SetExtDocNoMandatoryCondition();
    end;

    trigger OnOpenPage()
    var
        // CRMIntegrationManagement: Codeunit "CRM Integration Management";
        CRMConnectionSetup: Record "CRM Connection Setup";
        ICInboxOutboxMgt: Codeunit ICInboxOutboxMgt;
        OfficeMgt: Codeunit "Office Management";
    begin
        if UserMgt.GetSalesFilter() <> '' then begin
            Rec.FILTERGROUP(2);
            REc.SETRANGE("Responsibility Center", UserMgt.GetSalesFilter());
            Rec.FILTERGROUP(0);
        end;

        Rec.SETRANGE("Date Filter", 0D, WORKDATE() - 1);

        // Rec."GST Without Payment of Duty" := true;
        if CRMIntegrationEnabled then
            IsBidirectionalSyncEnabled := CRMConnectionSetup.IsBidirectionalSalesOrderIntEnabled();
        RejectICSalesOrderEnabled := ICInboxOutboxMgt.IsSalesHeaderFromIncomingIC(Rec);
        IsOfficeHost := OfficeMgt.IsAvailable();
        IsShipToCountyVisible := FormatAddress.UseCounty(Rec."Ship-to Country/Region Code");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        REc."LFS EXIM Type" := Rec."LFS EXIM Type"::Export;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        REc."LFS EXIM Type" := Rec."LFS EXIM Type"::Export;
    end;


    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD();
        EXIT(REc.ConfirmDeletion());
    end;

    trigger OnAfterGetRecord()
    var
        ICInboxOutboxMgt: Codeunit ICInboxOutboxMgt;
    begin
        WorkDescription := Rec.GetWorkDescription();
        RejectICSalesOrderEnabled := ICInboxOutboxMgt.IsSalesHeaderFromIncomingIC(Rec);
        SetControlVisibility();
    end;

    trigger OnAfterGetCurrRecord()
    var
    // CRMCouplingManagement: Codeunit "CRM Coupling Management";
    begin
        SetControlVisibility();
    end;


    var
        MoveNegSalesLines: Report "Move Negative Sales Lines";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ArchiveManagement: Codeunit ArchiveManagement;
        DocPrint: Codeunit "Document-Print";
        FormatAddress: Codeunit "Format Address";
        SalesCalcDiscountByType: Codeunit "Sales - Calc Discount By Type";
        // CopySalesDoc: Report "Copy Sales Document";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        ChangeExchangeRate: Page "Change Exchange Rate";
        ChangeCustomExchangeRate: Page "LFSChange Custom Exchange Rate";
        WorkDescription: Text;
        CanCancelApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        DocumentIsPosted: Boolean;
        DocumentIsScheduledForPosting: Boolean;
        // DocNoVisible: Boolean;
        ExternalDocNoMandatory: Boolean;
        GSTLocRegNo: Boolean;
        // DynamicEditable: Boolean;
        HasIncomingDocument: Boolean;
        IsBidirectionalSyncEnabled: Boolean;
        // IsRateChangeEnabled: Boolean;
        // EditableGSTwpayDuty: Boolean;
        // sales: Page "Sales Order";
        IsCustomerOrContactNotEmpty: Boolean;
        IsOfficeHost: Boolean;

        IsShipToCountyVisible: Boolean;
        // SalesLine: Record "Sales Line";
        JobQueueVisible: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        RejectICSalesOrderEnabled: Boolean;
        ReturnOrderNoVisible: Boolean;
        ShowWorkflowStatus: Boolean;
        ShipToOptions: Enum "Sales Ship-to Options";
        EmptyShipToCodeErr: Label 'The Code field can only be empty if you select Custom Address in the Ship-to field.';
        OpenPostedSalesOrderQst: Label 'The order is posted as number %1 and moved to the Posted Sales Invoices window.\\Do you want to open the posted invoice?', Comment = '%1 = posted document number';
        SureToRejectMsg: Label 'Rejecting this order will remove it from your company and send it back to the partner company.\\Do you want to continue?';
        Usage: Option "Order Confirmation","Work Order","Pick Instruction";

    var
        CGSTAmt, CGSTPer, IGSTAmt, IGSTPer, SGSTAmt, SGSTPer, TCSTransactionAmount, TotalGSTAmt : Decimal;

    Procedure DimensionCodeValidation()
    begin
        Rec.TestField("Shortcut Dimension 1 Code");
        Rec.TestField("Shortcut Dimension 2 Code");
    end;

    Procedure PackingListValidation()
    var
        LFSPackingList: Record "LFS EXIM Packing List Tab.";
        SalesLine: Record "Sales Line";
        TotalPackingQty: Decimal;
    begin
        SalesLine.SetRange("Document No.", Rec."No.");
        SalesLine.SetRange("Document Type", Rec."Document Type");
        SalesLine.SetRange("LFS EXIM Type", Rec."LFS EXIM Type");
        SalesLine.SetFilter("Qty. to Ship (Base)", '>%1', 0);
        if SalesLine.FindSet() then
            repeat
                Clear(TotalPackingQty);
                LFSPackingList.SetRange("LFS Source Document No.", SalesLine."Document No.");
                LFSPackingList.SetRange("LFS Source Doc. Line No.", SalesLine."Line No.");
                LFSPackingList.SetRange("LFS Source Order No.", SalesLine."Document No.");
                LFSPackingList.SetRange("LFS Source Order Line No.", SalesLine."Line No.");
                LFSPackingList.SetRange("LFS Source Document Type", LFSPackingList."LFS Source Document Type"::"Sales Order");
                if LFSPackingList.FindSet() then
                    repeat
                        TotalPackingQty += LFSPackingList."LFS Total Quantity in Pack";
                    until LFSPackingList.Next() = 0;
                if (SalesLine."Qty. to Ship (Base)" <> TotalPackingQty) and (SalesLine.Type = SalesLine.Type::Item) then
                    Error('Packing List Quantity is not matching with Quantity to Ship for Item : %1 and Variant : %2 and Line No.: %3', SalesLine."No.", SalesLine."Variant Code", SalesLine."Line No.");
            until SalesLine.Next() = 0;
    end;

    protected procedure PostSalesOrder(PostingCodeunitID: Integer; Navigate: Enum "Navigate After Posting")
    var
        SalesHeader: Record "Sales Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
    // IsHandled: Boolean;
    begin
        LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);

        Rec.SendToPosting(PostingCodeunitID);

        DocumentIsScheduledForPosting := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        DocumentIsPosted := (not SalesHeader.Get(Rec."Document Type", Rec."No.")) or DocumentIsScheduledForPosting;


        CurrPage.Update(false);


        if PostingCodeunitID <> CODEUNIT::"Sales-Post (Yes/No)" then
            exit;

        case Navigate of
            Enum::"Navigate After Posting"::"Posted Document":
                begin
                    if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode()) then
                        ShowPostedConfirmationMessage();

                    if DocumentIsScheduledForPosting or DocumentIsPosted then
                        CurrPage.Close();
                end;
            Enum::"Navigate After Posting"::"New Document":
                if DocumentIsPosted then begin
                    Clear(SalesHeader);
                    SalesHeader.Init();
                    SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Order);
                    SalesHeader.Insert(true);
                    PAGE.Run(PAGE::"Sales Order", SalesHeader);
                end;
        end;
    end;

    // local procedure SetLocGSTRegNoEditable()
    // begin
    // end;

    // local procedure CheckMultipleLicenseTotalQty()
    // var
    //     SalesLine: Record "Sales Line";
    //     EXIM_License: Record "LFS EXIM Export License";
    //     // EximLicense1: Record "LFS EXIM Export License";
    //     // eximLicenseHeader: Record "LFS EXIM  License Header";
    //     sumQty: Decimal;
    // begin
    //     sumQty := 0;
    //     SalesLine.SetRange("Document No.", Rec."No.");
    //     SalesLine.SetRange("Document Type", Rec."Document Type");
    //     if SalesLine.Findset() then
    //         repeat
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

    // local procedure checkPackingLinesQty()
    // var
    //     Packing: record "LFS EXIM Packing List Tab.";
    //     SalesLine: Record "Sales Line";
    //     // Packing2: Record "LFS Packing List";
    //     // reservation: Record "Reservation Entry";
    //     SumTotalQtyInPack: Decimal;
    // begin
    //     SalesLine.setrange("Document No.", Rec."No.");
    //     SalesLine.setrange("Document Type", SalesLine."Document Type"::Order);
    //     Salesline.setrange(type, salesline.Type::Item);
    //     if SalesLine.Findset() then
    //         repeat
    //             SumTotalQtyInPack := 0;
    //             Packing.SetRange("LFS Source Document No.", rec."No.");
    //             Packing.SetRange("LFS Source Doc. Line No.", SalesLine."Line No.");
    //             if packing.Findset() then begin
    //                 repeat
    //                     SumTotalQtyInPack += packing."LFS Total Quantity in Pack";
    //                 until packing.Next() = 0;
    //                 if SumTotalQtyInPack > SalesLine."Qty. to Ship (Base)" then
    //                     Error('Sum of total Qty in Pack Should not exceed Qty. to Ship in line No. %1', SalesLine."Line No.");
    //             end;
    //         until SalesLine.Next() = 0;
    // end;

    // local procedure qtyInEachPack()
    // var
    //     Packing: record "LFS Packing List";
    //     reservation: Record "Reservation Entry";
    //     Salesline: record "Sales Line";
    //     SumQtyInEachPack: decimal;
    //     // SumTotalQtyInPack: Decimal;
    //     QtytoHandle: Decimal;
    // begin
    //     SalesLine.setrange("Document No.", Rec."No.");
    //     SalesLine.setrange("Document Type", SalesLine."Document Type"::Order);
    //     Salesline.setrange(type, salesline.Type::Item);
    //     if Salesline.Findset() then
    //         repeat
    //             reservation.SetRange("Item No.", Salesline."No.");
    //             reservation.SetRange("Source ID", Salesline."Document No.");
    //             reservation.SetRange("Source Ref. No.", Salesline."Line No.");
    //             if reservation.Findset() then begin
    //                 repeat
    //                     SumQtyInEachPack := 0;
    //                     QtytoHandle := 0;
    //                     Packing.SetRange("LFS Item Code", reservation."Item No.");
    //                     Packing.SetRange("LFS Source Order No.", reservation."Source ID");
    //                     Packing.SetRange("LFS Source Doc. Line No.", reservation."Source Ref. No.");
    //                     Packing.SetRange("LFS Lot No.", reservation."Lot No.");
    //                     if Packing.Findset() then begin
    //                         repeat
    //                             SumQtyInEachPack += Packing."LFS Total Quantity in Pack";
    //                         until Packing.Next() = 0;
    //                         QtytoHandle += reservation."Qty. to Handle (Base)";
    //                     end;
    //                 until reservation.Next() = 0;
    //                 if not (SumQtyInEachPack = abs(QtytoHandle)) then
    //                     Error('Sum of "Total Quantity in Pack" Should be equal to "Qty. to handle" in Item tracking Lot No. %1, Line No. %2', reservation."Lot No.", reservation."Source Ref. No.");
    //             end;
    //         until Salesline.Next() = 0;
    // end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.SalesLines.PAGE.ApproveCalcInvDisc();
    end;



    local procedure BilltoCustomerNoOnAfterValidat()
    begin
        CurrPage.Update();
    end;

    // local procedure Post(PostingCodeunitID: Integer)
    // begin
    //     Rec.SendToPosting(PostingCodeunitID);
    //     if Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting" then
    //         CurrPage.CLOSE();
    //     CurrPage.UPDATE(FALSE);
    // end;

    // local procedure PerformManualRelease()
    // var
    //     ReleaseSalesDoc: Codeunit "Release Sales Document";
    // begin
    //     if Rec.Status <> Rec.Status::Released then begin
    //         ReleaseSalesDoc.PerformManualRelease(Rec);
    //         Commit();
    //     end;
    // end;

    local procedure SelltoCustomerNoOnAfterValidat()
    begin
        if Rec.GETFILTER("Sell-to Customer No.") = xRec."Sell-to Customer No." then
            if Rec."Sell-to Customer No." <> xRec."Sell-to Customer No." then
                Rec.SETRANGE("Sell-to Customer No.");
        CurrPage.UPDATE();
    end;

    local procedure SetControlVisibility()
    var
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        JobQueueVisible := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        SetExtDocNoMandatoryCondition();

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
        IsCustomerOrContactNotEmpty := (Rec."Sell-to Customer No." <> '') or (Rec."Sell-to Contact No." <> '');
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
    end;

    // local procedure ShortcutDimension1CodeOnAfterV()
    // begin
    //     CurrPage.Update();
    // end;

    // local procedure ShortcutDimension2CodeOnAfterV()
    // begin
    //     CurrPage.Update();
    // end;

    // local procedure PricesIncludingVATOnAfterValid()
    // begin
    //     CurrPage.Update();
    // end;

    // local procedure Prepayment37OnAfterValidate()
    // begin
    //     CurrPage.Update();
    // end;

    // local procedure ReDispatchOnPush()
    // begin
    // end;

    // local procedure SetDocNoVisible()
    // var
    //     DocumentNoVisibility: Codeunit DocumentNoVisibility;
    //     DocType: Option Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    // begin
    //     DocNoVisible := DocumentNoVisibility.SalesDocumentNoIsVisible(DocType::Order, Rec."No.");
    // end;

    local procedure SetExtDocNoMandatoryCondition()
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        SalesReceivablesSetup.GET();
        ExternalDocNoMandatory := SalesReceivablesSetup."Ext. Doc. No. Mandatory"
    end;

    local procedure ShowPostedConfirmationMessage()
    var
        OrderSalesHeader: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    // ICFeedback: Codeunit "IC Feedback";
    begin
        if not OrderSalesHeader.Get(Rec."Document Type", Rec."No.") then begin
            SalesInvoiceHeader.SetRange("No.", Rec."Last Posting No.");
            if SalesInvoiceHeader.FindFirst() then
                if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedSalesOrderQst, SalesInvoiceHeader."No."),
                     InstructionMgt.ShowPostedConfirmationMessageCode())
                then
                    InstructionMgt.ShowPostedDocument(SalesInvoiceHeader, Page::"Sales Order");
        end;
    end;

    local procedure ShowPrepmtCrMemoPreview()
    var
        SalesPostPrepaymentYesNo: Codeunit "Sales-Post Prepayment (Yes/No)";
    begin
        SalesPostPrepaymentYesNo.Preview(Rec, 3);
    end;

    local procedure ShowPrepmtInvoicePreview()
    var
        SalesPostPrepaymentYesNo: Codeunit "Sales-Post Prepayment (Yes/No)";
    begin
        SalesPostPrepaymentYesNo.Preview(Rec, 2);
    end;

    local procedure ShowPreview()
    var
        SalesPostYesNo: Codeunit "Sales-Post (Yes/No)";
    begin
        SalesPostYesNo.Preview(Rec);
    end;

}