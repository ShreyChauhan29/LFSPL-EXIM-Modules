namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.Document;
using Microsoft.Inventory.Item;

tableextension 72009 "LFS EXIM Purchase Line Ext." extends "Purchase Line"
{
    fields
    {
        field(72000; "LFS EXIM Type"; Enum "LFS EXIM Type")
        {
            Caption = 'EXIM Type';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(72001; "LFS License Type"; Enum "LFS License Type")
        {
            Caption = 'License Type';
            DataClassification = CustomerContent;
        }
        field(72002; "LFS License No."; Code[20])
        {
            Caption = 'License No.';
            DataClassification = CustomerContent;
            TableRelation = "LFS Rodtep License Header"."LFS No.";
        }
        field(72003; "LFS FOB Amount (FCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 5;
            Caption = 'FOB Amount (FCY)';
            trigger OnValidate()
            begin
                OnValidateFOBValue(Rec, xRec, CurrFieldNo);
            end;
        }
        field(72031; "LFS FOB Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 5;
            Caption = 'FOB Amount (LCY)';
        }
        field(72004; "LFS CIF Amount (FCY)"; Decimal)
        {
            Caption = 'CIF Amount (FCY) ';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 5;
        }
        field(72005; "LFS Freight Amount (FCY)"; Decimal)
        {
            Caption = 'Freight Amount (FCY)';
            DataClassification = CustomerContent;
        }
        field(72006; "LFS Insurance Amount (FCY)"; Decimal)
        {
            Caption = 'Insurance Amount (FCY)';
            DataClassification = CustomerContent;
        }
        field(72007; "LFS Import Duties Amt. (LCY)"; Decimal)
        {
            Caption = 'Custom Duties Amount (LCY)';
            DataClassification = CustomerContent;
        }
        // field(72010; "LFS EXIM Remark"; Text[250])
        // {
        //     Caption = 'EXIM Remark';
        //     DataClassification = CustomerContent;
        // }
        // field(72011; "LFS Currency Exch. Rate"; Decimal)
        // {
        //     Caption = 'Currency Exch. Rate';
        //     DataClassification = CustomerContent;
        //     Editable = false;
        // }
        field(72012; "LFS Custom Exch. Rate"; Decimal)
        {
            Caption = 'Custom Exch. Rate';
            DataClassification = CustomerContent;
            Editable = false;
        }
        // field(72013; "LFS EXIM Item Group"; Code[20])
        // {
        //     Caption = 'EXIM Item Group';
        //     DataClassification = CustomerContent;
        //     Editable = false;
        //     TableRelation = "LFS EXIM Item Group";
        // }
        // field(72014; "LFS BCD Amt. License Calc."; Decimal)
        // {
        //     Caption = 'BCD Amt. For License Calc.';
        //     DataClassification = CustomerContent;
        // }
        field(72015; "LFS GST Assesable Value INR"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'GST Assesable Value INR';
        }
        field(72016; "LFS Source No."; Code[20])
        {
            Caption = 'Source No.';
            DataClassification = CustomerContent;
        }
        field(72017; "LFS Source Line No."; Integer)
        {
            Caption = 'Source Line No.';
            DataClassification = CustomerContent;
        }
        field(72018; "LFS CIF Amount (LCY)"; Decimal)
        {
            Caption = 'CIF Amount (LCY)';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "LFS CIF Amount (LCY)" <> 0 then begin
                    Rec."LFS USD CIF (LCY)" := Rec."LFS CIF Amount (LCY)";
                    Rec."LFS USD CIF (FCY)" := Rec."LFS USD CIF (LCY)" / "LFS CIF Currency Exchange Rate";
                end;
            end;
        }
        // field(72019; "LFS CIF Amount (FCY)"; Decimal)
        // {
        //     Caption = 'CIF Amount (FCY)';
        //     DataClassification = CustomerContent;
        // }
        field(72020; "LFS RoDTEP Value (LCY)"; decimal)
        {
            Caption = 'RoDTEP Value (LCY)';
            DataClassification = CustomerContent;
        }
        field(72032; "LFS Exim Group No."; Code[20])
        {
            Caption = 'Exim Group No.';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "EXIM Group Master"."LFS Group No.";
        }
        field(72033; "LFS CIF Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'CIF Currency Code';
            Editable = false;
        }
        field(72034; "LFS CIF Currency Exchange Rate"; Decimal)
        {
            Caption = 'CIF Currency Exchange Rate';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                Rec."LFS USD CIF (LCY)" := Rec."LFS CIF Amount (LCY)";
                Rec."LFS USD CIF (FCY)" := Rec."LFS USD CIF (LCY)" / "LFS CIF Currency Exchange Rate";
            end;
        }
        field(72035; "LFS USD CIF (FCY)"; Decimal)
        {
            Caption = 'USD CIF (FCY)';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(72036; "LFS USD CIF (LCY)"; Decimal)
        {
            Caption = 'USD CIF (LCY)';
            DataClassification = CustomerContent;
            Editable = false;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                Item: Record Item;
                EXIMCurrExRate: Record "LFSEXIM Currency Exchange Rate";
                Exc_Rate: Decimal;
            begin
                if (Rec."No." <> '') then begin
                    Clear(Rec."LFS Exim Group No.");
                    if Rec.Type = Rec.Type::Item then begin
                        Item.Get(Rec."No.");
                        Rec."LFS Exim Group No." := Item."LFS Exim Group No.";
                    end;
                    Exc_Rate := 0;
                    Rec."LFS CIF Currency Code" := 'USD';
                    EXIMCurrExRate.Reset();
                    EXIMCurrExRate.SetRange("LFS Currency Code", Rec."LFS CIF Currency Code");
                    EXIMCurrExRate.SetAscending("LFS Starting Date", true);
                    if EXIMCurrExRate.FindLast() then begin
                        Exc_Rate := 1 / EXIMCurrExRate.ExchangeRate(EXIMCurrExRate."LFS Starting Date", Rec."LFS CIF Currency Code", 1);
                        Rec.Validate("LFS CIF Currency Exchange Rate", Exc_Rate);
                    end;
                end
                else begin
                    Rec."LFS Exim Group No." := '';
                    Rec."LFS CIF Currency Code" := '';
                end;
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                CIFvalue();
            end;
        }
        modify("Direct Unit Cost")
        {
            trigger OnAfterValidate()
            begin
                CIFvalue();
            end;
        }
        modify("Line Amount")
        {
            trigger OnAfterValidate()
            begin
                CIFvalue();
            end;
        }
    }

    trigger OnDelete()
    var
        ImportLicense: record "LFS EXIM Import License";
    begin
        ImportLicense.SetRange("LFS Source No.", Rec."Document No.");
        ImportLicense.SetRange("LFS Source line No.", Rec."Line No.");
        if ImportLicense.Findset() then
            ImportLicense.DeleteAll();
    end;

    procedure HasTypeToFillMandatotyFields(): Boolean
    begin
        exit(Type <> Type::" ");
    end;

    // local procedure CheckAdvLicenseQty()
    // var
    //     EXIMAdvLicenseIODetails: Record "LFS EXIM License IO Details";
    // begin
    //     if "LFS License No." = '' then
    //         EXIT;
    //     EXIMAdvLicenseIODetails.Reset();
    //     EXIMAdvLicenseIODetails.SETRANGE(EXIMAdvLicenseIODetails."LFS Adv. License No.", "LFS License No.");
    //     EXIMAdvLicenseIODetails.SETRANGE(EXIMAdvLicenseIODetails."LFS Item Type", "LFS EXIM Item Group");
    //     if EXIMAdvLicenseIODetails.FINDFIRST() then;
    //     EXIMAdvLicenseIODetails.CALCFIELDS(EXIMAdvLicenseIODetails."LFS Consumed Import Qty.");
    //     if Quantity + EXIMAdvLicenseIODetails."LFS Consumed Import Qty." > EXIMAdvLicenseIODetails."LFS Qty." then
    //         ERROR('Cannot Consume more than %1 units for Adv. License No. %2', EXIMAdvLicenseIODetails."LFS Qty.", "LFS License No.");
    // end;

    local procedure CIFvalue()
    var
        PurchHeader: Record "Purchase Header";
        ExchRate: Decimal;
    begin
        ExchRate := 0;
        PurchHeader.SetRange("Document Type", Rec."Document Type");
        PurchHeader.SetRange("No.", Rec."Document No.");
        if PurchHeader.FindFirst() then begin
            if Rec."Currency Code" = Rec."LFS CIF Currency Code" then
                Rec."LFS CIF Currency Exchange Rate" := Rec."LFS Custom Exch. Rate";
            Rec."LFS CIF Amount (FCY)" := Rec."Line Amount";
            if PurchHeader."Currency Factor" <> 0 then begin
                ExchRate := 1 / PurchHeader."Currency Factor";
                Rec."LFS Custom Exch. Rate" := ExchRate;
                rec.Validate("LFS CIF Amount (LCY)", Rec."Line Amount" * ExchRate);
                Rec."LFS FOB Amount (LCY)" := Rec."Line Amount" * ExchRate;
                Rec."GST Assessable Value" := Rec."LFS GST Assesable Value INR" / ExchRate;
                Rec."Custom Duty Amount" := Rec."LFS Import Duties Amt. (LCY)" / ExchRate;
            end
            else
                if PurchHeader."Currency Factor" = 0 then begin
                    ExchRate := 1;
                    Rec."LFS Custom Exch. Rate" := ExchRate;
                    rec.Validate("LFS CIF Amount (LCY)", Rec."Line Amount" * ExchRate);
                    Rec."LFS FOB Amount (LCY)" := Rec."Line Amount" * ExchRate;
                    Rec."GST Assessable Value" := Rec."LFS GST Assesable Value INR" / ExchRate;
                    Rec."Custom Duty Amount" := Rec."LFS Import Duties Amt. (LCY)" / ExchRate;
                end;
        end;
        // if Rec.Quantity <> 0 then
        //     rec."LFS CIF Amount (FCY)" := rec."LFS CIF Amount (FCY)" / Rec.Quantity;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnValidateFOBValue(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line"; CurrentFieldNo: Integer);
    begin
    end;
}