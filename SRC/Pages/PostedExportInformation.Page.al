namespace LFSEximModule.LFSPLEXIMModule;

page 72048 "LFS Posted Export Information"
{
    ApplicationArea = All;
    Caption = 'Posted Export Information';
    PageType = Card;
    SourceTable = "LFS Posted Export Information";
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
                    Editable = false;
                    ToolTip = 'Specifies the Document No.';
                }
                field("LFS Customer Order No."; Rec."LFS Customer Order No.")
                {
                    ToolTip = 'Specifies the value of the Customer Order No. 2 field.', Comment = '%';
                }
                field("LFS Customer Order Date 2"; Rec."LFS Customer Order Date 2")
                {
                    ToolTip = 'Specifies the value of the Customer Order Date 2 field.', Comment = '%';
                }
                field("LFS Shipping Bill No."; Rec."LFS Shipping Bill No.")
                {
                    Caption = 'Shipping Bill No.';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shipping Bill No.';
                }
                field("LFS Shipping Bill Date"; Rec."LFS Shipping Bill Date")
                {
                    Caption = 'Shipping Bill Date';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shipping Bill Date';
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
                field("LFS Latest Date of Shipment"; Rec."LFS Latest Date of Shipment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Latest Date of Shipment ';
                }
                field("LFS LC Expiry Date"; Rec."LFS LC Expiry Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the LC Expiry Date';
                }
                field("Vessel/Flight No."; Rec."LFS Vessel/Flight No.")
                {
                    ToolTip = 'Specifies the Vessel/Flight No.';
                    ApplicationArea = all;
                }
                field("LFS ETD"; Rec."LFS ETD")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the ETD ';
                }
                field("LFS ETA"; Rec."LFS ETA")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the ETA';
                }
            }
            group("Other Information")
            {
                field("LFS HS Code"; Rec."LFS HS Code")
                {
                    Caption = 'Party HS Code';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Party HS Code';
                }
                field("Description of Goods"; Rec."LFS Description of Goods")
                {
                    ApplicationArea = all;
                    Caption = 'Container Details';
                    ToolTip = 'Specifies the Container Details';
                }
                field("Sp Notes"; Rec."LFS Sp Notes")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Sp Notes';
                }
                field("LFS Palletization"; Rec."LFS Palletization")
                {
                    ToolTip = 'Specifies the value of the Palletization (If Required) field.', Comment = '%';
                }
                field("LFS Pre-Shipment Sample"; Rec."LFS Pre-Shipment Sample")
                {
                    ToolTip = 'Specifies the value of the Pre-Shipment Sample Required field.', Comment = '%';
                }
            }
            group(Agent)
            {

                field("Agent Code"; Rec."LFS Agent Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Agent Code';
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
            group("Check List")
            {
                field("Full Set Clean- Bill of Lading"; Rec."LFS Full Set Clean- BOL")
                {
                    ToolTip = 'Specifies the Full Set Clean- Bill of Lading';
                }
                field("Air Way Bill"; Rec."LFS Air Way Bill")
                {
                    ToolTip = 'Specifies the Air Way Bill';
                }
                field("Signed Commercial Inv. Org."; Rec."LFS Signed Comm. Inv. Org.")
                {
                    ToolTip = 'Specifies the Signed Commercial Inv. Org.';
                }
                field("Certificate Of Origin"; Rec."LFS Certificate Of Origin")
                {
                    ToolTip = 'Specifies the Certificate Of Origin';
                }
                field("Packing List in Four fold"; Rec."LFS Pack List in Four fold")
                {
                    ToolTip = 'Specifies the Packing List in Four fold';
                }
                field("Copy of the Certificate"; Rec."LFS Copy of the Certificate")
                {
                    ToolTip = 'Specifies the Copy of the Certificate';
                }
                field("Certificate of Insurance"; Rec."LFS Cert. of Insurance")
                {
                    ToolTip = 'Specifies the v';
                }
                field("document will be forwarded"; Rec."LFS doc. will be forwarded")
                {
                    ToolTip = 'Specifies the document will be forwarded';
                }
                field("non-Neg doc frwd 7 days"; Rec."LFS non-Neg doc frwd 7 days")
                {
                    ToolTip = 'Specifies the non-Neg doc frwd 7 days';
                }
                field("non-Neg doc frwd 3 days"; Rec."LFS non-Neg doc frwd 3 days")
                {
                    ToolTip = 'Specifies the non-Neg doc frwd 3 days';
                }
                field(Form; Rec."LFS Form")
                {
                    ToolTip = 'Specifies the Form';
                }
                field("Shipping Period"; Rec."LFS Shipping Period")
                {
                    ToolTip = 'Specifies the Shipping Period';
                }
                field("Shipping Marks"; Rec."LFS Shipping Marks")
                {
                    ToolTip = 'Specifies the Shipping Marks';
                }
            }
            group("Information")
            {
                field("Your Ref No."; Rec."LFS Your Ref No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Your Ref No.';
                    Visible = false;
                }
                field("Your Ref Date"; Rec."LFS Your Ref Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Your Ref Date';
                    Visible = false;
                }
                field("P.O Receive Date"; Rec."LFS P.O Receive Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the P.O Receive Date';
                }
                field("Delivery Terms"; Rec."LFS Delivery Terms")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Delivery Terms';
                    Visible = false;
                }
                field("Dispatch Mode"; Rec."LFS Dispatch Mode")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Dispatch Mode';
                    Visible = false;
                }
                field("Delivery Address"; Rec."LFS Delivery Address")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Delivery Address';
                    Visible = false;
                }
                field("Buyer(if other then Consignee)"; Rec."LFS BuyerotherthanConsignee")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Buyer(if other then Consignee)';
                    Visible = false;
                }
                field("Payment Terms"; Rec."LFS Payment Terms")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Payment Terms';
                    Visible = false;
                }
                field("Contact Person1"; Rec."LFS Contact Person1")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Contact Person';
                    Visible = false;
                }

                field("Port of Loading"; Rec."LFS Port of Loading")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Port of Loading';
                    Visible = false;
                }
                field("Port of Discharge"; Rec."LFS Port of Discharge")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Port of Discharge';
                    Visible = false;
                }
                field("Ship By"; Rec."LFS Ship By")
                {
                    ToolTip = 'Specifies the Ship By';
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Paying Agent"; Rec."LFS Paying Agent")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Paying Agent';
                }
                field("Our Bank"; Rec."LFS Our Bank")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Our Bank';
                }
                field("Customer (Bank Details)"; Rec."LFS Customer (Bank Details)")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the Customer (Bank Details)';
                    Visible = false;
                }
                field("Dispatch Instruction"; Rec."LFS Dispatch Instruction")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Dispatch Instruction';
                }
                field("Carrier Name"; Rec."LFS Carrier Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Carrier Name';
                }
                field("S.B. No"; Rec."LFS S.B. No")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the S.B. No';
                    Visible = false;
                }
                field("S.B. Date"; Rec."LFS S.B. Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the S.B. Date';
                    Visible = false;
                }
                field("Trade Benefit"; rec."LFS Trade Benefit")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Trade Benefit';
                }
                field("Doc Remarks"; rec."LFS Doc Remarks")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Doc Remarks';
                    Visible = false;
                }
                field("Container No."; rec."LFS Container No.")
                {
                    ToolTip = 'Specifies the Container No.';
                    ApplicationArea = all;
                }
                field("Seller Name & Address"; rec."LFS Seller Name & Address")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Seller Name & Address';
                    Visible = false;
                }
                field("No. & Kind Of PKDG"; rec."LFS No. & Kind Of PKDG")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the No. & Kind Of PKDG';
                }
                field("Notify Party"; rec."LFS Notify Party")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Notify Party';
                }
                field("Receiver Code"; rec."LFS Receiver Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Receiver Code';
                    Visible = false;
                }
                field("Tarrif No."; rec."LFS Tarrif No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Tarrif No.';
                    Visible = false;
                }
                field("Agreement No."; rec."LFS Agreement No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Agreement No.';
                    Visible = false;
                }
                field("ISO Code"; rec."LFS ISO Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the ISO Code';
                    Visible = false;
                }
                field("HS Code"; rec."LFS HS Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the HS Code';
                    Visible = false;
                }
                field("Seal Code"; rec."LFS Seal Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Seal Code';
                    Visible = false;
                }
                field(Tare; rec."LFS Tare")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Tare ';
                    Visible = false;
                }
                field("Packed in"; rec."LFS Packed in")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Packed in';
                    Visible = false;
                }
                field("Consignment ID"; rec."LFS Consignment ID")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Consignment ID';
                    Visible = false;
                }
                field("CP Week"; rec."LFS CP Week")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the CP Week';
                    Visible = false;
                }
                field("BRC No."; rec."LFS BRC No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the BRC No.';
                }

            }
            group("Shipping Details")
            {
                field("LFS Price Term"; Rec."LFS Price Term")
                {
                    ToolTip = 'Specifies the value of the Price Term field.', Comment = '%';
                    Visible = false;
                }
                field("LFS Method of Dispatch"; Rec."LFS Method of Dispatch")
                {
                    ToolTip = 'Specifies the value of the Method of Dispatch field.', Comment = '%';
                    Visible = false;
                }
                field("LFS Agent Name (Shipping)"; Rec."LFS Agent Name (Shipping)")
                {
                    ToolTip = 'Specifies the value of the Agent Name (Shipping) field.', Comment = '%';
                    Visible = false;
                }
                field("LFS Bank Name"; Rec."LFS Bank Name")
                {
                    ToolTip = 'Specifies the value of the Bank Name field.', Comment = '%';
                    Visible = false;
                }
                field("LFS Ship By (shipping)"; Rec."LFS Ship By (shipping)")
                {
                    ToolTip = 'Specifies the value of the Ship By (shipping) field.', Comment = '%';
                    Visible = false;
                }
                field("LFS Contact Person 2"; Rec."LFS Contact Person 2")
                {
                    ToolTip = 'Specifies the value of the Contact Person 2 field.', Comment = '%';
                    Visible = false;
                }
                field("LFS Designation"; Rec."LFS Designation")
                {
                    ToolTip = 'Specifies the value of the Designation field.', Comment = '%';
                    Visible = false;
                }
                field("LFS Other Referance(s)"; Rec."LFS Other Referance(s)")
                {
                    ToolTip = 'Specifies the value of the Other Referance(s) field.', Comment = '%';
                    Visible = false;
                }
                field("LFS Quoting Terms"; Rec."LFS Quoting Terms")
                {
                    ToolTip = 'Specifies the value of the Quoting Terms field.', Comment = '%';
                    Visible = false;
                }
                field("LFS Payment Terms 2"; Rec."LFS Payment Terms 2")
                {
                    ToolTip = 'Specifies the value of the Terms of Delivery and Payment field.', Comment = '%';
                }
                field("LFS Terms of Delivery"; Rec."LFS Terms of Delivery")
                {
                    ToolTip = 'Specifies the value of the Terms of Delivery field.', Comment = '%';
                    Visible = false;
                }
                field("LFS Notes"; Rec."LFS Notes")
                {
                    ToolTip = 'Specifies the value of the Notes field.', Comment = '%';
                }
                field("LFS Bank Details"; Rec."LFS Bank Details")
                {
                    ToolTip = 'Specifies the value of the Bank Details field.', Comment = '%';
                    Caption = 'Customer Bank Name';
                }
            }
            group(Realisation)
            {
                field("LFS Net Amount"; Rec."LFS Net Amount")
                {
                    ToolTip = 'Specifies the value of the Net Amount field.', Comment = '%';
                    Visible = false;
                }
                field("LFS ARE No."; Rec."LFS ARE No.")
                {
                    ToolTip = 'Specifies the value of the ARE No. field.', Comment = '%';
                    Visible = false;
                }
                field("LFS ARE Date"; Rec."LFS ARE Date")
                {
                    ToolTip = 'Specifies the value of the ARE Date field.', Comment = '%';
                    Visible = false;
                }
                field("LFS GST Taxable Amount"; Rec."LFS GST Taxable Amount")
                {
                    ToolTip = 'Specifies the value of the GST Taxable Amount field.', Comment = '%';
                    Visible = false;
                }
                field("LFS IGST Amount"; Rec."LFS IGST Amount")
                {
                    ToolTip = 'Specifies the value of the IGST Amount field.', Comment = '%';
                    Visible = false;
                }
                field("LFS CIF Value"; Rec."LFS CIF Value")
                {
                    ToolTip = 'Specifies the value of the CIF Value field.', Comment = '%';
                }
                field("LFS CIF GST Amount"; Rec."LFS CIF GST Amount")
                {
                    ToolTip = 'Specifies the value of the CIF GST Amount field.', Comment = '%';
                }
                field("LFS Print Date"; Rec."LFS Print Date")
                {
                    ToolTip = 'Specifies the value of the Print Date field.', Comment = '%';
                    Visible = false;
                }
                field("LFS Submit Date"; Rec."LFS Submit Date")
                {
                    ToolTip = 'Specifies the value of the Submit Date field.', Comment = '%';
                    Visible = false;
                }
                field("LFS Receipt value"; Rec."LFS Receipt value")
                {
                    ToolTip = 'Specifies the value of the Receipt value field.', Comment = '%';
                }
                field("LFS Receipt Date"; Rec."LFS Receipt Date")
                {
                    ToolTip = 'Specifies the value of the Receipt Date field.', Comment = '%';
                }
                field("LFS Vessel/Flight No.2"; Rec."LFS Vessel/Flight No.2")
                {
                    ToolTip = 'Specifies the value of the Vessel/Flight No.2 field.', Comment = '%';
                    Visible = false;
                }
                field("LFS Ship Date"; Rec."LFS Ship Date")
                {
                    ToolTip = 'Specifies the value of the Ship Date field.', Comment = '%';
                    Visible = false;
                }
                field("LFS TC No."; Rec."LFS TC No.")
                {
                    ToolTip = 'Specifies the value of the TC No. field.', Comment = '%';
                    Visible = false;
                }
                field("LFS Bank Ref No."; Rec."LFS Bank Ref No.")
                {
                    ToolTip = 'Specifies the value of the Bank Ref No. field.', Comment = '%';
                }
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
                field("LFS Export Date"; Rec."LFS Export Date")
                {
                    ToolTip = 'Specifies the value of the Export Date field.', Comment = '%';
                }
                field("LFS LET Export Date"; Rec."LFS LET Export Date")
                {
                    ToolTip = 'Specifies the value of the LET Export Date field.', Comment = '%';
                    Visible = false;
                }
                field("LFS Realisation Date"; Rec."LFS Realisation Date")
                {
                    ToolTip = 'Specifies the value of the Realisation Date field.', Comment = '%';
                }
                field("LFS Receipt Date 2"; Rec."LFS Receipt Date 2")
                {
                    ToolTip = 'Specifies the value of the Receipt Date 2 field.', Comment = '%';
                    Visible = false;
                }
                field("LFS BRC Print Date"; Rec."LFS BRC Print Date")
                {
                    ToolTip = 'Specifies the value of the BRC Print Date field.', Comment = '%';
                    Visible = false;
                }
                field("LFS Bank Date"; Rec."LFS Bank Date")
                {
                    ToolTip = 'Specifies the value of the Bank Date field.', Comment = '%';
                    Visible = false;
                }
                field("LFS Curr. Rate"; Rec."LFS Curr. Rate")
                {
                    ToolTip = 'Specifies the value of the Curr. Rate field.', Comment = '%';
                    Caption = 'Payment Received Currency Rate';
                }
                field("LFS Rs."; Rec."LFS Rs.")
                {
                    ToolTip = 'Specifies the value of the Rs. field.', Comment = '%';
                    Caption = 'Payment Received Currency LC';
                }
                field("LFS Freight Amt (Rs)"; Rec."LFS Freight Amt (Rs)")
                {
                    ToolTip = 'Specifies the value of the Freight Amt (Rs) field.', Comment = '%';
                }
                field("LFS Freight Amt ($)"; Rec."LFS Freight Amt ($)")
                {
                    ToolTip = 'Specifies the value of the Freight Amt ($) field.', Comment = '%';
                }
                field("LFS Insurance Amt (Rs)"; Rec."LFS Insurance Amt (Rs)")
                {
                    ToolTip = 'Specifies the value of the Insurance Amt (Rs) field.', Comment = '%';
                }
                field("LFS Insurance Amt ($)"; Rec."LFS Insurance Amt ($)")
                {
                    ToolTip = 'Specifies the value of the Insurance Amt ($) field.', Comment = '%';
                }
                field("LFS Comm % (Rs)"; Rec."LFS Comm % (Rs)")
                {
                    ToolTip = 'Specifies the value of the Comm % (Rs) field.', Comment = '%';
                }
                field("LFS Comm % ($)"; Rec."LFS Comm % ($)")
                {
                    ToolTip = 'Specifies the value of the Comm % ($) field.', Comment = '%';
                }
                field("LFS Clearance Amt (Rs)"; Rec."LFS Clearance Amt (Rs)")
                {
                    ToolTip = 'Specifies the value of the Clearance Amt (Rs) field.', Comment = '%';
                }
                field("LFS FOB Value(Rs)"; Rec."LFS FOB Value(Rs)")
                {
                    ToolTip = 'Specifies the value of the FOB Value(Rs) field.', Comment = '%';
                }
                field("LFS FOB Value($)"; Rec."LFS FOB Value($)")
                {
                    ToolTip = 'Specifies the value of the FOB Value($) field.', Comment = '%';
                }
                field("LFS Received Amt.(Rs)"; Rec."LFS Received Amt.(Rs)")
                {
                    ToolTip = 'Specifies the value of the Received Amt.(Rs) field.', Comment = '%';
                }
                field("LFS Deduction"; Rec."LFS Deduction")
                {
                    ToolTip = 'Specifies the value of the Deduction field.', Comment = '%';
                }
                field("LFS Agent Name 2"; Rec."LFS Agent Name 2")
                {
                    ToolTip = 'Specifies the value of the Agent Name 2 field.', Comment = '%';
                }
                field("LFS Local Agent Commision"; Rec."LFS Local Agent Commision")
                {
                    ToolTip = 'Specifies the value of the Local Agent Commision field.', Comment = '%';
                }
                field("LFS Receipt"; Rec."LFS Receipt")
                {
                    ToolTip = 'Specifies the value of the Receipt field.', Comment = '%';
                    Caption = 'Commission Paid';
                }
            }
            group("Letter Document")
            {
                field("LFS Beneficiary Certificate"; Rec."LFS Beneficiary Certificate")
                {
                    ToolTip = 'Specifies the value of the Beneficiary Certificate field.', Comment = '%';
                }
                field("LFS LC Details"; Rec."LFS LC Details")
                {
                    ToolTip = 'Specifies the value of the LC Details field.', Comment = '%';
                }
                field("LFS Insurance Letter Add."; Rec."LFS Insurance Letter Add.")
                {
                    ToolTip = 'Specifies the value of the Insurance Letter Address field.', Comment = '%';
                }
                field("LFS Insurance Number"; Rec."LFS Insurance Number")
                {
                    ToolTip = 'Specifies the value of the Insurance Number field.', Comment = '%';
                    Visible = false;
                }
                field("LFS Insurance Date 2"; Rec."LFS Insurance Date 2")
                {
                    ToolTip = 'Specifies the value of the Insurance Date 2 field.', Comment = '%';
                    Visible = false;
                }
            }
        }
    }
}