namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Finance.GeneralLedger.Setup;

page 72088 "LFSChange Custom Exchange Rate"
{
    ApplicationArea = All;
    Caption = 'Change Custom Exchange Rate';
    PageType = StandardDialog;
    DataCaptionExpression = DynamicDataCaption;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(CurrencyCode; CurrencyCode)
                {
                    ApplicationArea = all;
                    Caption = 'Currency Code';
                    Editable = CurrencyCodeEditable;
                    ToolTip = 'Specifies the Currency Code';
                }
                field(CurrentExchRate; CurrentExchRate)
                {
                    ApplicationArea = all;
                    Caption = 'Exchange Rate Amount';
                    Editable = CurrentExchRateEditable;
                    DecimalPlaces = 1 : 6;
                    ToolTip = 'Specifies the Exchange Rate Amount';
                    trigger OnValidate()
                    begin
                        if CurrentExchRate <= 0 then
                            ERROR(Text000Lbl);
                        if RefCurrencyCode = '' then
                            CurrencyFactor := CurrentExchRate / RefExchRate
                        else
                            CurrencyFactor := (CurrentExchRate * CurrentExchRate2) / (RefExchRate * RefExchRate2);
                    end;
                }
                field(RefExchRate; RefExchRate)
                {
                    ApplicationArea = all;
                    Caption = 'Relational Exch. Rate Amount';
                    ToolTip = 'Specifies the Relational Exch. Rate Amount';
                    Editable = RefExchRateEditable;
                    DecimalPlaces = 1 : 6;
                    trigger OnValidate()
                    begin
                        if RefExchRate <= 0 then
                            ERROR(Text000Lbl);
                        if RefCurrencyCode = '' then
                            CurrencyFactor := CurrentExchRate / RefExchRate
                        else
                            CurrencyFactor := (CurrentExchRate * CurrentExchRate2) / (RefExchRate * RefExchRate2);
                    end;
                }
                field(RefCurrencyCode; ShowCurrencyCode(RefCurrencyCode, true))
                {
                    ApplicationArea = all;
                    Caption = 'Relational Currency Code';
                    ToolTip = 'Specifies the Relational Currency Code';
                    Editable = RefCurrencyCodeEditable;
                }
                field(CurrencyCode2; CurrencyCode2)
                {
                    ApplicationArea = all;
                    Caption = 'Currency Code';
                    ToolTip = 'Specifies the Currency Code';
                    Editable = CurrencyCode2Editable;
                }
                field(CurrentExchRate2; CurrentExchRate2)
                {
                    ApplicationArea = all;
                    Editable = CurrentExchRate2Editable;
                    Caption = 'Exchange Rate Amount';
                    ToolTip = 'Specifies the Exchange Rate Amount';
                    DecimalPlaces = 1 : 6;
                    trigger OnValidate()
                    begin
                        if RefExchRate2 <= 0 then
                            ERROR(Text000Lbl);
                        CurrencyFactor := (CurrentExchRate * CurrentExchRate2) / (RefExchRate * RefExchRate2);
                    end;
                }
                field(RefExchRate2; RefExchRate2)
                {
                    ApplicationArea = all;
                    Caption = 'Relational Exch. Rate Amount';
                    ToolTip = 'Specifies the Relational Exch. Rate Amount';
                    Editable = RefExchRate2Editable;
                    DecimalPlaces = 1 : 6;
                }
                field(RefCurrencyCode2; ShowCurrencyCode(RefCurrencyCode2, RefCurrencyCode <> ''))
                {
                    ApplicationArea = all;
                    Caption = 'Relational Currency Code';
                    ToolTip = 'Specifies the Relational Currency Code';
                    Editable = RefCurrencyCode2Editable;
                }
                field(UseExchRate; UseExchRate)
                {
                    ApplicationArea = all;
                    Caption = 'Use FA Add.-Curr Exch. Rate';
                    ToolTip = 'Specifies the Use FA Add.-Curr Exch. Rate';
                    Editable = UseExchRateEditable;
                    Visible = true;
                    MultiLine = true;
                    trigger OnValidate()
                    begin
                        if UseExchRate then begin
                            CurrencyCode3 := CurrencyCode4;
                            CurrencyFactor := CurrExchRate.ExchangeRate(Date2, CurrencyCode3, EximType);
                            InitForm();
                        end else begin
                            CurrencyCode := '';
                            CurrentExchRate := 0;
                            RefExchRate := 0;
                            RefCurrencyCode := '';
                            CurrencyCode2 := '';
                            CurrentExchRate2 := 0;
                            RefExchRate2 := 0;
                            RefCurrencyCode2 := '';
                            CurrentExchRateEditable := FALSE;
                            RefExchRateEditable := FALSE;
                            CurrentExchRate2Editable := FALSE;
                            RefExchRate2Editable := FALSE
                        end;
                    end;
                }
            }
        }
    }
    var
        CurrExchRate: Record "LFSEXIM Currency Exchange Rate";
        GLSetup: Record "General Ledger Setup";
        CurrencyCode: Code[10];
        CurrencyCode2: Code[10];
        CurrentExchRate: Decimal;
        CurrentExchRate2: Decimal;
        RefExchRate: Decimal;
        RefExchRate2: Decimal;
        RefCurrencyCode: Code[10];
        RefCurrencyCode2: Code[10];
        CurrencyCode3: Code[10];
        CurrencyFactor: Decimal;
        Fix: Option;
        Fix2: Option;
        UseExchRate: Boolean;
        CurrencyCode4: Code[10];
        DynamicDataCaption: Text[50];
        Date2: Date;
        Date3: Date;
        FAUsed: Boolean;
        CurrentExchRateEditable: Boolean;
        RefExchRateEditable: Boolean;
        CurrentExchRate2Editable: Boolean;
        RefExchRate2Editable: Boolean;
        UseExchRateEditable: Boolean;
        CurrencyCodeEditable: Boolean;
        RefCurrencyCodeEditable: Boolean;
        CurrencyCode2Editable: Boolean;
        RefCurrencyCode2Editable: Boolean;
        EximType: Option " ",Import,Export;
        Text000Lbl: Label 'The value must be greater than 0.';
#pragma warning disable AA0470
        Text001Lbl: Label 'The %1 field is not set up properly in the Currency Exchange Rates window. For %2 or the currency set up in the %3 field, the %1 field should be set to both.';
#pragma warning restore AA0470

    trigger OnInit()
    begin
        RefExchRate2Editable := true;
        CurrentExchRate2Editable := true;
        RefExchRateEditable := true;
        CurrentExchRateEditable := true;
        GLSetup.GET();
    end;

    trigger OnOpenPage()
    begin
        InitForm();
    end;

    procedure SetParameter(NewCurrencyCode: Code[10]; NewFactor: Decimal; Date: Date; EType: Enum "LFS EXIM Type")
    begin
        CurrencyCode3 := NewCurrencyCode;
        CurrencyFactor := NewFactor;
        Date3 := Date;
        UseExchRate := FALSE;
        FAUsed := FALSE;
        EximType := EType;
    end;

    procedure GetParameter(): Decimal
    begin
        if UseExchRate OR NOT FAUsed then
            EXIT(CurrencyFactor);

        exit(0);
    end;

    procedure SetParameterFA(NewFactor: Decimal; CurrencyCode5: Code[10]; Date: Date)
    begin
        if NewFactor = 0 then begin
            CurrencyFactor := 1;
            UseExchRate := FALSE;
        end else begin
            CurrencyFactor := NewFactor;
            UseExchRate := true;
            CurrencyCode3 := CurrencyCode5;
        end;
        UseExchRateEditable := true;
        FAUsed := true;
        CurrencyCode4 := CurrencyCode5;
        Date2 := Date;
        Date3 := Date;
    end;

    procedure SetCaption(DataCaption: Text[50])
    begin
        DynamicDataCaption := DataCaption;
    end;

    procedure InitForm()
    begin
        if CurrencyCode3 = '' then begin
            CurrencyCodeEditable := FALSE;
            CurrentExchRateEditable := FALSE;
            RefExchRateEditable := FALSE;
            RefCurrencyCodeEditable := FALSE;
            CurrencyCode2Editable := FALSE;
            CurrentExchRate2Editable := FALSE;
            RefExchRate2Editable := FALSE;
            RefCurrencyCode2Editable := FALSE;
            EXIT;
        end;

        CurrExchRate.SETRANGE(CurrExchRate."LFS Currency Code", CurrencyCode3);
        CurrExchRate.SETRANGE(CurrExchRate."LFS Starting Date", 0D, Date3);
        CurrExchRate.FINDLAST();
        CurrencyCode := CurrExchRate."LFS Currency Code";
        if EximType = EximType::Import then begin
            CurrentExchRate := CurrExchRate."LFS Exch Rate Amount (Imp)";
            RefExchRate := CurrExchRate."LFS Rel Exch Rate Amt (Imp)";
        end else begin
            CurrentExchRate := CurrExchRate."LFS Exch Rate Amount (Exp)";
            RefExchRate := CurrExchRate."LFS Rel Exch Rate Amt (Exp)";
        end;
        RefCurrencyCode := CurrExchRate."LFS Rel Currency Code";
        Fix := CurrExchRate."LFS Fix Exch Rate Amount";
        CurrExchRate.SETRANGE(CurrExchRate."LFS Currency Code", RefCurrencyCode);
        CurrExchRate.SETRANGE(CurrExchRate."LFS Starting Date", 0D, Date3);

        if CurrExchRate.FindLast() then begin
            CurrencyCode2 := CurrExchRate."LFS Currency Code";
            if EximType = EximType::Import then begin
                CurrentExchRate2 := CurrExchRate."LFS Exch Rate Amount (Imp)";
                RefExchRate2 := CurrExchRate."LFS Rel Exch Rate Amt (Imp)";
            end else begin
                CurrentExchRate2 := CurrExchRate."LFS Exch Rate Amount (Exp)";
                RefExchRate2 := CurrExchRate."LFS Rel Exch Rate Amt (Exp)";
            end;
            RefCurrencyCode2 := CurrExchRate."LFS Rel Currency Code";
            Fix2 := CurrExchRate."LFS Fix Exch Rate Amount";
        end;


        CASE Fix OF
            CurrExchRate."LFS Fix Exch Rate Amount"::Currency:
                begin
                    CurrentExchRateEditable := FALSE;
                    RefExchRateEditable := true;
                    if RefCurrencyCode = '' then
                        RefExchRate := CurrentExchRate / CurrencyFactor
                    else
                        RefExchRate := (CurrentExchRate * CurrentExchRate2) / (CurrencyFactor * RefExchRate2);
                end;
            CurrExchRate."LFS Fix Exch Rate Amount"::"Relational Currency":
                begin
                    CurrentExchRateEditable := true;
                    RefExchRateEditable := FALSE;
                    if RefCurrencyCode = '' then
                        CurrentExchRate := CurrencyFactor * RefExchRate
                    else
                        CurrentExchRate := (RefExchRate * RefExchRate2 * CurrencyFactor) / CurrentExchRate2;
                end;
            CurrExchRate."LFS Fix Exch Rate Amount"::Both:
                begin
                    CurrentExchRateEditable := FALSE;
                    RefExchRateEditable := FALSE;
                end;
        end;

        if RefCurrencyCode <> '' then begin
            if (Fix <> CurrExchRate."LFS Fix Exch Rate Amount"::Both) AND (Fix2 <> CurrExchRate."LFS Fix Exch Rate Amount"::Both) then
                ERROR(Text001Lbl, CurrExchRate.FIELDCAPTION(CurrExchRate."LFS Fix Exch Rate Amount"), CurrencyCode, CurrExchRate.FIELDCAPTION(CurrExchRate."LFS Rel Currency Code"));
            CASE Fix2 OF
                CurrExchRate."LFS Fix Exch Rate Amount"::Currency:
                    begin
                        CurrentExchRate2Editable := FALSE;
                        RefExchRate2Editable := true;
                        RefExchRate2 := (CurrentExchRate * CurrentExchRate2) / (CurrencyFactor * RefExchRate);
                    end;
                CurrExchRate."LFS Fix Exch Rate Amount"::"Relational Currency":
                    begin
                        CurrentExchRate2Editable := true;
                        RefExchRate2Editable := FALSE;
                        CurrentExchRate2 := (CurrencyFactor * RefExchRate * RefExchRate2) / CurrentExchRate;
                    end;
                CurrExchRate."LFS Fix Exch Rate Amount"::Both:
                    begin
                        CurrentExchRate2Editable := FALSE;
                        RefExchRate2Editable := FALSE;
                    end;
            end;
        end else begin
            CurrencyCode2Editable := FALSE;
            CurrentExchRate2Editable := FALSE;
            RefExchRate2Editable := FALSE;
            RefCurrencyCode2Editable := FALSE;
            if CurrencyCode = '' then begin
                CurrencyCodeEditable := FALSE;
                CurrentExchRateEditable := FALSE;
                RefExchRateEditable := FALSE;
                RefCurrencyCodeEditable := FALSE;
            end;
        end;

    end;

    local procedure ShowCurrencyCode(ShowCurrency: Code[10]; DoShow: Boolean): Code[10]
    begin
        if NOT DoShow then
            EXIT('');
        if ShowCurrency = '' then
            EXIT(GLSetup."LCY Code");

        EXIT(ShowCurrency);
    end;

    procedure InitForm_UpdateCurr(PostDate: Date; CurrCode: Code[10]; CurrFActor: Decimal; EType: Option Import,Export): Decimal
    begin
        CurrencyCode3 := CurrCode;
        CurrencyFactor := CurrFActor;
        Date3 := PostDate;
        EximType := EType;
        if CurrencyCode3 = '' then begin
            CurrencyCodeEditable := FALSE;
            CurrentExchRateEditable := FALSE;
            RefExchRateEditable := FALSE;
            RefCurrencyCodeEditable := FALSE;
            CurrencyCode2Editable := FALSE;
            CurrentExchRate2Editable := FALSE;
            RefExchRate2Editable := FALSE;
            RefCurrencyCode2Editable := FALSE;
            EXIT;
        end;
        CurrExchRate.SETRANGE(CurrExchRate."LFS Currency Code", CurrencyCode3);
        CurrExchRate.SETRANGE(CurrExchRate."LFS Starting Date", 0D, Date3);
        CurrExchRate.FINDLAST();
        CurrencyCode := CurrExchRate."LFS Currency Code";
        if EximType = EximType::Import then begin
            CurrentExchRate := CurrExchRate."LFS Exch Rate Amount (Imp)";
            RefExchRate := CurrExchRate."LFS Rel Exch Rate Amt (Imp)";
        end else begin
            CurrentExchRate := CurrExchRate."LFS Exch Rate Amount (Exp)";
            RefExchRate := CurrExchRate."LFS Rel Exch Rate Amt (Exp)";
        end;
        RefCurrencyCode := CurrExchRate."LFS Rel Currency Code";
        Fix := CurrExchRate."LFS Fix Exch Rate Amount";
        CurrExchRate.SETRANGE(CurrExchRate."LFS Currency Code", RefCurrencyCode);
        CurrExchRate.SETRANGE(CurrExchRate."LFS Starting Date", 0D, Date3);
        if CurrExchRate.FindLast() then begin
            CurrencyCode2 := CurrExchRate."LFS Currency Code";
            if EximType = EximType::Import then begin
                CurrentExchRate2 := CurrExchRate."LFS Exch Rate Amount (Imp)";
                RefExchRate2 := CurrExchRate."LFS Rel Exch Rate Amt (Imp)";
            end else begin
                CurrentExchRate2 := CurrExchRate."LFS Exch Rate Amount (Exp)";
                RefExchRate2 := CurrExchRate."LFS Rel Exch Rate Amt (Exp)";
            end;
            RefCurrencyCode2 := CurrExchRate."LFS Rel Currency Code";
            Fix2 := CurrExchRate."LFS Fix Exch Rate Amount";
        end;

        CASE Fix OF
            CurrExchRate."LFS Fix Exch Rate Amount"::Currency:
                begin
                    CurrentExchRateEditable := FALSE;
                    RefExchRateEditable := true;
                    if RefCurrencyCode = '' then
                        RefExchRate := CurrentExchRate / CurrencyFactor
                    else
                        RefExchRate := (CurrentExchRate * CurrentExchRate2) / (CurrencyFactor * RefExchRate2);
                end;
            CurrExchRate."LFS Fix Exch Rate Amount"::"Relational Currency":
                begin
                    CurrentExchRateEditable := true;
                    RefExchRateEditable := FALSE;
                    if RefCurrencyCode = '' then
                        CurrentExchRate := CurrencyFactor * RefExchRate
                    else
                        CurrentExchRate := (RefExchRate * RefExchRate2 * CurrencyFactor) / CurrentExchRate2;
                end;
            CurrExchRate."LFS Fix Exch Rate Amount"::Both:
                begin
                    CurrentExchRateEditable := FALSE;
                    RefExchRateEditable := FALSE;
                end;
        end;

        if RefCurrencyCode <> '' then begin
            if (Fix <> CurrExchRate."LFS Fix Exch Rate Amount"::Both) AND (Fix2 <> CurrExchRate."LFS Fix Exch Rate Amount"::Both) then
                ERROR(Text001Lbl, CurrExchRate.FIELDCAPTION(CurrExchRate."LFS Fix Exch Rate Amount"), CurrencyCode, CurrExchRate.FIELDCAPTION(CurrExchRate."LFS Rel Currency Code"));
            CASE Fix2 OF
                CurrExchRate."LFS Fix Exch Rate Amount"::Currency:
                    begin
                        CurrentExchRate2Editable := FALSE;
                        RefExchRate2Editable := true;
                        RefExchRate2 := (CurrentExchRate * CurrentExchRate2) / (CurrencyFactor * RefExchRate);
                    end;
                CurrExchRate."LFS Fix Exch Rate Amount"::"Relational Currency":
                    begin
                        CurrentExchRate2Editable := true;
                        RefExchRate2Editable := FALSE;
                        CurrentExchRate2 := (CurrencyFactor * RefExchRate * RefExchRate2) / CurrentExchRate;
                    end;
                CurrExchRate."LFS Fix Exch Rate Amount"::Both:
                    begin
                        CurrentExchRate2Editable := FALSE;
                        RefExchRate2Editable := FALSE;
                    end;
            end;
        end else begin
            CurrencyCode2Editable := FALSE;
            CurrentExchRate2Editable := FALSE;
            RefExchRate2Editable := FALSE;
            RefCurrencyCode2Editable := FALSE;
            if CurrencyCode = '' then begin
                CurrencyCodeEditable := FALSE;
                CurrentExchRateEditable := FALSE;
                RefExchRateEditable := FALSE;
                RefCurrencyCodeEditable := FALSE;
            end;
        end;

        EXIT(RefExchRate);
    end;
}