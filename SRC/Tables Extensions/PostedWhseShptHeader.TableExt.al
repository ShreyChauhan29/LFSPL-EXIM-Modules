namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Warehouse.History;
using Microsoft.Foundation.Address;
using Microsoft.Purchases.Vendor;
using Microsoft.Bank.BankAccount;
using Microsoft.Finance.Currency;

tableextension 72006 "LFS Posted Whse. Shpt. Header" extends "Posted Whse. Shipment Header"
{
    fields
    {
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
            TableRelation = "Country/Region";
        }
        field(72006; "LFS Inco Terms"; Code[20])
        {
            Caption = 'Inco Terms';
            DataClassification = CustomerContent;
            TableRelation = "LFS EXIM Inco Terms";
        }
        field(72007; "LFS Export Remark"; Text[75])
        {
            Caption = 'Export Remark';
            DataClassification = CustomerContent;
        }
        field(72008; "LFS Custom Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Currency Code';
            TableRelation = Currency.Code;
        }
        field(72009; "LFS Custom Currency Factor"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MaxValue = 0;
        }
        field(72010; "LFS Shpping Line"; Code[20])
        {
            Caption = 'Shpping Line';
            DataClassification = CustomerContent;
            TableRelation = "LFS EXIM Shipping Line";
        }
        field(72011; "LFS Pre Carriage"; Enum "LFS Pre Carriage")
        {
            Caption = 'Pre Carriage';
            DataClassification = CustomerContent;
        }
        field(72012; "LFS Bill of Lading Date"; Date)
        {
            Caption = 'Bill of Lading Date';
            DataClassification = CustomerContent;
        }
        field(72013; "LFS Bill of Lading No."; Code[20])
        {
            Caption = 'Bill of Lading No.';
            DataClassification = CustomerContent;
        }
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
            DataClassification = CustomerContent;
            TableRelation = "Bank Account"."No.";
        }
        field(72017; "LFS Commercial Bank Account"; Code[20])
        {
            Caption = 'Commercial  Bank Account';
            DataClassification = CustomerContent;
            TableRelation = "Bank Account";
        }
        field(72018; "LFS Carrier"; Text[30])
        {
            Caption = 'Carrier';
            DataClassification = CustomerContent;
        }
        field(72019; "LFS FTT No."; Code[20])
        {
            Caption = 'FTT No.';
            DataClassification = CustomerContent;
        }
        field(72020; "LFS FTT Date"; Date)
        {
            Caption = 'FTT Date';
            DataClassification = CustomerContent;
        }
        field(72021; "LFS BIN No."; Code[20])
        {
            Caption = 'BIN No.';
            DataClassification = CustomerContent;
        }
        field(72022; "LFS Exim Shipping Line"; Code[10])
        {
            Caption = 'Exim Shipping Line';
            DataClassification = CustomerContent;
            TableRelation = "LFS EXIM Shipping Line"."LFS Code";
        }
        field(72023; "LFS Commission Agent"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Commission Agent Domestic';
            trigger OnLookup()
            var
                vendor: Record Vendor;
            begin
                if vendor.Findset() then
                    if page.Runmodal(page::"Vendor List", vendor) = action::LookupOK then
                        Rec."LFS Commission Agent" := vendor."No.";
            end;
        }
        field(72024; "LFS Comm. Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Commission Amount Domestic';
        }

    }
}