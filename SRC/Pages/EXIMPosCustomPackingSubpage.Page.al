// namespace LFSEximModule.LFSPLEXIMModule;

// page 72042 LFSEXIMPosCustomPackingSubpage
// {
//     ApplicationArea = All;
//     Caption = 'EXIMPosCustomPackingSubpage';
//     PageType = ListPart;
//     SourceTable = "LFS EXIM Packing Lines";
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
//                 field("Line No."; Rec."LFS Line No.")
//                 {
//                     ToolTip = 'Specifies the value of the Line No. field.';
//                     ApplicationArea = All;
//                 }
//                 field("Item No."; Rec."LFS Item No.")
//                 {
//                     ToolTip = 'Specifies the value of the Item No. field.';
//                     ApplicationArea = All;
//                 }
//                 field("Item Description"; Rec."LFS Item Description")
//                 {
//                     ToolTip = 'Specifies the value of the Item Description field.';
//                     ApplicationArea = All;
//                 }
//                 field("Total Shipment Qty."; Rec."LFS Total Shipment Qty.")
//                 {
//                     ToolTip = 'Specifies the value of the Total Shipment Qty. field.';
//                     ApplicationArea = All;
//                 }
//                 field("Qty. To Pack"; Rec."LFS Qty. To Pack")
//                 {
//                     ToolTip = 'Specifies the value of the Qty. To Pack field.';
//                     ApplicationArea = All;
//                 }
//                 field("Package Type"; Rec."LFS Package Type")
//                 {
//                     ToolTip = 'Specifies the value of the Package Type field.';
//                     ApplicationArea = All;
//                 }
//                 field("From Package No."; Rec."LFS From Package No.")
//                 {
//                     ToolTip = 'Specifies the value of the From Package No. field.';
//                     ApplicationArea = All;
//                 }
//                 field("To Package No."; Rec."LFS To Package No.")
//                 {
//                     ToolTip = 'Specifies the value of the To Package No. field.';
//                     ApplicationArea = All;
//                 }
//                 field("Total No of Packages"; Rec."LFS Total No of Packages")
//                 {
//                     ToolTip = 'Specifies the value of the Total No of Packages field.';
//                     ApplicationArea = All;
//                 }
//                 field("Qty. Per Packages"; Rec."LFS Qty. Per Packages")
//                 {
//                     ToolTip = 'Specifies the value of the Qty. Per Packages field.';
//                     ApplicationArea = All;
//                 }
//                 field("Net Weight / Unit"; Rec."LFS Net Weight / Unit")
//                 {
//                     ToolTip = 'Specifies the value of the Net Weight / Unit field.';
//                     ApplicationArea = All;
//                 }
//                 field("Gross Weight / Unit"; Rec."LFS Gross Weight / Unit")
//                 {
//                     ToolTip = 'Specifies the value of the Gross Weight / Unit field.';
//                     ApplicationArea = All;
//                 }
//                 field(Quantity; Rec."LFS Quantity")
//                 {
//                     ToolTip = 'Specifies the value of the Quantity field.';
//                     ApplicationArea = All;
//                 }
//                 field(Length; Rec."LFS Length")
//                 {
//                     ToolTip = 'Specifies the value of the Length field.';
//                     ApplicationArea = All;
//                 }
//                 field(Height; Rec."LFS Height")
//                 {
//                     ToolTip = 'Specifies the value of the Height field.';
//                     ApplicationArea = All;
//                 }
//                 field(Width; Rec."LFS Width")
//                 {
//                     ToolTip = 'Specifies the value of the Width field.';
//                     ApplicationArea = All;
//                 }
//                 field(Volume; Rec."LFS Volume")
//                 {
//                     ToolTip = 'Specifies the value of the Volume field.';
//                     ApplicationArea = All;
//                 }
//                 field("Total Net Weight"; Rec."LFS Total Net Weight")
//                 {
//                     ToolTip = 'Specifies the value of the Total Net Weight field.';
//                     ApplicationArea = All;
//                 }
//                 field("Total Gross Weight"; Rec."LFS Total Gross Weight")
//                 {
//                     ToolTip = 'Specifies the value of the Total Gross Weight field.';
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
//                 field("Date of Let Export Order"; Rec."LFS Date of Let Export Order")
//                 {
//                     ToolTip = 'Specifies the value of the Date of Let Export Order field.';
//                     ApplicationArea = All;
//                 }
//                 field("Container No."; Rec."LFS Container No.")
//                 {
//                     ToolTip = 'Specifies the value of the Container No. field.';
//                     ApplicationArea = All;
//                 }
//                 field("Container Size"; Rec."LFS Container Size")
//                 {
//                     ToolTip = 'Specifies the value of the Container Size field.';
//                     ApplicationArea = All;
//                 }
//                 field("Trailor No."; Rec."LFS Trailor No.")
//                 {
//                     ToolTip = 'Specifies the value of the Trailor No. field.';
//                     ApplicationArea = All;
//                 }
//                 field("Vehicle No."; Rec."LFS Vehicle No.")
//                 {
//                     ToolTip = 'Specifies the value of the Vehicle No. field.';
//                     ApplicationArea = All;
//                 }
//                 field("Agent Seal No."; Rec."LFS Agent Seal No.")
//                 {
//                     ToolTip = 'Specifies the value of the Agent Seal No. field.';
//                     ApplicationArea = All;
//                 }
//                 field("RFID E-Seal Nos."; Rec."LFS RFID E-Seal Nos.")
//                 {
//                     ToolTip = 'Specifies the value of the RFID E-Seal Nos. field.';
//                     ApplicationArea = All;
//                 }
//                 field("Rotation No."; Rec."LFS Rotation No.")
//                 {
//                     ToolTip = 'Specifies the value of the Rotation No. field.';
//                     ApplicationArea = All;
//                 }
//                 field("Shipping Line"; Rec."LFS Shipping Line")
//                 {
//                     ToolTip = 'Specifies the value of the Shipping Line field.';
//                     ApplicationArea = All;
//                 }
//                 field("Vessel / Flight Details"; Rec."LFS Vessel / Flight Details")
//                 {
//                     ToolTip = 'Specifies the value of the Vessel / Flight Details field.';
//                     ApplicationArea = All;
//                 }
//                 field(Carriage; Rec."LFS Carriage")
//                 {
//                     ToolTip = 'Specifies the value of the Carriage field.';
//                     ApplicationArea = All;
//                 }
//                 field(ETD; Rec."LFS ETD")
//                 {
//                     ToolTip = 'Specifies the value of the ETD field.';
//                     ApplicationArea = All;
//                 }
//                 field(ETA; Rec."LFS ETA")
//                 {
//                     ToolTip = 'Specifies the value of the ETA field.';
//                     ApplicationArea = All;
//                 }
//                 field("Date of Stuffing"; Rec."LFS Date of Stuffing")
//                 {
//                     ToolTip = 'Specifies the value of the Date of Stuffing field.';
//                     ApplicationArea = All;
//                 }
//                 field("Port Cut Off"; Rec."LFS Port Cut Off")
//                 {
//                     ToolTip = 'Specifies the value of the Port Cut Off field.';
//                     ApplicationArea = All;
//                 }
//                 field("Forwarder No."; Rec."LFS Forwarder No.")
//                 {
//                     ToolTip = 'Specifies the value of the Forwarder No. field.';
//                     ApplicationArea = All;
//                 }
//                 field("CHA No."; Rec."LFS CHA No.")
//                 {
//                     ToolTip = 'Specifies the value of the CHA No. field.';
//                     ApplicationArea = All;
//                 }
//                 field("Transporter No."; Rec."LFS Transporter No.")
//                 {
//                     ToolTip = 'Specifies the value of the Transporter No. field.';
//                     ApplicationArea = All;
//                 }
//                 field("QC Vendor No."; Rec."LFS QC Vendor No.")
//                 {
//                     ToolTip = 'Specifies the value of the QC Vendor No. field.';
//                     ApplicationArea = All;
//                 }
//                 field("BL No."; Rec."LFS BL No.")
//                 {
//                     ToolTip = 'Specifies the value of the BL No. field.';
//                     ApplicationArea = All;
//                 }
//                 field("BL Date"; Rec."LFS BL Date")
//                 {
//                     ToolTip = 'Specifies the value of the BL Date field.';
//                     ApplicationArea = All;
//                 }
//                 field("Parent Line No."; Rec."LFS Parent Line No.")
//                 {
//                     ToolTip = 'Specifies the value of the Parent Line No. field.';
//                     ApplicationArea = All;
//                 }
//                 field("W.T of Each Pallet"; Rec."LFS W.T of Each Pallet")
//                 {
//                     ToolTip = 'Specifies the value of the W.T of Each Pallet field.';
//                     ApplicationArea = All;
//                 }
//                 field("Tare W.T of each Bag(KG)"; Rec."LFS Tare W.T of each Bag(KG)")
//                 {
//                     ToolTip = 'Specifies the value of the Tare W.T of each Bag(KG) field.';
//                     ApplicationArea = All;
//                 }
//                 field("Total Tare W.T (KG)"; Rec."LFS Total Tare W.T (KG)")
//                 {
//                     ToolTip = 'Specifies the value of the Total Tare W.T (KG) field.';
//                     ApplicationArea = All;
//                 }
//                 field("From Pallet"; Rec."LFS From Pallet")
//                 {
//                     ToolTip = 'Specifies the value of the From Pallet field.';
//                     ApplicationArea = All;
//                 }
//                 field("To Pallet"; Rec."LFS To Pallet")
//                 {
//                     ToolTip = 'Specifies the value of the To Pallet field.';
//                     ApplicationArea = All;
//                 }
//                 field("Total No. of Pallets"; Rec."LFS Total No. of Pallets")
//                 {
//                     ToolTip = 'Specifies the value of the Total No. of Pallets field.';
//                     ApplicationArea = All;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         MainLine := Rec."LFS Parent Line No." = 0;
//         MainIndent := Rec."LFS Indentation";
//     end;

//     trigger OnOpenPage()
//     begin
//         Clear(MainLine);
//         Clear(MainIndent);
//     end;

//     var
//         MainLine: Boolean;
//         MainIndent: Integer;
// }