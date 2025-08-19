report 72002 "Proform Invoice Export"
{
    ApplicationArea = All;
    Caption = 'Proform Invoice Export';
    DefaultLayout = RDLC;
    EnableHyperlinks = true;
    RDLCLayout = './SRC/Reports Layouts/Proform Invoice Export.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = WHERE("Document Type" = FILTER(Order));
            RequestFilterFields = "No.";

            column(PostingDate; FORMAT("Sales Header"."Posting Date", 0, '<Day,2>/<Month,02>/<Year4>')) { }
            column(BilltoName; "Bill-to Name") { }
            column(BilltoAddress; "Bill-to Address") { }
            column(Quote_No_; "Quote No.") { }
            column(VesselFlightNo; VesselFlightNo) { }
            column(QuoteDate; QuoteDate) { }
            column(Delivery_Load_Time; "Requested Delivery Date") { }
            column(Valid_Till; "Quote Valid Until Date") { }
            column(ShiptoCountry; ShiptoCountry) { }
            column(BilltoAddress2; "Bill-to Address 2") { }
            column(BilltoCity; "Bill-to City") { }
            column(Bill_to_Contact; ContactRec.Name) { }
            column(Bill_to_Contact_No_; "Bill-to Contact No.") { }
            column(Bill_to_Post_Code; "Bill-to Post Code") { }
            column(BillToCountry; BillToCountry) { }
            column(BillToEmail; 'E-mail Id : ' + BillToEmail) { }
            column(Customer_GST_Reg__No_; "Customer GST Reg. No.") { }
            column(ShiptoName; "Ship-to Name") { }
            column(ShiptoAddress; "Ship-to Address") { }
            column(ShiptoAddress2; "Ship-to Address 2") { }
            column(ShiptoCity; "Ship-to City") { }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code") { }
            column(ShiptoPostCode; ShiptoPostCode) { }
            column(ShiptoState; ShiptoState) { }
            column(ShiptoContactname; ShiptoContactname) { }
            column(Ship_to_Contact; "Ship-to Contact") { }
            column(ShiptoEmail; ShiptoEmail) { }
            column(ShipToGSTIN; ShipToGSTIN) { }
            column(Shipment_Method_Code; "Shipment Method Code") { }
            column(Pharmacopia_Code; '') { }
            column(PlaceofReceiptby; '') { }
            column(Inco_Terms; EXIMIncoTerms."LFS Description") { }
            column(Port_of_Discharge; "LFS Port of Discharge") { }
            column(Port_of_Loading; Port_of_Loading) { }
            column(Final_Destination1; "LFS Final Destination") { }
            column(ExternalDocumentNo; "External Document No.") { }
            column(No_SalesShipmentHeader; "No.") { }
            column(currencycode; "Currency Code") { }
            column(CountryofOriginofGoods; CountryofOrginofGoods) { }
            column(CountryofFinalDestination; "LFS Final Destination") { }
            // column(CountryofFinalDestination; CountryofFinalDestination)
            // {
            // }
            column(Port; PortofLoading) { }
            column(PortofDischarge; PortofDischarge) { }
            column(RepTypeOpt; RepTypeOpt) { }
            column(Comp_StateCode; recState1.Description) { }
            column(CompInfo_GSTIN; CompanyInformation."GST Registration No.") { }
            column(CompInfo_FaxNo; FaxNo) { }
            column(CompInfo_PhoneNo; 'Tel. No.:' + CompanyInformation."Phone No.") { }
            column(CompName; CompanyInformation.Name) { }
            column(CompAddr; CompanyInformation.Address) { }
            column(CompAddr2; CompanyInformation."Address 2") { }
            column(CompCity_State_PostCode_country; CompanyInformation.City + ', ' + ComInfoState + ', ' + CompCoutry + '-' + CompanyInformation."Post Code") { }
#pragma warning disable AL0432
            column(CompWEB; CompanyInformation."Home Page") { }
#pragma warning restore AL0432{}
            column(CompGSTNo; CompanyInformation."GST Registration No.") { }
            column(CompInfo_Picture; CompanyInformation.Picture) { }
            column(CompInfo_CIN; '') { }
            column(CompPANNo; CompanyInformation."P.A.N. No.") { }
            column(CompEmail; 'E-Mail : ' + CompanyInformation."E-Mail") { }
            column(CompaBankName; CompanyInformation."Bank Name") { }
            column(CompBankAcc; CompanyInformation."Bank Account No.") { }
            column(CompBankBranch; CompanyInformation."Bank Branch No.") { }
            column(CompIFSC; CompanyInformation."SWIFT Code") { }
            column(I_E_C_CODE; '') { }
            column(Invoice_To_StateCode; Invoice_To_StateCode) { }
            column(Invoice_To_State; Invoice_To_State) { }
            column(IEC; '') { }
            column(Druglic; '') { }
            column(factotsufffile; '') { }
            column(CIN_No; '') { }
            column(PAN_No; CompanyInformation."P.A.N. No.") { }
            column(comp_city; CompanyInformation.City) { }
            column(post_code; CompanyInformation."Post Code") { }
            column(CompInfo_PostCode; PostCode) { }
            column(CompInfo_Address2; CompanyInformation."Address 2") { }
            column(Comment_SalesShipmentHeader; Comment) { }
            column(CompInfo_Address; CompanyInformation.Address) { }
            column(city; City) { }
            column(CompInfo_Name; CompanyInformation.Name) { }
            column(ComInfo_Contact_No; CompanyInformation."Phone No.") { }
            column(ComInfo_E_Mail; CompanyInformation."E-Mail") { }
            column(AmountInWords1; NoText1[1] + ' ' + NoText1[2]) { }
            column(Insurance; ROUND(InsuranceAmt)) { }
            column(Freight; ROUND(FreihtAmt)) { }
            column(curencycode; currncycode) { }
            column(SalesHeader_PortofLoading; PortOFloading2) { }
            column(SalesHeader_PortofDischarge; PortofDischrg2) { }
            column(SalesHeader_FinalDestination; '') { }
            column(SalesHeader_CtyfGoods; CountryofOrginofGoods) { }
            column(SalesHeader_CtyfFinalDest; CountryofFinalDestination) { }
            column(SalesHeader_PaymentTermsCode; PaymentTerms.Code) { }
            column(Code_Loc; LocationRec.Code) { }
            column(Name_Loc; LocationRec.Name) { }
            column(OrderDate_SH; '') { }
            column(ETD_SH; ''/*FORMAT("Sales Header".ETD, 0, '<Day,2>/<Month,2>/<Year4>')*/) { }
            column(Address_Loc; LocationRec.Address + ', ' + LocationRec."Address 2") { }
            column(City_PostCode_Loc; LocationRec.City + ' ' + LocationRec."Post Code") { }
            column(Email_Loc; LocationRec."E-Mail") { }
            column(Phone_Loc; LocationRec."Phone No.") { }
            column(FaxNo_Loc; LocationRec."Fax No.") { }
            column(GSTNo_Loc; LocationRec."GST Registration No.") { }
            column(Precarriages; "LFS Pre Carriage") { }
            column(custombankaccount; BankAccount.Name) { }
            column(bankadd; BankAccount.Address + ' ' + BankAccount."Address 2" + ' ' + BankAccount.City + ' ' + BankAccount."Post Code") { }
            column(IncoTrem; "Sales Header"."LFS Inco Terms") { }
            column(modeoftransport; "Mode of Transport") { }
            column(AgentCommPer; '') { }
            column(AgentCode; AgentCode) { }
            column(SalesPerCode; SalesPerCode) { }
            column(ModeOf_Transport; SalesHeader."Mode of Transport") { }
            column(ShipmentDate; SalesHeader."Shipment Date") { }
            column(GST_ShipTo; SalesHeader."Ship-to GST Reg. No.") { }
            column(GST_BuyTo; SalesHeader."Customer GST Reg. No.") { }
            column(Delivery_Terms; TermsofDelivery) { }
            column(PO_Date; '') { }
            column(BankName; BankName) { }
            column(BankAccNo; BankAccNo) { }
            column(BankBranchNo; BankBranchAddress) { }
            column(IFSCcode; IFSCcode) { }
            column(BankSwift; BankSwift) { }
            column(InterBankAccName; BankAccRec.Name) { }
            column(InterBankAccNo; BankAccRec."Bank Account No.") { }
            column(InterBankAccSwift; BankAccRec."SWIFT Code") { }
            column(InterBankAccAddress; BankAccRec.Address + ', ' + BankAccRec."Address 2") { }
            column(Notify_Party; '') { }
            column(statename; statename) { }
            column(countryname; countryname) { }
            column(paymenttermname; paymenttermname) { }
            column(ManLicTax; ManLicTax) { }
            column(AmountInWords2; NoText2[1] + ' ' + NoText2[2]) { }
            column(ComInfo_Name; CompanyInformation.Name) { }
            column(ComInfo_Address; CompanyInformation.Address) { }
            column(ComInfo_Address_2; CompanyInformation."Address 2") { }
            column(ComInfo_City; CompanyInformation.City) { }
            column(ComInfo_State_Code; ComInfoState) { }
            column(ComInfo_County; CompanyInformation.County) { }
            column(ComInfo_Post_Code; CompanyInformation."Post Code") { }
            column(Sell_to_Contact; "Sell-to Contact") { }
            column(BilltoContactNo; BilltoContactNo) { }
            column(BillToState; BillToState) { }
            column(ShiptoContactNo; ShiptoContactNo) { }
            column(SalesHeaderComment; SalesHeaderComment) { }
            column(CustomerOrderNo; "External Document No.") { }
            column(CustomerOrderDate; '') { }
            column(DateOfSupply; "Posting Date") { }
            column(Address; Address) { }
            column(Address2; Address2) { }
            column(City1; City) { }
            column(PostCode; PostCode) { }
            column(StateCode; StateCode) { }
            column(CountryCode; CountryCode) { }
            column(Email; 'E-Mail Id-' + Email) { }
            column(Invoice_To_GSTIN; Invoice_To_GSTIN) { }
            column(Invoice_To_Post_Code; Invoice_To_Post_Code) { }
            column(Invoice_To_Email; Invoice_To_Email) { }
            column(Invoice_To_Country; Invoice_To_Country) { }
            column(Invoice_To_Contact; Invoice_To_Contact) { }
            column(Shipping_Agent_Service_Code; Shipping_Agent_Service_Code) { }
            column(Shipment_Date; "Shipment Date") { }
            column(Payment_Terms_Code; paymenttermname) { }
            column(Charge_Amt_TRN; Charge_Amt_TRN) { }
            column(SystemCreatedBy; SystemCreatedByUser) { }
            column(TermAndCondDescrip; TermAndCondDescrip) { }
            column(TermAndCondDescripTechnical; TermAndCondDescripTechnical) { }
            column(TermAndCondDescripLogistics; TermAndCondDescripLogistics) { }
            column(Cust_phone; customer."Phone No.") { }
            column(Company_Bank_Account_Code; "Company Bank Account Code") { }
            column(Work_Description; WorkDescriptionAsText) { }
            column(FooterCompanyAddress; CompanyInformation.Address + ', ' + CompanyInformation."Address 2" + ', ' + CompanyInformation.City + ', ' + CompanyStateDesc + ', ' + CountryRegionDesc + '-' + CompanyInformation."Post Code") { }
#pragma warning disable AL0432
            column(FooterAddress2; 'Tel No.: ' + CompanyInformation."Phone No." + ' | E-Mail : ' + CompanyInformation."E-Mail" + ' | ' + 'Website: ' + CompanyInformation."Home Page") { }
#pragma warning restore AL0432{}
            column(FooterCompanyAddressHO; LocationHO.Address + ', ' + LocationHO."Address 2" + ', ' + LocationHO.City + ', ' + LocationStateDescHO + ', ' + Loc_CountryRegionDescHO + '-' + LocationHO."Post Code") { }
#pragma warning disable AL0432
            column(FooterAddress2HO; 'Tel No.: ' + LocationHO."Phone No." + ' | E-Mail: ' + LocationHO."E-Mail" + Crlf + 'Website: ' + LocationHO."Home Page" + '/www.mehtatubes.com') { }
#pragma warning restore AL0432{}
            column(LCY_Currency_Code; GenLedgSetup."LCY Code") { }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = field("No."),
                               "Document Type" = field("Document Type");
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.") order(ascending);
                column(Type; Type) { }
                column(LengthCalculate; LengthCalculate)
                {

                }
                column(Length_mtr_pc_; '')
                {

                }
                column(Length_feet_pc_; '')
                {

                }
                column(Length_mm_pc_; '')
                {

                }
                column(Rate_Per_Kg; '')
                {

                }
                column(Rate_per_Feet; '')
                {

                }
                column(Rate_per_Lbs; '')
                {

                }
                column(Rate_per_Mtr; '')
                {

                }
                column(Rate_per_Pc; '')
                {
                }
                column(Print_Rate_KG; Print_Rate_KG)
                {

                }
                column(Print_Length_Mtr; Print_Length_Mtr)
                {
                }
                column(HSN_SAC_Code; "HSN/SAC Code")
                {
                }
                column(CGSTPer; CGSTPer)
                {
                }
                column(CGSTAmt; ABS(CGSTAmt))
                {
                }
                column(SGSTPer; SGSTPer)
                {
                }
                column(SGSTAmt; ABS(SGSTAmt))
                {
                }
                column(IGSTAmt; ABS(IGSTAmt))
                {
                }
                column(IGSTPer; IGSTPer)
                {
                }
                column(Specification_Code; '')
                {

                }
                column(FOB_Igst; FOB_Igst)
                {
                }
                column(FOB_CurrValue; FOB_CurrValue)
                {
                }
                column(Curr_Factor; Curr_Factor)
                {
                }
                column(TotalValue_INR; TotalValue_INR)
                {
                }
                column(FOB_Value; FOB_Value)
                {
                }
                column(Marks; Marks)
                {
                }
                column(Pallet; Pallet)
                {
                }
                column(FromPallet; FromPallet)
                {
                }
                column(ToPallet; ToPallet)
                {
                }
                column(ExpDate; ExpDate)
                {
                }
                column(NettWeight; NettWeight)
                {
                }
                column(GrossWeight; GrossWeight)
                {
                }
                column(Amount_CIF; Amount_CIF)
                {
                }
                column(AmountINUSD; AmountINUSD)
                {
                }
                column(TotalAmount; TotalAmount)
                {
                }
                column(NetWeight; "Variant Code")
                {
                }
                column(Gross_Weight; "Gross Weight")
                {
                }
                column(Liscnceno; '')
                {
                }
                column(Description; Description)
                {
                }
                column(Description2; "Description 2")
                {
                }
                column(HSNSACCode; "HSN/SAC Code")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(UnitofMeasureCode; "Unit of Measure Code")
                {
                }
                column(UnitPrice; "Sales Line"."Unit Price")
                {
                }
                column(NetWeight1; "Net Weight")
                {
                }
                column(Grossweight1; "Gross Weight")
                {
                }
                column(itemno; "No.")
                {
                }
                column(LineAmount; "Line Amount")
                {
                }
                column(SrNo; SrNo)
                {
                }
                column(lisctype; '')
                {
                }
                column(ExmptedMet; ExmptedMet)
                {
                }
                column(AdvLicissuedate; '')
                {
                }
                column(noofbags; noofbags)
                {
                }
                column(UNITPER; Item_Rec."Units per Parcel")
                {
                }
                column(lot; Lot)
                {
                }
                column(ARNno; '')
                {
                }
                column(containner; '')
                {
                }
                column(UOM; "Unit of Measure Code")
                {

                }
                column(mfgdate; '')
                {
                }
                column(NumInWords1; Notext[1])
                {
                }
                column(NumInWords2; Notext[2])
                {
                }
                column(RemittanceAmntInWords; RemittanceAmntInWords) { }
                column(EXIMRemark_SalesLine; '')
                {
                }
                column(LineAmount_SalesLine; "Sales Line"."Line Amount")
                {
                }
                column(ShippingBillNo; '')
                {
                }
                column(ShippingBillDate; '')
                {
                }
                column(LineAmtTax; LineAmtTax)
                {
                }
                column(TotalLineamt; "Line Amount")
                {
                }
                column(FreightAmount; FreightAmount)
                {
                }
                column(InsuranceAmount; InsuranceAmount)
                {
                }
                column(AdvLiceNo; AdvLiceNo)
                {
                }
                column(IncentiveType_; '')
                {
                }
                column(ClaimDDB_; '')
                {
                }
                column(FreightAmt; FreightAmt)
                {
                }
                column(PackingAmt; PackingAmt)
                {
                }
                column(GSTAmt; GSTAmt)
                {
                }
                column(BCDAmt; BCDAmt)
                {
                }
                column(SWCAmt; SWCAmt)
                {
                }
                column(EDCAmt; EDCAmt)
                {
                }
                column(Final_destination; GSTStateCode)
                {
                }
                column(GSTRegNo; GSTRegNo)
                {
                }
                column(Pharmacopoeia; '')
                {
                }
                column(TotalAmtIncTax; TotalAmtIncTax)
                {
                }
                column(TCSAmt; ROUND(TCSAmt, 1))
                {
                }
                column(Aux_UOM; '')
                {

                }
                column(Aux_Qty; '')
                {

                }
                column(Aux_Unit_Rate; '')
                {

                }
                column(Aux_Amount; '')
                {

                }
                column(No__of_Pc; '')
                {

                }
                column(Item_Temper_Code; '')
                {

                }
                column(OD_inch_; '')
                {

                }
                column(Thickness_inch_; '')
                {

                }
                column(Wt_feet; '')
                {

                }
                column(Wt_Pc; '')
                {

                }
                column(ItemDescription; ItemDescription)
                {

                }
                column(Item_Reference_No_; "Item Reference No.")
                {

                }
                column(Net_Weight; "Net Weight")
                {

                }
                trigger OnAfterGetRecord();
                begin
                    Clear(MinAverageTxt);
                    // if "Sales Line".Type = "Sales Line".Type::Item then
                    //     if "Sales Line".MinAverage = "Sales Line".MinAverage::Average then
                    //         MinAverageTxt := ' - Avg'
                    //     else
                    //         MinAverageTxt := ' - Min';
                    // Clear(ItemDescription);
                    // ItemDescription := "Sales Line".Description + ' ' + MinAverageTxt + ', ' + FORMAT("Sales Line"."Specification Code") + 'TYPE : ' + FORMAT("Sales Line"."Item Type") + ', TEMPER : ' + FORMAT("Sales Line"."Item Temper Code") + ', Length : ' + FORMAT(Round("Sales Line"."Length(feet/pc)", 0.001)) + ' Feet(1PC) -' + FORMAT("Sales Line"."No. of Pc") + 'PCS (' + FORMAT("Sales Line".Quantity) + 'KG)';
                    // if Print_Length_Mtr = Print_Length_Mtr::"Length(feet)" then
                    //     LengthCalculate := "Sales Line"."Length(feet/pc)";
                    // if Print_Length_Mtr = Print_Length_Mtr::"Length(mm)" then
                    //     LengthCalculate := "Sales Line"."Length(mm/pc)";
                    // if Print_Length_Mtr = Print_Length_Mtr::"Length(mtr)" then
                    //     LengthCalculate := "Sales Line"."Length(mtr/pc)";
                    //IF "Sales Line".Type <> "Sales Line".Type::Item THEN
                    //CurrReport.SKIP;
                    ItemandVariant := "Sales Line"."No." + "Sales Line"."Variant Code";

                    //FOB_Value :=TotalLineamt;LFS-YJ
                    IF "Sales Header"."Currency Factor" <> 0 THEN
                        Curr_Factor := (1 / ("Sales Header"."Currency Factor"))
                    ELSE
                        Curr_Factor := 1;
                    FOB_CurrValue := FOB_Value * Curr_Factor;

                    TotalValue_INR := FOB_CurrValue + FOB_Igst;

                    TotalValue_INR := ROUND(TotalValue_INR, 0.01);



                    // CRLF[1] := 13;
                    // CRLF[1] := 10;
                    SR1 := 0;
                    CLEAR(Marks);
                    SalesCommentLine.Reset();
                    SalesCommentLine.SETRANGE("No.", "Sales Line"."Document No.");
                    SalesCommentLine.SETRANGE("Document Line No.", "Sales Line"."Line No.");
                    IF SalesCommentLine.FindFirst() then
                        REPEAT
                            IF SR1 > 0 THEN
                                Marks := Marks + CRLF + SalesCommentLine.Comment
                            ELSE
                                Marks := Marks + SalesCommentLine.Comment;
                            SR1 += 1;
                        UNTIL SalesCommentLine.Next() = 0;

                    Pallet := 0;
                    FromPallet := 0;
                    ToPallet := 0;
                    noofbags := 0;
                    TotalAmount := 0;
                    LineAmtTax := 0;

                    Item_Rec.Reset();
                    Item_Rec.SETRANGE("No.", "Sales Line"."No.");
                    IF Item_Rec.FindFirst() then
                        ExpDate := FORMAT(Item_Rec."Expiration Calculation");
                    Expdate1 := DELCHR(FORMAT(ExpDate), '<>', '1234567890');
                    CASE Expdate1 OF
                        'M':
                            ExpDate := FORMAT(ExpDate) + ' Months from the MFG date';
                        'Y':
                            ExpDate := FORMAT(ExpDate) + ' Years from the MFG date';
                        'D':
                            ExpDate := FORMAT(ExpDate) + ' Days from the MFG date';
                    END;

                    UnitPrice2 := 0;
                    CLEAR(FreightAmount);
                    CLEAR(InsuranceAmount);
                    FreightAmount := GetStrAmount('300201');
                    InsuranceAmount := GetStrAmount('300202');

                    CLEAR(AdvLiceNo);
                    SalesLine.Reset();
                    SalesLine.SETRANGE("Document No.", "Sales Line"."Document No.");
                    SalesLine.SETRANGE("Line No.", "Sales Line"."Line No.");
                    IF SalesLine.FindSet() then
                        REPEAT
                        UNTIL SalesLine.Next() = 0;


                    if not GSTSetup.Get() then
                        exit;

                    if "Sales Line".Type <> "Sales Line".Type::" " then begin
                        if ("Sales Line"."GST Group Code" <> '') and ("Sales Line"."HSN/SAC Code" <> '') then begin
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
                    end;

                    TaxTransactionValue.SetRange("Tax Record ID", "Sales Line".RecordId);
                    TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                    TaxTransactionValue.SetRange("Tax Type", 'TCS');
                    TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
                    if TaxTransactionValue.FindSet() then
                        repeat
                            TCSAmt += TaxTransactionValue.Amount;
                        until TaxTransactionValue.Next() = 0;

                    // TotalLineAmt += "Aux Amount";

                    TotalAmtIncTaxWords := TotalLineAmt + Charge_Amt_TRN + FreightAmt + TCSAmt; //TotalAmtIncTax ;

                    InitTextVariable;
                    FormatNoText(Notext, Abs(TotalAmtIncTaxWords), "Sales Header"."Currency Code");
                    RemittanceAmntInWords := Notext[1] + Notext[2];
                end;

                trigger OnPostDataItem();
                begin

                    Clear(CGSTAmt);
                    Clear(IGSTAmt);
                    Clear(SGSTAmt);
                    Clear(IGSTPer);
                    Clear(SGSTPer);
                    Clear(CGSTPer);
                    CLEAR(TotalLineamt);
                end;

                trigger OnPreDataItem();
                begin
                    SrNo := 0
                end;
            }

            trigger OnAfterGetRecord();
            var
                SalesLine: Record "Sales Line";
            begin
                if ContactRec.Get("Sales Header"."Sell-to Contact No.") then;
                if ExportInformation.get("Sales Header"."No.", "Sales Header"."Document Type") then;
                RecState.Reset();
                RecState.SETRANGE(Code, CompanyInformation."State Code");
                IF RecState.FindFirst() then;
                ComInfoState := RecState.Description;
                CountryRegion4.Reset();
                CountryRegion4.SetRange(Code, CompanyInformation."Country/Region Code");
                if CountryRegion4.FindFirst() then
                    CompCoutry := CountryRegion4.Name;
                IF "Sales Header"."Currency Code" <> '' THEN
                    currncycode := "Sales Header"."Currency Code"
                ELSE
                    currncycode := 'INR';

                Contact.Reset();
                Contact.SetRange("No.", "Bill-to Contact No.");
                if Contact.FindFirst() then
                    BilltoContactNo := Contact."Phone No.";


                BankAcc.Reset();
                BankAcc.SETRANGE("No.", "Sales Header"."LFS Customs Bank Account");
                IF BankAcc.FindFirst() then BEGIN
                    BankName := BankAcc.Name;
                    BankAccNo := BankAcc."Bank Account No.";
                    BankBranchAddress := BankAcc.Address + ' ' + BankAcc."Address 2" + ' ' + BankAcc.City;
                    BankSwift := BankAcc."SWIFT Code";
                    IFSCcode := BankAcc."IFSC Code";
                END;

                BankAccRec.Reset();
                BankAccRec.SETRANGE("No.", "Sales Header"."Company Bank Account Code");
                IF BankAccRec.FindFirst() then;
                SaleheaderAchive.Reset();
                SaleheaderAchive.SetRange("No.", "Quote No.");
                if SaleheaderAchive.FindFirst() then
                    QuoteDate := SaleheaderAchive."Document Date";

                ShiptoAddress.Reset();
                ShiptoAddress.SetRange(Code, "Sales Header"."Ship-to Code");
                ShiptoAddress.SetRange("Customer No.", "Sales Header"."Sell-to Customer No.");
                if ShiptoAddress.FindFirst() then begin
                    ShiptoPostCode := ShiptoAddress."Post Code";
                    ShiptoEmail := ShiptoAddress."E-Mail";
                    ShipToGSTIN := ShiptoAddress."GST Registration No.";
                    State1.reset();
                    State1.SetRange(Code, ShiptoAddress.State);
                    if State1.FindFirst() then
                        ShiptoState := State1.Description;
                    CountryReg.Reset();
                    CountryReg.SetRange(Code, ShiptoAddress."Country/Region Code");
                    if CountryReg.FindFirst() then begin
                        ShiptoCountry := CountryReg.Name;
                    end;
                    ShiptoContactNo := ShiptoAddress."Phone No.";
                    ShiptoContactname := ShiptoAddress.Contact;
                end
                else begin
                    customer.GET("Sales Header"."Sell-to Customer No.");
                    ShiptoEmail := customer."E-Mail";
                    ShiptoPostCode := customer."Post Code";
                    ShiptoContactNo := customer."Phone No.";
                    ShiptoContactname := customer.Contact;
                    State1.reset();
                    State1.SetRange(Code, customer."State Code");
                    if State1.FindFirst() then
                        ShiptoState := State1.Description;
                    CountryReg.Reset();
                    CountryReg.SetRange(Code, ShiptoAddress."Country/Region Code");
                    if CountryReg.FindFirst() then begin
                        ShiptoCountry := CountryReg.Name;
                    end;

                end;
                Customer1.Reset();
                Customer1.SetRange("No.", "Bill-to Customer No.");
                if Customer1.FindFirst() then begin
                    BillToEmail := Customer1."E-Mail";
                    CountryRegion2.Reset();
                    CountryRegion2.SetRange(Code, Customer1."Country/Region Code");
                    if CountryRegion2.FindFirst() then begin
                        BillToCountry := CountryRegion2.Name;
                    end;
                end;
                PaymentTerms.SETRANGE(Code, "Sales Header"."Payment Terms Code");
                IF PaymentTerms.FindFirst() then;

                IF "Sales Header"."GST Ship-to State Code" <> '' THEN
                    GSTStateCode := "Sales Header"."GST Ship-to State Code"
                ELSE
                    GSTStateCode := "Sales Header"."GST Bill-to State Code";

                CLEAR(GSTRegNo);
                IF "Sales Header"."Ship-to GST Reg. No." <> '' THEN
                    GSTRegNo := "Sales Header"."Ship-to GST Reg. No."
                ELSE
                    GSTRegNo := "Sales Header"."Customer GST Reg. No.";


                IF PaymentTerms.GET("Sales Header"."Payment Terms Code") THEN
                    paymenttermname := PaymentTerms.Description;

                IF RecState.GET(CompanyInformation."State Code") THEN
                    statename := RecState.Description;

                customer.GET("Sales Header"."Sell-to Customer No.");
                ManLicTax := customer."Registration Number";
                ShipToGSTIN := customer."GST Registration No.";

                IF CountryRegion.GET(CompanyInformation."Country/Region Code") THEN
                    countryname := CountryRegion.Name;

                IF Location.GET("Location Code") THEN BEGIN
                    Address := Location.Address;
                    Address2 := Location."Address 2";
                    City := Location.City;
                    if State2.Get(Location."State Code") then
                        StateCode := State2.Description;
                    if CountryRegion2.Get(Location."Country/Region Code") then
                        CountryCode := CountryRegion2.Name;
                    PostCode := Location."Post Code";
                    PhNo := Location."Phone No.";
                    Email := Location."E-Mail";
                    Invoice_To_Contact := Location."Phone No.";
                    FaxNo := Location."Fax No.";
                    recState1.Reset();
                    IF recState1.GET(Location."State Code") THEN begin
                        Invoice_To_State := recState1.Description;
                        Invoice_To_StateCode := recState1."State Code (GST Reg. No.)";
                    end;

                    CountryRegion4.Reset();
                    CountryRegion4.SetRange(Code, Location."Country/Region Code");
                    if CountryRegion4.FindFirst() then
                        Invoice_To_Country := CountryRegion4.Name;
                    Invoice_To_Email := Location."E-Mail";
                    Invoice_To_GSTIN := Location."GST Registration No.";
                    Invoice_To_Post_Code := Location."Post Code";
                END;


                FreihtAmt := 0;
                SalesLine.Reset();
                SalesLine.SETRANGE(SalesLine."Document No.", "Sales Header"."No.");//LFS-YJ
                IF SalesLine.FindSet() then
                    REPEAT

                    UNTIL SalesLine.Next() = 0;

                InsuranceAmt := 0;
                SalesLine.Reset();
                SalesLine.SETRANGE(SalesLine."Document No.", "Sales Header"."No.");//LFS-YJ
                IF SalesLine.FindSet() then
                    REPEAT
                    UNTIL SalesLine.Next() = 0;
                IF LocationRec.GET("Sales Header"."Location Code") THEN;

                CLEAR(TotallFOBValue);
                CLEAR(TotalCIFValue);
                SalesLine.Reset();
                SalesLine.SETRANGE(SalesLine."Document No.", "Sales Header"."No.");//LFS-YJ
                SalesLine.SETRANGE("Document Type", "Sales Header"."Document Type");
                SalesLine.SETFILTER(Type, '%1', SalesLine.Type::Item);
                IF SalesLine.FindSet() then
                    REPEAT
                        TotallFOBValue += SalesLine.Quantity * SalesLine."Unit Price";
                    UNTIL SalesLine.Next() = 0;

                CLEAR(SalesLineAmt);
                CLEAR(TCSAmt);
                SalesLine.Reset();
                SalesLine.SETRANGE("Document No.", "Sales Header"."No.");
                IF SalesLine.FindSet() then
                    REPEAT
                        SalesLineAmt += SalesLine.Amount;
                    UNTIL SalesLine.Next() = 0;

                Crlf := TypeHelper.CRLFSeparator();
                SalesCommentLine1.Reset();
                SalesCommentLine1.SetRange("Document Type", "Sales Header"."Document Type");
                SalesCommentLine1.SetRange("No.", "Sales Header"."No.");
                SalesCommentLine1.SetRange("Document Line No.", 0);
                if SalesCommentLine1.FindSet() then
                    repeat
                        SalesHeaderComment += SalesCommentLine1.Comment + Crlf;
                    until SalesCommentLine1.Next() = 0;
                Salesperson.Reset();
                Salesperson.SetRange(Code, "Sales Header"."Salesperson Code");
                if Salesperson.FindFirst() then
                    SalesPerCode := Salesperson.Name;
                ShippingAgent.Reset();
                ShippingAgent.SetRange(Code, "Sales Header"."Shipping Agent Code");
                if ShippingAgent.FindFirst() then
                    AgentCode := ShippingAgent.Name;
                State2.Reset();
                State2.SetRange(Code, "GST Bill-to State Code");
                if State2.FindFirst() then
                    BillToState := State2.Description;
                RecSaleSLine.Reset();
                RecSaleSLine.SetRange("Document No.", "Sales Header"."No.");
                RecSaleSLine.SetRange("Document Type", "Sales Header"."Document Type");
                RecSaleSLine.SetRange(Type, RecSaleSLine.Type::"Charge (Item)");
                if RecSaleSLine.FindSet() then
                    repeat
                        if RecSaleSLine."No." = 'TRN' then
                            Charge_Amt_TRN := RecSaleSLine."Line Amount";
                    until RecSaleSLine.Next() = 0;
                // CRLF[1] := 13;
                // CRLF[1] := 10;
                SR1 := 0;
                Number1 := 1;
                Clear(TermAndCondDescrip);
                // TermAndCondition.Reset();
                // TermAndCondition.SetRange("Source Type", TermAndCondition."Source Type"::Sales);
                // TermAndCondition.SetRange("Source No.", "Sales Header"."No.");
                // TermAndCondition.SetRange("Technical Notes", false);
                // TermAndCondition.SetRange("Logistics and Dispatch Notes", false);
                // if TermAndCondition.FindSet() then
                //     repeat
                //         IF SR1 > 0 THEN
                //             TermAndCondDescrip := TermAndCondDescrip + CRLF + Format(Number1) + '. ' + TermAndCondition.Description
                //         ELSE
                //             TermAndCondDescrip := TermAndCondDescrip + Format(Number1) + '. ' + TermAndCondition.Description;
                //         SR1 += 1;
                //         Number1 += 1;
                //     until TermAndCondition.Next() = 0;

                //Technical Term
                SR2 := 0;
                Number2 := 1;
                Clear(TermAndCondDescripTechnical);
                // TermAndCondition.Reset();
                // TermAndCondition.SetRange("Source Type", TermAndCondition."Source Type"::Sales);
                // TermAndCondition.SetRange("Source No.", "Sales Header"."No.");
                // TermAndCondition.SetRange("Technical Notes", true);
                // if TermAndCondition.FindSet() then
                //     repeat
                //         IF SR2 > 0 THEN
                //             TermAndCondDescripTechnical := TermAndCondDescripTechnical + CRLF + Format(Number2) + '. ' + TermAndCondition.Description
                //         ELSE
                //             TermAndCondDescripTechnical := TermAndCondDescripTechnical + Format(Number2) + '. ' + TermAndCondition.Description;
                //         SR2 += 1;
                //         Number2 += 1;
                //     until TermAndCondition.Next() = 0;
                //logistics t&c
                //Technical Term
                SR3 := 0;
                Number3 := 1;
                Clear(TermAndCondDescripLogistics);
                // TermAndCondition.Reset();
                // TermAndCondition.SetRange("Source Type", TermAndCondition."Source Type"::Sales);
                // TermAndCondition.SetRange("Source No.", "Sales Header"."No.");
                // TermAndCondition.SetRange("Logistics and Dispatch Notes", true);
                // if TermAndCondition.FindSet() then
                //     repeat
                //         IF SR3 > 0 THEN
                //             TermAndCondDescripLogistics := TermAndCondDescripLogistics + CRLF + Format(Number3) + '. ' + TermAndCondition.Description
                //         ELSE
                //             TermAndCondDescripLogistics := TermAndCondDescripLogistics + Format(Number3) + '. ' + TermAndCondition.Description;
                //         SR3 += 1;
                //         Number3 += 1;
                //     until TermAndCondition.Next() = 0;
                if EXIMIncoTerms.Get("Sales Header"."LFS Inco Terms") then;
                ShippingAgentServices.Reset();
                ShippingAgentServices.SetRange("Shipping Agent Code", "Sales Header"."Shipping Agent Code");
                if ShippingAgentServices.FindFirst() then
                    Shipping_Agent_Service_Code := ShippingAgentServices.Description;
                User.Reset();
                User.SetRange(User."User Security ID", "Sales Header".SystemCreatedBy);
                if User.FindFirst() then
                    SystemCreatedByUser := User."User Name";
                CountryRegion4.Reset();
                CountryRegion4.SetRange(Code, "Sales Header"."LFS Final Destination");
                if CountryRegion4.FindFirst() then
                    CountryofFinalDestination := CountryRegion.Name;
                CountryRegion4.Reset();
                CountryRegion4.SetRange(Code, "Sales Header"."LFS Country Origin Goods");
                if CountryRegion4.FindFirst() then
                    CountryofOrginofGoods := CountryRegion.Name;
                EXIMPort.Reset();
                EXIMPort.SetRange("LFS Code", "Sales Header"."LFS Port of Discharge");
                if EXIMPort.FindFirst() then
                    PortofDischarge := EXIMPort."LFS Port Name";
                EXIMPort.Reset();
                EXIMPort.SetRange("LFS Code", "Sales Header"."LFS Port of Loading");
                if EXIMPort.FindFirst() then
                    Port_of_Loading := EXIMPort."LFS Port Name";
                if "Sales Header"."Work Description".HasValue then begin
                    TempBlob.CreateOutStream(OutStr);
                    "Sales Header".CalcFields("Work Description");
                    "Sales Header"."Work Description".CreateInStream(InStr);
                    InStr.ReadText(WorkDescText);
                    WorkDescriptionAsText := WorkDescText;
                end;

                // LocationHO.SetRange(HO, true);
                // IF LocationHO.FindFirst() then;

                StateRec.Reset();
                if StateRec.Get(LocationHO."State Code") then begin
                    LocationStateDescHO := StateRec.Description;
                    CompanyStateCodeHO := StateRec."State Code (GST Reg. No.)";
                end;

                Country_Region.Reset();
                if Country_Region.Get(LocationHO."Country/Region Code") then
                    Loc_CountryRegionDescHO := Country_Region.Name;

                Clear(CountryRegionDesc);
                //COUNTRY DESC FROM COMPANY INFO+++
                Country_Region.Reset();
                if Country_Region.Get(CompanyInformation."Country/Region Code") then
                    CountryRegionDesc := Country_Region.Name;
                //COUNTRY DESC FROM COMPANY INFO---


                Clear(companyStateDesc);
                Clear(CompanyStateCode);
                //State Code & DESC FROM COMPANY INFO+++
                StateRec.Reset();
                if StateRec.Get(CompanyInformation."State Code") then begin
                    CompanyStateDesc := StateRec.Description;
                    CompanyStateCode := StateRec."State Code (GST Reg. No.)";
                end;

                if GenLedgSetup.Get() then;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {

                field(Print_Length_Mtr; Print_Length_Mtr)
                {
                    ApplicationArea = All;
                    Caption = 'Print Length(Mtr)';
                    ToolTip = 'Specifies the value of the Print Length(Mtr) field.';
                }
                field(Print_Rate_KG; Print_Rate_KG)
                {
                    ApplicationArea = All;
                    Caption = 'Print Rate(KG)';
                    ToolTip = 'Specifies the value of the Print Rate(KG) field.';
                    Visible = false;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        CompanyInformation.Get();
        CompanyInformation.CALCFIELDS(Picture);
    end;

    var
        BankAcc: Record "Bank Account";
        BankAccount: Record "Bank Account";
        BankAccRec: Record "Bank Account";

        CompanyInformation: Record "Company Information";
        Contact: Record Contact;
        Contact1: Record Contact;
        ContactRec: Record Contact;
        Country_Region: Record "Country/Region";
        CountryReg: Record "Country/Region";
        CountryRegion: Record "Country/Region";
        CountryRegion2: Record "Country/Region";
        CountryRegion4: record "Country/Region";
        customer: Record Customer;
        Customer1: Record Customer;

        EXIMIncoTerms: Record "LFS EXIM Inco Terms";
        EXIMPort: Record "LFS EXIM Port";
        ExportInformation: Record "LFS Export Information Header";
        GenLedgSetup: Record "General Ledger Setup";
        GSTSetup: Record "GST Setup";
        Item: Record Item;
        Item_Rec: Record Item;
        ItemVariant: Record "Item Variant";
        Location: Record Location;
        Location1: Record Location;
        LocationHO: Record Location;
        LocationRec: Record Location;
        PaymentTerms: Record "Payment Terms";
        PostCode1: Record "Post Code";
        SalesCommentLine: Record "Sales Comment Line";
        SalesCommentLine1: Record "Sales Comment Line";
        SalesHeader: Record "Sales Header";
        SaleheaderAchive: Record "Sales Header Archive";
        RecSaleSLine: Record "Sales Line";
        SalesLine: Record "Sales Line";
        SalesLineRec: Record "Sales Line";
        Salesperson: Record "Salesperson/Purchaser";
        ShiptoAddress: Record "Ship-to Address";
        ShippingAgent: Record "Shipping Agent";
        ShippingAgentServices: Record "Shipping Agent Services";
        RecState: Record State;
        recState1: Record State;
        State1: Record State;
        State2: Record State;
        StateRec: Record State;
        TaxTransactionValue: Record "Tax Transaction Value";
        // TermAndCondition: Record "LFS Terms and Conditions Trans";
        User: Record User;
        RepCheck: array[2] of Report Check;
        TempBlob: Codeunit "Temp Blob";
        TypeHelper: Codeunit "Type Helper";
        x: Page "LFS Export Whse. Shipment Subf";
        Include_Innexure: Boolean;
        Print_Rate_KG: Boolean;
        CompanyStateCode, CompanyStateCodeHO : code[10];
        Invoice_To_StateCode: Code[10];
        AdvLiceNo: Code[20];
        BankAccNo: Code[20];
        BankBranchNo: Code[20];
        BankSwift: Code[20];
        ECCNo1: Code[20];
        GSTIN: Code[20];
        IFSCcode: Code[20];
        Invoice_To_GSTIN: Code[20];
        Invoice_To_Post_Code: Code[20];
        LRNo: Code[20];
        PostCode: Code[20];
        ShipToGSTIN: code[20];
        ShiptoPostCode: Code[20];
        VesselFlightNo: Code[20];
        GSTRegNo: Code[22];
        CountryCo: Code[30];
        ManLicTax: Code[30];
        CEComm1: Code[58];
        BankName: Code[100];
        LRdate: Date;
        QuoteDate: Date;
        Amount_CIF: Decimal;
        AmountINUSD: Decimal;
        BCDAmt: Decimal;
        CGSTAmt: Decimal;
        CGSTPer: Decimal;
        Charge_Amt_TRN: Decimal;
        Curr_Factor: Decimal;
        EDCAmt: Decimal;
        FOB_CurrValue: Decimal;
        FOB_Igst: Decimal;
        FOB_Value: Decimal;
        FreightAmount: Decimal;
        FreightAmt: Decimal;
        // StructureOrderLineDetails: Record 13795;
        FreihtAmt: Decimal;
        GrossWeight: Decimal;
        GSTAmt: Decimal;
        IGSTAmt: Decimal;
        IGSTPer: Decimal;
        InsuranceAmount: Decimal;
        InsuranceAmt: Decimal;
        LengthCalculate: Decimal;
        LineAmount: Decimal;
        LineAmt: Decimal;

        LineAmtTax: Decimal;
        NettWeight: Decimal;
        // EXIMItemGroup: Record 90004;
        noofbags: Decimal;
        //StrOrderDetail: Record 13794;
        PackingAmt: Decimal;
        QTY: Decimal;
        SalesLineAmt: Decimal;
        // DetailedGSTEntryBuffer: Record 16412;
        SGSTAmt: Decimal;
        SGSTPer: Decimal;
        SWCAmt: Decimal;
        TCSAmt: Decimal;
        TotalAmount: Decimal;
        TotalAmtIncTax: Decimal;
        TotalAmtIncTaxWords: Decimal;
        Totalamtwords: Decimal;
        TotalCIFValue: Decimal;
        TotalFreight: Decimal;
        TotalInsurance: Decimal;
        TotallFOBValue: Decimal;
        totalLine: Decimal;
        TotalLineamt: Decimal;
        TotalValue_INR: Decimal;

        TotAmt: Decimal;
        UnitPrice: Decimal;
        UnitPrice2: Decimal;
        InStr: InStream;
        FromPallet: Integer;
        Number1: Integer;
        Number2: Integer;
        Number3: Integer;
        //EXIMPackingLines_Rec: Record 90016;
        Pallet: Integer;
        PalletSize: Integer;
        SR1: Integer;
        SR2: Integer;
        SR3: Integer;
        SrNo: Integer;
        ToPallet: Integer;
        AndLbl: Label 'AND';
        CroreLbl: Label 'CRORE';
        EighteenLbl: Label 'EIGHTEEN';
        EightLbl: Label 'EIGHT';
        EightyLbl: Label 'EIGHTY';
        ElevenLbl: Label 'ELEVEN';
        FifteenLbl: Label 'FIFTEEN';
        FiftyLbl: Label 'FIFTY';
        FiveLbl: Label 'FIVE';
        FortyLbl: Label 'FORTY';
        FourLbl: Label 'FOUR';
        FourteenLbl: Label 'FOURTEEN';
        HundreadLbl: Label 'HUNDRED';
        LakhLbl: Label 'LAKH';
        NineLbl: Label 'NINE';
        NinetyLbl: Label 'NINETY';
        NinteenLbl: Label 'NINETEEN';
        OneLbl: Label 'ONE';
        OnlyLbl: Label 'ONLY';
        SevenLbl: Label 'SEVEN';
        SeventeenLbl: Label 'SEVENTEEN';
        SeventyLbl: Label 'SEVENTY';
        SixLbl: Label 'SIX';
        SixteenLbl: Label 'SIXTEEN';
        SixtyLbl: Label 'SIXTY';
        TenLbl: Label 'TEN';
        ThireentLbl: Label 'THIRTEEN';
        ThirtyLbl: Label 'THIRTY';
        ThousandLbl: Label 'THOUSAND';
        ThreeLbl: Label 'THREE';
        TwelveLbl: Label 'TWELVE';
        TwentyLbl: Label 'TWENTY';
        TwoLbl: Label 'TWO';
        ZeroLbl: Label 'ZERO';
        Print_Length_Mtr: Option "Length(mtr)","Length(feet)","Length(mm)";
        RepTypeOpt: Option "Original For Recipient","Duplicate For Supplier/Transporter","Triplicate For Supplier","Office Copy";
        OutStr: OutStream;
        AmtinWords: array[2] of Text;
        BilltoGSTIN: Text;
        CompanyStateDesc, LocationStateDescHO : Text;
        CountryRegionDesc, Loc_CountryRegionDescHO : Text;
        currncycode: Text;
        EXIMAdvLicenseHeader: Text;
        EXIMAdvLicenseIODetails: Text;
        ExmptedMet: Text;
        ExpDate: Text;
        // GSTAccountingPeriod: Record 16401;
        // EXIMPackingHeader: Record 90015;
        Expdate1: Text;
        GSTStateCode: Text;
        ItemandVariant: Text;
        ItemDescription: Text;
        Lot: Text;
        Marks: Text;
        Notext: array[2] of Text;
        PortofDischrg2: Text;
        //EXIMPort2: Record 90001;
        PortOFloading2: Text;
        RemittanceAmntInWords: Text;
        SalesHeaderComment: Text;
        TermAndCondDescrip: Text;
        TermAndCondDescripLogistics: Text;
        TermAndCondDescripTechnical: Text;
        WorkDescriptionAsText: text;
        WorkDescText: Text;
        CRLF: Text[2];
        MinAverageTxt: Text[10];
        BilltoContactNo: Text[30];
        ExponentText: array[5] of Text[30];
        FaxNo: Text[30];
        Invoice_To_Country: Text[30];
        OnesText: array[20] of Text[30];
        PhNo: Text[30];
        ShiptoContactNo: Text[30];
        TensText: array[10] of Text[30];
        Bill_toCountry: Text[50];
        BillToCountry: Text[50];
        BillToState: Text[50];
        ComInfoState: Text[50];
        CompCoutry: Text[50];
        CountryCode: Text[50];
        countryname: Text[50];
        CountryofFinalDestination: Text[50];
        CountryofOrginofGoods: Text[50];
        FinalDestination: Text[50];
        Invoice_To_Address_2: Text[50];
        Invoice_To_City: Text[50];
        Invoice_To_State: Text[50];
        Invoice_To_State_1: Text[50];
        Notext1: array[2] of Text[50];
        Notext2: array[2] of Text[50];
        PortofLoading: Text[50];
        SalesPerCode: Text[50];
        ShiptoCountry: Text[50];
        ShiptoState: Text[50];

        StateCode: Text[50];
        statename: Text[50];
        SystemCreatedByUser: Text[50];
        TermsofDelivery: Text[50];
        TransporterName: Text[50];
        Address: Text[57];
        Address2: Text[58];
        City: Text[59];
        StateDesc: Text[59];
        BillToEmail: Text[80];
        Email: Text[80];
        Invoice_To_Email: Text[80];
        NoTextAmt: ARRAY[2] OF Text[80];
        NoTextAmt2: ARRAY[2] OF Text[80];
        NoTextExcise: array[2] of Text[80];
        Port_of_Loading: Text[80];
        PortofDischarge: Text[80];
        ShiptoEmail: Text[80];
        AgentCode: Text[100];
        Invoice_To_Address: Text[100];
        Invoice_To_Contact: Text[100];
        Loc_Contact: Text[100];
        paymenttermname: Text[100];
        Shipping_Agent_Service_Code: Text[100];
        ShiptoContactname: Text[100];
        BankBranchAddress: Text[130];

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
        if CurrencyCode <> '' then begin
            Currency.Get(CurrencyCode);
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + Currency.Code);
        end
        else begin
            if GenLedgSetup.Get() then;
            if GenLedgSetup."LCY Code" = 'INR' then
                AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + 'RUPEES');
        end;
        // end else
        //   AddToNoText(NoText, NoTextIndex, PrintExponent, 'RUPEES');
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
        if (CurrencyCode <> '') then
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ONLY')
        //AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + Currency.Code + ' ONLY')
        else
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' PAISA ONLY');
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

    local procedure GetStrAmount(StrCode: Code[20]): Decimal;
    var
        SalesLine1: Record "Sales Line";
    begin
        //LFS-YJ-3548++
        SalesLine1.Reset();
        SalesLine1.SETRANGE("Document No.", "Sales Line"."Document No.");
        SalesLine1.SETRANGE("Document Type", "Sales Line"."Document Type");
        SalesLine1.SETFILTER("No.", '%1', StrCode);
        IF SalesLine1.FindSet() then
            EXIT(SalesLine1."Unit Price");
        //LFS-YJ-3548--
    end;
}

