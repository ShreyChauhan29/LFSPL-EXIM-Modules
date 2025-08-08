namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Inventory.Item;
using Microsoft.Foundation.UOM;
using Microsoft.Inventory.Location;
table 72033 "LFS EXIM Posted Packing Table"
{
    Caption = 'Posted Packing List';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "LFS Source Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Source Document No.';
            Editable = false;
        }
        field(2; "LFS Source Doc. Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Source Document Line No.';
            Editable = false;
        }
        field(3; "LFS Source Order No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Source Order No.';
            Editable = false;
        }
        field(4; "LFS Source Order Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Source Order Line No.';
            Editable = false;
        }
        field(5; "LFS Source Document Type"; Option)
        {
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = 'Sales Order, Transfer Order, Warehouse Shipment';
            OptionMembers = "Sales Order","Transfer Order","Warehouse Shipment";
            Caption = 'Source Document Type';
        }
        field(6; "LFS Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(7; "LFS Item Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Code';
            Editable = false;
        }
        field(8; "LFS Variant Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Variant Code';
            Editable = false;
        }
        field(9; "LFS Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity';
            Editable = false;
        }
        field(10; "LFS Item UOM"; code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Item UOM';
            TableRelation = "Item Unit of Measure".Code;
            Editable = false;
        }
        field(11; "LFS Lot No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Lot No.';
        }
        // field(12; "LFS Serial No."; Code[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Seal No.';
        // }
        field(13; "LFS Location Code"; code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Location';
            TableRelation = Location.Code;
            Editable = false;
        }
        // field(14; "LFS Packing Type"; Code[20])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Packing Type';
        // }
        field(15; "LFS Packing No. From"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Packing no. From';
            MinValue = 0;
            trigger OnValidate()
            begin
                if Rec."LFS Packing No. From" <= Rec."LFS Packing No. To" then
                    Rec."LFS No. of Packs" := Rec."LFS Packing No. To" - Rec."LFS Packing No. From" + 1;
                rec."LFS Total Quantity in Pack" := Rec."LFS Qty. In each Pack" * Rec."LFS No. of Packs";
                Rec."LFS Net Weight of Pack" := Rec."LFS Net Weight per Item" * Rec."LFS Total Quantity in Pack";
                if Rec."LFS Total Quantity in Pack" <> 0 then
                    rec."LFS Gross Weight Per Item" := Rec."LFS Gross Weight of Pack" / Rec."LFS Total Quantity in Pack";
            end;
        }
        field(16; "LFS Packing No. To"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Packing No. To';
            MinValue = 0;
            trigger OnValidate()
            begin
                if Rec."LFS Packing No. From" <= Rec."LFS Packing No. To" then
                    Rec."LFS No. of Packs" := Rec."LFS Packing No. To" - Rec."LFS Packing No. From" + 1
                else
                    error('"Packing No. to" should be greater than or equal to "Packing No. from"');
                rec."LFS Total Quantity in Pack" := Rec."LFS Qty. In each Pack" * Rec."LFS No. of Packs";
                Rec."LFS Net Weight of Pack" := Rec."LFS Net Weight per Item" * Rec."LFS Total Quantity in Pack";
                if Rec."LFS Total Quantity in Pack" <> 0 then
                    rec."LFS Gross Weight Per Item" := Rec."LFS Gross Weight of Pack" / Rec."LFS Total Quantity in Pack";

            end;
        }
        field(17; "LFS No. of Packs"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. of Packs';
            MinValue = 0;
            trigger OnValidate()
            begin
                rec."LFS Total Quantity in Pack" := Rec."LFS Qty. In each Pack" * Rec."LFS No. of Packs";
                if Rec."LFS Total Quantity in Pack" <> 0 then
                    rec."LFS Gross Weight Per Item" := Rec."LFS Gross Weight of Pack" / Rec."LFS Total Quantity in Pack";
            end;
        }
        field(18; "LFS Packing No."; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Packing No.';
        }
        field(19; "LFS Qty. In each Pack"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. In each Pack';
            MinValue = 0;
            trigger OnValidate()
            begin
                rec."LFS Total Quantity in Pack" := Rec."LFS Qty. In each Pack" * Rec."LFS No. of Packs";
                if Rec."LFS Total Quantity in Pack" <> 0 then
                    rec."LFS Gross Weight Per Item" := Rec."LFS Gross Weight of Pack" / Rec."LFS Total Quantity in Pack";
            end;
        }
        field(20; "LFS Total Quantity in Pack"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Quantity in Pack';
            Editable = false;
            trigger OnValidate()
            begin
                if Rec."LFS Total Quantity in Pack" <> 0 then
                    rec."LFS Gross Weight Per Item" := Rec."LFS Gross Weight of Pack" / Rec."LFS Total Quantity in Pack";
            end;
        }
        field(21; "LFS Tare Weight of Pack"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Tare Weight of Pack';
            MinValue = 0;
            trigger OnValidate()
            begin
                Rec."LFS Gross Weight of Pack" := rec."LFS Tare Weight of Pack" + Rec."LFS Net Weight of Pack";
                if Rec."LFS Total Quantity in Pack" <> 0 then
                    rec."LFS Gross Weight Per Item" := Rec."LFS Gross Weight of Pack" / Rec."LFS Total Quantity in Pack";
            end;
        }
        field(22; "LFS Net Weight per Item"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Net Weight per Item';
            MinValue = 0;
            Editable = false;
            trigger OnValidate()
            begin
                Rec."LFS Gross Weight of Pack" := rec."LFS Tare Weight of Pack" + Rec."LFS Net Weight of Pack";
                if Rec."LFS Total Quantity in Pack" <> 0 then
                    rec."LFS Gross Weight Per Item" := Rec."LFS Gross Weight of Pack" / Rec."LFS Total Quantity in Pack";
            end;
        }
        field(23; "LFS Net Weight of Pack"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Net Weight of Pack';
            MinValue = 0;
            Editable = false;
        }
        field(24; "LFS Gross Weight of Pack"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Gross Weight of Pack';
            MinValue = 0;
            Editable = false;
            trigger OnValidate()
            begin
                Rec."LFS Total Gross Weight" := Rec."LFS Gross Weight of Pack" + Rec."LFS Tare Weight of Pallet";
                if Rec."LFS Total Quantity in Pack" <> 0 then
                    rec."LFS Gross Weight Per Item" := Rec."LFS Gross Weight of Pack" / Rec."LFS Total Quantity in Pack";
            end;
        }
        field(25; "LFS UOM"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Packing Material UOM';
            TableRelation = "Unit of Measure".Code;
        }
        field(26; "LFS Pallet Nos From"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Pallet Nos From';
            MinValue = 0;
            trigger OnValidate()
            begin
                if Rec."LFS Pallet Nos From" <= Rec."LFS Pallet Nos To" then
                    Rec."LFS No. of Pallets" := Rec."LFS Pallet Nos To" - Rec."LFS Pallet Nos From" + 1;
            end;
        }
        field(27; "LFS Pallet Nos To"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Pallet Nos To';
            MinValue = 0;
            trigger OnValidate()
            begin
                if Rec."LFS Pallet Nos From" <= Rec."LFS Pallet Nos To" then
                    Rec."LFS No. of Pallets" := Rec."LFS Pallet Nos To" - Rec."LFS Pallet Nos From" + 1
                else
                    error('"Pallet No. To" should be greater than or equal to "Pallet No. From"');
            end;
        }
        field(28; "LFS No. of Pallets"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. of Pallets';
            Editable = false;

        }
        field(29; "LFS Tare Weight of Pallet"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Tare Weight of Pallet';
            Editable = false;
            trigger OnValidate()
            begin
                Rec."LFS Total Gross Weight" := Rec."LFS Tare Weight of Pallet" + Rec."LFS Gross Weight of Pack";
            end;
        }
        field(30; "LFS Total Gross Weight"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Gross Weight';
            Editable = false;
        }
        field(31; "LFS Posted Export Shipment"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Posted Export Shipment';
        }
        field(32; "LFS PostExShipmentLineNo."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Posted Export Shipment Line No.';
        }
        field(33; "LFS PostedWhseShipment"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Posted Whse. Shipment';
        }
        field(34; "LFS PostWhseShipmentLineNo"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Posted Whse. Shipment Line No.';
        }
        field(35; "LFS Item tracking Updated"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Item tracking Updated';
        }
        field(36; "LFS Gross Weight Per Item"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Gross Weight Per Item';
        }
        field(37; "LFS Packing Dimension"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Packing Dimension';
        }
        field(38; "LFS Pallet Dimension"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Pallet Dimension';
        }

        // field(39; "LFS Custom_Serial No."; Code[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Custom Seal No.';
        // }
        field(40; "LFS Remarks"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Remarks';
        }
    }

    keys
    {
        key(Key1; "LFS Source Document Type", "LFS Posted Export Shipment", "LFS PostExShipmentLineNo.", "LFS Line No.")
        {
            Clustered = true;
        }
    }
}