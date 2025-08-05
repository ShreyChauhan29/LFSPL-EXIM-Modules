namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.History;
using Microsoft.Purchases.Vendor;

tableextension 72020 "LFS Sales Cr.Memo Header Ext." extends "Sales Cr.Memo Header"
{
    fields
    {
        field(72000; "LFS EXIM Type"; Enum "LFS EXIM Type")
        {
            Caption = 'EXIM Type';

            Editable = false;
            DataClassification = CustomerContent;
        }
        field(72001; "LFS Port of Loading"; Code[20])
        {
            Caption = 'Port of Loading';
            DataClassification = CustomerContent;
        }
        field(72002; "LFS Port of Discharge"; Code[20])
        {
            Caption = 'Port of Discharge';
            DataClassification = CustomerContent;
        }
        field(72003; "LFS Country of Final Dest."; Code[20])
        {
            Caption = 'Country of Final Destination';
            DataClassification = CustomerContent;
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
        }
        field(72006; "LFS Inco Terms"; Code[20])
        {
            Caption = 'Inco Terms';
            DataClassification = CustomerContent;
        }
        field(72007; "LFS Export Remark"; Text[250])
        {
            Caption = 'Export Remark';
            DataClassification = CustomerContent;
        }
        field(72008; "LFS Custom Currency Code"; Code[10])
        {
            Caption = 'Custom Currency Code';
            DataClassification = CustomerContent;
        }
        field(72009; "LFS Custom Currency Factor"; Decimal)
        {
            Caption = 'Custom Currency Factor';
            Editable = false;
            MinValue = 0;
            DecimalPlaces = 0 : 15;
            DataClassification = CustomerContent;
        }
        field(72010; "LFS Shpping Line"; Code[20])
        {
            Caption = 'Shpping Line';
            DataClassification = CustomerContent;
        }
        field(72011; "LFS Pre Carriage"; Enum "LFS Pre Carriage")
        {
            Caption = 'Pre Carriage';
            DataClassification = CustomerContent;
        }
        // field(72012; "LFS Bill of Lading Date"; Date)
        // {
        //     Caption = 'Bill of Lading Date';
        //     DataClassification = CustomerContent;
        // }
        // field(72013; "LFS Bill of Lading No."; Code[20])
        // {
        //     Caption = 'Bill of Lading No.';
        //     DataClassification = CustomerContent;
        // }
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
        }
        field(72017; "LFS Commercial Bank Account"; Code[20])
        {
            Caption = 'Commercial  Bank Account';
            DataClassification = CustomerContent;
        }
        // field(72018; "LFS Carrier"; Text[30])
        // {
        //     Caption = 'Carrier';
        //     DataClassification = CustomerContent;
        // }
        // field(72019; "LFS Late export order No."; code[15])
        // {
        //     Caption = 'Late export order No.';
        //     DataClassification = CustomerContent;
        // }
        // field(72020; "LFS Late export order date"; Date)
        // {
        //     Caption = 'Late export order date';
        //     DataClassification = CustomerContent;
        // }
        // field(72021; "LFS bill No."; code[15])
        // {
        //     Caption = 'Bill No.';
        //     DataClassification = CustomerContent;
        // }
        // field(72022; "LFS bill Date"; Date)
        // {
        //     Caption = 'Bill Date';
        //     DataClassification = CustomerContent;
        // }
        field(72023; "LFS Shipping Bill No."; Code[50])
        {
            Caption = 'Shipping Bill No.';
            DataClassification = CustomerContent;
        }
        field(72024; "LFS Shipping Bill Date"; Date)
        {
            Caption = 'Shipping Bill Date';
            DataClassification = CustomerContent;
        }

        // field(72026; "LFS DDB Value"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'DDB Value';
        // }
        // field(72027; "LFS FOB Amount (FCY)"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'FOB Amount (FCY)';
        // }
        // field(72028; "LFS FOB Amount (LCY)"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'FOB Amount (LCY)';
        // }
        // field(72029; "LFS CIF Amount (FCY)"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'CIF Amount (FCY)';
        // }
        // field(72030; "LFS CIF Amount (LCY)"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'CIF Amount (LCY)';
        // }
        // field(72031; "LFS FOB Amount (FCY) LFSPL"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'FOB Amount (FCY)';
        // }
        // field(72032; "LFS Shortcut Dim Update"; Code[20])
        // {
        //     Caption = 'Shortcut Dim Update';
        //     DataClassification = CustomerContent;
        // }
        field(72033; "LFS Your Reference Date"; Date)
        {
            Caption = 'Your Reference Date';
            DataClassification = CustomerContent;
        }
        // field(72034; "LFS Adv. Payment"; Boolean)
        // {
        //     Caption = 'Adv. Payment';
        //     DataClassification = CustomerContent;
        // }
        // field(72035; "LFS License"; Boolean)
        // {
        //     Caption = 'License';
        //     DataClassification = CustomerContent;
        // }
        // field(72036; "LFS LC"; Boolean)
        // {
        //     Caption = 'LC';
        //     DataClassification = CustomerContent;
        // }
        // field(72037; "LFS Import Documents"; Boolean)
        // {
        //     Caption = 'Import Documents';
        //     DataClassification = CustomerContent;
        // }
        // field(72038; "LFS COA Approval"; Boolean)
        // {
        //     Caption = 'COA Approval';
        //     DataClassification = CustomerContent;
        // }
        // field(72039; "LFS Credit Block"; Boolean)
        // {
        //     Caption = 'Credit Block';
        //     DataClassification = CustomerContent;
        // }
        // field(72040; "LFS PSS Approval"; Boolean)
        // {
        //     Caption = 'PSS Approval';
        //     DataClassification = CustomerContent;
        // }
        // field(72041; "LFS other"; Boolean)
        // {
        //     Caption = 'Other';
        //     DataClassification = CustomerContent;
        // }
        // field(72042; "LFS Narcotix NOC"; Boolean)
        // {
        //     Caption = 'Narcotix NOC';
        //     DataClassification = CustomerContent;
        // }
        // field(72043; "LFS Additional Information"; Text[500])
        // {
        //     Caption = 'Additional Information';
        //     DataClassification = CustomerContent;
        // }
        // field(72044; "LFS FTT No."; Code[20])
        // {
        //     Caption = 'FTT No.';
        //     DataClassification = CustomerContent;
        // }
        // field(72045; "LFS FTT Date"; Date)
        // {
        //     Caption = 'FTT Date';
        //     DataClassification = CustomerContent;
        // }
        // field(72046; "LFS BIN No."; Code[20])
        // {
        //     Caption = 'BIN No.';
        //     DataClassification = CustomerContent;
        // }
        // field(72047; "LFS Commission Agent"; Code[20])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Commission Agent';
        //     trigger OnLookup()
        //     var
        //         vendor: Record Vendor;
        //     begin
        //         if vendor.Findset() then
        //             if page.Runmodal(page::"Vendor List", vendor) = action::LookupOK then
        //                 Rec."LFS Commission Agent" := vendor."No.";
        //     end;
        // }
        // field(72048; "LFS Comm. Amount"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Commission Amount';
        // }
        field(72050; "LFS Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Inco Terms Type';
            OptionCaption = 'CIF,FOB';
            OptionMembers = CIF,FOB;
        }
        // field(72051; "LFS Commission %"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Commission %"';
        // }
        // field(72052; "LFS Packing Type"; Option)
        // {
        //     OptionMembers = Custom,Commercial;
        //     OptionCaption = ' ,Custom,Commercial';
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("LFS EXIM Packing Lines"."LFS Type" where("LFS Shipment Document No." = field("No.")));
        //     Editable = false;
        //     Caption = 'Packing Type';
        // }
        // field(72053; "LFS Packing No."; Code[20])
        // {
        //     Caption = 'Packing No.';
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("LFS EXIM Packing Lines"."LFS Packing List No." where("LFS Shipment Document No." = field("No.")));
        //     Editable = false;
        // }
        // field(72054; "LFS Completely Packed"; Boolean)
        // {
        //     Caption = 'Completely Packed';
        //     FieldClass = FlowField;
        //     CalcFormula = - exist("Sales Shipment Line" where("Document No." = field("No."), Type = filter(Item)/*,Rem."Qty. To be Packed"=FILTER(<>0)*/));
        //     Editable = false;
        // }
        // field(72055; "LFS Total Line Qty."; Decimal)
        // {
        //     Caption = 'Total Line Qty.';
        //     FieldClass = FlowField;
        //     CalcFormula = Sum("Sales Shipment Line".Quantity where("Document No." = FIELD("No."), Type = FILTER(Item)));
        //     Editable = false;
        // }
        // field(72056; "LFS Packing Posted"; Boolean)
        // {
        //     Caption = 'Packing Posted';
        //     DataClassification = CustomerContent;
        // }
        field(72063; "LFSPlaceofReceiptPre-Carriage"; Enum "LFS Pre Carriage")
        {
            DataClassification = CustomerContent;
            Caption = 'Place of Receipt By Pre-Carriage';
        }
        field(72064; "Json Body"; Blob)
        {
            DataClassification = CustomerContent;
            Caption = 'Json Body';
        }
        field(72069; "LFS Lodgement Ref No"; Code[50])
        {
            Caption = 'Lodgement Ref No';
            DataClassification = CustomerContent;
        }
        field(72070; "LFS LUT No."; Code[30])
        {
            Caption = 'LUT No.';
            DataClassification = CustomerContent;
            TableRelation = "LFS LUT Master Table"."LFS LUT No.";
        }
        field(72071; "LFS LUT Date"; Date)
        {
            Caption = 'LUT Date';
            DataClassification = CustomerContent;
        }
    }
}