namespace LFSEximModule.LFSPLEXIMModule;

page 72032 "LFS EXIM CommercialPackingList"
{
    ApplicationArea = All;
    Caption = 'EXIM CommercialPackingList';
    PageType = List;
    SourceTable = "LFS EXIM Packing Header";
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "LFS EXIM CommercialPackingCard";
    SourceTableView = where("LFS Type" = const(Commercial));
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Type"; Rec."LFS Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    ApplicationArea = All;
                }
                field("Packing List No."; Rec."LFS Packing List No.")
                {
                    ToolTip = 'Specifies the value of the Packing List No. field.';
                    ApplicationArea = All;
                }
                field("Total Shipment Qty."; Rec."LFS Total Shipment Qty.")
                {
                    ToolTip = 'Specifies the value of the Total Shipment Qty. field.';
                    ApplicationArea = All;
                }
                field(Status; Rec."LFS Status")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                }
                field("Export Shipment / Invoice No."; Rec."LFS ExportShipment/Invoice No.")
                {
                    ToolTip = 'Specifies the value of the Export Shipment / Invoice No. field.';
                    ApplicationArea = All;
                }
                field("Export Shipment / Invoice Date"; Rec."LFS ExportShipment/InvoiceDate")
                {
                    ToolTip = 'Specifies the value of the Export Shipment / Invoice Date field.';
                    ApplicationArea = All;
                }
                field("Shipping Bill No."; Rec."LFS Shipping Bill No.")
                {
                    ToolTip = 'Specifies the value of the Shipping Bill No. field.';
                    ApplicationArea = All;
                }
                field("Shipping Bill Date"; Rec."LFS Shipping Bill Date")
                {
                    ToolTip = 'Specifies the value of the Shipping Bill Date field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}