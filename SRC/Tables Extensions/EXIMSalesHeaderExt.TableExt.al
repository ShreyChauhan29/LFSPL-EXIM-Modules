namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.Document;
using Microsoft.Sales.Customer;
using Microsoft.Foundation.Address;
using Microsoft.Foundation.NoSeries;
using Microsoft.Finance.Currency;
using Microsoft.Utilities;
using Microsoft.Finance.GST.Sales;
using Microsoft.Sales.Setup;
using Microsoft.Bank.BankAccount;

tableextension 72022 "LFS EXIM Sales Header Ext." extends "Sales Header"
{
    fields
    {
        modify("Sell-to Customer No.")
        {
            TableRelation = if ("LFS EXIM Type" = const(Export)) Customer."No." where("GST Customer Type" = filter("GST Customer Type"::Export));
        }
        modify("External Document No.")
        { Caption = 'Customer Order No.'; }
        field(72000; "LFS EXIM Type"; Enum "LFS EXIM Type")
        {
            Caption = 'EXIM Type';
            DataClassification = CustomerContent;
        }
        field(72001; "LFS Port of Loading"; Code[20])
        {
            Caption = 'Port of Loading';
            TableRelation = "LFS EXIM Port"."LFS Code";
            DataClassification = CustomerContent;
        }
        field(72002; "LFS Port of Discharge"; Code[20])
        {
            Caption = 'Port of Discharge';
            TableRelation = "LFS EXIM Port"."LFS Code";
            DataClassification = CustomerContent;
        }
        field(72003; "LFS Country of Final Dest."; Code[20])
        {
            Caption = 'Country of Final Destination';
            TableRelation = "Country/Region".Code;
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                CountryRegion: Record "Country/Region";
            begin
                if Rec."LFS Country of Final Dest." <> '' then begin
                    CountryRegion.SetRange(Code, Rec."LFS Country of Final Dest.");
                    if CountryRegion.FindFirst() then
                        Rec."LFS Final Destination" := Format(CountryRegion.Name);
                end;
            end;
        }
        field(72004; "LFS Final Destination"; Code[20])
        {
            Caption = 'Final Destination';
            DataClassification = CustomerContent;
        }
        field(72005; "LFS Country Origin Goods"; Code[20])
        {
            Caption = 'Country of Origin of Goods';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(72006; "LFS Inco Terms"; Code[20])
        {
            Caption = 'Inco Terms';
            TableRelation = "LFS EXIM Inco Terms";
            DataClassification = CustomerContent;
        }
        // field(72007; "LFS Export Remark"; Text[250])
        // {
        //     Caption = 'Export Remark';
        //     DataClassification = CustomerContent;
        // }
        field(72008; "LFS Custom Currency Code"; Code[10])
        {
            Caption = 'Custom Currency Code';
            TableRelation = "LFSEXIM Currency Exchange Rate";
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                StandardCodesMgt: Codeunit "Standard Codes Mgt.";
            begin
                if not (CurrFieldNo in [0, FieldNo("Posting Date")]) or ("LFS Custom Currency Code" <> xRec."LFS Custom Currency Code") then
                    TestStatusOpen();

                ResetInvoiceDiscountValue();

                if (CurrFieldNo <> FieldNo("LFS Custom Currency Code")) and ("LFS Custom Currency Code" = xRec."LFS Custom Currency Code") then
                    UpdateCurrencyFactorNew()
                else
                    if "LFS Custom Currency Code" <> xRec."LFS Custom Currency Code" then
                        UpdateCurrencyFactorNew()
                    else
                        if "LFS Custom Currency Code" <> '' then begin
                            UpdateCurrencyFactorNew();
                            if "LFS Custom Currency Factor" <> xRec."LFS Custom Currency Factor" then
                                ConfirmCurrencyFactorUpdateNew();
                        end;

                if ShouldCheckShowRecurringSalesLines(xRec, Rec) then
                    StandardCodesMgt.CheckShowSalesRecurringLinesNotification(Rec);

                if "LFS Custom Currency Code" <> xRec."LFS Custom Currency Code" then
                    SalesCalcDiscountByType.ApplyDefaultInvoiceDiscount(0, Rec);

                if Status = Status::Open then
                    SetCompanyBankAccount();
            end;
        }
        field(72009; "LFS Custom Currency Factor"; Decimal)
        {
            Caption = 'Custom Currency Factor';
            Editable = false;
            MinValue = 0;
            DecimalPlaces = 0 : 15;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UpdateSalesLines(Format(FIELDCAPTION("LFS Custom Currency Code")), FALSE);
                Validate("Currency Factor", "LFS Custom Currency Factor");
            end;
        }
        field(72010; "LFS Shipping Line"; Code[20])
        {
            Caption = 'Shipping Line';
            TableRelation = "LFS EXIM Shipping Line";
            DataClassification = CustomerContent;
        }
        field(72011; "LFS Pre Carriage"; Enum "LFS Pre Carriage")
        {
            Caption = 'Pre Carriage';
            DataClassification = CustomerContent;
        }
        // field(72012; "LFS Bill of Lading Date"; Date)
        // {
        //     Caption = 'Bill of Lading Date';
        //     DataClassification = CustomerContent;
        // }
        // field(72013; "LFS Bill of Lading No."; Code[20])
        // {
        //     Caption = 'Bill of Lading No.';
        //     DataClassification = CustomerContent;
        // }
        field(72014; "LFS ETD"; Date)
        {
            Caption = 'ETD';
            DataClassification = CustomerContent;
        }
        field(72015; "LFS ETA"; Date)
        {
            Caption = 'ETA';
            DataClassification = CustomerContent;
        }
        field(72016; "LFS Customs Bank Account"; Code[20])
        {
            Caption = 'Customs Bank Account';
            TableRelation = "Bank Account"."No.";
            DataClassification = CustomerContent;
        }
        field(72017; "LFS Commercial Bank Account"; Code[20])
        {
            Caption = 'Commercial  Bank Account';
            TableRelation = "Bank Account"."No.";
            DataClassification = CustomerContent;
        }
        // field(72018; "LFS Carrier"; Text[30])
        // {
        //     Caption = 'Carrier';
        //     DataClassification = CustomerContent;
        // }
        // field(72019; "LFS Late export order No."; code[15])
        // {
        //     Caption = 'Late export order No.';
        //     DataClassification = CustomerContent;
        // }
        // field(72020; "LFS Late export order date"; Date)
        // {
        //     Caption = 'Late export order date';
        //     DataClassification = CustomerContent;
        // }

        // field(72021; "LFS bill No."; code[15])
        // {
        //     Caption = 'Bill No.';
        //     DataClassification = CustomerContent;
        // }
        // field(72022; "LFS bill Date"; Date)
        // {
        //     Caption = 'Bill Date';
        //     DataClassification = CustomerContent;
        // }
        field(72023; "LFS Shipping Bill No."; Code[50])
        {
            Caption = 'Shipping Bill No.';
            DataClassification = CustomerContent;
        }
        field(72024; "LFS Shipping Bill Date"; Date)
        {
            Caption = 'Shipping Bill Date';
            DataClassification = CustomerContent;
        }
        // field(72026; "LFS DDB Value"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'DDB Value';
        // }
        // field(72027; "LFS FOB Amount (FCY)"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'FOB Amount (FCY)';
        // }
        // field(72028; "LFS FOB Amount (LCY)"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'FOB Amount (LCY)';
        // }
        // field(72029; "LFS CIF Amount (FCY)"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'CIF Amount (FCY)';
        // }
        // field(72030; "LFS CIF Amount (LCY)"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'CIF Amount (LCY)';
        // }
        // field(72031; "LFS FOB Amount (FCY) LFSPL"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'FOB Amount (FCY)';
        // }
        // field(72032; "LFS Shortcut Dim Update"; Code[20])
        // {
        //     Caption = 'Shortcut Dim Update';
        //     DataClassification = CustomerContent;
        //     trigger OnValidate()
        //     begin
        //         ValidateShortcutDimCode(5, "LFS Shortcut Dim Update");
        //     end;
        // }
        field(72033; "LFS Your Reference Date"; Date)
        {
            Caption = 'Your Reference Date';
            DataClassification = CustomerContent;
        }
        // field(72034; "LFS Adv. Payment"; Boolean)
        // {
        //     Caption = 'Adv. Payment';
        //     DataClassification = CustomerContent;
        // }
        // field(72035; "LFS License"; Boolean)
        // {
        //     Caption = 'License';
        //     DataClassification = CustomerContent;
        // }
        // field(72036; "LFS LC"; Boolean)
        // {
        //     Caption = 'LC';
        //     DataClassification = CustomerContent;
        // }
        // field(72037; "LFS Import Documents"; Boolean)
        // {
        //     Caption = 'Import Documents';
        //     DataClassification = CustomerContent;
        // }
        // field(72038; "LFS COA Approval"; Boolean)
        // {
        //     Caption = 'COA Approval';
        //     DataClassification = CustomerContent;
        // }
        // field(72039; "LFS Credit Block"; Boolean)
        // {
        //     Caption = 'Credit Block';
        //     DataClassification = CustomerContent;
        // }
        // field(72040; "LFS PSS Approval"; Boolean)
        // {
        //     Caption = 'PSS Approval';
        //     DataClassification = CustomerContent;
        // }
        // field(72041; "LFS other"; Boolean)
        // {
        //     Caption = 'Other';
        //     DataClassification = CustomerContent;
        // }
        // field(72042; "LFS Narcotix NOC"; Boolean)
        // {
        //     Caption = 'Narcotix NOC';
        //     DataClassification = CustomerContent;
        // }
        // field(72043; "LFS Additional Information"; Text[500])
        // {
        //     Caption = 'Additional Information';
        //     DataClassification = CustomerContent;
        // }
        // field(72044; "LFS FTT No."; Code[20])
        // {
        //     Caption = 'FTT No.';
        //     DataClassification = CustomerContent;
        // }
        // field(72045; "LFS FTT Date"; Date)
        // {
        //     Caption = 'FTT Date';
        //     DataClassification = CustomerContent;
        // }
        // field(72046; "LFS BIN No."; Code[20])
        // {
        //     Caption = 'BIN No.';
        //     DataClassification = CustomerContent;
        // }
        // field(72047; "LFS Commission Agent"; Code[20])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Commission Agent';
        //     trigger OnLookup()
        //     var
        //         vendor: Record Vendor;
        //     begin
        //         if page.Runmodal(page::"Vendor List", vendor) = action::LookupOK then
        //             Rec."LFS Commission Agent" := vendor."No.";
        //     end;
        // }
        // field(72048; "LFS Comm. Amount"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Commission Amount';
        // }
        field(72050; "LFS FOB CIF Calc. Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'FOB/CIF Calculation Type';
            OptionCaption = 'FOB,CIF';
            OptionMembers = FOB,CIF;
            trigger OnValidate()
            var
                SalesLine: Record "Sales Line";
                exchRate: Decimal;
            begin
                SalesLine.SetRange("Document Type", Rec."Document Type");
                SalesLine.SetRange("Document No.", Rec."No.");
                if SalesLine.Findset() then
                    repeat
                        salesline."LFS FOB CIF Calc. Type" := Rec."LFS FOB CIF Calc. Type";
                        if rec."Currency Factor" <> 0 then begin
                            exchRate := 1 / rec."Currency Factor";
                            SalesLine."LFS Custom Exch. Rate" := exchRate;
                            if rec."LFS FOB CIF Calc. Type" = rec."LFS FOB CIF Calc. Type"::FOB then begin
                                SalesLine."LFS FOB Amount (FCY)" := SalesLine."Line Amount";
                                SalesLine."LFS FOB Amount (LCY)" := SalesLine."Line Amount" * exchRate;
                                SalesLine."LFS Freight Value (LCY)" := SalesLine."LFS Freight Value (FCY)" * exchRate;
                                SalesLine."LFS Insurance Value (LCY)" := SalesLine."LFS Insurance Value (FCY)" * exchRate;
                                SalesLine."LFS CIF Value (FCY)" := SalesLine."LFS Freight Value (FCY)" + SalesLine."LFS Insurance Value (FCY)" + SalesLine."LFS FOB Amount (FCY)";
                                SalesLine."LFS CIF Value (LCY)" := SalesLine."LFS CIF Value (FCY)" * exchRate;
                                // if SalesLine.Quantity <> 0 then begin
                                //     SalesLine."LFS FOB Amount (FCY)" := SalesLine."LFS FOB Amount (FCY)" / SalesLine.quantity;
                                //     SalesLine."LFS CIF Amount (FCY)" := SalesLine."LFS CIF Value (FCY)" / SalesLine.Quantity;
                                // end;
                            end
                            else
                                if rec."LFS FOB CIF Calc. Type" = rec."LFS FOB CIF Calc. Type"::CIF then begin
                                    SalesLine."LFS Freight Value (LCY)" := SalesLine."LFS Freight Value (FCY)" * exchRate;
                                    SalesLine."LFS Insurance Value (LCY)" := SalesLine."LFS Insurance Value (FCY)" * exchRate;
                                    SalesLine."LFS CIF Value (FCY)" := SalesLine."Line Amount";
                                    SalesLine."LFS CIF Value (LCY)" := SalesLine."Line Amount" * exchRate;
                                    SalesLine."LFS FOB Amount (FCY)" := SalesLine."LFS CIF Value (FCY)" - SalesLine."LFS Freight Value (FCY)" - SalesLine."LFS Insurance Value (FCY)";
                                    SalesLine."LFS FOB Amount (LCY)" := SalesLine."LFS FOB Amount (FCY)" * exchRate;
                                    // if SalesLine.Quantity <> 0 then begin
                                    //     SalesLine."LFS FOB Amount (FCY)" := SalesLine."LFS FOB Amount (FCY)" / SalesLine.quantity;
                                    //     SalesLine."LFS CIF Amount (FCY)" := SalesLine."LFS CIF Value (FCY)" / SalesLine.Quantity;
                                    // end;
                                end;
                            SalesLine.Modify();
                        end;
                    until SalesLine.Next() = 0;
            end;
        }
        // field(72051; "LFS Commission %"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Commission %';
        // }
        // field(72052; "LFS Packing Type"; Option)
        // {
        //     OptionMembers = Custom,Commercial;
        //     OptionCaption = ' ,Custom,Commercial';
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("LFS EXIM Packing Lines"."LFS Type" where("LFS Shipment Document No." = field("No.")));
        //     Editable = false;
        //     Caption = 'Packing Type';
        // }
        // field(72053; "LFS Packing No."; Code[20])
        // {
        //     Caption = 'Packing No.';
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("LFS EXIM Packing Lines"."LFS Packing List No." where("LFS Shipment Document No." = field("No.")));
        //     Editable = false;
        // }
        // field(72054; "LFS Completely Packed"; Boolean)
        // {
        //     Caption = 'Completely Packed';
        //     FieldClass = FlowField;
        //     CalcFormula = - exist("Sales Shipment Line" where("Document No." = field("No."), Type = filter(Item)/*,Rem."Qty. To be Packed"=FILTER(<>0)*/));
        //     Editable = false;
        // }
        // field(72055; "LFS Total Line Qty."; Decimal)
        // {
        //     Caption = 'Total Line Qty.';
        //     FieldClass = FlowField;
        //     CalcFormula = Sum("Sales Shipment Line".Quantity where("Document No." = FIELD("No."), Type = FILTER(Item)));
        //     Editable = false;
        // }
        // field(72056; "LFS Packing Posted"; Boolean)
        // {
        //     Caption = 'Packing Posted';
        //     DataClassification = CustomerContent;
        // }
        // field(72057; "LFS Notify Party 1"; Code[20])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Notify Party 1';
        //     TableRelation = "LFS EXIM Notifying Parties"."LFS Party Code";
        // }
        // field(72058; "LFS Notify Party 2"; Code[20])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Notify Party 2';
        //     TableRelation = "LFS EXIM Notifying Parties"."LFS Party Code";
        // }
        // field(72059; "LFS Notify Party 3"; Code[20])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Notify Party 3';
        //     TableRelation = "LFS EXIM Notifying Parties"."LFS Party Code";
        // }

        field(72060; "IRN Hash"; Text[64])
        {
            Caption = 'IRN Hash';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(72061; "Cancel Reason"; Enum "e-Invoice Cancel Reason")
        {
            Caption = 'Cancel Reason';
            DataClassification = CustomerContent;
        }
        field(72062; "LFS Dispatch Date"; Date)
        {
            Caption = 'Dispatch Date';
            DataClassification = CustomerContent;
        }
        field(72063; "LFSPlaceofReceiptPre-Carriage"; Enum "LFS Pre Carriage")
        {
            DataClassification = CustomerContent;
            Caption = 'Place of Receipt By Pre-Carriage';
        }
        field(72064; "Json Body"; Blob)
        {
            DataClassification = CustomerContent;
            Caption = 'Json Body';
        }
        field(72065; "Acknowledgement No."; Text[30])
        {
            Caption = 'Acknowledgement No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(72066; "E-Inv. Cancelled Date"; DateTime)
        {
            Caption = 'E-Inv. Cancelled Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(72067; "QR Code"; Blob)
        {
            Subtype = Bitmap;
            Caption = 'QR Code';
            DataClassification = CustomerContent;
        }
        field(72068; "Acknowledgement Date"; DateTime)
        {
            Caption = 'Acknowledgement Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(72070; "LFS LUT No."; Code[30])
        {
            Caption = 'LUT No.';
            DataClassification = CustomerContent;
            TableRelation = "LFS LUT Master Table"."LFS LUT No.";
            trigger OnValidate()
            var
                LUTMaster: Record "LFS LUT Master Table";
            begin
                if LUTMaster.get("LFS LUT No.") then begin
                    Rec."GST Without Payment of Duty" := true;
                    Rec."LFS LUT Date" := LUTMaster."LFS LUT Expiry Date";
                end
                else begin
                    Rec."GST Without Payment of Duty" := false;
                    Rec."LFS LUT Date" := 0D;
                end;
            end;
        }
        field(72071; "LFS LUT Date"; Date)
        {
            Caption = 'LUT Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        // field(72069; "LFS Near Expiry Sales"; Boolean)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Near Expiry Sales';
        // }
        // field(72070; "LFS Bills OverDue"; Boolean)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Order Level Bills OverDue';
        // }
        // field(72071; "LFS INV Bills OverDue"; Boolean)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Invoice Level Bills OverDue';
        // }
        // field(72072; "LFS Skip Inv Bill Overdue"; Boolean)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Skip Invoice Bills Overdue';
        // }
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                if Rec."No." <> '' then
                    Rec.Validate("Posting No.", Rec."No.");
            end;
        }
    }

    trigger OnAfterInsert()
    begin
        if (Rec."No." <> '') and (Rec."LFS EXIM Type" = Rec."LFS EXIM Type"::Export) then
            Rec.Validate("Posting No.", Rec."No.");
    end;

    var
        EximSetup: Record "LFS EXIM Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit "No. Series";
        SalesCalcDiscountByType: Codeunit "Sales - Calc Discount By Type";
    // NoSeries: Codeunit "No. Series";


    procedure AssistEditExport(OldSalesHeader: Record "Sales Header"): Boolean
    begin
        if "LFS EXIM Type" = "LFS EXIM Type"::" " then begin
            SalesSetup.GET();
            TestNoSeries();
            if NoSeriesMgt.LookupRelatedNoSeries(GetNoSeriesCode(), OldSalesHeader."No. Series", Rec."No. Series") then begin
                SalesSetup.GET();
                TestNoSeries();
                NoSeriesMgt.GetNextNo(Rec."No. Series", WorkDate());
                EXIT(true);
            end;
        end else begin
            EximSetup.Get();
            TestEximExportNoSeries();
            if NoSeriesMgt.LookupRelatedNoSeries(GetEximExportNoSeriesCode(), OldSalesHeader."No. Series", Rec."No. Series") then begin
                // NoSeriesMgt.GetNextNo(Rec."No. Series", WorkDate());
                // NoSeriesMgt.PeekNextNo(Rec."No. Series", WorkDate());
                Rec."No." := NoSeriesMgt.GetNextNo(Rec."No. Series", WorkDate());
                EXIT(true);
            end;
        end;
    end;


    procedure GetEximExportNoSeriesCode(): Code[20]
    begin
        EximSetup.Get();
        CASE "Document Type" OF
            "Document Type"::Order:
                EXIT(EximSetup."LFS Export Order Nos.");
            "Document Type"::Invoice:
                EXIT(EximSetup."LFS Export Invoice Nos.");
            "Document Type"::"Blanket Order":
                EXIT(EximSetup."LFS Blanket Exp Order No.");
            "Document Type"::Quote:
                EXIT(EximSetup."LFS Export Sales Quote Nos.");
            "Document Type"::"Credit Memo":
                EXIT(EximSetup."LFS Export SalesCreditMemoNos.");
        end;
    end;

    procedure TestEximExportNoSeries(): Boolean
    begin
        EximSetup.Get();
        case "Document Type" of
            "Document Type"::Quote:
                EximSetup.TestField("LFS Export Sales Quote Nos.");
            "Document Type"::Order:
                EximSetup.TESTFIELD("LFS Export Order Nos.");
            "Document Type"::Invoice:
                begin
                    EximSetup.TESTFIELD("LFS Export Invoice Nos.");
                    EximSetup.TESTFIELD("LFS Posted Exp Invoice Nos.");
                end;
            "Document Type"::"Return Order":
                ERROR('Exim Return Order not allowed');
            "Document Type"::"Credit Memo":
                begin
                    EximSetup.TestField("LFS Export SalesCreditMemoNos.");
                    EximSetup.TestField("LFS Pstd Export SalesCrMemoNos");
                end;
            "Document Type"::"Blanket Order":
                EximSetup.TESTFIELD("LFS Blanket Exp Order No.");
        end;
    end;

    local procedure ResetInvoiceDiscountValue()
    // var
    //     IsHandled: Boolean;
    begin
        // IsHandled := false;
        // // OnBeforeResetInvoiceDiscountValue(Rec, IsHandled);
        // if IsHandled then
        //     exit;

        if "Invoice Discount Value" <> 0 then begin
            CalcFields("Invoice Discount Amount");
            if "Invoice Discount Amount" = 0 then
                "Invoice Discount Value" := 0;
        end;
    end;

    procedure UpdateCurrencyFactorNew()
    var
        CurrExchRate: Record "Currency Exchange Rate";
        UpdateCurrencyExchangeRates: Codeunit "Update Currency Exchange Rates";
        CurrencyDate: Date;
    // Updated: Boolean;
    begin
        // OnBeforeUpdateCurrencyFactor(Rec, Updated, CurrExchRate, xRec);
        // if Updated then
        //     exit;

        if "LFS Custom Currency Code" <> '' then begin
            if Rec."Posting Date" <> 0D then
                CurrencyDate := Rec."Posting Date"
            else
                CurrencyDate := WorkDate();

            if UpdateCurrencyExchangeRates.ExchangeRatesForCurrencyExist(CurrencyDate, "LFS Custom Currency Code") then begin
                "LFS Custom Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate, "LFS Custom Currency Code");
                if ("LFS Custom Currency Code" <> xRec."LFS Custom Currency Code") and (xRec."No." <> '') then
                    RecreateSalesLines(FieldCaption("LFS Custom Currency Code"));
            end else
                UpdateCurrencyExchangeRates.ShowMissingExchangeRatesNotification("LFS Custom Currency Code");
        end else begin
            "LFS Custom Currency Factor" := 0;
            if "LFS Custom Currency Code" <> xRec."LFS Custom Currency Code" then
                RecreateSalesLines(FieldCaption("LFS Custom Currency Code"));
        end;

        // OnAfterUpdateCurrencyFactor(Rec, GetHideValidationDialog());
    end;

    procedure ConfirmCurrencyFactorUpdateNew()
    var
        ForceConfirm: Boolean;
        IsHandled: Boolean;
        Confirmed: Boolean;
        // CurrencyDate: Date;
        Text021Lbl: Label 'Do you want to update the exchange rate?';

    begin
        IsHandled := false;
        ForceConfirm := false;
        // OnBeforeConfirmUpdateCurrencyFactor(Rec, HideValidationDialog, xRec, IsHandled, ForceConfirm);
        if IsHandled then
            exit;

        if GetHideValidationDialog() or not GuiAllowed() or ForceConfirm then
            Confirmed := true
        else
            Confirmed := Confirm(Text021Lbl, false);
        if Confirmed then
            Validate("LFS Custom Currency Factor")
        else
            "LFS Custom Currency Factor" := xRec."LFS Custom Currency Factor";

        // OnAfterConfirmCurrencyFactorUpdate(Rec, Confirmed);
    end;

    local procedure ShouldCheckShowRecurringSalesLines(var xHeader: Record "Sales Header"; var Header: Record "Sales Header"): Boolean
    begin
        exit(
            (xHeader."Bill-to Customer No." <> '') and
            (Header."No." <> '') and
            (Header."LFS Custom Currency Code" <> xHeader."LFS Custom Currency Code")
        );
    end;

    local procedure SetCompanyBankAccount()
    var
        BankAccount: Record "Bank Account";
    // IsHandled: Boolean;
    begin
        // IsHandled := false;
        // OnBeforeSetCompanyBankAccount(Rec, IsHandled);
        // if not IsHandled then
        Validate("Company Bank Account Code", BankAccount.GetDefaultBankAccountNoForCurrency("LFS Custom Currency Code"));
        // OnAfterSetCompanyBankAccount(Rec, xRec);
    end;
}