report 72014 "Certificate Of Origin"
{
    ApplicationArea = All;
    Caption = 'Certificate Of Origin';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './SRC/Reports Layouts/Certificate Of Origin.rdl';
    EnableHyperlinks = true;
    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            column(CompanyInfo_Name; CompanyInfo.Name)
            { }
            column(CompanyInfo_Address; CompanyInfo.Address)
            { }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_PostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyInfo_County; CompanyInfo.County)
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

#pragma warning disable AL0432
            column(CompanyInfo_HomePage; CompanyInfo."Home Page")
            {
            }
#pragma warning restore AL0432

            column(SrNo; SrNo)
            {
            }
            column(Ship_to_Address; "Ship-to Address")
            {

            }
            column(Ship_to_Name; "Ship-to Name")
            {

            }
            column(PortOfLoading; PortOfLoading)
            {

            }
            column(PortOfDischarge; PortOfDischarge)
            {

            }
            column(No_; "No.")
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(PostingDate; PostingDate) { }
            column(PostDate; PostDate) { }
            column(Seller_Address; Seller_Address) { }
            column(Consignee_Address; Consignee_Address)
            {

            }
            column(Consignee_Name; Consignee_Name)
            {

            }
            column(Pre_Carriage; "LFS Pre Carriage") { }
            column(Sell_to_Country_Region_Code; "Sell-to Country/Region Code")
            {

            }
            column(DescOfGoods; DescOfGoods)
            {

            }
            column(Currency_Code; "Currency Code")
            {

            }
            column(CountryDes; CountryDes)
            {

            }
            column(ShippingMarks; ShippingMarks)
            {

            }
            column(Buyer; Buyer)
            {

            }
            column(VesselNo; VesselNo)
            {

            }
            column(DDB_Value; '"LFS DDB Value"')
            {

            }

            column(Country_of_Final_Destination; "LFS Final Destination")
            { }
            column(LCNo; LCNo)
            { }
            column(Notify; Notify)
            { }
            column(SelltoCountry; SelltoCountry) { }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLinkReference = "Sales Invoice Header";
                DataItemLink = "Document No." = field("No."), "Sell-to Customer No." = field("Sell-to Customer No.");
                DataItemTableView = sorting("Document No.", "Line No.") where(Type = filter(Type::Item));
                column(ItemNo_; "No.")
                {

                }
                column(Variant_Code; "Variant Code")
                {

                }
                column(Description; Description)
                {

                }
                column(No____Kind_Of_PKDG; '"No. & Kind Of PKDG"') { }
                column(Unit_of_Measure; "Unit of Measure")
                {

                }
                column(UOM_Code; "Unit of Measure Code") { }
                column(Quantity; Quantity)
                {

                }
                column(NetWt; NetWt)
                {

                }
                column(GrossWt; GrossWt)
                {

                }
                column(PackingNo; PackingNo)
                {

                }
                column(PackingType; PackingType)
                {

                }
                column(CountInWords; Notext1[1] + ' ' + Notext1[2])
                {

                }
                // dataitem("Posted Packing List"; "Posted Packing List")
                // {
                //     DataItemLinkReference = "Sales Invoice Line";
                //     DataItemLink = "Posted Export Shipment" = field("Shipment No."), "PostedExportShipmentLineNo." = field("Shipment Line No.");
                //     column(GrossWt; "Gross Weight of Pack")
                //     {
                //     }
                //     column(NetWt; "Net Weight of Pack")
                //     {
                //     }
                //     trigger OnAfterGetRecord()
                //     begin
                //         if OldBatchNo = "Posted Packing List"."Lot No." then
                //             CurrReport.Skip();
                //         OldBatchNo := "Posted Packing List"."Lot No.";
                //     end;

                // }
                trigger OnAfterGetRecord()
                begin
                    SrNo += 1;
                    // Clear(PackingNo);
                    // Clear(GrossWt);
                    // ILE.Reset();
                    // ILE.SetRange("Document No.", "Sales Invoice Line"."Shipment No.");
                    // ILE.SetRange("Document Line No.", "Sales Invoice Line"."Shipment Line No.");
                    // if ILE.FindSet() then begin
                    //     repeat
                    //  PosPackList.SetRange("Lot No.", ."Lot No.");
                    PosPackList.SetRange("LFS Item Code", "Sales Invoice Line"."No.");
                    PosPackList.SetRange("LFS Location Code", "Sales Invoice Line"."Location Code");
                    PosPackList.SetRange("LFS Variant Code", "Sales Invoice Line"."Variant Code");
                    //PosPackList.SetRange("Select Line", true);
                    PosPackList.SetRange("LFS Posted Export Shipment", "Sales Invoice Line"."Shipment No.");
                    PosPackList.SetRange("LFS PostExShipmentLineNo.", "Sales Invoice Line"."Shipment Line No.");
                    if PosPackList.FindSet() then begin
                        repeat
                            PackingNo += 1;
                            NetWt += PosPackList."LFS Net Weight of Pack";
                            //  PackingType := PosPackList."Packing Type";
                            GrossWt += PosPackList."LFS Gross Weight of Pack";
                        until PosPackList.Next() = 0;
                    end;
                    //         end;
                    //     until ILE.Next() = 0;
                    // end;
                    // InitTextVariable();
                    // FormatNoText(Notext1, PackingNo, '');
                end;

                trigger OnPostDataItem()
                begin
                    SrNo := 0;
                end;

            }
            trigger OnAfterGetRecord()
            begin
                ExportInfoHdr.SetRange("LFS Document No.", "Sales Invoice Header"."No.");
                if ExportInfoHdr.FindFirst() then begin
                    // DescOfGoods := ExportInfoHdr.GetDescOfGoods();
                    // Buyer := ExportInfoHdr.GetBuyerIfOtherthenCongsinee();
                    // ShippingMarks := ExportInfoHdr.GetShippingMarks();
                    VesselNo := ExportInfoHdr."LFS Vessel/Flight No.";
                    LCNo := ExportInfoHdr."LFS LC No.";
                    // PortOfLoading := ExportInfoHdr."LFS Port of Loading_txt";
                    // PortOfDischarge := ExportInfoHdr."LFS Port of Discharge_txt";
                    // Seller_Address := ExportInfoHdr.GetSellerAdr();
                    //Consignee_Name := ExportInfoHdr."Consignee Name";
                    // Consignee_Address := ExportInfoHdr.GetConsigneeAdr();
                end;

                if (LCNo <> '') And ("LFS Final Destination" = 'PK') Or ("LFS Final Destination" = 'BD') then
                    Notify := ("Sell-to Customer Name" + '' + "Sell-to Address" + '' + "Sell-to Address 2" + '' + "Sell-to City" + '' + "Sell-to County" + '' + "Sell-to Country/Region Code")
                else
                    Notify := '';

                if CountryRegion.get("Sales Invoice Header"."LFS Country Origin of Goods") then
                    CountryDes := CountryRegion.name;

                if CountryRegion.Get("Sales Invoice Header"."Sell-to Country/Region Code") then
                    SelltoCountry := CountryRegion.Name;

                if PostingDate = 0D then
                    PostDate := "Sales Invoice Header"."Posting Date" else
                    PostDate := PostingDate;


            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group("Show Document Info")
                {
                    field(PostingDate; PostingDate)
                    {
                        ApplicationArea = all;
                        ToolTip = 'Specifies the value of the PostingDate field.';

                    }
                }
            }
        }
    }
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

        while StrLen(NoText[NoTextIndex] + ' ' + AddText) > MaxStrLen(NoText[1]) do begin
            NoTextIndex := NoTextIndex + 1;
            //if NoTextIndex > ArrayLen(NoText) then
            //Error(exceededStringErr, AddText);

        end;

        NoText[NoTextIndex] := DelChr(NoText[NoTextIndex] + ' ' + AddText, '<');

    end;

    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var

        Currency: Record Currency;

        PrintExponent: Boolean;

        NoTextIndex: Integer;

        TensDec: Integer;

        OnesDec: Integer;

        Ones: Integer;

        Tens: Integer;

        Hundreds: Integer;

        Exponent: Integer;
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

    end;

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
    end;

    var
        CompanyInfo: Record "Company Information";
        NetWt: Decimal;
        PackingType: Code[10];
        ValueEntries: Record "Value Entry";
        ILE: Record "Item Ledger Entry";
        BatchNo: code[50];
        Quantity1: Decimal;
        // PostedPackingDetails: Record "LFS Posted Packing Details";
        PackingNo: Integer;
        GrossWt: Decimal;
        OneLbl: Label 'ONE';
        TwoLbl: Label 'TWO';
        ThreeLbl: Label 'THREE';
        FourLbl: Label 'FOUR';
        FiveLbl: Label 'FIVE';
        SixLbl: Label 'SIX';
        SevenLbl: Label 'SEVEN';
        EightLbl: Label 'EIGHT';
        NineLbl: Label 'NINE';
        TenLbl: Label 'TEN';
        ElevenLbl: Label 'ELEVEN';
        TwelveLbl: Label 'TWELVE';
        ThireentLbl: Label 'THIRTEEN';
        FourteenLbl: Label 'FOURTEEN';
        FifteenLbl: Label 'FIFTEEN';
        SixteenLbl: Label 'SIXTEEN';
        SeventeenLbl: Label 'SEVENTEEN';
        EighteenLbl: Label 'EIGHTEEN';
        NinteenLbl: Label 'NINETEEN';
        TwentyLbl: Label 'TWENTY';
        ThirtyLbl: Label 'THIRTY';
        HundreadLbl: Label 'HUNDRED';
        FortyLbl: Label 'FORTY';
        AndLbl: Label 'AND';
        FiftyLbl: Label 'FIFTY';
        SixtyLbl: Label 'SIXTY';
        SeventyLbl: Label 'SEVENTY';
        EightyLbl: Label 'EIGHTY';
        NinetyLbl: Label 'NINETY';
        ThousandLbl: Label 'THOUSAND';
        LakhLbl: Label 'LAKH';
        CroreLbl: Label 'CRORE';
        ZeroLbl: Label 'ZERO';
        OnlyLbl: Label 'ONLY';
        Amount_In_WordsCaptionLbl: Label 'Amount (in words):';
        Notext1: array[2] of Text[50];
        Notext2: array[2] of Text[50];
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        NoTextAmt: ARRAY[2] OF Text[80];
        NoTextAmt2: ARRAY[2] OF Text[80];
        NoTextExcise: array[2] of Text[80];
        RepCheck: array[2] of Report Check;
        ExportInfoHdr: Record "LFS Posted Export Information";
        DescOfGoods: Text;
        CountryDes: Text;
        CountryRegion: Record "Country/Region";
        Buyer: Text;
        ShippingMarks: Text;
        VesselNo: Code[100];
        PosPackList: Record "LFS EXIM Posted Packing Table";
        LCNo: Text[80];
        Notify: Text;
        SelltoCountry: Text;
        SrNo: Integer;
        PostingDate: Date;
        PostDate: Date;
        PortOfLoading: Text[250];
        PortOfDischarge: Text[250];
        Seller_Address: Text;
        OldBatchNo: Code[50];
        Consignee_Name: Text;
        Consignee_Address: Text;
}