
report 72003 "Custom Invoice Draft"
{
    ApplicationArea = All;
    Caption = 'Custom Invoice Draft';
    PreviewMode = PrintLayout;
    RDLCLayout = './SRC/Reports Layouts/Custom Invoice Draft.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.";
            RequestFilterHeading = 'Posted Sales Invoice';
            column(No_SIH; "No.") { }
            column(Commission_Rate; 0) { }
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
            column(CompanyInfoCINNo; '') { }
            column(CompInfIEC; '') { }
            column(CompanyInfoState; StateRec.Description) { }
            column(CompanyInfoCity; CompanyInfo.City) { }
            column(CompanyInfocountry; CountryRegion2.Name) { }
            column(CompanyPanNo; CompanyInfo."P.A.N. No.") { }
            column(ExternalNo; "Sales Invoice Header"."External Document No.") { }

            column(OrderDate; Format("Sales Invoice Header"."Order Date", 0, '<Day,2>-<Month,2>-<Year>')) { }
            column(Document_Date; "Document Date") { }
            column(NotifyParty; NotifyParty) { }
            column(ConsignAddress; ConsignAddress) { }
            column(Pre_Carriage_ModeOfTransport; "LFS Pre Carriage") { }
            column(VesselFlightNo; VesselFlightNo) { }
            column(Port_of_Loading; EXIMPort."LFS Port Name") { }
            column(Port_of_Discharge; EXIMPortRec."LFS Port Name") { }
            column(Final_Destination; "LFS Final Destination") { }
            column(Country_of_Origin_of_Goods; CountryRegionRec.Name) { }
            column(Country_of_Final_Destination; CountryRegion.Name) { }
            column(DeliveryMethod; "Shipment Method Code") { }
            column(Inco_Terms; EXIMIncoTerms."LFS Description") { }
            column(AdvLineNo; AdvLineNo) { }
            column(Currency_Code; "Currency Code") { }
            column(CustName; CustName) { }
            column(CustAdd; CustAdd) { }
            column(CustAdd2; CustAdd2) { }
            column(CustCity; CustCity) { }
            column(CustState; CustState) { }
            column(CustPostCode; CustPostCode) { }
            column(CustCountry; CustCountry) { }
            column(BuyerShortName; BuyerShortName) { }
            column(ShiipingMarks; ShiipingMarks) { }
            column(BuyersAddressName; BuyersAddressName) { }
            column(DesofGoods; DesofGoods) { }
            column(PaymentTermsDesc; PaymentTermsDesc) { }
            column(AmountInWords; Notext1[1] + ' ' + Notext1[2]) { }
            column(BankName; BankName) { }
            column(BankAccNo; BankAccNo) { }
            column(BankBranchNo; BankBranchAddress) { }
            column(IFSCcode; IFSCcode) { }
            column(BankSwift; BankSwift) { }
            column(BankName1; BankName1) { }
            column(BankAccNo1; BankAccNo1) { }
            column(BankBranchNo1; BankBranchAddress1) { }
            column(IFSCcode1; IFSCcode1) { }
            column(ADCode1; ADCode1) { }
            column(BankSwift1; BankSwift1) { }
            column(Work_Description; WorkDescription) { }
            column(LFS_No__of_Packages; '') { }
            column(Ship_to_Code; "Ship-to Code") { }
            column(ShiptoAddressName; ShiptoAddressRec.Name) { }
            column(ShiptoAddressAddress; ShiptoAddressRec.Address) { }
            column(ShiptoAddressAddress2; ShiptoAddressRec."Address 2") { }
            column(ShiptoAddressCity; ShiptoAddressRec.City) { }
            column(ShiptoAddrCountryName; CountryRegionrec3.Name) { }
            column(ShiptoAddrPostCode; ShiptoAddressRec."Post Code") { }
            column(FinalDestination; FinalDestination) { }
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
            // column(EXIMLicenseIODetails_Scrap; ScrapPercent) { }
            column(TotalLineDicsAmt; TotalLineDicsAmt) { }
            column(LessFrIns; LessFrIns) { }
            column(Shipment_Method_Code; "Shipment Method Code") { }
            column(SpNotes; SpNotes) { }
            column(TotalHSNTotalNetQty; TotalHSNTotalNetQty) { }
            column(TotalHSNTotalGrossWt; TotalHSNTotalGrossWt) { }
            column(TotalHSNTotalNoOfPCS; TotalHSNTotalNoOfPCS) { }
            column(TotalHSNTotalPackages; TotalHSNTotalPackages) { }
            column(TotalHSNTotalQty; TotalHSNTotalQty) { }
            column(TotalMainScrapRow; TotalMainScrapRow) { }
            column(Cont_No; ContactRec."No.") { }
            column(ContName; ContactRec.Name) { }
            column(ContCity; ContactRec.City) { }
            column(ContAddr; ContactRec.Address) { }
            column(ContAddr2; ContactRec."Address 2") { }
            column(ContPostCode; ContactRec."Post Code") { }
            column(ContCtryName; ContactCountry.Name) { }
            column(FooterCompanyAddress; CompanyInfo.Address + ', ' + CompanyInfo."Address 2" + ', ' + CompanyInfo.City + ', ' + CompanyStateDesc + ', ' + CountryRegionDesc + '-' + CompanyInfo."Post Code") { }
#pragma warning disable AL0432
            column(FooterAddress2; 'Tel No.: ' + CompanyInfo."Phone No." + ' | E-Mail : ' + CompanyInfo."E-Mail" + ' | ' + 'Website: ' + CompanyInfo."Home Page") { }
#pragma warning restore AL0432{}
            column(FooterCompanyAddressHO; LocationHO.Address + ', ' + LocationHO."Address 2" + ', ' + LocationHO.City + ', ' + LocationStateDescHO + ', ' + Loc_CountryRegionDescHO + '-' + LocationHO."Post Code") { }
#pragma warning disable AL0432
            column(FooterAddress2HO; 'Tel No.: ' + LocationHO."Phone No." + ' | E-Mail: ' + LocationHO."E-Mail" + Crlf + 'Website: ' + LocationHO."Home Page" + '/www.mehtatubes.com') { }
#pragma warning restore AL0432{}

            dataitem(Loop; Integer)
            {
                DataItemTableView = sorting(Number);
                column(Number; Number) { }
                dataitem("Sales Invoice Line";
                "Sales Invoice Line")
                {
                    DataItemLink = "Document No." = field("No.");
                    DataItemLinkReference = "Sales Invoice Header";
                    // DataItemTableView = sorting("Document No.", "Line No.");
                    DataItemTableView = sorting("Document No.", "Line No.") where("No." = filter(<> ''));
                    column(Line_No_; "Line No.") { }
                    column(No_; "No.") { }
                    column(Type; Type) { }
                    column(Description; Description) { }
                    column(Description_2; "Description 2")
                    {

                    }
                    column(Aux_Qty; '') { }
                    column(Aux_UOM; '') { }
                    column(Aux_Unit_Rate; '') { }
                    column(Aux_Amount; '') { }
                    column(Quantity; Quantity) { }
                    column(HSN_SAC_Code; "HSN/SAC Code") { }
                    column(LotNo; LotNo) { }
                    column(Gross_Weight; "Gross Weight") { }
                    column(No__of_Pc; '') { }

                    column(No__of_Packages; '') { }

                    column(SumOfAmount; SumOfAmount) { }
                    column(PostedExportLicenceNo; PostedExportLicence."LFS License No.")
                    {

                    }
                    column(Item_Reference_No_; "Item Reference No.")
                    {

                    }
                    column(AuxLBS; AuxLBS)
                    {

                    }
                    column(GrosWightLBS; GrosWightLBS)
                    {

                    }
                    column(AuxFEET; Uom)
                    { }
                    column(GrosWightFEET; GrosWightFEET)
                    {

                    }
                    column(FirstUOM; '') { }
                    column(SLAmount; SLAmount) { }

                    column(ItemQuantity; ItemQuantity) { }
                    column(HSNSAC_Desc; HSNSAC.Description) { }
                    column(HSNTotalGrossWt; HSNTotalGrossWt) { }
                    column(HSNTotalNetQty; HSNTotalNetQty) { }
                    column(HSNTotalNoOfPCS; HSNTotalNoOfPCS) { }
                    column(HSNTotalPackages; HSNTotalPackages) { }
                    column(HSNTotalQty; HSNTotalQty) { }
                    column(MainScrapRow; MainScrapRow) { }
                    column(PoNo; PoNo)
                    {
                    }


                    // trigger OnPreDataItem()
                    // begin
                    //     "Sales Invoice Line".SetFilter("No.", '<>1%', '');
                    // end;

                    trigger OnAfterGetRecord()
                    var
                        ILE: Record "Item Ledger Entry";
                        SalesHeader: Record "Sales Header";
                        SalesInvLine: Record "Sales Invoice Line";
                        SalesInvLine_rec: Record "Sales Invoice Line";
                    begin
                        Crlf := TypeHelper.CRLFSeparator();
                        // Uom := SalesInvLine."Aux UOM";

                        clear(PoNo);
                        if "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item then
                            // if PrintLineWise then begin
                            //     if "Customer Order No." = '' then
                            //         PoNo := "Sales Invoice Header"."External Document No."
                            //     else
                            //         PoNo := "Customer Order No.";
                            // end
                            // else
                                PoNo := "Sales Invoice Header"."External Document No.";

                        Clear(SLAmount);
                        if "Sales Invoice Line".Type = "Sales Invoice Line".Type::"Charge (Item)" then
                            SLAmount := "Sales Invoice Line"."Unit Price" * "Sales Invoice Line".Quantity;
                        // else
                        //     SLAmount := "Sales Invoice Line"."Aux Qty" * "Sales Invoice Line"."Aux Unit Rate";
                        SumofSLAmount += SLAmount;
                        // if "Sales Invoice Line"."Aux UOM" = 'LBS' then begin
                        //     AuxLBS := "Sales Invoice Line"."Aux Qty";
                        GrosWightLBS := "Sales Invoice Line"."Gross Weight" * 2.20462;
                        // end;
                        // if "Sales Invoice Line"."Aux UOM" = 'FEET' then begin
                        //     AuxFEET := "Sales Invoice Line"."Aux Qty";
                        GrosWightFEET := "Sales Invoice Line"."Gross Weight" * 2.20462;
                        // end;

                        if HSNSAC.get("GST Group Code", "HSN/SAC Code") then;

                        PostedExportLicence.Reset();
                        PostedExportLicence.SetRange(PostedExportLicence."LFS Source Type", PostedExportLicence."LFS Source Type"::Invoice);
                        PostedExportLicence.SetRange("LFS Source No.", "Sales Invoice Line"."Document No.");
                        PostedExportLicence.SetRange("LFS Source line No.", "Sales Invoice Line"."Line No.");
                        if PostedExportLicence.FindFirst() then;

                        // ILE.Reset();
                        // ILE.SetRange("Entry Type", ILE."Entry Type"::Sale);
                        // ILE.SetRange("Source Type", ILE."Source Type"::Customer);
                        // ILE.SetRange("Source No.", "Sales Invoice Line"."Sell-to Customer No.");
                        // ILE.SetRange("Item No.", "Sales Invoice Line"."No.");
                        // ILE.SetRange("Document No.", "Sales Invoice Line"."Shipment No.");
                        // if ILE.FindFirst() then
                        //     LotNo := ILE."Lot No.";

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
                        // if "Sales Invoice Header"."Currency Factor" <> 0 then
                        //     SumOfAmount += "Sales Invoice Line"."Aux Amount" - "Sales Invoice Line"."Freight Value Per Type (FCY)" - "Sales Invoice Line"."Insurance Value Per Type (FCY)" - ("Line Discount Amount" / "Sales Invoice Header"."Currency Factor")
                        // else

                        Clear(TotalLineDicsAmt);
                        clear(ItemQuantity);
                        clear(LessFrIns);

                        SalesInvLine.Reset();
                        SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                        SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
                        if SalesInvLine.FindSet() then
                            repeat
                                // if "Sales Invoice Header"."Currency Factor" <> 0 then
                                //     TotalLineDicsAmt += ("SalesINvLine"."Line Discount Amount" / "Sales Invoice Header"."Currency Factor")
                                // else
                                TotalLineDicsAmt += "SalesINvLine"."Line Discount Amount";
                                ItemQuantity += SalesInvLine.Quantity;
                                LessFrIns += SalesInvLine."LFS Freight Value (FCY)" + SalesInvLine."LFS Insurance Value (FCY)";
                            until SalesInvLine.Next() = 0;


                        // SumOfAmount += "Sales Invoice Line"."Aux Amount" - "Sales Invoice Line"."Freight Value Per Type (FCY)" - "Sales Invoice Line"."Insurance Value Per Type (FCY)" - "Line Discount Amount";

                        Clear(ForInWrdSumOfAmount);
                        if "Sales Invoice Header"."LFS Inco Terms" = 'FOB' then
                            ForInWrdSumOfAmount := SumofSLAmount
                        else
                            ForInWrdSumOfAmount := SumofSLAmount - (LessFrIns + TotalLineDicsAmt);

                        InitTextVariable();

                        FormatNoText(Notext1, ForInWrdSumOfAmount, "Sales Invoice Header"."Currency Code");

                        if HSNSAC.get("GST Group Code", "HSN/SAC Code") then;

                        if loop.Number = 2 then
                            if PrevHSNCode.contains("Sales Invoice Line"."HSN/SAC Code") then begin
                                SalesInvLine_Rec.Reset();
                                SalesInvLine_Rec.SetRange("Document No.", "Document No.");
                                SalesInvLine_Rec.SetRange("HSN/SAC Code", "HSN/SAC Code");
                                // SalesInvLine_Rec.SetFilter("HSN/SAC Code", '<>%1', '');
                                SalesInvLine_Rec.SetRange(Type, Type::Item);
                                if SalesInvLine_Rec.FindSet() then
                                    repeat
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
                                    until SalesInvLine_Rec.Next() = 0;
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
                                //MainScrapRow := ScrapPercent * HSNTotalQty;
                                MainScrapRow := ScrapPercent * HSNTotalNetQty;
                                CurrReport.Skip()
                            end
                            else begin
                                SalesInvLine_Rec.Reset();
                                SalesInvLine_Rec.SetRange("Document No.", "Document No.");
                                SalesInvLine_Rec.SetRange("HSN/SAC Code", "HSN/SAC Code");
                                // SalesInvLine_Rec.SetFilter("HSN/SAC Code", '<>%1', '');
                                SalesInvLine_Rec.SetRange(Type, Type::Item);
                                if SalesInvLine_Rec.FindSet() then
                                    repeat
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
                                    until SalesInvLine_Rec.Next() = 0;

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
                                //MainScrapRow := ScrapPercent * HSNTotalQty;
                                MainScrapRow := ScrapPercent * HSNTotalNetQty;
                            end;
                    end;
                }
                dataitem("Posted Export Licence"; "LFS EXIM Posted Export Licence")
                {
                    DataItemLink = "LFS Source No." = field("Document No.");
                    DataItemLinkReference = "Sales Invoice Line";
                    DataItemTableView = sorting("LFS Source Type", "LFS Source No.", "LFS Source line No.", "LFS Line No.");
                    dataitem("EXIM License IO Details"; "LFS EXIM License IO Details")
                    {
                        DataItemLink = "LFS Adv. License No." = field("LFS License No.");
                        DataItemLinkReference = "Posted Export Licence";
                        DataItemTableView = sorting("LFS Adv. License No.", "LFS Line No.");
                        column(Scrap_Percent;
                        "Scrap Percent")
                        {
                        }
                        column(Item_Description; "LFS Item Description")
                        {
                        }
                        column(Type_License; "LFS Type") { }
                        column(MainScrapRowNew; MainScrapRowNew) { }

                        trigger OnAfterGetRecord()
                        begin
                            if Loop.Number = 2 then begin
                                if IODetailsLoop.Contains("LFS Item Description") then
                                    CurrReport.Skip();
                            end
                            else
                                CurrReport.Skip();

                            MainScrapRowNew := "Scrap Percent" * HSNTotalNetQty;

                            IODetailsLoop += '|' + "LFS Item Description";
                        end;

                        trigger OnPreDataItem()
                        begin
                            "EXIM License IO Details".SetFilter("LFS Type", '=%1', "LFS Type"::Import);
                            if Loop.Number = 1 then CurrReport.skip();
                        end;
                    }
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
                CustRec: Record Customer;
                PaymentTerms: Record "Payment Terms";
                SalesInvLine: Record "Sales Invoice Line";
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

                if StateRec.Get(CompanyInfo."State Code") then;
                if CountryRegion2.Get(CompanyInfo."Country/Region Code") then;
                if EXIMPortRec.Get("LFS Port of Discharge") then;
                if EXIMPort.Get("LFS Port of Loading") then;
                if CountryRegion.Get("LFS Final Destination") then;
                if CountryRegionRec.Get("LFS Country Origin of Goods") then;
                if PaymentTerms.get("Payment Terms Code") then;
                IF ShipmentMethod.Get("Shipment Method Code") then;
                if EXIMIncoTerms.Get("LFS Inco Terms") then;
                // if ContactRec.Get("Sales Invoice Header"."LFS Notify Party") then
                if ContactCountry.Get(ContactRec."Country/Region Code") then;
                Clear(AdvLineNo);
                EXIMPostedExportLicence.Reset();
                EXIMPostedExportLicence.SetRange("LFS Source Type", EXIMPostedExportLicence."LFS Source Type"::Invoice);
                EXIMPostedExportLicence.SetRange("LFS Source No.", "Sales Invoice Header"."No.");
                if EXIMPostedExportLicence.FindSet() then
                    repeat
                        AdvLineNo := EXIMPostedExportLicence."LFS License No.";
                    until EXIMPostedExportLicence.Next() = 0;
                BankAcc.Reset();
                BankAcc.SETRANGE("No.", "Sales Invoice Header"."LFS Customs Bank Account");
                IF BankAcc.FINDFIRST() THEN BEGIN
                    BankName := BankAcc.Name;
                    BankAccNo := BankAcc."Bank Account No.";
                    BankBranchAddress := BankAcc.Address + ' ' + BankAcc."Address 2" + ' ' + BankAcc.City;
                    BankSwift := BankAcc."SWIFT Code";
                    IFSCcode := BankAcc."IFSC Code";
                END;
                BankAcc.Reset();
                BankAcc.SETRANGE("No.", "Sales Invoice Header"."LFS Comm. Bank Account");
                IF BankAcc.FINDFIRST() THEN BEGIN
                    BankName1 := BankAcc.Name;
                    BankAccNo1 := BankAcc."Bank Account No.";
                    BankBranchAddress1 := BankAcc.Address + ' ' + BankAcc."Address 2" + ' ' + BankAcc.City;
                    BankSwift1 := BankAcc."SWIFT Code";
                    IFSCcode1 := BankAcc."IFSC Code";
                    // ADCode1 := BankAcc."AD Code";
                END;
                // IF PrintBuyerInformation then
                //     if Cust.get("Sales Invoice Header"."Sell-to Customer No.") then begin
                //         CustName := Cust.Name;
                //         CustAdd := Cust.Address;
                //         CustAdd2 := Cust."Address 2";
                //         CustCity := Cust.City;
                //         CustPostCode := Cust."Post Code";
                //         CustState := Cust."State Code";
                //         IF Country.Get(Cust."Country/Region Code") then
                //             CustCountry := Country.Name;
                //     end;

                if Cust.get("Sales Invoice Header"."Sell-to Customer No.") then begin
                    CustName := Cust.Name;
                    CustAdd := Cust.Address;
                    CustAdd2 := Cust."Address 2";
                    CustCity := Cust.City;
                    CustPostCode := Cust."Post Code";
                    CustState := Cust."State Code";
                    IF Country.Get(Cust."Country/Region Code") then
                        CustCountry := Country.Name;
                end;
                if CustRec.get("Sales Invoice Header"."Sell-to Customer No.") then
                    BuyerShortName := GetBlobBuyerShortNameAsText(CustRec);

                Clear(NotifyParty);

                PostedExportInfo.Reset();
                PostedExportInfo.SetRange("LFS Document No.", "Sales Invoice Header"."No.");
                if PostedExportInfo.FindFirst() then begin
                    NotifyParty := GetBlobDataAsText(PostedExportInfo);
                    VesselFlightNo := PostedExportInfo."LFS Vessel/Flight No.";
                    ShiipingMarks := GetBlobShippingMarksAsText(PostedExportInfo);
                    IF NOT PrintBuyerInformation then
                        BuyersAddressName := GetBlobBuyersAddressNameAsText(PostedExportInfo);
                    DesofGoods := GetBlobDescriptionAsText(PostedExportInfo);
                    ConsignAddress := GetBlobConsineeAsText(PostedExportInfo);
                    // FinalDestination := PostedExportInfo."LFS Final Destination";
                    // SpNotes := PostedExportInfo."Sp Notes";
                end;


                if PaymentTerms.Get("Sales Invoice Header"."Payment Terms Code") then
                    PaymentTermsDesc := PaymentTerms.Description;
                Clear(WorkDescription);
                if "Sales Invoice Header"."Work Description".HasValue then begin
                    TempBlob.CreateOutStream(OutStr);
                    "Sales Invoice Header".CalcFields("Work Description");
                    "Sales Invoice Header"."Work Description".CreateInStream(InStr);
                    InStr.Read(WorkDescText);
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

                Clear(companyStateDesc);
                Clear(CompanyStateCode);
                //State Code & DESC FROM COMPANY INFO+++
                StateRec.Reset();
                if StateRec.Get(CompanyInfo."State Code") then begin
                    CompanyStateDesc := StateRec.Description;
                    CompanyStateCode := StateRec."State Code (GST Reg. No.)";
                end;

                Clear(CountryRegionDesc);
                //COUNTRY DESC FROM COMPANY INFO+++
                Country_Region.Reset();
                if Country_Region.Get(CompanyInfo."Country/Region Code") then
                    CountryRegionDesc := Country_Region.Name;
            end;

            trigger OnPreDataItem()
            begin
                Clear(IODetailsLoop);
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
                    field(PrintBuyerInformation; PrintBuyerInformation)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Buyer Information';
                        ToolTip = 'Print Buyer Information';
                    }
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
        ContactRec: Record Contact;
        ContactCountry: Record "Country/Region";
        Country_Region: Record "Country/Region";
        CountryRegion: Record "Country/Region";
        CountryRegion2: Record "Country/Region";
        CountryRegionRec: Record "Country/Region";
        CountryRegionRec3: Record "Country/Region";
        CountryRegionRec4: Record "Country/Region";
        EXIMIncoTerms: Record "LFS EXIM Inco Terms";
        EXIMLicenseIODetails: Record "LFS EXIM License IO Details";
        EXIMPort: Record "LFS EXIM Port";
        EXIMPortRec: Record "LFS EXIM Port";
        HSNSAC: Record "HSN/SAC";
        Location: Record Location;
        LocationHO: Record Location;
        PostedExportInfo: Record "LFS Posted Export Information";
        EXIMExportLicense: Record "LFS EXIM Posted Export Licence";
        EXIMPostedExportLicence: Record "LFS EXIM Posted Export Licence";
        PostedExportLicence: Record "LFS EXIM Posted Export Licence";
        ShiptoAddressRec: Record "Ship-to Address";
        ShipmentMethod: Record "Shipment Method";
        StateRec: Record State;
        StateRec2: Record State;
        ValueEntry: Record "Value Entry";
        TempBlob: Codeunit "Temp Blob";
        TypeHelper: Codeunit "Type Helper";
        PrintBuyerInformation: Boolean;
        PrintLineWise: Boolean;
        CompanyStateCode, CompanyStateCodeHO : code[10];
        Uom: Code[10];
        BankSwift: Code[20];
        BankSwift1: Code[20];
        FinalDestination: Code[20];
        IFSCcode: Code[20];
        IFSCcode1: Code[20];
        BankAccNo: Code[30];
        BankAccNo1: Code[30];
        PoNo: Code[35];
        ADCode1: Code[50];
        VesselFlightNo: Code[50];
        AdvLineNo: Code[100];
        BankName: Code[100];
        BankName1: Code[100];
        PaymentTermsDesc: Code[100];
        LotNo: Code[2048];

        AuxFEET: Decimal;
        AuxLBS: Decimal;
        ForInWrdSumOfAmount: Decimal;
        GrosWightFEET: Decimal;
        GrosWightLBS: Decimal;
        HSNTotalGrossWt: Decimal;

        HSNTotalNetQty: Decimal;
        HSNTotalNoOfPCS: Decimal;
        HSNTotalPackages: Decimal;
        HSNTotalQty: Decimal;
        ItemQuantity: Decimal;
        LessFrIns: Decimal;
        MainScrapRow: Decimal;
        MainScrapRowNew: Decimal;
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
        BuyersAddressName: Text;
        BuyerShortName: Text;
        CompanyStateDesc, LocationStateDescHO : Text;
        ConsignAddress: Text;
        CountryRegionDesc, Loc_CountryRegionDescHO : Text;
        CustAdd: Text;
        CustAdd2: Text;
        CustCity: Text;
        CustCountry: Text;
        CustName: Text;
        CustPostCode: Text;
        CustState: Text;
        DesofGoods: TEXT;
        IODetailsLoop: Text;
        NotifyParty: Text;
        ShiipingMarks: Text;
        WorkDescription: Text;
        WorkDescText: Text;
        CRLF: Text[2];
        ExponentText: array[5] of Text[30];
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        Notext1: array[2] of Text[50];
        Notext2: array[2] of Text[50];
        SpNotes: Text[51];
        NoTextAmt: array[2] of Text[80];
        NoTextAmt2: array[2] of Text[80];
        NoTextExcise: array[2] of Text[80];
        BankBranchAddress, BankBranchAddress1 : Text[200];
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

    procedure GetBlobBuyersAddressNameAsText(PostedExportInfo: Record "LFS Posted Export Information"): Text
    var
        BlobText: Text;
    begin
        // PostedExportInfo.CalcFields("Buyer Name & Address");
        // if PostedExportInfo."Buyer Name & Address".HasValue then begin
        //     PostedExportInfo."Buyer Name & Address".CreateInStream(InStr);
        //     InStr.Read(BlobText);
        // end;
        exit(BlobText);
    end;

    procedure GetBlobBuyerShortNameAsText(CustomerRec2: Record Customer): Text
    var
        InStr2: InStream;
        BlobText: Text;
    begin
        // CustomerRec2.CalcFields("Buyer Short Name");
        // if CustomerRec2."Buyer Short Name".HasValue then begin
        //     CustomerRec2."Buyer Short Name".CreateInStream(InStr2);
        //     InStr2.Read(BlobText);
        // end;
        exit(BlobText);
    end;

    procedure GetBlobConsineeAsText(PostedExportInfo3: Record "LFS Posted Export Information"): Text
    var
        InStr3: InStream;
        BlobText: Text;
    begin
        // PostedExportInfo3.CalcFields("Consignee Address");
        // if PostedExportInfo3."Consignee Address".HasValue then begin
        //     PostedExportInfo3."Consignee Address".CreateInStream(InStr3);
        //     InStr3.Read(BlobText);
        // end;
        exit(BlobText);
    end;

    procedure GetBlobDataAsText(PostedExportInfo1: Record "LFS Posted Export Information"): Text
    var
        InStr1: InStream;
        BlobText: Text;
    begin
        // PostedExportInfo1.CalcFields("Notify Party");
        // if PostedExportInfo1."Notify Party".HasValue then begin
        //     PostedExportInfo1."Notify Party".CreateInStream(InStr1);
        //     InStr1.Read(BlobText);
        // end;
        exit(BlobText);
    end;

    procedure GetBlobDescriptionAsText(PostedExportInfo1: Record "LFS Posted Export Information"): Text
    var
        InStrm: InStream;
        BlobText: Text;
    begin
        // PostedExportInfo1.CalcFields("Description of Goods");
        // if PostedExportInfo1."Description of Goods".HasValue then begin
        //     PostedExportInfo1."Description of Goods".CreateInStream(InStrm);
        //     InStrm.Read(BlobText);
        // end
        // else
        BlobText := 'COPPER TUBE';
        exit(BlobText);
    end;

    procedure GetBlobShippingMarksAsText(PostedExportInfo2: Record "LFS Posted Export Information"): Text
    var
        InStr2: InStream;
        BlobText: Text;
    begin
        // PostedExportInfo2.CalcFields("Shipping Marks");
        // if PostedExportInfo2."Shipping Marks".HasValue then begin
        //     PostedExportInfo2."Shipping Marks".CreateInStream(InStr2);
        //     InStr2.Read(BlobText);
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