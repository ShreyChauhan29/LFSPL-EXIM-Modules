namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Sales.Document;
using Microsoft.Utilities;
using Microsoft.Sales.History;
using Microsoft.Finance.GST.Base;
using Microsoft.Projects.Resources.Resource;
using Microsoft.FixedAssets.FixedAsset;
using Microsoft.Inventory.Item;
using Microsoft.Finance.GeneralLedger.Account;
table 72025 "LFS EXIM RoDTEP Rebate Entry"
{
    Caption = 'EXIM RoDTEP Rebate Entry';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "LFS Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            DataClassification = CustomerContent;
        }
        field(2; "LFS Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
            OptionMembers = " ","Posted Sales Invoice","Posted Sales Cr. Memo","Posted Purchase Invoice","Posted Purch. Cr. Memo";
            OptionCaption = ' ,Posted Sales Invoice,Posted Sales Cr. Memo,Posted Purchase Invoice,Posted Purch. Cr. Memo';
        }
        field(3; "LFS Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(4; "LFS Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(5; "LFS Type"; Enum "Sales Line Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(6; "LFS No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            TableRelation = if ("LFS Type" = const(" ")) "Standard Text"
            else
            if ("LFS Type" = const(" ")) "G/L Account" where("Direct Posting" = const(true), "Account Type" = const(Posting), Blocked = const(false))
            else
            if ("LFS Type" = const(Item)) Item
            else
            if ("LFS Type" = const(Resource)) Resource
            else
            if ("LFS Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("LFS Type" = const("Charge (Item)")) "Item Charge";
        }
        field(7; "LFS Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(8; "LFS Unit of Measure"; Code[20])
        {
            Caption = 'Unit of Measure';
            DataClassification = CustomerContent;
        }
        field(9; "LFS Quantity"; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(10; "LFS Rate"; Decimal)
        {
            Caption = 'Rate';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 5;
        }
        field(11; "LFS FCY Amount"; Decimal)
        {
            Caption = 'FOB (FCY)';
            DataClassification = CustomerContent;
        }
        field(12; "LFS LCY Amount"; Decimal)
        {
            Caption = 'FOB (LCY)';
            DataClassification = CustomerContent;
        }
        field(13; "LFS Exchange Rate"; Decimal)
        {
            Caption = 'Exchange Rate';
            DataClassification = CustomerContent;
        }
        field(14; "LFS Custom Exchange Rate"; Decimal)
        {
            Caption = 'Custom Exchange Rate';
            DataClassification = CustomerContent;
        }
        field(15; "LFS EXIM Type"; Enum "LFS EXIM Type")
        {
            Caption = 'EXIM Type';
            DataClassification = CustomerContent;
        }
        field(16; "LFS Incentive Type"; Enum "LFS Incentive Type")
        {
            Caption = 'Incentive Type';
            DataClassification = CustomerContent;
        }
        field(19; "LFS FOB Amount (FCY)"; Decimal)
        {
            Caption = 'FOB (FCY) Per Unit';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 5;
        }
        field(20; "LFS CIF Amount (FCY)"; Decimal)
        {
            Caption = 'CIF (FCY) Per Unit';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 5;
        }
        field(21; "LFS No. of Container"; Integer)
        {
            Caption = 'No. of Container';
            DataClassification = CustomerContent;
        }
        // field(22; "LFS Freight Type"; Enum "LFS Freight Type")
        // {
        //     Caption = 'Freight Type';
        //     DataClassification = CustomerContent;
        // }
        field(23; "LFS Freight ValPerType LCY"; Decimal)
        {

            DataClassification = CustomerContent;
            Caption = 'Freight Value Per Type (LCY)';
        }
        field(24; "LFS Freight ValPerType FCY"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Freight Value Per Type (FCY)';
        }
        // field(25; "LFS Insurance Type"; Enum "LFS Insurance Type")
        // {
        //     Caption = 'Insurance Type';
        //     DataClassification = CustomerContent;
        // }
        field(26; "LFS Insur Val Per Type LCY"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Insurance Value Per Type (LCY)';
        }
        field(27; "LFS Insur Val Per Type FCY"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Insurance Value Per Type (FCY)';
        }
        // field(28; "LFS Category Type"; Enum "LFS Category Type")
        // {
        //     Caption = 'Category Type';
        //     DataClassification = CustomerContent;
        // }
        field(29; "LFS RoDTEP Rebate Rate %"; Decimal)
        {
            Caption = 'RoDTEP Rate %';
            DataClassification = CustomerContent;
        }
        field(30; "LFS RoDTEP Rebate Value LCY"; Decimal)
        {
            Caption = 'RoDTEP Value (LCY)';
            DataClassification = CustomerContent;
        }
        field(34; "LFS RoDTEP Con Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'RoDTEP Consumed Amount (LCY)';
        }
        // field(36; "LFS EXIM Remark"; Text[100])
        // {
        //     Caption = 'EXIM Remark';
        //     DataClassification = CustomerContent;
        // }
        field(37; "LFS Freight Value (FCY)"; Decimal)
        {
            Caption = 'Freight Value (FCY)';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(38; "LFS Freight Value (LCY)"; Decimal)
        {
            Caption = 'Freight Value (LCY)';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(39; "LFS Insurance Value (FCY)"; Decimal)
        {
            Caption = 'Insurance Value (FCY)';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(40; "LFS Insurance Value (LCY)"; Decimal)
        {
            Caption = 'Insurance Value (LCY)';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(41; "LFS Packing List No."; Code[20])
        {
            Caption = 'Packing List No.';
            DataClassification = CustomerContent;
        }
        field(42; "LFS Commercial Invoice No."; Code[20])
        {
            Caption = 'Commercial Invoice No.';
            DataClassification = CustomerContent;
        }
        field(43; "LFS Claim Amount"; Decimal)
        {
            Caption = 'Claim Amount';
            DataClassification = CustomerContent;
        }

        field(46; "LFS Receivable No."; Code[20])
        {
            Caption = 'Receivable No.';
            DataClassification = CustomerContent;
        }
        field(47; "LFS Receivable Date"; Date)
        {
            Caption = 'Receivable Date';
            DataClassification = CustomerContent;
        }
        field(48; "LFS Receivable G/L Doc No."; Code[20])
        {
            Caption = 'Receivable G/L Doc No.';
            DataClassification = CustomerContent;
        }
        field(49; "LFS Receivable G/L Doc Date"; Date)
        {
            Caption = 'Receivable G/L Doc Date';
            DataClassification = CustomerContent;
        }
        field(51; "LFS License Issue Date"; Date)
        {
            Caption = 'License Issue Date';
            DataClassification = CustomerContent;
        }
        field(52; "LFS License G/L Doc. No."; Code[20])
        {
            Caption = 'License G/L Doc. No.';
            DataClassification = CustomerContent;
        }
        field(53; "LFS Lic Issue G/L Doc. Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'License Issue G/L Doc. Date';
        }

        field(55; "LFS Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
            DataClassification = CustomerContent;
        }
        field(56; "LFS Currency Code"; Code[20])
        {
            Caption = 'Currency Code';
            DataClassification = CustomerContent;
        }
        field(57; "LFS Port Code"; Code[50])
        {
            Caption = 'Port Code';
            DataClassification = CustomerContent;
            TableRelation = "LFS EXIM Port"."LFS Code";
        }
        field(58; "LFS RoDTEP Rebate Value FCY"; Decimal)
        {
            Caption = 'RoDTEP Rebate Value FCY';
            DataClassification = CustomerContent;
        }
        field(59; "LFS Shipping Bill No."; Code[50])
        {
            Caption = 'Shipping Bill No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."Bill Of Export No." where("No." = field("LFS Document No.")));
            Editable = false;
        }
        field(60; "LFS Shipping Bill Date"; Date)
        {
            Caption = 'Shipping Bill Date';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."Bill Of Export Date" where("No." = field("LFS Document No.")));
            Editable = false;
        }
        field(61; "LFS Rebate Value"; Decimal)
        {
            Caption = 'Rebate Value';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Line"."LFS RoDTEP Rebate Value" where("Document No." = field("LFS Document No."), "Line No." = field("LFS Document Line No.")));
            Editable = false;
        }
        field(62; "LFS Select License"; Boolean)
        {
            Caption = 'Select License';
            DataClassification = CustomerContent;
        }
        field(63; "LFS License Created"; Boolean)
        {
            Caption = 'License Created';
            DataClassification = CustomerContent;
        }
        field(64; "LFS License No."; Code[20])
        {
            Caption = 'License No.';
            DataClassification = CustomerContent;
        }
        field(65; "LFS HSN No."; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "HSN/SAC".Code;
            Caption = 'HSN No.';
        }
        field(66; "LFS CIF Value (FCY)"; Decimal)
        {
            Caption = 'CIF (FCY)';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(67; "LFS CIF Value (LCY)"; Decimal)
        {
            Caption = 'CIF (LCY)';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(44; "LFS Bill No."; code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("LFS Posted Export Information"."LFS BL No/ AWB No." where("LFS Document No." = field("LFS Document No.")));
            Editable = false;
            Caption = 'BL No/ AWB No.';
        }
        field(45; "LFS Bill Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("LFS Posted Export Information"."LFS BL Date/ AWB Date" where("LFS Document No." = field("LFS Document No.")));
            Editable = false;
            Caption = 'BL Date/ AWB Date';
        }
    }
    keys
    {
        key(Key1; "LFS Entry No.")
        {
            Clustered = true;
        }
    }
}