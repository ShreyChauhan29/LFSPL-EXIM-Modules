namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Warehouse.History;

tableextension 72007 "LFS Posted Whse. Shipment Line" extends "Posted Whse. Shipment Line"
{
    fields
    {
        field(72000; "LFS EXIM Type"; Enum "LFS EXIM Type")
        {
            Caption = 'EXIM Type';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(72001; "LFS Incentive Type"; Enum "LFS Incentive Type")
        {
            Caption = 'Incentive Type';
            DataClassification = CustomerContent;
        }
        field(72002; "LFS License Type"; Enum "LFS License Type")
        {
            Caption = 'License Type';
            DataClassification = CustomerContent;
        }
        field(72003; "LFS License No."; Code[20])
        {
            Caption = 'License No.';
            DataClassification = CustomerContent;
            TableRelation = if ("LFS License Type" = const("Adv. License")) "LFS EXIM License Header";
        }
        field(72004; "LFS FOB Amount (FCY)"; Decimal)
        {
            Caption = 'FOB Amount (FCY)';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 5;
        }
        field(72005; "LFS CIF Amount (FCY)"; Decimal)
        {
            Caption = 'CIF Amount (FCY)';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 5;
        }
        field(72006; "LFS No. of Container"; Integer)
        {
            Caption = 'No. of Container';
            DataClassification = CustomerContent;
        }
        // field(72007; "LFS Freight Type"; Enum "LFS Freight Type")
        // {
        //     Caption = 'Freight Type';
        //     DataClassification = CustomerContent;
        // }
        field(72008; "LFS Freight Value (LCY)"; Decimal)
        {
            Caption = 'Freight Value Per Type (LCY)';
            DataClassification = CustomerContent;
        }
        field(72009; "LFS Freight Value (FCY)"; Decimal)
        {
            Caption = 'Freight Value Per Type (FCY)';
            DataClassification = CustomerContent;
            Editable = false;
        }
        // field(72010; "LFS Insurance Type"; Enum "LFS Insurance Type")
        // {
        //     Caption = 'Insurance Type';
        //     DataClassification = CustomerContent;
        // }
        field(72011; "LFS Insurance Value (LCY)"; Decimal)
        {
            Caption = 'Insurance Value Per Type (LCY)';
            DataClassification = CustomerContent;
        }
        field(72012; "LFS Insurance Value (FCY)"; Decimal)
        {
            Caption = 'Insurance Value Per Type (FCY)';
            DataClassification = CustomerContent;
            Editable = false;
        }
        // field(72013; "LFS Category Type"; Enum "LFS Category Type")
        // {
        //     Caption = 'Category Type';
        //     DataClassification = CustomerContent;
        // }
        // field(72019; "LFS EXIM Remark"; Text[100])
        // {
        //     Caption = 'EXIM Remark';
        //     DataClassification = CustomerContent;
        // }
        field(72020; "LFS Packing List No."; Code[20])
        {
            Caption = 'Packing List No.';
            DataClassification = CustomerContent;
        }
        field(72021; "LFS Claim DDB"; Boolean)
        {
            Caption = 'Claim DDB';
            DataClassification = CustomerContent;
        }
        field(72022; "LFS Currency Exch. Rate"; Decimal)
        {
            Caption = 'Currency Exch. Rate';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(72023; "LFS Custom Exch. Rate"; Decimal)
        {
            Caption = 'Custom Exch. Rate';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(72024; "LFS EXIM Item Group"; Code[20])
        {
            Caption = 'EXIM Item Group';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "LFS EXIM Item Group";
        }
        field(72025; "LFS Packing Line Exists"; Boolean)
        {
            Caption = 'Packing Line Exists';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Exist("LFS EXIM Packing Lines" where("LFS Shipment Document No." = FIELD("Source No."), "LFS Shipment Document Line No." = FIELD("Source Line No.")));
        }
        field(72026; "LFS Packed Qty."; Decimal)
        {
            Caption = 'Packed Qty.';
            DataClassification = CustomerContent;
        }
        field(72027; "LFS Rem. Qty. To be Packed"; Decimal)
        {
            Caption = 'Rem. Qty. To be Packed';
            DataClassification = CustomerContent;
        }
        field(72028; "LFS Shipping Bill No."; Code[50])
        {
            Caption = 'Shipping Bill No.';
            DataClassification = CustomerContent;
        }
        field(72029; "LFS Shipping Bill Date"; Date)
        {
            Caption = 'Shipping Bill Date';
            DataClassification = CustomerContent;
        }
        field(72056; "LFS FOB Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 5;
            Caption = 'FOB Amount (LCY)';
        }
    }
}