namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Sales.Document;
using Microsoft.Foundation.Address;
using Microsoft.CRM.Team;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Inventory.Tracking;
using System.Reflection;
using Microsoft.Finance.Currency;
using Microsoft.Bank.BankAccount;
using Microsoft.Sales.Comment;
using Microsoft.Foundation.Company;
using Microsoft.Inventory.Intrastat;
using Microsoft.Finance.GST.Base;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Inventory.Location;
using System.Automation;
using System.Security.AccessControl;
using Microsoft.Finance.TaxBase;
using Microsoft.Inventory.Item;

report 72003 "LFS WORK ORDER Report"
{
    ApplicationArea = All;
    Caption = 'WORK ORDER Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports Layouts/WORK ORDER Report.rdl';
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            RequestFilterFields = "No.";
            DataItemTableView = sorting("No.");
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {

            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_PostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyInfo_Country; CountryName_Comp)
            {
            }
            column(CompanyInfo_PhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_EMail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfo_Fax; CompanyInfo."Fax No.")
            {
            }
#pragma warning disable AL0432
            column(CompanyInfo_URL; CompanyInfo."Home Page")
#pragma warning restore AL0432
            {
            }
            column(CompanyInfo_GST_No; CompanyInfo."GST Registration No.")
            {
            }
            column(CompanyInfo_PAN_No; CompanyInfo."P.A.N. No.")
            {
            }
            column(CompanyInfo_Reg_No; CompanyInfo."Registration No.")
            {
            }
            // column(CompanyInfo_CIN_No; CompanyInfo."LFS CIN No.")
            // {
            // }
            // column(CompanyInfo_FSSAI_No; CompanyInfo."LFS FSSAI No.")
            // {
            // }
            column(CompInShiptoName; CompanyInfo."Ship-to Name")
            {

            }
            column(CompInfShipAddre; CompanyInfo."Ship-to Address")
            {

            }
            column(CompInShiptoaddre2; CompanyInfo."Ship-to Address 2")
            {

            }
            column(CompInShiptoCity; CompanyInfo.City)
            {

            }
            column(CompInShiptoPostCode; CompanyInfo."Post Code")
            {

            }
            column(CompInShiptoState; CompInShiptoState)
            {

            }
            column(CompInShiptoCoutry; CompInShiptoCoutry)
            {

            }
            column(RBICODENO; CompanyInfo."LFS R.B.I. CODE NO.")
            {

            }
            column(IECCodeNo; CompanyInfo."LFS I.E.C. CODE NO.")
            {

            }
            column(CompanyInfo_ARN_No; CompanyInfo."ARN No.")
            {

            }
            // column(LFS_EX_Export_Remark; "LFS Export Remark")
            // {

            // }
            column(PreparedBy; PreparedBy)
            {
            }
            column(PreparedBydt; PreparedBydt)
            {

            }
            column(AuthorizedBy; AuthorizedBy)
            {
            }
            column(AuthorizedByDt; AuthorizedByDt)
            {

            }
            column(CheckedBy; CheckedBy)
            {
            }
            column(No_; "No.")
            {
            }
            column(Ship_to_Name; "Ship-to Name")
            {
            }
            column(Ship_to_Address; "Ship-to Address")
            {
            }
            column(Ship_to_Address_2; "Ship-to Address 2")
            {
            }
            column(Ship_to_City; "Ship-to City")
            {
            }
            column(Ship_to_Country_Region_Code; ShipToCountry)
            {
            }
            column(Ship_to_Post_Code; "Ship-to Post Code")
            {
            }
            column(Pre_Carriage; "LFS Pre Carriage")
            {
            }
            column(Port_of_Loading; "LFS Port of Loading")
            {
            }
            column(Port_of_Discharge; "LFS Port of Discharge")
            {
            }
            column(Final_Destination; "LFS Final Destination")
            {
            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {
            }
            column(Sell_to_Address; "Sell-to Address")
            {
            }
            column(Sell_to_Address_2; "Sell-to Address 2")
            {
            }
            column(Sell_to_City; "Sell-to City")
            {
            }
            column(Sell_to_Country_Region_Code; "Sell-to Country/Region Code")
            {
            }
            column(Sell_to_County; "Sell-to County")
            {
            }
            column(Country_of_Origin_of_Goods; Country_of_Origin_of_Goods)
            {
            }
            column(Country_of_Final_Destination; "LFS Country of Final Dest.")
            {
            }
            column(CountryFinalDestinationName; CountryFinalDestinationName)
            {
            }
            column(Order_No_; "External Document No.")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(Currency_Code; CurrencyCode)
            {
            }
            column(External_Document_No_; "External Document No.")
            {
            }
            column(Location_Code; "Location Code")
            {
            }
            column(Location_GST_Reg__No_; "Location GST Reg. No.")
            {

            }
            column(Name; Name)
            {

            }
            column(Conutry; Conutry)
            {

            }
            column(LocationAddress; Address)
            {

            }
            column(Address1; Address1)
            {

            }
            column(PostCode; PostCode)
            {

            }
            column(GSTNo; GSTNo)
            {

            }
            column(LocState; LocState) { }
            column(LC_No_; LCNo)
            {
            }
            column(LC_Date; LCDate)
            {
            }
            column(CustomerBankName; CustomerBankName) { }
            column(Payment_Terms; PaymentTerms)
            {
            }
            column(Delivery_Terms; Delivery_Terms)
            { }
            column(Payment_Terms_2; PaymentTerms2)
            {
            }
            column(Buyer_If_other_then_Consignee_; BuyerIfotherthenConsignee_)
            {
            }
            column(Vessel_Flight_No_; VesselFlightNo)
            { }
            column(Bank; Bank)
            { }
            column(Description_of_Goods; DescOfGoods)
            { }
            column(Commission_Manual_; '"Commission(Manual)"')
            {

            }
            column(PortOfDescharg; PortName)
            {

            }
            column(PortName; "LFS Final Destination")
            {

            }
            column(PortOfLoading; PortOfLoading)
            {

            }
            column(Terms; "LFS Inco Terms")
            {
            }
            column(TermsDescription; TermsDescription)
            {
            }
            column(paymenttermname; paymenttermname)
            {
            }
            column(Consignee_Address; Consignee_Address)
            { }
            column(ConsigneeName; ConsigneeName)
            { }
            column(CustomerOrderNo; "External Document No.")
            {

            }
            column(CustomerOrderDate; "LFS Your Reference Date")
            {

            }
            column(Bill_to_Name; "Bill-to Name")
            {

            }
            column(Bill_to_Address; "Bill-to Address")
            { }
            column(Bill_to_Address_2; "Bill-to Address 2")
            { }

            column(Bill_to_City; "Bill-to City")
            { }
            column(Bill_to_Country_Region_Code; "Bill-to Country/Region Code")
            { }
            column(Bill_to_Post_Code; "Bill-to Post Code")
            { }
            column(Seller_Address; Seller_Address)
            {
            }
            column(Work_Description; GetWorkDescription())
            {
            }
            column(BankName_ba; BankName)
            {
            }
            column(BankName2; BankName2)
            {
            }
            column(BankAccNo_ba; BankAccNo)
            {
            }
            column(IFSCcode_ba; IFSCcode)
            {
            }
            column(AD_Code; AD_Code)
            {

            }
            column(BankAddress; BankAddress)
            {
            }
            column(BankCountryDes; BankCountryDes)
            {

            }
            column(BankStateDes; BankStateDes)
            {

            }
            column(BankSwift_ba; BankSwift)
            {
            }
            column(TransportDesc; TransportDesc)
            { }
            column(LUT_Date; LUT_Date)
            { }
            column(Bill_to_County; Bill_to_County)
            { }
            // column(Commission__; "LFS Commission %") { }
            column(ShipBillNo; ShipBillNo)
            {
            }
            column(ShipBillDate; ShipBillDate)
            {
            }
            column(BOLDate; FORMAT(BOLDate, 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(BOLNo; BOLNo)
            {
            }
            column(ETD; ETD)
            {

            }
            column(ETA; ETA)
            {

            }
            column(PartyHSCode; PartyHSCode)
            {

            }
            column(LFS_Dispatch_Date; "LFS Dispatch Date")
            {

            }
            // column(LFS_EX_Commission__; "LFS Commission %")
            // {

            // }
            column(LUTNumber; LUTNumber)
            {

            }
            column(LUTDate; LUTDate)
            {

            }
            column(CommissioNLabel; CommissioNLabelLbl)
            {

            }
            column(CommissioNLabel2; CommissioNLabel2Lbl)
            {

            }
            column(RoDTEPValueLabel; RoDTEPValueLabelLbl)
            {

            }
            column(Email; Email)
            {
            }
            column(Your_Reference; "Your Reference")
            {

            }
            column(VesselFlight; VesselFlight)
            {

            }
            column(LFS_EX_Final_Destination; "LFS Final Destination")
            {
            }
            // column(LFS_EX_Your_Reference_Date; "LFS Your Reference Date")
            // {
            // }
            column(Order_Date; "Order Date")
            {
            }
            column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code")
            {
            }
            column(Salesperson_Code; SalesPerseonDes)
            {
            }


            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = field("No."), "Sell-to Customer No." = field("Sell-to Customer No.");
                DataItemLinkReference = SalesHeader;
                DataItemTableView = sorting("Document No.", "Line No.") where(Type = filter(Type::Item));
                column(HSN_SAC_Code; "HSN/SAC Code")
                {
                }
                column(SrNo; SrNo)
                {

                }
                column(ItemNo_; "No.")
                {
                }
                column(Description; Description)
                {

                }
                column(Variant_Code; "Variant Code")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Unit_of_Measure; "Unit of Measure")
                {
                }
                column(Unit_Cost; "Unit Price")
                {
                }
                column(AmountToCustomer; 'AmountToCustomer')
                {
                }
                column(Line_Discount_Amount; "Line Discount Amount")
                {
                }
                column(Line_No_; "Line No.")
                {
                }
                column(Amount; Amount)
                {
                }
                column(CountInWords; Notext1[1] + ' ' + Notext1[2])
                {
                }
                column(PackingNo; PackingNo)
                {
                }
                column(TotalAmountasText; Notext2[1] + Notext2[2])
                {
                }
                column(TotalAmount; TotalAmount)
                {
                }
                column(CurrDes; CurrDes) { }
                column(GrossWeightPack; GrossWeightPack)
                {

                }
                column(NetWeight; NetWeight)
                {

                }
                column(LFS_EX_CIF_FCY_; ("LFS CIF Value (FCY)"))
                {

                }
                column(LFS_EX_CIF_LCY_; ("LFS CIF Value (LCY)"))
                {

                }
                column(CommetTxt; CommetTxt)
                {
                }
                column(Insurance_Value_Per_Type__FCY_; ("LFS Insurance Value (FCY)"))
                {

                }
                column(Insurance_Value_Per_Type__LCY_; ("LFS Insurance Value (LCY)"))
                {

                }
                column(Freight_Value_Per_Type__FCY_; ("LFS Freight Value (FCY)"))
                {

                }
                column(Freight_Value_Per_Type__LCY_; ("LFS Freight Value (LCY)"))
                {
                }
                column(FOB__FC_; ("LFS FOB Amount (FCY)"))
                {
                }
                column(FOB__LC_; ("LFS FOB Amount (LCY)"))
                {
                }
                column(DrugLic; DrugLic)
                {

                }
                column(TotalAmountasText1; TotalAmountasText)
                {

                }
                column(IGSTAmt; IGSTAmt)
                {

                }
                column(SGSTAmt; SGSTAmt)
                {

                }
                column(CGSTAmt; CGSTAmt)
                {

                }
                column(TaxAbleAmt; TaxAbleAmt)
                {

                }
                column(IGSTPer; IGSTPer)
                {

                }
                column(CGSTPer; CGSTPer)
                {

                }
                column(SGSTPer; SGSTPer)
                {

                }
                column(TotalCGST; TotalCGST)
                {

                }
                column(TotalIGST; TotalIGST)
                {

                }
                column(TotalSGST; TotalSGST)
                {

                }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                {

                }
                column(Incentive_Type; "LFS Incentive Type")
                {

                }
                column(UnderDuty; UnderDuty)
                {

                }
                column(ShippingMrks; ShippingMrks)
                {

                }
                column(PackingType; 'Packing')
                {

                }
                // column(ExpiryDate; ExpiryDate)
                // {

                // }
                // column(MfgDate; MfgDate)
                // {

                // }
                // column(LotNo; LotNo)
                // {

                // }
                column(Adv__Lic_File_No_; Adv__Lic_File_No_)
                { }
                column(Issue_Date; Issue_Date)
                {
                }
                column(RoDTEP_Rebate_Value; RoDTEP_Rebate_Value)
                {

                }
                column(No_LIC; No_LIC)
                { }
                column(License_No_; License_No_)
                { }
                column(LFS_EX_to; "LFS No. & Kind of Packages")
                {

                }
                column(LFS_EX_From; "LFS Container No/Shipp. Marks")
                {

                }
                column(ContainerDetails; ContainerDetails)
                {

                }
                column(IncoTermsDescription; IncoTermsDescription)
                {
                }
                column(PreShipmentSample; PreShipmentSample)
                {
                }
                column(Palletization; Palletization)
                {
                }
                column(FormsRequirement; FormsRequirement)
                {

                }
                dataitem(ReservationEntrydataitem; "Reservation Entry")
                {
                    DataItemLinkReference = "Sales Line";
                    DataItemLink = "Source ID" = field("Document No."), "Source Ref. No." = field("Line No."), "Item No." = field("No.");
                    column(ExpiryDate; "Expiration Date")
                    {

                    }
                    // column(MfgDate; "LFS Mfg. Date")
                    // {

                    // }
                    column(LotNo; "Lot No.")
                    {

                    }

                }
                dataitem("Sales Comment Line"; "Sales Comment Line")//Sales Comment Line
                {

                }

                trigger OnAfterGetRecord()//Sales Line
                begin
                    Clear(GrossWeight);
                    Clear(PackingNo);
                    SrNo += 1;


                    PackingList.Reset();
                    PackingList.SetRange("LFS Posted Export Shipment", "Sales Line"."Shipment No.");
                    PackingList.SetRange("LFS PostExShipmentLineNo.", "Sales Line"."Shipment Line No.");
                    if PackingList.Findset() then
                        repeat
                            NetWeight += PackingList."LFS Net Weight of Pack";
                            GrossWeightPack += PackingList."LFS Gross Weight of Pack";
                        until PackingList.Next() = 0;

                    ExpInfo.Reset();
                    ExpInfo.SetRange("LFS Document No.", "Sales Line"."Document No.");
                    if ExpInfo.FindFirst() then begin
                        ShippingMrks := ExpInfo."LFS Shipping Marks";
                        ContainerDetails := ExpInfo."LFS Description of Goods";
                        IncoTermsDescription := ExpInfo."LFS Sp Notes";
                        FormsRequirement := ExpInfo."LFS Dispatch Instruction";
                        Delivery_Terms := ExpInfo."LFS Sp Notes";
                        if ExpInfo."LFS Palletization" = true then
                            Palletization := 'YES'
                        else
                            Palletization := 'NO';
                        if ExpInfo."LFS Pre-Shipment Sample" = true then
                            PreShipmentSample := 'YES'
                        else
                            PreShipmentSample := 'NO';

                    end;

                    TotalAmount += "Sales Line".Amount;
                    eximmgmt."LFS InitTextVariable"();
                    eximmgmt."LFS FormatNoText"(Notext2, TotalAmount - "Line Discount Amount", SalesHeader."Currency Code");

                    if CurrRec.get(SalesHeader."Currency Code") then
                        CurrDes := CurrRec.Description;

                    // ItemRec.Reset();
                    // if ItemRec.get("Sales Line"."No.") then
                    //     DrugLic := itemrec."LFS Drug Lic No.";

                    CommetTxt := '';
                    Crlf := TypeHelper.CRLFSeparator();
                    SalesCommentLine.Reset();
                    SalesCommentLine.SetRange("Document Type", "Sales Line"."Document Type");
                    SalesCommentLine.SetRange("No.", "Sales Line"."Document No.");
                    SalesCommentLine.SetFilter("Document Line No.", '<>%1', 0);
                    if SalesCommentLine.Findset() then
                        repeat
                            if CommetTxt <> '' then
                                //SRNo += 1;
                                CommetTxt += Crlf + SalesCommentLine.Comment
                            else
                                // SRNo := 1;
                                CommetTxt := SalesCommentLine.Comment;

                        until SalesCommentLine.Next() = 0;

                    DetailedGSTLedgerEntry.Reset();
                    DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                    DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Line No.");
                    DetailedGSTLedgerEntry.SETFILTER("Entry Type", '%1', DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
                    if DetailedGSTLedgerEntry.FIND('-') then
                        repeat
                            CASE DetailedGSTLedgerEntry."GST Component Code" OF
                                'CGST':
                                    begin
                                        CGSTPer := DetailedGSTLedgerEntry."GST %";
                                        CGSTAmt += DetailedGSTLedgerEntry."GST Amount" * -1;
                                        TotalCGST += CGSTAmt;
                                        TaxAbleAmt := DetailedGSTLedgerEntry."GST Base Amount";
                                    end;
                                'SGST':
                                    begin
                                        SGSTPer := DetailedGSTLedgerEntry."GST %";
                                        SGSTAmt += DetailedGSTLedgerEntry."GST Amount" * -1;
                                        TotalSGST += SGSTAmt;
                                        TaxAbleAmt := DetailedGSTLedgerEntry."GST Base Amount";
                                    end;
                                'IGST':
                                    begin
                                        IGSTPer := DetailedGSTLedgerEntry."GST %";
                                        IGSTAmt += DetailedGSTLedgerEntry."GST Amount" * -1;
                                        TotalIGST += IGSTAmt;
                                        TaxAbleAmt := DetailedGSTLedgerEntry."GST Base Amount";
                                    end;
                            end;
                        UNTIL DetailedGSTLedgerEntry.Next() = 0;

                    RoDTEP_Rebate_Value += "Sales Line"."LFS RoDTEP Rebate Value";
                    UnderDuty := Format("HSN/SAC Code", 4)
                end;


            }
            trigger OnAfterGetRecord()
            var
                GenLedgerSetup: Record "General Ledger Setup";
                EximIncoTerms: Record "LFS EXIM Inco Terms";
            // SRNo: Integer;
            begin

                Clear(CurrencyCode);
                if SalesHeader."Currency Code" = '' then begin
                    GenLedgerSetup.Get();
                    CurrencyCode := GenLedgerSetup."LCY Code";
                end
                else
                    CurrencyCode := SalesHeader."Currency Code";

                State1.Reset();
                State1.SetRange(Code, CompanyInfo."State Code");
                if State1.FindFirst() then
                    CompInShiptoState := State1.Description;
                RecState3.Reset();
                if RecState3.Get(CompanyInfo."State Code") then
                    ComInfoState := RecState3.Description;
                CoutryR.Reset();
                CoutryR.SetRange(Code, CompanyInfo."Country/Region Code");
                if CoutryR.FindFirst() then
                    CompInShiptoCoutry := CoutryR.Name;
                if CountryRegion_Rec1.GET(CompanyInfo."Country/Region Code") then
                    CountryName_Comp := (CountryRegion_Rec1.Name);
                CoutryR.Reset();
                CoutryR.SetRange(Code, SalesHeader."LFS Country of Final Dest.");
                if CoutryR.FindFirst() then
                    CountryFinalDestinationName := CoutryR.Name;

                EximIncoTerms.SetRange("LFS Code", SalesHeader."LFS Inco Terms");
                if EximIncoTerms.FindFirst() then
                    TermsDescription := EximIncoTerms."LFS Description";

                if Locationrec.get(SalesHeader."Location Code") then begin
                    Name := Locationrec.name;
                    Address := Locationrec.address;
                    Address1 := Locationrec."Address 2";
                    PostCode := Locationrec."Post Code";
                    City := Locationrec.City;
                    GSTNo := Locationrec."GST Registration No.";
                    Email := Locationrec."E-Mail";
                    if RecState.get(Locationrec."State Code") then
                        LocState := RecState.Description;

                    if CountReg.Get(Locationrec."Country/Region Code") then
                        Conutry := CountReg.Name;
                end;
                ExpInfo.Reset();
                ExpInfo.SetRange("LFS Document No.", SalesHeader."No.");
                if ExpInfo.FindFirst() then
                    VesselFlight := ExpInfo."LFS Vessel/Flight No.";

                if SalesPersonRec.Get(SalesHeader."Salesperson Code") then
                    SalesPerseonDes := SalesPersonRec.Name;

                BankAcc.Reset();
                BankAcc.SETRANGE("No.", "LFS Customs Bank Account");
                if BankAcc.FINDFIRST() then begin
                    BankName := BankAcc.Name;
                    BankName2 := BankAcc."Name 2";
                    BankAccNo := BankAcc."Bank Account No.";
                    BankSwift := BankAcc."SWIFT Code";
                    IFSCcode := BankAcc."IFSC Code";
                    AD_Code := BankAcc."LFS AD Code";
                    BankAddress := BankAcc.Address + ', ' + BankAcc."Address 2" + ', ' + BankAcc.City + ', ' + BankAcc."Post Code" + ', ' + BankStateDes + ', ' + BankCountryDes;
                    if CountReg.Get(BankAcc."Country/Region Code") then
                        BankCountryDes := CountReg.Name;

                    if RecState.Get(BankAcc."State Code") then
                        BankStateDes := RecState.Description;
                end;
                if RecPaymentTerms.GET("Payment Terms Code") then
                    paymenttermname := RecPaymentTerms.Description;
                PostedExportInformation.SetRange("LFS Document No.", SalesHeader."No.");
                if PostedExportInformation.FindFirst() then begin
                    ShipBillNo := PostedExportInformation."LFS Shipping Bill No.";
                    ShipBillDate := PostedExportInformation."LFS Shipping Bill Date";
                    BOLNo := PostedExportInformation."LFS BL No/ AWB No.";
                    BOLDate := PostedExportInformation."LFS BL Date/ AWB Date";
                    DescOfGoods := PostedExportInformation."LFS Description of Goods";
                    LCDate := PostedExportInformation."LFS LC Date";
                    LCNo := PostedExportInformation."LFS LC No.";
                    PaymentTerms := PostedExportInformation."LFS Payment Terms";
                    // Delivery_Terms := PostedExportInformation."LFS Delivery Terms";
                    PaymentTerms2 := PostedExportInformation."LFS Payment Terms 2";
                    PortName := PostedExportInformation."LFS Port of Discharge";
                    PortOfLoading := PostedExportInformation."LFS Port of Loading";
                    BuyerIfotherthenConsignee_ := PostedExportInformation."LFS BuyerotherthanConsignee";
                    VesselFlightNo := PostedExportInformation."LFS Vessel/Flight No.";
                    Bank := PostedExportInformation."LFS Our Bank";
                    PartyHSCode := PostedExportInformation."LFS HS Code";
                    Seller_Address := PostedExportInformation."LFS Seller Name & Address";
                    CustomerBankName := PostedExportInformation."LFS Bank Details";
                    if SalesHeader."LFS ETD" = 0D then
                        ETD := PostedExportInformation."LFS ETD"
                    else
                        ETD := SalesHeader."LFS ETD";
                    if SalesHeader."LFS ETA" = 0D then
                        ETA := PostedExportInformation."LFS ETA"
                    else
                        ETA := SalesHeader."LFS ETA";

                end;
                if EximPort.get(SalesHeader."LFS Port of Discharge") then
                    PortName := EximPort."LFS Port Name";
                if EximPort.get(SalesHeader."LFS Port of Loading") then
                    PortOfLoading := EximPort."LFS Port Name";
                if CountryRegion.Get(SalesHeader."LFS Country Origin Goods") then
                    Country_of_Origin_of_Goods := CountryRegion.Name;
                if TransportMethod.Get(SalesHeader."Transport Method") then
                    TransportDesc := TransportMethod.Description;
                if CountryRegion.Get(SalesHeader."Bill-to Country/Region Code") then
                    Bill_to_County := CountryRegion.Name;

                if CountryRegion.Get(SalesHeader."Ship-to Country/Region Code") then
                    ShipToCountry := CountryRegion.Name;

                RecLocation.Reset();
                RecLocation.SetRange(Code, SalesHeader."Location Code");
                if RecLocation.FindFirst() then begin
                    GSTRegistrationNos.Reset();
                    GSTRegistrationNos.SetRange(Code, RecLocation."GST Registration No.");
                    if GSTRegistrationNos.FindFirst() then begin
                        LUTNumber := GSTRegistrationNos."LFS LUT No.";
                        LUTDate := GSTRegistrationNos."LFS LUT Date";
                    end;
                end;

                Users.Reset();
                Users.SetRange(Users."User Security ID", SalesHeader.SystemCreatedBy);
                if Users.FindFirst() then
                    PreparedBy := Users."User Name";

                if SalesHeader.Status = SalesHeader.Status::Released then begin
                    ApprovalEntries.Reset();
                    ApprovalEntries.SetRange("Table ID", Database::"Sales Header");
                    ApprovalEntries.SetRange("Document No.", SalesHeader."No.");
                    ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Approved);

                    // Use SetCurrentKey to sort by Sequence No.
                    ApprovalEntries.SetCurrentKey("Document No.", "Sequence No.");
                    if ApprovalEntries.FindSet() then begin
                        // Initialize placeholders for CheckBy and AuthorizedBy
                        CheckedBy := '';
                        AuthorizedBy := '';

                        repeat
                            Users.Reset();
                            Users.SetRange("User Name", ApprovalEntries."Approver ID");
                            if Users.FindFirst() then begin
                                if CheckedBy = '' then
                                    CheckedBy := Users."User Name";  // Assign the first approver to CheckedBy
                                AuthorizedBy := Users."User Name";    // Keep updating AuthorizedBy with the latest approver
                            end;
                        until ApprovalEntries.Next() = 0;

                        if AuthorizedBy = '' then
                            AuthorizedBy := CheckedBy; // If no distinct authorized approver, set to CheckedBy
                    end;
                end;
            end;
        }


    }
    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        ApprovalEntries: Record "Approval Entry";
        BankAcc: Record "Bank Account";
        CompanyInfo: Record "Company Information";
        CountReg: Record "Country/Region";
        CountryRegion: Record "Country/Region";
        CountryRegion_Rec1: Record "Country/Region";
        CoutryR: Record "Country/Region";
        CurrRec: Record Currency;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        GSTRegistrationNos: Record "GST Registration Nos.";
        // ItemRec: Record Item;
        PackingList: Record "LFS EXIM Packing List Tab.";
        EximPort: Record "LFS EXIM Port";
        ExpInfo: Record "LFS Export Information Header";
        PostedExportInformation: Record "LFS Posted Export Information";
        Locationrec: Record Location;
        RecLocation: Record Location;
        RecPaymentTerms: Record "Payment Terms";
        SalesCommentLine: Record "Sales Comment Line";
        SalesPersonRec: Record "Salesperson/Purchaser";
        RecState: Record State;
        RecState3: Record State;
        State1: Record State;
        TransportMethod: Record "Transport Method";
        Users: Record User;
        eximmgmt: Codeunit "LFS EXIM General Functions";
        TypeHelper: Codeunit "Type Helper";
        UnderDuty: Code[10];
        AD_Code: Code[20];
        BankSwift: Code[20];
        BOLNo: Code[20];
        CurrencyCode, PartyHSCode : Code[20];
        DrugLic: Code[20];
        GSTNo: code[20];
        IFSCcode: Code[20];
        License_No_: Code[20];
        No_LIC: Code[20];
        PostCode: Code[20];
        VesselFlight: Code[20];
        Bank: code[50];
        BankCountryDes: Code[50];
        BankStateDes: Code[50];
        PreparedBy: Code[50];
        ShipBillNo: Code[50];
        VesselFlightNo: Code[50];
        BankName: Code[100];
        BankName2: Code[100];
        BOLDate: Date;
        ETA: Date;
        ETD: Date;
        Issue_Date: Date;
        LCDate: Date;
        LUT_Date: Date;
        LUTDate: Date;
        ShipBillDate: Date;
        AuthorizedByDt, PreparedBydt : DateTime;
        CGSTAmt: Decimal;
        CGSTPer: Decimal;
        GrossWeight: Decimal;
        GrossWeightPack: Decimal;
        IGSTAmt: Decimal;
        IGSTPer: Decimal;
        NetWeight: Decimal;
        RoDTEP_Rebate_Value: Decimal;
        SGSTAmt: Decimal;
        SGSTPer: Decimal;
        TaxAbleAmt: decimal;
        TotalAmount: Decimal;
        TotalAmountasText: Decimal;
        TotalCGST: decimal;
        TotalIGST: Decimal;
        TotalSGST: decimal;
        PackingNo: Integer;
        SrNo: Integer;
        CommissioNLabel2Lbl: Label 'On FOB';
        CommissioNLabelLbl: Label 'Commission % : ';
        RoDTEPValueLabelLbl: Label 'RoDTEP  Value : ';
        Address: Text;
        Address1: Text;
        BankAddress: Text;
        BuyerIfotherthenConsignee_: Text;
        City: text;
        CommetTxt, CurrDes : Text;
        Conutry: text;
        CountryFinalDestinationName, FormsRequirement, Palletization, PreShipmentSample : Text;
        DescOfGoods: Text;
        Email: Text;
        LCNo: Text;
        LocState: Text;
        Name: Text;
        PaymentTerms2: Text;
        SalesPerseonDes: text;
        ShipToCountry: Text;
        TermsDescription: Text;
        Crlf: Text[2];
        Adv__Lic_File_No_: Text[30];
        BankAccNo: Text[30];
        Bill_to_County: Text[50];
        ComInfoState: Text[50];
        CompInShiptoCoutry: Text[50];
        CompInShiptoState: Text[50];
        ConsigneeName: Text[50];
        Country_of_Origin_of_Goods: Text[50];
        CountryName_Comp: Text[50];
        LUTNumber: Text[50];
        Notext1: array[2] of Text[50];
        Notext2: array[2] of Text[50];
        AuthorizedBy, CheckedBy : Text[80];
        ContainerDetails: Text[100];
        Delivery_Terms: Text[100];
        // EntryID 
        IncoTermsDescription: Text[100];
        paymenttermname: Text[100];
        TransportDesc: Text[100];
        CustomerBankName: Text[200];
        PaymentTerms: Text[200];
        PortName: Text[250];
        PortOfLoading: Text[250];
        Consignee_Address: Text[500];
        Seller_Address: Text[500];
        ShippingMrks: Text[1000];
}
