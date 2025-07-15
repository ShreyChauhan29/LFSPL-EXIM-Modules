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
        field(72011; "LFS Currency Exch. Rate"; Decimal)
        {
            Caption = 'Currency Exch. Rate';
            DataClassification = CustomerContent;
            Editable = false;
        }
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
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                Item: Record Item;
            begin
                if (Rec."No." <> '') then begin
                    Clear(Rec."LFS Exim Group No.");
                    if Rec.Type = Rec.Type::Item then begin
                        Item.Get(Rec."No.");
                        Rec."LFS Exim Group No." := Item."LFS Exim Group No.";
                    end;
                end
                else
                    Rec."LFS Exim Group No." := '';
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
            Rec."LFS CIF Amount (FCY)" := Rec."Line Amount";
            if PurchHeader."Currency Factor" <> 0 then begin
                ExchRate := 1 / PurchHeader."Currency Factor";
                Rec."LFS Currency Exch. Rate" := ExchRate;
                rec."LFS CIF Amount (LCY)" := Rec."Line Amount" * ExchRate;
                Rec."LFS FOB Amount (LCY)" := Rec."Line Amount" * ExchRate;
                Rec."GST Assessable Value" := Rec."LFS GST Assesable Value INR" / ExchRate;
                Rec."Custom Duty Amount" := Rec."LFS Import Duties Amt. (LCY)" / ExchRate;
            end
            else
                if PurchHeader."Currency Factor" = 0 then begin
                    ExchRate := 1;
                    Rec."LFS Currency Exch. Rate" := ExchRate;
                    rec."LFS CIF Amount (LCY)" := Rec."Line Amount" * ExchRate;
                    Rec."LFS FOB Amount (LCY)" := Rec."Line Amount" * ExchRate;
                    Rec."GST Assessable Value" := Rec."LFS GST Assesable Value INR" / ExchRate;
                    Rec."Custom Duty Amount" := Rec."LFS Import Duties Amt. (LCY)" / ExchRate;
                end;
        end;
        if Rec.Quantity <> 0 then
            rec."LFS CIF Amount (FCY)" := rec."LFS CIF Amount (FCY)" / Rec.Quantity;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnValidateFOBValue(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line"; CurrentFieldNo: Integer);
    begin
    end;
}