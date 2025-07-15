// namespace LFSEximModule.LFSPLEXIMModule;

// page 72028 LFSEXIMPostedCustomPackingList
// {
//     ApplicationArea = All;
//     Caption = 'EXIM Posted Custom Packing List';
//     PageType = List;
//     SourceTable = "LFS EXIM Packing Header";
//     UsageCategory = History;
//     Editable = false;
//     CardPageId = "LFSEXIMPostedCustomPackingCard";
//     SourceTableView = where("LFS Type" = const(Custom), "LFS Posted" = const(true));
//     InsertAllowed = false;
//     DeleteAllowed = false;

//     layout
//     {
//         area(content)
//         {
//             repeater(General)
//             {
//                 field("Type"; Rec."LFS Type")
//                 {
//                     ToolTip = 'Specifies the value of the Type field.';
//                     ApplicationArea = All;
//                 }
//                 field("Packing List No."; Rec."LFS Packing List No.")
//                 {
//                     ToolTip = 'Specifies the value of the Packing List No. field.';
//                     ApplicationArea = All;
//                 }
//                 field("Total Shipment Qty."; Rec."LFS Total Shipment Qty.")
//                 {
//                     ToolTip = 'Specifies the value of the Total Shipment Qty. field.';
//                     ApplicationArea = All;
//                 }
//                 field(Status; Rec."LFS Status")
//                 {
//                     ToolTip = 'Specifies the value of the Status field.';
//                     ApplicationArea = All;
//                 }
//                 field("Export Shipment / Invoice No."; Rec."LFS ExportShipment/Invoice No.")
//                 {
//                     ToolTip = 'Specifies the value of the Export Shipment / Invoice No. field.';
//                     ApplicationArea = All;
//                 }
//                 field("Export Shipment / Invoice Date"; Rec."LFS ExportShipment/InvoiceDate")
//                 {
//                     ToolTip = 'Specifies the value of the Export Shipment / Invoice Date field.';
//                     ApplicationArea = All;
//                 }
//                 field("Shipping Bill No."; Rec."LFS Shipping Bill No.")
//                 {
//                     ToolTip = 'Specifies the value of the Shipping Bill No. field.';
//                     ApplicationArea = All;
//                 }
//                 field("Shipping Bill Date"; Rec."LFS Shipping Bill Date")
//                 {
//                     ToolTip = 'Specifies the value of the Shipping Bill Date field.';
//                     ApplicationArea = All;
//                 }
//             }
//         }
//     }
//     procedure GetResult(var EXIMPackingHdr: Record "LFS EXIM Packing Header")
//     begin
//         CurrPage.SetSelectionFilter(EXIMPackingHdr);
//     end;
// }