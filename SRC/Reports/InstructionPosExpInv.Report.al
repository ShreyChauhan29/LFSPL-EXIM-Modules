report 72015 "Instruction-PosExpInv"
{
    ApplicationArea = All;
    Caption = 'Instruction';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './SRC/Reports Layouts/Instruction--PosExpInv Report.rdl';
    dataset
    {
        dataitem(SalesInvoiceHeader; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            column(No_; "No.") { }
            column(Posting_Date; "Posting Date") { }
            column(CompanyInfo_Name; CompanyInfo.Name)
            { }
            column(CompanyInfo_Address; CompanyInfo.Address)
            { }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            { }
            column(CompanyInfo_City; CompanyInfo.City)
            { }
            column(CompanyInfo_PostCode; CompanyInfo."Post Code")
            { }
            column(CompanyInfo_County; CompanyInfo.County)
            { }
            column(CompanyInfo_PhoneNo; CompanyInfo."Phone No.")
            { }
            column(CompanyInfo_FaxNo; CompanyInfo."Fax No.")
            { }
            column(CompanyInfo_EMail; CompanyInfo."E-Mail")
            { }

#pragma warning disable AL0432
            column(CompanyInfo_HomePage; CompanyInfo."Home Page")
            {
            }
#pragma warning restore AL0432
            column(CompGSTN; CompanyInfo."GST Registration No.") { }
            column(CompaARN; CompanyInfo."ARN No.") { }
            column(Phone; Phone)
            { }
            column(Fax; Fax)
            { }
            column(Email; Email)
            { }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            { }
            column(Sell_to_Customer_Name_2; "Sell-to Customer Name 2")
            { }
            column(Sell_to_Address; "Sell-to Address")
            { }
            column(Sell_to_Address_2; "Sell-to Address 2")
            { }
            column(Sell_to_City; "Sell-to City")
            { }
            column(Sell_to_Country_Region_Code; "Sell-to Country/Region Code")
            { }
            column(Sell_to_County; "Sell-to County")
            { }
            column(Sell_to_Post_Code; "Sell-to Post Code")
            { }
            column(Ship_to_Customer; "Ship-to Customer")
            { }
            column(Ship_to_Address; "Ship-to Address")
            { }
            column(Ship_to_Address_2; "Ship-to Address 2")
            { }
            column(Ship_to_City; "Ship-to City")
            { }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code")
            { }
            column(Ship_to_County; "Ship-to County")
            { }
            column(Ship_to_Post_Code; "Ship-to Post Code")
            { }
            column(Port_of_Loading; "LFS Port of Loading")
            {
            }
            column(PortName; PortName) { }
            column(Port_of_Discharge; "LFS Port of Discharge")
            {
            }
            column(Pre_Carriage; "LFS Pre Carriage")
            {
            }
            column(Final_Destination; "LFS Final Destination")
            {
            }
            column(Vessel_Flight_No_; Vessel_Flight_No_) { }
            column(ContainerNo; ContainerNo) { }
            column(Freight; Freight) { }
            column(Freight_Manual_; '"Freight(Manual)"')
            { }
            column(DescOfGoods; DescOfGoods)
            { }
            column(ShippingMarks; ShippingMarks)
            { }
            column(Notify; Notify)
            { }
            column(Additional_Information; '"Additional Information"')
            { }
            column(BLNotes; BLNotes) { }
            column(SpNotes; SpNotes) { }
            column(LocName; Name) { }
            column(LocAddress; Address) { }
            column(LocAddress1; Address1) { }
            column(LocPostCode; PostCode) { }
            column(LocCity; City) { }
            column(LocGSTNo; GSTNo) { }
            column(LocState; LocState) { }
            column(LocConutry; Conutry) { }
            column(RFID_E_Seal_No_; '"RFID E-Seal No."') { }
            column(Liner_Seal_No_; '"Liner Seal No."') { }
            column(CompIEC; 'CompanyInfo."I.E.C. CODE NO."') { }
            column(PO_No; "External Document No.") { }
            column(ShipBillNo; "LFS Shipping Bill No.") { }
            column(ShipBillDate; "LFS Shipping Bill Date") { }
            column(Country_of_Origin_of_Goods; "LFS Country Origin of Goods") { }
            column(HC; 'HC') { }
            column(BillLadingNo; '"LFS Bill of Lading No."') { }
            column(BillLadingDate; '"LFS Bill of Lading Date"') { }
            column(BookingNo; BookingNo1) { }
            column(BL_No; BL_No) { }
            column(BL_Date; BL_Date) { }
            column(Receipt_By_Carrier; '"LFS Receipt By Carrier"') { }
            column(GrossWeight; GrossWt) { }
            column(NetWeight; NetWt) { }
            column(FreightIncoTerm; FreightIncoTerm) { }
            dataitem(SalesInvoiceLine; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No."), "Sell-to Customer No." = field("Sell-to Customer No.");
                DataItemLinkReference = SalesInvoiceHeader;
                DataItemTableView = sorting("Document No.", "Line No.") where(Type = filter(Type::Item));
                column(Quantity; Quantity)
                { }
                column(Quantity__Base_; "Quantity (Base)") { }
                column(Description; Description)
                { }
                column(HSN_SAC_Code; "HSN/SAC Code") { }
                column(Unit_of_Measure; "Unit of Measure")
                { }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                { }
                column(Variant_Code; "Variant Code")
                { }
                column(Adv__Lic_File_No_; Adv__Lic_File_No_)
                { }
                column(Issue_Date; Issue_Date)
                {

                }
                column(LiceDecsiption; LiceDecsiption) { }
                column(No_LIC; No_LIC)
                { }
                column(License_No_; License_No_)
                { }
                column(UOM; RecItem."Base Unit of Measure") { }
                column(GrossWt; "Gross Weight") { }
                column(NetWt; "Net Weight") { }
                column(TotalQtyText; Notext2[1] + ' ' + Notext2[2])
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if RecItem.Get(SalesInvoiceLine."No.") then;

                    EXIMLicense.Reset();
                    EXIMLicense.SetRange("LFS Source No.", SalesInvoiceLine."Document No.");
                    EXIMLicense.SetRange("LFS Source line No.", SalesInvoiceLine."Line No.");
                    EXIMLicense.SetRange("LFS Item No.", SalesInvoiceLine."No.");
                    If EXIMLicense.FindSet() then begin
                        repeat
                            License_No_ := EXIMLicense."LFS License No.";
                            EXIMLicenseHeader.Reset();
                            EXIMLicenseHeader.SetRange("LFS No.", EXIMLicense."LFS License No.");
                            if EXIMLicenseHeader.FindFirst() then begin
                                No_LIC := EXIMLicenseHeader."LFS No.";
                                Issue_Date := EXIMLicenseHeader."LFS Issue Date";
                                // Adv__Lic_File_No_ := EXIMLicenseHeader."LFS Adv. Lic File No.";
                                LiceDecsiption := EXIMLicenseHeader."LFS Description";
                            end;
                        until EXIMLicense.Next() = 0;
                    end;

                    SumQty += SalesInvoiceLine.Quantity;

                    InitTextVariable();
                    FormatNoText(Notext2, SumQty, '');


                end;

                trigger OnPreDataItem()
                begin
                    Clear(SumQty);
                end;
            }
            trigger OnAfterGetRecord()
            var
                EximPort: Record "LFS EXIM Port";
            begin
                if Locationrec.get(SalesInvoiceHeader."Location Code") then begin
                    Name := Locationrec.name;
                    Address := Locationrec.address;
                    Address1 := Locationrec."Address 2";
                    PostCode := Locationrec."Post Code";
                    City := Locationrec.City;
                    Phone := Locationrec."Phone No.";
                    Fax := Locationrec."Fax No.";
                    Email := Locationrec."E-Mail";

                    GSTNo := Locationrec."GST Registration No.";

                    if RecState.get(Locationrec."State Code") then
                        LocState := RecState.Description;

                    if CountReg.Get(Locationrec."Country/Region Code") then
                        Conutry := CountReg.Name;
                end;
                ExportInfoHdr.Reset();
                ExportInfoHdr.SetRange("LFS Document No.", SalesInvoiceHeader."No.");
                if ExportInfoHdr.FindFirst() then begin
                    // Notify := ExportInfoHdr.GetNotifyParty();
                    // Freight := ExportInfoHdr."LFS Freight Charges";
                    // BLNotes := ExportInfoHdr.GetNotes();
                    // SpNotes := ExportInfoHdr."Sp Notes";
                    Vessel_Flight_No_ := ExportInfoHdr."LFS Vessel/Flight No.";
                    ContainerNo := ExportInfoHdr."LFS Container No.";
                    BL_Date := ExportInfoHdr."LFS BL Date/ AWB Date";
                    BL_No := ExportInfoHdr."LFS BL No/ AWB No.";
                    // BookingNo1 := ExportInfoHdr."LFS Booking No.";
                end;

                SalesInvLine.Reset();
                SalesInvLine.SetRange("Document No.", SalesInvoiceHeader."No.");
                SalesInvLine.SetFilter("No.", '<>%1', '');
                if SalesInvLine.FindFirst() then begin
                    WhsExpshipLine.Reset();
                    WhsExpshipLine.SetRange("Posted Source No.", SalesInvLine."Shipment No.");
                    if WhsExpshipLine.FindFirst() then begin
                        WhsExpship.Reset();
                        WhsExpship.SetRange("No.", WhsExpshipLine."No.");
                        if WhsExpship.FindFirst() then
                            BookingNo := WhsExpship."Whse. Shipment No.";
                    end;
                end;

                Clear(GrossWt);
                Clear(NetWt);
                SalesInvoiceLine.Reset();
                SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
                if SalesInvoiceLine.FindSet() then
                    repeat
                        GrossWt += SalesInvoiceLine."Gross Weight";
                        NetWt += SalesInvoiceLine."Net Weight";
                    until SalesInvoiceLine.Next() = 0;

                Clear(PortName);
                if EximPort.Get("LFS Port of Loading") then
                    PortName := EximPort."LFS Port Name";

                //Clear(IncoTermCode);
                Clear(FreightIncoTerm);
                EXIMIncoTerms.Reset();
                EXIMIncoTerms.SetRange("LFS Description", SalesInvoiceHeader."LFS Inco Terms");
                if EXIMIncoTerms.FindFirst() then begin
                    //IncoTermCode := EXIMIncoTerms.Code;
                    if EXIMIncoTerms."LFS Code" = 'CIF' then
                        FreightIncoTerm := 'Collect'
                    else
                        FreightIncoTerm := 'To Pay';
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
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
            }
        }
    }

    trigger OnInitReport()
    begin
        CompanyInfo.Get;
    end;

    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var
        CurrRec: Record Currency;
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        TensDec: Integer;
        OnesDec: Integer;
    begin
        Clear(NoText);
        NoTextIndex := 1;
        NoText[1] := '';

        if No < 1 then
            AddToNoText(NoText, NoTextIndex, PrintExponent, ZeroLbl)
        else
            for Exponent := 4 DOWNTO 1 do begin
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

        if CurrencyCode <> '' then begin
            CurrRec.Get(CurrencyCode);
            // AddToNoText(NoText, NoTextIndex, PrintExponent, CurrRec.Description);
            AddToNoText(NoText, NoTextIndex, PrintExponent, '');
        end else
            AddToNoText(NoText, NoTextIndex, PrintExponent, '');

        if No <> 0 then
            AddToNoText(NoText, NoTextIndex, PrintExponent, AndLbl);

        TensDec := ((No * 100) MOD 100) DIV 10;
        OnesDec := (No * 100) MOD 10;
        if TensDec >= 2 then begin
            AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[TensDec]);
            if OnesDec > 0 then
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[OnesDec]);
        end else
            if (TensDec * 10 + OnesDec) > 0 then
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[TensDec * 10 + OnesDec]);
        // else
        //     AddToNoText(NoText, NoTextIndex, PrintExponent, ZeroLbl);

        if No > 0 then begin
            if (CurrencyCode <> '') then
                AddToNoText(NoText, NoTextIndex, PrintExponent, CurrRec.Code + ' ONLY')
            else
                AddToNoText(NoText, NoTextIndex, PrintExponent, 'ONLY');
        end
        else
            AddToNoText(NoText, NoTextIndex, PrintExponent, 'ONLY')

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
            if NoTextIndex > ArrayLen(NoText) then
                Error(exceededStringErr, AddText);
        end;

        NoText[NoTextIndex] := CopyStr(DelChr(NoText[NoTextIndex] + ' ' + AddText, '<'), 1, 80);
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
        OnesText[13] := ThirteenLbl;
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


    var
        myInt: Integer;
        CompanyInfo: Record "Company Information";
        Locationrec: Record Location;
        Name: Text;
        Address: Text;
        EximPort: Record "LFS EXIM Port";
        EXIMIncoTerms: Record "LFS EXIM Inco Terms";
        FreightIncoTerm: Text[20];
        PortOfLoading: Text[80];
        PortOfDischarge: Text[80];
        Address1: Text;
        City: text;
        Conutry: text;
        PostCode: Code[20];
        Phone: Text[30];
        Fax: Text[30];
        Email: Code[80];
        GSTNo: Text;
        LocState: Text;
        BookingNo1: Text[50];
        CountReg: Record "Country/Region";
        RecState: Record State;
        ExportInfoHdr: Record "LFS Posted Export Information";
        DescOfGoods: Text;
        ShippingMarks: Text;
        Notify: Text;
        Freight: Text;
        BLNotes: Text;
        SpNotes: text[51];
        Vessel_Flight_No_: Text[50];
        ContainerNo: code[50];
        EXIMLicense: Record "LFS EXIM Posted Export Licence";
        // EXIMLicHdr: Record "LFS EXIM License Header";
        EXIMLicenseHeader: Record "LFS EXIM License Header";
        No_LIC: Code[20];
        Issue_Date: Date;
        SumQty: Decimal;
        LiceDecsiption: Text[100];
        Adv__Lic_File_No_: Text[30];
        License_No_: code[20];
        RecItem: Record Item;
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
        ThirteenLbl: Label 'THIRTEEN';
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
        exceededStringErr: Label '%1 results in a written number that is too long.', Comment = '%1= AddText';
        WhsExpship: Record "Posted Whse. Shipment Header";
        WhsExpshipLine: Record "Posted Whse. Shipment Line";
        SalesInvLine: Record "Sales Invoice Line";
        BookingNo: Code[20];
        BL_No: Code[20];
        BL_Date: Date;
        GrossWt: Decimal;
        NetWt: Decimal;
        PortName: Text[80];
}