report 72001 "LFS Commercial Invoice"
{
    ApplicationArea = All;
    Caption = 'Commercial Invoice';
    PreviewMode = PrintLayout;
    RDLCLayout = './SRC/Reports Layouts/LFS Commercial Invoice.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.";
            RequestFilterHeading = 'Posted Sales Invoice';
            column(No_SIH; "No.") { }
            column(DesofGoods; DesofGoods) { }
            column(BankSwift1; BankSwift1) { }
            column(BankName1; BankName1) { }
            column(BankAccNo1; BankAccNo1) { }
            column(BankBranchNo1; BankBranchAddress1) { }
            column(IFSCcode1; IFSCcode1) { }
            column(ADCode1; ADCode1) { }
            column(Mode_of_Transport; "Mode of Transport") { }
            column(Payment_Terms_Code; "Payment Terms Code") { }
            column(CompanyInfoPicture; CompanyInfo.Picture) { }
            column(CompName; CompanyInfo.Name) { }
            column(CompanyInfoName; CompanyInfo.Name) { }
            column(CompanyInfoAddress; CompanyInfo.Address) { }
            column(CompanyInfoAddress2; CompanyInfo."Address 2") { }
            column(CompanyInfoPhoneNo; CompanyInfo."Phone No.") { }
            column(CompanyInfoEMail; CompanyInfo."E-Mail") { }
            column(CompanyInfoGSTno; CompanyInfo."GST Registration No.") { }
            column(CompanyInfoPostcode; CompanyInfo."Post Code") { }
            column(CompanyInfoCity; CompanyInfo.City) { }
            column(CompanyInfocountry; CompanyInfo."Country/Region Code") { }
            column(CompanyPanNo; CompanyInfo."P.A.N. No.") { }
            column(CompanyPhoneNo; CompanyInfo."Phone No.") { }
            column(CompanyEmail; CompanyInfo."E-Mail") { }
            column(CompanyInfo_IEC; '') { }
            // column(CompanyInfo_IEC; CompanyInfo."I.E.C. CODE NO.") { }

            column(ExternalNo; "Sales Invoice Header"."External Document No.") { }
            // column(PoNo; "External Document No.")
            // {
            // }
            column(OrderDate; Format("Sales Invoice Header"."Order Date", 0, '<Day,2>-<Month,2>-<Year>')) { }
            column(Document_Date; "Document Date") { }
            column(NotifyParty; NotifyParty) { }
            // column(Pre_Carriage_ModeOfTransport; "Pre Carriage") { }
            column(Pre_Carriage_ModeOfTransport; '') { }
            column(VesselFlightNo; VesselFlightNo) { }
            column(Port_of_Loading; EXIMPortRec."LFS Port Name") { }
            column(Port_of_Discharge; EXIMPortRec2."LFS Port Name") { }
            column(Final_Destination; "LFS Final Destination") { }
            column(Country_of_Origin_of_Goods; CountryRegionRec.Name) { }
            column(Country_of_Final_Destination; CountryRegionRec2.Name) { }
            column(DeliveryMethod; "Shipment Method Code") { }
            // column(Inco_Terms; EXIMShippingLine.Description) { }
            column(Inco_Terms; EXIMIncoTerms."LFS Description") { }
            column(AdvLineNo; AdvLineNo) { }
            column(Currency_Code; "Currency Code") { }
            column(CustName; CustName) { }
            column(CustAdd; CustAdd) { }
            column(CustAdd2; CustAdd2) { }
            column(CustCity; CustCity) { }
            column(CustEmail; CustEmail) { }
            column(CustPAN; CustPAN) { }
            column(CustPhone; CustPhone) { }
            column(CustGSTNo; CustGSTNo) { }
            column(CustState; CustState) { }
            column(CustPostCode; CustPostCode) { }
            column(CustCountry; CustCountry) { }

            column(ShipCustName; ShipCustName) { }
            column(ShipCustAdd; ShipCustAdd) { }
            column(ShipCustAdd2; ShipCustAdd2) { }
            column(ShipCustCity; ShipCustCity) { }
            column(ShipCustState; ShipCustState) { }
            column(ShipCustPostCode; ShipCustPostCode) { }
            column(ShipCustPhone; ShipCustPhone) { }
            column(ShipCustCountry; ShipCustCountry) { }
            column(ShiipingMarks; ShiipingMarks) { }
            column(PaymentTermsDesc; PaymentTermsDesc) { }
            column(AmountInWords; Notext1[1] + ' ' + Notext1[2]) { }
            column(BankName; BankName) { }
            column(BankAccNo; BankAccNo) { }
            column(BankBranchNo; BankBranchAddress) { }
            column(IFSCcode; IFSCcode) { }
            column(BankSwift; BankSwift) { }
            column(Work_Description; WorkDescription) { }
            column(LFS_No__of_Packages; '') { }
            // column(LFS_No__of_Packages; "LFS No. of Packages") { }
            column(Ship_to_Code; "Ship-to Code") { }
            column(ShiptoAddressName; ShiptoAddressRec.Name) { }
            column(ShiptoAddressAddress; ShiptoAddressRec.Address) { }
            column(ShiptoAddressAddress2; ShiptoAddressRec."Address 2") { }
            column(ShiptoAddressCity; ShiptoAddressRec.City) { }
            column(ShiptoAddrCountryName; CountryRegionrec3.Name) { }
            column(ShiptoAddrPostCode; ShiptoAddressRec."Post Code") { }
            column(FinalDestination; FinalDestination) { }
            column(ConsignAddress; ConsignAddress) { }

            column(Location_Code; "Location Code") { }
            column(LocationName; Location.Name) { }
            column(LocationAddress; Location.Address) { }
            column(LocationAddress2; Location."Address 2") { }
            column(LocationCity; Location.City) { }
            column(LocationStateDescri; StateRec2.Description) { }
            column(LocationcoutryName; CountryRegionRec4.Name) { }
            column(LocationGSTRegistrationNo; Location."GST Registration No.") { }
            column(LocationPostCode; Location."Post Code") { }
            column(LC_No; PostedExportInfo."LFS LC No.") { }
            column(LC_Date; PostedExportInfo."LFS LC Date") { }
            column(Location_PhoneNo; Location."Phone No.") { }
            column(Location_EMail; Location."E-Mail") { }
            column(EXIMIncoTerms_Code; EXIMIncoTerms."LFS Code") { }
            column(EXIMIncoTerms_Desc; EXIMIncoTerms."LFS Description") { }
            // column(EXIMLicenseIODetails_Scrap; ScrapPercent) { }
            column(SpNotes; SpNotes) { }
            column(TotalLineDicsAmt; TotalLineDicsAmt) { }
            dataitem(Loop; Integer)
            {
                DataItemTableView = sorting(Number);
                column(Number; Number) { }
                dataitem("Sales Invoice Line"; "Sales Invoice Line")
                {
                    DataItemLink = "Document No." = field("No.");
                    DataItemLinkReference = "Sales Invoice Header";
                    DataItemTableView = sorting("Document No.", "Line No.") where(Type = filter(<> " "));
                    column(No_; "No.") { }
                    // column(Quantity;Quantity){}
                    column(Unit_of_Measure_Code; "Unit of Measure Code") { }
                    column(Unit_Price; "Unit Price") { }
                    // column(Line_Amount;"Line Amount"){}
                    column(SLAmount; SLAmount) { }
                    column(Line_Amount; "Line Amount") { }
                    column(HSNSAC_Desc; HSNSAC.Description) { }
                    column(Description; Description) { }
                    column(Description_2; "Description 2")
                    { }
                    column(Type; Type) { }
                    column(HSNTotalGrossWt; HSNTotalGrossWt) { }
                    column(HSNTotalNetQty; HSNTotalNetQty) { }
                    column(HSNTotalNoOfPCS; HSNTotalNoOfPCS) { }
                    column(HSNTotalPackages; HSNTotalPackages) { }
                    column(HSNTotalQty; HSNTotalQty) { }
                    column(MainScrapRow; MainScrapRow) { }
                    column(Aux_Qty; '') { }
                    column(Aux_UOM; '') { }
                    column(Aux_Unit_Rate; '') { }
                    column(Aux_Amount; '') { }
                    // column(Aux_Qty; "Aux Qty") { }
                    // column(Aux_UOM; "Aux UOM") { }
                    // column(Aux_Unit_Rate; "Aux Unit Rate") { }
                    // column(Aux_Amount; "Aux Amount") { }
                    column(Quantity; Quantity) { }
                    column(HSN_SAC_Code; "HSN/SAC Code") { }
                    column(LotNo; LotNo) { }
                    column(Gross_Weight; "Gross Weight") { }
                    column(No__of_Pc; '') { }

                    column(No__of_Packages; '') { }
                    // column(No__of_Pc; "No. of Pc") { }

                    // column(No__of_Packages; "No. of Packages") { }

                    column(SumOfAmount; SumOfAmount) { }
                    column(Item_Reference_No_; "Item Reference No.")
                    {
                    }
                    column(TotalHSNTotalNetQty; TotalHSNTotalNetQty) { }
                    column(TotalHSNTotalGrossWt; TotalHSNTotalGrossWt) { }
                    column(TotalHSNTotalNoOfPCS; TotalHSNTotalNoOfPCS) { }
                    column(TotalHSNTotalPackages; TotalHSNTotalPackages) { }
                    column(TotalHSNTotalQty; TotalHSNTotalQty) { }
                    column(TotalMainScrapRow; TotalMainScrapRow) { }
                    column(PoNo; PoNo)
                    {
                    }
                    trigger OnAfterGetRecord()
                    var
                        ILE: Record "Item Ledger Entry";
                        ValueEntry: Record "Value Entry";
                    begin
                        clear(PoNo);
                        // if "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item then
                        //     if PrintLineWise then
                        // begin
                        //     if "LFSCustomer Order No." = '' then
                        //         PoNo := "Sales Invoice Header"."External Document No."
                        //     else
                        //         PoNo := "Customer Order No.";
                        // end
                        // else
                        PoNo := "Sales Invoice Header"."External Document No.";

                        ValueEntry.Reset();
                        ValueEntry.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                        ValueEntry.SetRange("Document Line No.", "Sales Invoice Line"."Line No.");
                        ValueEntry.SetRange("Item No.", "Sales Invoice Line"."No.");
                        if ValueEntry.Findset() then begin
                            Clear(LotNo);
                            repeat
                                ILE.Reset();
                                ILE.SetRange("Entry No.", ValueEntry."Item Ledger Entry No.");
                                ILE.SetRange("Item No.", ValueEntry."Item No.");
                                if ILE.FindFirst() then
                                    LotNo += ', ' + ILE."Lot No.";
                            until ValueEntry.Next() = 0;

                            if StrPos(LotNo, ',') = 1 then
                                LotNo := format(DelStr(LotNo, 1, 2));
                        end;


                        Clear(SalesLineAmount);
                        SalesInvLine_Rec.Reset();
                        SalesInvLine_Rec.SetRange("Document No.", "Sales Invoice Header"."No.");
                        SalesInvLine_Rec.SetFilter(Type, '<>%1', SalesInvLine_Rec.Type::" ");
                        if SalesInvLine_Rec.FindSet() then begin
                            //repeat
                            SalesInvLine_Rec.CalcSums(Amount);
                            SalesLineAmount := SalesInvLine_Rec.Amount;
                        end;
                        // Message('%1', SalesLineAmount);

                        Clear(SLAmount);
                        if "Sales Invoice Line".Type = "Sales Invoice Line".Type::"Charge (Item)" then
                            SLAmount := "Sales Invoice Line"."Unit Price" * "Sales Invoice Line".Quantity
                        else
                            // SLAmount := "Sales Invoice Line"."Aux Qty" * "Sales Invoice Line"."Aux Unit Rate";
                        SumofSLAmount += SLAmount;


                        // SumOfAmount += "Sales Invoice Line"."Aux Amount";
                        // Message('%1', SumOfAmount);
                        //Message('%1', SumOfAmount);

                        // Clear(SumOfAmount);
                        // if "Sales Invoice Header"."Inco Terms" = 'FOB' then
                        //     SumOfAmount := SumofSLAmount;

                        InitTextVariable();

                        FormatNoText(Notext1, SalesLineAmount, "Sales Invoice Header"."Currency Code");


                        if HSNSAC.get("GST Group Code", "HSN/SAC Code") then;

                        if loop.Number = 2 then begin
                            if PrevHSNCode.contains("Sales Invoice Line"."HSN/SAC Code") then begin
                                SalesInvLine_Rec.Reset();
                                SalesInvLine_Rec.SetRange("Document No.", "Document No.");
                                SalesInvLine_Rec.SetRange("HSN/SAC Code", "HSN/SAC Code");
                                // SalesInvLine_Rec.SetFilter("HSN/SAC Code", '<>%1', '');
                                SalesInvLine_Rec.SetRange(Type, Type::Item);
                                if SalesInvLine_Rec.FindSet() then begin
                                    if HSNSAC.get(SalesInvLine_Rec."GST Group Code", SalesInvLine_Rec."HSN/SAC Code") then begin
                                        Clear(HSNTotalQty);
                                        Clear(HSNTotalGrossWt);
                                        Clear(HSNTotalPackages);
                                        Clear(HSNTotalNetQty);
                                        Clear(HSNTotalNoOfPCS);
                                        repeat
                                            // HSNTotalNetQty += SalesInvLine_Rec.Quantity;
                                            HSNTotalNetQty += SalesInvLine_Rec."Net Weight";
                                            HSNTotalGrossWt += SalesInvLine_Rec."Gross Weight";
                                        // HSNTotalPackages += SalesInvLine_Rec."Packed Qty.";
                                        // HSNTotalNoOfPCS += SalesInvLine_Rec."No. of Pc";
                                        // HSNTotalQty += SalesInvLine_Rec."Aux Qty";
                                        until SalesInvLine_Rec.Next() = 0;

                                        PrevHSNCode += ' ' + SalesInvLine_Rec."HSN/SAC Code";
                                    end;
                                end;
                                EXIMExportLicense.Reset();
                                EXIMExportLicense.SetRange("LFS Source No.", "Sales Invoice Header"."No.");
                                if EXIMExportLicense.FindFirst() then begin
                                    EXIMLicenseIODetails.Reset();
                                    // EXIMLicenseIODetails.SetRange("LFS Adv. License No.", EXIMExportLicense."License No.");
                                    EXIMLicenseIODetails.SetRange("LFS Type", EXIMLicenseIODetails."LFS Type"::Export);
                                    if EXIMLicenseIODetails.FindFirst() then
                                        ScrapPercent := EXIMLicenseIODetails."Scrap Percent"
                                    else
                                        ScrapPercent := 0;
                                end;
                                MainScrapRow := ScrapPercent * HSNTotalQty;
                                CurrReport.Skip()
                            end
                            else begin
                                SalesInvLine_Rec.Reset();
                                SalesInvLine_Rec.SetRange("Document No.", "Document No.");
                                SalesInvLine_Rec.SetRange("HSN/SAC Code", "HSN/SAC Code");
                                // SalesInvLine_Rec.SetFilter("HSN/SAC Code", '<>%1', '');
                                SalesInvLine_Rec.SetRange(Type, Type::Item);
                                if SalesInvLine_Rec.FindSet() then begin
                                    if HSNSAC.get(SalesInvLine_Rec."GST Group Code", SalesInvLine_Rec."HSN/SAC Code") then begin
                                        Clear(HSNTotalQty);
                                        Clear(HSNTotalGrossWt);
                                        Clear(HSNTotalPackages);
                                        Clear(HSNTotalNetQty);
                                        Clear(HSNTotalNoOfPCS);
                                        repeat
                                            // HSNTotalNetQty += SalesInvLine_Rec.Quantity;
                                            HSNTotalNetQty += SalesInvLine_Rec."Net Weight";
                                            HSNTotalGrossWt += SalesInvLine_Rec."Gross Weight";
                                        // HSNTotalPackages += SalesInvLine_Rec."Packed Qty.";
                                        // HSNTotalNoOfPCS += SalesInvLine_Rec."No. of Pc";
                                        // HSNTotalQty += SalesInvLine_Rec."Aux Qty";
                                        until SalesInvLine_Rec.Next() = 0;

                                        PrevHSNCode += ' ' + SalesInvLine_Rec."HSN/SAC Code";
                                    end;
                                end;

                                EXIMExportLicense.Reset();
                                EXIMExportLicense.SetRange("LFS Source No.", "Sales Invoice Header"."No.");
                                if EXIMExportLicense.FindFirst() then begin
                                    EXIMLicenseIODetails.Reset();
                                    // EXIMLicenseIODetails.SetRange("Adv. License No.", EXIMExportLicense."License No.");
                                    EXIMLicenseIODetails.SetRange("LFS Type", EXIMLicenseIODetails."LFS Type"::Export);
                                    if EXIMLicenseIODetails.FindFirst() then
                                        ScrapPercent := EXIMLicenseIODetails."Scrap Percent"
                                    else
                                        ScrapPercent := 0;
                                end;
                                MainScrapRow := ScrapPercent * HSNTotalQty;
                            end;
                        end;


                    end;
                }
                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, 2);
                end;

            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = field("No.");
                DataItemLinkReference = "Sales Invoice Header";
                DataItemTableView = sorting("Line No.") where("Document Type" = filter('Posted Invoice'));
                column(Comments; Comments) { }

            }
            trigger OnAfterGetRecord()
            var
                Country: Record "Country/Region";
                Cust: Record Customer;
                PaymentTerms: Record "Payment Terms";
                PostedExportInfo: Record "LFS Posted Export Information";
                SalesInvLine: Record "Sales Invoice Line";
                State_Rec: Record State;
            begin
                EXIMExportLicense.Reset();
                EXIMExportLicense.SetRange("LFS Source No.", "Sales Invoice Header"."No.");
                if EXIMExportLicense.FindFirst() then begin
                    EXIMLicenseIODetails.Reset();
                    EXIMLicenseIODetails.SetRange("LFS Adv. License No.", EXIMExportLicense."LFS License No.");
                    EXIMLicenseIODetails.SetRange("LFS Type", EXIMLicenseIODetails."LFS Type"::Export);
                    if EXIMLicenseIODetails.FindFirst() then
                        ScrapPercent := EXIMLicenseIODetails."Scrap Percent"
                    else
                        ScrapPercent := 0;
                end;

                SalesInvLine.Reset();
                SalesInvLine.SetRange("Document No.", "No.");
                SalesInvLine.SetRange(Type, Type::Item);
                if SalesInvLine.FindSet() then begin
                    repeat
                        if SalesInvLine."HSN/SAC Code" <> '' then begin
                            TotalHSNTotalNetQty += SalesInvLine."Net Weight";
                            TotalHSNTotalGrossWt += SalesInvLine."Gross Weight";
                            // TotalHSNTotalPackages += SalesInvLine."Packed Qty.";
                            // TotalHSNTotalNoOfPCS += SalesInvLine."No. of Pc";
                            // TotalHSNTotalQty += SalesInvLine."Aux Qty";
                        end;
                    until SalesInvLine.Next() = 0;
                    TotalMainScrapRow := ScrapPercent * TotalHSNTotalNetQty;
                end;

                SalesInvLine.Reset();
                SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
                if SalesInvLine.FindSet() then
                    repeat
                        // if "Sales Invoice Header"."Currency Factor" <> 0 then
                        //     TotalLineDicsAmt += ("SalesINvLine"."Line Discount Amount" / "Sales Invoice Header"."Currency Factor")
                        // else
                        TotalLineDicsAmt += "SalesINvLine"."Line Discount Amount";
                    until SalesInvLine.Next() = 0;



                if EXIMIncoTerms.Get("Sales Invoice Header"."LFS Inco Terms") then;
                if CountryRegionRec2.Get("Sales Invoice Header"."LFS Final Destination") then;
                if CountryRegionRec.Get("Sales Invoice Header"."LFS Country Origin of Goods") then;
                if EXIMPortRec.Get("Sales Invoice Header"."LFS Port of Loading") then;
                if EXIMPortRec2.Get("Sales Invoice Header"."LFS Port of Discharge") then;
                Clear(AdvLineNo);
                EXIMPostedExportLicence.Reset();
                EXIMPostedExportLicence.SetRange("LFS Source Type", EXIMPostedExportLicence."LFS Source Type"::Invoice);
                EXIMPostedExportLicence.SetRange("LFS Source No.", "Sales Invoice Header"."No.");
                if EXIMPostedExportLicence.FindSet() then
                    repeat
                        AdvLineNo += EXIMPostedExportLicence."LFS License No.";
                    until EXIMPostedExportLicence.Next() = 0;

                BankAcc.Reset();
                // BankAcc.SETRANGE("No.", "Sales Invoice Header"."Customs Bank Account");
                IF BankAcc.FindFirst() then BEGIN
                    BankName := BankAcc.Name;
                    BankAccNo := BankAcc."Bank Account No.";
                    BankBranchAddress := BankAcc.Address + ' ' + BankAcc."Address 2" + ' ' + BankAcc.City;
                    BankSwift := BankAcc."SWIFT Code";
                    IFSCcode := BankAcc."IFSC Code";
                END;

                BankAcc.Reset();
                // BankAcc.SETRANGE("No.", "Sales Invoice Header"."LFS Commercial Bank Account");
                IF BankAcc.FINDFIRST() THEN BEGIN
                    BankName1 := BankAcc.Name;
                    BankAccNo1 := BankAcc."Bank Account No.";
                    BankBranchAddress1 := BankAcc.Address + ' ' + BankAcc."Address 2" + ' ' + BankAcc.City;
                    BankSwift1 := BankAcc."SWIFT Code";
                    IFSCcode1 := BankAcc."IFSC Code";
                    // ADCode1 := BankAcc."AD Code";
                END;
                if Cust.get("Sales Invoice Header"."Sell-to Customer No.") then begin
                    CustName := Cust.Name;
                    CustAdd := Cust.Address;
                    CustAdd2 := Cust."Address 2";
                    CustCity := Cust.City;
                    CustPostCode := Cust."Post Code";

                    if State_Rec.get(Cust."State Code") then
                        CustState := State_Rec.Description;
                    IF Country.Get(Cust."Country/Region Code") then
                        CustCountry := Country.Name;

                    CustEmail := Cust."E-Mail";
                    CustPAN := Cust."P.A.N. No.";
                    CustPhone := Cust."Phone No.";
                    CustGSTNo := Cust."GST Registration No.";
                end;

                if "Ship-to Code" <> '' then begin
                    ShipCustName := "Ship-to Name";
                    ShipCustAdd := "Ship-to Address";
                    ShipCustAdd2 := "Ship-to Address 2";
                    ShipCustCity := "Ship-to City";
                    ShipCustPostCode := "Ship-to Post Code";
                    if State_Rec.get("GST Ship-to State Code") then
                        ShipCustState := State_Rec.Description;
                    IF Country.Get(Cust."Country/Region Code") then
                        ShipCustCountry := Country.Name;
                    ShipCustPhone := "Ship-to Phone No.";
                end
                else begin
                    if Cust.get("Sales Invoice Header"."Sell-to Customer No.") then;
                    ShipCustName := Cust.Name;
                    ShipCustAdd := Cust.Address;
                    ShipCustAdd2 := Cust."Address 2";
                    ShipCustCity := Cust.City;
                    ShipCustPostCode := Cust."Post Code";
                    if State_Rec.get(Cust."State Code") then
                        ShipCustState := State_Rec.Description;
                    IF Country.Get(Cust."Country/Region Code") then
                        ShipCustCountry := Country.Name;
                end;


                PostedExportInfo.Reset();
                PostedExportInfo.SetRange("LFS Document No.", "Sales Invoice Header"."No.");
                if PostedExportInfo.FindFirst() then begin
                    NotifyParty := GetBlobDataAsText(PostedExportInfo);
                    VesselFlightNo := PostedExportInfo."LFS Vessel/Flight No.";
                    ShiipingMarks := GetBlobShippingMarksAsText(PostedExportInfo);
                    // FinalDestination := PostedExportInfo.;
                    ConsignAddress := GetBlobConsineeAsText(PostedExportInfo);
                    // SpNotes := PostedExportInfo."LFS Sp Notes";
                end;
                if PaymentTerms.Get("Sales Invoice Header"."Payment Terms Code") then
                    PaymentTermsDesc := PaymentTerms.Description;

                Clear(WorkDescription);
                if "Sales Invoice Header"."Work Description".HasValue then begin
                    TempBlob.CreateOutStream(OutStr);
                    "Sales Invoice Header".CalcFields("Work Description");
                    "Sales Invoice Header"."Work Description".CreateInStream(InStr);
                    InStr.ReadText(WorkDescText);
                    WorkDescription := WorkDescText;
                end;
                if ShiptoAddressRec.Get("Sales Invoice Header"."Sell-to Customer No.", "Sales Invoice Header"."Ship-to Code") then
                    if CountryRegionrec3.Get(ShiptoAddressRec."Country/Region Code") then;


                if Location.Get("Sales Invoice Header"."Location Code") then begin
                    if CountryRegionRec4.Get(Location."Country/Region Code") then;
                    if StateRec2.Get(Location."State Code") then;
                end;

                EXIMExportLicense.Reset();
                EXIMExportLicense.SetRange("LFS Source No.", "Sales Invoice Header"."No.");
                if EXIMExportLicense.FindFirst() then begin
                    EXIMLicenseIODetails.Reset();
                    EXIMLicenseIODetails.SetRange("LFS Adv. License No.", EXIMExportLicense."LFS License No.");
                    EXIMLicenseIODetails.SetRange("LFS Type", EXIMLicenseIODetails."LFS Type"::Export);
                    if EXIMLicenseIODetails.FindFirst() then
                        ScrapPercent := EXIMLicenseIODetails."Scrap Percent"
                    else
                        ScrapPercent := 0;
                end;

                DesofGoods := GetBlobDescriptionAsText(PostedExportInfo);

                // EXIMExportLicense.Reset();
                // EXIMExportLicense.SetRange("Source No.", "Sales Invoice Header"."No.");
                // if EXIMExportLicense.FindFirst() then begin
                //     EXIMLicenseIODetails.Reset();
                //     EXIMLicenseIODetails.SetRange("Adv. License No.", EXIMExportLicense."License No.");
                //     EXIMLicenseIODetails.SetRange(Type, EXIMLicenseIODetails.Type::Export);
                //     if EXIMLicenseIODetails.FindFirst() then
                //         ScrapPercent := EXIMLicenseIODetails."Scrap Percent"
                //     else
                //         ScrapPercent := 0;
                // end;

                // SalesInvLine.Reset();
                // SalesInvLine.SetRange("Document No.", "No.");
                // SalesInvLine.SetRange(Type, Type::Item);
                // if SalesInvLine.FindSet() then begin
                //     repeat
                //         if SalesInvLine."HSN/SAC Code" <> '' then begin
                //             TotalHSNTotalNetQty += SalesInvLine."Net Weight";
                //             TotalHSNTotalGrossWt += SalesInvLine."Gross Weight";
                //             TotalHSNTotalPackages += SalesInvLine."Packed Qty.";
                //             TotalHSNTotalNoOfPCS += SalesInvLine."No. of Pc";
                //             TotalHSNTotalQty += SalesInvLine."Aux Qty";
                //         end;
                //     until SalesInvLine.Next() = 0;
                //     TotalMainScrapRow := ScrapPercent * TotalHSNTotalNetQty;
                // end;
            end;
        }
    }
    requestpage
    {
        // Add changes to the requestpage here
        layout
        {
            area(content)
            {
                group(General)
                {
                    field(PrintLineWise; PrintLineWise)
                    {
                        ApplicationArea = all;
                        ToolTip = 'Specifies the value of the PrintLineWise field.';
                    }
                }
            }
        }
        trigger OnOpenPage()
        begin
            PrintLineWise := true;
        end;
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        BankAcc: Record "Bank Account";
        CompanyInfo: Record "Company Information";
        CountryRegionRec: Record "Country/Region";
        CountryRegionRec2: Record "Country/Region";
        CountryRegionrec3: Record "Country/Region";
        CountryRegionRec4: Record "Country/Region";
        EXIMIncoTerms: Record "LFS EXIM Inco Terms";
        EXIMLicenseIODetails: Record "LFS EXIM License IO Details";
        EXIMPortRec: Record "LFS EXIM Port";
        EXIMPortRec2: Record "LFS EXIM Port";
        EXIMShippingLine: Record "LFS EXIM Shipping Line";
        HSNSAC: Record "HSN/SAC";
        Location: Record Location;
        PostedExportInfo: Record "LFS Posted Export Information";
        EXIMExportLicense: Record "LFS EXIM Posted Export Licence";
        EXIMPostedExportLicence: Record "LFS EXIM Posted Export Licence";
        SalesInvLine_Rec: Record "Sales Invoice Line";
        ShiptoAddressRec: Record "Ship-to Address";
        StateRec2: Record State;
        RepCheck: array[2] of Report Check;
        TempBlob: Codeunit "Temp Blob";
        PrintLineWise: Boolean;
        BankAccNo, BankAccNo1 : Code[20];
        BankSwift, BankSwift1 : Code[20];
        CustGSTNo: Code[20];
        CustPAN: Code[20];
        FinalDestination: Code[20];
        // BankBranchNo: Code[20];
        IFSCcode, IFSCcode1 : Code[20];
        PoNo: code[35];
        ADCode1: Code[50];
        VesselFlightNo: Code[50];
        AdvLineNo: Code[100];

        BankName, BankName1 : Code[100];
        PaymentTermsDesc: Code[150];
        LotNo: Code[2048];
        HSNTotalGrossWt: Decimal;
        HSNTotalNetQty: Decimal;
        HSNTotalNoOfPCS: Decimal;
        HSNTotalPackages: Decimal;
        HSNTotalQty: Decimal;
        MainScrapRow: Decimal;
        SalesLineAmount: Decimal;
        ScrapPercent: Decimal;
        SLAmount: Decimal;
        SumOfAmount: Decimal;
        SumofSLAmount: Decimal;
        TotalHSNTotalGrossWt: Decimal;
        TotalHSNTotalNetQty: Decimal;
        TotalHSNTotalNoOfPCS: Decimal;
        TotalHSNTotalPackages: Decimal;
        TotalHSNTotalQty: Decimal;

        TotalLineDicsAmt: Decimal;
        TotalMainScrapRow: Decimal;
        InStr: InStream;
        Amount_In_WordsCaptionLbl: Label 'Amount (in words):';
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

        OutStr: OutStream;
        ConsignAddress: Text;
        CustAdd: Text;
        CustAdd2: Text;
        CustCity: Text;
        CustCountry: Text;
        CustName: Text;
        CustPostCode: Text;
        CustState: Text;
        DesofGoods: TEXT;
        NotifyParty: Text;
        ShiipingMarks: Text;
        ShipCustAdd: Text;
        ShipCustAdd2: Text;
        ShipCustCity: Text;
        ShipCustCountry: Text;
        ShipCustName: Text;
        ShipCustPhone: Text;
        ShipCustPostCode: Text;
        ShipCustState: Text;
        WorkDescription: Text;

        WorkDescText: Text;
        CustPhone: Text[30];
        ExponentText: array[5] of Text[30];
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        Notext1: array[2] of Text[50];
        Notext2: array[2] of Text[50];
        SpNotes: Text[51];
        CustEmail: Text[80];
        NoTextAmt: ARRAY[2] OF Text[80];
        NoTextAmt2: ARRAY[2] OF Text[80];
        NoTextExcise: array[2] of Text[80];
        BankBranchAddress, BankBranchAddress1 : Text[130];


        Comments: Text[250];
        PrevHSNCode: Text[2048];

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
        end else
            AddToNoText(NoText, NoTextIndex, PrintExponent, 'RUPEES');
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
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + '' + ' CENT ONLY')//Currency."Currency Decimal Description"
        else
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' PAISA ONLY');
    end;

    procedure GetBlobConsineeAsText(PostedExportInfo: Record "LFS Posted Export Information"): Text
    var
        InStr: InStream;
        BlobText: Text;
    begin
        // PostedExportInfo.CalcFields("Consignee Address");
        // if PostedExportInfo."Consignee Address".HasValue then begin
        //     PostedExportInfo."Consignee Address".CreateInStream(InStr);
        //     InStr.Read(BlobText);
        // end;
        exit(BlobText);
    end;



    procedure GetBlobDataAsText(PostedExportInfo: Record "LFS Posted Export Information"): Text
    var
        InStr: InStream;
        BlobText: Text[2048];
    begin
        // PostedExportInfo.CalcFields("Notify Party");
        // if PostedExportInfo."Notify Party".HasValue then begin
        //     PostedExportInfo."Notify Party".CreateInStream(InStr);
        //     InStr.Read(BlobText);
        // end;
        exit(BlobText);
    end;

    procedure GetBlobDescriptionAsText(PostedExportInfo1: Record "LFS Posted Export Information"): Text
    var
        InStrm: InStream;
        BlobText: Text;
    begin
        // PostedExportInfo1.CalcFields("LFS Description of Goods");
        // if PostedExportInfo1."LFS Description of Goods".HasValue then begin
        //     PostedExportInfo1."LFS Description of Goods".CreateInStream(InStrm);
        //     InStrm.Read(BlobText);
        // end
        // else
        BlobText := 'COPPER TUBE';
        exit(BlobText);
    end;

    procedure GetBlobShippingMarksAsText(PostedExportInfo: Record "LFS Posted Export Information"): Text
    var
        InStr: InStream;
        BlobText: Text;
    begin
        // PostedExportInfo.CalcFields("Shipping Marks");
        // if PostedExportInfo."Shipping Marks".HasValue then begin
        //     PostedExportInfo."Shipping Marks".CreateInStream(InStr);
        //     InStr.ReadText(BlobText);
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
}