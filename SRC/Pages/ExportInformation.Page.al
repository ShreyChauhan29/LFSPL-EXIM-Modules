namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Purchases.Vendor;
using Microsoft.Sales.Document;

page 72040 "LFS Export Information"
{
    ApplicationArea = All;
    Caption = 'Export Information Card';
    PageType = Card;
    SourceTable = "LFS Export Information Header";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Document No."; Rec."LFS Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Document No.';
                    Editable = false;
                }
                // field("LFS Customer Order No."; Rec."LFS Customer Order No.")
                // {
                //     ToolTip = 'Specifies the value of the Customer Order No. 2 field.', Comment = '%';
                // }
                // field("LFS Customer Order Date 2"; Rec."LFS Customer Order Date 2")
                // {
                //     ToolTip = 'Specifies the value of the Customer Order Date 2 field.', Comment = '%';
                // }
                field("LFS Shipping Bill No."; Rec."LFS Shipping Bill No.")
                {
                    Caption = 'Shipping Bill No.';
                    ToolTip = 'Specifies the Shipping Bill No.';
                    ApplicationArea = All;
                }
                field("LFS Shipping Bill Date"; Rec."LFS Shipping Bill Date")
                {
                    Caption = 'Shipping Bill Date';
                    ToolTip = 'Specifies the Shipping Bill Date';
                    ApplicationArea = All;
                }
                field("BL No/ AWB No."; Rec."LFS BL No/ AWB No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the BL No/ AWB No.';
                }
                field("BL Date/ AWB Date"; Rec."LFS BL Date/ AWB Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the BL Date/ AWB Date';
                }
                field("LC No."; Rec."LFS LC No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the LC No.';
                }
                field("LC Date"; Rec."LFS LC Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the LC Date';
                }
                // field("LFS Latest Date of Shipment"; Rec."LFS Latest Date of Shipment")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the Latest Date of Shipment ';
                // }
                field("LFS LC Expiry Date"; Rec."LFS LC Expiry Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the LC Expiry Date';
                }
                field("Vessel/Flight No."; Rec."LFS Vessel/Flight No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Vessel/Flight No.';
                }
                field("LFS ETD"; Rec."LFS ETD")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the ETD';
                }
                field("LFS ETA"; Rec."LFS ETA")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the ETA';
                }
            }
            // group("Other Information")
            // {
            // field("LFS HS Code"; Rec."LFS HS Code")
            // {
            //     Caption = 'Party HS Code';
            //     ToolTip = 'Specifies the Party HS Code';
            //     ApplicationArea = All;
            // }
            // field("Description of Goods"; Rec."LFS Description of Goods")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Container Details';
            //     ToolTip = 'Specifies the Container Details';
            // }
            // field("Sp Notes"; Rec."LFS Sp Notes")
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Specifies the Sp Notes';
            // }
            // field("LFS Palletization"; Rec."LFS Palletization")
            // {
            //     ToolTip = 'Specifies the value of the Palletization (If Required) field.', Comment = '%';
            // }
            // field("Dispatch Instruction"; Rec."LFS Dispatch Instruction")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Forms Requirement';
            //     ToolTip = 'Specifies the Forms Requirement';
            // }
            // field("LFS Pre-Shipment Sample"; Rec."LFS Pre-Shipment Sample")
            // {
            //     ToolTip = 'Specifies the value of the Pre-Shipment Sample Required field.', Comment = '%';
            // }
            // field("LFS Shipping Marks"; Rec."LFS Shipping Marks")
            // {
            //     ToolTip = 'Specifies the value of the EX_Shipping Marks Required field.', Comment = '%';
            // }
            // field("LFS Notes"; Rec."LFS Notes")
            // {
            //     ToolTip = 'Specifies the value of the Notes field.', Comment = '%';
            // }
            // }
            group(Agent)
            {
                Editable = IsEditable;
                field("Agent Code"; Rec."LFS Agent Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Agent Code';
                    Lookup = true;
                    LookupPageId = "Vendor List";
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        vendor: Record Vendor;
                        VendorList: Page "Vendor List";
                    begin
                        vendor.SetRange("LFS Agent Code", true);
                        VendorList.LookupMode(true);
                        VendorList.SetTableView(vendor);
                        if Page.RunModal(Page::"Vendor List", vendor) = Action::LookupOK then begin
                            Rec."LFS Agent Code" := vendor."No.";
                            Rec."LFS Agent Name" := Vendor.Name;
                            Rec."LFS Address1" := Vendor.Address;
                            Rec."LFS Address2" := Vendor."Address 2";
                            Rec.Validate("LFS City", Vendor.City);
                            Rec."LFS Tel No." := Vendor."Phone No.";
                            Rec."LFS Mobile No." := Vendor."Mobile Phone No.";
                        end;

                    end;
                }
                field("Agent Name"; Rec."LFS Agent Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Agent Name';
                }
                field("Contact Person"; Rec."LFS Contact Person")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Contact Person';
                }
                field(Address1; Rec."LFS Address1")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Address1';
                }
                field(Address2; Rec."LFS Address2")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Address2';
                }
                field(City; Rec."LFS City")
                {
                    ToolTip = 'Specifies the City';
                    ApplicationArea = all;
                }
                field(Pin; Rec."LFS Pin")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Pin';
                }
                field("Tel No."; Rec."LFS Tel No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Tel No.';
                }
                field("Mobile No."; Rec."LFS Mobile No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Mobile No.';
                }
                field(Email; Rec."LFS Email")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Email';
                }
            }
            // group("Check List")
            // {
            //     Editable = IsEditable;
            //     field("LFS Full Set Clean- BOL"; Rec."LFS Full Set Clean- BOL")
            //     {
            //         ToolTip = 'Specifies the value of the Full Set Clean- Bill of Lading field.', Comment = '%';
            //     }
            //     field("LFS Air Way Bill"; Rec."LFS Air Way Bill")
            //     {
            //         ToolTip = 'Specifies the value of the Air Way Bill field.', Comment = '%';
            //     }
            //     field("LFS Signed Comm. Inv. Org."; Rec."LFS Signed Comm. Inv. Org.")
            //     {
            //         ToolTip = 'Specifies the value of the Signed Commercial Inv. Org. field.', Comment = '%';
            //     }
            //     field("LFS Certificate Of Origin"; Rec."LFS Certificate Of Origin")
            //     {
            //         ToolTip = 'Specifies the value of the Certificate Of Origin field.', Comment = '%';
            //     }
            //     field("LFS Pack List in Four fold"; Rec."LFS Pack List in Four fold")
            //     {
            //         ToolTip = 'Specifies the value of the Packing List in Four fold field.', Comment = '%';
            //     }
            //     field("LFS Copy of the Certificate"; Rec."LFS Copy of the Certificate")
            //     {
            //         ToolTip = 'Specifies the value of the Copy of the Certificate field.', Comment = '%';
            //     }
            //     field("LFS Cert. of Insurance"; Rec."LFS Cert. of Insurance")
            //     {
            //         ToolTip = 'Specifies the value of the Certificate of Insurance field.', Comment = '%';
            //     }
            //     field("LFS Doc. will be forwarded"; Rec."LFS Doc. will be forwarded")
            //     {
            //         ToolTip = 'Specifies the value of the Document will be forwarded field.', Comment = '%';
            //     }
            //     field("LFS non-Neg doc frwd 7 days"; Rec."LFS non-Neg doc frwd 7 days")
            //     {
            //         ToolTip = 'Specifies the value of the non-Neg doc frwd 7 days field.', Comment = '%';
            //     }
            //     field("LFS non-Neg doc frwd 3 days"; Rec."LFS non-Neg doc frwd 3 days")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the value of the non-Neg doc frwd 3 days field.', Comment = '%';
            //     }
            //     field("LFS Form"; Rec."LFS Form")
            //     {
            //         ToolTip = 'Specifies the value of the Form field.', Comment = '%';
            //     }
            //     field("LFS Shipping Period"; Rec."LFS Shipping Period")
            //     {
            //         ToolTip = 'Specifies the value of the Shipping Period field.', Comment = '%';
            //     }
            // }
            // group("Information")
            // {
            //     Editable = IsEditable;
            //     field("LFS Your Ref No."; Rec."LFS Your Ref No.")
            //     {
            //         ToolTip = 'Specifies the value of the Your Ref No. field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS Your Ref Date"; Rec."LFS Your Ref Date")
            //     {
            //         ToolTip = 'Specifies the value of the Your Ref Date field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS P.O Receive Date"; Rec."LFS P.O Receive Date")
            //     {
            //         ToolTip = 'Specifies the value of the P.O Receive Date field.', Comment = '%';
            //     }
            //     field("LFS Delivery Terms"; Rec."LFS Delivery Terms")
            //     {
            //         ToolTip = 'Specifies the value of the Delivery Terms field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS Delivery Address"; Rec."LFS Delivery Address")
            //     {
            //         ToolTip = 'Specifies the value of the Delivery Address field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS Dispatch Mode"; Rec."LFS Dispatch Mode")
            //     {
            //         ToolTip = 'Specifies the value of the Dispatch Mode field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS BuyerOtherthanConsignee"; Rec."LFS BuyerOtherthanConsignee")
            //     {
            //         ToolTip = 'Specifies the value of the Buyer(if other than Consignee) field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS Payment Terms"; Rec."LFS Payment Terms")
            //     {
            //         ToolTip = 'Specifies the value of the Payment Terms field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS Contact Person1"; Rec."LFS Contact Person1")
            //     {
            //         ToolTip = 'Specifies the value of the Contact Person1 field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS Ship By"; Rec."LFS Ship By")
            //     {
            //         ToolTip = 'Specifies the value of the Ship By field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS Paying Agent"; Rec."LFS Paying Agent")
            //     {
            //         ToolTip = 'Specifies the value of the Paying Agent field.', Comment = '%';
            //     }
            //     field("LFS Our Bank"; Rec."LFS Our Bank")
            //     {
            //         ToolTip = 'Specifies the value of the Our Bank field.', Comment = '%';
            //     }
            //     field("LFS Customer (Bank Details)"; Rec."LFS Customer (Bank Details)")
            //     {
            //         ToolTip = 'Specifies the value of the Customer (Bank Details) field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS Carrier Name"; Rec."LFS Carrier Name")
            //     {
            //         ToolTip = 'Specifies the value of the Carrier Name field.', Comment = '%';
            //     }
            //     field("LFS S.B. No"; Rec."LFS S.B. No")
            //     {
            //         ToolTip = 'Specifies the value of the S.B. No. field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS S.B. Date"; Rec."LFS S.B. Date")
            //     {
            //         ToolTip = 'Specifies the value of the S.B. Date field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS Trade Benefit"; Rec."LFS Trade Benefit")
            //     {
            //         ToolTip = 'Specifies the value of the Trade Benefit field.', Comment = '%';
            //     }
            //     field("LFS Doc Remarks"; Rec."LFS Doc Remarks")
            //     {
            //         ToolTip = 'Specifies the value of the Doc Remarks field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS Container No."; Rec."LFS Container No.")
            //     {
            //         ToolTip = 'Specifies the value of the Container No. field.', Comment = '%';
            //     }
            //     field("LFS Seller Name & Address"; Rec."LFS Seller Name & Address")
            //     {
            //         ToolTip = 'Specifies the value of the No. & Kind Of PKDG field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS No. & Kind Of PKDG"; Rec."LFS No. & Kind Of PKDG")
            //     {
            //         ToolTip = 'Specifies the value of the No. & Kind Of PKDG field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS Notify Party"; Rec."LFS Notify Party")
            //     {
            //         ToolTip = 'Specifies the value of the Notify Party field.', Comment = '%';
            //     }
            //     field("LFS Receiver Code"; Rec."LFS Receiver Code")
            //     {
            //         ToolTip = 'Specifies the value of the Receiver Code field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS Tarrif No."; Rec."LFS Tarrif No.")
            //     {
            //         ToolTip = 'Specifies the value of the Tarrif No. field.', Comment = '%';
            //     }
            //     field("LFS Agreement No."; Rec."LFS Agreement No.")
            //     {
            //         ToolTip = 'Specifies the value of the Agreement No. field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS ISO Code"; Rec."LFS ISO Code")
            //     {
            //         ToolTip = 'Specifies the value of the ISO Code field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("HS Code"; rec."LFS HS Code")
            //     {
            //         ApplicationArea = all;
            //         ToolTip = 'Specifies the value of the HS Code field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS Seal Code"; Rec."LFS Seal Code")
            //     {
            //         ToolTip = 'Specifies the value of the Seal Code field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS Tare"; Rec."LFS Tare")
            //     {
            //         ToolTip = 'Specifies the value of the Tare field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS Packed in"; Rec."LFS Packed in")
            //     {
            //         ToolTip = 'Specifies the value of the Packed in field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS Consignment ID"; Rec."LFS Consignment ID")
            //     {
            //         ToolTip = 'Specifies the value of the Consignment ID field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS CP Week"; Rec."LFS CP Week")
            //     {
            //         ToolTip = 'Specifies the value of the CP Week field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS BRC No."; Rec."LFS BRC No.")
            //     {
            //         ToolTip = 'Specifies the value of the BRC No. field.', Comment = '%';
            //     }
            // }
            // group("Shipping Details")
            // {
            //     Editable = IsEditable;

            //     field("LFS Price Term"; Rec."LFS Price Term")
            //     {
            //         ToolTip = 'Specifies the value of the Price Term field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS Agent Name (Shipping)"; Rec."LFS Agent Name (Shipping)")
            //     {
            //         ToolTip = 'Specifies the value of the Agent Name (Shipping) field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS Bank Name"; Rec."LFS Bank Name")
            //     {
            //         ToolTip = 'Specifies the value of the Bank Name field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS Ship By (shipping)"; Rec."LFS Ship By (shipping)")
            //     {
            //         ToolTip = 'Specifies the value of the Ship By (shipping) field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS Contact Person 2"; Rec."LFS Contact Person 2")
            //     {
            //         ToolTip = 'Specifies the value of the Contact Person 2 field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS Designation"; Rec."LFS Designation")
            //     {
            //         ToolTip = 'Specifies the value of the Designation field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS Other Referance(s)"; Rec."LFS Other Referance(s)")
            //     {
            //         ToolTip = 'Specifies the value of the Other Referance(s) field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS Quoting Terms"; Rec."LFS Quoting Terms")
            //     {
            //         ToolTip = 'Specifies the value of the Quoting Terms field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS Payment Terms 2"; Rec."LFS Payment Terms 2")
            //     {
            //         ToolTip = 'Specifies the value of the Terms of Delivery and Payment field.', Comment = '%';
            //     }
            //     field("LFS Terms of Delivery"; Rec."LFS Terms of Delivery")
            //     {
            //         ToolTip = 'Specifies the value of the Terms of Delivery field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS Bank Details"; Rec."LFS Bank Details")
            //     {
            //         ToolTip = 'Specifies the value of the Bank Details field.', Comment = '%';
            //         Caption = 'Customer Bank Name';
            //     }
            // }
            group(Realisation)
            {
                Editable = IsEditable;

                // field("LFS Net Amount"; Rec."LFS Net Amount")
                // {
                //     ToolTip = 'Specifies the value of the Net Amount field.', Comment = '%';
                //     Visible = false;
                // }
                // field("LFS ARE No."; Rec."LFS ARE No.")
                // {
                //     ToolTip = 'Specifies the value of the ARE No. field.', Comment = '%';
                //     Visible = false;
                // }
                // field("LFS ARE Date"; Rec."LFS ARE Date")
                // {
                //     ToolTip = 'Specifies the value of the ARE Date field.', Comment = '%';
                //     Visible = false;
                // }
                // field("LFS GST Taxable Amount"; Rec."LFS GST Taxable Amount")
                // {
                //     ToolTip = 'Specifies the value of the GST Taxable Amount field.', Comment = '%';
                //     Visible = false;
                // }
                // field("LFS IGST Amount"; Rec."LFS IGST Amount")
                // {
                //     ToolTip = 'Specifies the value of the IGST Amount field.', Comment = '%';
                //     Visible = false;
                // }
                // field("LFS CIF Value"; Rec."LFS CIF Value")
                // {
                //     ToolTip = 'Specifies the value of the CIF Value field.', Comment = '%';
                // }
                // field("LFS CIF GST Amount"; Rec."LFS CIF GST Amount")
                // {
                //     ToolTip = 'Specifies the value of the CIF GST Amount field.', Comment = '%';
                // }
                // field("LFS Print Date"; Rec."LFS Print Date")
                // {
                //     ToolTip = 'Specifies the value of the Print Date field.', Comment = '%';
                //     Visible = false;
                // }
                // field("LFS Submit Date"; Rec."LFS Submit Date")
                // {
                //     ToolTip = 'Specifies the value of the Submit Date field.', Comment = '%';
                //     Visible = false;
                // }
                // field("LFS Receipt value"; Rec."LFS Receipt value")
                // {
                //     ToolTip = 'Specifies the value of the Receipt value field.', Comment = '%';
                // }
                // field("LFS Receipt Date"; Rec."LFS Receipt Date")
                // {
                //     ToolTip = 'Specifies the value of the Receipt Date field.', Comment = '%';
                // }
                // field("LFS Vessel/Flight No.2"; Rec."LFS Vessel/Flight No.2")
                // {
                //     ToolTip = 'Specifies the value of the Vessel/Flight No.2 field.', Comment = '%';
                //     Visible = false;
                // }
                // field("LFS Ship Date"; Rec."LFS Ship Date")
                // {
                //     ToolTip = 'Specifies the value of the Ship Date field.', Comment = '%';
                //     Visible = false;
                // }
                // field("LFS TC No."; Rec."LFS TC No.")
                // {
                //     ToolTip = 'Specifies the value of the TC No. field.', Comment = '%';
                //     Visible = false;
                // }
                // field("LFS Bank Ref No."; Rec."LFS Bank Ref No.")
                // {
                //     ToolTip = 'Specifies the value of the Bank Ref No. field.', Comment = '%';
                // }
                field("Shipping Bill No."; Rec."LFS Shipping Bill No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Shipping Bill No. field.', Comment = '%';
                    Visible = false;
                }
                field("Shipping Bill Date"; Rec."LFS Shipping Bill Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Shipping Bill Date field.', Comment = '%';
                    Visible = false;
                }
                field("LFS Insurance No."; Rec."LFS Insurance No.")
                {
                    ToolTip = 'Specifies the value of the Insurance No. field.', Comment = '%';
                }
                field("LFS Insurance Date"; Rec."LFS Insurance Date")
                {
                    ToolTip = 'Specifies the value of the Insurance Date field.', Comment = '%';
                }
                // field("LFS Export Date"; Rec."LFS Export Date")
                // {
                //     ToolTip = 'Specifies the value of the Export Date field.', Comment = '%';
                //     Visible = false;
                // }
                // field("LFS LET Export Date"; Rec."LFS LET Export Date")
                // {
                //     ToolTip = 'Specifies the value of the LET Export Date field.', Comment = '%';
                // }
                // field("LFS Realisation Date"; Rec."LFS Realisation Date")
                // {
                //     ToolTip = 'Specifies the value of the Realisation Date field.', Comment = '%';
                // }
                // field("LFS Receipt Date 2"; Rec."LFS Receipt Date 2")
                // {
                //     ToolTip = 'Specifies the value of the Receipt Date 2 field.', Comment = '%';
                //     Visible = false;
                // }
                // field("LFS BRC Print Date"; Rec."LFS BRC Print Date")
                // {
                //     ToolTip = 'Specifies the value of the BRC Print Date field.', Comment = '%';
                //     Visible = false;
                // }
                // field("LFS Bank Date"; Rec."LFS Bank Date")
                // {
                //     ToolTip = 'Specifies the value of the Bank Date field.', Comment = '%';
                //     Visible = false;
                // }
                // field("LFS Curr. Rate"; Rec."LFS Curr. Rate")
                // {
                //     ToolTip = 'Specifies the value of the Curr. Rate field.', Comment = '%';
                //     Caption = 'Payment Received Currency Rate';
                // }
                // field("LFS Rs."; Rec."LFS Rs.")
                // {
                //     ToolTip = 'Specifies the value of the Rs. field.', Comment = '%';
                //     Caption = 'Payment Received Currency LC';
                // }
                // field("LFS Freight Amt (Rs)"; Rec."LFS Freight Amt (Rs)")
                // {
                //     ToolTip = 'Specifies the value of the Freight Amt (Rs) field.', Comment = '%';
                // }
                // field("LFS Freight Amt ($)"; Rec."LFS Freight Amt ($)")
                // {
                //     ToolTip = 'Specifies the value of the Freight Amt ($) field.', Comment = '%';
                // }
                // field("LFS Insurance Amt (Rs)"; Rec."LFS Insurance Amt (Rs)")
                // {
                //     ToolTip = 'Specifies the value of the Insurance Amt (Rs) field.', Comment = '%';
                // }
                // field("LFS Insurance Amt ($)"; Rec."LFS Insurance Amt ($)")
                // {
                //     ToolTip = 'Specifies the value of the Insurance Amt ($) field.', Comment = '%';
                // }
                // field("LFS Comm % (Rs)"; Rec."LFS Comm % (Rs)")
                // {
                //     ToolTip = 'Specifies the value of the Comm % (Rs) field.', Comment = '%';
                // }
                // field("LFS Comm % ($)"; Rec."LFS Comm % ($)")
                // {
                //     ToolTip = 'Specifies the value of the Comm % ($) field.', Comment = '%';
                // }
                // field("LFS Clearance Amt (Rs)"; Rec."LFS Clearance Amt (Rs)")
                // {
                //     ToolTip = 'Specifies the value of the Clearance Amt (Rs) field.', Comment = '%';
                // }
                // field("LFS FOB Value(Rs)"; Rec."LFS FOB Value(Rs)")
                // {
                //     ToolTip = 'Specifies the value of the FOB Value(Rs) field.', Comment = '%';
                // }
                // field("LFS FOB Value($)"; Rec."LFS FOB Value($)")
                // {
                //     ToolTip = 'Specifies the value of the FOB Value($) field.', Comment = '%';
                // }
                // field("LFS Received Amt.(Rs)"; Rec."LFS Received Amt.(Rs)")
                // {
                //     ToolTip = 'Specifies the value of the Received Amt.(Rs) field.', Comment = '%';
                // }
                // field("LFS Deduction"; Rec."LFS Deduction")
                // {
                //     ToolTip = 'Specifies the value of the Deduction field.', Comment = '%';
                // }
                // field("LFS Agent Name 2"; Rec."LFS Agent Name 2")
                // {
                //     ToolTip = 'Specifies the value of the Agent Name 2 field.', Comment = '%';
                // }
                // field("LFS Local Agent Commision"; Rec."LFS Local Agent Commision")
                // {
                //     ToolTip = 'Specifies the value of the Local Agent Commision field.', Comment = '%';
                // }
                // field("LFS Receipt"; Rec."LFS Receipt")
                // {
                //     ToolTip = 'Specifies the value of the Receipt field.', Comment = '%';
                //     Caption = 'Commission Paid';
                // }
            }
            // group("Letter Document")
            // {
            //     Editable = IsEditable;
            //     field("LFS Beneficiary Certificate"; Rec."LFS Beneficiary Certificate")
            //     {
            //         ToolTip = 'Specifies the value of the Beneficiary Certificate field.', Comment = '%';
            //     }
            //     field("LFS LC Details"; Rec."LFS LC Details")
            //     {
            //         ToolTip = 'Specifies the value of the LC Details field.', Comment = '%';
            //     }
            //     field("LFS Insurance Letter Add."; Rec."LFS Insurance Letter Add.")
            //     {
            //         ToolTip = 'Specifies the value of the Insurance Letter Address field.', Comment = '%';
            //     }
            //     field("LFS Insurance Number"; Rec."LFS Insurance Number")
            //     {
            //         ToolTip = 'Specifies the value of the Insurance Number field.', Comment = '%';
            //         Visible = false;
            //     }
            //     field("LFS Insurance Date 2"; Rec."LFS Insurance Date 2")
            //     {
            //         ToolTip = 'Specifies the value of the Insurance Date 2 field.', Comment = '%';
            //         Visible = false;
            //     }
            // }
        }
    }
    trigger OnInit()
    begin
        IsEditable := true;
    end;

    trigger OnAfterGetRecord()
    var
        SalesHeader: Record "Sales Header";
    begin
        IsEditable := true;
        salesheader.SetRange("No.", Rec."LFS Document No.");
        if salesheader.FindFirst() then begin
            if SalesHeader.Status = salesheader.Status::Released then begin
                CurrPage.Editable := false;
                IsEditable := false;
            end;
        end
        else begin
            CurrPage.Editable := true;
            IsEditable := true;
        end;
    end;

    var
        IsEditable: Boolean;
}