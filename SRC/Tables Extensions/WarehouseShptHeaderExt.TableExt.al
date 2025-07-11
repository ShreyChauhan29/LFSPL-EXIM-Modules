namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Warehouse.Document;
using Microsoft.Purchases.Vendor;
using Microsoft.Sales.History;
using Microsoft.Bank.BankAccount;
using Microsoft.Finance.Currency;
using Microsoft.Foundation.Address;

tableextension 72031 "LFS Warehouse Shpt. Header Ext" extends "Warehouse Shipment Header"
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
            TableRelation = "Country/Region".Code;
        }
        field(72006; "LFS Inco Terms"; Code[20])
        {
            Caption = 'Inco Terms';
            DataClassification = CustomerContent;
            TableRelation = "LFS EXIM Inco Terms";
        }
        field(72007; "LFS Export Remark"; Text[250])
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
        field(72011; "LFS Pre Carriage"; enum "LFS Pre Carriage")
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
            TableRelation = "Bank Account"."No.";
        }
        field(72018; "LFS Carrier"; Text[30])
        {
            Caption = 'Carrier';
            DataClassification = CustomerContent;
        }
        field(72019; "LFS Additional Information"; Text[500])
        {
            Caption = 'Additional Information';
            DataClassification = CustomerContent;
        }
        field(72020; "LFS FTT No."; Code[20])
        {
            Caption = 'FTT No.';
            DataClassification = CustomerContent;
        }
        field(72021; "LFS FTT Date"; Date)
        {
            Caption = 'FTT Date';
            DataClassification = CustomerContent;
        }
        field(72022; "LFS BIN No."; Code[20])
        {
            Caption = 'BIN No.';
            DataClassification = CustomerContent;
        }
        field(72023; "LFS Exim Shipping Line"; Code[10])
        {
            Caption = 'Exim Shipping Line';
            DataClassification = CustomerContent;
            TableRelation = "LFS EXIM Shipping Line"."LFS Code";
        }
        field(72024; "LFS Packing Type"; Option)
        {
            Caption = 'Packing Type';
            OptionMembers = Custom,Commercial;
            OptionCaption = ' ,Custom,Commercial';
            FieldClass = FlowField;
            CalcFormula = lookup("LFS EXIM Packing Lines"."LFS Type" where("LFS Shipment Document No." = field("No.")));
            Editable = false;
        }
        field(72025; "LFS Packing No."; Code[20])
        {
            Caption = 'Packing No.';
            FieldClass = FlowField;
            CalcFormula = lookup("LFS EXIM Packing Lines"."LFS Packing List No." where("LFS Shipment Document No." = field("No.")));
            Editable = false;
        }
        field(72026; "LFS Completely Packed"; Boolean)
        {
            Caption = 'Completely Packed';
            FieldClass = FlowField;
            CalcFormula = - exist("Sales Shipment Line" where("Document No." = field("No."), Type = filter(Item)));
            Editable = false;
        }
        field(72027; "LFS Total Line Qty."; Decimal)
        {
            Caption = 'Total Line Qty.';
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Shipment Line".Quantity where("Document No." = FIELD("No."), Type = FILTER(Item)));
            Editable = false;
        }
        field(72028; "LFS Packing Posted"; Boolean)
        {
            Caption = 'Packing Posted';
            DataClassification = CustomerContent;
        }
        field(72029; "LFS Commission Agent"; Code[20])
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
        field(72030; "LFS Comm. Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Commission Amount Domestic';
        }
        field(72063; "LFSPlaceofReceiptPre-Carriage"; Enum "LFS Pre Carriage")
        {
            DataClassification = CustomerContent;
            Caption = 'Place of Receipt By Pre-Carriage';
        }
    }
    trigger OnDelete()
    var
        PackingList: Record "LFS EXIM Packing List Tab.";
        exportinfo: Record "LFS Export Information Header";
    begin
        exportinfo.SetRange("LFS Document No.", Rec."No.");
        if exportinfo.FindFirst() then
            exportinfo.Delete();
        PackingList.SetRange("LFS Source Document No.", rec."No.");
        if PackingList.Findset() then
            PackingList.DeleteAll();

    end;
}