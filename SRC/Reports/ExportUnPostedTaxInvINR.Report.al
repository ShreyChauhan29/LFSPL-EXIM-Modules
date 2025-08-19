report 72009 "Export UnPosted Tax Inv-INR"
{
    ApplicationArea = All;
    Caption = 'Export UnPosted Tax Invoice-INR';
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    RDLCLayout = './SRC/Reports Layouts/Export UnPosted Tax Invoice-INR.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = sorting("No.", "Document Type");
            RequestFilterFields = "No.";
            //CalcFields = "QR Code";
            column("UserID"; UserSetup."User ID") { }
            column(QR_Code; 0) { }
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
            column(Order_No_; '') { }
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
#pragma warning disable AA0248
#pragma warning disable AL0432
            column(FooterAddress2; 'T: ' + compyInfo."Phone No." + ' | E: ' + compyInfo."E-Mail" + ' | ' + 'W: ' + compyInfo."Home Page") { }
#pragma warning restore AL0432
#pragma warning restore AA0248{}
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
            column(IRN_Hash; '') { }
            column(Acknowledgement_Date; 0D) { }
            column(Acknowledgement_No_; '') { }
            column(LocCountryName; LocCountryName) { }
            column(PaymentTermsDesc; PaymentTermsDesc) { }
            column(SumQuantityLine; SumQuantityLine) { }
            column(CustLedEntAmtLCY; CustLedEntAmtLCY) { }
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
            column(Ship_to_Code; "Ship-to Code") { }
            column(BuyersAddressName; BuyersAddressName) { }
            column(GST_Customer_Type; "GST Customer Type") { }
            column(Total_Line_Discount_Amount; TotalLineDicsAmt) { }

            dataitem(CopyLoop; Integer)
            {
                DataItemLinkReference = "Sales Header";
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
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document No." = field("No."), "Sell-to Customer No." = field("Sell-to Customer No.");
                        DataItemLinkReference = "Sales Header";
                        // DataItemTableView = sorting(Type) where(Type = filter(<> ''), "No." = filter(<> '402545'));//402545
                        DataItemTableView = sorting("Document No.", "Line No.");

                        column(No; "No.")
                        { }
                        // column(Quantity;Quantity){}
                        // column(Unit_of_Measure_Code;"Unit of Measure Code"){}
                        // column(Unit_Price; "Unit Price") { }
                        column(Line_Amount; "Line Amount") { }
                        column(HSN_SAC_Code; HSN_SAC_Code)
                        { }
                        column(HSNSAC_Description; HSNSAC.Description) { }
                        column(Quantity; Quantity)
                        { }
                        column(Description; ItemDescription)
                        { }
                        column(Description_2; DescriptionCustom)
                        {

                        }
                        column(Description_3; "Description 2") { }
                        column(No_of_Pc; '') { }
                        column(No_Of_Packages; '') { }
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
                        column(Aux_Unit_Rate; AuxUnitRateVar)
                        {

                        }
                        column(Aux_Amount; '')
                        {

                        }
                        column(Insurance_Value_Per_Type__LCY_; "LFS Insurance Value (LCY)") { }
                        column(Freight_Value_Per_Type__LCY_; "LFS Freight Value (LCY)") { }
                        trigger OnPreDataItem()
                        begin
                            "Sales Line".setfilter(Type, '<>%1', "Sales Line".Type::" ");

                            if CustomerPostingGrp.GET("Sales Header"."Customer Posting Group") then;
                            if "Sales Line".Type = "Sales Line".Type::"G/L Account" then
                                "Sales Line".SetRange("No.", '<>%1', CustomerPostingGrp."Invoice Rounding Account");
                        end;

                        trigger OnAfterGetRecord()
                        begin

                            SrNo += 1;
                            SumOFAmount += Amount;
                            Clear(DescriptionCustom);
                            if "Sales Line".Type = "Sales Line".Type::Item then begin
                                Crlf := TypeHelper.CRLFSeparator();
                                if "Sales Line"."HSN/SAC Code" <> '' then
                                    if HSNSACRec.Get("Sales Line"."GST Group Code", "Sales Line"."HSN/SAC Code") then;
                                if HSNSACRec.Description <> '' then
                                    DescriptionCustom := HSNSACRec.Description + Crlf;
                            end;
                            if "Sales Line".Type <> "Sales Line".type::"Charge (Item)" then
                                HSN_SAC_Code := "Sales Line"."HSN/SAC Code"
                            else
                                HSN_SAC_Code := '';
                            Clear(ItemDescription);
                            if "Sales Line".Type = "Sales Line".Type::"Charge (Item)" then begin
                                // if "Sales Line"."Charge Calculation Type" = "Sales Line"."Charge Calculation Type"::"Percentage On Amount" then
                                //     ItemDescription := "Sales Line".Description + ' ' + Format("Sales Line"."Charge Rate") + '%'
                                // else
                                ItemDescription := "Sales Line".Description;
                            end else
                                ItemDescription := "Sales Line".Description;

                            Comments := '';
                            SalesCommentLine.Reset();
                            //SalesCommentLine.SetRange("Document Type", "Purchase Line"."Document Type");
                            SalesCommentLine.SetRange("No.", "Sales Line"."Document No.");
                            SalesCommentLine.SetRange("Document Line No.", "Sales Line"."Line No.");
                            if SalesCommentLine.FindSet() then
                                repeat
                                    if Comments = '' then
                                        Comments := SalesCommentLine.Comment
                                    else
                                        Comments += ', ' + SalesCommentLine.Comment;
                                until SalesCommentLine.Next() = 0;

                            Clear(TCSAmt1);
                            TCSAmt1 := GetAmount("Sales Line".RecordId);

                            CGSTPer := 0;
                            CGSTAmt := 0;
                            SGSTPer := 0;
                            SGSTAmt := 0;
                            IGSTPer := 0;
                            IGSTAmt := 0;
                            TaxAbleAmt := 0;
                            //  GrandTotal1 := 0;
                            if not GSTSetup.Get() then
                                exit;
                            // if ("Sales Line"."GST Group Code" <> '') and (."HSN/SAC Code" <> '') then begin
                            TaxTransactionValue.Reset();
                            TaxTransactionValue.SetRange("Tax Record ID", "Sales Line".RecordId);
                            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                            if GSTSetup."Cess Tax Type" <> '' then
                                TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
                            else
                                TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
                            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
                            if TaxTransactionValue.FindFirst() then
                                repeat
                                    if TaxTransactionValue."Value ID" = 2 then begin
                                        CGSTAmt += TaxTransactionValue.Amount;
                                        CGSTPer := TaxTransactionValue.Percent;
                                        TotalCGST += CGSTAmt;
                                        //TaxAbleAmt := Abs(TaxTransactionValue.am);
                                    end;
                                    if TaxTransactionValue."Value ID" = 6 then begin
                                        SGSTAmt += TaxTransactionValue.Amount;
                                        SGSTPer := TaxTransactionValue.Percent;
                                        TotalSGST += SGSTAmt;
                                        //TaxAbleAmt := Abs(TaxTransactionValue."GST Base Amount");
                                    end;

                                    if TaxTransactionValue."Value ID" = 3 then begin
                                        IGSTAmt += TaxTransactionValue.Amount * "LFS Custom Exch. Rate";
                                        IGSTPer := TaxTransactionValue.Percent;
                                        TotalIGST += IGSTAmt;
                                        // TaxAbleAmt := Abs(TaxTransactionValue."GST Base Amount");
                                    end;
                                //  TotalGSTAmt := Abs(CGSTAmt + SGSTAmt + IGSTAmt);
                                until TaxTransactionValue.Next() = 0;



                            // DetailedGSTLedgerEntry.Reset();
                            // DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                            // DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Line No.");
                            // DetailedGSTLedgerEntry.SETFILTER("Entry Type", '%1', DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
                            // IF DetailedGSTLedgerEntry.FIND('-') THEN
                            //     REPEAT
                            //         CASE DetailedGSTLedgerEntry."GST Component Code" OF
                            //             'CGST':
                            //                 BEGIN
                            //                     CGSTPer := DetailedGSTLedgerEntry."GST %";
                            //                     CGSTAmt += DetailedGSTLedgerEntry."GST Amount" * -1;
                            //                     TotalCGST += CGSTAmt;
                            //                     TaxAbleAmt := Abs(DetailedGSTLedgerEntry."GST Base Amount");
                            //                 END;
                            //             'SGST':
                            //                 BEGIN
                            //                     SGSTPer := DetailedGSTLedgerEntry."GST %";
                            //                     SGSTAmt += DetailedGSTLedgerEntry."GST Amount" * -1;
                            //                     TotalSGST += SGSTAmt;
                            //                     TaxAbleAmt := Abs(DetailedGSTLedgerEntry."GST Base Amount");
                            //                 END;
                            //             'IGST':
                            //                 BEGIN
                            //                     IGSTPer := DetailedGSTLedgerEntry."GST %";
                            //                     IGSTAmt += DetailedGSTLedgerEntry."GST Amount" * -1; //*"Sales Header"."Currency Factor";
                            //                     TotalIGST += IGSTAmt;
                            //                     TaxAbleAmt := Abs(DetailedGSTLedgerEntry."GST Base Amount");
                            //                 END;
                            //         END;
                            //     UNTIL DetailedGSTLedgerEntry.Next() = 0;
                            if "Sales Header"."Currency Code" <> '' then begin
                                InvLineRate := "Sales Line"."Unit Price" / "Sales Header"."Currency Factor";
                                InvLineLine_Discount := "Sales Line"."Line Discount Amount" / "Sales Header"."Currency Factor";
                                // TotalInvLineLine_Discount += "Sales Line"."Line Discount Amount" / "Sales Header"."Currency Factor";
                                // InvLineAmount := "Sales Line".Amount / "Sales Header"."Currency Factor";
                            end else begin
                                InvLineRate := "Sales Line"."Unit Price";
                                InvLineLine_Discount := "Sales Line"."Line Discount Amount";
                                // TotalInvLineLine_Discount += "Sales Line"."Line Discount Amount";
                                // InvLineAmount := "Sales Line".Amount;
                            end;

                            Clear(AuxUnitRateVar);
                            // if "LFS Custom Exch. Rate" <> 0 then
                            //     AuxUnitRateVar := "Sales Line"."Aux Unit Rate" * "Sales Line"."Custom Exch. Rate"
                            // else
                            //     AuxUnitRateVar := "Sales Line"."Aux Unit Rate";

                            InvLineAmount := AuxUnitRateVar * "Sales Line"."Line Amount";

                            // TotalInsurance += "Sales Line"."Insurance Value Per Type (LCY)";
                            // TotalFreight += "Sales Line"."Freight Value Per Type (LCY)";

                            TotalInvLineAmount += (InvLineAmount + IGSTAmt) - TotalInsurance - TotalFreight;
                            if SGSTPer <> 0 then
                                GSTRate := SGSTPer + CGSTPer;

                            if CGSTPer <> 0 then
                                GSTRate := CGSTPer + SGSTPer;

                            if IGSTPer <> 0 then
                                GSTRate := IGSTPer;
                            GrandTotal1 += IGSTAmt + CGSTAmt + SGSTAmt + "Sales Line".Amount;
                            GrandTotal := GrandTotal1 + TCSAmt1;

                            InitTextVariable();
                            FormatNoText(Notext1, GrandTotal, "Sales Header"."Currency Code");
                            TotalOfGSt += IGSTAmt + CGSTAmt + SGSTAmt;
                            // FormatNoText(Notext2, TotalOfGSt, "Sales Header"."Currency Code");
                            CurrancyCode := 'INR';
                            FormatNoText(Notext2, TotalOfGSt, CurrancyCode);

                            //Clear(TCSAmt);

                            CustLedgerEntry.Reset();
                            CustLedgerEntry.SetRange("Document No.", "Sales Line"."Document No.");
                            //CustLedgerEntry.SetRange("Posting Date", "Sales Header"."Posting Date");
                            CustLedgerEntry.SetRange("Customer No.", "Sales Line"."Sell-to Customer No.");
                            if CustLedgerEntry.FindFirst() then begin
                                CustLedgerEntry.CalcFields("Amount (LCY)");
                                CustLedEntAmtLCY := CustLedgerEntry."Amount (LCY)";
                            end;

                            // FormatNoText(Notext3, CustLedEntAmtLCY, "Sales Header"."Currency Code");
                            //CurrancyCode := 'INR';
                            FormatNoText(Notext3, TotalInvLineAmount, CurrancyCode);

                            Clear(SerialNo);
                            Clear(LotNo);
                            ValueEntry.SetRange("Document No.", "Sales Line"."Document No.");
                            ValueEntry.SetRange("Document Line No.", "Sales Line"."Line No.");
                            ValueEntry.SetRange("Item No.", "Sales Line"."No.");
                            ValueEntry.SetRange("Variant Code", "Sales Line"."Variant Code");
                            ValueEntry.SetRange("Location Code", "Sales Line"."Location Code");
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


                            HSNSAC.reset();
                            HSNSAC.setrange(Code, "HSN/SAC Code");
                            if HSNSAC.findfirst() then;


                        end;
                    }
                }
                trigger OnPreDataItem()
                begin
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
                        // IF Number = 1 THEN BEGIN
                        //     CopyText := 'Original For Buyer';
                        //     OutputNo += 1;
                        // END
                        // ELSE
                        //     IF Number = 2 THEN BEGIN
                        //         CopyText := 'Duplicate For Transporter';
                        //         OutputNo += 1;
                        //     END
                        //     ELSE
                        //         IF Number = 3 THEN BEGIN
                        //             CopyText := 'Triplicate For Assessee';
                        //             OutputNo += 1;
                        //         END
                        //         else
                        //             IF Number = 4 THEN BEGIN
                        //                 CopyText := 'Extra Copy';
                        //                 OutputNo += 1;
                        //             END
                        //             else
                        //                 IF Number = 5 THEN BEGIN
                        //                     CopyText := 'Extra Copy';
                        //                     OutputNo += 1;
                        //                 END
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
                    ELSE
                        IF RepTypeOpt = RepTypeOpt::"Original For Buyer" THEN BEGIN
                            CopyText := 'Original For Buyer';
                            OutputNo += 1;
                        END
                        ELSE
                            IF RepTypeOpt = RepTypeOpt::"Duplicate For Transporter" THEN BEGIN
                                OutputNo += 1;
                                CopyText := 'Duplicate For Transporter';
                            END
                            ELSE
                                IF RepTypeOpt = RepTypeOpt::"Triplicate For Assessee" THEN BEGIN
                                    CopyText := 'Triplicate For Assessee';
                                    OutputNo += 1;
                                END
                                ELSE
                                    IF RepTypeOpt = RepTypeOpt::"Extra Copy" THEN BEGIN
                                        CopyText := 'Extra Copy';
                                        OutputNo += 1;
                                    end;

                    CurrReport.PAGENO := 1;

                    TCSAmt := 0;
                    TcsPer := 0;
                    TCSENtry.SetRange("Document No.", "Sales Header"."No.");
                    if TCSENtry.FindSet() then
                        repeat
                            TCSAmt := TCSENtry."TCS Amount";
                            TotalTCSAmt += TCSENtry."TCS Amount";
                            TcsPer := TCSENtry."TCS %";
                        until TCSENtry.Next() = 0;
                end;
            }
            trigger OnAfterGetRecord()//Header
            var
                SalesLine: Record "Sales Line";
                IGSTNew, TotalFreight, TotalIGSTNew, TotalInsurance : Decimal;
            begin
                Clear(TotalItemQty);
                Clear(TotalGrossWeight);

                Clear(TotalInsurance);
                Clear(TotalFreight);
                Clear(TotalLineDicsAmt);

                SalesLine.Reset();
                SalesLine.SetRange("Document No.", "Sales Header"."No.");
                SalesLine.SetRange(Type, SalesLine.Type::Item);
                if SalesLine.FindSet() then
                    repeat
                        // TotalItemQty += SalesLine."Aux Qty";
                        TotalGrossWeight += SalesLine."Gross Weight";

                        TotalInsurance += SalesLine."LFS Insurance Value (LCY)";
                        TotalFreight += SalesLine."LFS Freight Value (LCY)";

                        if "Sales Header"."Currency Factor" <> 0 then
                            TotalLineDicsAmt += (SalesLine."Line Discount Amount" / "Sales Header"."Currency Factor")
                        else
                            TotalLineDicsAmt += SalesLine."Line Discount Amount";
                    until SalesLine.Next() = 0;

                IF LocationRec.GET("Sales Header"."Location Code") THEN;


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

                SalesLine.Reset();
                SalesLine.SetRange("Document No.", "Sales Header"."No.");
                SalesLine.SetRange(Type, SalesLine.Type::Item);
                if SalesLine.FindSet() then;
                SalesLine.CalcSums("LFS Insurance Value (LCY)");
                SalesLine.CalcSums("LFS Freight Value (LCY)");
                CustLedgerEntry.Reset();
                CustLedgerEntry.SetRange("Document No.", "Sales Header"."No.");
                //CustLedgerEntry.SetRange("Posting Date", "Sales Invoice Header"."Posting Date");
                CustLedgerEntry.SetRange("Customer No.", "Sales Header"."Sell-to Customer No.");
                if CustLedgerEntry.FindFirst() then begin
                    CustLedgerEntry.CalcFields("Amount (LCY)");
                    CustLedEntAmtLCY := CustLedgerEntry."Amount (LCY)" + IGSTNew - TotalInsurance - TotalFreight - TotalLineDicsAmt;
                end;


                //Get Data of Packing Type AND No. of Pack from Line Level Items+++
                //LFS-AS++ commented
                // SalesInvLine.Reset();
                // SalesInvLine.SetRange("Document No.", "Sales Header"."No.");
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
                // SalesInvLine.SetRange("Document No.", "Sales Header"."No.");
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
                // SalesInvLine.SetRange("Document No.", "Sales Header"."No.");
                // // SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
                // if SalesInvLine.FindSet() then begin
                //     repeat
                //         if "Sales Header"."Currency Code" <> '' then begin
                //             InvLineRate := SalesInvLine."Unit Price" / "Sales Header"."Currency Factor";
                //             InvLineLine_Discount := SalesInvLine."Line Discount Amount" / "Sales Header"."Currency Factor";
                //             InvLineAmount := SalesInvLine.Amount / "Sales Header"."Currency Factor";
                //         end;
                //     until SalesInvLine.Next() = 0;
                // end;
                //Get Sales Order No. and Order Date from line with no duplicate---


                //GET DATA FROM SHIP-TO-ADDRESS:
                if "Ship-to Code" <> '' then begin
                    ShipToAddressRec.SetRange(ShipToAddressRec.Code, "Ship-to Code");
                    ShipToAddressRec.SetRange(ShipToAddressRec."Customer No.", "Bill-to Customer No.");
                    if ShipToAddressRec.FindFirst() then begin
                        ShipToEmail := ShipToAddressRec."E-Mail";
                        //ShipToPhoneNo := ShipToAddressRec."Phone No.";
                        ShipToGSTNo := ShipToAddressRec."GST Registration No.";
                        // ShipToPanNo := ShipToAddressRec."P.A.N. No.";
                        ShipToContact := ShipToAddressRec.Contact;

                        // if Salutation.Get(ShipToAddressRec."Salutation Code") then
                        //     ShipToSalutationCode := Salutation.Description + '.';

                        if StateRec.Get(ShipToAddressRec.State) then begin
                            ShipToSateDesc := StateRec.Description;
                            stateCode := StateRec."State Code (GST Reg. No.)";
                        end;

                        if Country_Region.Get(ShipToAddressRec."Country/Region Code") then
                            ShipToCountryDecs := Country_Region.Name;

                    end;
                    //END;
                    //COMMENTED NOT NEEDED DATA FROM CUSTOMER TABLE+++
                end else
                    if "Ship-to Code" = '' then begin
                        customer.get("Bill-to Customer No.");
                        ShipToEmail := customer."E-Mail";
                        // IF not "Ship-to Code Modify" then
                        ShipToGSTNo := customer."GST Registration No.";
                        ShipToPhoneNo := customer."Phone No.";
                        ShipToPanNo := customer."P.A.N. No.";
                        if ContactRec3.Get(customer."Primary Contact No.") then begin
                            ShipToContact := ContactRec3.Name;
                            ShipToContactPhoneNo := ContactRec3."Phone No.";
                        end;

                        ContactRec.Reset();
                        ContactRec.SetRange("No.", "Sales Header"."Sell-to Contact No.");
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
                SalesCommentLine.SetRange("No.", "Sales Header"."No.");
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
                    // if "Sales Header"."Currency Code" <> '' then begin
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


                if Currency.get("Currency Code") then
                    // cu := Currency.Code
                    cu := Currency.Code
                else begin
                    GenLedSetup.Get();
                    cu := GenLedSetup."LCY Code";
                end;

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
                    ContactRec.SetRange("No.", "Sales Header"."Sell-to Contact No.");
                    if ContactRec.FindFirst() then
                        if Salutation.Get(ContactRec."Salutation Code") then
                            SellToSalutatioCode := Salutation.Description + '.';

                    Clear(SumQuantityLine);
                    SalesLine.Reset();
                    SalesLine.SetRange("Document No.", "Sales Header"."No.");
                    SalesLine.SetFilter("Gen. Prod. Posting Group", '<>%1', 'SERVICE');
                    SalesLine.SetFilter("No.", '<>%1', '30210');
                    if SalesLine.FindSet() then
                        repeat
                            SumQuantityLine += SalesLine.Quantity;
                        until SalesLine.Next() = 0;
                    // Crlf := TypeHelper.CRLFSeparator();
                    // CRLF[1] := 13;
                    // CRLF[1] := 10;
                    SR1 := 0;
                    TermsNumber := 1;
                    Clear(TermAndCondDescrip);
                    // TermAndCondition.Reset();
                    // TermAndCondition.SetRange("Source Type", TermAndCondition."Source Type"::Sales);
                    // TermAndCondition.SetRange("Source No.", "Sales Header"."No.");
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
                IF CustomerPostingGrpRec.Get("Sales Header"."Customer Posting Group") then begin
                    SalesLine.Reset();
                    SalesLine.SetRange("Document No.", "Sales Header"."No.");
                    SalesLine.SetRange("No.", CustomerPostingGrpRec."Invoice Rounding Account");
                    if SalesLine.FindFirst() then
                        RoundingAmt := SalesLine."Line Amount";
                end;

                User.Reset();
                User.SetRange(User."User Security ID", "Sales Header".SystemCreatedBy);
                if User.FindFirst() then
                    SystemCreatedByUser := User."User Name";
                if ShippingAgentServices.Get("Sales Header"."Shipping Agent Service Code") then;
                if ShippingAgent.Get("Sales Header"."Shipping Agent Code") then;
                Clear(Total_Pieces);
                SalesLineRec.Reset();
                SalesLineRec.SetRange("Document No.", "Sales Header"."No.");
                SalesLineRec.SetRange(SalesLineRec.Type, SalesLineRec.Type::Item);
                if SalesLineRec.FindSet() then
                    repeat
                    // Total_Pieces += SalesLineRec."No. of Pc";
                    until SalesLineRec.Next() = 0;

                PostedExportInfo.Reset();
                PostedExportInfo.SetRange("LFS Document No.", "Sales Header"."No.");
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
        GSTSetup: Record "GST Setup";
        HSNSAC: Record "HSN/SAC";
        HSNSACRec: Record "HSN/SAC";
        Item: Record Item;
        ILE: Record "Item Ledger Entry";
        LoactionRec: Record Location;
        LocationRec: Record Location;
        PaymentTerms: Record "Payment Terms";
        PostedExportInfo: Record "LFS Posted Export Information";
        SalesCommentLine: Record "Sales Comment Line";
        SalesInvLineRec: Record "Sales Invoice Line";
        SalesLineRec: Record "Sales Line";
        Salutation: Record Salutation;
        ShipToAddressRec: Record "Ship-to Address";
        ShipmentMethod: Record "Shipment Method";
        ShippingAgent: Record "Shipping Agent";
        ShippingAgentServices: Record "Shipping Agent Services";
        StateRec: Record State;
        TaxTransactionValue: Record "Tax Transaction Value";
        TCSENtry: Record "TCS Entry";
        TCSSetup: Record "TCS Setup";
        // TermAndCondition: Record "Terms and Conditions Trans";
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
        Total_Pieces: Decimal;
        TotalCGST: Decimal;
        TotalFreight, TotalInsurance : Decimal;
        TotalGrossWeight: Decimal;
        TotalIGST: Decimal;
        TotalInvLineAmount: Decimal;
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
        // PostedExportInfo.CalcFields("LFS Buyer Name & Address");
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

    local procedure GetAmount(RecID: RecordID): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        TCSSetup: Record "TCS Setup";
    begin
        if not TCSSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        TaxTransactionValue.SetRange("Tax Type", TCSSetup."Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if not TaxTransactionValue.IsEmpty() then
            TaxTransactionValue.CalcSums(Amount);

        exit(TaxTransactionValue.Amount);
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