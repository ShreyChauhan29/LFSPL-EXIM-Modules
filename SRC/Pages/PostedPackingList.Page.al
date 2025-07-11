namespace LFSEximModule.LFSPLEXIMModule;

page 72049 "LFS Posted Packing List"
{
    ApplicationArea = All;
    Caption = 'Posted Packing List';
    PageType = List;
    SourceTable = "LFS EXIM Posted Packing Table";
    UsageCategory = History;
    ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(content1)
            {
                field("Source Document No."; Rec."LFS Source Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Source Document No.';
                    Visible = false;
                }
                field("Source Document Line No."; Rec."LFS Source Doc. Line No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Source Document Line No.';
                    Visible = false;
                }
                field("Source Order No."; Rec."LFS Source Order No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Source Order No.';
                    visible = false;
                }
                field("Source Order Line No."; Rec."LFS Source Order Line No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Source Order Line No.';
                    visible = false;
                }
                field("Source Document Type"; Rec."LFS Source Document Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Source Document Type';
                    visible = false;
                }
                field("Line No."; Rec."LFS Line No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Line No.';
                    Visible = false;
                }
                field("Item Code"; Rec."LFS Item Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Item Code';
                }
                field("Varint Code"; Rec."LFS Variant Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Varint Code';
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
                field("LFS Qty. In each Pack"; Rec."LFS Qty. In each Pack")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Qty. In each Pack';
                }
                field("Lot No."; Rec."LFS Lot No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Lot No.';
                }
                field("Seal No."; Rec."LFS Serial No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Seal No.';
                }
                field("LFS Custom_Serial No."; Rec."LFS Custom_Serial No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Custom_Serial No.';
                }
                field("Packing Type"; Rec."LFS Packing Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Packing Type';
                    visible = false;
                }
                field("LFS UOM"; Rec."LFS UOM")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Packing Material UOM';
                    Caption = 'Packing Material UOM';
                }
                field("LFS Packing Dimension"; Rec."LFS Packing Dimension")
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
                field("LFS v"; Rec."LFS Gross Weight of Pack")
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
                field("Posted Export Shipment"; Rec."LFS Posted Export Shipment")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Posted Export Shipment';
                    Visible = false;
                }
                field("PostedExportShipmentLineNo."; Rec."LFS PostExShipmentLineNo.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Posted Export Shipment Line No';
                    Visible = false;
                }
                field(PostedWhseShipment; Rec."LFS PostedWhseShipment")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Posted Whse Shipment';
                    Visible = false;
                }
                field(PostedWhseShipmentLineNo; Rec."LFS PostWhseShipmentLineNo")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Post Whse Shipment Line No';
                    Visible = false;
                }
                field("LFS Remarks"; Rec."LFS Remarks")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.', Comment = '%';
                }
            }
        }
    }
}