namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Finance.Currency;
using Microsoft.Finance.TaxEngine.TaxTypeHandler;
using Microsoft.Finance.GST.Base;
using System.Automation;
using Microsoft.Purchases.Document;
using Microsoft.Foundation.Shipping;
using Microsoft.Inventory.Intrastat;
using System.Security.AccessControl;
using Microsoft.Finance.TaxBase;
using Microsoft.Purchases.Vendor;
using Microsoft.Foundation.Company;
using Microsoft.Foundation.Address;
using Microsoft.Inventory.Location;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Inventory.Item.Catalog;

report 72008 "Import Purchase Order"
{
    ApplicationArea = All;
    Caption = 'Import Purchase Order';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports Layouts/Import Purchase Order.rdl';
    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            column(CompanyName; CompanyInfo.Name)
            { }
            column(Location_Code; "Location Code")
            { }
            column(CompanyAddress; CompanyInfo.Address)
            { }
            column(CompanyAddress2; CompanyInfo."Address 2")
            { }
            column(CompanyEMail; CompanyInfo."E-Mail")
            { }
            column(CompanyPicture; CompanyInfo.Picture)
            { }
            column(CompanyCity; CompanyInfo.City + ', ' + CompanyInfo."Post Code")
            { }
            column(companyStateCode; CompanyInfo."State Code")
            { }
            column(CompanyInfo_Phone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Phone2; CompanyInfo."Phone No. 2")
            { }
            column(CountryRegionDesc; CountryRegionDesc)
            {
            }
            column(CompStateDes; CompStateDes)
            {

            }
            // column(CIN; CompanyInfo."LFS CIN No.")
            // {

            // }
            column(CompanyPostCode; CompanyInfo."Post Code")
            { }
            column(CompanyCountry; CompanyInfo."Country/Region Code")
            { }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            { }
            column(CompanyGstNo; "Vendor GST Reg. No.")
            { }
            column(CompanyPanNo; CompanyInfo."P.A.N. No.")
            { }
            column(CompanyGST; CompanyInfo."GST Registration No.")
            {

            }
            // column(FSSAI; CompanyInfo."LFS FSSAI No.")
            // {

            // }
            column(IECNo; CompanyInfo."LFS I.E.C. CODE NO.")
            {

            }

            column(PoNo; "No.")
            {
            }
            column(LocationAddress; LocationAddress)
            {

            }
            column(LocationAddress2; LocationAddress2)
            {

            }
            column(LocationCity; LocationCity + ' -' + LocationPostCode)
            {

            }
            column(LocationCountry; LocationCountry)
            {

            }
            column(LocationGSTNo; LocationGSTNo)
            {

            }
            column(LocationPhoneNo; LocationPhoneNo)
            {

            }
            column(LocationStateDesc; LocationStateDesc)
            {

            }
            column(LocationCountryDes; LocationCountryDes)
            {

            }
            column(LocationState; LocationState)
            {

            }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {

            }
            column(Buy_from_Address; "Buy-from Address")
            {

            }
            column(Buy_from_Address_2; "Buy-from Address 2")
            {

            }
            column(Buy_from_City; "Buy-from City")
            {

            }
            column(Buy_from_Post_Code; "Buy-from Post Code")
            {

            }
            column(VendorCountryDes; VendorCountryDes)
            {

            }
            column(VendorStateDescribtion; VendorStateDescribtion)
            {

            }
            column(Port_of_Loading; PortOfLoding)
            {

            }
            column(Payment_Terms_Code; "Payment Terms Code")
            {

            }
            column(PreparedBy; PreparedBy)
            {

            }
            column(AuthorizedBy; AuthorizedBy)
            {

            }
            column(CheckedBy; CheckedBy)
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(Order_Date; "Order Date")
            {

            }
            column(CCode; "Currency Code")
            {

            }
            column(ModeofDispatch; ModeofDispatch)
            {

            }
            column(PaymentTermsDesc; PaymentTermsDesc)
            { }
            column(ShipmentMethodName; ShipmentMethodName)
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No."), "Buy-from Vendor No." = field("Buy-from Vendor No.");
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.") order(ascending);
                column(Quantity_PurchaseLine; Quantity)
                {
                }
                column(UnitofMeasure_PurchaseLine; "Unit of Measure")
                {
                }
                column(SrNo; SrNo)
                { }
                column(Description; Description)
                {

                }
                column(Unit_Price__LCY_; "Unit Price (LCY)")
                {

                }
                column(Unit_Cost; "Direct Unit Cost")
                {

                }
                // column(LFS_Manufacturer_Code; "LFS Manufacturer Code")
                // {

                // }
                column(HSN_SAC_Code; "HSN/SAC Code")
                {

                }
                column(IGSTAmt; IGSTAmt)
                {

                }
                column(IGSTPer; IGSTPer)
                {

                }
                column(TotalGSTAmt; TotalGSTAmt)
                {

                }
                column(Notext; PurchaseHeader."Currency Code" + ' ' + Notext[1])
                {
                }
                column(ManufacturerDesc; ManufacturerDesc)
                {

                }
                column(Line_Amount; "Line Amount")
                {

                }

                trigger OnAfterGetRecord()
                var
                    AmountInWords: Codeunit "LFS Amount In Words";
                begin
                    SrNo += 1;
                    TotalCostAmt += "Purchase Line"."Line Amount";
                    GetGSTAmount(RecordId);
                    // InitTextVariable();
                    // FormatNoText(Notext, TotalCostAmt, "Purchase Line"."Currency Code");

                    AmountInWords.InitTextVariable();
                    AmountInWords.FormatNoText(Notext, TotalCostAmt, "Purchase Line"."Currency Code");

                    Manufacturer.Reset();
                    // Manufacturer.SetRange(Code, "Purchase Line"."LFS Manufacturer Code");
                    if Manufacturer.FindFirst() then
                        ManufacturerDesc := Manufacturer.Name;

                end;

            }
            trigger OnAfterGetRecord()
            var
                ShpimentMethod: Record "Shipment Method";
            begin

                Clear(PreparedBy);
                Clear(CheckedBy);
                Clear(AuthorizedBy);

                if Country_Region.Get(CompanyInfo."Country/Region Code") then
                    CountryRegionDesc := Country_Region.Name;

                if StateRec.Get(CompanyInfo."State Code") then
                    CompStateDes := StateRec.Description;

                if Port.Get(PurchaseHeader."LFS Port of Loading") then
                    PortOfLoding := Port."LFS Port Name";


                if Location.Get("Location Code") then begin
                    LocationAddress := Location.Address;
                    LocationAddress2 := Location."Address 2";
                    LocationCity := Location.City;
                    LocationState := Location."State Code";
                    LocationPostCode := Location."Post Code";
                    LocationCountry := Location."Country/Region Code";
                    LocationPhoneNo := Location."Phone No.";
                    LocationGSTNo := Location."GST Registration No.";

                    if StateRec.get(Location."State Code") then
                        LocationStateDesc := StateRec.Description;

                    if Country_Region.get(Location."Country/Region Code") then
                        LocationCountryDes := Country_Region.Name;
                end;

                if Vendor.Get("Buy-from Vendor No.") then begin
                    if StateRec.Get(Vendor."State Code") then
                        VendorStateDescribtion := StateRec.Description;

                    if Country_Region.Get(Vendor."Country/Region Code") then
                        VendorCountryDes := Country_Region.Name;

                end;
                Users.Reset();
                Users.SetRange(Users."User Security ID", PurchaseHeader.SystemCreatedBy);
                if Users.FindFirst() then
                    PreparedBy := Users."Full Name";

                // ApprovalEntries.Reset();
                // ApprovalEntries.SetRange("Table ID", Database::"Purchase Header");
                // ApprovalEntries.SetRange("Document No.", PurchaseHeader."No.");
                // ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Approved);
                // if ApprovalEntries.FindLast() then begin
                //     Users.Reset();
                //     Users.SetRange("User Name", ApprovalEntries."Approver ID");
                //     if Users.FindFirst() then
                //         AuthorizedBy := Users."User Name";
                //     EntryID := ApprovalEntries."Entry No.";
                //     ApprovalEntries.SetFilter("Entry No.", '<>%1', EntryID);
                //     if ApprovalEntries.FindLast() then begin
                //         Users.Reset();
                //         Users.SetRange("User Name", ApprovalEntries."Approver ID");
                //         if Users.FindFirst() then
                //             CheckedBy := Users."User Name";
                //     end;

                // end;
                if PurchaseHeader.Status = PurchaseHeader.Status::Released then begin
                    ApprovalEntries.Reset();
                    ApprovalEntries.SetRange("Table ID", Database::"Purchase Header");
                    ApprovalEntries.SetRange("Document No.", PurchaseHeader."No.");
                    ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Approved);

                    // Use SetCurrentKey to sort by Sequence No.
                    ApprovalEntries.SetCurrentKey("Document No.", "Sequence No.");
                    if ApprovalEntries.FindSet() then begin
                        // Initialize placeholders for CheckBy and AuthorizedBy
                        CheckedBy := '';
                        AuthorizedBy := '';
                        repeat
                            case ApprovalEntries."Sequence No." of
                                1:
                                    begin
                                        Users.Reset();
                                        Users.SetRange("User Name", ApprovalEntries."Last Modified By User ID");
                                        if Users.FindFirst() and (CheckedBy = '') then
                                            CheckedBy := Users."Full Name"; // Assign first approver to CheckedBy
                                    end;
                                2:
                                    begin
                                        Users.Reset();
                                        Users.SetRange("User Name", ApprovalEntries."Last Modified By User ID");
                                        if Users.FindFirst() and (AuthorizedBy = '') then
                                            AuthorizedBy := Users."Full Name"; // Assign second approver to AuthorizedBy
                                    end;
                            end;
                        until ApprovalEntries.Next() = 0;

                        // If no distinct authorized approver found, fallback to CheckedBy
                        if AuthorizedBy = '' then
                            AuthorizedBy := CheckedBy;
                    end;
                end;
                TransportMethod.Reset();
                TransportMethod.SetRange(Code, PurchaseHeader."Transport Method");
                if TransportMethod.FindFirst() then
                    ModeofDispatch := TransportMethod.Description;

                ShpimentMethod.SetRange(Code, PurchaseHeader."Shipment Method Code");
                if ShpimentMethod.FindFirst() then
                    ShipmentMethodName := ShpimentMethod.Description;

                PaymentTerms.Reset();
                PaymentTerms.SetRange(Code, PurchaseHeader."Payment Terms Code");
                if PaymentTerms.FindFirst() then
                    PaymentTermsDesc := PaymentTerms.Description;


            end;
        }

    }
    trigger OnPreReport()
    begin
        CompanyInfo.get();
        CompanyInfo.CalcFields(Picture);
    end;

    var

        ApprovalEntries: Record "Approval Entry";
        CompanyInfo: Record "Company Information";
        Country_Region: Record "Country/Region";
        Port: Record "LFS EXIM Port";
        Location: Record Location;
        Manufacturer: Record Manufacturer;
        PaymentTerms: Record "Payment Terms";
        StateRec: Record State;
        TransportMethod: Record "Transport Method";
        Users: Record User;
        Vendor: Record Vendor;
        LocationGSTNo: Code[20];
        LocationPostCode: Code[20];
        CGSTAmt: Decimal;
        CGSTPer: Decimal;
        IGSTAmt: Decimal;
        IGSTPer: Decimal;
        SGSTAmt: Decimal;
        SGSTPer: Decimal;
        // TotalCalcGSTAmt: Decimal;
        TotalCostAmt: Decimal;
        TotalGSTAmt: Decimal;
        SrNo: Integer;
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
        CompStateDes,
        // EntryID: Integer;
        CountryRegionDesc, VendorCountryDes, VendorStateDescribtion : text;
        LocationAddress, ShipmentMethodName : Text;
        LocationAddress2: text;
        LocationCity: Text;
        LocationCountry: Text;
        LocationCountryDes: Text;
        LocationState: Text;
        LocationStateDesc: Text;
        ModeofDispatch: Text;
        Notext: array[2] of Text;
        // PreparedBy: Code[50];
        PortOfLoding: Text;
        ExponentText: array[5] of Text[30];
        LocationPhoneNo: Text[30];
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        AuthorizedBy, PreparedBy : Text[80];
        CheckedBy: Text[80];
        ManufacturerDesc: text[100];
        PaymentTermsDesc: text[100];


    procedure GetGSTAmount(RecID: RecordID)
    var
        GSTSetup: Record "GST Setup";
        TaxTransactionValue: Record "Tax Transaction Value";
    begin
        Clear(SGSTAmt);
        Clear(CGSTAmt);
        Clear(IGSTAmt);
        Clear(CGSTPer);
        Clear(IGSTPer);
        Clear(SGSTPer);

        if not GSTSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if TaxTransactionValue.FindSet() then
            repeat
                if TaxTransactionValue."Value ID" = 3 then begin
                    IGSTAmt := TaxTransactionValue.Amount;
                    IGSTPer := TaxTransactionValue.Percent;
                end;
            until TaxTransactionValue.Next() = 0;

        TotalGSTAmt += IGSTAmt;
    end;

#pragma warning disable AA0244
    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
#pragma warning restore AA0244
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
        else
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
        if CurrencyCode <> '' then begin
            Currency.Get(CurrencyCode);
            AddToNoText(NoText, NoTextIndex, PrintExponent, '');
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
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ONLY')
        else
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' PAISA ONLY');
    end;

#pragma warning disable AA0244
    local procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
#pragma warning restore AA0244
    begin
        PrintExponent := true;

        while StrLen(NoText[NoTextIndex] + ' ' + AddText) > MaxStrLen(NoText[1]) do
            // begin
            NoTextIndex := NoTextIndex + 1;
        //if NoTextIndex > ArrayLen(NoText) then
        //Error(exceededStringErr, AddText);
        // end;

#pragma warning disable AA0139
        NoText[NoTextIndex] := DelChr(NoText[NoTextIndex] + ' ' + AddText, '<');
#pragma warning restore AA0139

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
}
