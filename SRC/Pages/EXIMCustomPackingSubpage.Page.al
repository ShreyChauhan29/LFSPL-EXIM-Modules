// namespace LFSEximModule.LFSPLEXIMModule;

// page 72043 "LFS EXIM Custom PackingSubpage"
// {
//     ApplicationArea = All;
//     Caption = 'EXIM Custom PackingSubpage';
//     PageType = ListPart;
//     SourceTable = "LFS EXIM Packing Lines";
//     DelayedInsert = true;
//     AutoSplitKey = true;
//     MultipleNewLines = true;
//     RefreshOnActivate = true;

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
//                     Editable = false;
//                 }
//                 field("Packing List No."; Rec."LFS Packing List No.")
//                 {
//                     ToolTip = 'Specifies the value of the Packing List No. field.';
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Line No."; Rec."LFS Line No.")
//                 {
//                     ToolTip = 'Specifies the value of the Line No. field.';
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Shipment Document No."; Rec."LFS Shipment Document No.")
//                 {
//                     ToolTip = 'Specifies the value of the Shipment Document No. field.';
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Shipment Document Line No."; Rec."LFS Shipment Document Line No.")
//                 {
//                     ToolTip = 'Specifies the value of the Shipment Document Line No. field.';
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Item No."; Rec."LFS Item No.")
//                 {
//                     ToolTip = 'Specifies the value of the Item No. field.';
//                     ApplicationArea = All;
//                     Editable = false;
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
//                     Editable = false;
//                 }

//                 field("Package Type"; Rec."LFS Package Type")
//                 {
//                     Caption = 'Marks & Container No.';
//                     ToolTip = 'Specifies the value of the Package Type field.';
//                     ApplicationArea = All;
//                 }
//                 field(Quantity; Rec."LFS Quantity")
//                 {
//                     ToolTip = 'Specifies the value of the Quantity field.';
//                     ApplicationArea = All;
//                 }
//                 field("Parent Line No."; Rec."LFS Parent Line No.")
//                 {
//                     ToolTip = 'Specifies the value of the Parent Line No. field.';
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Pallet Size"; Rec."LFS Pallet Size")
//                 {
//                     Caption = 'No. & KInd Of PKG';
//                     ToolTip = 'Specifies the value of the Pallet Size field.';
//                     ApplicationArea = All;
//                 }
//                 field("Bag Size"; Rec."LFS Bag Size")
//                 {
//                     Caption = 'Description of Goods';
//                     ToolTip = 'Specifies the value of the Bag Size field.';
//                     ApplicationArea = All;
//                 }
//                 field("From Pallet"; Rec."LFS From Pallet")
//                 {
//                     Caption = 'From Pallet';
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the From Pallet';
//                 }
//                 field("To Pallet"; Rec."LFS To Pallet")
//                 {
//                     Caption = 'To Pallet';
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the To Pallet';
//                 }
//                 field("Total No. of Pallets"; Rec."LFS Total No. of Pallets")
//                 {
//                     Caption = 'Total No. of Pallets';
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the Total No. of Pallets';
//                 }
//                 field("W.T of Each Pallet"; Rec."LFS W.T of Each Pallet")
//                 {
//                     Caption = 'W.T of Each Pallet';
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the W.T of Each Pallet';
//                 }
//                 field("Total Weight of Pallet"; Rec."LFS Total Weight of Pallet")
//                 {
//                     Caption = 'Total Weight of Pallet';
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the Total Weight of Pallet';
//                 }
//                 field("Qty. To Pack"; Rec."LFS Qty. To Pack")
//                 {
//                     Caption = 'Qty. To Pack';
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the Qty. To Pack';
//                 }
//                 field("From Package No."; Rec."LFS From Package No.")
//                 {
//                     Caption = 'From Package No.';
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the From Package No.';
//                 }
//                 field("To Package No."; Rec."LFS To Package No.")
//                 {
//                     Caption = 'To Package No.';
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the To Package No.';
//                 }
//                 field("Qty. Per Packages"; Rec."LFS Qty. Per Packages")
//                 {
//                     Caption = 'Qty. Per Packages';
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the Qty. Per Packages';
//                 }
//                 field("Total No of Packages"; Rec."LFS Total No of Packages")
//                 {
//                     Caption = 'Total No of Packages';
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the Total No of Packages';
//                 }
//                 field("Net Weight / Unit"; Rec."LFS Net Weight / Unit")
//                 {
//                     Caption = 'Net Weight / Unit';
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the Net Weight / Unit';
//                 }
//                 field("Gross Weight / Unit"; Rec."LFS Gross Weight / Unit")
//                 {
//                     Caption = 'Gross Weight / Unit';
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the Gross Weight / Unit';
//                 }
//                 field("Total Net Weight"; Rec."LFS Total Net Weight")
//                 {
//                     Caption = 'Total Net Weight';
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the Total Net Weight';
//                 }
//                 field("Total Gross Weight"; Rec."LFS Total Gross Weight")
//                 {
//                     Caption = 'Total Gross Weight';
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the Total Gross Weight';
//                 }
//                 field("Lot No. From to To"; Rec."LFS Lot No. From to To")
//                 {
//                     Caption = 'Lot No. From to To';
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the Lot No. From to To';
//                 }
//                 field("Lot No."; Rec."LFS Lot No.")
//                 {
//                     Caption = 'Lot No.';
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the Lot No.';
//                 }
//                 field("Lot Entry No."; Rec."LFS Lot Entry No.")
//                 {
//                     Caption = 'Lot Entry No.';
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the Lot Entry No.';
//                 }
//                 field("Tare W.T of each Bag(KG)"; Rec."LFS Tare W.T of each Bag(KG)")
//                 {
//                     Caption = 'Tare W.T of each Bag(KG)';
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the Tare W.T of each Bag(KG)';
//                 }
//                 field("Total Tare W.T (KG)"; Rec."LFS Total Tare W.T (KG)")
//                 {
//                     Caption = 'Total Tare W.T (KG)';
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the Total Tare W.T (KG)';
//                 }
//                 field("MFG Date"; Rec."LFS MFG Date")
//                 {
//                     Caption = 'MFG Date';
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the MFG Date';
//                 }
//                 field("Container Size"; Rec."LFS Container Size")
//                 {
//                     Caption = 'Container Size';
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the Container Size';
//                 }
//             }
//         }
//     }
//     actions
//     {
//         area(Processing)
//         {
//             action("Split Line")
//             {
//                 ApplicationArea = all;
//                 Image = Splitlines;
//                 Ellipsis = true;
//                 ToolTip = 'Specifies the Split Line';
//                 trigger OnAction()
//                 begin
//                     Rec.TestField("LFS Parent Line No.", 0);

//                     EXIMPackingLines.Reset();
//                     EXIMPackingLines.SetRange(EXIMPackingLines."LFS Type", Rec."LFS Type");
//                     EXIMPackingLines.SetRange(EXIMPackingLines."LFS Packing List No.", Rec."LFS Packing List No.");
//                     EXIMPackingLines.SetRange("LFS Parent Line No.", Rec."LFS Line No.");
//                     if EXIMPackingLines.FindLast() then
//                         LineNo := EXIMPackingLines."LFS Line No." + 1
//                     else
//                         LineNo := Rec."LFS Line No." + 1;

//                     EXIMPackingLines.Init();
//                     EXIMPackingLines.TransferFields(Rec);
//                     EXIMPackingLines."LFS Line No." := LineNo;
//                     EXIMPackingLines."LFS Parent Line No." := Rec."LFS Line No.";
//                     EXIMPackingLines."LFS Indentation" := 2;
//                     EXIMPackingLines."LFS Quantity" := 0;
//                     EXIMPackingLines.Insert();
//                 end;
//             }
//         }
//     }

//     trigger OnOpenPage()
//     begin
//         Clear(MainIndent);
//         Clear(MainLine);
//     end;

//     trigger OnAfterGetRecord()
//     begin
//         MainLine := Rec."LFS Parent Line No." = 0;
//         MainIndent := Rec."LFS Indentation";
//         Rec.UpadateParentLineTotal();
//     end;

//     trigger OnAfterGetCurrRecord()
//     begin
//         Rec.UpadateParentLineTotal();
//     end;

//     var
//         EXIMPackingLines: Record "LFS EXIM Packing Lines";
//         MainLine: Boolean;
//         LineNo: Integer;
//         MainIndent: Integer;

//     procedure PageUpadateParentLineTotal();
//     var
//         EXIMPackingLines1: Record "LFS EXIM Packing Lines";
//         total: array[11] of Decimal;
//     begin
//         Total[1] := 0;
//         Total[2] := 0;
//         Total[3] := 0;
//         Total[4] := 0;
//         Total[5] := 0;
//         Total[6] := 0;
//         Total[7] := 0;
//         Total[8] := 0;
//         Total[9] := 0;
//         Total[10] := 0;
//         Total[11] := 0;

//         EXIMPackingLines1.Reset();
//         EXIMPackingLines1.SetFilter("LFS Parent Line No.", '<>%1', 0);
//         EXIMPackingLines1.SetRange("LFS Shipment Document Line No.", Rec."LFS Shipment Document Line No.");
//         EXIMPackingLines1.SetRange("LFS Shipment Document No.", Rec."LFS Shipment Document No.");
//         EXIMPackingLines1.SetRange("LFS Packing List No.", Rec."LFS Packing List No.");
//         if EXIMPackingLines1.Findset() then
//             repeat
//                 Total[2] += EXIMPackingLines1."LFS Quantity";
//                 Total[6] += EXIMPackingLines1."LFS Total No. of Pallets";
//             until EXIMPackingLines1.Next() = 0;

//         EXIMPackingLines1.SetFilter("LFS Parent Line No.", '%1', 0);
//         EXIMPackingLines1.SetRange("LFS Shipment Document Line No.", Rec."LFS Shipment Document Line No.");
//         EXIMPackingLines1.SetRange("LFS Shipment Document No.", Rec."LFS Shipment Document No.");
//         EXIMPackingLines1.SetRange("LFS Packing List No.", Rec."LFS Packing List No.");
//         if EXIMPackingLines1.FindFirst() then begin
//             EXIMPackingLines1."LFS Quantity" := Total[2];
//             EXIMPackingLines1."LFS Total No. of Pallets" := Total[6];
//             EXIMPackingLines1.Modify();
//         end;
//     end;
// }