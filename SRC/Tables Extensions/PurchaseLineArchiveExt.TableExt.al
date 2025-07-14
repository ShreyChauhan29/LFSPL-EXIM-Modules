namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.Archive;

tableextension 72035 "LFS Purchase Line Archive Ext" extends "Purchase Line Archive"
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
        field(72013; "LFS EXIM Item Group"; Code[20])
        {
            Caption = 'EXIM Item Group';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "LFS EXIM Item Group";
        }
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
        field(72020; "LFS RoDTEP Value (LCY)"; decimal)
        {
            Caption = 'RoDTEP Value (LCY)';
            DataClassification = CustomerContent;
        }
    }
}
