namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Finance.Currency;

table 72004 "LFSEXIM Currency Exchange Rate"
{
    Caption = 'EXIM Currency Exchange Rate';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "LFS Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = CustomerContent;
            TableRelation = Currency;

            trigger OnValidate()
            begin
                if "LFS Currency Code" = "LFS Rel Currency Code" then
                    Error(Text000Lbl, FieldCaption("LFS Currency Code"), FieldCaption("LFS Rel Currency Code"));
            end;
        }
        field(2; "LFS Starting Date"; Date)
        {
            Caption = 'Starting Date';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(3; "LFS Exch Rate Amount (Imp)"; Decimal)
        {
            Caption = 'Exch Rate Amount (Import)';
            DecimalPlaces = 1 : 6;
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestField("LFS Exch Rate Amount (Imp)");
            end;
        }
        field(4; "LFS Adj Exch. Rate Amount"; Decimal)
        {
            Caption = 'Adjustment Exch. Rate Amount';
            AccessByPermission = TableData 4 = R;
            DecimalPlaces = 1 : 6;
            MinValue = 0;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestField("LFS Adj Exch. Rate Amount");
            end;
        }
        field(5; "LFS Rel Currency Code"; Code[10])
        {
            TableRelation = Currency;
            Caption = 'Relational Currency Code';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "LFS Currency Code" = "LFS Rel Currency Code" then
                    Error(Text000Lbl, FieldCaption("LFS Currency Code"), FieldCaption("LFS Rel Currency Code"));
            end;
        }
        field(6; "LFS Rel Exch Rate Amt (Imp)"; Decimal)
        {
            Caption = 'Relational Exchange Rate Amount (Import)';
            AccessByPermission = TableData 4 = R;
            DecimalPlaces = 1 : 6;
            MinValue = 0;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestField("LFS Rel Exch Rate Amt (Imp)");
            end;
        }
        field(7; "LFS Fix Exch Rate Amount"; Option)
        {
            Caption = 'Fix Exchange Rate Amount';
            DataClassification = CustomerContent;
            OptionMembers = Currency,"Relational Currency",Both;
            OptionCaption = 'Currency,Relational Currency,Both';
        }
        field(8; "LFS Rel Adjmt Exch Rate Amt"; Decimal)
        {
            Caption = 'Relational Adjustment Exchange Rate Amount';
            DataClassification = CustomerContent;
            AccessByPermission = TableData 4 = R;
            DecimalPlaces = 1 : 6;
            MinValue = 0;
            trigger OnValidate()
            begin
                TESTFIELD("LFS Rel Adjmt Exch Rate Amt");
            end;
        }
        field(9; "LFS Exch Rate Amount (Exp)"; Decimal)
        {
            Caption = 'Exchange Rate Amount (Export)';
            DataClassification = CustomerContent;
            DecimalPlaces = 1 : 6;
            MinValue = 0;
            trigger OnValidate()
            begin
                TESTFIELD("LFS Exch Rate Amount (Imp)");
            end;
        }
        field(10; "LFS Rel Exch Rate Amt (Exp)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Relational Exchange Rate Amount (Export)';
            AccessByPermission = TableData 4 = R;
            DecimalPlaces = 1 : 6;
            MinValue = 0;
            trigger OnValidate()
            begin
                TestField("LFS Rel Exch Rate Amt (Imp)");
            end;
        }
    }

    keys
    {
        key(Key1; "LFS Currency Code", "LFS Starting Date")
        {
            Clustered = true;
        }

    }

    var
        CurrencyExchRate2: array[2] of Record "LFSEXIM Currency Exchange Rate";
        CurrencyExchRate3: array[3] of Record "LFSEXIM Currency Exchange Rate";
#pragma warning disable AA0470
        Text000Lbl: Label 'The currency code in the %1 field and the %2 field cannot be the same.';
#pragma warning restore AA0470
        CurrencyCode2: array[2] of Code[10];
        Date2: array[2] of Date;
        ExchangeRateAmt: Decimal;
        RelExchangeRateAmt: Decimal;
        RelCurrencyCode: Code[10];
        FixExchangeRateAmt: Option;
        CurrencyFactor: Decimal;
        UseAdjmtAmounts: Boolean;

    procedure ApplnExchangeAmtFCYToFCY(Date: Date; FromCurrencyCode: Code[10]; ToCurrencyCode: Code[10]; Amount: Decimal; VAR ExchRateFound: Boolean): Decimal;
    begin
        if FromCurrencyCode = ToCurrencyCode then
            EXIT(Amount);
        if ToCurrencyCode = '' then begin
            ExchRateFound := FindApplnCurrency(Date, FromCurrencyCode, 1);
            if NOT ExchRateFound then
                EXIT(0);

            if CurrencyExchRate3[1]."LFS Rel Currency Code" = '' then
                EXIT(
                  (Amount / CurrencyExchRate3[1]."LFS Exch Rate Amount (Imp)") *
                  CurrencyExchRate3[1]."LFS Rel Exch Rate Amt (Imp)");

            ExchRateFound := FindApplnCurrency(Date, CurrencyExchRate3[1]."LFS Rel Currency Code", 3);
            if NOT ExchRateFound then
                EXIT(0);

            Amount :=
              (Amount / CurrencyExchRate3[1]."LFS Exch Rate Amount (Imp)") *
              CurrencyExchRate3[1]."LFS Rel Exch Rate Amt (Imp)";
            EXIT(
              (Amount / CurrencyExchRate3[3]."LFS Exch Rate Amount (Imp)") *
              CurrencyExchRate3[3]."LFS Rel Exch Rate Amt (Imp)");
        end;
        if FromCurrencyCode = '' then begin
            ExchRateFound := FindApplnCurrency(Date, ToCurrencyCode, 2);
            if NOT ExchRateFound then
                EXIT(0);

            if CurrencyExchRate3[2]."LFS Rel Currency Code" = '' then
                EXIT(
                  (Amount / CurrencyExchRate3[2]."LFS Rel Exch Rate Amt (Imp)") *
                  CurrencyExchRate3[2]."LFS Exch Rate Amount (Imp)");

            ExchRateFound := FindApplnCurrency(Date, CurrencyExchRate3[2]."LFS Rel Currency Code", 3);
            if NOT ExchRateFound then
                EXIT(0);

            Amount :=
              ((Amount / CurrencyExchRate3[2]."LFS Rel Exch Rate Amt (Imp)") *
               CurrencyExchRate3[2]."LFS Exch Rate Amount (Imp)");
            EXIT(
              (Amount / CurrencyExchRate3[3]."LFS Rel Exch Rate Amt (Imp)") *
              CurrencyExchRate3[3]."LFS Exch Rate Amount (Imp)");
        end;
        ExchRateFound := FindApplnCurrency(Date, FromCurrencyCode, 1);
        if NOT ExchRateFound then
            EXIT(0);

        ExchRateFound := FindApplnCurrency(Date, ToCurrencyCode, 2);
        if NOT ExchRateFound then
            EXIT(0);

        if CurrencyExchRate3[1]."LFS Currency Code" = CurrencyExchRate3[2]."LFS Rel Currency Code" then
            EXIT(
              (Amount / CurrencyExchRate3[2]."LFS Rel Exch Rate Amt (Imp)") *
              CurrencyExchRate3[2]."LFS Exch Rate Amount (Imp)");
        if CurrencyExchRate3[1]."LFS Rel Currency Code" = CurrencyExchRate3[2]."LFS Currency Code" then
            EXIT(
              (Amount / CurrencyExchRate3[1]."LFS Exch Rate Amount (Imp)") *
              CurrencyExchRate3[1]."LFS Rel Exch Rate Amt (Imp)");

        if CurrencyExchRate3[1]."LFS Rel Currency Code" = CurrencyExchRate3[2]."LFS Rel Currency Code" then begin
            Amount :=
              ((Amount / CurrencyExchRate3[1]."LFS Exch Rate Amount (Imp)") *
               CurrencyExchRate3[1]."LFS Rel Exch Rate Amt (Imp)");
            EXIT(
              (Amount / CurrencyExchRate3[2]."LFS Rel Exch Rate Amt (Imp)") *
              CurrencyExchRate3[2]."LFS Exch Rate Amount (Imp)");
        end;
        if (CurrencyExchRate3[1]."LFS Rel Currency Code" = '') AND
           (CurrencyExchRate3[2]."LFS Rel Currency Code" <> '')
        then begin
            ExchRateFound := FindApplnCurrency(Date, CurrencyExchRate3[2]."LFS Rel Currency Code", 3);
            if NOT ExchRateFound then
                EXIT(0);

            Amount :=
              (Amount * CurrencyExchRate3[1]."LFS Rel Exch Rate Amt (Imp)") /
              CurrencyExchRate3[1]."LFS Exch Rate Amount (Imp)";
            Amount :=
              (Amount / CurrencyExchRate3[3]."LFS Rel Exch Rate Amt (Imp)") *
              CurrencyExchRate3[3]."LFS Exch Rate Amount (Imp)";
            EXIT(
              (Amount / CurrencyExchRate3[2]."LFS Rel Exch Rate Amt (Imp)") *
              CurrencyExchRate3[2]."LFS Exch Rate Amount (Imp)");
        end;
        if (CurrencyExchRate3[1]."LFS Rel Currency Code" <> '') AND
           (CurrencyExchRate3[2]."LFS Rel Currency Code" = '')
        then begin
            ExchRateFound := FindApplnCurrency(Date, CurrencyExchRate3[1]."LFS Rel Currency Code", 3);
            if NOT ExchRateFound then
                EXIT(0);

            Amount :=
              (Amount / CurrencyExchRate3[1]."LFS Exch Rate Amount (Imp)") *
              CurrencyExchRate3[1]."LFS Rel Exch Rate Amt (Imp)";
            Amount :=
              (Amount / CurrencyExchRate3[3]."LFS Exch Rate Amount (Imp)") *
              CurrencyExchRate3[3]."LFS Rel Exch Rate Amt (Imp)";
            EXIT(
              (Amount / CurrencyExchRate3[2]."LFS Rel Exch Rate Amt (Imp)") *
              CurrencyExchRate3[2]."LFS Exch Rate Amount (Imp)");
        end;
    end;

    procedure ExchangeAmount(Amount: Decimal; FromCurrencyCode: Code[10]; ToCurrencyCode: Code[10]; UsePostingDate: Date): Decimal;
    VAR
        ToCurrency: Record Currency;
    begin
        if (FromCurrencyCode = ToCurrencyCode) OR (Amount = 0) then
            EXIT(Amount);

        Amount := ExchangeAmtFCYToFCY(UsePostingDate, FromCurrencyCode, ToCurrencyCode, Amount);

        if ToCurrencyCode <> '' then begin
            ToCurrency.GET(ToCurrencyCode);
            Amount := ROUND(Amount, ToCurrency."Amount Rounding Precision");
        end else
            Amount := ROUND(Amount);

        EXIT(Amount);
    end;

    procedure ExchangeAmtFCYToFCY(Date: Date; FromCurrencyCode: Code[10]; ToCurrencyCode: Code[10]; Amount: Decimal): Decimal;
    begin
        if FromCurrencyCode = ToCurrencyCode then
            EXIT(Amount);
        if ToCurrencyCode = '' then begin
            FindCurrency2(Date, FromCurrencyCode, 1);
            if CurrencyExchRate3[1]."LFS Rel Currency Code" = '' then
                EXIT(
                  (Amount / CurrencyExchRate3[1]."LFS Exch Rate Amount (Imp)") *
                  CurrencyExchRate3[1]."LFS Rel Exch Rate Amt (Imp)");

            FindCurrency2(Date, CurrencyExchRate3[1]."LFS Rel Currency Code", 3);
            Amount :=
              ((Amount / CurrencyExchRate3[1]."LFS Exch Rate Amount (Imp)") *
               CurrencyExchRate3[1]."LFS Rel Exch Rate Amt (Imp)");
            EXIT(
              (Amount / CurrencyExchRate3[3]."LFS Exch Rate Amount (Imp)") *
              CurrencyExchRate3[3]."LFS Rel Exch Rate Amt (Imp)");
        end;
        if FromCurrencyCode = '' then begin
            FindCurrency2(Date, ToCurrencyCode, 2);
            if CurrencyExchRate3[2]."LFS Rel Currency Code" = '' then
                EXIT(
                  (Amount / CurrencyExchRate3[2]."LFS Rel Exch Rate Amt (Imp)") *
                  CurrencyExchRate3[2]."LFS Exch Rate Amount (Imp)");

            FindCurrency2(Date, CurrencyExchRate3[2]."LFS Rel Currency Code", 3);
            Amount :=
              ((Amount / CurrencyExchRate3[2]."LFS Rel Exch Rate Amt (Imp)") *
               CurrencyExchRate3[2]."LFS Exch Rate Amount (Imp)");
            EXIT(
              (Amount / CurrencyExchRate3[3]."LFS Rel Exch Rate Amt (Imp)") *
              CurrencyExchRate3[3]."LFS Exch Rate Amount (Imp)");
        end;
        FindCurrency2(Date, FromCurrencyCode, 1);
        FindCurrency2(Date, ToCurrencyCode, 2);
        if CurrencyExchRate3[1]."LFS Currency Code" = CurrencyExchRate3[2]."LFS Rel Currency Code" then
            EXIT(
              (Amount / CurrencyExchRate3[2]."LFS Rel Exch Rate Amt (Imp)") *
              CurrencyExchRate3[2]."LFS Exch Rate Amount (Imp)");
        if CurrencyExchRate3[1]."LFS Rel Currency Code" = CurrencyExchRate3[2]."LFS Currency Code" then
            EXIT(
              (Amount / CurrencyExchRate3[1]."LFS Exch Rate Amount (Imp)") *
              CurrencyExchRate3[1]."LFS Rel Exch Rate Amt (Imp)");

        if CurrencyExchRate3[1]."LFS Rel Currency Code" = CurrencyExchRate3[2]."LFS Rel Currency Code" then begin
            Amount :=
              ((Amount / CurrencyExchRate3[1]."LFS Exch Rate Amount (Imp)") *
               CurrencyExchRate3[1]."LFS Rel Exch Rate Amt (Imp)");
            EXIT(
              (Amount / CurrencyExchRate3[2]."LFS Rel Exch Rate Amt (Imp)") *
              CurrencyExchRate3[2]."LFS Exch Rate Amount (Imp)");
        end;
        if (CurrencyExchRate3[1]."LFS Rel Currency Code" = '') AND
           (CurrencyExchRate3[2]."LFS Rel Currency Code" <> '')
        then begin
            FindCurrency2(Date, CurrencyExchRate3[2]."LFS Rel Currency Code", 3);
            Amount :=
              (Amount * CurrencyExchRate3[1]."LFS Rel Exch Rate Amt (Imp)") /
              CurrencyExchRate3[1]."LFS Exch Rate Amount (Imp)";
            Amount :=
              (Amount / CurrencyExchRate3[3]."LFS Rel Exch Rate Amt (Imp)") *
              CurrencyExchRate3[3]."LFS Exch Rate Amount (Imp)";
            EXIT(
              (Amount / CurrencyExchRate3[2]."LFS Rel Exch Rate Amt (Imp)") *
              CurrencyExchRate3[2]."LFS Exch Rate Amount (Imp)");
        end;
        if (CurrencyExchRate3[1]."LFS Rel Currency Code" <> '') AND
           (CurrencyExchRate3[2]."LFS Rel Currency Code" = '')
        then begin
            FindCurrency2(Date, CurrencyExchRate3[1]."LFS Rel Currency Code", 3);
            Amount :=
              (Amount / CurrencyExchRate3[1]."LFS Exch Rate Amount (Imp)") *
              CurrencyExchRate3[1]."LFS Rel Exch Rate Amt (Imp)";
            Amount :=
              (Amount / CurrencyExchRate3[3]."LFS Exch Rate Amount (Imp)") *
              CurrencyExchRate3[3]."LFS Rel Exch Rate Amt (Imp)";
            EXIT(
              (Amount / CurrencyExchRate3[2]."LFS Rel Exch Rate Amt (Imp)") *
              CurrencyExchRate3[2]."LFS Exch Rate Amount (Imp)");
        end;
    end;

    procedure ExchangeAmtFCYToLCY(Date: Date; CurrencyCode: Code[10]; Amount: Decimal; Factor: Decimal): Decimal;
    begin
        if CurrencyCode = '' then
            EXIT(Amount);
        FindCurrency(Date, CurrencyCode, 1);
        if NOT UseAdjmtAmounts then begin
            TESTFIELD("LFS Exch Rate Amount (Imp)");
            TESTFIELD("LFS Rel Exch Rate Amt (Imp)");
        end else begin
            TESTFIELD("LFS Adj Exch. Rate Amount");
            TESTFIELD("LFS Rel Adjmt Exch Rate Amt");
            "LFS Exch Rate Amount (Imp)" := "LFS Adj Exch. Rate Amount";
            "LFS Rel Exch Rate Amt (Imp)" := "LFS Rel Adjmt Exch Rate Amt";
        end;
        if "LFS Rel Currency Code" = '' then
            if "LFS Fix Exch Rate Amount" = "LFS Fix Exch Rate Amount"::Both then
                Amount := (Amount / "LFS Exch Rate Amount (Imp)") * "LFS Rel Exch Rate Amt (Imp)"
            else
                Amount := Amount / Factor
        else begin
            RelExchangeRateAmt := "LFS Rel Exch Rate Amt (Imp)";
            ExchangeRateAmt := "LFS Exch Rate Amount (Imp)";
            RelCurrencyCode := "LFS Rel Currency Code";
            FixExchangeRateAmt := "LFS Fix Exch Rate Amount";
            FindCurrency(Date, RelCurrencyCode, 2);
            if NOT UseAdjmtAmounts then begin
                TESTFIELD("LFS Exch Rate Amount (Imp)");
                TESTFIELD("LFS Rel Exch Rate Amt (Imp)");
            end else begin
                TESTFIELD("LFS Adj Exch. Rate Amount");
                TESTFIELD("LFS Rel Adjmt Exch Rate Amt");
                "LFS Exch Rate Amount (Imp)" := "LFS Adj Exch. Rate Amount";
                "LFS Rel Exch Rate Amt (Imp)" := "LFS Rel Adjmt Exch Rate Amt";
            end;
            CASE FixExchangeRateAmt OF
                "LFS Fix Exch Rate Amount"::"Relational Currency":
                    ExchangeRateAmt :=
                      (RelExchangeRateAmt * "LFS Rel Exch Rate Amt (Imp)") /
                      ("LFS Exch Rate Amount (Imp)" * Factor);
                "LFS Fix Exch Rate Amount"::Currency:
                    RelExchangeRateAmt :=
                      ((Factor * ExchangeRateAmt * "LFS Exch Rate Amount (Imp)") /
                       "LFS Rel Exch Rate Amt (Imp)");
                "LFS Fix Exch Rate Amount"::Both:
                    CASE "LFS Fix Exch Rate Amount" OF
                        "LFS Fix Exch Rate Amount"::"Relational Currency":
                            "LFS Exch Rate Amount (Imp)" :=
                              (RelExchangeRateAmt * "LFS Rel Exch Rate Amt (Imp)") /
                              (ExchangeRateAmt * Factor);
                        "LFS Fix Exch Rate Amount"::Currency:
                            "LFS Rel Exch Rate Amt (Imp)" :=
                              ((Factor * ExchangeRateAmt * "LFS Exch Rate Amount (Imp)") /
                               RelExchangeRateAmt);
                        "LFS Fix Exch Rate Amount"::Both:
                            begin
                                Amount := (Amount / ExchangeRateAmt) * RelExchangeRateAmt;
                                Amount := (Amount / "LFS Exch Rate Amount (Imp)") * "LFS Rel Exch Rate Amt (Imp)";
                                EXIT(Amount);
                            end;
                    end;
            end;
            Amount := (Amount / RelExchangeRateAmt) * ExchangeRateAmt;
            Amount := (Amount / "LFS Rel Exch Rate Amt (Imp)") * "LFS Exch Rate Amount (Imp)";
        end;
        EXIT(Amount);

    end;

    procedure ExchangeAmtFCYToLCYAdjmt(Date: Date; CurrencyCode: Code[10]; Amount: Decimal; Factor: Decimal): Decimal;
    begin
        UseAdjmtAmounts := true;
        EXIT(ExchangeAmtFCYToLCY(Date, CurrencyCode, Amount, Factor));
    end;

    procedure ExchangeAmtLCYToFCY(Date: Date; CurrencyCode: Code[10]; Amount: Decimal; Factor: Decimal): Decimal
    begin
        if CurrencyCode = '' then
            exit(Amount);
        FindCurrency(Date, CurrencyCode, 1);
        TestField("LFS Exch Rate Amount (Imp)");
        TestField("LFS Rel Exch Rate Amt (Imp)");
        if "LFS Rel Currency Code" = '' then
            if "LFS Fix Exch Rate Amount" = "LFS Fix Exch Rate Amount"::Both then
                Amount := (Amount / "LFS Rel Exch Rate Amt (Imp)") * "LFS Exch Rate Amount (Imp)"
            else
                Amount := Amount * Factor
        else begin
            RelExchangeRateAmt := "LFS Rel Exch Rate Amt (Exp)";
            ExchangeRateAmt := "LFS Exch Rate Amount (Imp)";
            RelCurrencyCode := "LFS Rel Currency Code";
            FixExchangeRateAmt := "LFS Fix Exch Rate Amount";
            FindCurrency(Date, RelCurrencyCode, 2);
            TestField("LFS Exch Rate Amount (Imp)");
            TestField("LFS Rel Exch Rate Amt (Imp)");
            case FixExchangeRateAmt of
                "LFS Fix Exch Rate Amount"::"Relational Currency":
                    ExchangeRateAmt := (Factor * RelExchangeRateAmt * "LFS Rel Exch Rate Amt (Imp)") / "LFS Exch Rate Amount (Imp)";
                "LFS Fix Exch Rate Amount"::Currency:
                    RelExchangeRateAmt :=
                      (ExchangeRateAmt * "LFS Exch Rate Amount (Imp)") / (Factor * "LFS Rel Exch Rate Amt (Imp)");
                "LFS Fix Exch Rate Amount"::Both:
                    CASE "LFS Fix Exch Rate Amount" OF
                        "LFS Fix Exch Rate Amount"::"Relational Currency":
                            "LFS Exch Rate Amount (Imp)" :=
                              (Factor * RelExchangeRateAmt * "LFS Rel Exch Rate Amt (Imp)") /
                              ExchangeRateAmt;
                        "LFS Fix Exch Rate Amount"::Currency:
                            "LFS Rel Exch Rate Amt (Imp)" :=
                              (ExchangeRateAmt * "LFS Exch Rate Amount (Imp)") /
                              (Factor * RelExchangeRateAmt);
                    end;
            end;
            Amount := (Amount / RelExchangeRateAmt) * ExchangeRateAmt;
            Amount := (Amount / "LFS Rel Exch Rate Amt (Imp)") * "LFS Exch Rate Amount (Imp)";
        end;
        exit(Amount);
    end;

    procedure ExchangeAmtLCYToFCYOnlyFactor(Amount: Decimal; Factor: Decimal): Decimal;
    begin
        Amount := Factor * Amount;
        exit(Amount);
    end;

    procedure ExchangeRate(Date: Date; CurrencyCode: Code[10]; EximType: Option Import,Export): Decimal;
    begin
        if CurrencyCode = '' then
            EXIT(1);
        FindCurrency(Date, CurrencyCode, 1);
        if EximType = EximType::Import then begin
            if NOT UseAdjmtAmounts then begin
                TESTFIELD("LFS Exch Rate Amount (Imp)");
                TESTFIELD("LFS Rel Exch Rate Amt (Imp)");
            end else begin
                TESTFIELD("LFS Adj Exch. Rate Amount");
                TESTFIELD("LFS Rel Adjmt Exch Rate Amt");
                "LFS Exch Rate Amount (Imp)" := "LFS Adj Exch. Rate Amount";
                "LFS Rel Exch Rate Amt (Imp)" := "LFS Rel Adjmt Exch Rate Amt";
            end;
            RelExchangeRateAmt := "LFS Rel Exch Rate Amt (Imp)";
            ExchangeRateAmt := "LFS Exch Rate Amount (Imp)";
            RelCurrencyCode := "LFS Rel Currency Code";
            if "LFS Rel Currency Code" = '' then
                CurrencyFactor := "LFS Exch Rate Amount (Imp)" / "LFS Rel Exch Rate Amt (Imp)"
            else begin
                FindCurrency(Date, RelCurrencyCode, 2);
                if NOT UseAdjmtAmounts then begin
                    TESTFIELD("LFS Exch Rate Amount (Imp)");
                    TESTFIELD("LFS Rel Exch Rate Amt (Imp)");
                end else begin
                    TESTFIELD("LFS Adj Exch. Rate Amount");
                    TESTFIELD("LFS Rel Adjmt Exch Rate Amt");
                    "LFS Exch Rate Amount (Imp)" := "LFS Adj Exch. Rate Amount";
                    "LFS Rel Exch Rate Amt (Imp)" := "LFS Rel Adjmt Exch Rate Amt";
                end;
                CurrencyFactor := (ExchangeRateAmt * "LFS Exch Rate Amount (Imp)") / (RelExchangeRateAmt * "LFS Rel Exch Rate Amt (Imp)");
            end;
        end else begin
            if NOT UseAdjmtAmounts then begin
                TESTFIELD("LFS Exch Rate Amount (Exp)");
                TESTFIELD("LFS Rel Exch Rate Amt (Exp)");
            end else begin
                TESTFIELD("LFS Adj Exch. Rate Amount");
                TESTFIELD("LFS Rel Adjmt Exch Rate Amt");
                "LFS Exch Rate Amount (Exp)" := "LFS Adj Exch. Rate Amount";
                "LFS Rel Exch Rate Amt (Exp)" := "LFS Rel Adjmt Exch Rate Amt";
            end;
            RelExchangeRateAmt := "LFS Rel Exch Rate Amt (Exp)";
            ExchangeRateAmt := "LFS Exch Rate Amount (Exp)";
            RelCurrencyCode := "LFS Rel Currency Code";
            if "LFS Rel Currency Code" = '' then
                CurrencyFactor := "LFS Exch Rate Amount (Exp)" / "LFS Rel Exch Rate Amt (Exp)"
            else begin
                FindCurrency(Date, RelCurrencyCode, 2);
                if NOT UseAdjmtAmounts then begin
                    TESTFIELD("LFS Exch Rate Amount (Exp)");
                    TESTFIELD("LFS Rel Exch Rate Amt (Exp)");
                end else begin
                    TESTFIELD("LFS Adj Exch. Rate Amount");
                    TESTFIELD("LFS Rel Adjmt Exch Rate Amt");
                    "LFS Exch Rate Amount (Exp)" := "LFS Adj Exch. Rate Amount";
                    "LFS Rel Exch Rate Amt (Exp)" := "LFS Rel Adjmt Exch Rate Amt";
                end;
                CurrencyFactor := (ExchangeRateAmt * "LFS Exch Rate Amount (Exp)") / (RelExchangeRateAmt * "LFS Rel Exch Rate Amt (Exp)");
            end;
        end;
        EXIT(CurrencyFactor);
    end;

    procedure FindCurrency(Date: Date; CurrencyCode: Code[10]; CacheNo: Integer);
    begin
        if (CurrencyCode2[CacheNo] = CurrencyCode) and (Date2[CacheNo] = Date) then
            Rec := CurrencyExchRate2[CacheNo]
        else begin
            if Date = 0D then
                Date := WorkDate();
            CurrencyExchRate2[CacheNo].SetRange("LFS Currency Code", CurrencyCode);
            CurrencyExchRate2[CacheNo].SetRange("LFS Starting Date", 0D, Date);
            CurrencyExchRate2[CacheNo].FindLast();
            Rec := CurrencyExchRate2[CacheNo];
            CurrencyCode2[CacheNo] := CurrencyCode;
            Date2[CacheNo] := Date;
        end;
    end;

    procedure GetCurrentCurrencyFactor(CurrencyCode: Code[10]): Decimal;
    begin
        SETRANGE("LFS Currency Code", CurrencyCode);
        if FindLast() then
            if "LFS Rel Exch Rate Amt (Imp)" <> 0 then
                EXIT("LFS Exch Rate Amount (Imp)" / "LFS Rel Exch Rate Amt (Imp)");
    end;


    procedure GetLastestExchangeRate(CurrencyCode: Code[10]; VAR Date: Date; VAR Amt: Decimal);
    begin
        Date := 0D;
        Amt := 0;
        SETRANGE("LFS Currency Code", CurrencyCode);
        if FindLast() then begin
            Date := "LFS Starting Date";
            if "LFS Exch Rate Amount (Imp)" <> 0 then
                Amt := "LFS Rel Exch Rate Amt (Imp)" / "LFS Exch Rate Amount (Imp)";
        end;
    end;


    procedure SetCurrentCurrencyFactor(CurrencyCode: Code[10]; CurrencyFactors: Decimal);

    VAR
        RateForTodayExists: Boolean;
    begin
        "LFS Currency Code" := CurrencyCode;
        TESTFIELD("LFS Currency Code");
        RateForTodayExists := GET(CurrencyCode, TODAY);
        "LFS Exch Rate Amount (Imp)" := 1;
        "LFS Rel Exch Rate Amt (Imp)" := 1 / CurrencyFactors;
        "LFS Adj Exch. Rate Amount" := "LFS Exch Rate Amount (Imp)";
        "LFS Rel Adjmt Exch Rate Amt" := "LFS Rel Exch Rate Amt (Imp)";
        if RateForTodayExists then begin
            "LFS Rel Currency Code" := '';
            MODIFY();
        end else begin
            "LFS Starting Date" := TODAY;
            Insert();
        end;
    end;

    LOCAL procedure FindApplnCurrency(Date: Date; CurrencyCode: Code[10]; Number: Integer): Boolean;
    begin
        CurrencyExchRate3[Number].SETRANGE("LFS Currency Code", CurrencyCode);
        CurrencyExchRate3[Number].SETRANGE("LFS Starting Date", 0D, Date);
        if NOT CurrencyExchRate3[Number].FindLast() then
            EXIT(FALSE);

        CurrencyExchRate3[Number].TESTFIELD("LFS Exch Rate Amount (Imp)");
        CurrencyExchRate3[Number].TESTFIELD("LFS Rel Exch Rate Amt (Imp)");
        EXIT(true);
    end;

    LOCAL procedure FindCurrency2(Date: Date; CurrencyCode: Code[10]; Number: Integer);
    begin
        if Date = 0D then
            Date := WORKDATE();
        CurrencyExchRate3[Number].SETRANGE("LFS Currency Code", CurrencyCode);
        CurrencyExchRate3[Number].SETRANGE("LFS Starting Date", 0D, Date);
        CurrencyExchRate3[Number].FINDLAST();
        CurrencyExchRate3[Number].TESTFIELD("LFS Exch Rate Amount (Imp)");
        CurrencyExchRate3[Number].TESTFIELD("LFS Rel Exch Rate Amt (Imp)");
    end;
}