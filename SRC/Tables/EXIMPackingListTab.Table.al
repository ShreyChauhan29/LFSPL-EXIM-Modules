namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Inventory.Item;
using Microsoft.Foundation.UOM;
using Microsoft.Sales.Document;
using Microsoft.Warehouse.Document;
using Microsoft.Inventory.Tracking;
using Microsoft.Inventory.Location;
table 72031 "LFS EXIM Packing List Tab."
{
    Caption = 'EXIM Packing List Tab.';
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
            OptionCaption = 'Sales Order, Transfer Order';
            OptionMembers = "Sales Order","Transfer Order";
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
        field(12; "LFS Serial No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Seal No.';
        }
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
            Editable = true;
            trigger OnValidate()
            begin
                Rec."LFS Gross Weight of Pack" := rec."LFS Tare Weight of Pack" + Rec."LFS Net Weight of Pack";
                if Rec."LFS Total Quantity in Pack" <> 0 then
                    rec."LFS Gross Weight Per Item" := Rec."LFS Gross Weight of Pack" / Rec."LFS Total Quantity in Pack";
                Rec."LFS Net Weight of Pack" := Rec."LFS Net Weight per Item" * Rec."LFS Total Quantity in Pack";
            end;
        }
        field(23; "LFS Net Weight of Pack"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Net Weight of Pack';
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
            MinValue = 0;
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
        field(39; "LFS Custom_Serial No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Container No.';
        }
        field(40; "LFS Remarks"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Remarks';
        }
    }

    keys
    {
        key(Key1; "LFS Source Document No.", "LFS Source Doc. Line No.", "LFS Source Document Type", "LFS Source Order No.", "LFS Source Order Line No.", "LFS Line No.")
        {
            Clustered = true;
        }
    }


    trigger OnModify()
    begin
        ValueUpdateInNewLines();
    end;


    var
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        ItemTrackingDataCollection: Codeunit "Item Tracking Data Collection";

    procedure LookUpTrackingSummary(var PackingList: Record "LFS EXIM Packing List Tab."; SearchForSupply: Boolean; SignFactor: Integer; TrackingType: Enum "Item Tracking Type")
    var
        TempTrackingSpecification: Record "Tracking Specification" temporary;
    // IsHandled: Boolean;
    begin
        InitTrackingSpecFromWhseActivLine(TempTrackingSpecification, PackingList);
        TempTrackingSpecification."Quantity (Base)" := PackingList."LFS Quantity";
        TempTrackingSpecification."Qty. to Handle (Base)" := PackingList."LFS Total Quantity in Pack";
        TempTrackingSpecification."Qty. to Invoice" := 0;
        TempTrackingSpecification."Qty. to Invoice (Base)" := 0;
        TempTrackingSpecification."Quantity Handled (Base)" := 0;
        TempTrackingSpecification."Quantity Invoiced (Base)" := 0;

        GetItem();
        if not ItemTrackingDataCollection.CurrentDataSetMatches(
            PackingList."LFS Item Code", PackingList."LFS Variant Code", PackingList."LFS Location Code")
        then
            Clear(ItemTrackingDataCollection);
        case TrackingType of
            TrackingType::"Serial No.":
                if TempTrackingSpecification."Serial No." <> '' then begin
                    PackingList.Validate("LFS Serial No.", TempTrackingSpecification."Serial No.");
                    PackingList.Validate("LFS Lot No.", TempTrackingSpecification."Lot No.");
                    PackingList.Modify();
                end;
            TrackingType::"Lot No.":
                if TempTrackingSpecification."Lot No." <> '' then begin
                    PackingList.Validate("LFS Lot No.", TempTrackingSpecification."Lot No.");
                    PackingList.Modify();
                end;
        end;
    end;

    procedure ValueUpdateInNewLines()
    var
        Items: Record Item;
        salesOrder: Record "Sales Line";
        WhseShip: Record "Warehouse Shipment Line";
    begin
        WhseShip.SetRange("No.", Rec."LFS Source Document No.");
        WhseShip.SetRange("Line No.", Rec."LFS Source Doc. Line No.");
        if WhseShip.FindFirst() then begin
            Rec."LFS Item Code" := WhseShip."Item No.";
            Rec."LFS Variant Code" := WhseShip."Variant Code";
            Rec."LFS Quantity" := WhseShip."Qty. to Ship (Base)";
            Rec."LFS Item UOM" := WhseShip."Unit of Measure Code";
            Rec."LFS Location Code" := WhseShip."Location Code";
        end;
        salesOrder.SetRange("Document No.", Rec."LFS Source Document No.");
        salesOrder.SetRange("Line No.", Rec."LFS Source Doc. Line No.");
        salesOrder.SetRange("Document Type", salesOrder."Document Type"::Order);
        salesOrder.SetRange(Type, salesOrder.Type::Item);
        if salesOrder.FindFirst() then begin
            Rec."LFS Item Code" := salesOrder."No.";
            Rec."LFS Variant Code" := salesOrder."Variant Code";
            Rec."LFS Quantity" := salesOrder."Qty. to Ship (Base)";
            Rec."LFS Item UOM" := salesOrder."Unit of Measure Code";
            Rec."LFS Location Code" := salesOrder."Location Code";
        end;
        Items.Reset();
        Items.SetRange("No.", rec."LFS Item Code");
        if Items.FindFirst() then
            if Items."Net Weight" <> 0 then
                Rec."LFS Net Weight per Item" := Items."Net Weight";
        rec.Validate("LFS Net Weight per Item");
    end;

    local procedure GetItem()
    begin
        if Item."No." = "LFS Item Code" then
            exit;

        Item.Get("LFS Item Code");
        if Item."Item Tracking Code" <> '' then
            ItemTrackingCode.Get(Item."Item Tracking Code")
        else
            Clear(ItemTrackingCode);
    end;

    local procedure InitTrackingSpecFromWhseActivLine(var TrackingSpecification: Record "Tracking Specification"; PackingList: Record "LFS EXIM Packing List Tab.")
    begin
        TrackingSpecification.Init();
        TrackingSpecification."Item No." := PackingList."LFS Item Code";
        TrackingSpecification."Location Code" := PackingList."LFS Location Code";
        TrackingSpecification."Variant Code" := PackingList."LFS Variant Code";
        TrackingSpecification."Qty. to Handle (Base)" := PackingList."LFS Total Quantity in Pack";
    end;
}