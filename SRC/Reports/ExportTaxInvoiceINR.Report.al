report 72007 "Export Tax Invoice-INR"
{
    ApplicationArea = All;
    Caption = 'Export Tax Invoice-INR';
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    RDLCLayout = './SRC/Reports Layouts/Export Tax Invoice-INR.rdl';
    // UsageCategory = ReportsandAnalysis;
    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            CalcFields = "QR Code";
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            column("UserID"; UserSetup."User ID") { }
            column(QR_Code; "QR Code") { }
            column(Picture; compyInfo.Picture) { }
            column(CompName; compyInfo.Name) { }
            column(CompAdd1; compyInfo.Address) { }
            column(compAdd2; compyInfo."Address 2") { }
            column(Comp_City; compyInfo.City + '-' + compyInfo."Post Code" + ',' + CompanyStateDesc + ',' + CountryRegionDesc) { }
            column(CompPhoneNo; compyInfo."Phone No.") { }
            column(CompEmail; compyInfo."E-Mail") { }
            column(CompCINNo; '') { }
            column(CompGSTNo; compyInfo."GST Registration No.") { }
            column(TAN_No; compyInfo."T.A.N. No.") { }
            column(MSMENo; '') { }
            column(CompanyStateCode; CompanyStateCode) { }
            column(PANno; compyInfo."P.A.N. No.") { }
            column(No_; "No.") { }
            column(Address; Address) { }
            column(Address2; Address2) { }
            column(City1; City) { }
            column(CompInfo_PhoneNo; PhNo) { }
            column(CompPANNo; compyInfo."P.A.N. No.") { }
            column(PostCode; PostCode) { }
            column(State_Code; State_Code) { }
            column(statecode; stateCode) { }
            column(CountryCode; CountryCode) { }
            column(Email; Email) { }

            column(Address_Loc; LocationRec.Address + ', ' + LocationRec."Address 2") { }
            column(City_PostCode_Loc; LocationRec.City + ' ' + LocationRec."Post Code") { }
            column(Email_Loc; LocationRec."E-Mail") { }
            column(Phone_Loc; LocationRec."Phone No.") { }
            column(FaxNo_Loc; LocationRec."Fax No.") { }
            column(GSTNo_Loc; LocationRec."GST Registration No.") { }

            // column(Address; Address) { }
            // column(Address2; Address2) { }
            column(Posting_Date; "Posting Date") { }
            column(Vehicle_No_; "Vehicle No.") { }
            column(Sell_to_Address; "Sell-to Address") { }
            column(Sell_to_Address_2; "Sell-to Address 2") { }
            column(SelltoCity; "Sell-to City" + '- ' + "Sell-to Post Code" + ',' + SelltoStateDescribtion + ', ' + SelltoCountryDesc) { }
            column(Sell_to_Customer_Name; "Sell-to Customer Name") { }
            column(SelltoStateDescribtion; SelltoStateDescribtion) { }
            column(SelltoCountryDesc; SelltoCountryDesc) { }
            column(Sell_to_Post_Code; "Sell-to Post Code") { }
            column(SelltoCustomerPan; SelltoCustomerPan) { }
            column(SelltoCustomerPhoneNo; SelltoCustomerPhoneNo) { }
            column(SelltoCustomerEmail; SelltoCustomerEmail) { }
            column(SelltoGST; SelltoGST) { }
            column(Bill_to_Name; "Bill-to Name") { }
            column(Bill_to_Address; "Bill-to Address") { }
            column(Bill_to_Address_2; "Bill-to Address 2") { }
            column(BilltoCity; "Bill-to City" + ', ' + BilltoStateDescribtion + ', ' + BilltoCountryDescribtion + '-' + "Bill-to Post Code") { }
            column(BilltoStateDescribtion; BilltoStateDescribtion) { }
            column(BilltoCustomerEmail; BilltoCustomerEmail) { }
            column(BilltoCustomerPan; BilltoCustomerPan) { }
            column(BilltoCustomerPhoneNo; BilltoCustomerPhoneNo) { }
            column(BilltoStateCode; BilltoStateCode) { }
            column(BilltoGST; BilltoGST) { }
            column(Due_Date; "Due Date") { }
            column(Dispatch_Through; ShippingAgent.Name) { }//"Transporter Name"{}
            column(External_Document_No_; "External Document No.") { }
            column(Buyer_Reference_Date; '') { }
            column(Order_Date; '') { }
            column(Order_No_; "Order No.") { }
            column(Nature_of_Supply; "Nature of Supply") { }
            column(Total_Gross_Weight; TotalGrossWeight) { }//"Total Gross Weight"{}
            column(Total_Net_Weight; '') { }//"Total Net Weight"{}
            column(Total_Packages; '') { }//"Total Packages"{}
            column(E_Way_Bill_No_; "E-Way Bill No.") { }
            column(HeaderComments; HeaderComments) { }
            column(BankAccName; BankAccName) { }
            column(BankName; BankName) { }
            column(BankAccountNo; BankAccountNo) { }
            column(BankAddress1; BankAddress1) { }
            column(BankAddress2; BankAddress2) { }
            column(BankCity; BankCity) { }
            column(BankIfscCode; BankIfscCode) { }
            column(BankPostCode; BankPostCode) { }
            column(BankStateDes; BankStateDes) { }
            column(BankCountryDes; BankCountryDes) { }
            column(FooterCompanyAddress; compyInfo.Address + ', ' + compyInfo."Address 2" + ', ' + compyInfo.City + ', ' + CompanyStateDesc + ', ' + CountryRegionDesc + '-' + compyInfo."Post Code") { }
#pragma warning disable AL0432
            column(FooterAddress2; 'T: ' + compyInfo."Phone No." + ' | E: ' + compyInfo."E-Mail" + ' | ' + 'W: ' + compyInfo."Home Page") { }
#pragma warning restore AL0432{}
            // column(FooterAddress2; 'CIN: ' + compyInfo."CIN No." + ' | Email: ' + 'info@medicainstrument.com' + ' | ' + compyInfo."Home Page")
            // { }
            column(Companyaddr1; CompanyAddr[2]) { }
            column(CompanyAddr2; CompanyAddr[3]) { }
            column(Companyaddr3; CompanyAddr[4]) { }
            column(Companyaddr4; CompanyAddr[5]) { }
            column(CompanyAddress; compyInfo.Address) { }
            column(CompanyAddress2; compyInfo."Address 2") { }
            column(CompanyCity; compyInfo.City) { }
            column(companyState; CompanyStateDesc) { }//compyInfo."State Code"){}
            column(CompanyPostCode; compyInfo."Post Code") { }
            column(CountryRegionDesc; CountryRegionDesc) { }
            column(CompanyName; compyInfo.Name) { }
            column(CIN; '') { }
            column(TCSAmt; TCSAmt) { }
            column(TcsPer; TcsPer) { }
            column(Payment_Terms_Code; "Payment Terms Code") { }
            column(Shipment_Method_Code; "Shipment Method Code") { }
            column(Sell_to_Contact; "Sell-to Contact") { }
            column(cu; cu) { }
            column(Ship_to_Name; "Ship-to Name") { }
            column(Ship_to_Address; "Ship-to Address") { }
            column(Ship_to_Address_2; "Ship-to Address 2") { }
            column(Ship_to_City; "Ship-to City") { }
            column(Ship_to_Post_Code; "Ship-to Post Code") { }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code") { }
            column(ShipToCountryDecs; ShipToCountryDecs) { }
            column(ShipToSateDesc; ShipToSateDesc) { }
            column(ShipToGSTNo; ShipToGSTNo) { }
            column(ShipToTan; ShipToTan) { }
            column(ShipToEmail; ShipToEmail) { }
            column(ShipToPhoneNo; ShipToPhoneNo) { }
            column(ShipToPanNo; ShipToPanNo) { }
            column(LocName; LocName) { }
            column(LocAdd; LocAdd) { }
            column(LocAdd2; LocAdd2) { }
            column(LocCity; LocCity) { }
            column(LocState; LocState) { }
            column(LocStateCode; LocStateCode) { }
            column(LocEmail; LocEmail) { }
            column(LocPhone; LocPhone) { }
            column(Loccountry; Loccountry) { }
            column(LocPostCode; LocPostCode) { }
            column(LocCompName; LocCompName) { }
            column(locationGst; locationGst) { }
            column(PackingType; '') { }//"Total Packages"{}
            column(LR_RR_Date; "LR/RR Date") { }
            column(LR_RR_No_; "LR/RR No.") { }
            column(LFS_No__of_Packages; '') { }
            column(Total_Pieces; Total_Pieces) { }
            column(NewSalesOrderNo; NewSalesOrderNo) { }
            column(ShipmentMethodName; ShipmentMethodName) { }
            column(TransporterMethodName; TransporterMethodName)
            { }
            column(Shippi_Agent_SerDescrip; ShippingAgentServices.Description) { }
            column(IRN_Hash; "IRN Hash") { }
            column(Acknowledgement_Date; "Acknowledgement Date") { }
            column(Acknowledgement_No_; "Acknowledgement No.") { }
            column(LocCountryName; LocCountryName) { }
            column(PaymentTermsDesc; PaymentTermsDesc) { }
            column(SumQuantityLine; SumQuantityLine) { }
            column(CustLedEntAmtLCY; Round(CustLedEntAmtLCY, 1, '=')) { }
            column(CorresBankName; CorresBankName) { }
            column(CorresBankAccName; CorresBankAccName) { }
            column(CorresBankAccountNo; CorresBankAccountNo) { }
            column(CorresBankAddress1; CorresBankAddress1) { }
            column(CorresBankAddress2; CorresBankAddress2) { }
            column(CorresBankCity; CorresBankCity) { }
            column(CorresBankIfscCode; CorresBankIfscCode) { }
            column(CorresBankPostCode; CorresBankPostCode) { }
            column(CorresBankStateDes; CorresBankStateDes) { }
            column(CorresBankCountryDes; CorresBankCountryDes) { }
            column(Currency_Code; "Currency Code") { }
            column(SellToSalutatioCode; SellToSalutatioCode) { }
            column(ShipToSalutationCode; ShipToSalutationCode) { }
            column(ShipToContact; ShipToContact) { }
            column(ShipToContactPhoneNo; ShipToContactPhoneNo) { }
            column(TermAndCondDescrip; TermAndCondDescrip) { }
            column(SystemCreatedBy; SystemCreatedByUser) { }
            column(ContactName; ContactName) { }
            column(ContactPhoneNo; ContactPhoneNo) { }
            column(RoundingAmt; RoundingAmt) { }
            column(TotalItemQty; TotalItemQty) { }
            column(Ship_to_Code; "Ship-to Code")
            {


            }
            column(BuyersAddressName; BuyersAddressName) { }
            column(GST_Customer_Type; "GST Customer Type") { }
            column(Total_Line_Discount_Amount; TotalLineDicsAmt) { }
            column(TotalLineDicsAmt; TotalLineDicsAmt) { }
            dataitem(CopyLoop; Integer)
            {
                DataItemLinkReference = "Sales Invoice Header";
                DataItemTableView = sorting(Number);
                column(Hedername; CopyText) { }

                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));
                    column(OutputNo; OutputNo)
                    { }
                    // column(Hedername; CopyText)
                    // { }
                    column(PageNo; PageCaptionCap)
                    { }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = field("No."), "Sell-to Customer No." = field("Sell-to Customer No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        // DataItemTableView = sorting(Type) where(Type = filter(<> ''), "No." = filter(<> '402545'));//402545
                        DataItemTableView = sorting("Document No.", "Line No.") where(Type = filter(<> ''), "No." = filter(<> '402545'));
                        column(No; "No.")
                        { }
                        column(HSN_SAC_Code; HSN_SAC_Code)
                        { }
                        column(HSNSAC_Description; HSNSAC.Description) { }
                        column(Quantity; Quantity)
                        { }
                        column(Length_mtr_pc; '') { }
                        column(No_of_Pc; '') { }
                        column(No_Of_Packages; '') { }
                        column(Description; Description)
                        { }
                        column(Description_2; DescriptionCustom)
                        {
                        }
                        column(Description_3; "Description 2") { }
                        // column(Unit_Price; "Unit Price")
                        // { }
                        column(Unit_Price; InvLineRate)
                        { }
                        column(Line_Discount_Amount; InvLineLine_Discount)
                        { }
                        column(Line_Discount__; "Line Discount %")
                        { }
                        column(Amount; InvLineAmount)
                        { }
                        column(Comments; Comments)
                        { }
                        column(Unit_of_Measure_Code; "Unit of Measure Code")
                        { }
                        column(GSTRate; GSTRate)
                        { }
                        column(IGSTPer; IGSTPer)
                        { }
                        column(SGSTPer; SGSTPer)
                        { }
                        column(CGSTPer; CGSTPer)
                        { }
                        column(CGSTAmt; Round(CGSTAmt, 0.01, '<'))
                        { }
                        column(SGSTAmt; Round(SGSTAmt, 0.01, '<'))
                        { }
                        column(IGSTAmt; Round(IGSTAmt, 0.01, '<'))
                        { }
                        column(TCSAmt1; Round(TCSAmt1, 0.01, '<'))
                        { }
                        column(GrandTotal; Round(GrandTotal, 0.01, '<'))
                        { }
                        // column(GrandTotal; GrandTotal)
                        // { }
                        column(AmtInWords; Notext1[1] + ' ' + Notext1[2])
                        { }
                        column(AmtInWords2; Notext2[1] + ' ' + Notext2[2])
                        { }
                        column(AmtInWords3; Notext3[1] + ' ' + Notext3[2])
                        { }
                        column(SrNo; SrNo)
                        { }
                        column(TotalCGST; TotalCGST)
                        { }
                        column(TotalIGST; TotalIGST)
                        { }
                        column(TotalSGST; TotalSGST)
                        { }
                        column(TaxAbleAmt; TaxAbleAmt)
                        { }
                        column(Shipment_Date; "Shipment Date")
                        { }
                        column(Shipment_No_; "Shipment No.")
                        { }
                        column(SerialNo; SerialNo)
                        { }
                        column(LotNo; LotNo)
                        { }
                        column(NoofPacks; NoofPacks)
                        { }
                        column(Aux_Qty; Round(0, 0.001, '>'))
                        {
                            DecimalPlaces = 3 : 3;
                        }
                        column(Aux_UOM; '')
                        {

                        }
                        column(Aux_Amount; '')
                        {

                        }
                        column(Custom_Exch_Rate; "LFS Custom Exch. Rate") { }
                        column(Aux_Unit_Rate; AuxUnitRateVar)
                        {

                        }
                        column(Insurance_Value_Per_Type__LCY_; "LFS Insurance Value (LCY)") { }
                        column(Freight_Value_Per_Type__LCY_; "LFS Freight Value (LCY)") { }

                        // column(CustLedEntAmtLCY; Round(CustLedEntAmtLCY, 1, '='))
                        // { }
                        trigger OnPreDataItem()
                        begin
                            // if CustomerPostingGrp.GET("Sales Invoice Header"."Customer Posting Group") then;
                            // if "Sales Invoice Line".Type = "Sales Invoice Line".Type::"G/L Account" then
                            //     "Sales Invoice Line".SetFilter("No.", '<>%1', CustomerPostingGrp."Invoice Rounding Account");
                            clear(TotalFreight);
                            // clear(TotalInsurance);
                        end;

                        trigger OnAfterGetRecord()
                        begin
                            // if CustomerPostingGrp.GET("Sales Invoice Header"."Customer Posting Group") then;
                            // if "Sales Invoice Line".Type = "Sales Invoice Line".Type::"G/L Account" then
                            //     if "Sales Invoice Line"."No." = CustomerPostingGrp."Invoice Rounding Account" then
                            //         CurrReport.Skip();

                            SrNo += 1;
                            SumOFAmount += Amount;
                            Clear(DescriptionCustom);
                            if "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item then begin
                                Crlf := TypeHelper.CRLFSeparator();
                                if "Sales Invoice Line"."HSN/SAC Code" <> '' then
                                    if HSNSACRec.Get("Sales Invoice Line"."GST Group Code", "Sales Invoice Line"."HSN/SAC Code") then;
                                if HSNSACRec.Description <> '' then
                                    DescriptionCustom := HSNSACRec.Description + Crlf;
                            end;
                            if "Sales Invoice Line".Type <> "Sales Invoice Line".type::"Charge (Item)" then
                                HSN_SAC_Code := "Sales Invoice Line"."HSN/SAC Code"
                            else
                                HSN_SAC_Code := '';
                            Comments := '';
                            SalesCommentLine.Reset();
                            //SalesCommentLine.SetRange("Document Type", "Purchase Line"."Document Type");
                            SalesCommentLine.SetRange("No.", "Sales Invoice Line"."Document No.");
                            SalesCommentLine.SetRange("Document Line No.", "Sales Invoice Line"."Line No.");
                            if SalesCommentLine.FindSet() then
                                repeat
                                    if Comments = '' then
                                        Comments := SalesCommentLine.Comment
                                    else
                                        Comments += ', ' + SalesCommentLine.Comment;
                                until SalesCommentLine.Next() = 0;

                            Clear(TCSAmt1);
                            TCSENtry.Reset();
                            TCSENtry.SetRange("Document No.", "Sales Invoice Header"."No.");
                            if TCSENtry.FindFirst() then
                                repeat
                                    TCSAmt1 += TCSENtry."TCS Amount";
                                    TcsPer := TCSENtry."TCS %";
                                until TCSENtry.Next() = 0;

                            CGSTPer := 0;
                            CGSTAmt := 0;
                            SGSTPer := 0;
                            SGSTAmt := 0;
                            IGSTPer := 0;
                            IGSTAmt := 0;
                            TaxAbleAmt := 0;
                            //  GrandTotal1 := 0;

                            DetailedGSTLedgerEntry.RESET();
                            DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                            DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Line No.");
                            DetailedGSTLedgerEntry.SETFILTER("Entry Type", '%1', DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
                            IF DetailedGSTLedgerEntry.FIND('-') THEN
                                REPEAT
                                    CASE DetailedGSTLedgerEntry."GST Component Code" OF
                                        'CGST':
                                            BEGIN
                                                CGSTPer := DetailedGSTLedgerEntry."GST %";
                                                CGSTAmt += DetailedGSTLedgerEntry."GST Amount" * -1;
                                                TotalCGST += CGSTAmt;
                                                TaxAbleAmt := Abs(DetailedGSTLedgerEntry."GST Base Amount");
                                            END;
                                        'SGST':
                                            BEGIN
                                                SGSTPer := DetailedGSTLedgerEntry."GST %";
                                                SGSTAmt += DetailedGSTLedgerEntry."GST Amount" * -1;
                                                TotalSGST += SGSTAmt;
                                                TaxAbleAmt := Abs(DetailedGSTLedgerEntry."GST Base Amount");
                                            END;
                                        'IGST':
                                            BEGIN
                                                IGSTPer := DetailedGSTLedgerEntry."GST %";
                                                IGSTAmt += DetailedGSTLedgerEntry."GST Amount" * -1; //*"Sales Invoice Header"."Currency Factor";
                                                TotalIGST += IGSTAmt;
                                                TaxAbleAmt := Abs(DetailedGSTLedgerEntry."GST Base Amount");
                                            END;
                                    END;
                                UNTIL DetailedGSTLedgerEntry.NEXT() = 0;


                            if SGSTPer <> 0 then
                                GSTRate := SGSTPer + CGSTPer;

                            if CGSTPer <> 0 then
                                GSTRate := CGSTPer + SGSTPer;

                            if IGSTPer <> 0 then
                                GSTRate := IGSTPer;
                            GrandTotal1 += IGSTAmt + CGSTAmt + SGSTAmt + "Sales Invoice Line".Amount;
                            GrandTotal := GrandTotal1 + TCSAmt1;

                            InitTextVariable();
                            FormatNoText(Notext1, GrandTotal, "Sales Invoice Header"."Currency Code");
                            TotalOfGSt += IGSTAmt + CGSTAmt + SGSTAmt;
                            // FormatNoText(Notext2, TotalOfGSt, "Sales Invoice Header"."Currency Code");
                            CurrancyCode := 'INR';
                            FormatNoText(Notext2, TotalOfGSt, CurrancyCode);

                            //Clear(TCSAmt);

                            // TotalFreight += "Freight Value Per Type (LCY)";
                            // TotalInsurance += "Insurance Value Per Type (LCY)";


                            // CustLedgerEntry.Reset();
                            // CustLedgerEntry.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                            // //CustLedgerEntry.SetRange("Posting Date", "Sales Invoice Header"."Posting Date");
                            // CustLedgerEntry.SetRange("Customer No.", "Sales Invoice Line"."Sell-to Customer No.");
                            // if CustLedgerEntry.FindFirst() then begin
                            //     CustLedgerEntry.CalcFields("Amount (LCY)");
                            //     CustLedEntAmtLCY := CustLedgerEntry."Amount (LCY)" + TotalIGST - TotalFreight - TotalInsurance;
                            // end;

                            // FormatNoText(Notext3, CustLedEntAmtLCY, "Sales Invoice Header"."Currency Code");

                            CurrancyCode := 'INR';
                            FormatNoText(Notext3, CustLedEntAmtLCY, CurrancyCode);

                            Clear(SerialNo);
                            Clear(LotNo);
                            ValueEntry.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                            ValueEntry.SetRange("Document Line No.", "Sales Invoice Line"."Line No.");
                            ValueEntry.SetRange("Item No.", "Sales Invoice Line"."No.");
                            ValueEntry.SetRange("Variant Code", "Sales Invoice Line"."Variant Code");
                            ValueEntry.SetRange("Location Code", "Sales Invoice Line"."Location Code");
                            ValueEntry.SetFilter("Item Charge No.", '=%1', '');
                            ValueEntry.SetFilter(Adjustment, '%1', false);
                            if ValueEntry.FindSet() then
                                repeat
                                    ILE.SetRange("Entry No.", ValueEntry."Item Ledger Entry No.");
                                    if ILE.FindSet() then
                                        repeat
                                            if SerialNo = '' then
                                                SerialNo := ILE."Serial No."
                                            else
                                                SerialNo += ', ' + ILE."Serial No.";

                                            if LotNo = '' then
                                                LotNo := ILE."Lot No."
                                            else
                                                LotNo += ', ' + ILE."Lot No.";
                                        until ILE.Next() = 0;

                                until ValueEntry.Next() = 0;

                            if "Sales Invoice Header"."Currency Code" <> '' then begin
                                InvLineRate := "Sales Invoice Line"."Unit Price" / "Sales Invoice Header"."Currency Factor";
                                InvLineLine_Discount := "Sales Invoice Line"."Line Discount Amount" / "Sales Invoice Header"."Currency Factor";
                                TotalInvLineLine_Discount += "Sales Invoice Line"."Line Discount Amount" / "Sales Invoice Header"."Currency Factor";
                                // InvLineAmount := "Sales Invoice Line".Amount / "Sales Invoice Header"."Currency Factor";
                            end else begin
                                InvLineRate := "Sales Invoice Line"."Unit Price";
                                InvLineLine_Discount := "Sales Invoice Line"."Line Discount Amount";
                                TotalInvLineLine_Discount += "Sales Invoice Line"."Line Discount Amount";
                                // InvLineAmount := "Sales Invoice Line".Amount;
                            end;

                            Clear(AuxUnitRateVar);
                            // if "LFS Custom Exch. Rate" <> 0 then
                            //     AuxUnitRateVar := "Sales Invoice Line"."Aux Unit Rate" * "Sales Invoice Line"."Custom Exch. Rate"
                            // else
                            //     AuxUnitRateVar := "Sales Invoice Line"."Aux Unit Rate";

                            // InvLineAmount := AuxUnitRateVar * "Sales Invoice Line"."Aux Qty";


                            HSNSAC.reset();
                            HSNSAC.setrange(Code, "HSN/SAC Code");
                            if HSNSAC.findfirst() then;
                        end;
                    }
                }
                trigger OnPreDataItem()
                begin
                    Clear(NoOfCopies);
                    IF RepTypeOpt = RepTypeOpt::"All Pages" THEN
                        NoOfCopies := 5
                    ELSE
                        NoOfCopies := 1;
                    NoOfLoops := NoOfCopies;
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;

                trigger OnAfterGetRecord()
                begin
                    Clear(SrNo);
                    //  GrandTotal := 0;
                    GrandTotal1 := 0;
                    TotalOfGSt := 0;
                    TCSAmt1 := 0;
                    TaxAbleAmt := 0;
                    IF RepTypeOpt = RepTypeOpt::"All Pages" THEN BEGIN
                        IF Number = 1 THEN BEGIN
                            CopyText := 'Duplicate For Transporter';
                            OutputNo += 1;
                        END
                        ELSE
                            IF Number = 2 THEN BEGIN
                                CopyText := 'Triplicate For Assessee';
                                OutputNo += 1;
                            END
                            ELSE
                                IF Number = 3 THEN BEGIN
                                    CopyText := 'Extra Copy';
                                    OutputNo += 1;
                                END
                                else
                                    IF Number = 4 THEN BEGIN
                                        CopyText := 'Extra Copy';
                                        OutputNo += 1;
                                    END
                                    else
                                        IF Number = 5 THEN BEGIN
                                            CopyText := 'Original For Buyer';
                                            OutputNo += 1;
                                        END
                    END
                    ELSE begin
                        IF RepTypeOpt = RepTypeOpt::"Original For Buyer" THEN BEGIN
                            Clear(CopyText);
                            CopyText := 'Original For Buyer';
                            OutputNo += 1;
                        END
                        ELSE
                            IF RepTypeOpt = RepTypeOpt::"Duplicate For Transporter" THEN BEGIN
                                Clear(CopyText);
                                OutputNo += 1;
                                CopyText := 'Duplicate For Transporter';
                            END
                            ELSE
                                IF RepTypeOpt = RepTypeOpt::"Triplicate For Assessee" THEN BEGIN
                                    Clear(CopyText);
                                    CopyText := 'Triplicate For Assessee';
                                    OutputNo += 1;
                                END
                                ELSE
                                    IF RepTypeOpt = RepTypeOpt::"Extra Copy" THEN BEGIN
                                        Clear(CopyText);
                                        CopyText := 'Extra Copy';
                                        OutputNo += 1;
                                    end;
                    end;
                    CurrReport.PAGENO := 1;
                end;
            }
            trigger OnAfterGetRecord()//Header
            var
                DetailedGSTLedgerEntry_Rec: Record "Detailed GST Ledger Entry";
                SalesInvLine: Record "Sales Invoice Line";
                IGSTNew, TotalFreight, TotalIGSTNew, TotalInsurance : Decimal;
            begin
                Clear(TotalItemQty);
                Clear(TotalGrossWeight);

                Clear(TotalInsurance);
                Clear(TotalFreight);
                Clear(TotalLineDicsAmt);

                SalesInvLine.Reset();
                SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
                if SalesInvLine.FindSet() then
                    repeat
                        // TotalItemQty += SalesInvLine."Aux Qty";
                        TotalGrossWeight += SalesInvLine."Gross Weight";

                        TotalInsurance += SalesInvLine."LFS Insurance Value (LCY)";
                        TotalFreight += SalesInvLine."LFS Freight Value (LCY)";

                        if "Sales Invoice Header"."Currency Factor" <> 0 then
                            TotalLineDicsAmt += ("SalesINvLine"."Line Discount Amount" / "Sales Invoice Header"."Currency Factor")
                        else
                            TotalLineDicsAmt += "SalesINvLine"."Line Discount Amount";
                    until SalesInvLine.Next() = 0;

                DetailedGSTLedgerEntry_Rec.RESET();
                DetailedGSTLedgerEntry_Rec.SETRANGE("Document No.", "No.");
                // DetailedGSTLedgerEntry_Rec.SETRANGE("Document Line No.", "Line No.");
                DetailedGSTLedgerEntry_Rec.SETFILTER("Entry Type", '%1', DetailedGSTLedgerEntry_Rec."Entry Type"::"Initial Entry");
                IF DetailedGSTLedgerEntry_Rec.FIND('-') THEN
                    REPEAT
                        CASE DetailedGSTLedgerEntry_Rec."GST Component Code" OF
                            'IGST':
                                IGSTNew += DetailedGSTLedgerEntry_Rec."GST Amount" * -1; //*"Sales Invoice Header"."Currency Factor";
                        END;
                    UNTIL DetailedGSTLedgerEntry_Rec.NEXT() = 0;

                SalesInvLine.Reset();
                SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
                if SalesInvLine.FindSet() then;
                SalesInvLine.CalcSums("LFS Insurance Value (LCY)");
                SalesInvLine.CalcSums("LFS Freight Value (LCY)");
                CustLedgerEntry.Reset();
                CustLedgerEntry.SetRange("Document No.", "Sales Invoice Header"."No.");
                //CustLedgerEntry.SetRange("Posting Date", "Sales Invoice Header"."Posting Date");
                CustLedgerEntry.SetRange("Customer No.", "Sales Invoice Header"."Sell-to Customer No.");
                if CustLedgerEntry.FindFirst() then begin
                    CustLedgerEntry.CalcFields("Amount (LCY)");
                    CustLedEntAmtLCY := CustLedgerEntry."Amount (LCY)" + IGSTNew - TotalInsurance - TotalFreight - TotalLineDicsAmt;
                end;

                // CurrancyCode := 'INR';
                // FormatNoText(Notext3, CustLedEntAmtLCY, CurrancyCode);

                IF LocationRec.GET("Sales Invoice Header"."Location Code") THEN;


                if customer.Get("Sell-to Customer No.") then begin
                    SelltoCustomerPan := customer."P.A.N. No.";
                    SelltoCustomerPhoneNo := customer."Phone No.";
                    SelltoCustomerEmail := customer."E-Mail";
                    SelltoGST := customer."GST Registration No.";

                    if ContactRec2.Get(customer."Primary Contact No.") then begin
                        ContactName := ContactRec2.Name;
                        ContactPhoneNo := ContactRec2."Phone No.";
                    end;

                    // if StateRec.Get(customer."State Code") then
                    //     SelltoStateDescribtion := StateRec.Description;
                    // stateCode := StateRec."State Code (GST Reg. No.)";

                    // if Country_Region.Get(customer."Country/Region Code") then
                    //     SelltoCountryDesc := Country_Region.Name;
                end;

                //Get Data of Packing Type AND No. of Pack from Line Level Items+++
                //LFS-AS++ commented
                // SalesInvLine.Reset();
                // SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                // SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
                // if SalesInvLine.FindSet() then begin
                //     repeat
                // Item.Reset();
                // Item.SetRange("No.", SalesInvLine."No.");
                // if item.FindFirst() then begin
                //     if Item."No of Pack" <> 0 then begin
                //         if PackingType = '' then begin
                //             PackingType := Format(Item."No of Pack") + ' ' + Format(Item."Packing Type");
                //         end
                //         else
                //             PackingType += ' ,' + Format(Item."No of Pack") + ' ' + Format(Item."Packing Type");
                //     end;
                // end;
                //     until SalesInvLine.Next() = 0;
                // end;
                //LFS-AS--
                //Get Data of Packing Type AND No. of Pack from Line Level Items---


                //Get Sales Order No. and Order Date from line with no duplicate+++
                // SalesInvLine.Reset();
                // SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                // SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
                // SalesInvLine.SetCurrentKey("Order No.");
                // if SalesInvLine.FindSet() then begin
                //     repeat
                //         SalesInvLine.CalcFields("Order Date");
                //         if SalesInvLine."Order No." <> OldSalesOrderNo then begin
                //             if NewSalesOrderNo = '' then begin
                //                 NewSalesOrderNo := SalesInvLine."Order No." + ' • Date: ' + Format(SalesInvLine."Order Date");
                //                 NewSalesOrderNo1 := SalesInvLine."Order No.";
                //             end
                //             else begin
                //                 NewSalesOrderNo += ', ' + SalesInvLine."Order No." + ' • Date: ' + Format(SalesInvLine."Order Date");
                //                 NewSalesOrderNo1 := SalesInvLine."Order No.";
                //             end;
                //         end;
                //         OldSalesOrderNo := NewSalesOrderNo1;
                //     until SalesInvLine.Next() = 0;
                // end;

                // Clear(InvLineRate);
                // Clear(InvLineLine_Discount);
                // Clear(InvLineAmount);
                // SalesInvLine.Reset();
                // SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                // // SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
                // if SalesInvLine.FindSet() then begin
                //     repeat
                //         if "Sales Invoice Header"."Currency Code" <> '' then begin
                //             InvLineRate := SalesInvLine."Unit Price" / "Sales Invoice Header"."Currency Factor";
                //             InvLineLine_Discount := SalesInvLine."Line Discount Amount" / "Sales Invoice Header"."Currency Factor";
                //             InvLineAmount := SalesInvLine.Amount / "Sales Invoice Header"."Currency Factor";
                //         end;
                //     until SalesInvLine.Next() = 0;
                // end;
                //Get Sales Order No. and Order Date from line with no duplicate---


                //GET DATA FROM SHIP-TO-ADDRESS:
                if "Ship-to Code" <> '' then begin
                    ShipToAddressRec.SetRange(ShipToAddressRec.Code, "Ship-to Code");
                    ShipToAddressRec.SetRange(ShipToAddressRec."Customer No.", "Bill-to Customer No.");
                    if not ShipToAddressRec.FindFirst() then begin
                        ShipToEmail := ShipToAddressRec."E-Mail";
                        //ShipToPhoneNo := ShipToAddressRec."Phone No.";
                        // IF not "Ship-to Code Modify" then
                        ShipToGSTNo := ShipToAddressRec."GST Registration No.";
                        // ShipToPanNo := ShipToAddressRec."P.A.N. No.";
                        ShipToContact := ShipToAddressRec.Contact;

                        // if Salutation.Get(ShipToAddressRec."Salutation Code") then
                        //     ShipToSalutationCode := Salutation.Description + '.';

                        if StateRec.Get(ShipToAddressRec.State) then
                            // IF not "Ship-to Code Modify" then begin
                                ShipToSateDesc := StateRec.Description;
                        stateCode := StateRec."State Code (GST Reg. No.)";
                        // end;

                        if Country_Region.Get(ShipToAddressRec."Country/Region Code") then
                            ShipToCountryDecs := Country_Region.Name;

                    end;
                    //END;
                    //COMMENTED NOT NEEDED DATA FROM CUSTOMER TABLE+++
                end else
                    if "Ship-to Code" = '' then begin
                        customer.get("Bill-to Customer No.");
                        ShipToEmail := customer."E-Mail";
                        ShipToGSTNo := customer."GST Registration No.";
                        ShipToPhoneNo := customer."Phone No.";
                        ShipToPanNo := customer."P.A.N. No.";
                        if ContactRec3.Get(customer."Primary Contact No.") then begin
                            ShipToContact := ContactRec3.Name;
                            ShipToContactPhoneNo := ContactRec3."Phone No.";
                        end;

                        ContactRec.Reset();
                        ContactRec.SetRange("No.", "Sales Invoice Header"."Sell-to Contact No.");
                        if ContactRec.FindFirst() then
                            if Salutation.Get(ContactRec."Salutation Code") then
                                ShipToSalutationCode := Salutation.Description + '.';

                        if StateRec.Get(customer."State Code") then
                            // IF not "Ship-to Code Modify" then begin
                                ShipToSateDesc := StateRec.Description;
                        stateCode := StateRec."State Code (GST Reg. No.)";
                        // end;

                        if Country_Region.Get(customer."Country/Region Code") then
                            ShipToCountryDecs := Country_Region.Name;
                    end;
                //COMMENTED NOT NEEDED DATA FROM CUSTOMER TABLE---


                //GET BILL-TO-CUSTOMER DETAILS FROM CUSTOMER TABLE:
                if customer.Get("Bill-to Customer No.") then begin
                    BilltoCustomerPan := customer."P.A.N. No.";
                    BilltoCustomerPhoneNo := customer."Phone No.";
                    BilltoCustomerEmail := customer."E-Mail";
                    BilltoGST := customer."GST Registration No.";

                    //STATE CODE AND DESCRIPTION+++
                    if StateRec.Get(customer."State Code") then begin
                        BilltoStateDescribtion := StateRec.Description;
                        BilltoStateCode := StateRec."State Code (GST Reg. No.)";
                    end;
                    //STATE CODE AND DESCRIPTION---

                    //COUNTRY DESC FROM CUSTOMER TABLE+++
                    if Country_Region.Get(customer."Country/Region Code") then
                        BilltoCountryDescribtion := Country_Region.Name;
                    //COUNTRY DESC FROM CUSTOMER TABLE---
                end;

                //Get Comments from Sales Invoice+++
                HeaderComments := '';
                SalesCommentLine.Reset();
                SalesCommentLine.SetRange("No.", "Sales Invoice Header"."No.");
                SalesCommentLine.SetFilter("Document Line No.", '%1', 0);
                if SalesCommentLine.FindSet() then
                    repeat
                        if HeaderComments = '' then
                            HeaderComments := SalesCommentLine.Comment
                        else
                            HeaderComments += ', ' + SalesCommentLine.Comment;
                    until SalesCommentLine.Next() = 0;
                //Get Comments from Sales Invoice---


                //GET BANK DETAILS & COUNTRY Desc FROM COMPANY ACC DETAILS+++
                if BankAccount.get("Company Bank Account Code") then begin
                    BankName := BankAccount.Name;
                    //BankAccName := BankAccount."Account Name";
                    BankAccountNo := BankAccount."Bank Account No.";
                    BankIfscCode := BankAccount."IFSC Code";
                    BankAddress1 := BankAccount.Address;
                    BankAddress2 := BankAccount."Address 2";
                    BankPostCode := BankAccount."Post Code";
                    BankCity := BankAccount.City;
                    if Country_Region.Get(BankAccount."Country/Region Code") then
                        BankCountryDes := Country_Region.Name;

                    //LFS-AS commented
                    // if "Sales Invoice Header"."Currency Code" <> '' then begin
                    //     if BankAccount.get(BankAccount."Corresponding Bank A/c") then begin
                    //         CorresBankName := BankAccount."Account Name";
                    //         CorresBankAccName := BankAccount."Account Name";
                    //         CorresBankAccountNo := BankAccount."Bank Account No.";
                    //         CorresBankIfscCode := BankAccount."IFSC Code";
                    //         CorresBankAddress1 := BankAccount.Address;
                    //         CorresBankAddress2 := BankAccount."Address 2";
                    //         CorresBankPostCode := BankAccount."Post Code";
                    //         CorresBankCity := BankAccount.City;

                    //         if Country_Region.Get(BankAccount."Country/Region Code") then
                    //             CorresBankCountryDes := Country_Region.Name;
                    //     end;
                    // end;
                end;
                //GET BANK DETAILS & COUNTRY Desc FROM COMPANY ACC DETAILS---


                //COUNTRY DESC FROM COMPANY INFO+++
                FormatAddr.Company(CompanyAddr, compyInfo);
                if Country_Region.Get(compyInfo."Country/Region Code") then
                    CountryRegionDesc := Country_Region.Name;
                //COUNTRY DESC FROM COMPANY INFO---


                //State Code & DESC FROM COMPANY INFO+++
                if StateRec.Get(compyInfo."State Code") then begin
                    CompanyStateDesc := StateRec.Description;
                    CompanyStateCode := StateRec."State Code (GST Reg. No.)";
                end;
                //State Code & DESC FROM COMPANY INFO---


                //if Currency.get("Currency Code") then
                // cu := Currency.Code
                cu := 'INR';


                IF ShipmentMethod.Get("Shipment Method Code") then
                    ShipmentMethodName := ShipmentMethod.Description;

                if TransporterMethod.Get("Transport Method") then
                    TransporterMethodName := TransporterMethod.Description;

                if LoactionRec.get("Location Code") then begin
                    LocName := LoactionRec.Name;
                    LocAdd := LoactionRec.Address;
                    LocAdd2 := LoactionRec."Address 2";
                    LocCity := LoactionRec.City;
                    LocPostCode := LoactionRec."Post Code";
                    Loccountry := LoactionRec."Country/Region Code";
                    StateRec.Reset();
                    if StateRec.Get(LoactionRec."State Code") then begin
                        LocState := StateRec.Description;
                        LocStateCode := StateRec."State Code (GST Reg. No.)"
                    end;
                    LocCompName := LoactionRec.Name;
                    locationGst := LoactionRec."GST Registration No.";
                    LocEmail := LoactionRec."E-Mail";
                    LocPhone := LocationRec."Phone No.";
                    if Country_Region.Get(LoactionRec."Country/Region Code") then
                        LocCountryName := Country_Region.Name;
                end;


                IF LoactionRec.GET("Location Code") THEN BEGIN
                    Address := LoactionRec.Address;
                    Address2 := LoactionRec."Address 2";
                    City := LoactionRec.City;
                    if StateRec.Get(LoactionRec."State Code") then
                        State_Code := StateRec.Description;
                    if Country_Region.Get(LoactionRec."Country/Region Code") then
                        CountryCode := Country_Region.Name;
                    PostCode := LoactionRec."Post Code";
                    PhNo := LoactionRec."Phone No.";
                    Email := LoactionRec."E-Mail";

                    if PaymentTerms.Get("Payment Terms Code") then
                        PaymentTermsDesc := PaymentTerms.Description;

                    ContactRec.Reset();
                    ContactRec.SetRange("No.", "Sales Invoice Header"."Sell-to Contact No.");
                    if ContactRec.FindFirst() then
                        if Salutation.Get(ContactRec."Salutation Code") then
                            SellToSalutatioCode := Salutation.Description + '.';

                    Clear(SumQuantityLine);
                    SalesInvLine.Reset();
                    SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                    SalesInvLine.SetFilter("Gen. Prod. Posting Group", '<>%1', 'SERVICE');
                    SalesInvLine.SetFilter("No.", '<>%1', '30210');
                    if SalesInvLine.FindSet() then
                        repeat
                            SumQuantityLine += SalesInvLine.Quantity;
                        until SalesInvLine.Next() = 0;

                    // Crlf := TypeHelper.CRLFSeparator();
                    // CRLF[1] := 13;
                    // CRLF[1] := 10;
                    SR1 := 0;
                    TermsNumber := 1;
                    Clear(TermAndCondDescrip);
                    // TermAndCondition.Reset();
                    // TermAndCondition.SetRange("Source Type", TermAndCondition."Source Type"::Sales);
                    // TermAndCondition.SetRange("Posted Document No.", "Sales Invoice Header"."No.");
                    // if TermAndCondition.FindSet() then
                    //     repeat
                    //         IF SR1 > 0 THEN
                    //             TermAndCondDescrip := TermAndCondDescrip + 'VbCrLf' + Format(TermsNumber) + '. ' + TermAndCondition.Description
                    //         ELSE
                    //             TermAndCondDescrip := TermAndCondDescrip + Format(TermsNumber) + '. ' + TermAndCondition.Description;
                    //         SR1 += 1;
                    //         TermsNumber += 1;
                    //     until TermAndCondition.Next() = 0;

                end;
                IF CustomerPostingGrpRec.Get("Sales Invoice Header"."Customer Posting Group") then begin
                    SalesInvLine.Reset();
                    SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                    SalesInvLine.SetRange("No.", CustomerPostingGrpRec."Invoice Rounding Account");
                    if SalesInvLine.FindFirst() then
                        RoundingAmt := SalesInvLine."Line Amount";
                end;

                User.Reset();
                User.SetRange(User."User Security ID", "Sales Invoice Header".SystemCreatedBy);
                if User.FindFirst() then
                    SystemCreatedByUser := User."User Name";
                if ShippingAgentServices.Get("Sales Invoice Header"."Shipping Agent Service Code") then;
                if ShippingAgent.Get("Sales Invoice Header"."Shipping Agent Code") then;
                Clear(Total_Pieces);
                SalesInvLineRec.Reset();
                SalesInvLineRec.SetRange("Document No.", "Sales Invoice Header"."No.");
                SalesInvLineRec.SetRange(SalesInvLineRec.Type, SalesInvLineRec.Type::Item);
                if SalesInvLineRec.FindSet() then
                    repeat
                    // Total_Pieces += SalesInvLineRec."No. of Pc";
                    until SalesInvLineRec.Next() = 0;

                TCSAmt := 0;
                TcsPer := 0;
                TCSENtry.SetRange("Document No.", "Sales Invoice Header"."No.");
                if TCSENtry.FindSet() then
                    repeat
                        TCSAmt := TCSENtry."TCS Amount";
                        TotalTCSAmt += TCSENtry."TCS Amount";
                        TcsPer := TCSENtry."TCS %";
                    until TCSENtry.Next() = 0;

                PostedExportInfo.Reset();
                PostedExportInfo.SetRange("LFS Document No.", "Sales Invoice Header"."No.");
                if PostedExportInfo.FindFirst() then begin
                    BuyersAddressName := GetBlobBuyersAddressNameAsText(PostedExportInfo);
                end;
            end;


        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Report Type Filter")
                {
                    field(RepTypeOpt; RepTypeOpt)
                    {
                        ApplicationArea = All;
                        Editable = true;
                        Enabled = true;
                        HideValue = false;
                        QuickEntry = true;
                        ShowCaption = true;
                        ToolTip = 'Specifies the value of the RepTypeOpt field.';
                        Visible = true;
                    }
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        compyInfo.Get();
        compyInfo.CalcFields(Picture);
        SrNo := 0;
        UserSetup.Get(UserId);


    end;

    var
        BankAccount: Record "Bank Account";
        compyInfo: Record "Company Information";
        ContactRec: Record Contact;
        ContactRec2: Record Contact;
        ContactRec3: Record Contact;
        Country_Region: Record "Country/Region";
        Currency: record Currency;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        customer: Record Customer;
        CustomerPostingGrp: Record "Customer Posting Group";
        CustomerPostingGrpRec: Record "Customer Posting Group";
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        GenLedSetup: Record "General Ledger Setup";
        HSNSAC: Record "HSN/SAC";
        HSNSACRec: Record "HSN/SAC";
        Item: Record Item;
        ILE: Record "Item Ledger Entry";
        LoactionRec: Record Location;
        LocationRec: Record Location;
        PaymentTerms: Record "Payment Terms";
        PostedExportInfo: Record "LFS Posted Export Information";
        // TermAndCondition: Record "LFS Posted Terms and Conditions";
        SalesCommentLine: Record "Sales Comment Line";
        SalesInvLine: Record "Sales Invoice Line";
        SalesInvLineRec: Record "Sales Invoice Line";
        Salutation: Record Salutation;
        ShipToAddressRec: Record "Ship-to Address";
        ShipmentMethod: Record "Shipment Method";
        ShippingAgent: Record "Shipping Agent";
        ShippingAgentServices: Record "Shipping Agent Services";
        StateRec: Record State;
        TCSENtry: Record "TCS Entry";
        TransporterMethod: Record "Transport Method";
        User: Record User;
        UserSetup: Record "User Setup";
        ValueEntry: Record "Value Entry";
        RepCheck: array[2] of Report Check;
        FormatAddr: Codeunit "Format Address";
        TypeHelper: Codeunit "Type Helper";
        BilltoStateCode: code[10];
        CompanyStateCode: code[10];
        CU: Code[10];
        curreyncSymbol: Code[10];
        HSN_SAC_Code: Code[10];
        LocStateCode: Code[10];
        stateCode: Code[10];
        BankPostCode: code[20];
        BilltoCustomerPan: Code[20];
        BilltoGST: code[20];
        CurrancyCode: Code[20];
        locationGst: code[20];
        LocPostCode: Code[20];
        NewItemNo: code[20];
        oldItemNo: Code[20];
        PostCode: Code[20];
        SelltoCustomerPan: Code[20];
        SelltoGST: code[20];
        LocState: Code[50];
        SalesOrderDate: Date;
        AuxUnitRateVar: Decimal;
        CGSTAmt: Decimal;
        CGSTPer: Decimal;
        CustLedEntAmtLCY: Decimal;
        GrandTotal: Decimal;
        GrandTotal1: Decimal;
        GSTRate: Decimal;
        IGSTAmt: Decimal;
        IGSTPer: Decimal;
        InvLineAmount: Decimal;
        InvLineLine_Discount: Decimal;
        InvLineRate: Decimal;
        NoofPacks: Decimal;
        RoundingAmt: Decimal;
        SGSTAmt: Decimal;
        SGSTPer: Decimal;
        SumOFAmount: Decimal;
        SumQuantityLine: Decimal;
        TaxAbleAmt: Decimal;
        TCSAmt: Decimal;
        TCSAmt1: Decimal;
        TcsPer: Decimal;
        TotalCGST: Decimal;
        TotalFreight, TotalInsurance : Decimal;
        TotalGrossWeight: Decimal;
        TotalIGST: Decimal;
        TotalInvLineLine_Discount: Decimal;
        TotalItemQty: Decimal;
        TotalLineDicsAmt: Decimal;
        TotalOfGSt: Decimal;
        TotalSGST: Decimal;
        TotalTCSAmt: Decimal;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        SR1: Integer;
        SrNo: Integer;
        TermsNumber: Integer;
        Total_Pieces: Integer;
        Amount_In_WordsCaptionLbl: Label 'Amount (in words):';
        AndLbl: Label 'And';
        CroreLbl: Label 'Crore';
        EighteenLbl: Label 'Eighteen';
        EightLbl: Label 'Eight';
        EightyLbl: Label 'Eighty';
        ElevenLbl: Label 'Eleven';
        FifteenLbl: Label 'Fifteen';
        FiftyLbl: Label 'Fifty';
        FiveLbl: Label 'Five';
        FortyLbl: Label 'Forty';
        FourLbl: Label 'Four';
        FourteenLbl: Label 'Fourteen';
        HundreadLbl: Label 'Hundred';
        LakhLbl: Label 'Lakh';
        NineLbl: Label 'Nine';
        NinetyLbl: Label 'Ninety';
        NinteenLbl: Label 'Nineteen';
        OneLbl: Label 'One';
        OnlyLbl: Label 'Only';
        PageCaptionCap: Label 'Page';
        SevenLbl: Label 'Seven';
        SeventeenLbl: Label 'Seventeen';
        SeventyLbl: Label 'Seventy';
        SixLbl: Label 'Six';
        SixteenLbl: Label 'Sixteen';
        SixtyLbl: Label 'Sixty';
        TenLbl: Label 'Ten';
        ThireentLbl: Label 'Thirteen';
        ThirtyLbl: Label 'Thirty';
        ThousandLbl: Label 'Thousand';
        ThreeLbl: Label 'Three';
        TwelveLbl: Label 'Twelve';
        TwentyLbl: Label 'Twenty';
        TwoLbl: Label 'Two';
        ZeroLbl: Label 'Zero';
        RepTypeOpt: Option "All Pages","Original For Buyer","Duplicate For Transporter","Triplicate For Assessee","Extra Copy";
        BankAccName: Text;
        BankAccountNo: text;
        BankAddress1: text;
        BankAddress2: Text;
        BankCity: Text;
        BankCountryDes: text;
        BankIfscCode: text;
        BankName: text;
        BankStateDes: text;
        BilltoCountryDescribtion: Text;
        BilltoCustomerEmail: text;
        BilltoCustomerPhoneNo: Text;
        BilltoStateDescribtion: Text;
        BuyersAddressName: Text;
        Comments: Text;
        CompanyStateDesc: Text;
        CorresBankAccName, CorresBankAccountNo, CorresBankAddress1, CorresBankAddress2, CorresBankCity, CorresBankCountryDes, CorresBankIfscCode, CorresBankName, CorresBankPostCode, CorresBankStateDes : text;
        CountryRegionDesc: Text;
        DescriptionCustom: Text;
        HeaderComments: Text;
        ItemDescription: Text;
        LocAdd: Text;
        LocAdd2: text;
        LocCity: text;
        LocCompName: Text;
        Loccountry: text;
        LocCountryName: Text;
        LotNo: Text;
        NewSalesOrderNo: Text;
        NewSalesOrderNo1: Text;
        NewSalesOrderNo2: Text;
        OldSalesOrderNo: Text;
        PackingType: Text;
        PaymentTermsDesc: Text;
        SelltoCountryDesc: Text;
        SelltoCustomerEmail: text;
        SelltoCustomerPhoneNo: Text;
        SellToSalutatioCode: Text;
        SelltoStateDescribtion: Text;
        SerialNo: Text;
        ShipmentMethodName: Text;
        ShipToContact: Text;
        ShipToCountryDecs: text;
        ShipToEmail: Text;
        ShipToGSTNo: Text;
        ShipToPanNo: Text;
        ShipToPhoneNo: Text;
        ShipToSalutationCode: Text;
        ShipToSateDesc: Text;
        ShipToTan: Text;
        State_Code: Text;
        TermAndCondDescrip: Text;
        TransporterMethodName: Text;
        CRLF: Text[2];
        ContactPhoneNo: text[30];
        ExponentText: array[5] of Text[30];
        LocPhone: Text[30];
        OnesText: array[20] of Text[30];
        PhNo: Text[30];
        ShipToContactPhoneNo: Text[30];
        TensText: array[10] of Text[30];
        CompanyAddr: array[8] of Text[50];
        CountryCode: Text[50];
        Notext1: array[2] of Text[50];
        Notext2: array[2] of Text[50];
        Notext3: array[2] of Text[50];
        SystemCreatedByUser: Text[50];
        Address: Text[57];
        Address2: Text[58];
        City: Text[59];
        Email: Text[80];
        LocEmail: Text[80];
        NoTextAmt: ARRAY[2] OF Text[80];
        NoTextAmt2: ARRAY[2] OF Text[80];
        NoTextExcise: array[2] of Text[80];
        ContactName: Text[100];
        CopyText: Text[100];
        LocName: Text[100];

    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var

        Currency: Record Currency;

        PrintExponent: Boolean;

        Exponent: Integer;

        Hundreds: Integer;

        NoTextIndex: Integer;

        Ones: Integer;

        OnesDec: Integer;

        Tens: Integer;

        TensDec: Integer;
    begin
        Clear(NoText);
        NoTextIndex := 1;
        NoText[1] := '';
        if No < 1 then
            AddToNoText(NoText, NoTextIndex, PrintExponent, ZeroLbl)
        else begin
            for Exponent := 4 downto 1 do begin
                PrintExponent := false;
                if No > 99999 then begin
                    Ones := No DIV (Power(100, Exponent - 1) * 10);
                    Hundreds := 0;
                end else begin
                    Ones := No DIV Power(1000, Exponent - 1);
                    Hundreds := Ones DIV 100;
                end;
                Tens := (Ones MOD 100) DIV 10;
                Ones := Ones MOD 10;
                if Hundreds > 0 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, HundreadLbl);
                end;
                if Tens >= 2 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    if Ones > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                end else
                    if (Tens * 10 + Ones) > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                if PrintExponent and (Exponent > 1) then
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                if No > 99999 then
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * Power(100, Exponent - 1) * 10
                else
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * Power(1000, Exponent - 1);
            end;
        end;
        //LFS-MR++
        // if CurrencyCode <> '' then begin
        //     IF Currency.Get(CurrencyCode) then
        //         CurrencyCode := 'INR';
        //     AddToNoText(NoText, NoTextIndex, PrintExponent, '' + CurrencyCode);
        // end else
        //LFS-MR++
        AddToNoText(NoText, NoTextIndex, PrintExponent, 'Rupees');
        AddToNoText(NoText, NoTextIndex, PrintExponent, AndLbl);
        TensDec := ROUND(((No * 100) MOD 100) DIV 10, 1);
        OnesDec := ROUND((No * 100) MOD 10, 1);
        if TensDec >= 2 then begin
            AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[TensDec]);
            if OnesDec > 0 then
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[OnesDec]);
        end else
            if (TensDec * 10 + OnesDec) > 0 then
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[TensDec * 10 + OnesDec])
            else
                AddToNoText(NoText, NoTextIndex, PrintExponent, ZeroLbl);
        //LFS-MR++
        // if (CurrencyCode <> '') then
        //     AddToNoText(NoText, NoTextIndex, PrintExponent, '' + '' + 'Only') //Currency."Currency Decimal Description" 
        // else //LFS-MR++
        AddToNoText(NoText, NoTextIndex, PrintExponent, 'Paisa Only');

    end;

    procedure GetBlobBuyersAddressNameAsText(PostedExportInfo: Record "LFS Posted Export Information"): Text
    var
        InStr: InStream;
        BlobText: Text;
    begin
        // PostedExportInfo.CalcFields("Buyer Name & Address");
        // if PostedExportInfo."Buyer Name & Address".HasValue then begin
        //     PostedExportInfo."Buyer Name & Address".CreateInStream(InStr);
        //     InStr.Read(BlobText);
        // end;
        exit(BlobText);
    end;

    procedure InitTextVariable()
    begin
        OnesText[1] := OneLbl;
        OnesText[2] := TwoLbl;
        OnesText[3] := ThreeLbl;
        OnesText[4] := FourLbl;
        OnesText[5] := FiveLbl;
        OnesText[6] := SixLbl;
        OnesText[7] := SevenLbl;
        OnesText[8] := EightLbl;
        OnesText[9] := NineLbl;
        OnesText[10] := TenLbl;
        OnesText[11] := ElevenLbl;
        OnesText[12] := TwelveLbl;
        OnesText[13] := ThireentLbl;
        OnesText[14] := FourteenLbl;
        OnesText[15] := FifteenLbl;
        OnesText[16] := SixteenLbl;
        OnesText[17] := SeventeenLbl;
        OnesText[18] := EighteenLbl;
        OnesText[19] := NinteenLbl;

        TensText[1] := '';
        TensText[2] := TwentyLbl;
        TensText[3] := ThirtyLbl;
        TensText[4] := FortyLbl;
        TensText[5] := FiftyLbl;
        TensText[6] := SixtyLbl;
        TensText[7] := SeventyLbl;
        TensText[8] := EightyLbl;
        TensText[9] := NinetyLbl;

        ExponentText[1] := '';
        ExponentText[2] := ThousandLbl;
        ExponentText[3] := LakhLbl;
        ExponentText[4] := CroreLbl;
    end;

    local procedure AddToNoText(
            var NoText: array[2] of Text[80];
            var NoTextIndex: Integer;
            var PrintExponent: Boolean;
            AddText: Text[30])
    begin
        PrintExponent := true;

        while StrLen(NoText[NoTextIndex] + ' ' + AddText) > MaxStrLen(NoText[1]) do
            NoTextIndex := NoTextIndex + 1;
        //if NoTextIndex > ArrayLen(NoText) then
        //Error(exceededStringErr, AddText);

        NoText[NoTextIndex] := DelChr(NoText[NoTextIndex] + ' ' + AddText, '<');

    end;

    local procedure GetGSTAmount(RecID: RecordID)
    var
        GSTSetup: Record "GST Setup";
        TaxTransactionValue: Record "Tax Transaction Value";
    begin
        if not GSTSetup.Get() then
            exit;
        // Clear(CGSTAmt);
        // Clear(CGSTPer);
        // Clear(SGSTAmt);
        // Clear(SGSTPer);
        // Clear(IGSTAmt);
        // Clear(IGSTPer);

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if TaxTransactionValue.FindSet() then
            repeat
                //TaxTransactionValue.CalcSums()(Amount);

                if TaxTransactionValue."Value ID" = 2 then begin
                    CGSTAmt += TaxTransactionValue.Amount;
                    CGSTPer := TaxTransactionValue.Percent;
                end;

                if TaxTransactionValue."Value ID" = 6 then begin

                    SGSTAmt += TaxTransactionValue.Amount;
                    SGSTPer := TaxTransactionValue.Percent;
                end;

                if TaxTransactionValue."Value ID" = 3 then begin
                    IGSTAmt += TaxTransactionValue.Amount;
                    IGSTPer := TaxTransactionValue.Percent;
                end;

            until TaxTransactionValue.Next() = 0;
    end;
}

// Report 50102 "Export Sales - Invoice"
// {
//     // //LFS-NK- Created New report for export INR values.
//     DefaultLayout = RDLC;
//     RDLCLayout = 'src/EXIM/Report Layouts/Tax Invoice Export.rdl';

//     Caption = 'Sales - Invoice INR';
//     Permissions = TableData "Sales Shipment Buffer" = rimd;
//     PreviewMode = PrintLayout;

//     dataset
//     {
//         dataitem("Sales Invoice Header"; "Sales Invoice Header")
//         {
//             DataItemTableView = sorting("No.");
//             RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
//             RequestFilterHeading = 'Posted Sales Invoice';
//             CalcFields = "QR Code";
//             // column(ReportForNavId_5581; 5581)
//             // {
//             // }
//             column(SoOrderDate; "Sales Invoice Header"."Shipment Date")
//             {
//             }
//             column(contactNumber; contactNumber)
//             {
//             }
//             column(contactPerson; contactPerson)
//             {
//             }
//             column(CustPanNO; CustPanNO)
//             {
//             }
//             column(No_SalesInvHdr; "No.")
//             {
//             }
//             column(InvDiscountAmountCaption; InvDiscountAmountCaptionLbl)
//             {
//             }
//             column(VATPercentageCaption; VATPercentageCaptionLbl)
//             {
//             }
//             column(VATAmountCaption; VATAmountCaptionLbl)
//             {
//             }
//             column(VATIdentifierCaption; VATIdentifierCaptionLbl)
//             {
//             }
//             column(TotalCaption; TotalCaptionLbl)
//             {
//             }
//             column(VATBaseCaption; VATBaseCaptionLbl)
//             {
//             }
//             column(PaymentTermsCaption; PaymentTermsCaptionLbl)
//             {
//             }
//             column(ShipmentMethodCaption; ShipmentMethodCaptionLbl)
//             {
//             }
//             column(EMailCaption; EMailCaptionLbl)
//             {
//             }
//             column(DocumentDateCaption; DocumentDateCaptionLbl)
//             {
//             }
//             column(RoundoffAmt; RoundoffAmt)
//             {
//             }
//             column(Agent; DimText)
//             {
//             }
//             column(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
//             {
//             }
//             column(FullDate; FullDate)
//             {
//             }
//             column(Currency_Factor; "Currency Factor")
//             {
//             }
//             column(SystemCreatedAt; SystemCreatedAt)
//             {
//             }
//             column(Document_Date; "Document Date") { }
//             column(QRCode; "QR Code")
//             {
//             }
//             column(IRN; "Sales Invoice Header"."IRN Hash")
//             {
//             }
//             column(LR_RR_Date; "LR/RR Date") { }
//             column(LR_RR_No_; "LR/RR No.") { }
//             column(LR_No__2; "LR No. 2")
//             {
//             }
//             column(LR_Date_2; "LR Date 2")
//             {
//             }
//             dataitem(CopyLoop; "Integer")
//             {
//                 DataItemTableView = sorting(Number);
//                 // column(ReportForNavId_5701; 5701)
//                 // {
//                 // }
//                 dataitem(PageLoop; "Integer")
//                 {
//                     DataItemTableView = sorting(Number) where(Number = const(1));
//                     // column(ReportForNavId_6455; 6455)
//                     // {
//                     // }
//                     column(DrugLicNo; DrugLicNo) { }
//                     column(Unit_Price; Unit_Price) { }
//                     column(PANNo; CompanyInfo."P.A.N. No.")
//                     {
//                     }
//                     column(CompanyInfo3Picture; CompanyInfo.Picture)
//                     {
//                     }
//                     column(DocumentCaptionCopyText; CopyText)
//                     {
//                     }
//                     column(CompanyRegistrationLbl; CompanyRegistrationLbl)
//                     {
//                     }
//                     column(CompanyInfo_GST_RegistrationNo; CompanyInfo."GST Registration No.")
//                     {
//                     }
//                     column(CustomerRegistrationLbl; CustomerRegistrationLbl)
//                     {
//                     }
//                     column(Customer_GST_RegistrationNo; Customer."GST Registration No.")
//                     {
//                     }
//                     column(GSTComponentCode1; GSTComponentCode[1] + ' Amount')
//                     {
//                     }
//                     column(GSTComponentCode2; GSTComponentCode[2] + ' Amount')
//                     {
//                     }
//                     column(GSTComponentCode3; GSTComponentCode[3] + ' Amount')
//                     {
//                     }
//                     column(GSTComponentCode4; GSTComponentCode[4] + 'Amount')
//                     {
//                     }
//                     column(GSTCompAmount1; Format(Abs(GSTCompAmount[1]), 0, '<Precision,2><Integer Thousand><Decimals,3>'))
//                     {
//                     }
//                     column(GSTCompAmount2; Format(Abs(GSTCompAmount[2]), 0, '<Precision,2><Integer Thousand><Decimals,3>'))
//                     {
//                     }
//                     column(GSTCompAmount3; Format(Abs(GSTCompAmount[3]), 0, '<Precision,2><Integer Thousand><Decimals,3>'))
//                     {
//                     }
//                     column(GSTCompAmount4; Format(Abs(GSTCompAmount[4]), 0, '<Precision,2><Integer Thousand><Decimals,3>'))
//                     {
//                     }
//                     column(txtComment; txtComment)
//                     {
//                     }
//                     column(IsGSTApplicable; IsGSTApplicable)
//                     {
//                     }
//                     column(CustAddr1; CustAddr[1])
//                     {
//                     }
//                     column(CompanyAddr1; CompanyAddr[1])
//                     {
//                     }
//                     column(LocationAdd1; LocationAdd[1])
//                     {
//                     }
//                     column(CustAddr2; CustAddr[2])
//                     {
//                     }
//                     column(CompanyAddr2; CompanyAddr[2])
//                     {
//                     }
//                     column(CustAddr3; CustAddr[3])
//                     {
//                     }
//                     column(CompanyAddr3; CompanyAddr[3])
//                     {
//                     }
//                     column(CustAddr4; CustAddr[4])
//                     {
//                     }
//                     column(CompanyAddr4; CompanyAddr[4])
//                     {
//                     }
//                     column(CustAddr5; CustAddr[5])
//                     {
//                     }
//                     column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
//                     {
//                     }
//                     column(MfgLicNo; ''/* CompanyInfo."Mfg. Lic No." */)
//                     {
//                     }
//                     column(LRNo2; LRNo2)
//                     {
//                     }
//                     column(LRDate2; LRDate2)
//                     {
//                     }
//                     column(DLNoBuyer; DLNoBuyer)
//                     {
//                     }
//                     column(LUTNumber; LUTNumber)
//                     {
//                     }
//                     column(DLNoConsignee; DLNoConsignee)
//                     {
//                     }
//                     column(CustAddr6; CustAddr[6])
//                     {
//                     }
//                     column(LocationAdd2; LocationAdd[2])
//                     {
//                     }
//                     column(LocationAdd3; LocationAdd[3])
//                     {
//                     }
//                     column(LocationAdd4; LocationAdd[4])
//                     {
//                     }
//                     column(LocationAdd5; LocationAdd[5])
//                     {
//                     }
//                     column(LocationAdd6; LocationAdd[6])
//                     {
//                     }
//                     column(PaymentTermsDescription; PaymentTerms.Description)
//                     {
//                     }
//                     column(ShipmentMethodDescription; ShipmentMethod.Description)
//                     {
//                     }
//                     column(CompanyInfoHomePage; CompanyInfo."Home Page")
//                     {
//                     }
//                     column(CompanyInfoEMail; CompanyInfo."E-Mail")
//                     {
//                     }
//                     column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
//                     {
//                     }
//                     column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
//                     {
//                     }
//                     column(CompanyInfoBankName; CompanyInfo."Bank Name")
//                     {
//                     }
//                     column(CompanyInfoBankAccountNo; CompanyInfo."Bank Account No.")
//                     {
//                     }
//                     column(BillToCustNo_SalesInvHdr; "Sales Invoice Header"."Bill-to Customer No.")
//                     {
//                     }
//                     column(PostingDate_SalesInvHdr; Format("Sales Invoice Header"."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'))
//                     {
//                     }
//                     column(VATNoText; VATNoText)
//                     {
//                     }
//                     column(VATRegNo_SalesInvHdr; "Sales Invoice Header"."VAT Registration No.")
//                     {
//                     }
//                     column(LUTCode; "Sales Invoice Header"."Transport Method")
//                     {
//                     }
//                     column(DueDate_SalesInvoiceHdr; Format("Sales Invoice Header"."Due Date", 0, '<Day,2>-<Month,2>-<Year4>'))
//                     {
//                     }
//                     column(SalesPersonText; SalesPersonText)
//                     {
//                     }
//                     column(ShippingAgent; ShippingAgent.Name)
//                     {
//                     }
//                     column(SalesPurchPersonName; SalesPurchPerson.Name)
//                     {
//                     }
//                     column(ReferenceText; ReferenceText)
//                     {
//                     }
//                     column(YourReference_SalesInvHdr; "Sales Invoice Header"."Your Reference")
//                     {
//                     }
//                     column(OrderNoText; OrderNoText)
//                     {
//                     }
//                     column(OrderNo_SalesInvoiceHdr; "Sales Invoice Header"."Order No.")
//                     {
//                     }
//                     column(CustAddr7; CustAddr[7])
//                     {
//                     }
//                     column(CustAddr8; CustAddr[8])
//                     {
//                     }
//                     column(CompanyAddr5; CompanyAddr[5])
//                     {
//                     }
//                     column(CompanyAddr6; CompanyAddr[6])
//                     {
//                     }
//                     column(DocDate_SalesInvHeader; Format("Sales Invoice Header"."Document Date", 0, '<Day,2>-<Month,2>-<Year4>'))
//                     {
//                     }
//                     column(PricesInclVAT_SalesInvHdr; "Sales Invoice Header"."Prices Including VAT")
//                     {
//                     }
//                     column(OutputNo; OutputNo)
//                     {
//                     }
//                     column(PricesInclVATYesNo; Format("Sales Invoice Header"."Prices Including VAT"))
//                     {
//                     }
//                     column(PageCaption; PageCaptionCap)
//                     {
//                     }
//                     // column(PLAEntryNo_SalesInvHdr; "Sales Invoice Header"."PLA Entry No.") LFS commented
//                     // {
//                     // }
//                     column(SupplementaryText; SupplementaryText)
//                     {
//                     }
//                     //LFS commented++
//                     // column(RG23AEntryNo_SalesInvHdr; "Sales Invoice Header"."RG 23 A Entry No.")
//                     // {
//                     // }
//                     // column(RG23CEntryNo_SalesInvHdr; "Sales Invoice Header"."RG 23 C Entry No.")
//                     // {
//                     // }
//                     //LFS commented--
//                     column(PhoneNoCaption; PhoneNoCaptionLbl)
//                     {
//                     }
//                     column(HomePageCaption; HomePageCaptionCap)
//                     {
//                     }
//                     column(VATRegNoCaption; VATRegNoCaptionLbl)
//                     {
//                     }
//                     column(GiroNoCaption; GiroNoCaptionLbl)
//                     {
//                     }
//                     column(BankNameCaption; BankNameCaptionLbl)
//                     {
//                     }
//                     column(BankAccNoCaption; BankAccNoCaptionLbl)
//                     {
//                     }
//                     column(DueDateCaption; DueDateCaptionLbl)
//                     {
//                     }
//                     column(InvoiceNoCaption; InvoiceNoCaptionLbl)
//                     {
//                     }
//                     column(PostingDateCaption; PostingDateCaptionLbl)
//                     {
//                     }
//                     column(PLAEntryNoCaption; PLAEntryNoCaptionLbl)
//                     {
//                     }
//                     column(RG23AEntryNoCaption; RG23AEntryNoCaptionLbl)
//                     {
//                     }
//                     column(RG23CEntryNoCaption; RG23CEntryNoCaptionLbl)
//                     {
//                     }
//                     column(ServiceTaxRegistrationNoCaption; ServiceTaxRegistrationNoLbl)
//                     {
//                     }
//                     column(ServiceTaxRegistrationNo; ServiceTaxRegistrationNo)
//                     {
//                     }
//                     column(BillToCustNo_SalesInvHdrCaption; "Sales Invoice Header".FieldCaption("Bill-to Customer No."))
//                     {
//                     }
//                     column(PricesInclVAT_SalesInvHdrCaption; "Sales Invoice Header".FieldCaption("Prices Including VAT"))
//                     {
//                     }
//                     column(SellToCustNo_SalesInvHdr; "Sales Invoice Header"."Sell-to Customer No.")
//                     {
//                     }
//                     column(ShipToAddr1; ShipToAddr[1])
//                     {
//                     }
//                     column(ShipToAddr2; ShipToAddr[2])
//                     {
//                     }
//                     column(ShipToAddr3; ShipToAddr[3])
//                     {
//                     }
//                     column(ShipToAddr4; ShipToAddr[4])
//                     {
//                     }
//                     column(ShipToAddr5; ShipToAddr[5])
//                     {
//                     }
//                     column(Comment_SalesCommentLine; txtComment)
//                     {
//                     }
//                     column(ShipToAddr6; ShipToAddr[6])
//                     {
//                     }
//                     column(ShipToAddr7; ShipToAddr[7])
//                     {
//                     }
//                     column(ShipToAddr8; ShipToAddr[8])
//                     {
//                     }
//                     column(ShipToAddressCaption; ShipToAddressCaptionLbl)
//                     {
//                     }
//                     column(SellToCustNo_SalesInvHdrCaption; "Sales Invoice Header".FieldCaption("Sell-to Customer No."))
//                     {
//                     }
//                     column(PoNo; "Sales Invoice Header"."External Document No.")
//                     {
//                     }
//                     column(CompanyPanNo; CompanyInfo."P.A.N. No.")
//                     {
//                     }
//                     column(LRNo; "Sales Invoice Header"."LR/RR No.")
//                     {
//                     }
//                     column(LRdate; Format("Sales Invoice Header"."LR/RR Date", 0, '<Day,2>-<Month,2>-<Year4>'))
//                     {
//                     }
//                     column(VHNo; "Sales Invoice Header"."Vehicle No.")
//                     {
//                     }
//                     // LFS:SC:06-08-2024++
//                     // column(TransporterName; ShippingAgent.Name)
//                     // {
//                     // }
//                     column(TransporterName; TransporterName)
//                     {
//                     }
//                     // LFS:SC:06-08-2024++
//                     //LFS:SC:06-08-2024:++
//                     column(ShippingMarks; ShippingMarks) { }
//                     column(TimeofRemoval; "Sales Invoice Header"."Time of Removal")
//                     {
//                     }
//                     column(ExternalNo; "Sales Invoice Header"."External Document No.")
//                     {
//                     }
//                     column(OrderDate; Format("Sales Invoice Header"."Order Date", 0, '<Day,2>-<Month,2>-<Year>'))
//                     {
//                     }
//                     column(ShipGSTIN; GSTN_Ship)
//                     {
//                     }
//                     column(StateCode_Sell; "Sales Invoice Header"."GST Bill-to State Code")
//                     {
//                     }
//                     column(GSTIN_Sell; "Sales Invoice Header"."Customer GST Reg. No.")
//                     {
//                     }
//                     column(CINNo_Company; CompanyInfo."CIN No.")
//                     {
//                     }
//                     column(BankName_comp; CompanyInfo."Bank Name")
//                     {
//                     }
//                     column(Acc_Comp; CompanyInfo."Bank Account No.")
//                     {
//                     }
//                     column(Swift_Comp; CompanyInfo."SWIFT Code")
//                     {
//                     }
//                     column(DebitRoundAcc; CustomerPostingGroup."Debit Rounding Account")
//                     {
//                     }
//                     column(CReditRoundAcc; CustomerPostingGroup."Credit Rounding Account")
//                     {
//                     }
//                     column(StateCode_Ship; StateCode_Ship)
//                     {
//                     }

//                     column(CurrFact; CurrFact)
//                     {
//                     }
//                     dataitem("Sales Invoice Line"; "Sales Invoice Line")
//                     {
//                         DataItemLink = "Document No." = field("No.");
//                         DataItemLinkReference = "Sales Invoice Header";
//                         DataItemTableView = sorting("Document No.", "Line No.") where(Type = filter(<> " "));
//                         // column(ReportForNavId_1570; 1570)
//                         // {
//                         // }
//                         column(LineAmount_SalesInvLine; LineAmount_SalesInvLine)
//                         {
//                             AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
//                             AutoFormatType = 1;
//                         }
//                         column(Desc_SalesInvLine; Description)
//                         {
//                         }
//                         column(No_SalesInvLine; "No.")
//                         {
//                         }
//                         column(Qty_SalesInvLine; Quantity)
//                         {
//                         }
//                         column(UOM_SalesInvoiceLine; "Sales Invoice Line"."Unit of Measure Code")
//                         {
//                         }
//                         column(UnitPrice_SalesInvLine; UnitPrice_SalesInvLine)
//                         {
//                             AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
//                             AutoFormatType = 2;
//                         }
//                         column(LineDiscount_SalesInvLine; "Line Discount %")
//                         {
//                         }
//                         column(LineDiscount_SalesInvLineAmount; "Line Discount Amount")
//                         {
//                         }
//                         column(PostedShipmentDate; Format(PostedShipmentDate))
//                         {
//                         }
//                         column(SalesLineType; Format("Sales Invoice Line".Type))
//                         {
//                         }
//                         //LFS commented++
//                         // column(DirectDebitPLARG_SalesInvLine; "Direct Debit To PLA / RG")
//                         // {
//                         // }
//                         // column(SourceDocNo_SalesInvLine; "Source Document No.")
//                         // {
//                         // }
//                         // column(Supplementary; Supplementary)
//                         // {
//                         // }
//                         //LFS commented--
//                         column(InvDiscountAmount; -"Inv. Discount Amount")
//                         {
//                             AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
//                             AutoFormatType = 1;
//                         }
//                         column(TotalSubTotal; Format(TotalSubTotal, 0, '<Precision,2><Integer Thousand><Decimals,3>'))
//                         {
//                             AutoFormatExpression = "Sales Invoice Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(TotalInvoiceDiscAmount; TotalInvoiceDiscountAmount)
//                         {
//                             AutoFormatExpression = "Sales Invoice Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(TotalText; TotalText)
//                         {
//                         }
//                         column(SalesInvoiceLineAmount; Amount)
//                         {
//                             AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
//                             AutoFormatType = 1;
//                         }
//                         column(TotalAmount; Format(TotalAmount, 0, '<Precision,2><Integer Thousand><Decimals,3>'))
//                         {
//                             AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
//                             AutoFormatType = 1;
//                         }
//                         column(OtherTaxesAmount; Format(FrightCharge, 0, '<Precision,2><Integer Thousand><Decimals,3>'))
//                         {
//                             AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
//                             AutoFormatType = 1;
//                         }
//                         //LFS commented++
//                         // column(AmtInclVAT_SalesInvLine; "Amount To Customer")
//                         // {
//                         //     AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
//                         //     AutoFormatType = 1;
//                         // }
//                         //LFS commented--
//                         column(TotalInclVATText; TotalInclVATText)
//                         {
//                         }
//                         column(CGSTPer; CGSTPer)
//                         {
//                         }
//                         column(SGSTPer; SGSTPer)
//                         {
//                         }
//                         column(IGSTPer; IGSTPer)
//                         {
//                         }
//                         column(CGSTAmt; CGSTAmt)
//                         {
//                         }
//                         column(SGSTAmt; SGSTAmt)
//                         {
//                         }
//                         column(IGSTAmt; IGSTAmt)
//                         {
//                         }
//                         column(TotalCGST; TotalCGST)
//                         {
//                         }
//                         column(TotalSGST; TotalSGST)
//                         {
//                         }
//                         column(TotalIGST; TotalIGST)
//                         {
//                         }
//                         column(TotalAmountInclVAT; Format(TotalAmountInclVAT, 0, '<Precision,2><Integer Thousand><Decimals,3>'))
//                         {
//                             AutoFormatExpression = "Sales Invoice Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(TotalAmountInclVAT1; TotalAmountInclVAT1)
//                         {
//                         }
//                         column(TotalAmountVAT1; TotalAmountVAT1) { }
//                         // column(TaxAmount_SalesInvLine; "Tax Amount")
//                         // {
//                         //     AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;  //LFS commented
//                         //     AutoFormatType = 1;
//                         // }
//                         column(ServiceTaxAmt; ServiceTaxAmt)
//                         {
//                             AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
//                             AutoFormatType = 1;
//                         }
//                         column(ChargesAmount; Format(ChargesAmount, 0, '<Precision,2><Integer Thousand><Decimals,3>'))
//                         {
//                             AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
//                             AutoFormatType = 1;
//                         }
//                         column(SubTotalAmt; Format(TotalAmount + ChargesAmount + OtherTaxesAmount + FrightCharge, 0, '<Precision,2><Integer Thousand><Decimals,3>'))
//                         {
//                         }
//                         column(OtherTaxesAmount_; OtherTaxesAmount)
//                         {
//                         }
//                         column(ServiceTaxECessAmt; ServiceTaxECessAmt)
//                         {
//                             AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
//                             AutoFormatType = 1;
//                         }
//                         column(SalesInvLineTotalTDSTCSInclSHECESS; Format(TotalTCSAmount, 0, '<Precision,2><Integer Thousand><Decimals,3>'))
//                         {
//                         }
//                         column(AppliedServiceTaxAmt; AppliedServiceTaxAmt)
//                         {
//                             AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
//                             AutoFormatType = 1;
//                         }
//                         column(AppliedServiceTaxECessAmt; AppliedServiceTaxECessAmt)
//                         {
//                             AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
//                             AutoFormatType = 1;
//                         }
//                         column(ServiceTaxSHECessAmt; ServiceTaxSHECessAmt)
//                         {
//                             AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
//                             AutoFormatType = 1;
//                         }
//                         column(AppliedServTaxSHECessAmt; AppliedServiceTaxSHECessAmt)
//                         {
//                             AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
//                             AutoFormatType = 1;
//                         }
//                         column(TotalTaxAmt; TotalTaxAmt)
//                         {
//                         }
//                         column(TotalExciseAmt; TotalExciseAmt)
//                         {
//                         }
//                         column(VATBaseDisc_SalesInvHdr; "Sales Invoice Header"."VAT Base Discount %")
//                         {
//                             AutoFormatType = 1;
//                         }
//                         column(TotalPaymentDiscountOnVAT; TotalPaymentDiscountOnVAT)
//                         {
//                             AutoFormatType = 1;
//                         }
//                         column(VATAmtLineVATAmtText; VATAmountLine.VATAmountText())
//                         {
//                         }
//                         column(TotalExclVATText; TotalExclVATText)
//                         {
//                         }
//                         column(TotalAmountVAT; TotalAmountVAT)
//                         {
//                         }
//                         column(LineNo_SalesInvLine; "Line No.")
//                         {
//                         }
//                         column(UnitPriceCaption; UnitPriceCaptionLbl)
//                         {
//                         }
//                         column(DiscountCaption; DiscountCaptionLbl)
//                         {
//                         }
//                         column(AmountCaption; AmountCaptionLbl)
//                         {
//                         }
//                         column(LineDiscountCaption; LineDiscountCaptionLbl)
//                         {
//                         }
//                         column(PostedShipmentDateCaption; PostedShipmentDateCaptionLbl)
//                         {
//                         }
//                         column(SubtotalCaption; SubtotalCaptionLbl)
//                         {
//                         }
//                         column(ExciseAmountCaption; ExciseAmountCaptionLbl)
//                         {
//                         }
//                         column(TaxAmountCaption; TaxAmountCaptionLbl)
//                         {
//                         }
//                         column(ServiceTaxAmountCaption; ServiceTaxAmountCaptionLbl)
//                         {
//                         }
//                         column(ChargesAmountCaption; ChargesAmountCaptionLbl)
//                         {
//                         }
//                         column(OtherTaxesAmountCaption; OtherTaxesAmountCaptionLbl)
//                         {
//                         }
//                         column(ServTaxeCessAmtCaption; ServTaxeCessAmtCaptionLbl)
//                         {
//                         }
//                         column(TCSAmountCaption; TCSAmountCaptionLbl)
//                         {
//                         }
//                         column(SvcTaxAmtAppliedCaption; SvcTaxAmtAppliedCaptionLbl)
//                         {
//                         }
//                         column(SvcTaxeCessAmtAppliedCaption; SvcTaxeCessAmtAppliedCaptionLbl)
//                         {
//                         }
//                         column(ServTaxSHECessAmtCaption; ServTaxSHECessAmtCaptionLbl)
//                         {
//                         }
//                         column(SvcTaxSHECessAmtAppliedCaption; SvcTaxSHECessAmtAppliedCaptionLbl)
//                         {
//                         }
//                         column(PaymentDiscVATCaption; PaymentDiscVATCaptionLbl)
//                         {
//                         }
//                         column(Description_SalesInvLineCaption; FieldCaption(Description))
//                         {
//                         }
//                         column(No_SalesInvoiceLineCaption; FieldCaption("No."))
//                         {
//                         }
//                         column(Quantity_SalesInvoiceLineCaption; FieldCaption(Quantity))
//                         {
//                         }
//                         column(UOM_SalesInvoiceLineCaption; FieldCaption("Unit of Measure"))
//                         {
//                         }
//                         // column(DirectDebitPLARG_SalesInvLineCaption; FieldCaption("Direct Debit To PLA / RG")) //LFS commented
//                         // {
//                         // }
//                         column(ServiceTaxSBCAmt; ServiceTaxSBCAmt)
//                         {
//                         }
//                         column(AppliedServiceTaxSBCAmt; AppliedServiceTaxSBCAmt)
//                         {
//                         }
//                         column(ServTaxSBCAmtCaption; ServTaxSBCAmtCaptionLbl)
//                         {
//                         }
//                         column(SvcTaxSBCAmtAppliedCaption; SvcTaxSBCAmtAppliedCaptionLbl)
//                         {
//                         }
//                         column(KKCessAmt; KKCessAmt)
//                         {
//                         }
//                         column(AppliedKKCessAmt; AppliedKKCessAmt)
//                         {
//                         }
//                         column(KKCessAmtCaption; KKCessAmtCaptionLbl)
//                         {
//                         }
//                         column(KKCessAmtAppliedCaption; KKCessAmtAppliedCaptionLbl)
//                         {
//                         }
//                         // column(NumInWords1; NumInWords[1])
//                         // {
//                         // }
//                         column(NumInWords1; NumInWords[1])
//                         {
//                         }
//                         column(NumInWords2; NumInWords[2])
//                         {
//                         }
//                         // column(NumInWords2; NumInWords[2])
//                         // {
//                         // }
//                         column(HSNSACCode_SalesInvoiceLine; "Sales Invoice Line"."HSN/SAC Code")
//                         {
//                         }
//                         column(UnitPrice_SalesInvoiceLine; "Sales Invoice Line"."Unit Price")
//                         {
//                         }
//                         column(SRNo; SRNo)
//                         {
//                         }
//                         column(GST_Per; "GST%")
//                         {
//                         }
//                         column(GST_PerIGST; GST_PerIGST)
//                         {
//                         }
//                         column(CGST_1; CGST_InWords[1])
//                         {
//                         }
//                         column(CGST_2; CGST_InWords[2])
//                         {
//                         }
//                         column(SGST_1; SGST_InWords[1])
//                         {
//                         }
//                         column(SGST_2; SGST_InWords[2])
//                         {
//                         }
//                         column(IGST_1; IGST_InWords[1])
//                         {
//                         }
//                         column(IGST_2; IGST_InWords[2])
//                         {
//                         }
//                         column(VariantCode_SalesInvoiceLine; "Sales Invoice Line".Pack)
//                         {
//                         }
//                         column(Type_SalesInvoiceLine; "Sales Invoice Line".Type)
//                         {
//                         }
//                         column(FrightCharge; FrightCharge)
//                         {
//                         }
//                         column(Packing_SalesInvoiceLine; "Sales Invoice Line".Packing)
//                         {
//                         }
//                         column(LotInfoExist; LotInfoExist)
//                         {
//                         }
//                         column(IsItem; IsItem)
//                         {
//                         }
//                         column(TotalLineAmt; TotalLineAmt) { }

//                         dataitem(ILE; "Integer")
//                         {
//                             DataItemTableView = sorting(Number) where(Number = filter(1 ..));
//                             // column(ReportForNavId_1000000142; 1000000142)
//                             // {
//                             // }
//                             column(LotNo; TempItemLedgEntry."Lot No.")
//                             {
//                             }
//                             column(LotQty; Abs(TempItemLedgEntry.Quantity))
//                             {
//                             }
//                             column(Mfg_Date; TempItemLedgEntry."Manufacturing Date")
//                             {
//                             }
//                             column(ExpDate; TempItemLedgEntry."Expiration Date")
//                             {
//                             }
//                             column(ChkBatch; ChkBatch)
//                             {
//                             }
//                             column(DateFormate; DateFormate)
//                             {
//                             }
//                             column(DateFormate2; DateFormate2)
//                             {
//                             }
//                             column(LineNo_SalesCommentLine; '"Sales Comment Line"."Line No."')
//                             {
//                             }
//                             column(txtComment1; txtComment1)
//                             {
//                             }
//                             trigger OnAfterGetRecord()
//                             begin

//                                 if Number = 1 then begin
//                                     if not TempItemLedgEntry.Find('-') then
//                                         CurrReport.Break;
//                                 end else
//                                     if TempItemLedgEntry.Next() = 0 then
//                                         CurrReport.Break;

//                                 if TempItemLedgEntry."Lot No." = '' then
//                                     CurrReport.Skip;

//                                 ChkBatch += 1;

//                                 //LFS-NK +++ Date Formate
//                                 // IF FullDate = TRUE THEN BEGIN
//                                 //  DateFormate := FORMAT(TempItemLedgEntry."Manufacturing Date", 11,'<Day,2>-<Month,2>-<Year>');
//                                 //  DateFormate2 := FORMAT(TempItemLedgEntry."Expiration Date", 11,'<Day,2>-<Month,2>-<Year>');
//                                 // END ELSE
//                                 // BEGIN
//                                 //  DateFormate := FORMAT(TempItemLedgEntry."Manufacturing Date",10,'<Month Text,3> <Year4>');
//                                 //  DateFormate2 := FORMAT(TempItemLedgEntry."Expiration Date", 10,'<Month Text,3> <Year4>');
//                                 //  END;
//                                 //LFS-NK-----
//                             end;

//                             trigger OnPreDataItem()
//                             begin
//                                 ChkBatch := 0;
//                             end;
//                         }

//                         trigger OnAfterGetRecord()
//                         var
//                             //  StructureLineDetails: Record "Posted Str Order Line Details"; //LFS commented
//                             GSTEval: Decimal;
//                             GSTEval2: Decimal;
//                             GSTEval3: Decimal;

//                             SalesCommentLine: Record "Sales Comment Line";
//                             TypeHelper: Codeunit "Type Helper";
//                             Crlf: Text[2];
//                             Item: Record Item;
//                         begin
//                             SRNo += 1;
//                             OtherTaxesAmount := 0;
//                             ChargesAmount := 0;

//                             if Item.Get("Sales Invoice Line"."No.") then
//                                 DrugLicNo := Item."Manufacturing License";

//                             Unit_Price := "Line Amount" / Quantity;
//                             IF "Sales Invoice Header"."Currency Factor" <> 0 THEN BEGIN
//                                 "Sales Invoice Line"."Line Amount" := ROUND("Sales Invoice Line"."Line Amount" * (1 / "Sales Invoice Header"."Currency Factor"), 0.01, '=');
//                                 // "Sales Line"."Unit Price" := ROUND("Sales Line"."Unit Price" * (1 / "Sales Header"."Currency Factor"), 0.01, '=');
//                                 "Sales Invoice Line"."Unit Price" := "Sales Invoice Line"."Line Amount" / "Sales Invoice Line".Quantity;
//                                 "Sales Invoice Line".Amount := ROUND("Sales Invoice Line".Amount * (1 / "Sales Invoice Header"."Currency Factor"), 0.01, '='); // TEC_08Apr2020
//                                 "Sales Invoice Line"."Amount Including VAT" := ROUND("Sales Invoice Line"."Amount Including VAT" * (1 / "Sales Invoice Header"."Currency Factor"), 0.01, '=');

//                                 //  "Sales Line"."Amount To Customer" := ROUND("Sales Line"."Amount To Customer" * (1 / "Sales Header"."Currency Factor"), 0.01, '=');
//                             END;

//                             Crlf := TypeHelper.CRLFSeparator();
//                             SalesCommentLine.SetCurrentKey("No.", "Line No.", "Document Line No.", "Document Type");
//                             SalesCommentLine.SetRange("No.", "Sales Invoice Line"."No.");
//                             SalesCommentLine.SetRange("Document Type", SalesCommentLine."Document Type"::"Posted Invoice");
//                             SalesCommentLine.SetRange("Document Line No.", 0);
//                             if SalesCommentLine.FindSet() then
//                                 if txtComment1 <> '' then
//                                     txtComment1 := Crlf + SalesCommentLine.Comment
//                                 else
//                                     txtComment1 := SalesCommentLine.Comment;


//                             // SalesInvoiceLine_Grec.Reset();
//                             // SalesInvoiceLine_Grec.SetRange("Document No.", "Sales Invoice Line"."Document No.");
//                             // // SalesInvoiceLine_Grec.SetRange("Document Type", "Sales Invoice Line"."Document Type");
//                             // SalesInvoiceLine_Grec.SetRange("No.", "Sales Invoice Line"."No.");
//                             // SalesInvoiceLine_Grec.SetRange("Line No.", "Sales Invoice Line"."Line No.");
//                             // SalesInvoiceLine_Grec.SetFilter(Type, '%1', SalesInvoiceLine_Grec.Type::"Charge (Item)");
//                             // if SalesInvoiceLine_Grec.FindSet() then begin
//                             //     repeat
//                             //         ItemCharge.Reset();
//                             //         ItemCharge.SetRange("No.", SalesInvoiceLine_Grec."No.");
//                             //         ItemCharge.SetRange(Charges, true);
//                             //         if ItemCharge.FindFirst() then begin
//                             //             ChargesAmount += SalesInvoiceLine_Grec."Line Amount";
//                             //         end;
//                             //         OtherTaxesAmount += SalesInvoiceLine_Grec."Line Amount";
//                             //     until SalesInvoiceLine_Grec.Next() = 0;
//                             // end;

//                             //  lfs-sc
//                             UnitPrice_SalesInvLine := "Sales Invoice Line"."Unit Price";// / "Sales Invoice Header"."Currency Factor"; //LFS-NK
//                             LineAmount_SalesInvLine := "Sales Invoice Line"."Line Amount";// / "Sales Invoice Header"."Currency Factor"; //LFS-NK


//                             TotalLineAmt += "Sales Invoice Line"."Line Amount";
//                             PostedShipmentDate := 0D;
//                             if Quantity <> 0 then
//                                 PostedShipmentDate := FindPostedShipmentDate;

//                             VATAmountLine.Init;
//                             VATAmountLine."VAT Identifier" := "VAT Identifier";
//                             VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
//                             VATAmountLine."Tax Group Code" := "Tax Group Code";
//                             VATAmountLine."VAT %" := "VAT %";
//                             VATAmountLine."VAT Base" := Amount;
//                             VATAmountLine."Amount Including VAT" := "Amount Including VAT";
//                             VATAmountLine."Line Amount" := "Line Amount";
//                             if "Allow Invoice Disc." then
//                                 VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
//                             VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
//                             VATAmountLine.InsertLine;

//                             // TotalTCSAmount += "Total TDS/TCS Incl. SHE CESS"; //LFS commented

//                             TotalSubTotal += "Line Amount";// / "Sales Invoice Header"."Currency Factor"; //LFS-NK
//                             TotalInvoiceDiscountAmount -= "Inv. Discount Amount";
//                             if ("Sales Invoice Line"."No." <> '7815094') and ("Sales Invoice Line"."No." <> '5200109') then begin
//                                 TotalAmount += Amount;// / "Sales Invoice Header"."Currency Factor"; //LFS-NK
//                                 //TotalAmountInclVAT += "Amount To Customer";// / "Sales Invoice Header"."Currency Factor"; //LFS-NK //LFS commented
//                             end;
//                             //MESSAGE('%1..%2',TotalAmount,TotalAmountInclVAT);
//                             /*
//                             IF ("Sales Invoice Line"."No." = '7815094') OR ("Sales Invoice Line"."No." = '5200109') THEN BEGIN
//                               RoundoffAmt += "Sales Invoice Line".Amount;
//                             END;
//                              */
//                             //  lfs-sc
//                             TotalAmountVAT += "Amount Including VAT" - Amount;
//                             //TotalAmountInclVAT += "Amount Including VAT";
//                             TotalPaymentDiscountOnVAT += (-("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT") / "Sales Invoice Header"."Currency Factor");
//                             TcsEntry.Reset();
//                             TcsEntry.SetRange("Document No.", "Document No.");
//                             if TcsEntry.FindSet() then
//                                 repeat
//                                     TotalTCSAmount += (TcsEntry."TCS Amount" / "Sales Invoice Header"."Currency Factor");
//                                 until TcsEntry.Next() = 0;

//                             CGSTPer := 0;
//                             CGSTAmt := 0;
//                             SGSTPer := 0;
//                             SGSTAmt := 0;
//                             IGSTPer := 0;
//                             IGSTAmt := 0;
//                             TotalCGST := 0;
//                             TotalIGST := 0;
//                             TotalSGST := 0;
//                             TotalAmountInclVAT := 0;
//                             // Grand_Total := 0;
//                             DetailedGSTLedgerEntry.Reset();
//                             DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
//                             DetailedGSTLedgerEntry.SETFILTER("Entry Type", '%1', DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
//                             IF DetailedGSTLedgerEntry.FindFirst() THEN
//                                 REPEAT
//                                     if DetailedGSTLedgerEntry."GST Component Code" = 'CGST' then BEGIN
//                                         CGSTPer := DetailedGSTLedgerEntry."GST %";
//                                         CGSTAmt += (DetailedGSTLedgerEntry."GST Amount" * -1)
//                                         // / "Sales Invoice Header"."Currency Factor";
//                                         // TotalCGST := (CGSTAmt / "Sales Invoice Header"."Currency Factor");
//                                     END;
//                                     if DetailedGSTLedgerEntry."GST Component Code" = 'SGST' then BEGIN
//                                         SGSTPer := DetailedGSTLedgerEntry."GST %";
//                                         SGSTAmt += (DetailedGSTLedgerEntry."GST Amount" * -1)
//                                         // / "Sales Invoice Header"."Currency Factor";
//                                         // TotalSGST := (SGSTAmt / "Sales Invoice Header"."Currency Factor");
//                                     END;
//                                     if DetailedGSTLedgerEntry."GST Component Code" = 'IGST' then BEGIN
//                                         IGSTPer := DetailedGSTLedgerEntry."GST %";
//                                         IGSTAmt += (DetailedGSTLedgerEntry."GST Amount" * -1)
//                                         // / "Sales Invoice Header"."Currency Factor";
//                                         // TotalIGST := (IGSTAmt / "Sales Invoice Header"."Currency Factor");
//                                     END;
//                                 UNTIL DetailedGSTLedgerEntry.Next() = 0;
//                             // AmountIncVAT += "Sales Invoice Line"."Amount Including VAT"/ "Sales Invoice Header"."Currency Factor";
//                             AmountIncVATINR := TotalSubTotal / "Sales Invoice Header"."Currency Factor";
//                             TotalAmountInclVAT := (AmountIncVATINR + CGSTAmt + SGSTAmt + IGSTAmt + TotalTCSAmount);
//                             //LFS commented++
//                             //vk
//                             // if IsGSTApplicable and (Type <> Type::" ") then begin
//                             //     J := 1;
//                             //     GSTComponent.Reset();
//                             //     GSTComponent.SetRange("GST Jurisdiction Type", "GST Jurisdiction Type");
//                             //     if GSTComponent.FindSet() then
//                             //         repeat
//                             //             if GSTComponent.Code = 'CGST' then
//                             //                 J := 1
//                             //             else
//                             //                 if GSTComponent.Code = 'SGST' then
//                             //                     J := 2
//                             //                 else
//                             //                     if GSTComponent.Code = 'IGST' then
//                             //                         J := 3
//                             //                     else
//                             //                         if GSTComponent.Code = 'CESS' then
//                             //                             J := 4;
//                             //             GSTComponentCode[J] := GSTComponent.Code;
//                             //             DetailedGSTLedgerEntry.Reset();
//                             //             DetailedGSTLedgerEntry.SetCurrentkey("Transaction Type", "Document Type", "Document No.", "Document Line No.");
//                             //             DetailedGSTLedgerEntry.SetRange("Transaction Type", DetailedGSTLedgerEntry."transaction type"::Sales);
//                             //             DetailedGSTLedgerEntry.SetRange("Document No.", "Document No.");
//                             //             DetailedGSTLedgerEntry.SetRange("Document Line No.", "Line No.");
//                             //             DetailedGSTLedgerEntry.SetRange("GST Component Code", GSTComponentCode[J]);
//                             //             if DetailedGSTLedgerEntry.FindSet() then begin
//                             //                 repeat
//                             //                     if GSTComponent.Code <> 'IGST' then
//                             //                         "GST%" := DetailedGSTLedgerEntry."GST %"
//                             //                     else
//                             //                         GST_PerIGST := DetailedGSTLedgerEntry."GST %";
//                             //                     GSTCompAmount[J] +=
//                             //                       CurrExchRate.ExchangeAmtLCYToFCY(
//                             //                         DetailedGSTLedgerEntry."Posting Date", DetailedGSTLedgerEntry."Currency Code",
//                             //                         DetailedGSTLedgerEntry."GST Amount", DetailedGSTLedgerEntry."Currency Factor");

//                             //                     TotalGSTAmt := Abs(GSTCompAmount[3]);
//                             //                 until DetailedGSTLedgerEntry.Next() = 0;
//                             //                 //J += 1;
//                             //             end;
//                             //         until GSTComponent.Next() = 0;
//                             // end;

//                             // StructureLineDetails.Reset();
//                             // StructureLineDetails.SetRange(Type, StructureLineDetails.Type::Sale);
//                             // StructureLineDetails.SetRange("Document Type", StructureLineDetails."document type"::Invoice);
//                             // StructureLineDetails.SetRange("Invoice No.", "Document No.");
//                             // StructureLineDetails.SetRange("Item No.", "No.");
//                             // StructureLineDetails.SetRange("Line No.", "Line No.");
//                             // if StructureLineDetails.Find('-') then
//                             //     repeat
//                             //         if not StructureLineDetails."Payable to Third Party" then begin
//                             //             if (StructureLineDetails."Tax/Charge Type" = StructureLineDetails."tax/charge type"::Charges) and (StructureLineDetails."Tax/Charge Group" = 'OTHER') then
//                             //                 ChargesAmount := ChargesAmount + Abs(StructureLineDetails.Amount);
//                             //             if StructureLineDetails."Tax/Charge Type" = StructureLineDetails."tax/charge type"::"Other Taxes" then
//                             //                 OtherTaxesAmount := OtherTaxesAmount + Abs(StructureLineDetails.Amount);
//                             //             if StructureLineDetails."Tax/Charge Group" = 'FREIGHT' then
//                             //                 FrightCharge += Abs(StructureLineDetails.Amount);
//                             //         end;
//                             //     until StructureLineDetails.Next() = 0;
//                             // if "Sales Invoice Header"."Transaction No. Serv. Tax" <> 0 then begin
//                             //     ServiceTaxEntry.Reset();
//                             //     ServiceTaxEntry.SetRange(Type, ServiceTaxEntry.Type::Sale);
//                             //     ServiceTaxEntry.SetRange("Document Type", ServiceTaxEntry."document type"::Invoice);
//                             //     ServiceTaxEntry.SetRange("Document No.", "Document No.");
//                             //     if ServiceTaxEntry.FindFirst() then begin

//                             //         ServiceTaxAmt := Abs(ServiceTaxEntry."Service Tax Amount");
//                             //         ServiceTaxECessAmt := Abs(ServiceTaxEntry."eCess Amount");
//                             //         ServiceTaxSHECessAmt := Abs(ServiceTaxEntry."SHE Cess Amount");
//                             //         ServiceTaxSBCAmt := Abs(ServiceTaxEntry."Service Tax SBC Amount");
//                             //         KKCessAmt := Abs(ServiceTaxEntry."KK Cess Amount");
//                             //         AppliedServiceTaxAmt := ServiceTaxAmount - Abs(ServiceTaxEntry."Service Tax Amount");
//                             //         AppliedServiceTaxECessAmt := ServiceTaxeCessAmount - Abs(ServiceTaxEntry."eCess Amount");
//                             //         AppliedServiceTaxSHECessAmt := ServiceTaxSHECessAmount - Abs(ServiceTaxEntry."SHE Cess Amount");
//                             //         AppliedServiceTaxSBCAmt := ServiceTaxSBCAmount - Abs(ServiceTaxEntry."Service Tax SBC Amount");
//                             //         AppliedKKCessAmt := KKCessAmount - Abs(ServiceTaxEntry."KK Cess Amount");
//                             //     end else begin
//                             //         AppliedServiceTaxAmt := ServiceTaxAmount;
//                             //         AppliedServiceTaxECessAmt := ServiceTaxeCessAmount;
//                             //         AppliedServiceTaxSHECessAmt := ServiceTaxSHECessAmount;
//                             //         AppliedServiceTaxSBCAmt := ServiceTaxSBCAmount;
//                             //         AppliedKKCessAmt := KKCessAmount;
//                             //     end;
//                             // end else begin
//                             //     ServiceTaxAmt := ServiceTaxAmount;
//                             //     ServiceTaxECessAmt := ServiceTaxeCessAmount;
//                             //     ServiceTaxSHECessAmt := ServiceTaxSHECessAmount;
//                             //     ServiceTaxSBCAmt := ServiceTaxSBCAmount;
//                             //     KKCessAmt := KKCessAmount
//                             // end;
//                             //LFS commented--
//                             TempItemLedgEntry.DeleteAll;
//                             if "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item then begin



//                                 ValueEntry.Reset();
//                                 ValueEntry.SetCurrentkey("Document No.");
//                                 ValueEntry.SetRange("Document No.", "Sales Invoice Line"."Document No.");
//                                 ValueEntry.SetRange("Document Type", ValueEntry."document type"::"Sales Invoice");
//                                 ValueEntry.SetRange("Document Line No.", "Sales Invoice Line"."Line No.");
//                                 if ValueEntry.FindSet() then
//                                     repeat
//                                         ItemLedgEntry.Get(ValueEntry."Item Ledger Entry No.");
//                                         TempItemLedgEntry := ItemLedgEntry;
//                                         if TempItemLedgEntry.Insert then;
//                                     until ValueEntry.Next() = 0;
//                             end;
//                             LotInfoExist := false;
//                             IsItem := false;
//                             if "Sales Invoice Line"."No." = 'MLDPB0001' then //LFS-NK +++++
//                                 LotInfoExist := false
//                             else //LFS-NK ---
//                                 if (TempItemLedgEntry.FindSet) or ("Sales Invoice Line".Type = "Sales Invoice Line".Type::Item) then begin
//                                     LotInfoExist := true;
//                                     IsItem := true;
//                                 end;
//                             // IF GSTComponentCode[1] <> '' THEN
//                             //  GSTEval := GSTCompAmount[1];
//                             // IF GSTComponentCode[2] <> '' THEN
//                             //  GSTEval2 := GSTCompAmount[2];
//                             // IF GSTComponentCode[4] <> '' THEN
//                             //  GSTEval3 := GSTCompAmount[4];
//                             //
//                             TotalAmountInclVAT1 := (TotalAmountInclVAT + TotalGSTAmt) / CurrFact;
//                             TotalAmountVAT1 := TotalSubTotal + SGSTAmt + CGSTAmt + IGSTAmt + TotalTCSAmount;
//                             Clear(NumInWords);
//                             // Check.InitTextVariable();
//                             //Check.FormatNoText(NumInWords,ROUND(ABS(TotalAmountInclVAT)),"Sales Invoice Header"."Currency Code"); //LFS-NK
//                             // Check.FormatNoText(NumInWords, ROUND(Abs((TotalAmountInclVAT + TotalGSTAmt) / CurrFact)), "Sales Invoice Header"."Currency Code");
//                             // Check.FormatNoText(NumInWords, TotalAmountInclVAT, "Sales Invoice Header"."Currency Code");
//                             InitTextVariable();
//                             // FormatNoText(Notext, Abs(TotalAmountVAT1), '');
//                             FormatNoText(NumInWords, Abs(round(TotalAmountVAT1, 0.01)), "Sales Invoice Header"."Currency Code");
//                             RemittanceAmntInWords := Notext[1] + Notext[2];
//                             /*
//                             CLEAR(CGST_InWords);
//                             Check.InitTextVariable();
//                             Check.FormatNoText(CGST_InWords,ABS(GSTCompAmount[1]),"Sales Invoice Header"."Currency Code");

//                             CLEAR(IGST_InWords);
//                             Check.InitTextVariable();
//                             Check.FormatNoText(IGST_InWords,ABS(GSTCompAmount[3]),"Sales Invoice Header"."
//                              Code");

//                             CLEAR(SGST_InWords);
//                             Check.InitTextVariable();
//                             Check.FormatNoText(SGST_InWords,ABS(GSTCompAmount[2]),"Sales Invoice Header"."Currency Code");
//                             */
//                             // lfs-sc

//                         end;

//                         trigger OnPostDataItem()
//                         begin
//                             //MESSAGE('%1 Round',RoundoffAmt);
//                         end;

//                         trigger OnPreDataItem()
//                         var
//                             SalesCommentLine: Record "Sales Comment Line";
//                         begin

//                             UnitPrice_SalesInvLine := 0;  //LFS-NK
//                             LineAmount_SalesInvLine := 0; //LFS-NK
//                             TotalAmountInclVAT1 := 0; //LFS-NK
//                                                       // TotalAmountVAT1 := 0;

//                             VATAmountLine.DeleteAll;
//                             SalesShipmentBuffer.Reset();
//                             SalesShipmentBuffer.DeleteAll;
//                             FirstValueEntryNo := 0;
//                             MoreLines := Find('+');
//                             while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do
//                                 MoreLines := Next(-1) <> 0;
//                             if not MoreLines then
//                                 CurrReport.Break;
//                             SetRange("Line No.", 0, "Line No.");
//                             //LFS commented++
//                             // CurrReport.CreateTotals("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount", "Excise Amount", "Tax Amount",
//                             //   "Service Tax Amount", "Service Tax eCess Amount", "Amount To Customer", "Service Tax SBC Amount");
//                             // CurrReport.CreateTotals("KK Cess Amount");
//                             // CurrReport.CreateTotals("Service Tax SHE Cess Amount");
//                             //LFS commented--
//                             SRNo := 0;
//                         end;
//                     }
//                 }

//                 trigger OnAfterGetRecord()
//                 begin
//                     if Number > 1 then begin
//                         CopyText := Text003;
//                         OutputNo += 1;
//                     end;
//                     CurrReport.PageNo := 1;


//                     case Number of
//                         1:
//                             CopyText := 'Original for Buyer';
//                         2:
//                             CopyText := 'Duplicate for Transporter';
//                         3:
//                             CopyText := 'Triplicate for Consignor';
//                         3 .. 100:
//                             CopyText := 'Extra Copy';
//                     end;

//                     TotalSubTotal := 0;
//                     TotalInvoiceDiscountAmount := 0;
//                     TotalAmount := 0;
//                     TotalAmountVAT := 0;
//                     TotalAmountInclVAT := 0;
//                     TotalPaymentDiscountOnVAT := 0;
//                     TotalExciseAmt := 0;
//                     TotalTaxAmt := 0;
//                     ServiceTaxAmount := 0;
//                     ServiceTaxeCessAmount := 0;
//                     ServiceTaxSHECessAmount := 0;
//                     ServiceTaxSBCAmount := 0;
//                     KKCessAmount := 0;
//                     Clear(GSTCompAmount);
//                     //RoundoffAmt := 0;

//                     OtherTaxesAmount := 0;
//                     ChargesAmount := 0;
//                     AppliedServiceTaxSHECessAmt := 0;
//                     AppliedServiceTaxECessAmt := 0;
//                     AppliedServiceTaxAmt := 0;
//                     AppliedServiceTaxSBCAmt := 0;
//                     AppliedKKCessAmt := 0;
//                     ServiceTaxSHECessAmt := 0;
//                     ServiceTaxECessAmt := 0;
//                     ServiceTaxAmt := 0;
//                     ServiceTaxSBCAmt := 0;
//                     KKCessAmt := 0;
//                     TotalTCSAmount := 0;
//                     FrightCharge := 0;
//                 end;

//                 trigger OnPostDataItem()
//                 begin
//                     if not CurrReport.Preview then
//                         SalesInvCountPrinted.Run("Sales Invoice Header");
//                 end;

//                 trigger OnPreDataItem()
//                 begin
//                     NoOfLoops := Abs(NoOfCopies) + Cust."Invoice Copies" + 2;
//                     if NoOfLoops <= 0 then
//                         NoOfLoops := 1;
//                     CopyText := '';
//                     SetRange(Number, 1, NoOfLoops);
//                     OutputNo := 1;
//                 end;
//             }

//             trigger OnAfterGetRecord()
//             var
//                 SalesInvLine: Record "Sales Invoice Line";
//                 Location: Record Location;
//             begin
//                 //LFS-NK
//                 if ("Sales Invoice Header"."Currency Code" <> '') and ("Sales Invoice Header"."Currency Factor" <> 0) then
//                     CurrFact := "Sales Invoice Header"."Currency Factor"
//                 else
//                     CurrFact := 1;

//                 if ("Sales Invoice Header"."Currency Factor" = 0) and ("Sales Invoice Header"."Currency Code" = '') then
//                     Error('This Report is for Export only');
//                 //LFS-NK

//                 ExportInfo.SetRange("Document No.", "Sales Invoice Header"."No.");
//                 if ExportInfo.FindFirst() then
//                     ShippingMarks := ExportInfo.GetShippingMarks();

//                 if "Sales Invoice Header"."Transport Method" <> '' then begin
//                     gRecTransporter.Reset();
//                     gRecTransporter.Get("Sales Invoice Header"."Transport Method");
//                     if gRecTransporter.FindFirst() then
//                         LUTNumber := gRecTransporter.Description;
//                 end else
//                     LUTNumber := '';
//                 CustPanNO := '';
//                 if Customer.Get("Sales Invoice Header"."Sell-to Customer No.") then
//                     if Customer."P.A.N. No." <> '' then
//                         CustPanNO := 'PAN No- ' + Customer."P.A.N. No.";
//                 if Customer."E-Mail" <> '' then
//                     CustPanNO := CustPanNO + '   Email ID- ' + Customer."E-Mail";
//                 contactPerson := Customer.Contact;
//                 contactNumber := Customer."Phone No.";

//                 SalesShipmentHeader.Reset();
//                 SalesShipmentHeader.SetRange(SalesShipmentHeader."External Document No.", "External Document No.");
//                 if SalesShipmentHeader.Find('-') then
//                     OrderDate := SalesShipmentHeader."Order Date";


//                 if GlobalLanguage = Language.GetLanguageID("Language Code") then
//                     CurrReport.Language := Language.GetLanguageID("Language Code")
//                 else
//                     CurrReport.Language := Language.GetLanguageID('ENU');
//                 // IsGSTApplicable := GSTManagement.IsGSTApplicable(Structure); LFS commented
//                 Customer.Get("Bill-to Customer No.");
//                 //  DLNoBuyer := Customer."DL No";
//                 // LFS:SC:06-08-2024++
//                 EwaybillHeader.Reset();
//                 EwaybillHeader.SetRange("Document No.", "No.");
//                 if EwaybillHeader.FindSet() then begin
//                     TransporterName := EwaybillHeader.Transporter;
//                     LRNo := EwaybillHeader."LR No.";
//                     LRdate := EwaybillHeader."LR Date";
//                     EwaybillLine.Reset();
//                     EwaybillLine.SetRange("Document No.", EwaybillHeader."No.");
//                     if EwaybillLine.FindFirst() then begin
//                         LRNo2 := EwaybillLine."New Lr No";
//                         LRDate2 := EwaybillHeader."LR Date";
//                     end;
//                 end else begin
//                     // "Sales Invoice Header".Calcfields("Trans Name");
//                     TransporterName := "Sales Invoice Header"."Trans Name";
//                     LRNo := "Sales Invoice Header"."LR/RR No.";
//                     LRdate := "Sales Invoice Header"."LR/RR Date";
//                     LRNo2 := "Sales Invoice Header"."LR No. 2";
//                     LRDate2 := "Sales Invoice Header"."LR Date 2";
//                 end;
//                 // LFS:SC:06-08-2024++
//                 //LFS:SC:06-08-2024:++
//                 EwaybillHeader.Reset();
//                 EwaybillHeader.SetRange("Document No.", "No.");
//                 if EwaybillHeader.FindSet() then begin
//                     TransporterName := EwaybillHeader.Transporter;
//                     LRNo := EwaybillHeader."LR No.";
//                     LRdate := EwaybillHeader."LR Date";
//                     EwaybillLine.Reset();
//                     EwaybillLine.SetRange("Document No.", EwaybillHeader."No.");
//                     if EwaybillLine.FindFirst() then begin
//                         LRNo2 := EwaybillLine."New Lr No";
//                         LRDate2 := EwaybillHeader."LR Date";
//                     end;
//                 end else begin
//                     // "Sales Invoice Header".Calcfields("Trans Name");
//                     TransporterName := "Sales Invoice Header"."Trans Name";
//                     LRNo := "Sales Invoice Header"."LR/RR No.";
//                     LRdate := "Sales Invoice Header"."LR/RR Date";
//                     LRNo2 := "Sales Invoice Header"."LR No. 2";
//                     LRDate2 := "Sales Invoice Header"."LR Date 2";
//                 end;
//                 // LRNo2 := "Sales Invoice Header"."LR No. 2";
//                 // LRDate2 := "Sales Invoice Header"."LR Date 2";
//                 //LFS:SC:06-08-2024:++
//                 APIE_Invoicing.Reset();
//                 APIE_Invoicing.SetRange("Document No", "Sales Invoice Header"."No.");
//                 APIE_Invoicing.SetFilter(Type, '%1', 'INV');//PDD 240121
//                 if (APIE_Invoicing.FindLast()) or (APIE_Invoicing.Success = 'true') then
//                     APIE_Invoicing.CalcFields("QR Code");
//                 "Sales Invoice Header".CalcFields("Sales Invoice Header".IRN);

//                 if RespCenter.Get("Responsibility Center") then begin
//                     FormatAddr.RespCenter(CompanyAddr, RespCenter);
//                     CompanyInfo."Phone No." := RespCenter."Phone No.";
//                     CompanyInfo."Fax No." := RespCenter."Fax No.";
//                 end else
//                     FormatAddr.Company(CompanyAddr, CompanyInfo);
//                 Location.Get("Sales Invoice Header"."Location Code");
//                 GenFun.Location(LocationAdd, Location);

//                 DimSetEntry1.Reset();
//                 DimSetEntry1.SetRange(DimSetEntry1."Dimension Set ID", "Dimension Set ID");
//                 DimSetEntry1.SetFilter(DimSetEntry1."Dimension Code", '%1', 'AGENT');
//                 if DimSetEntry1.FindSet() then
//                     DimSetEntry1.CalcFields(DimSetEntry1."Dimension Value Name");
//                 DimText := DimSetEntry1."Dimension Value Name";


//                 if "Order No." = '' then
//                     OrderNoText := ''
//                 else
//                     OrderNoText := FieldCaption("Order No.");
//                 if "Salesperson Code" = '' then begin
//                     SalesPurchPerson.Init();
//                     SalesPersonText := '';
//                 end else begin
//                     SalesPurchPerson.Get("Salesperson Code");
//                     SalesPersonText := Text000;
//                 end;
//                 if "Your Reference" = '' then
//                     ReferenceText := ''
//                 else
//                     ReferenceText := FieldCaption("Your Reference");
//                 if "VAT Registration No." = '' then
//                     VATNoText := ''
//                 else
//                     VATNoText := FieldCaption("VAT Registration No.");
//                 if "Currency Code" = '' then begin
//                     GLSetup.TestField("LCY Code");
//                     TotalText := StrSubstNo(Text001, GLSetup."LCY Code");
//                     TotalInclVATText := StrSubstNo(Text13700, GLSetup."LCY Code");
//                     TotalExclVATText := StrSubstNo(Text13701, GLSetup."LCY Code");
//                 end else begin
//                     TotalText := StrSubstNo(Text001, "Currency Code");
//                     TotalInclVATText := StrSubstNo(Text13700, "Currency Code");
//                     TotalExclVATText := StrSubstNo(Text13701, "Currency Code");
//                 end;

//                 FormatAddr.SalesInvBillTo(CustAddr, "Sales Invoice Header");
//                 if not Cust.Get("Bill-to Customer No.") then
//                     Clear(Cust);

//                 if "Payment Terms Code" = '' then
//                     PaymentTerms.Init()
//                 else begin
//                     PaymentTerms.Get("Payment Terms Code");
//                     PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
//                 end;
//                 if "Shipment Method Code" = '' then
//                     ShipmentMethod.Init()
//                 else begin
//                     ShipmentMethod.Get("Shipment Method Code");
//                     ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");
//                 end;



//                 //IF ShiptoAddress
//                 FormatAddr.SalesInvShipTo(ShipToAddr, CustAddr, "Sales Invoice Header");
//                 ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
//                 for i := 1 to ArrayLen(ShipToAddr) do
//                     if ShipToAddr[i] <> CustAddr[i] then
//                         ShowShippingAddr := true;

//                 /*
//                 IF ShiptoAddress_Grec.GET("Sell-to Customer No.","Sales Invoice Header"."Ship-to Code") THEN

//                 IF CustPanNO = '' THEN
//                   //CustPanNO := 'PAN No- '+ShiptoAddress_Grec.p+' Email ID- ' + ShiptoAddress_Grec."E-Mail";
//                   */

//                 GetLineFeeNoteOnReportHist("No.");
//                 //LFS-NS-17042024++
//                 // if LogInteraction then
//                 //     if not CurrReport.Preview then begin
//                 //         if "Bill-to Contact No." <> '' then
//                 //             SegManagement.LogDocument(
//                 //               SegManagement.SalesInvoiceInterDocType, "No.", 0, 0, Database::Contact, "Bill-to Contact No.", "Salesperson Code",
//                 //               "Campaign No.", "Posting Description", '')
//                 //         else
//                 //             SegManagement.LogDocument(
//                 //               SegManagement.SalesInvoiceInterDocType, "No.", 0, 0, Database::Customer, "Bill-to Customer No.", "Salesperson Code",
//                 //               "Campaign No.", "Posting Description", '');
//                 //     end;
//                 //LFS-NS-17042024++

//                 SupplementaryText := '';
//                 SalesInvLine.SetRange("Document No.", "No.");
//                 //SalesInvLine.SetRange(Supplementary, true); //LFS commented
//                 if SalesInvLine.FindFirst() then
//                     SupplementaryText := Text16500;
//                 ////LFS commented++
//                 // if Location.Get("Location Code") then
//                 //     ServiceTaxRegistrationNo := Location."Service Tax Registration No."
//                 // else
//                 //     ServiceTaxRegistrationNo := CompanyInfo."Service Tax Registration No.";
//                 //LFS commented--
//                 /*
//                 SalesCommentLine.Reset();
//                 SalesCommentLine.SETRANGE("Document Type",SalesCommentLine."Document Type"::"Posted Invoice");
//                 SalesCommentLine.SETRANGE("No.","No.");
//                 SalesCommentLine.SETRANGE("Line No.",0);
//                 IF SalesCommentLine.FindSet() then;
//                 */
//                 ShippingAgent.Reset();
//                 if ShippingAgent.Get("Sales Invoice Header"."Shipping Agent Code") then;

//                 Customer_Grec.Reset();
//                 if Customer_Grec.Get("Sales Invoice Header"."Sell-to Customer No.") then begin
//                     StateCode_Ship := Customer_Grec."State Code";
//                     GSTN_Ship := Customer_Grec."GST Registration No.";
//                 end;
//                 //  CustomerPostingGroup.Reset();
//                 //  IF CustomerPostingGroup.GET(Customer."Customer Posting Group") THEN;

//                 RoundoffAmt := 0;
//                 SalesInvoiceLine_Grec.Reset();
//                 SalesInvoiceLine_Grec.SetRange("Document No.", "No.");
//                 SalesInvoiceLine_Grec.SetRange(Type, SalesInvoiceLine_Grec.Type::"G/L Account");
//                 if SalesInvoiceLine_Grec.FindSet() then
//                     repeat
//                         if (SalesInvoiceLine_Grec."No." = '7815094') or (SalesInvoiceLine_Grec."No." = '5200109') then
//                             RoundoffAmt += SalesInvoiceLine_Grec.Amount;
//                     until SalesInvoiceLine_Grec.Next() = 0;

//                 ShiptoAddress_Grec.Reset();
//                 ShiptoAddress_Grec.SetRange(Code, "Sales Invoice Header"."Ship-to Code");
//                 ShiptoAddress_Grec.SetRange("Customer No.", "Sales Invoice Header"."Sell-to Customer No.");
//                 if ShiptoAddress_Grec.FindFirst() then begin
//                     StateCode_Ship := ShiptoAddress_Grec.State;
//                     GSTN_Ship := ShiptoAddress_Grec."GST Registration No.";
//                     // DLNoConsignee := ShiptoAddress_Grec."DL No";
//                 end;
//                 txtComment := '';
//                 SalesInvoiceLine_Grec.Reset();
//                 SalesInvoiceLine_Grec.SetRange("Document No.", "No.");
//                 SalesInvoiceLine_Grec.SetFilter("No.", '<>%1', '');
//                 if SalesInvoiceLine_Grec.FindSet() then
//                     repeat
//                         SalesCommentLine.Reset();
//                         SalesCommentLine.SetRange("No.", SalesInvoiceLine_Grec."Document No.");
//                         SalesCommentLine.SetRange("Document Line No.", SalesInvoiceLine_Grec."Line No.");
//                         SalesCommentLine.SetRange("Document Type", SalesCommentLine."document type"::"Posted Invoice");
//                         if SalesCommentLine.FindSet() then
//                             repeat
//                                 if txtComment <> '' then
//                                     txtComment := txtComment + ' ' + SalesCommentLine.Comment
//                                 else
//                                     txtComment := SalesCommentLine.Comment;
//                             until SalesCommentLine.Next() = 0

// until SalesInvoiceLine_Grec.Next() = 0;

//             end;
//         }
//     }

//     requestpage
//     {
//         SaveValues = true;

//         layout
//         {
//             area(content)
//             {
//                 group(Options)
//                 {
//                     Caption = 'Options';
//                     field(NoOfCopies; NoOfCopies)
//                     {
//                         ApplicationArea = Suite;
//                         Caption = 'No. of Copies';
//                         Visible = false;
//                         ToolTip = 'Specifies the value of the No. of Copies field.';
//                     }
//                     field(ShowInternalInfo; ShowInternalInfo)
//                     {
//                         ApplicationArea = Suite;
//                         Caption = 'Show Internal Information';
//                         Visible = false;
//                         ToolTip = 'Specifies the value of the Show Internal Information field.';
//                     }
//                     field(LogInteraction; LogInteraction)
//                     {
//                         ApplicationArea = Suite;
//                         Caption = 'Log Interaction';
//                         Enabled = LogInteractionEnable;
//                         Visible = false;
//                         ToolTip = 'Specifies the value of the Log Interaction field.';
//                     }
//                     field(DisplayAsmInformation; DisplayAssemblyInformation)
//                     {
//                         ApplicationArea = Suite;
//                         Caption = 'Show Assembly Components';
//                         Visible = false;
//                         ToolTip = 'Specifies the value of the Show Assembly Components field.';
//                     }
//                     field(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
//                     {
//                         ApplicationArea = Suite;
//                         Caption = 'Show Additional Fee Note';
//                         Visible = false;
//                         ToolTip = 'Specifies the value of the Show Additional Fee Note field.';
//                     }
//                     field("Full Date"; FullDate)
//                     {
//                         Caption = 'Full Date';
//                         ApplicationArea = Suite;
//                         ToolTip = 'Specifies the value of the FullDate field.';
//                     }
//                 }
//             }
//         }

//         actions
//         {
//         }

//         trigger OnInit()
//         begin
//             LogInteractionEnable := true;
//         end;

//         trigger OnOpenPage()
//         begin
//             InitLogInteraction;
//             LogInteractionEnable := LogInteraction;
//             NoOfCopies := 2;
//         end;
//     }

//     labels
//     {
//         Mfg_Lbl = 'Mfg Lic No.:';
//         CINNo_Lbl = 'CIN No.:';
//         TaxinvoiceLine_Lbl = '(Tax invoice as per rule 7 and section 31 of GST Act – 2017)';
//         TAXINVOICE_Lbl = 'TAX INVOICE';
//         TimeofPreparation_Lbl = 'Time of Preparation :';
//         Date_Lbl = 'Date :';
//         NameofTransporter_Lbl = 'Name of Transporter :';
//         LRNo1_Lbl = 'LR. No. :';
//         LRNo2_Lbl = 'LR. No. (2) :';
//         AgentName_Lbl = 'Agent Name :';
//         SalesPerson_Lbl = 'Sales Person :';
//         BuyerName_Lbl = 'Customer Name & Address :';
//         ConsigneeName_Lbl = 'Consignee Name and Address :';
//         CorpOff_Lbl = 'Corp. Off.:';
//         PlantAdd_Lbl = 'Plant Add.:';
//         CGSTAmt_Lbl = 'CGST Amount In Words :';
//         SGSTAmt_Lbl = 'SGST Amount In Words :';
//         IGSTAmt_Lbl = 'IGST Amount In Words :';
//         TimeofRemoval_Lbl = 'Time of Removal :';
//         DateofRemoval_Lbl = 'Date of Removal :';
//     }

//     trigger OnInitReport()
//     var
//         SalesCommentLine: Record "Sales Comment Line";
//     begin
//         GLSetup.Get();
//         CompanyInfo.Get();
//         SalesSetup.Get();
//         CompanyInfo.VerifyAndSetPaymentInfo;
//         CompanyInfo.CalcFields(Picture);
//         //txtComment:='';
//         /*SalesCommentLine.Reset();
//         SalesCommentLine.SETRANGE("No.","Sales Invoice Header"."No.");
//         SalesCommentLine.SETRANGE("Document Line No.",0);
//         SalesCommentLine.SETRANGE("Document Type",SalesCommentLine."Document Type"::"Posted Invoice");
//         IF SalesCommentLine.FindSet() then REPEAT
//           IF txtComment='' THEN
//             txtComment:=SalesCommentLine.Comment
//           ELSE
//             txtComment:=txtComment+' '+SalesCommentLine.Comment;

//         UNTIL SalesCommentLine.NEXT=0;
//         */
//         /*CASE SalesSetup."Logo Position on Documents" OF
//           SalesSetup."Logo Position on Documents"::Left:
//             BEGIN
//               CompanyInfo3.Get();
//               CompanyInfo3.CALCFIELDS(Picture);
//             END;
//           SalesSetup."Logo Position on Documents"::Center:
//             BEGIN
//               CompanyInfo1.Get();
//               CompanyInfo1.CALCFIELDS(Picture);
//             END;
//           SalesSetup."Logo Position on Documents"::Right:
//             BEGIN
//               CompanyInfo2.Get();
//               CompanyInfo2.CALCFIELDS(Picture);
//             END;
//         END;*/

//     end;

//     trigger OnPreReport()
//     begin
//         if not CurrReport.UseRequestPage then
//             InitLogInteraction;
//     end;

//     var
//         Text000: label 'Salesperson';
//         Text001: label 'Total %1';
//         Text003: label ' COPY';
//         Text004: label 'Sales - Invoice%1';
//         PageCaptionCap: label 'Page %1 of %2';
//         contactPerson: Text;
//         contactNumber: Text;
//         GLSetup: Record "General Ledger Setup";
//         ShipmentMethod: Record "Shipment Method";
//         PaymentTerms: Record "Payment Terms";
//         SalesPurchPerson: Record "Salesperson/Purchaser";
//         CompanyInfo: Record "Company Information";
//         CompanyInfo1: Record "Company Information";
//         CompanyInfo2: Record "Company Information";
//         CompanyInfo3: Record "Company Information";
//         //  GSTComponent: Record "GST Component"; //LFS commented
//         Customer: Record Customer;
//         DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
//         SalesSetup: Record "Sales & Receivables Setup";
//         Cust: Record Customer;
//         VATAmountLine: Record "VAT Amount Line" temporary;
//         DimSetEntry1: Record "Dimension Set Entry";
//         DimSetEntry2: Record "Dimension Set Entry";
//         RespCenter: Record "Responsibility Center";
//         Language: Record Language;
//         CurrExchRate: Record "Currency Exchange Rate";
//         TempPostedAsmLine: Record "Posted Assembly Line" temporary;
//         TempLineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist." temporary;
//         // GSTManagement: Codeunit "GST Management"; //LFS commented
//         SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
//         FormatAddr: Codeunit "Format Address";
//         SegManagement: Codeunit SegManagement;
//         SalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
//         GSTCompAmount: array[20] of Decimal;
//         GSTComponentCode: array[20] of Code[10];
//         PostedShipmentDate: Date;
//         CustAddr: array[8] of Text[50];
//         ShipToAddr: array[8] of Text[50];
//         CompanyAddr: array[8] of Text[50];
//         OrderNoText: Text[80];
//         SalesPersonText: Text[30];
//         VATNoText: Text[80];
//         ReferenceText: Text[80];
//         TotalText: Text[50];
//         TotalExclVATText: Text[50];
//         TotalInclVATText: Text[50];
//         MoreLines: Boolean;
//         NoOfCopies: Integer;
//         NoOfLoops: Integer;
//         CopyText: Text[30];
//         ShowShippingAddr: Boolean;
//         i: Integer;
//         NextEntryNo: Integer;
//         FirstValueEntryNo: Integer;
//         DimText: Text[120];
//         OldDimText: Text[75];
//         ShowInternalInfo: Boolean;
//         Continue: Boolean;
//         LogInteraction: Boolean;
//         VALVATBaseLCY: Decimal;
//         VALVATAmountLCY: Decimal;
//         VALSpecLCYHeader: Text[80];
//         Text007: label 'VAT Amount Specification in ';
//         Text008: label 'Local Currency';
//         VALExchRate: Text[50];
//         Text009: label 'Exchange rate: %1/%2';
//         CalculatedExchRate: Decimal;
//         Text010: label 'Sales - Prepayment Invoice %1';
//         OutputNo: Integer;
//         TotalSubTotal: Decimal;
//         TotalAmount: Decimal;
//         TotalAmountInclVAT: Decimal;
//         TotalAmountVAT: Decimal;
//         TotalInvoiceDiscountAmount: Decimal;
//         TotalPaymentDiscountOnVAT: Decimal;
//         ChargesAmount: Decimal;
//         OtherTaxesAmount: Decimal;
//         ItemCharge: Record "Item Charge";
//         Text13700: label 'Total Incl. Taxes';
//         Text13701: label 'Total Excl. Taxes';
//         SupplementaryText: Text[30];
//         Text16500: label 'Supplementary Invoice';
//         // ServiceTaxEntry: Record "Service Tax Entry"; //LFS commented
//         ServiceTaxAmt: Decimal;
//         ServiceTaxECessAmt: Decimal;
//         AppliedServiceTaxAmt: Decimal;
//         AppliedServiceTaxECessAmt: Decimal;
//         ServiceTaxSHECessAmt: Decimal;
//         AppliedServiceTaxSHECessAmt: Decimal;
//         TotalTaxAmt: Decimal;
//         TotalExciseAmt: Decimal;
//         TotalTCSAmount: Decimal;
//         ServiceTaxAmount: Decimal;
//         ServiceTaxeCessAmount: Decimal;
//         ServiceTaxSHECessAmount: Decimal;
//         LogInteractionEnable: Boolean;
//         DisplayAssemblyInformation: Boolean;
//         PhoneNoCaptionLbl: label 'Phone No.';
//         HomePageCaptionCap: label 'Home Page';
//         VATRegNoCaptionLbl: label 'VAT Registration No.';
//         GiroNoCaptionLbl: label 'Giro No.';
//         BankNameCaptionLbl: label 'Bank';
//         BankAccNoCaptionLbl: label 'Account No.';
//         DueDateCaptionLbl: label 'Due Date';
//         InvoiceNoCaptionLbl: label 'Invoice No.';
//         PostingDateCaptionLbl: label 'Posting Date';
//         PLAEntryNoCaptionLbl: label 'PLA Entry No.';
//         RG23AEntryNoCaptionLbl: label 'RG23A Entry No.';
//         RG23CEntryNoCaptionLbl: label 'RG23C Entry No.';
//         HeaderDimensionsCaptionLbl: label 'Header Dimensions';
//         UnitPriceCaptionLbl: label 'Rate';
//         DiscountCaptionLbl: label 'Discount %';
//         AmountCaptionLbl: label 'Value(Rs)';
//         LineDiscountCaptionLbl: label 'Line Discount Amount';
//         PostedShipmentDateCaptionLbl: label 'Posted Shipment Date';
//         SubtotalCaptionLbl: label 'Subtotal';
//         ExciseAmountCaptionLbl: label 'Excise Amount';
//         TaxAmountCaptionLbl: label 'Tax Amount';
//         ServiceTaxAmountCaptionLbl: label 'Service Tax Amount';
//         ChargesAmountCaptionLbl: label 'Other Charges';
//         OtherTaxesAmountCaptionLbl: label 'Other Taxes Amount';
//         ServTaxeCessAmtCaptionLbl: label 'Service Tax eCess Amount';
//         TCSAmountCaptionLbl: label 'TCS Amount';
//         SvcTaxAmtAppliedCaptionLbl: label 'Svc Tax Amt (Applied)';
//         SvcTaxeCessAmtAppliedCaptionLbl: label 'Svc Tax eCess Amt (Applied)';
//         ServTaxSHECessAmtCaptionLbl: label 'Service Tax SHE Cess Amount';
//         SvcTaxSHECessAmtAppliedCaptionLbl: label 'Svc Tax SHECess Amt(Applied)';
//         PaymentDiscVATCaptionLbl: label 'Payment Discount on VAT';
//         ShipmentCaptionLbl: label 'Shipment';
//         LineDimensionsCaptionLbl: label 'Line Dimensions';
//         VATAmountSpecificationCaptionLbl: label 'VAT Amount Specification';
//         InvDiscBaseAmtCaptionLbl: label 'Invoice Discount Base Amount';
//         LineAmountCaptionLbl: label 'Line Amount';
//         ShipToAddressCaptionLbl: label 'Ship-to Address';
//         ServiceTaxRegistrationNo: Code[20];
//         ServiceTaxRegistrationNoLbl: label 'Service Tax Registration No.';
//         InvDiscountAmountCaptionLbl: label 'Invoice Discount Amount';
//         VATPercentageCaptionLbl: label 'VAT %';
//         VATAmountCaptionLbl: label 'VAT Amount';
//         VATIdentifierCaptionLbl: label 'VAT Identifier';
//         TotalCaptionLbl: label 'Total';
//         VATBaseCaptionLbl: label 'VAT Base';
//         PaymentTermsCaptionLbl: label 'Payment Terms';
//         ShipmentMethodCaptionLbl: label 'Shipment Method';
//         EMailCaptionLbl: label 'E-Mail';
//         DocumentDateCaptionLbl: label 'Document Date';
//         DisplayAdditionalFeeNote: Boolean;
//         ServTaxSBCAmtCaptionLbl: label 'SBC Amount';
//         SvcTaxSBCAmtAppliedCaptionLbl: label 'SBC Amt (Applied)';
//         ServiceTaxSBCAmount: Decimal;
//         ServiceTaxSBCAmt: Decimal;
//         AppliedServiceTaxSBCAmt: Decimal;
//         KKCessAmount: Decimal;
//         KKCessAmt: Decimal;
//         AppliedKKCessAmt: Decimal;
//         KKCessAmtCaptionLbl: label 'KKC Amount';
//         KKCessAmtAppliedCaptionLbl: label 'KKC Amt (Applied)';
//         IsGSTApplicable: Boolean;
//         J: Integer;
//         CompanyRegistrationLbl: label 'GST No.';
//         CustomerRegistrationLbl: label 'Customer GST Reg No.';
//         ItemLedgEntry: Record "Item Ledger Entry";
//         TempItemLedgEntry: Record "Item Ledger Entry" temporary;
//         ValueEntry: Record "Value Entry";
//         NumInWords: array[2] of Text[250];
//         Check: Report Check;
//         SalesCommentLine: Record "Sales Comment Line";
//         ShippingAgent: Record "Shipping Agent";
//         SRNo: Integer;
//         "GST%": Decimal;
//         GST_PerIGST: Decimal;
//         CGST_InWords: array[2] of Text;
//         SGST_InWords: array[2] of Text;
//         IGST_InWords: array[2] of Text;
//         Customer_Grec: Record Customer;
//         RoundoffAmt: Decimal;
//         CustomerPostingGroup: Record "Customer Posting Group";
//         SalesInvoiceLine_Grec: Record "Sales Invoice Line";
//         FrightCharge: Decimal;
//         ShiptoAddress_Grec: Record "Ship-to Address";
//         StateCode_Ship: Code[20];
//         LocationAdd: array[8] of Text[50];
//         txtComment: Text;
//         DLNoConsignee: Text;
//         DLNoBuyer: Text;
//         LRNo2: Code[20];
//         LRDate2: Date;
//         ShiptoAddress: Record "Ship-to Address";
//         ChkBatch: Integer;
//         LotInfoExist: Boolean;
//         gRecDimSet: Record "Dimension Set Entry";
//         GSTN_Ship: Text[15];
//         gRecTransporter: Record "Transport Method";
//         LUTNumber: Text[50];
//         TCSAmount: Decimal;
//         IsItem: Boolean;
//         APIE_Invoicing: Record "API E_Invoicing";
//         CustPanNO: Text[500];
//         DimensionSetEntry: Record "Dimension Set Entry";
//         SalesShipmentHeader: Record "Sales Shipment Header";
//         SalesShipmentLine: Record "Sales Shipment Line";
//         SalesHeader: Record "Sales Header";
//         OrderDate: Date;
//         FullDate: Boolean;
//         DateFormate: Text;
//         DateFormate2: Text;
//         UnitPrice_SalesInvLine: Decimal;
//         LineAmount_SalesInvLine: Decimal;
//         TotalAmountInclVAT1: Decimal;
//         TotalAmountVAT1: Decimal;
//         CurrFact: Decimal;
//         TotalGSTAmt: Decimal;
//         GenFun: Codeunit "General Functions";
//         RG23CEntryNo_SalesInvHdr: Code[20];
//         RG23AEntryNo_SalesInvHdr: Code[20];
//         PLAEntryNo_SalesInvHdr: Code[20];
//         TcsEntry: Record "TCS Entry";
//         CGSTAmt: Decimal;
//         SGSTAmt: Decimal;
//         IGSTAmt: Decimal;
//         CGSTPer: Decimal;
//         SGSTPer: Decimal;
//         IGSTPer: Decimal;
//         TotalSGST: Decimal;
//         TotalIGST: Decimal;
//         TotalCGST: Decimal;
//         AmountIncVAT: Decimal;
//         AmtinWords: array[2] of Text;
//         IFSCvalue: Text;
//         OneLbl: Label 'ONE';
//         TwoLbl: Label 'TWO';
//         ThreeLbl: Label 'THREE';
//         FourLbl: Label 'FOUR';
//         FiveLbl: Label 'FIVE';
//         SixLbl: Label 'SIX';
//         SevenLbl: Label 'SEVEN';
//         EightLbl: Label 'EIGHT';
//         NineLbl: Label 'NINE';
//         TenLbl: Label 'TEN';
//         ElevenLbl: Label 'ELEVEN';
//         TwelveLbl: Label 'TWELVE';
//         ThireentLbl: Label 'THIRTEEN';
//         FourteenLbl: Label 'FOURTEEN';
//         FifteenLbl: Label 'FIFTEEN';
//         SixteenLbl: Label 'SIXTEEN';
//         SeventeenLbl: Label 'SEVENTEEN';
//         EighteenLbl: Label 'EIGHTEEN';
//         NinteenLbl: Label 'NINETEEN';
//         TwentyLbl: Label 'TWENTY';
//         ThirtyLbl: Label 'THIRTY';
//         HundreadLbl: Label 'HUNDRED';
//         FortyLbl: Label 'FORTY';
//         AndLbl: Label 'AND';
//         FiftyLbl: Label 'FIFTY';
//         SixtyLbl: Label 'SIXTY';
//         SeventyLbl: Label 'SEVENTY';
//         EightyLbl: Label 'EIGHTY';
//         NinetyLbl: Label 'NINETY';
//         ThousandLbl: Label 'THOUSAND';
//         LakhLbl: Label 'LAKH';
//         CroreLbl: Label 'CRORE';
//         ZeroLbl: Label 'ZERO';
//         OnlyLbl: Label 'ONLY';
//         OnesText: array[20] of Text[30];
//         TensText: array[10] of Text[30];
//         ExponentText: array[5] of Text[30];
//         NoTextAmt: ARRAY[2] OF Text[80];
//         NoTextAmt2: ARRAY[2] OF Text[80];
//         NoTextExcise: array[2] of Text[80];
//         RepCheck: array[2] of Report Check;
//         TransporterName: Text[50];
//         LRNo: Code[20];
//         LRdate: Date;
//         EwaybillHeader: Record "Eway Bill Header";
//         EwaybillLine: Record "Eway Bill Lines";
//         RemittanceAmntInWords: Text;
//         PreviousLineNo: Integer;
//         CurrencyExchangeRate: Record "Currency Exchange Rate";
//         AmountInINR: Decimal;
//         Notext: array[2] of Text;
//         AmountIncVATINR: Decimal;
//         Item: Record Item;
//         DrugLicNo: Code[20];
//         ExportInfo: Record "Posted Export Information";
//         ShippingMarks: Text;
//         Unit_Price: Decimal;
//         TotalLineAmt: Decimal;
//         txtComment1: Text;

//     procedure InitLogInteraction()
//     begin
//         LogInteraction := SegManagement.FindInteractionTemplateCode(4) <> '';
//     end;


//     procedure FindPostedShipmentDate(): Date
//     var
//         SalesShipmentHeader: Record "Sales Shipment Header";
//         SalesShipmentBuffer2: Record "Sales Shipment Buffer" temporary;
//     begin
//         NextEntryNo := 1;
//         if "Sales Invoice Line"."Shipment No." <> '' then
//             if SalesShipmentHeader.Get("Sales Invoice Line"."Shipment No.") then
//                 exit(SalesShipmentHeader."Posting Date");

//         if "Sales Invoice Header"."Order No." = '' then
//             exit("Sales Invoice Header"."Posting Date");

//         case "Sales Invoice Line".Type of
//             "Sales Invoice Line".Type::Item:
//                 GenerateBufferFromValueEntry("Sales Invoice Line");
//             "Sales Invoice Line".Type::"G/L Account", "Sales Invoice Line".Type::Resource,
//           "Sales Invoice Line".Type::"Charge (Item)", "Sales Invoice Line".Type::"Fixed Asset":
//                 GenerateBufferFromShipment("Sales Invoice Line");
//             "Sales Invoice Line".Type::" ":
//                 exit(0D);
//         end;

//         SalesShipmentBuffer.Reset();
//         SalesShipmentBuffer.SetRange("Document No.", "Sales Invoice Line"."Document No.");
//         SalesShipmentBuffer.SetRange("Line No.", "Sales Invoice Line"."Line No.");
//         if SalesShipmentBuffer.Find('-') then begin
//             SalesShipmentBuffer2 := SalesShipmentBuffer;
//             if SalesShipmentBuffer.Next() = 0 then begin
//                 SalesShipmentBuffer.Get(
//                   SalesShipmentBuffer2."Document No.", SalesShipmentBuffer2."Line No.", SalesShipmentBuffer2."Entry No.");
//                 SalesShipmentBuffer.Delete;
//                 exit(SalesShipmentBuffer2."Posting Date");
//             end;
//             SalesShipmentBuffer.CalcSums(Quantity);
//             if SalesShipmentBuffer.Quantity <> "Sales Invoice Line".Quantity then begin
//                 SalesShipmentBuffer.DeleteAll;
//                 exit("Sales Invoice Header"."Posting Date");
//             end;
//         end else
//             exit("Sales Invoice Header"."Posting Date");
//     end;


//     procedure GenerateBufferFromValueEntry(SalesInvoiceLine2: Record "Sales Invoice Line")
//     var
//         ValueEntry: Record "Value Entry";
//         ItemLedgerEntry: Record "Item Ledger Entry";
//         TotalQuantity: Decimal;
//         Quantity: Decimal;
//     begin
//         TotalQuantity := SalesInvoiceLine2."Quantity (Base)";
//         ValueEntry.SetCurrentkey("Document No.");
//         ValueEntry.SetRange("Document No.", SalesInvoiceLine2."Document No.");
//         ValueEntry.SetRange("Posting Date", "Sales Invoice Header"."Posting Date");
//         ValueEntry.SetRange("Item Charge No.", '');
//         ValueEntry.SetFilter("Entry No.", '%1..', FirstValueEntryNo);
//         if ValueEntry.Find('-') then
//             repeat
//                 if ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.") then begin
//                     if SalesInvoiceLine2."Qty. per Unit of Measure" <> 0 then
//                         Quantity := ValueEntry."Invoiced Quantity" / SalesInvoiceLine2."Qty. per Unit of Measure"
//                     else
//                         Quantity := ValueEntry."Invoiced Quantity";
//                     AddBufferEntry(
//                       SalesInvoiceLine2,
//                       -Quantity,
//                       ItemLedgerEntry."Posting Date");
//                     TotalQuantity := TotalQuantity + ValueEntry."Invoiced Quantity";
//                 end;
//                 FirstValueEntryNo := ValueEntry."Entry No." + 1;
//             until (ValueEntry.Next() = 0) or (TotalQuantity = 0);
//     end;


//     procedure GenerateBufferFromShipment(SalesInvoiceLine: Record "Sales Invoice Line")
//     var
//         SalesInvoiceHeader: Record "Sales Invoice Header";
//         SalesInvoiceLine2: Record "Sales Invoice Line";
//         SalesShipmentHeader: Record "Sales Shipment Header";
//         SalesShipmentLine: Record "Sales Shipment Line";
//         TotalQuantity: Decimal;
//         Quantity: Decimal;
//     begin
//         TotalQuantity := 0;
//         SalesInvoiceHeader.SetCurrentkey("Order No.");
//         SalesInvoiceHeader.SetFilter("No.", '..%1', "Sales Invoice Header"."No.");
//         SalesInvoiceHeader.SetRange("Order No.", "Sales Invoice Header"."Order No.");
//         if SalesInvoiceHeader.Find('-') then
//             repeat
//                 SalesInvoiceLine2.SetRange("Document No.", SalesInvoiceHeader."No.");
//                 SalesInvoiceLine2.SetRange("Line No.", SalesInvoiceLine."Line No.");
//                 SalesInvoiceLine2.SetRange(Type, SalesInvoiceLine.Type);
//                 SalesInvoiceLine2.SetRange("No.", SalesInvoiceLine."No.");
//                 SalesInvoiceLine2.SetRange("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
//                 if SalesInvoiceLine2.Find('-') then
//                     repeat
//                         TotalQuantity := TotalQuantity + SalesInvoiceLine2.Quantity;
//                     until SalesInvoiceLine2.Next() = 0;
//             until SalesInvoiceHeader.Next() = 0;

//         SalesShipmentLine.SetCurrentkey("Order No.", "Order Line No.");
//         SalesShipmentLine.SetRange("Order No.", "Sales Invoice Header"."Order No.");
//         SalesShipmentLine.SetRange("Order Line No.", SalesInvoiceLine."Line No.");
//         SalesShipmentLine.SetRange("Line No.", SalesInvoiceLine."Line No.");
//         SalesShipmentLine.SetRange(Type, SalesInvoiceLine.Type);
//         SalesShipmentLine.SetRange("No.", SalesInvoiceLine."No.");
//         SalesShipmentLine.SetRange("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
//         SalesShipmentLine.SetFilter(Quantity, '<>%1', 0);

//         if SalesShipmentLine.Find('-') then
//             repeat
//                 if "Sales Invoice Header"."Get Shipment Used" then
//                     CorrectShipment(SalesShipmentLine);
//                 if Abs(SalesShipmentLine.Quantity) <= Abs(TotalQuantity - SalesInvoiceLine.Quantity) then
//                     TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity
//                 else begin
//                     if Abs(SalesShipmentLine.Quantity) > Abs(TotalQuantity) then
//                         SalesShipmentLine.Quantity := TotalQuantity;
//                     Quantity :=
//                       SalesShipmentLine.Quantity - (TotalQuantity - SalesInvoiceLine.Quantity);

//                     TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity;
//                     SalesInvoiceLine.Quantity := SalesInvoiceLine.Quantity - Quantity;

//                     if SalesShipmentHeader.Get(SalesShipmentLine."Document No.") then
//                         AddBufferEntry(
//                           SalesInvoiceLine,
//                           Quantity,
//                           SalesShipmentHeader."Posting Date");
//                 end;
//             until (SalesShipmentLine.Next() = 0) or (TotalQuantity = 0);
//     end;


//     procedure CorrectShipment(var SalesShipmentLine: Record "Sales Shipment Line")
//     var
//         SalesInvoiceLine: Record "Sales Invoice Line";
//     begin
//         SalesInvoiceLine.SetCurrentkey("Shipment No.", "Shipment Line No.");
//         SalesInvoiceLine.SetRange("Shipment No.", SalesShipmentLine."Document No.");
//         SalesInvoiceLine.SetRange("Shipment Line No.", SalesShipmentLine."Line No.");
//         if SalesInvoiceLine.Find('-') then
//             repeat
//                 SalesShipmentLine.Quantity := SalesShipmentLine.Quantity - SalesInvoiceLine.Quantity;
//             until SalesInvoiceLine.Next() = 0;
//     end;


//     procedure AddBufferEntry(SalesInvoiceLine: Record "Sales Invoice Line"; QtyOnShipment: Decimal; PostingDate: Date)
//     begin
//         SalesShipmentBuffer.SetRange("Document No.", SalesInvoiceLine."Document No.");
//         SalesShipmentBuffer.SetRange("Line No.", SalesInvoiceLine."Line No.");
//         SalesShipmentBuffer.SetRange("Posting Date", PostingDate);
//         if SalesShipmentBuffer.Find('-') then begin
//             SalesShipmentBuffer.Quantity := SalesShipmentBuffer.Quantity + QtyOnShipment;
//             SalesShipmentBuffer.Modify;
//             exit;
//         end;

//         SalesShipmentBuffer."Document No." := SalesInvoiceLine."Document No.";
//         SalesShipmentBuffer."Line No." := SalesInvoiceLine."Line No.";
//         SalesShipmentBuffer."Entry No." := NextEntryNo;
//         SalesShipmentBuffer.Type := SalesInvoiceLine.Type;
//         SalesShipmentBuffer."No." := SalesInvoiceLine."No.";
//         SalesShipmentBuffer.Quantity := QtyOnShipment;
//         SalesShipmentBuffer."Posting Date" := PostingDate;
//         SalesShipmentBuffer.INSERT();
//         NextEntryNo := NextEntryNo + 1
//     end;

//     local procedure DocumentCaption(): Text[250]
//     begin
//         if "Sales Invoice Header"."Prepayment Invoice" then
//             exit(Text010);
//         exit(Text004);
//     end;


//     procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean; DisplayAsmInfo: Boolean)
//     begin
//         NoOfCopies := NewNoOfCopies;
//         ShowInternalInfo := NewShowInternalInfo;
//         LogInteraction := NewLogInteraction;
//         DisplayAssemblyInformation := DisplayAsmInfo;
//     end;


//     procedure CollectAsmInformation()
//     var
//         ValueEntry: Record "Value Entry";
//         ItemLedgerEntry: Record "Item Ledger Entry";
//         PostedAsmHeader: Record "Posted Assembly Header";
//         PostedAsmLine: Record "Posted Assembly Line";
//         SalesShipmentLine: Record "Sales Shipment Line";
//     begin
//         TempPostedAsmLine.DeleteAll;
//         if "Sales Invoice Line".Type <> "Sales Invoice Line".Type::Item then
//             exit;
//         ValueEntry.SetCurrentkey(ValueEntry."Document No.");
//         ValueEntry.SetRange(ValueEntry."Document No.", "Sales Invoice Line"."Document No.");
//         ValueEntry.SetRange(ValueEntry."Document Type", ValueEntry."document type"::"Sales Invoice");
//         ValueEntry.SetRange(ValueEntry."Document Line No.", "Sales Invoice Line"."Line No.");
//         ValueEntry.SetRange(ValueEntry.Adjustment, false);
//         if not ValueEntry.FindSet() then
//             exit;
//         repeat
//             if ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.") then
//                 if ItemLedgerEntry."Document Type" = ItemLedgerEntry."document type"::"Sales Shipment" then begin
//                     SalesShipmentLine.Get(ItemLedgerEntry."Document No.", ItemLedgerEntry."Document Line No.");
//                     if SalesShipmentLine.AsmToShipmentExists(PostedAsmHeader) then begin
//                         PostedAsmLine.SetRange("Document No.", PostedAsmHeader."No.");
//                         if PostedAsmLine.FindSet() then
//                             repeat
//                                 TreatAsmLineBuffer(PostedAsmLine);
//                             until PostedAsmLine.Next() = 0;
//                     end;
//                 end;
//         until ValueEntry.Next() = 0;
//     end;


//     procedure TreatAsmLineBuffer(PostedAsmLine: Record "Posted Assembly Line")
//     begin
//         Clear(TempPostedAsmLine);
//         TempPostedAsmLine.SetRange(Type, PostedAsmLine.Type);
//         TempPostedAsmLine.SetRange("No.", PostedAsmLine."No.");
//         TempPostedAsmLine.SetRange("Variant Code", PostedAsmLine."Variant Code");
//         TempPostedAsmLine.SetRange(Description, PostedAsmLine.Description);
//         TempPostedAsmLine.SetRange("Unit of Measure Code", PostedAsmLine."Unit of Measure Code");
//         if TempPostedAsmLine.FindFirst() then begin
//             TempPostedAsmLine.Quantity += PostedAsmLine.Quantity;
//             TempPostedAsmLine.Modify;
//         end else begin
//             Clear(TempPostedAsmLine);
//             TempPostedAsmLine := PostedAsmLine;
//             TempPostedAsmLine.INSERT();
//         end;
//     end;


//     procedure GetUOMText(UOMCode: Code[10]): Text[10]
//     var
//         UnitOfMeasure: Record "Unit of Measure";
//     begin
//         if not UnitOfMeasure.Get(UOMCode) then
//             exit(UOMCode);
//         exit(UnitOfMeasure.Description);
//     end;


//     procedure BlanksForIndent(): Text[10]
//     begin
//         exit(PadStr('', 2, ' '));
//     end;

//     local procedure GetLineFeeNoteOnReportHist(SalesInvoiceHeaderNo: Code[20])
//     var
//         LineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist.";
//         CustLedgerEntry: Record "Cust. Ledger Entry";
//         Customer: Record Customer;
//     begin
//         TempLineFeeNoteOnReportHist.DeleteAll;
//         CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."document type"::Invoice);
//         CustLedgerEntry.SetRange("Document No.", SalesInvoiceHeaderNo);
//         if not CustLedgerEntry.FindFirst() then
//             exit;

//         if not Customer.Get(CustLedgerEntry."Customer No.") then
//             exit;

//         LineFeeNoteOnReportHist.SetRange("Cust. Ledger Entry No", CustLedgerEntry."Entry No.");
//         LineFeeNoteOnReportHist.SetRange("Language Code", Customer."Language Code");
//         if LineFeeNoteOnReportHist.FindSet() then begin
//             repeat
//                 TempLineFeeNoteOnReportHist.Init;
//                 TempLineFeeNoteOnReportHist.Copy(LineFeeNoteOnReportHist);
//                 TempLineFeeNoteOnReportHist.INSERT();
//             until LineFeeNoteOnReportHist.Next() = 0;
//         end else begin
//             LineFeeNoteOnReportHist.SetRange("Language Code", Language.GetUserLanguage);
//             if LineFeeNoteOnReportHist.FindSet() then
//                 repeat
//                     TempLineFeeNoteOnReportHist.Init;
//                     TempLineFeeNoteOnReportHist.Copy(LineFeeNoteOnReportHist);
//                     TempLineFeeNoteOnReportHist.INSERT();
//                 until LineFeeNoteOnReportHist.Next() = 0;
//         end;
//     end;

//     procedure InitTextVariable()
//     begin
//         OnesText[1] := OneLbl;
//         OnesText[2] := TwoLbl;
//         OnesText[3] := ThreeLbl;
//         OnesText[4] := FourLbl;
//         OnesText[5] := FiveLbl;
//         OnesText[6] := SixLbl;
//         OnesText[7] := SevenLbl;
//         OnesText[8] := EightLbl;
//         OnesText[9] := NineLbl;
//         OnesText[10] := TenLbl;
//         OnesText[11] := ElevenLbl;
//         OnesText[12] := TwelveLbl;
//         OnesText[13] := ThireentLbl;
//         OnesText[14] := FourteenLbl;
//         OnesText[15] := FifteenLbl;
//         OnesText[16] := SixteenLbl;
//         OnesText[17] := SeventeenLbl;
//         OnesText[18] := EighteenLbl;
//         OnesText[19] := NinteenLbl;

//         TensText[1] := '';
//         TensText[2] := TwentyLbl;
//         TensText[3] := ThirtyLbl;
//         TensText[4] := FortyLbl;
//         TensText[5] := FiftyLbl;
//         TensText[6] := SixtyLbl;
//         TensText[7] := SeventyLbl;
//         TensText[8] := EightyLbl;
//         TensText[9] := NinetyLbl;

//         ExponentText[1] := '';
//         ExponentText[2] := ThousandLbl;
//         ExponentText[3] := LakhLbl;
//         ExponentText[4] := CroreLbl;
//     end;

//     procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
//     var

//         Currency: Record Currency;

//         PrintExponent: Boolean;

//         NoTextIndex: Integer;

//         TensDec: Integer;

//         OnesDec: Integer;

//         Ones: Integer;

//         Tens: Integer;

//         Hundreds: Integer;

//         Exponent: Integer;
//     begin
//         Clear(NoText);
//         NoTextIndex := 1;
//         NoText[1] := '****';
//         if No < 1 then
//             AddToNoText(NoText, NoTextIndex, PrintExponent, ZeroLbl)
//         else begin
//             for Exponent := 4 downto 1 do begin
//                 PrintExponent := false;
//                 if No > 99999 then begin
//                     Ones := No DIV (Power(100, Exponent - 1) * 10);
//                     Hundreds := 0;
//                 end else begin
//                     Ones := No DIV Power(1000, Exponent - 1);
//                     Hundreds := Ones DIV 100;
//                 end;
//                 Tens := (Ones MOD 100) DIV 10;
//                 Ones := Ones MOD 10;
//                 if Hundreds > 0 then begin
//                     AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
//                     AddToNoText(NoText, NoTextIndex, PrintExponent, HundreadLbl);
//                 end;
//                 if Tens >= 2 then begin
//                     AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
//                     if Ones > 0 then
//                         AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
//                 end else
//                     if (Tens * 10 + Ones) > 0 then
//                         AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
//                 if PrintExponent and (Exponent > 1) then
//                     AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
//                 if No > 99999 then
//                     No := No - (Hundreds * 100 + Tens * 10 + Ones) * Power(100, Exponent - 1) * 10
//                 else
//                     No := No - (Hundreds * 100 + Tens * 10 + Ones) * Power(1000, Exponent - 1);
//             end;
//         end;
//         AddToNoText(NoText, NoTextIndex, PrintExponent, 'RUPEES');
//         AddToNoText(NoText, NoTextIndex, PrintExponent, AndLbl);
//         TensDec := ROUND(((No * 100) MOD 100) DIV 10, 1);
//         OnesDec := ROUND((No * 100) MOD 10, 1);
//         if TensDec >= 2 then begin
//             AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[TensDec]);
//             if OnesDec > 0 then
//                 AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[OnesDec]);
//         end else
//             if (TensDec * 10 + OnesDec) > 0 then
//                 AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[TensDec * 10 + OnesDec])
//             else
//                 AddToNoText(NoText, NoTextIndex, PrintExponent, ZeroLbl);
//         if (CurrencyCode <> '') then
//             AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + Currency.Code + ' ONLY')
//         else
//             AddToNoText(NoText, NoTextIndex, PrintExponent, ' PAISA ONLY');
//     end;

//     local procedure AddToNoText(
//             var NoText: array[2] of Text[80];
//             var NoTextIndex: Integer;
//             var PrintExponent: Boolean;
//             AddText: Text[30])
//     begin
//         PrintExponent := true;

//         while StrLen(NoText[NoTextIndex] + ' ' + AddText) > MaxStrLen(NoText[1]) do begin
//             NoTextIndex := NoTextIndex + 1;
//         end;
//         NoText[NoTextIndex] := DelChr(NoText[NoTextIndex] + ' ' + AddText, '<');
//     end;
// }