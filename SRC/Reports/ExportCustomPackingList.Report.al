namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Finance.TaxBase;
using Microsoft.Bank.BankAccount;
using Microsoft.Sales.History;
using Microsoft.Inventory.Ledger;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Foundation.Company;
using Microsoft.Finance.GST.Base;
using Microsoft.Inventory.Location;
using Microsoft.Foundation.Address;
using Microsoft.Finance.Currency;
using Microsoft.Inventory.Intrastat;

report 72010 "LFS Export Custom Packing List"
{
    ApplicationArea = All;
    Caption = 'Export Custom Packing List';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports Layouts/Custom Packing New.rdl';
    dataset
    {//Created New Report 31/07/2024
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            DataItemTableView = sorting("No.");
            RequestFilterHeading = 'Export Invoice';

            column(CompanyInfo_Name; CompanyInfo.Name)
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
            column(ComInfoState; ComInfoState)
            {

            }
            column(CompanyInfo_PostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyInfo_County; CountryName_Comp)
            {
            }
            column(CompanyInfo_PhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_FaxNo; CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfo_EMail; CompanyInfo."E-Mail")
            {
            }
            // column(CompanyInfo_CINno; CompanyInfo."LFS CIN No.")
            // {
            // }
            column(CompanyInfo_GSTregistrationNo; CompanyInfo."GST Registration No.")
            {
            }
            column(CompanyInfo_RegistrationNO; CompanyInfo."Registration No.")
            {
            }
            column(CompanyInfo_IECNo; CompanyInfo."LFS I.E.C. CODE NO.")
            {
            }
            // column(CompanyInfo_HomePage; CompanyInfo."Home Page")
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
            column(Ship_to_Country_Region_Code; ShiptoCoutry)
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
            column(Country_of_Final_Destination; "LFS Country Fin Destination")
            {
            }
            column(CountryFinalDestinationName; CountryFinalDestinationName)
            {
            }
            column(Order_No_; "External Document No.")
            {
            }
            // column(Posting_Date; "Posting Date")
            column(Posting_Date; "Order Date")
            {
            }
            column(Currency_Code; "Currency Code")
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
            column(Bill_to_Country_Region_Code; BilltoCountry)
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
            column(VesselFlight; VesselFlight)
            {

            }
            column(Your_Reference; "Your Reference")
            {
            }
            column(LFSPlaceofReceiptPre_Carriage; "LFSPlaceofReceiptPre-Carriage")
            {
            }
            column(CartonDimensions; CartonDimensions)
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No."), "Sell-to Customer No." = field("Sell-to Customer No.");
                DataItemLinkReference = "Sales Invoice Header";
                DataItemTableView = sorting("Document No.", "Line No.") where(Type = filter(Type::Item));

                column(Type; Type)
                {
                }
                column(HSN_SAC_Code; "HSN/SAC Code")
                {
                }
                column(LFS_HS_Code; HSCode)
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
                column(sumQty; sumQty)
                { }
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
                column(SumNetWtPackList1; SumNetWtPackList1)
                {

                }
                column(SumGrossWtPackList2; SumGrossWtPackList2)
                {

                }

                column(SumPalletWt3; SumPalletWt3)
                {

                }
                column(IncoTermsDescription; IncoTermsDescription)
                {
                }
                column(CustomerOrderNo2; CustomerOrderNo)
                {
                }
                column(CustomerOrderDate2; CustomerOrderDate)
                {
                }
                dataitem("LFS Packing List"; "LFS EXIM Posted Packing Table")
                {
                    DataItemLink = "LFS Posted Export Shipment" = field("Shipment No."), "LFS PostExShipmentLineNo." = field("Shipment Line No.");
                    DataItemLinkReference = "Sales Invoice Line";
                    column(LFS_EX_Line_No_; "LFS Line No.")
                    {
                    }
                    column(LFS_EX_Net_Weight_of_Pack; "LFS Net Weight of Pack")
                    {
                    }
                    column(LFS_EX_Gross_Weight_of_Pack; "LFS Gross Weight of Pack")
                    {
                    }
                    column(LFS_EX_Gross_Weight_Per_Item; "LFS Gross Weight Per Item")
                    {
                    }
                    column(LFS_EX_Tare_Weight_of_Pallet; "LFS Tare Weight of Pallet")
                    {
                    }
                    column(No_of_Packs; "LFS No. of Packs")
                    {
                    }
                    column(Net_Weight_per_Item; "LFS Net Weight per Item")
                    {
                    }
                    column(Total_Quantity_in_Pack; "LFS Total Quantity in Pack")
                    {
                    }
                    column(LFS_EX_Qty__In_each_Pack; "LFS Qty. In each Pack")
                    {
                    }
                    column(LFS_EX_Total_Gross_Weight; "LFS Total Gross Weight")
                    {
                    }
                    column(LFS_EX_UOM; "LFS UOM")
                    {
                    }
                    column(LFS_EX_Serial_No_; '')
                    {
                    }
                    column(LFS_EX_Custom_Serial_No_; '')
                    {
                    }
                    column(LFS_Remarks; "LFS Remarks")
                    {
                    }
                    column(LFS_EX_Packing_Dimension; "LFS Packing Dimension")
                    {
                    }
                    column(LFS_EX_Pallet_Dimension; "LFS Pallet Dimension")
                    {
                    }
                    column(LFS_EX_Quantity; "LFS Quantity")
                    {
                    }
                    column(LFS_EX_Lot_No_; "LFS Lot No.")
                    {
                    }
                    column(LFS_EX_Total_Quantity_in_Pack; "LFS Total Quantity in Pack")
                    {
                    }
                    column(TotalNetWeight; TotalNetWeight)
                    {
                    }
                    column(TotalGrossWeight; TotalGrossWeight)
                    {
                    }
                    trigger OnAfterGetRecord()
                    var
                        PackingList: Record "LFS EXIM Posted Packing Table";
                    begin
                        Clear(TotalNetWeight);
                        Clear(TotalGrossWeight);
                        PackingList.SetRange("LFS Posted Export Shipment", "LFS Packing List"."LFS Posted Export Shipment");
                        PackingList.SetRange("LFS PostExShipmentLineNo.", "LFS Packing List"."LFS PostExShipmentLineNo.");
                        if PackingList.FindSet() then
                            repeat
                                TotalNetWeight += PackingList."LFS Net Weight of Pack";
                                TotalGrossWeight += PackingList."LFS Gross Weight of Pack";
                            until PackingList.Next() = 0;
                    end;
                }
                dataitem("Value Entry"; "Value Entry")
                {
                    DataItemLinkReference = "Sales Invoice Line";
                    DataItemLink = "Document No." = field("Document No."), "Document Line No." = field("Line No."), "Item No." = field("No."), "Location Code" = field("Location Code");
                    DataItemTableView = where(Adjustment = filter(false));
                    dataitem("Item Ledger Entry"; "Item Ledger Entry")
                    {
                        DataItemLinkReference = "Value Entry";
                        DataItemLink = "Entry No." = field("Item Ledger Entry No.");
                        column(ExpiryDate; MonthYearEXP)
                        {
                        }
                        column(MfgDate; MonthYearMFG)
                        {
                        }
                        column(LotNo; "Lot No.")
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            if MonthYear = false then
                                // begin
                                // MonthYearMFG := Format("Item Ledger Entry"."LFS Mfg. Date", 0, '<Day,2>-<Month,2>-<Year4>');
                                MonthYearEXP := Format("Item Ledger Entry"."Expiration Date", 0, '<Day,2>-<Month,2>-<Year4>')
                            // end 
                            else
                                // begin
                                // MonthYearMFG := Format("Item Ledger Entry"."LFS Mfg. Date", 0, '<Month Text> <Year4>');
                                MonthYearEXP := Format("Item Ledger Entry"."Expiration Date", 0, '<Month Text> <Year4>');
                            // end;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                var
                    SalesInvoiceLine: Record "Sales Invoice Line";
                begin
                    Clear(PackingNo);
                    Clear(NetWeight);
                    Clear(GrossWeightPack);
                    Clear(sumQty);
                    // sumQty += "Sales Invoice Line".Quantity;
                    SalesInvoiceLine.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                    if SalesInvoiceLine.FindSet() then
                        repeat
                            sumQty += SalesInvoiceLine.Quantity;
                        until SalesInvoiceLine.Next() = 0;
                    PackingList.Reset();
                    PackingList.SetRange("LFS Posted Export Shipment", "Sales Invoice Line"."Shipment No.");
                    PackingList.SetRange("LFS PostExShipmentLineNo.", "Sales Invoice Line"."Shipment Line No.");
                    if PackingList.Findset() then
                        repeat
                            NetWeight := PackingList."LFS Net Weight of Pack";
                            GrossWeightPack := PackingList."LFS Gross Weight of Pack";
                            TotalNetWeight += NetWeight;
                            TotalGrossWeight += GrossWeightPack
                        until PackingList.Next() = 0;

                    RecPackingList.Reset();
                    RecPackingList.SetRange("LFS Posted Export Shipment", "Sales Invoice Line"."Shipment No.");
                    RecPackingList.SetRange("LFS PostExShipmentLineNo.", "Sales Invoice Line"."Shipment Line No.");
                    RecPackingList.SetRange("LFS Item Code", "Sales Invoice Line"."No.");
                    RecPackingList.SetRange("LFS Variant Code", "Sales Invoice Line"."Variant Code");
                    if RecPackingList.FindSet() then
                        repeat
                            SumNetWtPackList1 += RecPackingList."LFS Net Weight of Pack";
                            SumGrossWtPackList2 += RecPackingList."LFS Gross Weight of Pack";
                            SumPalletWt3 += RecPackingList."LFS Tare Weight of Pallet";
                        until RecPackingList.Next() = 0;

                    // ExpInfo.Reset();
                    // ExpInfo.SetRange("LFS Document No.", "Sales Invoice Line"."Document No.");
                    // if ExpInfo.FindFirst() then begin
                    //     IncoTermsDescription := ExpInfo."LFS Sp Notes";
                    //     CustomerOrderNo := ExpInfo."LFS Customer Order No.";
                    //     CustomerOrderDate := ExpInfo."LFS Customer Order Date 2";
                    //     ShippingMrks := ExpInfo."LFS Shipping Marks";
                    //     ContainerDetails := ExpInfo."LFS Description of Goods";
                    // end;

                    if "Sales Invoice Line"."HSN/SAC Code" <> '' then begin
                        HSCode := "Sales Invoice Line"."LFS HS Code";
                        if HSCode <> '' then
                            HSCode := 'HS Code:' + Format("Sales Invoice Line"."LFS HS Code");
                    end;

                    TotalAmount += "Sales Invoice Line".Amount;
                    eximmgmt."LFS InitTextVariable"();
                    eximmgmt."LFS FormatNoText"(Notext2, TotalAmount, "Sales Invoice Header"."Currency Code");

                    if CurrRec.get("Sales Invoice Header"."Currency Code") then
                        CurrDes := CurrRec.Description;

                    // ItemRec.Reset();
                    // if ItemRec.get("Sales Invoice Line"."No.") then
                    //     DrugLic := itemrec."LFS Drug Lic No.";

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

                    RoDTEP_Rebate_Value += "Sales Invoice Line"."LFS RoDTEP Rebate Value";
                    UnderDuty := Format("HSN/SAC Code", 4)
                end;
            }
            trigger OnAfterGetRecord()
            var
                EximIncoTerms: Record "LFS EXIM Inco Terms";
            begin
                Clear(CartonDimensions);
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
                CoutryR.SetRange(Code, "Sales Invoice Header"."LFS Country Fin Destination");
                if CoutryR.FindFirst() then
                    CountryFinalDestinationName := CoutryR.Name;

                CoutryR.Reset();
                CoutryR.SetRange(Code, "Sales Invoice Header"."Ship-to Country/Region Code");
                if CoutryR.FindFirst() then
                    ShiptoCoutry := CoutryR.Name;

                if CountReg.Get("Bill-to Country/Region Code") then
                    BilltoCountry := CountReg.Name;

                EximIncoTerms.SetRange("LFS Code", "Sales Invoice Header"."LFS Inco Terms");
                if EximIncoTerms.FindFirst() then
                    TermsDescription := EximIncoTerms."LFS Description";

                if Locationrec.get("Sales Invoice Header"."Location Code") then begin
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

                BankAcc.Reset();
                BankAcc.SETRANGE("No.", "LFS Customs Bank Account");
                if BankAcc.FINDFIRST() then begin
                    BankName := BankAcc.Name;
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
                PostedExportInformation.SetRange("LFS Document No.", "Sales Invoice Header"."No.");
                if PostedExportInformation.FindFirst() then begin
                    // ShipBillNo := PostedExportInformation."LFS Shipping Bill No.";
                    // ShipBillDate := PostedExportInformation."LFS Shipping Bill Date";
                    BOLNo := PostedExportInformation."LFS BL No/ AWB No.";
                    BOLDate := PostedExportInformation."LFS BL Date/ AWB Date";
                    // DescOfGoods := PostedExportInformation."LFS Description of Goods";
                    LCDate := PostedExportInformation."LFS LC Date";
                    LCNo := PostedExportInformation."LFS LC No.";
                    // PaymentTerms := PostedExportInformation."LFS Payment Terms";
                    // Delivery_Terms := PostedExportInformation."LFS Delivery Terms";
                    // PaymentTerms2 := PostedExportInformation."LFS Payment Terms 2";
                    // PortName := PostedExportInformation."LFS Port of Discharge";
                    // PortOfLoading := PostedExportInformation."LFS Port of Loading";
                    // BuyerIfotherthenConsignee_ := PostedExportInformation."LFS BuyerotherthanConsignee";
                    VesselFlight := PostedExportInformation."LFS Vessel/Flight No.";
                    VesselFlightNo := PostedExportInformation."LFS Vessel/Flight No.";
                    // Bank := PostedExportInformation."LFS Our Bank";
                    // PartyHSCode := PostedExportInformation."LFS HS Code";
                    // Seller_Address := PostedExportInformation."LFS Seller Name & Address";
                    // CustomerBankName := PostedExportInformation."LFS Bank Details";
                    // IncoTermsDescription := PostedExportInformation."LFS Sp Notes";
                    // CustomerOrderNo := PostedExportInformation."LFS Customer Order No.";
                    // CustomerOrderDate := PostedExportInformation."LFS Customer Order Date 2";
                    // ShippingMrks := PostedExportInformation."LFS Shipping Marks";
                    // ContainerDetails := PostedExportInformation."LFS Description of Goods";
                    // CartonDimensions := PostedExportInformation."LFS Notes";
                    if "Sales Invoice Header"."LFS ETD" = 0D then
                        ETD := PostedExportInformation."LFS ETD"
                    else
                        ETD := "Sales Invoice Header"."LFS ETD";
                    if "Sales Invoice Header"."LFS ETA" = 0D then
                        ETA := PostedExportInformation."LFS ETA"
                    else
                        ETA := "Sales Invoice Header"."LFS ETA";

                end;
                if EximPort.get("Sales Invoice Header"."LFS Port of Discharge") then
                    PortName := EximPort."LFS Port Name";
                if EximPort.get("Sales Invoice Header"."LFS Port of Loading") then
                    PortOfLoading := EximPort."LFS Port Name";
                if CountryRegion.Get("Sales Invoice Header"."LFS Country Origin of Goods") then
                    Country_of_Origin_of_Goods := CountryRegion.Name;
                if TransportMethod.Get("Sales Invoice Header"."Transport Method") then
                    TransportDesc := TransportMethod.Description;
                if CountryRegion.Get("Sales Invoice Header"."Ship-to Country/Region Code") then
                    Bill_to_County := CountryRegion.Name;
                RecLocation.Reset();
                RecLocation.SetRange(Code, "Sales Invoice Header"."Location Code");
                if RecLocation.FindFirst() then begin
                    GSTRegistrationNos.Reset();
                    GSTRegistrationNos.SetRange(Code, RecLocation."GST Registration No.");
                    if GSTRegistrationNos.FindFirst() then begin
                        LUTNumber := GSTRegistrationNos."LFS LUT No.";
                        LUTDate := GSTRegistrationNos."LFS LUT Date";
                    end;
                end;
            end;
        }

    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(MonthYears; MonthYear)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Date as Per Month and Year';
                        ToolTip = 'Specifies the Date as Per Month and Year';
                    }
                }
            }
        }
    }
    trigger OnInitReport()
    begin
        CompanyInfo.Get();
    end;

    var
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
        RecPackingList: Record "LFS EXIM Posted Packing Table";
        PostedExportInformation: Record "LFS Posted Export Information";
        Locationrec: Record Location;
        RecLocation: Record Location;
        RecPaymentTerms: Record "Payment Terms";
        RecState: Record State;
        RecState3: Record State;
        State1: Record State;
        TransportMethod: Record "Transport Method";
        eximmgmt: Codeunit "LFS EXIM General Functions";
        MonthYear: Boolean;
        UnderDuty: Code[10];
        AD_Code: Code[20];
        BankSwift: Code[20];
        BOLNo: Code[20];
        DrugLic: Code[20];
        GSTNo: code[20];
        IFSCcode: Code[20];
        License_No_: Code[20];
        No_LIC: Code[20];
        PartyHSCode: Code[20];
        PostCode: Code[20];
        VesselFlight: Code[20];
        Bank: code[50];
        BankCountryDes, CustomerOrderNo : Code[50];
        BankStateDes: Code[50];
        ShipBillNo: Code[50];
        VesselFlightNo: Code[50];
        BankName: Code[100];
        BOLDate: Date;
        CustomerOrderDate, LUT_Date : Date;
        ETA: Date;
        ETD: Date;
        Issue_Date: Date;
        LCDate: Date;
        LUTDate: Date;
        ShipBillDate: Date;
        CGSTAmt: Decimal;
        CGSTPer: Decimal;
        GrossWeightPack: Decimal;
        IGSTAmt: Decimal;
        IGSTPer: Decimal;
        NetWeight: Decimal;
        RoDTEP_Rebate_Value: Decimal;
        SGSTAmt: Decimal;
        SGSTPer: Decimal;
        SumGrossWtPackList2: Decimal;
        SumNetWtPackList1: Decimal;
        SumPalletWt3: Decimal;
        sumQty: Decimal;
        TaxAbleAmt: decimal;
        TotalAmount: Decimal;
        TotalAmountasText: Decimal;
        TotalCGST: decimal;
        TotalGrossWeight, TotalNetWeight : Decimal;
        TotalIGST: Decimal;
        TotalSGST: decimal;
        PackingNo: Integer;
        CommissioNLabel2Lbl: Label 'On FOB';
        CommissioNLabelLbl: Label 'Commission % : ';
        RoDTEPValueLabelLbl: Label 'RoDTEP  Value : ';
        Address: Text;
        Address1: Text;
        BankAddress: Text;
        BuyerIfotherthenConsignee_: Text;
        City: text;
        Conutry: text;
        CountryFinalDestinationName, paymenttermname : Text;
        CurrDes, IncoTermsDescription : text;
        DescOfGoods: Text;
        Email, MonthYearEXP, MonthYearMFG : Text;
        LCNo: Text;
        LocState: Text;
        Name: Text;
        PaymentTerms2: Text;
        TermsDescription: Text;
        Adv__Lic_File_No_: Text[30];
        BankAccNo, ComInfoState : Text[50];
        Bill_to_County: Text[50];
        BilltoCountry, CountryName_Comp, ShiptoCoutry : Text[50];
        CompInShiptoCoutry: Text[50];
        CompInShiptoState: Text[50];
        ConsigneeName: Text[50];
        Country_of_Origin_of_Goods: Text[50];
        LUTNumber: Text[50];
        Notext1: array[2] of Text[50];
        Notext2: array[2] of Text[50];
        ContainerDetails: Text[100];
        Delivery_Terms: Text[100];
        TransportDesc: Text[100];
        CustomerBankName: Text[200];
        PaymentTerms: Text[200];
        PortName: Text[250];
        PortOfLoading: Text[250];
        Consignee_Address: Text[500];
        HSCode, Seller_Address : Text[500];
        CartonDimensions, ShippingMrks : Text[1000];
}