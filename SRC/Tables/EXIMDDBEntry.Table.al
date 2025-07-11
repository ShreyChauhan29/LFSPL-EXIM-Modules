namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Sales.Document;
using Microsoft.Utilities;
using Microsoft.Finance.GST.Base;
using Microsoft.FixedAssets.FixedAsset;
using Microsoft.Projects.Resources.Resource;
using Microsoft.Inventory.Item;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Sales.History;

table 72005 "LFS EXIM DDB Entry"
{
    Caption = 'EXIM DDB Entry';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "LFS Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
        }
        field(2; "LFS Document Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Type';
            OptionMembers = " ","Posted Sales Invoice","Posted Sales Cr. Memo","Posted Purchase Invoice","Posted Purch. Cr. Memo";
            OptionCaption = ' ,Posted Sales Invoice,Posted Sales Cr. Memo,Posted Purchase Invoice,Posted Purch. Cr. Memo';
        }
        field(3; "LFS Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(4; "LFS Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Date';
        }
        field(5; "LFS Type"; Enum "Sales Line Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(6; "LFS No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = if ("LFS Type" = const(" ")) "Standard Text"
            else
            if ("LFS Type" = const("G/L Account")) "G/L Account" where("Direct Posting" = const(true),
                                                                        "Account Type" = const(Posting),
                                                                        Blocked = const(false))
            else
            if ("LFS Type" = const(Item)) Item
            else
            if ("LFS Type" = const(Resource)) Resource
            else
            if ("LFS Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("LFS Type" = const("Charge (Item)")) "Item Charge";
            DataClassification = CustomerContent;
        }
        field(7; "LFS Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(8; "LFS Unit of Measure"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit of Measure';
        }
        field(9; "LFS Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity';
        }
        field(10; "LFS Rate"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Rate';
        }
        field(11; "LFS FCY Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'FOB (FCY)';
        }
        field(12; "LFS LCY Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'FOB (LCY)';
        }
        field(13; "LFS Exchange Rate"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Exchange Rate';
        }
        field(14; "LFS Custom Exchange Rate"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Custom Exchange Rate';
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
            DataClassification = CustomerContent;
            Caption = 'FOB (FCY) Per Unit';
        }
        field(20; "LFS CIF Amount (FCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'CIF (FCY) Per Unit';
        }
        field(21; "LFS FOB FCY Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'FOB (FCY)';
        }
        field(22; "LFS CIF FCY Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'CIF (FCY)';
        }
        field(23; "LFS No. of Container"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. of Container';
        }
        field(24; "LFS Freight Type"; Enum "LFS Freight Type")
        {
            Caption = 'Freight Type';
            DataClassification = CustomerContent;
        }
        field(25; "LFS Freight ValuePerTypeLCY"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Freight Value Per Type (LCY)';
        }
        field(26; "LFS Freight ValuePerTypeFCY"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Freight Value Per Type (FCY)';
        }
        field(27; "ILFS Insurance Type"; Enum "LFS Insurance Type")
        {
            Caption = 'Insurance Type';
            DataClassification = CustomerContent;
        }
        field(28; "LFS Insurance Value LCY"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Insurance Value Per Type (LCY)';
        }
        field(29; "LFS Insurance Value FCY"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Insurance Value Per Type (FCY)';
        }
        field(30; "LFS EXIM Remark"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'EXIM Remark';
        }
        field(31; "LFS Freight Value (FCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Freight Value (FCY)';
        }
        field(32; "LFS Freight Value (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Freight Value (LCY)';
        }
        field(33; "LFS Insurance Value (FCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Insurance Value (FCY)';
        }
        field(34; "LFS Insurance Value (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Insurance Value (LCY)';
        }
        field(35; "LFS Packing List No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Packing List No.';
        }
        field(36; "LFS Claim DDB"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Claim DDB';
        }
        field(37; "LFS DDB %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'DDB %';
        }
        field(38; "LFS DDB Value FCY"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'DDB Value FCY';
        }
        field(39; "LFS Currency Exch. Rate"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Currency Exch. Rate';
        }
        field(40; "LFS Custom Exch. Rate"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Custom Exch. Rate';
        }
        field(41; "LFS DDB Value LCY"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'DDB Value LCY';
        }

        field(42; "LFS Late export order No."; code[15])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."LFS Late export order No." where("No." = field("LFS Document No.")));
            Editable = false;
            Caption = 'Late export order No.';
        }
        field(43; "LFS Late export order date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."LFS Late export order date" where("No." = field("LFS Document No.")));
            Editable = false;
            Caption = 'Late export order date';
        }

        field(44; "LFS bill No."; code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("LFS Posted Export Information"."LFS BL No/ AWB No." where("LFS Document No." = field("LFS Document No.")));
            Editable = false;
            Caption = 'BL No/ AWB No.';
        }
        field(45; "LFS bill Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("LFS Posted Export Information"."LFS BL Date/ AWB Date" where("LFS Document No." = field("LFS Document No.")));
            Editable = false;
            Caption = 'BL Date/ AWB Date';
        }
        field(46; "LFS Shipping Bill No."; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("LFS Posted Export Information"."LFS Shipping Bill No." where("LFS Document No." = field("LFS Document No.")));
            Editable = false;
            Caption = 'Shipping Bill No.';
        }
        field(47; "LFS Shipping Bill Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("LFS Posted Export Information"."LFS Shipping Bill Date" where("LFS Document No." = field("LFS Document No.")));
            Editable = false;
            Caption = 'Shipping Bill Date';
        }
        field(48; "LFS HSN No."; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "HSN/SAC";
            Caption = 'HSN No.';
        }
        field(49; "LFS CIF LCY Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'CIF (LCY)';
        }
        field(50; "LFS Actual DDB Value"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Actual DDB Value';
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