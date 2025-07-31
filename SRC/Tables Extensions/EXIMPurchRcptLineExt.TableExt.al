namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.History;
using Microsoft.Warehouse.GateEntry;
using Microsoft.Inventory.Ledger;
using Microsoft.Purchases.Vendor;

tableextension 72015 "LFS EXIM Purch. Rcpt. Line Ext" extends "Purch. Rcpt. Line"
{
    fields
    {
        field(72000; "LFS Exim Type"; Enum "LFS EXIM Type")
        {
            Caption = 'Exim Type';
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
        }
        field(72004; "LFS CIF Amount (FCY)"; Decimal)
        {
            Caption = 'CIF Amount (FCY)';
            DataClassification = CustomerContent;
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
        // field(72010; "LFS EXIM Remark"; Text[250])
        // {
        //     Caption = 'EXIM Remark';
        //     DataClassification = CustomerContent;
        // }
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
        field(72021; "LFS Total No. Of Drums"; Integer)
        {
            Caption = 'Total No. Of Packs';
            DataClassification = CustomerContent;
        }
        field(72008; "LFS Item/Value Entry No."; Integer)
        {
            Caption = 'Item Ledger Entry No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Value Entry"."Item Ledger Entry No." where("Document No." = field("Document No."), "Document Line No." = field("Line No."), "Item No." = field("No."), "Variant Code" = field("Variant Code")));
        }
        field(72009; "LFS Item Charge No."; Code[20])
        {
            Caption = 'Item Charge No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Value Entry"."Item Charge No." where("Item Ledger Entry No." = field("LFS Item/Value Entry No."), "Item Charge No." = filter(<> '')));
        }
        field(72027; "LFS Inward Gate Entry No."; Code[20])
        {
            Caption = 'Inward Gate Entry No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Posted Gate Entry Attachment"."Gate Entry No." where("Receipt No." = field("Document No."), "Entry Type" = filter("Gate Entry Type"::Inward)));
        }
        field(72028; "LFS LR/RR No."; Code[20])
        {
            Caption = 'LR/RR No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Posted Gate Entry Header"."LR/RR No." where("No." = field("LFS Inward Gate Entry No.")));
        }
        field(72029; "LFS LR/RR Date"; Date)
        {
            Caption = 'LR/RR Date';
            FieldClass = FlowField;
            CalcFormula = lookup("Posted Gate Entry Header"."LR/RR Date" where("No." = field("LFS Inward Gate Entry No.")));
        }
        field(72030; "LFS Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor.Name where("No." = field("Buy-from Vendor No.")));
            Editable = false;
        }
        field(72031; "LFS FOB Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 5;
            Caption = 'FOB Amount (LCY)';
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
            Editable = false;
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
    }
}
