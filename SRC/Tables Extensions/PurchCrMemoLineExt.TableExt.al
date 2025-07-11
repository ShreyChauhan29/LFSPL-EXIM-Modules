namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.History;

tableextension 72011 "LFS Purch. Cr. Memo Line Ext." extends "Purch. Cr. Memo Line"
{
    fields
    {
        field(72000; "LFS EXIM Type"; Enum "LFS EXIM Type")
        {
            Caption = 'EXIM Type';
            DataClassification = CustomerContent;

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
            TableRelation = if ("LFS License Type" = const("Adv. License")) "LFS EXIM License Header";
        }
        field(72003; "LFS FOB Amount (FCY)"; Decimal)
        {
            Caption = 'FOB Amount (FCY)';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 5;
        }
        field(72004; "LFS CIF Amount (FCY)"; Decimal)
        {
            Caption = 'CIF Amount (FCY)';
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
            Caption = 'Import Duties Amount (LCY)';
            DataClassification = CustomerContent;
        }
        field(72010; "LFS EXIM Remark"; Text[250])
        {
            Caption = 'EXIM Remark';
            DataClassification = CustomerContent;
        }
        field(72011; "LFS Currency Exch. Rate"; Decimal)
        {
            Caption = 'Currency Exch. Rate';
            DataClassification = CustomerContent;
        }
        field(72012; "LFS Custom Exch. Rate"; Decimal)
        {
            Caption = 'Custom Exch. Rate';
            DataClassification = CustomerContent;
        }
        field(72013; "LFS EXIM Item Group"; Code[20])
        {
            Caption = 'EXIM Item Group';
            DataClassification = CustomerContent;
            TableRelation = "LFS EXIM Item Group";
        }
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
        //     Caption = 'CIF (FC)';
        //     DataClassification = CustomerContent;
        // }
        field(72020; "LFS RoDTEP Value (LCY)"; decimal)
        {
            Caption = 'RoDTEP Value (LCY)';
            DataClassification = CustomerContent;
        }
        field(72031; "LFS FOB Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 5;
            Caption = 'FOB Amount (LCY)';
        }
    }
}