namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.Document;
using Microsoft.Foundation.NoSeries;
using Microsoft.Purchases.Setup;
using Microsoft.Foundation.Address;
using Microsoft.Purchases.Vendor;

tableextension 72008 "LFS EXIM Purchase Header Ext." extends "Purchase Header"
{
    fields
    {
        modify("Buy-from Vendor No.")
        {
            TableRelation = if ("LFS EXIM Type" = const(Import)) Vendor."No." where("GST Vendor Type" = filter("GST Vendor Type"::Import));
        }
        field(72000; "LFS EXIM Type"; Enum "LFS EXIM Type")
        {
            Caption = 'EXIM Type';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(72001; "LFS Port of Loading"; Code[20])
        {
            Caption = 'Port of Loading';
            DataClassification = CustomerContent;
            TableRelation = "LFS EXIM Port";
        }
        field(72002; "LFS Port of Discharge"; Code[20])
        {
            Caption = 'Port of Discharge';
            DataClassification = CustomerContent;
            TableRelation = "LFS EXIM Port";
        }
        field(72003; "LFS Country of Final Dest."; Code[20])
        {
            Caption = 'Country of Final Destination';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region".Code;
        }
        field(72004; "LFS Final Destination"; Code[20])
        {
            Caption = 'Final Destination';
            DataClassification = CustomerContent;
        }
        field(72005; "LFS Country Origin Goods"; Code[20])
        {
            Caption = 'Country of Origin of Goods';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region".Code;
        }
        field(72006; "LFS Inco Terms"; Code[20])
        {
            Caption = 'Inco Terms';
            DataClassification = CustomerContent;
            TableRelation = "LFS EXIM Inco Terms";
        }
        field(72007; "LFS Custom Currency Code"; Code[10])
        {
            Caption = 'Custom Currency Code';
            DataClassification = CustomerContent;
            TableRelation = "LFSEXIM Currency Exchange Rate";
        }
        field(72008; "LFS Custom Currency Factor"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
            trigger OnValidate()
            begin
                Validate("Currency Factor", "LFS Custom Currency Factor");
            end;
        }
        // field(72009; "LFS Exchange Rate for INR"; Decimal)
        // {
        //     Caption = 'Exchange Rate for INR';
        //     DataClassification = CustomerContent;
        // }
        field(72010; "LFS FOB Amount (FCY)"; Decimal)
        {
            // DataClassification = CustomerContent;
            Editable = false;
            Caption = 'FOB Amount (FCY)';
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line"."LFS FOB Amount (FCY)" where("Document No." = field("No.")));
        }
        field(72011; "LFS FOB Amount (LCY)"; Decimal)
        {
            // DataClassification = CustomerContent;
            Editable = false;
            Caption = 'FOB Amount (LCY)';
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line"."LFS FOB Amount (LCY)" where("Document No." = field("No.")));
        }
        field(72012; "LFS CIF Amount (FCY)"; Decimal)
        {
            Editable = false;
            Caption = 'CIF Amount (FCY)';
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line"."LFS CIF Amount (FCY)" where("Document No." = field("No.")));
        }
        field(72013; "LFS CIF Amount (LCY)"; Decimal)
        {
            // DataClassification = CustomerContent;
            Caption = 'CIF Amount (LCY)';
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line"."LFS CIF Amount (LCY)" where("Document No." = field("No.")));
        }
        field(72014; "LFS Challan No."; Code[20])
        {
            Caption = 'Challan No.';
            DataClassification = CustomerContent;
        }
        field(72015; "LFS Challan Date"; Date)
        {
            Caption = 'Challan Date';
            DataClassification = CustomerContent;
        }
        field(72016; "LFS Invoice No."; Code[20])
        {
            Caption = 'Invoice No.';
            DataClassification = CustomerContent;
        }
        field(72017; "LFS Driver Name"; Text[100])
        {
            Caption = 'Destination';
            DataClassification = CustomerContent;
        }
        field(72018; "LFS Driver License No."; Code[30])
        {
            Caption = 'Freight';
            DataClassification = CustomerContent;
        }
    }

    var
        EximSetup: Record "LFS EXIM Setup";
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit "No. Series";


    procedure AssistEditImport(OldPurchHeader: Record "Purchase Header"): Boolean
    begin
        if "LFS EXIM Type" = "LFS EXIM Type"::" " then begin
            PurchSetup.GET();
            TestNoSeries();
            if NoSeriesMgt.LookupRelatedNoSeries(GetNoSeriesCode(), OldPurchHeader."No. Series", Rec."No. Series") then begin
                PurchSetup.GET();
                TestNoSeries();
                // NoSeriesMgt.SetSeries("No.");
                NoSeriesMgt.GetNextNo(Rec."No. Series", WorkDate());
                EXIT(true);
            end;
        end else begin
            EximSetup.Get();
            TestEximNoSeries();
            if NoSeriesMgt.LookupRelatedNoSeries(GetEximNoSeriesCode(), OldPurchHeader."No. Series", Rec."No. Series") then begin
                // NoSeriesMgt.SetSeries("No.");
                // NoSeriesMgt.GetNextNo(Rec."No. Series", WorkDate());
                Rec."No." := NoSeriesMgt.GetNextNo(Rec."No. Series", WorkDate());
                // NoSeriesMgt.PeekNextNo(Rec."No. Series", WorkDate());
                EXIT(true);
            end;
        end;
    end;

    procedure GetEximNoSeriesCode(): Code[10]
    begin
        EximSetup.Get();
        CASE "Document Type" OF
            "Document Type"::Order:
                EXIT(EximSetup."LFS Import Order Nos.");
            "Document Type"::Invoice:
                EXIT(EximSetup."LFS Import Invoice Nos.");
            "Document Type"::"Blanket Order":
                EXIT(EximSetup."LFS Blanket Imp Order No.");
            "Document Type"::"Credit Memo":
                EXIT(EximSetup."LFS Import Purchase CreditNos");
        end;
    end;

    procedure TestEximNoSeries(): Boolean
    begin
        EximSetup.GET();
        CASE "Document Type" OF
            "Document Type"::Quote:
                ERROR('Exim Quote not allowed');
            "Document Type"::Order:
                EximSetup.TESTFIELD("LFS Import Order Nos.");
            "Document Type"::Invoice:
                begin
                    EximSetup.TESTFIELD("LFS Import Invoice Nos.");
                    EximSetup.TESTFIELD("LFS Posted Imp Invoice Nos.");
                end;
            "Document Type"::"Return Order":
                ERROR('Exim Return Order not allowed');
            "Document Type"::"Credit Memo":
                begin
                    EximSetup.TestField("LFS Pstd Import PurchCrMemoNos");
                    EximSetup.TestField("LFS Import Purchase CreditNos");
                end;
            "Document Type"::"Blanket Order":
                EximSetup.TESTFIELD("LFS Blanket Imp Order No.");
        end;
    end;
}