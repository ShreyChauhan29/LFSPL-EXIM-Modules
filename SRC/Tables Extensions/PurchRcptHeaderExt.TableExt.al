namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.History;
using Microsoft.Finance.Currency;
using Microsoft.Foundation.Address;

tableextension 72014 "LFS Purch. Rcpt. Header Ext." extends "Purch. Rcpt. Header"
{
    fields
    {
        field(72000; "LFS EXIM Type"; Enum "LFS EXIM Type")
        {
            Caption = 'EXIM Type';
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
            Caption = 'Currency Code';
            TableRelation = Currency.Code;
        }
        field(72008; "LFS Custom Currency Factor"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Currency Factor';
            Editable = false;
            MinValue = 0;
        }
        field(72009; "LFS Exchange Rate for INR"; Decimal)
        {
            Caption = 'Exchange Rate for INR';
            DataClassification = CustomerContent;
        }
        field(72010; "LFS FOB Amount (FCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'FOB Amount (FCY)';
        }
        field(72011; "LFS FOB Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'FOB Amount (LCY)';
        }
        field(72012; "LFS CIF Amount (FCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'CIF Amount (FCY)';
        }
        field(72013; "LFS CIF Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'CIF Amount (LCY)';
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
            Caption = 'Driver Name';
            DataClassification = CustomerContent;
        }
        field(72018; "LFS Driver License No."; Code[30])
        {
            Caption = 'Driver License No.';
            DataClassification = CustomerContent;
        }
    }
}