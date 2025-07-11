namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.Archive;

tableextension 72025 "LFS Sales Line Archive Ext." extends "Sales Line Archive"
{
    fields
    {
        field(72000; "LFS No. of Packages"; Integer)
        {
            Caption = 'No. of Packages';
            DataClassification = CustomerContent;
        }
        field(72001; "LFS Purity"; Decimal)
        {
            Caption = 'Purity';
            DataClassification = CustomerContent;
        }
        field(72002; "LFS Total Taxes"; Decimal)
        {
            Caption = 'Total Taxes';
            DataClassification = CustomerContent;
        }
        field(72003; "LFS From"; Text[250])
        {
            Caption = 'Container No. & Shipping Marks';
            DataClassification = CustomerContent;
        }
        field(72004; "LFS to"; Text[250])
        {
            Caption = 'No. & Kind of Packages';
            DataClassification = CustomerContent;
        }
        field(72005; "LFS EXIM Type"; Enum "LFS EXIM Type")
        {
            Caption = 'EXIM Type';
            Editable = false;
            Description = 'Lf-EXIM';
            DataClassification = CustomerContent;
        }
        field(72006; "LFS Incentive Type"; Enum "LFS Incentive Type")
        {
            Caption = 'Incentive Type';
            Description = 'Lf-EXIM';
            DataClassification = CustomerContent;
        }
        field(72007; "LFS License Type"; Enum "LFS License Type")
        {
            Caption = 'License Type';
            Description = 'Lf-EXIM';
            DataClassification = CustomerContent;
        }
        field(72008; "LFS License No."; Code[20])
        {
            Caption = 'License No.';
            Description = 'Lf-EXIM';
            TableRelation = if ("LFS License Type" = const("Adv. License")) "LFS EXIM License Header";
            DataClassification = CustomerContent;
        }
        field(72009; "LFS FOB Amount (FCY)"; Decimal)
        {
            Caption = 'FOB Amount (FCY)';
            DecimalPlaces = 2 : 5;
            Description = 'Lf-EXIM';
            DataClassification = CustomerContent;

        }
        field(72010; "LFS CIF Amount (FCY)"; Decimal)
        {
            Caption = 'CIF Amount (FCY)';
            DecimalPlaces = 2 : 5;
            DataClassification = CustomerContent;
        }
        field(72011; "LFS No. of Container"; Integer)
        {
            Caption = 'No. of Container';
            DataClassification = CustomerContent;
        }
        field(72012; "LFS Freight Type"; Enum "LFS Freight Type")
        {
            Caption = 'Freight Type';
            DataClassification = CustomerContent;
        }
        field(72013; "LFS Freight Value (LCY)"; Decimal)
        {
            Caption = 'Freight Value Per Type (LCY)';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(72014; "LFS Freight Value (FCY)"; Decimal)
        {
            Caption = 'Freight Value Per Type (FCY)';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
        field(72015; "LFS Insurance Type"; Enum "LFS Insurance Type")
        {
            Caption = 'Insurance Type';
            DataClassification = CustomerContent;
        }
        field(72016; "LFS Insurance Value (LCY)"; Decimal)
        {
            Caption = 'Insurance Value Per Type (LCY)';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(72017; "LFS Insurance Value (FCY)"; Decimal)
        {
            Caption = 'Insurance Value Per Type (FCY)';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
        field(72018; "LFS Category Type"; Enum "LFS Category Type")
        {
            Caption = 'Category Type';
            DataClassification = CustomerContent;

        }

        field(72024; "LFS EXIM Remark"; Text[250])
        {
            Caption = 'EXIM Remark';
            DataClassification = CustomerContent;
        }
        field(72025; "LFS Packing List No."; Code[20])
        {
            Caption = 'Packing List No.';
            DataClassification = CustomerContent;
        }
        field(72026; "LFS Claim DDB"; Boolean)
        {
            Caption = 'Claim DDB';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(72027; "LFS Currency Exch. Rate"; Decimal)
        {
            Caption = 'Currency Exch. Rate';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(72028; "LFS Custom Exch. Rate"; Decimal)
        {
            Caption = 'Custom Exch. Rate';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(72029; "LFS EXIM Item Group"; Code[20])
        {
            Caption = 'EXIM Item Group';
            Editable = false;
            TableRelation = "LFS EXIM Item Group";
            DataClassification = CustomerContent;
        }
        field(72030; "LFS Packing Line Exists"; Boolean)
        {
            Caption = 'Packing Line Exists';
            FieldClass = FlowField;
            CalcFormula = Exist("LFS EXIM Packing Lines" where("LFS Shipment Document No." = FIELD("Document No."), "LFS Shipment Document Line No." = FIELD("Line No.")));
            Editable = false;
        }
        field(72031; "LFS Packed Qty."; Decimal)
        {
            Caption = 'Packed Qty.';
            DataClassification = CustomerContent;
        }
        field(72032; "LFS Rem. Qty. To be Packed"; Decimal)
        {
            Caption = 'Rem. Qty. To be Packed';
            DataClassification = CustomerContent;
        }
        field(72033; "LFS Shipping Bill No."; Code[50])
        {
            Caption = 'Shipping Bill No.';
            DataClassification = CustomerContent;
        }
        field(72034; "LFS Shipping Bill Date"; Date)
        {
            Caption = 'Shipping Bill Date';
            DataClassification = CustomerContent;
        }
        field(72035; "LFS RoDTEP Rebate Rate %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'RoDTEP Rebate Rate %';
        }

        field(72036; "LFS RoDTEP Rebate Value"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Editable = false;
            Caption = 'RoDTEP Rebate Value';

        }
        field(72037; "LFS Source No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Source No.';
        }
        field(72038; "LFS Source Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Source Line No.';
        }
        field(72041; "LFS DDB Rate"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'DDB Rate';
        }
        field(72042; "LFS DDB Value (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Caption = 'DDB Value (LCY)';
        }
        field(72043; "LFS Dispatch Instruction"; Text[1000])
        {
            DataClassification = CustomerContent;
            Caption = 'Dispatch Instruction';
        }
        field(72044; "LFS Packing Details"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Packing Details';
        }
        field(72045; "LFS No. & Kind Of PKDG"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'No. & Kind Of PKDG';
        }
        field(72047; "LFS CIF Amount (LCY)"; decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Caption = 'CIF Amount (LCY)';
            Editable = false;
        }
        field(72048; "LFS Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Type';
            OptionCaption = 'CIF,FOB';
            OptionMembers = CIF,FOB;
        }
        field(72049; "LFS Salesperson Comm %"; Decimal)
        {
            Caption = 'Salesperson Commission %';
            DataClassification = CustomerContent;
        }
        field(72050; "LFS Salesperson Comm Amount"; Decimal)
        {
            Caption = 'Salesperson Commission Amount';
            DataClassification = CustomerContent;
        }
        field(72051; "LFS RoDTEP License No."; Code[20])
        {
            Caption = 'RoDTEP License No.';
            DataClassification = CustomerContent;
            TableRelation = "LFS Rodtep License Header"."LFS No." where("LFS Balance LCY" = filter(<> 0));
        }
        field(72052; "LFSRoDTEP License Sales Values"; Decimal)
        {
            Caption = 'RoDTEP License Sales Values';
            DataClassification = CustomerContent;
        }
        field(72053; "LFS HS Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'HS Code';
        }
        field(72056; "LFS FOB Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 5;
            Caption = 'FOB Amount (LCY)';
        }
    }
}