namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Sales.Document;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Finance.Currency;
using Microsoft.Finance.GST.Base;
using Microsoft.Finance.TaxEngine.TaxTypeHandler;
using System.Reflection;
using Microsoft.Foundation.Company;
using Microsoft.Finance.TCS.TCSBase;
using Microsoft.Utilities;
using Microsoft.Inventory.Tracking;
using Microsoft.Inventory.Location;
using Microsoft.Sales.Customer;
using Microsoft.Finance.TaxBase;
using Microsoft.Bank.BankAccount;
using Microsoft.Foundation.Shipping;
using Microsoft.Sales.Comment;
using Microsoft.Inventory.Ledger;

report 72007 "LFS Dispatch TaxInvoice Export"
{
    Caption = 'Dispatch Tax Invoice Export';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports Layouts/DISPATCH TAX INV Export.rdl';

    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            RequestFilterFields = "No.";
            DataItemTableView = sorting("No.");
            CalcFields = "QR Code";
            column(CompanyInfo_Name; CompanyInfo.Name)
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
            column(CompanyInfo_Country; CompanyInfo."Country/Region Code")
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
            column(CompanyInfo_ARN_No; CompanyInfo."ARN No.")
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
            column(LocationAddress; LocationAddress)
            {
            }
            column(LocationAddress2; LocationAddress2)
            {
            }
            column(LocationCity; LocationCity)
            {
            }
            column(LocationPostCode; LocationPostCode)
            {
            }
            column(LocationState; LocationState)
            {
            }
            column(LocationCountry; LocationCountry)
            {
            }
            column(LocationContact; LocationContact)
            {
            }
            column(Document_No_; "No.")
            {
            }
            column(Posting_No_; "Posting No.")
            {
            }
            // column(Posting_Date; "Posting Date")
            column(Posting_Date; "Document Date")
            {
            }
            column(Payment_Terms_Code; "Payment Terms Code")
            {
            }
            column(PaymentTermsDescription; PaymentTermsDescription)
            {
            }
            column(External_Document_No_; "External Document No.")
            {
            }
            column(LR_RR_No_; "LR/RR No.")
            {
            }
            column(LR_RR_Date; "LR/RR Date")
            {
            }
            column(Vehicle_No_; "Vehicle No.")
            {
            }
            column(Document_Date; "Document Date")
            {
            }
            column(QR_Code; "QR Code")
            {
            }
            column(Sell_to_Customer_No_; "Sell-to Customer No.")
            {
            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {
            }
            column(Sell_to_Contact_No_; "Sell-to Contact No.")
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
            column(Sell_to_County; "Sell-to County")
            {
            }
            column(Sell_to_Country_Region_Code; "Sell-to Country/Region Code")
            {
            }
            column(Sell_to_Phone_No_; "Sell-to Phone No.")
            {
            }
            column(Sell_to_Post_Code; "Sell-to Post Code")
            {
            }
            column(Customer_GST_Reg__No_; "Customer GST Reg. No.")
            {
            }
            column(Location_State_Code; "Location State Code")
            {
            }
            column(Location_GST_Reg__No_; "Location GST Reg. No.")
            {
            }
            column(Ship_to_Customer; "Ship-to Customer")
            {
            }
            column(Ship_to_Code; "Ship-to Code")
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
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code")
            {
            }
            column(Ship_to_County; "Ship-to County")
            {
            }
            column(Ship_to_GST_Customer_Type; "Ship-to GST Customer Type")
            {
            }
            column(Ship_to_GST_Reg__No_; "Ship-to GST Reg. No.")
            {
            }
            column(Ship_to_Post_Code; "Ship-to Post Code")
            {
            }
            column(GST_Ship_to_State_Code; "GST Ship-to State Code")
            {
            }
            column(Nature_of_Supply; "Nature of Supply")
            {
            }
            column(CommetTxt; CommetTxt)
            {
            }
            column(IRN_Hash; "IRN Hash")
            {
            }
            column(GSTPlaceofSupply; GSTPlaceofSupply)
            {
            }
            column(Shipping_Agent_Code; "Shipping Agent Code")
            {
            }
            column(TransporterName; TransporterName)
            {
            }
            column(TermsOfDelivery; TermsOfDelivery)
            {
            }
            column(BankName; BankName)
            {
            }
            column(BankAccountNo; BankAccountNo)
            {
            }
            column(IFSCCode; IFSCCode)
            {
            }
            column(BranchName; BranchName)
            {
            }
            column(Currency_Code; "Currency Code")
            {
            }
            column(StateName; StateName)
            {
            }
            column(GSTStateCode; GSTStateCode)
            {
            }
            column(TelphoneNo; TelphoneNo)
            {
            }
            column(MobileNo; MobileNo)
            {
            }
            // column(Currency_Factor; 1 / "Currency Factor")
            column(Currency_Factor; CurrencyFactor)
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLinkReference = SalesHeader;
                DataItemLink = "Document No." = field("No."), "Sell-to Customer No." = field("Sell-to Customer No.");
                DataItemTableView = sorting("Document No.", "Line No.") where(Type = filter(<> Type::" "), "No." = filter(<> '403255'));
                column(No_; "No.")
                {
                }
                column(SrNo; SrNo)
                {

                }
                column(Line_No_; "Line No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Description_2; "Description 2")
                {
                }
                column(HSN_SAC_Code; "HSN/SAC Code")
                {
                }
                column(Unit_of_Measure; "Unit of Measure Code")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Unit_Cost; "Unit Cost")
                {
                }
                column(Unit_Price; "Unit Price")
                {

                }
                column(Line_Amount; "Line Amount")
                {
                }
                column(Line_Discount__; "Line Discount %")
                {
                }
                column(Line_Discount_Amount; "Line Discount Amount")
                {
                }
                column(CGSTAmt; CGSTAmt)
                {
                }
                column(CGSTPer; CGSTPer)
                {
                }
                column(IGSTAmt; IGSTAmt)
                {
                }
                column(IGSTPer; IGSTPer)
                {
                }
                column(SGSTAmt; SGSTAmt)
                {
                }
                column(SGSTPer; SGSTPer)
                {
                }
                column(TotalGSTAmt; TotalGSTAmt)
                {
                }
                column(Notext; Notext[1])
                {
                }
                column(LFS_Packing_List_No_; '')
                {
                }
                column(Notext1; Notext1[1])
                {
                }
                column(TotalAmount; TotalAmount)
                {
                }
                column(TotalAmountIncGST; TotalAmountIncGST)
                {
                }
                column(TotalAmountRS; TotalAmountRS)
                {
                }
                column(LotNo; LotNo)
                {

                }
                column(LFS_Mfg__Date; MfgDate)
                {
                }
                column(ExpirationDate; ExpDate)
                {
                }
                column(TotalTCSAmt; TotalTCSAmt)
                {
                }
                column(Lots; Lots)
                {
                }
                column(LotQty; LotQty)
                {
                }
                column(TotalAmountofRS; TotalAmountofRS)
                {
                }
                column(TotalAmountofGST; TotalAmountofGST)
                {
                }
                column(TotalIGSTPer; TotalIGSTPer)
                {
                }
                column(TotalSGSTPer; TotalSGSTPer)
                {
                }
                column(TotalCGSTPer; TotalCGSTPer)
                {
                }
                column(TotalAmounts; TotalAmounts)
                {
                }
                column(TotalLineDiscountAmount; TotalLineDiscountAmount)
                {
                }
                column(TotalAmounts1; TotalAmounts1)
                {
                }
                column(TotalAmountIncGST1; TotalAmountIncGST1)
                {
                }
                column(TotalTCSAmt1; TotalTCSAmt1)
                {
                }
                column(UnitPrice1; UnitPrice1)
                {
                }
                column(TotalGSTAmt1; TotalGSTAmt1)
                {
                }
                column(CGSTAmt1; CGSTAmt1)
                {
                }
                column(SGSTAmt1; SGSTAmt1)
                {
                }
                column(IGSTAmt1; IGSTAmt1)
                {
                }
                column(SumCGST; SumCGST)
                {
                }
                column(SumSGST; SumSGST)
                {
                }
                column(SumIGST; SumIGST)
                {
                }
                column(TotalHSNBaseAmount; TotalHSNBaseAmount)
                {
                }
                column(IGSTAmtHSN; IGSTAmtHSN)
                {
                }
                column(SGSTAmtHSN; SGSTAmtHSN)
                {
                }
                column(CGSTAmtHSN; CGSTAmtHSN)
                {
                }
                dataitem("Value Entry"; "Value Entry")
                {
                    DataItemLink = "Document No." = field("Shipment No."), "Document Line No." = field("Shipment Line No."), "Item No." = field("No."), "Variant Code" = field("Variant Code"), "Location Code" = field("Location Code");
                    DataItemTableView = where(Adjustment = filter(false));
                    DataItemLinkReference = "Sales Line";
                    dataitem("Item Ledger Entry"; "Item Ledger Entry")
                    {
                        DataItemLink = "Entry No." = field("Item Ledger Entry No.");
                        DataItemLinkReference = "Value Entry";
                        column(Lot_No_; "Lot No.")
                        {
                        }
                        column(Expiration_Date; "Expiration Date")
                        {
                        }
                        column(MfgDate; MfgDate)
                        {
                        }
                        column(ILEQuantity; Abs(Quantity))
                        {
                        }
                    }
                    trigger OnAfterGetRecord()
                    var
                        ReservationEntry: Record "Reservation Entry";
                    begin
                        ReservationEntry.RESET();
                        ReservationEntry.SETRANGE("Item No.", "Value Entry"."Item No.");
                        ReservationEntry.SETRANGE("Variant Code", "Value Entry"."Variant Code");
                        ReservationEntry.SETRANGE("Location Code", "Value Entry"."Location Code");
                        ReservationEntry.SETRANGE("Item Ledger Entry No.", "Value Entry"."Item Ledger Entry No.");
                        if not ReservationEntry.IsEmpty() then;
                        // MfgDate := ReservationEntry."LFS Mfg. Date";
                    end;
                }
                // dataitem("Item Ledger Entry"; "Item Ledger Entry")
                // {
                //     DataItemLink = "Document No." = field("Shipment No."), "Document Line No." = field("Shipment Line No."), "Item No." = field("No."), "Variant Code" = field("No."), "Location Code" = field("Location Code");
                //     DataItemLinkReference = "Sales Line";
                //     DataItemTableView = sorting("Lot No.");
                //     column(Lot_No_; "Lot No.")
                //     {
                //     }
                //     column(LFS_Supplier_Batch_No_; "LFS Supplier Batch No.")
                //     {
                //     }
                //     column(Quantity_ILE; Quantity)
                //     {
                //     }
                //     column(LFS_Manufacturing_Date; "LFS Mfg. Date")
                //     {
                //     }
                //     column(Expiration_Date; "Expiration Date")
                //     {
                //     }
                //     column(LFS_Mfg__Date; "LFS Mfg. Date")
                //     {
                //     }

                trigger OnAfterGetRecord()
                var
                    GSTSetup: Record "GST Setup";
                    SalesLine: Record "Sales Line";
                    // DetailedGSTLedgerEntry1: Record "Detailed GST Ledger Entry";
                    TaxTransactionValue: Record "Tax Transaction Value";
                begin
                    // Clear(TotalAmountIncGST);
                    Clear(TotalAmountRS);
                    Clear(TotalAmount);

                    Clear(CurrencyFactor);
                    if SalesHeader."Currency Code" <> '' then
                        CurrencyFactor := Round(1 / SalesHeader."Currency Factor", 0.01, '=')
                    else
                        CurrencyFactor := 1;

                    SrNo += 1;
                    // SalesLine.Reset();
                    // SalesLine.SetRange("Document No.", "Sales Line"."Document No.");
                    // if SalesLine.Findset() then
                    //     repeat
                    GetGSTAmount(RecordId);
                    TotalAmount += "Sales Line".Quantity * "Sales Line"."Unit Price";
                    // until SalesLine.Next() = 0;
                    TotalAmountRS += TotalAmount + TotalGSTAmt;
                    TotalAmountofRS += TotalAmountRS;
                    CLEAR(TotalTCSAmt);
                    TCSEntry.RESET();
                    TCSEntry.SETRANGE("Document No.", "Sales Line"."Document No.");
                    TCSEntry.SETFILTER("TCS Amount Including Surcharge", '<>%1', 0);
                    IF TCSEntry.FindFirst() THEN
                        //TCSAmt := TCSEntry."TCS Amount Including Surcharge";
                        TotalTCSAmt += TCSEntry."TCS Amount";

                    TotalAmountIncGST += (TotalAmountofRS + TotalTCSAmt) * (CurrencyFactor);
                    // InitTextVariable();
                    // FormatNoText(Notext1, TotalAmountIncGST, '');

                    // SalesLine.SetRange("Document No.", SalesHeader."No.");
                    // if SalesLine.FindSet() then
                    //     repeat
                    //         TotalAmounts += SalesLine."Qty. to Ship" * SalesLine."Unit Price";
                    //         TotalLineDiscountAmount += SalesLine."Line Discount Amount";
                    //     until SalesLine.Next() = 0;

                    Clear(TotalLineDiscountAmount);
                    Clear(TotalGSTAmt1);
                    Clear(TotalAmounts);
                    Clear(TotalAmounts1);
                    Clear(TotalAmountIncGST1);
                    SalesLine.SetRange("Document No.", "Sales Line"."Document No.");
                    SalesLine.SetFilter(Type, '<>%1', SalesLine.Type::" ");
                    if SalesLine.FindSet() then
                        repeat
                            Clear(IGSTAmt1);
                            Clear(SGSTAmt1);
                            Clear(CGSTAmt1);
                            // DetailedGSTLedgerEntry1.Reset();
                            // DetailedGSTLedgerEntry1.SETRANGE("Document No.", SalesLine."Document No.");
                            // DetailedGSTLedgerEntry1.SETRANGE("Document Line No.", SalesLine."Line No.");
                            // // DetailedGSTLedgerEntry.SETFILTER("Entry Type", '%1', DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
                            // if DetailedGSTLedgerEntry1.FIND('-') then
                            //     repeat
                            //         CASE DetailedGSTLedgerEntry1."GST Component Code" OF
                            //             'CGST':
                            //                 // CGSTPer := DetailedGSTLedgerEntry."GST %";
                            //                 CGSTAmt1 := DetailedGSTLedgerEntry1."GST Amount" * -1;
                            //             'SGST':
                            //                 // SGSTPer := DetailedGSTLedgerEntry."GST %";
                            //                 SGSTAmt1 := DetailedGSTLedgerEntry1."GST Amount" * -1;
                            //             'IGST':
                            //                 // IGSTPer := DetailedGSTLedgerEntry."GST %";
                            //                 IGSTAmt1 := DetailedGSTLedgerEntry1."GST Amount" * -1;
                            //         end;
                            //     UNTIL DetailedGSTLedgerEntry1.Next() = 0;

                            if not GSTSetup.Get() then
                                exit;

                            TaxTransactionValue.SetRange("Tax Record ID", SalesLine.RecordId);
                            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                            if GSTSetup."Cess Tax Type" <> '' then
                                TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
                            else
                                TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
                            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
                            if not TaxTransactionValue.IsEmpty() then
                                repeat
                                    if TaxTransactionValue."Value ID" = 2 then
                                        CGSTAmt1 := TaxTransactionValue.Amount;
                                    // CGSTPer := TaxTransactionValue.Percent;

                                    if TaxTransactionValue."Value ID" = 6 then
                                        SGSTAmt1 := TaxTransactionValue.Amount;
                                    // SGSTPer := TaxTransactionValue.Percent;

                                    if TaxTransactionValue."Value ID" = 3 then
                                        IGSTAmt1 := TaxTransactionValue.Amount;
                                // IGSTPer := TaxTransactionValue.Percent;
                                until TaxTransactionValue.Next() = 0;

                            SumCGST += CGSTAmt1;
                            SumIGST += IGSTAmt1;
                            SumSGST += SGSTAmt1;
                            TotalGSTAmt1 += CGSTAmt1 + SGSTAmt1 + IGSTAmt1;
                            CLEAR(TotalTCSAmt1);
                            Clear(UnitPrice1);
                            TCSEntry.RESET();
                            TCSEntry.SETRANGE("Document No.", SalesLine."Document No.");
                            TCSEntry.SETFILTER("TCS Amount Including Surcharge", '<>%1', 0);
                            IF TCSEntry.FindFirst() THEN
                                TotalTCSAmt1 += TCSEntry."TCS Amount";
                            // if SalesInvoiceHeader1.get(SalesLine."Document No.") then
                            //     if SalesInvoiceHeader1."Currency Factor" <> 0 then
                            //         UnitPrice1 := SalesLine."Unit Price" * 1 / SalesInvoiceHeader1."Currency Factor"
                            //     else
                            UnitPrice1 := SalesLine."Unit Price";
                            TotalLineDiscountAmount += SalesLine."Line Discount Amount" + SalesLine."Inv. Discount Amount";
                            TotalAmounts += SalesLine.Quantity * UnitPrice1;
                            TotalAmounts1 := TotalAmounts + TotalGSTAmt1;
                            TotalAmountIncGST1 := TotalAmounts1 + TotalTCSAmt1;
                        until SalesLine.Next() = 0;

                    // TotalLineDiscountAmount += "Sales Line"."Line Discount Amount";

                    // TotalAmount += "Sales Line"."Qty. to Ship" * "Sales Line"."Unit Price";
                    // eximmgmt.LFS InitTextVariable();
                    // eximmgmt.LFS FormatNoText(Notext2, TotalAmounts - TotalLineDiscountAmount, SalesHeader."Currency Code");
                    InitTextVariable();
                    FormatNoText(Notext1, (TotalAmounts + TotalGSTAmt1 + TotalTCSAmt1 - TotalLineDiscountAmount) * CurrencyFactor, '');

                    InitTextVariable();
                    FormatNoText(Notext, TotalGSTAmt1 * CurrencyFactor, '');

                    // InitTextVariable();
                    // FormatNoText(Notext1, TotalAmountIncGST, '');

                    CrLf := TypeHelper.CRLFSeparator();
                    LotNo := '';
                    ExpDate := '';
                    ValueEntry.Reset();
                    ValueEntry.SetRange(ValueEntry."Document No.", "Sales Line"."Document No.");
                    ValueEntry.SetRange(ValueEntry."Document Line No.", "Sales Line"."Line No.");
                    ValueEntry.SetRange(ValueEntry."Item No.", "Sales Line"."No.");
                    ValueEntry.SetRange(ValueEntry."Location Code", "Sales Line"."Location Code");
                    ValueEntry.SetFilter(ValueEntry.Adjustment, '%1', false);
                    if ValueEntry.FindSet() then
                        repeat
                            ILE.SetRange("Entry No.", ValueEntry."Item Ledger Entry No.");
                            if ILE.FindSet() then
                                repeat
                                    if LotNo = '' then begin
                                        Lots := ILE."Lot No.";
                                        LotQty := Abs(ILE.Quantity);
                                        LotNo := ILE."Lot No." + CrLf;
                                        // ExpDate := 'Mfg Dt:' + Format(ILE."LFS Mfg. Date", 0, '<Day,2>.<Month,2>.<Year4>') + CrLf + 'Exp Dt: ' + Format(ILE."Expiration Date", 0, '<Day,2>.<Month,2>.<Year4>');
                                        // end else begin
                                        //     LotNo += CrLf + ILE."Lot No." + CrLf;
                                        //     ExpDate += 'Mfg Dt:' + Format(ILE."LFS Mfg. Date", 0, '<Day,2>.<Month,2>.<Year4>') + CrLf + 'Exp Dt: ' + Format(ILE."Expiration Date", 0, '<Day,2>.<Month,2>.<Year4>') + crlf;
                                    end;
                                until ILE.Next() = 0;
                        until ValueEntry.Next() = 0;

                    Clear(TotalHSNBaseAmount);
                    Clear(IGSTAmtHSN);
                    Clear(SGSTAmtHSN);
                    Clear(CGSTAmtHSN);
                    SalesLine.Reset();
                    SalesLine.SetCurrentKey("Line No.");
                    SalesLine.SetRange("Document No.", "Sales Line"."Document No.");
                    SalesLine.SetRange("HSN/SAC Code", "Sales Line"."HSN/SAC Code");
                    if SalesLine.FindSet() then
                        repeat
                            TotalHSNBaseAmount += SalesLine.Quantity * SalesLine."Unit Price" - SalesLine."Inv. Discount Amount" - SalesLine."Line Discount Amount";
                        until SalesLine.Next() = 0;
                end;

                trigger OnPreDataItem()
                begin
                    Clear(SrNo);
                end;
            }
            dataitem(LeftHeader; "Name/Value Buffer")
            {
                DataItemTableView = sorting(ID);
                UseTemporary = true;
                column(LeftHeaderName; Name)
                {
                }
                column(LeftHeaderValue; Value)
                {
                }
            }
            dataitem(RightHeader; "Name/Value Buffer")
            {
                DataItemTableView = sorting(ID);
                UseTemporary = true;
                column(RightHeaderName; Name)
                {
                }
                column(RightHeaderValue; Value)
                {
                }
            }
            trigger OnAfterGetRecord()
            var
                BankAccount: Record "Bank Account";
                Customer: Record Customer;
                Location: Record Location;
                PaymentTerms: Record "Payment Terms";
                SalesCommentLine: Record "Sales Comment Line";
                SalesInvLine: Record "Sales Line";
                ShiptoAddress: Record "Ship-to Address";
                ShipmentMethod: Record "Shipment Method";
                ShippingAgent: Record "Shipping Agent";
                State: Record State;
            begin

                FillLeftHeader();

                Clear(PaymentTermsDescription);
                Clear(GSTPlaceofSupply);
                Clear(TransporterName);
                Clear(TermsOfDelivery);
                Clear(BankName);
                Clear(BankAccountNo);
                Clear(IFSCCode);
                Clear(BranchName);
                Clear(StateName);
                Clear(GSTStateCode);
                Clear(MobileNo);
                Clear(TelphoneNo);
                PaymentTerms.Reset();
                PaymentTerms.SetRange(Code, "Payment Terms Code");
                if PaymentTerms.FindFirst() then
                    PaymentTermsDescription := PaymentTerms.Description;

                CommetTxt := '';
                SalesCommentLine.Reset();
                // SalesCommentLine.SetRange("Document Type", SalesHeader."Document Type");
                SalesCommentLine.SetRange("No.", SalesHeader."No.");
                if SalesCommentLine.Findset() then
                    repeat
                        if CommetTxt <> '' then
                            CommetTxt += ',' + SalesCommentLine.Comment
                        else
                            CommetTxt += SalesCommentLine.Comment;
                    until SalesCommentLine.Next() = 0;
                SalesInvLine.Reset();
                SalesInvLine.SetRange("Document No.", SalesHeader."No.");
                if SalesInvLine.FindFirst() then
                    GSTPlaceofSupply := Format(SalesInvLine."GST Place Of Supply");

                ShippingAgent.Reset();
                ShippingAgent.SetRange(Code, SalesHeader."Shipping Agent Code");
                if ShippingAgent.FindFirst() then
                    TransporterName := ShippingAgent.Name;

                ShipmentMethod.Reset();
                ShipmentMethod.SetRange(Code, SalesHeader."Shipment Method Code");
                if ShipmentMethod.FindFirst() then
                    TermsOfDelivery := ShipmentMethod.Description;

                if SalesHeader."GST Ship-to State Code" = '' then begin
                    State.SetRange(Code, SalesHeader."GST Bill-to State Code");
                    if State.FindFirst() then begin
                        GSTStateCode := State."State Code (GST Reg. No.)";
                        StateName := State.Description;
                    end;
                end else begin
                    State.SetRange(Code, SalesHeader."GST Ship-to State Code");
                    if State.FindFirst() then begin
                        GSTStateCode := State."State Code (GST Reg. No.)";
                        StateName := State.Description;
                    end;
                end;

                if SalesHeader."Ship-to Code" = '' then begin
                    Customer.SetRange("No.", SalesHeader."Bill-to Customer No.");
                    if Customer.FindFirst() then begin
                        TelphoneNo := Customer."Phone No.";
                        MobileNo := Customer."Mobile Phone No.";
                    end;
                end else begin
                    ShiptoAddress.SetRange("Customer No.", SalesHeader."Ship-to Customer");
                    if ShiptoAddress.FindFirst() then begin
                        TelphoneNo := ShiptoAddress."Fax No.";
                        MobileNo := ShiptoAddress."Phone No.";
                    end;
                end;
                Location.SetRange(Code, SalesHeader."Location Code");
                if Location.FindFirst() then begin
                    LocationAddress := Location.Address;
                    LocationAddress2 := Location."Address 2";
                    LocationCity := Location.City;
                    LocationState := Location."State Code";
                    LocationPostCode := Location."Post Code";
                    LocationContact := Location."Phone No.";
                    LocationCountry := Location."Country/Region Code";
                end;

                if SalesHeader."LFS EXIM Type" = SalesHeader."LFS EXIM Type"::Export then begin
                    BankAccount.Reset();
                    BankAccount.SetRange("No.", SalesHeader."LFS Customs Bank Account");
                    if BankAccount.FindFirst() then begin
                        BankName := BankAccount.Name;
                        BankAccountNo := BankAccount."Bank Account No.";
                        IFSCCode := BankAccount."IFSC Code";
                        BranchName := BankAccount."Fax No.";
                    end;
                end else
                    if SalesHeader."LFS EXIM Type" = SalesHeader."LFS EXIM Type"::" " then begin
                        BankAccount.Reset();
                        // BankAccount.SetRange("No.", Location."LFS Bank Account Code");
                        if BankAccount.FindFirst() then begin
                            BankName := BankAccount.Name;
                            BankAccountNo := BankAccount."Bank Account No.";
                            IFSCCode := BankAccount."IFSC Code";
                            BranchName := BankAccount."Fax No.";
                        end;
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
            area(Processing)
            {
            }
        }
    }
    var
        CompanyInfo: Record "Company Information";
        ILE: Record "Item Ledger Entry";
        TCSENtry: Record "TCS Entry";
        ValueEntry: Record "Value Entry";
        TypeHelper: Codeunit "Type Helper";
        LocationCountry, LocationPostCode, LocationState : Code[20];
        GSTStateCode, Lots : Code[50];
        MfgDate: Date;
        CGSTAmt, LotQty : Decimal;
        CGSTAmt1, CGSTAmtHSN, IGSTAmt1, IGSTAmtHSN, SGSTAmt1, SGSTAmtHSN, SumCGST, SumIGST, SumSGST, TotalAmountIncGST1, TotalAmounts, TotalAmounts1, TotalGSTAmt1, TotalHSNBaseAmount, TotalLineDiscountAmount, TotalTCSAmt1, UnitPrice1 : Decimal;
        CGSTPer: Decimal;
        CurrencyFactor, TotalTCSAmt : Decimal;
        IGSTAmt: Decimal;
        IGSTPer: Decimal;
        SGSTAmt: Decimal;
        SGSTPer: Decimal;
        TotalAmount: Decimal;
        TotalAmountIncGST, TotalAmountofGST, TotalAmountofRS : Decimal;
        TotalAmountRS: Decimal;
        TotalCalcGSTAmt, TotalCGSTPer, TotalIGSTPer, TotalSGSTPer : Decimal;
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
        BankName: Text;
        CommetTxt: Text;
        ExpDate: Text;
        GSTPlaceofSupply, LocationAddress, LocationAddress2, LocationCity, LocationContact : Text;
        LotNo: Text;
        Notext: array[2] of Text;
        Notext1: array[2] of Text;
        PaymentTermsDescription: Text;
        TermsOfDelivery: Text;
        TransporterName: Text;
        CrLf: Text[2];
        IFSCCode: Text[20];
        BankAccountNo: Text[30];
        BranchName: Text[30];
        ExponentText: array[5] of Text[30];
        MobileNo: Text[30];
        OnesText: array[20] of Text[30];
        TelphoneNo: Text[30];
        TensText: array[10] of Text[30];
        StateName: Text[50];

    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

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
        Clear(TotalCalcGSTAmt);
        if not GSTSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if not TaxTransactionValue.IsEmpty() then
            repeat
                if TaxTransactionValue."Value ID" = 2 then begin
                    CGSTAmt := TaxTransactionValue.Amount;
                    CGSTPer := TaxTransactionValue.Percent;
                end;

                if TaxTransactionValue."Value ID" = 6 then begin
                    SGSTAmt := TaxTransactionValue.Amount;
                    SGSTPer := TaxTransactionValue.Percent;
                end;

                if TaxTransactionValue."Value ID" = 3 then begin
                    IGSTAmt := TaxTransactionValue.Amount;
                    IGSTPer := TaxTransactionValue.Percent;
                end;
            until TaxTransactionValue.Next() = 0;

        TotalGSTAmt := CGSTAmt + SGSTAmt + IGSTAmt;
        TotalIGSTPer += IGSTAmt;
        TotalSGSTPer += SGSTAmt;
        TotalCGSTPer += CGSTAmt;
        TotalCalcGSTAmt += TotalGSTAmt * (CurrencyFactor);
        TotalAmountofGST += TotalCalcGSTAmt;
        // InitTextVariable();
        // FormatNoText(Notext, TotalCalcGSTAmt, '');
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
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + Currency.Code + ' ONLY')
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

    local procedure FillLeftHeader()
    begin
        // LeftHeader.DeleteAll();

        FillNameValueTable(LeftHeader, SalesHeader.FieldCaption("External Document No."), SalesHeader."External Document No.");
        FillNameValueTable(LeftHeader, SalesHeader.FieldCaption("Bill-to Customer No."), SalesHeader."Bill-to Customer No.");
        FillNameValueTable(LeftHeader, SalesHeader.GetCustomerVATRegistrationNumberLbl(), SalesHeader.GetCustomerVATRegistrationNumber());
#pragma warning disable AL0432
        FillNameValueTable(LeftHeader, SalesHeader.GetCustomerGlobalLocationNumberLbl(), SalesHeader.GetCustomerGlobalLocationNumber());
#pragma warning restore AL0432
        FillNameValueTable(LeftHeader, 'Invoice No.', SalesHeader."No.");
        FillNameValueTable(LeftHeader, SalesHeader.FieldCaption("No."), SalesHeader."No.");
        FillNameValueTable(LeftHeader, SalesHeader.FieldCaption("Document Date"), Format(SalesHeader."Document Date", 0, 4));
        FillNameValueTable(LeftHeader, SalesHeader.FieldCaption("Due Date"), Format(SalesHeader."Due Date", 0, 4));
    end;

    local procedure FillNameValueTable(var NameValueBuffer: Record "Name/Value Buffer"; Name: Text; Value: Text)
    var
        KeyIndex: Integer;
    begin
        if Value <> '' then begin
            Clear(NameValueBuffer);
            if NameValueBuffer.FindLast() then
                KeyIndex := NameValueBuffer.ID + 1;

            NameValueBuffer.Init();
            NameValueBuffer.ID := KeyIndex;
            NameValueBuffer.Name := CopyStr(Name, 1, MaxStrLen(NameValueBuffer.Name));
            NameValueBuffer.Value := CopyStr(Value, 1, MaxStrLen(NameValueBuffer.Value));
            NameValueBuffer.Insert();
        end;
    end;
}