namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Purchases.Vendor;
using Microsoft.Foundation.Address;
using Microsoft.Sales.History;
using Microsoft.Foundation.PaymentTerms;
table 72032 "LFS Posted Export Information"
{
    Caption = 'Posted Export Information';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "LFS Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(2; "LFS Document Type"; Enum "LFS Sales Source Document Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Document Type';
        }
        field(3; "LFS Agent Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Agent Code';
            TableRelation = Vendor."No." where("LFS Agent Code" = filter(true));
            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                Vendor.get(rec."LFS Agent Code");
                Rec."LFS Agent Name" := Vendor.Name;
            end;
        }
        field(4; "LFS Agent Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Agent Name';
        }
        field(5; "LFS Contact Person"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact Person';
        }
        field(6; "LFS Address1"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Address1';
        }
        field(7; "LFS Address2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Address2';
        }
        field(8; "LFS City"; text[30])
        {
            DataClassification = CustomerContent;
            TableRelation = "Post Code".City;
            Caption = 'City';

        }
        field(9; "LFS Pin"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Post Code";
            Caption = 'Pin Code';
        }
        field(10; "LFS Tel No."; Text[30])
        {
            DataClassification = CustomerContent;
            ExtendedDatatype = PhoneNo;
            Caption = 'Tel No.';
        }
        field(11; "LFS Mobile No."; text[30])
        {
            DataClassification = CustomerContent;
            ExtendedDatatype = PhoneNo;
            Caption = 'Mobile No.';
        }
        field(12; "LFS Email"; Text[80])
        {
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
            Caption = 'E-Mail';
        }
        // field(13; "LFS Full Set Clean- BOL"; Boolean)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Full Set Clean- Bill of Lading';
        // }
        // field(14; "LFS Air Way Bill"; Boolean)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Air Way Bill';
        // }
        // field(15; "LFS Signed Comm. Inv. Org."; Boolean)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Signed Commercial Inv. Org.';
        // }
        // field(16; "LFS Certificate Of Origin"; Boolean)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Certificate Of Origin';
        // }
        // field(17; "LFS Pack List in Four fold"; Boolean)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Packing List in Four fold';
        // }
        // field(18; "LFS Copy of the Certificate"; Boolean)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Copy of the Certificate';
        // }
        // field(19; "LFS Cert. of Insurance"; Boolean)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Certificate of Insurance';
        // }
        // field(20; "LFS Doc. will be forwarded"; Boolean)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Document will be forwarded';
        // }
        // field(21; "LFS non-Neg doc frwd 7 days"; Boolean)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'non-Neg doc frwd 7 days';
        // }
        // field(22; "LFS non-Neg doc frwd 3 days"; Boolean)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'non-Neg doc frwd 3 days';
        // }
        // field(23; "LFS Form"; Option)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Form';
        //     OptionMembers = "FORM-3 & FORM 7","FORM 9";
        //     OptionCaption = 'FORM-3 & FORM 7,FORM 9';
        // }
        // field(24; "LFS Shipping Period"; Text[20])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Shipping Period';
        // }
        field(25; "LFS Shipping Marks"; Text[2000])
        {
            DataClassification = CustomerContent;
            Caption = 'Shipping Marks';
        }
        // field(26; "LFS Your Ref No."; Text[80])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Your Ref No.';
        // }
        // field(27; "LFS Your Ref Date"; Date)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Your Ref Date';
        // }
        // field(28; "LFS P.O Receive Date"; Date)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'P.O Receive Date';
        // }
        // field(32; "LFS Delivery Terms"; Text[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Delivery Terms';
        // }
        // field(33; "LFS Dispatch Mode"; Text[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Dispatch Mode';
        // }
        // field(34; "LFS Delivery Address"; Text[100])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Delivery Address';
        // }
        // field(35; "LFS BuyerOtherthanConsignee"; Text[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Buyer(if other than Consignee)';
        // }
        // field(36; "LFS Payment Terms"; code[10])
        // {
        //     DataClassification = CustomerContent;
        //     TableRelation = "Payment Terms".Code;
        //     Caption = 'Payment Terms';
        // }
        // field(37; "LFS Contact Person1"; Text[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Contact Person1';
        // }
        field(38; "LFS LC No."; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'LC No.';
        }
        field(39; "LFS LC Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'LC Date';
        }
        // field(40; "LFS Port of Loading"; Text[50])
        // {
        //     DataClassification = CustomerContent;
        //     TableRelation = "LFS EXIM Port";
        //     Caption = 'Port of Loading';
        // }
        // field(41; "LFS Port of Discharge"; Text[50])
        // {
        //     DataClassification = CustomerContent;
        //     TableRelation = "LFS EXIM Port";
        //     Caption = 'Port of Discharge';
        // }
        // field(42; "LFS Ship By"; Text[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Ship By';
        // }
        // field(43; "LFS Paying Agent"; Text[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Paying Agent';
        // }
        // field(44; "LFS Our Bank"; Code[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Our Bank';
        // }
        field(45; "LFS Description of Goods"; Text[2000])
        {
            DataClassification = CustomerContent;
            Caption = 'Description of Goods';
        }
        // field(46; "LFS Customer (Bank Details)"; Text[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Customer (Bank Details)';
        // }
        // field(47; "LFS Dispatch Instruction"; Text[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Dispatch Instruction';
        // }
        // field(48; "LFS Carrier Name"; Text[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Carrier Name';
        // }
        // field(49; "LFS S.B. No"; Code[20])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'S.B. No.';
        // }
        // field(50; "LFS S.B. Date"; Date)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'S.B. Date';
        // }
        // field(51; "LFS Trade Benefit"; Text[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Trade Benefit';
        // }
        // field(52; "LFS Doc Remarks"; Text[200])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Doc Remarks';
        // }
        field(53; "LFS Container No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Container No.';
        }
        // field(54; "LFS Seller Name & Address"; Text[200])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'No. & Kind Of PKDG';
        // }
        // field(55; "LFS No. & Kind Of PKDG"; Code[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'No. & Kind Of PKDG';
        // }
        field(56; "LFS Notify Party"; Text[2000])
        {
            DataClassification = CustomerContent;
            Caption = 'Notify Party';
        }
        // field(57; "LFS Receiver Code"; Code[20])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Receiver Code';
        // }
        // field(58; "LFS Tarrif No."; Code[20])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Tarrif No.';
        // }
        // field(59; "LFS Agreement No."; Code[20])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Agreement No.';
        // }
        // field(60; "LFS ISO Code"; Code[20])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'ISO Code';
        // }
        // field(61; "LFS HS Code"; Code[20])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'HS Code';
        // }
        field(62; "LFS Container Seal No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Container Seal No.';
        }
        // field(63; "LFS Tare"; Text[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Tare';
        // }
        // field(64; "LFS Packed in"; Text[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Packed in';
        // }
        // field(65; "LFS Consignment ID"; Text[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Consignment ID';
        // }
        // field(66; "LFS CP Week"; Text[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'CP Week';
        // }
        // field(67; "LFS BRC No."; Code[20])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'BRC No.';
        // }
        // field(68; "LFS Price Term"; Text[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Price Term';
        // }
        // field(69; "LFS Method of Dispatch"; Text[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Method of Dispatch';
        // }
        // field(70; "LFS Agent Name (Shipping)"; Text[20])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Agent Name (Shipping)';
        // }
        // field(71; "LFS Bank Name"; Text[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Bank Name';
        // }
        // field(72; "LFS Ship By (shipping)"; Text[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Ship By (shipping)';
        // }
        field(73; "LFS BL No/ AWB No."; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'BL No/ AWB No.';
        }
        field(74; "LFS BL Date/ AWB Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'BL Date/ AWB Date';
            trigger OnValidate()
            var
                SalesInvoiceHead: Record "Sales Invoice Header";
                GeneralFunctionCodeUnit: Codeunit "LFS EXIM General Functions";
            begin
                SalesInvoiceHead.SetRange("No.", Rec."LFS Document No.");
                if SalesInvoiceHead.FindFirst() then
                    GeneralFunctionCodeUnit.UpdateDueDateBL(SalesInvoiceHead, Rec);
            end;
        }
        field(75; "LFS Vessel/Flight No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Vessel/Flight No.';
        }
        // field(76; "LFS Contact Person 2"; Text[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Contact Person 2';
        // }
        // field(77; "LFS Designation"; Text[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Designation';
        // }
        // field(78; "LFS Other Referance(s)"; Text[20])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Other Referance(s)';
        // }
        // field(79; "LFS Quoting Terms"; Text[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Quoting Terms';
        // }
        // field(80; "LFS Payment Terms 2"; Text[250])
        // {
        //     DataClassification = CustomerContent;
        //     TableRelation = "Payment Terms";
        //     Caption = 'Terms of Delivery and Payment';
        // }
        // field(81; "LFS Terms of Delivery"; Text[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Terms of Delivery';
        // }
        field(82; "LFS Notes"; Blob)
        {
            DataClassification = CustomerContent;
            Caption = 'Notes';
        }
        // field(83; "LFS Bank Details"; Text[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Bank Details';
        // }
        // field(84; "LFS Sp Notes"; Text[51])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Inco Terms Description';
        // }
        // field(85; "LFS Net Amount"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Net Amount';
        // }
        // field(86; "LFS ARE No."; Code[20])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'ARE No.';
        // }
        // field(87; "LFS ARE Date"; Date)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'ARE Date';
        // }
        // field(88; "LFS GST Taxable Amount"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'GST Taxable Amount';
        // }
        // field(89; "LFS IGST Amount"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'IGST Amount';
        // }
        // field(90; "LFS CIF Value"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'CIF Value';
        // }
        // field(91; "LFS CIF GST Amount"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'CIF GST Amount';
        // }
        // field(92; "LFS Print Date"; Date)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Print Date';
        // }
        // field(93; "LFS Submit Date"; date)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Submit Date';
        // }
        // field(94; "LFS Receipt value"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Receipt value';
        // }

        // field(96; "LFS Receipt Date"; Date)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Receipt Date';
        // }
        // field(97; "LFS Vessel/Flight No.2"; Code[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Vessel/Flight No.2';
        // }
        // field(98; "LFS Ship Date"; date)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Ship Date';
        // }
        // field(99; "LFS TC No."; Code[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'TC No.';
        // }
        // field(100; "LFS Bank Ref No."; Code[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Bank Ref No.';
        // }
        // field(101; "LFS Shipping Bill No."; Code[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Shipping Bill No.';
        // }
        // field(102; "LFS Shipping Bill Date"; Date)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Shipping Bill Date';
        // }
        field(103; "LFS Insurance No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Insurance No.';
        }
        field(104; "LFS Insurance Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Insurance Date';
        }
        // field(105; "LFS Export Date"; Date)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Export Date';
        // }
        // field(106; "LFS LET Export Date"; Date)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'LET Export Date';
        // }
        // field(107; "LFS Realisation Date"; Date)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Realisation Date';
        // }
        // field(108; "LFS Receipt Date 2"; Date)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Receipt Date 2';
        // }
        // field(109; "LFS BRC Print Date"; Date)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'BRC Print Date';
        // }
        // field(110; "LFS Bank Date"; Date)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Bank Date';
        // }
        // field(111; "LFS Curr. Rate"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Curr. Rate';
        // }
        // field(112; "LFS Rs."; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Rs.';
        // }
        // field(113; "LFS Freight Amt (Rs)"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Freight Amt (Rs)';
        // }
        // field(114; "LFS Freight Amt ($)"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Freight Amt ($)';
        // }
        // field(115; "LFS Insurance Amt (Rs)"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Insurance Amt (Rs)';
        // }
        // field(116; "LFS Insurance Amt ($)"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Insurance Amt ($)';
        // }
        // field(117; "LFS Comm % ($)"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Comm % ($)';
        // }
        // field(118; "LFS Comm % (Rs)"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Comm % (Rs)';
        // }
        // field(119; "LFS Clearance Amt (Rs)"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Clearance Amt (Rs)';
        // }
        // field(120; "LFS FOB Value(Rs)"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'FOB Value(Rs)';
        // }
        // field(121; "LFS FOB Value($)"; Decimal)

        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'FOB Value($)';
        // }
        // field(122; "LFS Received Amt.(Rs)"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Received Amt.(Rs)';
        // }
        // field(123; "LFS Deduction"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Deduction';
        // }
        // field(124; "LFS Agent Name 2"; Text[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Agent Name 2';
        // }
        // field(125; "LFS Agent Code 2"; Code[20])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Agent Code 2';
        // }
        // field(126; "LFS Local Agent Commision"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Local Agent Commision';
        // }
        // field(127; "LFS Receipt"; code[20])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Receipt';
        // }
        // field(128; "LFS Beneficiary Certificate"; Text[1000])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Beneficiary Certificate';
        // }
        // field(129; "LFS LC Details"; Text[1000])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'LC Details';
        // }
        // field(130; "LFS Insurance Letter Add."; text[1000])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Insurance Letter Address';
        // }
        // field(131; "LFS Insurance Number"; Code[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Insurance Number';
        // }
        // field(132; "LFS Insurance Date 2"; Date)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Insurance Date 2';
        // }
        field(133; "LFS Doc. Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Doc. Line No.';
        }
        field(134; "LFS ETD"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Estimated Delivery Time';
        }
        field(135; "LFS ETA"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Estimated Arrival Time';

        }
        // field(136; "LFS Latest Date of Shipment"; Date)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Latest Date of Shipment';
        // }
        field(137; "LFS LC Expiry Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'LC Expiry Date';
        }
        // field(138; "LFS Palletization"; Boolean)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Palletization (If Required)';
        // }
        // field(139; "LFS Pre-Shipment Sample"; Boolean)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Pre-Shipment Sample Required';
        // }
        // field(140; "LFS Customer Order No."; Code[35])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Customer Order No. 2';
        // }
        // field(141; "LFS Customer Order Date 2"; Date)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Customer Order Date 2';
        // }
        field(142; "LFS Container Size"; Code[50])
        {
            Caption = 'Container Size';
            DataClassification = CustomerContent;
        }
        field(143; "LFS RFID Seal No."; Code[50])
        {
            Caption = 'RFID Seal No.';
            DataClassification = CustomerContent;
        }
        field(144; "LFS Consignee Name & Address"; Text[2000])
        {
            Caption = 'Consignee Name & Address';
            DataClassification = CustomerContent;
        }
        // field(145; "LFS Consignee Address"; Blob)
        // {
        //     Caption = 'Consignee Address';
        //     DataClassification = CustomerContent;
        // }
    }

    keys
    {
        key(Key1; "LFS Document No.", "LFS Document Type")
        {
            Clustered = true;
        }
    }
}