namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Finance.GeneralLedger.Setup;

codeunit 72000 "LFS Amount In Words"
{
    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var
        GLSetup: Record "General Ledger Setup";
        PrintExponent: Boolean;
        DecimalPart: Decimal;
        DecimalInt: Integer;
        Exponent: Integer;
        Hundreds: Integer;
        NoTextIndex: Integer;
        Ones: Integer;
        OnesDec: Integer;
        Tens: Integer;
        TensDec: Integer;
    // DecimalPosition: Decimal;
    begin
        Clear(NoText);
        NoTextIndex := 1;
        // NoText[1] := '****';
        GLSetup.Get();

        if No < 1 then
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text026Lbl)
        else
            for Exponent := 4 downto 1 do begin
                PrintExponent := false;
                Ones := No div Power(1000, Exponent - 1);
                No := No mod Power(1000, Exponent - 1); // Reduce No here

                Hundreds := Ones div 100;
                Tens := (Ones mod 100) div 10;
                Ones := Ones mod 10;

                if Hundreds > 0 then begin
                    if Hundreds in [1 .. 9] then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text027Lbl); // "Hundred"
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
            end;

        if No <> 0 then
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text028Lbl);
        DecimalPart := ROUND(No * 100, 1, '=');
        DecimalInt := ROUND(DecimalPart, 1, '=');
        TensDec := DecimalInt DIV 10;
        OnesDec := DecimalInt MOD 10;

        if TensDec >= 2 then begin
            AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[TensDec]);
            if OnesDec > 0 then
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[OnesDec]);
        end else
            if (TensDec * 10 + OnesDec) > 0 then
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[TensDec * 10 + OnesDec]);
        if No > 0 then begin
            if (CurrencyCode <> '') then
                AddToNoText(NoText, NoTextIndex, PrintExponent, 'ONLY')
        end
        else
            if CurrencyCode <> '' then
                AddToNoText(NoText, NoTextIndex, PrintExponent, 'ONLY');

        // OnAfterFormatNoText(NoText, No, CurrencyCode);
    end;

    local procedure AddToNoText(var NoText: array[2] of Text; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent := true;

        while StrLen(NoText[NoTextIndex] + ' ' + AddText) > MaxStrLen(NoText[1]) do begin
            NoTextIndex := NoTextIndex + 1;
            if NoTextIndex > ArrayLen(NoText) then
                Error(Text029Lbl, AddText);
        end;

        NoText[NoTextIndex] := DelChr(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    procedure InitTextVariable()
    begin
        OnesText[1] := Text032Lbl;
        OnesText[2] := Text033Lbl;
        OnesText[3] := Text034Lbl;
        OnesText[4] := Text035Lbl;
        OnesText[5] := Text036Lbl;
        OnesText[6] := Text037Lbl;
        OnesText[7] := Text038Lbl;
        OnesText[8] := Text039Lbl;
        OnesText[9] := Text040Lbl;
        OnesText[10] := Text041Lbl;
        OnesText[11] := Text042Lbl;
        OnesText[12] := Text043Lbl;
        OnesText[13] := Text044Lbl;
        OnesText[14] := Text045Lbl;
        OnesText[15] := Text046Lbl;
        OnesText[16] := Text047Lbl;
        OnesText[17] := Text048Lbl;
        OnesText[18] := Text049Lbl;
        OnesText[19] := Text050Lbl;

        TensText[1] := '';
        TensText[2] := Text051Lbl;
        TensText[3] := Text052Lbl;
        TensText[4] := Text053Lbl;
        TensText[5] := Text054Lbl;
        TensText[6] := Text055Lbl;
        TensText[7] := Text056Lbl;
        TensText[8] := Text057Lbl;
        TensText[9] := Text058Lbl;

        ExponentText[1] := '';
        ExponentText[2] := Text059Lbl;
        ExponentText[3] := Text060Lbl;
        ExponentText[4] := Text061Lbl;
    end;

    var
        TensText: array[10] of Text[30];
        OnesText: array[20] of Text[30];
        ExponentText: array[5] of Text[30];
        Text032Lbl: Label 'ONE';
        Text033Lbl: Label 'TWO';
        Text034Lbl: Label 'THREE';
        Text035Lbl: Label 'FOUR';
        Text036Lbl: Label 'FIVE';
        Text037Lbl: Label 'SIX';
        Text038Lbl: Label 'SEVEN';
        Text039Lbl: Label 'EIGHT';
        Text040Lbl: Label 'NINE';
        Text041Lbl: Label 'TEN';
        Text042Lbl: Label 'ELEVEN';
        Text043Lbl: Label 'TWELVE';
        Text044Lbl: Label 'THIRTEEN';
        Text045Lbl: Label 'FOURTEEN';
        Text046Lbl: Label 'FIFTEEN';
        Text047Lbl: Label 'SIXTEEN';
        Text048Lbl: Label 'SEVENTEEN';
        Text049Lbl: Label 'EIGHTEEN';
        Text050Lbl: Label 'NINETEEN';
        Text051Lbl: Label 'TWENTY';
        Text052Lbl: Label 'THIRTY';
        Text053Lbl: Label 'FORTY';
        Text054Lbl: Label 'FIFTY';
        Text055Lbl: Label 'SIXTY';
        Text056Lbl: Label 'SEVENTY';
        Text057Lbl: Label 'EIGHTY';
        Text058Lbl: Label 'NINETY';
        Text059Lbl: Label 'THOUSAND';
        Text060Lbl: Label 'MILLION';
        Text061Lbl: Label 'BILLION';
        Text026Lbl: Label 'ZERO';
        Text027Lbl: Label 'HUNDRED';
        Text028Lbl: Label 'AND';
#pragma warning disable AA0470
        Text029Lbl: Label '%1 results in a written number that is too long.';
#pragma warning restore AA0470
}