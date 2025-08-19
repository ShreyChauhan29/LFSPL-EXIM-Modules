namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Warehouse.Document;
using Microsoft.Inventory.Tracking;
using Microsoft.Inventory.Item;
using Microsoft.Sales.Document;

page 72047 "LFS EXIM Packing List"
{
    ApplicationArea = All;
    Caption = 'EXIM Packing List';
    PageType = List;
    SourceTable = "LFS EXIM Packing List Tab.";
    UsageCategory = Lists;
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(content1)
            {
                field("Source Document No."; Rec."LFS Source Document No.")
                {
                    ApplicationArea = All;
                    visible = false;
                    ToolTip = 'Specifies the Source Document No.';
                }
                field("Source Document Line No."; Rec."LFS Source Doc. Line No.")
                {
                    ApplicationArea = all;
                    visible = false;
                    ToolTip = 'Specifies the Source Document Line No.';
                }
                field("Source Order No."; Rec."LFS Source Order No.")
                {
                    ApplicationArea = all;
                    visible = false;
                    ToolTip = 'Specifies the Source Order No.';
                }
                field("Source Order Line No."; Rec."LFS Source Order Line No.")
                {
                    ApplicationArea = all;
                    visible = false;
                    ToolTip = 'Specifies the Source Order Line No.';
                }
                field("Source Document Type"; Rec."LFS Source Document Type")
                {
                    ApplicationArea = all;
                    visible = false;
                    ToolTip = 'Specifies the Source Document Type';
                }
                field("Item Code"; Rec."LFS Item Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Item Code';
                }
                field("Variant Code"; Rec."LFS Variant Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Variant Code';
                }
                field("Item UOM"; Rec."LFS Item UOM")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Item UOM';
                }
                field(Quantity; Rec."LFS Quantity")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Quantity';
                }
                field("Location Code"; Rec."LFS Location Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Location Code';
                }
                field("Qty. In each Pack"; Rec."LFS Qty. In each Pack")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Qty. In each Pack';
                }
                field("Lot No."; Rec."LFS Lot No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Lot No.';
                }
                // field("Seal No."; Rec."LFS Serial No.")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the Seal No.';
                // }
                // field("LFS Custom_Serial No."; Rec."LFS Custom_Serial No.")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the Custom_Serial No.';
                // }
                // field("Packing Type"; Rec."LFS Packing Type")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the Packing Type';
                //     Visible = false;
                // }
                field(UOM; Rec."LFS UOM")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Packing Material UOM';
                    Caption = 'Packing Material UOM';
                }
                field("Packing Dimension"; Rec."LFS Packing Dimension")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Packing Dimension';
                }
                field("Packing No. From"; Rec."LFS Packing No. From")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Packing No. From';
                }
                field("Packing No. To"; Rec."LFS Packing No. To")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Packing No. To';
                }
                field("No. of Packs"; Rec."LFS No. of Packs")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the No. of Packs';
                }
                field("Total Quantity in Pack"; Rec."LFS Total Quantity in Pack")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Total Quantity in Pack';
                }
                field("Packing No."; Rec."LFS Packing No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Packing No.';
                }
                field("Net Weight per Item"; Rec."LFS Net Weight per Item")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Net Weight per Item';
                }
                field("Net Weight of Pack"; Rec."LFS Net Weight of Pack")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Net Weight of Pack';
                }
                field("Tare Weight of Pack"; Rec."LFS Tare Weight of Pack")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Tare Weight of Pack';
                }
                field("LFS Gross Weight Per Item"; Rec."LFS Gross Weight Per Item")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Gross Weight Per Item';
                }
                field("Gross Weight of Pack"; Rec."LFS Gross Weight of Pack")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Gross Weight of Pack';
                }
                field("LFS Pallet Dimension"; Rec."LFS Pallet Dimension")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Pallet Dimension';
                }
                field("Pallet Nos From"; Rec."LFS Pallet Nos From")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Pallet Nos From';
                }
                field("Pallet Nos To"; Rec."LFS Pallet Nos To")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Pallet Nos To';
                }
                field("No. of Pallets"; Rec."LFS No. of Pallets")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the No. of Pallets';
                }
                field("Tare Weight of Pallet"; Rec."LFS Tare Weight of Pallet")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Tare Weight of Pallet';
                }
                field("Total Gross Weight"; Rec."LFS Total Gross Weight")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Total Gross Weight';
                }
                field("LFS Remarks"; Rec."LFS Remarks")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Get Tracking Details")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Image = ItemTracking;
                ToolTip = 'Specifies the Get Tracking Details';
                trigger OnAction()
                var
                    SalesLine: Record "Sales Line";
                    whseShipmentLine: Record "Warehouse Shipment Line";
                begin
                    whseShipmentLine.SetRange("No.", Rec."LFS Source Document No.");
                    // whseShipmentLine.SetRange("Line No.", Rec."LFS Source Doc. Line No.");
                    if not whseShipmentLine.IsEmpty() then
                        gettrackingDetailsForWhseShipment();
                    SalesLine.SetRange("Document No.", Rec."LFS Source Document No.");
                    // SalesLine.SetRange("Line No.", Rec."LFS Source Doc. Line No.");
                    if not SalesLine.IsEmpty() then
                        getTrackingDetailsForSalesOrder();

                end;
            }
        }
    }

    trigger OnQueryClosePage(closeAction: Action): Boolean
    begin
        if Rec."LFS Pallet Nos From" > Rec."LFS Pallet Nos To" then
            error('"Pallet No. To" should be greater than or equal to "Pallet No. From"');
        // exit(false);
        if Rec."LFS Packing No. From" > Rec."LFS Packing No. To" then
            error('"Packing No. to" should be greater than or equal to "Packing No. from"');
        // exit(false);
    end;

    local procedure getTrackingDetailsForSalesOrder()
    var
        Item: Record Item;
        ItemTrackingLines: Record "Reservation Entry";
        SalesLine: Record "Sales Line";
        LineNo: Integer;
    begin
        rec.SetCurrentKey("LFS Line No.");
        if Rec.Findset() then
            repeat
                if Rec."LFS Item tracking Updated" = true then
                    Error('Item Tracking details is already Updated');
            until Rec.Next() = 0;
        LineNo := 0;
        ItemTrackingLines.SetRange("Source ID", Rec."LFS Source Document No.");
        // ItemTrackingLines.SetRange("Source Ref. No.", Rec."LFS Source Doc. Line No.");
        ItemTrackingLines.Setfilter("Qty. to Handle (Base)", '<>%1', 0);
        ItemTrackingLines.SetFilter("Item Tracking", '<>%1', ItemTrackingLines."Item Tracking"::None);
        if ItemTrackingLines.Findset() then begin
            repeat
                LineNo += 10000;
                Rec."LFS Line No." := LineNo;
                Rec."LFS Lot No." := ItemTrackingLines."Lot No.";
                // Rec."LFS Serial No." := ItemTrackingLines."Serial No.";
                Rec."LFS Total Quantity in Pack" := Abs(ItemTrackingLines."Qty. to Handle (Base)");
                Rec."LFS Net Weight of Pack" := Abs(ItemTrackingLines."Qty. to Handle (Base)");
                Rec."LFS Packing No." := ItemTrackingLines."Package No.";
                Rec."LFS Item tracking Updated" := true;
                SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                SalesLine.SetRange("Document No.", Rec."LFS Source Document No.");
                SalesLine.SetRange("Line No.", ItemTrackingLines."Source Ref. No.");
                // SalesLine.SetRange("Line No.", Rec."LFS Source Doc. Line No.");
                SalesLine.SetRange(Type, SalesLine.Type::Item);
                if SalesLine.FindFirst() then begin
                    Rec."LFS Item Code" := SalesLine."No.";
                    Rec."LFS Source Doc. Line No." := SalesLine."Line No.";
                    Rec."LFS Source Order Line No." := SalesLine."Line No.";
                    Rec."LFS Quantity" := SalesLine."Qty. to Ship (Base)";
                    rec."LFS Item UOM" := SalesLine."Unit of Measure Code";
                    Rec."LFS Location Code" := SalesLine."Location Code";
                    Rec."LFS Variant Code" := SalesLine."Variant Code";
                    Item.SetRange("No.", SalesLine."No.");
                    if Item.FindFirst() then
                        Rec."LFS Net Weight per Item" := Item."Net Weight";
                end;
                if not Rec.Insert() then Rec.Modify();
            until ItemTrackingLines.Next() = 0;
            Message('Item Tracking Lines successfully inserted');
        end
        else
            Message('There are no available Item tracking lines.');
    end;

    local procedure gettrackingDetailsForWhseShipment()
    var
        Item: Record Item;
        ItemTrackingLines: Record "Reservation Entry";
        whseShipmentLine: Record "Warehouse Shipment Line";
        LineNo: Integer;
    begin
        rec.SetCurrentKey("LFS Line No.");
        if Rec.Findset() then
            repeat
                if Rec."LFS Item tracking Updated" = true then
                    Error('Item Tracking details is already Updated');
            until Rec.Next() = 0;
        LineNo := 0;
        whseShipmentLine.Reset();
        whseShipmentLine.SetRange("No.", Rec."LFS Source Document No.");
        if whseShipmentLine.FindSet() then
            repeat
                ItemTrackingLines.SetRange("Source ID", whseShipmentLine."Source No.");
                ItemTrackingLines.SetRange("Source Ref. No.", whseShipmentLine."Source Line No.");
                ItemTrackingLines.Setfilter("Qty. to Handle (Base)", '<>%1', 0);
                ItemTrackingLines.SetFilter("Item Tracking", '<>%1', ItemTrackingLines."Item Tracking"::None);
                if ItemTrackingLines.Findset() then
                    // begin
                    repeat
                        LineNo += 10000;
                        Rec."LFS Line No." := LineNo;
                        Rec."LFS Lot No." := ItemTrackingLines."Lot No.";
                        Rec."LFS Source Doc. Line No." := whseShipmentLine."Line No.";
                        Rec."LFS Source Order No." := whseShipmentLine."Source No.";
                        Rec."LFS Source Order Line No." := whseShipmentLine."Source Line No.";
                        Rec."LFS Source Document Type" := Rec."LFS Source Document Type"::"Warehouse Shipment";
                        // Rec."LFS Serial No." := ItemTrackingLines."Serial No.";
                        Rec."LFS Total Quantity in Pack" := Abs(ItemTrackingLines."Quantity (Base)");
                        Rec."LFS Net Weight of Pack" := Abs(ItemTrackingLines."Qty. to Handle (Base)");
                        Rec."LFS Packing No." := ItemTrackingLines."Package No.";
                        Rec."LFS Item Code" := whseShipmentLine."Item No.";
                        Rec."LFS Quantity" := whseShipmentLine."Qty. to Ship (Base)";
                        rec."LFS Item UOM" := whseShipmentLine."Unit of Measure Code";
                        Rec."LFS Location Code" := whseShipmentLine."Location Code";
                        Rec."LFS Variant Code" := whseShipmentLine."Variant Code";
                        Item.SetRange("No.", whseShipmentLine."Item No.");
                        if Item.FindFirst() then
                            Rec."LFS Net Weight per Item" := Item."Net Weight";
                        if not Rec.Insert() then Rec.Modify();
                    until ItemTrackingLines.Next() = 0;
            // Message('Item Tracking Lines successfully inserted');
            // end
            // else
            //     Message('There are no available Item tracking lines.');
            until whseShipmentLine.Next() = 0;

        if not Rec.IsEmpty then
            Message('Item Tracking Lines successfully inserted')
        else
            Message('There are no available Item tracking lines.');
    end;
}