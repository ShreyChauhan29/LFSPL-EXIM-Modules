// namespace LFSEximModule.LFSPLEXIMModule;
// using Microsoft.Inventory.Item;
// using Microsoft.Sales.History;
// using Microsoft.Purchases.Vendor;
// using Microsoft.Foundation.UOM;
// using Microsoft.Inventory.Ledger;
// table 72028 "LFS EXIM Packing Lines"
// {
//     Caption = 'EXIM Packing Lines';
//     DataClassification = CustomerContent;

//     fields
//     {
//         field(1; "LFS Type"; Option)
//         {
//             Caption = 'Type';
//             OptionMembers = " ",Custom,Commercial;
//             OptionCaption = ' ,Custom,Commercial';
//             DataClassification = CustomerContent;
//         }
//         field(2; "LFS Packing List No."; Code[20])
//         {
//             Caption = 'Packing List No.';
//             DataClassification = CustomerContent;
//         }
//         field(4; "LFS Line No."; Integer)
//         {
//             Caption = 'Line No.';
//             DataClassification = CustomerContent;
//         }
//         field(5; "LFS Item No."; Code[20])
//         {
//             Caption = 'Item No.';
//             TableRelation = Item."No.";
//             DataClassification = CustomerContent;

//             trigger OnValidate()
//             begin
//                 if xRec."LFS Item No." <> Rec."LFS Item No." then
//                     if "LFS Item No." = '' then begin
//                         "LFS Item Description" := '';
//                         "LFS Net Weight / Unit" := 0;
//                         "LFS Gross Weight / Unit" := 0;
//                         "LFS Length" := 0;
//                         "LFS Height" := 0;
//                         "LFS Width" := 0;
//                         "LFS Volume" := 0;
//                         "LFS Total Net Weight" := 0;
//                         "LFS Total Gross Weight" := 0;
//                     end else begin
//                         Item.Get("LFS Item No.");
//                         "LFS Item Description" := Item.Description;
//                         "LFS Net Weight / Unit" := Item."Net Weight";
//                         "LFS Gross Weight / Unit" := Item."Gross Weight";
//                         if ItemUOM.Get("LFS Item No.", "LFS Unit of Measure Code") then begin
//                             "LFS Length" := ItemUOM.Length;
//                             "LFS Height" := ItemUOM.Height;
//                             "LFS Width" := ItemUOM.Width;
//                             "LFS Volume" := "LFS Length" * "LFS Height" * "LFS Width" / 1000000;
//                         end;
//                         "LFS Total Net Weight" := "LFS Total Shipment Qty." * "LFS Net Weight / Unit";
//                         "LFS Total Gross Weight" := "LFS Total Shipment Qty." * "LFS Gross Weight / Unit";
//                     end;
//             end;
//         }
//         field(6; "LFS Item Description"; Text[100])
//         {
//             Caption = 'Item Description';
//             DataClassification = CustomerContent;
//         }
//         field(7; "LFS Total Shipment Qty."; Decimal)
//         {
//             Caption = 'Total Shipment Qty.';
//             DataClassification = CustomerContent;
//         }
//         field(8; "LFS From Package No."; Integer)
//         {
//             Caption = 'From Package No.';
//             DataClassification = CustomerContent;
//             trigger OnValidate()
//             begin
//                 UpadateParentLineTotal();
//             end;
//         }
//         field(9; "LFS To Package No."; Integer)
//         {
//             Caption = 'To Package No.';
//             DataClassification = CustomerContent;

//             trigger OnValidate()
//             begin
//                 if "LFS To Package No." <> 0 then begin
//                     TestField("LFS From Package No.");
//                     Validate("LFS Total No of Packages", ("LFS To Package No." - "LFS From Package No.") + 1);
//                 end else
//                     Validate("LFS Total No of Packages", 0);
//                 UpadateParentLineTotal();
//             end;
//         }
//         field(10; "LFS Total No of Packages"; Integer)
//         {
//             Caption = 'Total No of Packages';
//             DataClassification = CustomerContent;

//             trigger OnValidate()
//             begin
//                 Validate("LFS Total Tare W.T (KG)", "LFS Total No of Packages" * "LFS Tare W.T of each Bag(KG)");
//                 UpadateParentLineTotal();
//             end;
//         }
//         field(11; "LFS Qty. Per Packages"; Decimal)
//         {
//             Caption = 'Qty. Per Packages';
//             DataClassification = CustomerContent;
//         }
//         field(12; "LFS Net Weight / Unit"; Decimal)
//         {
//             Caption = 'Net Weight / Unit';
//             DataClassification = CustomerContent;
//         }
//         field(13; "LFS Gross Weight / Unit"; Decimal)
//         {
//             Caption = 'Gross Weight / Unit';
//             DataClassification = CustomerContent;
//         }
//         field(14; "LFS Quantity"; Decimal)
//         {
//             Caption = 'Quantity';
//             DataClassification = CustomerContent;

//             trigger OnValidate()
//             var
//                 RecEximLine: Record "LFS EXIM Packing Lines";
//                 RecSalesShipLine: Record "Sales Shipment Line";
//                 VarQty: Decimal;
//                 Text001Lbl: Label 'Total Quantity must be same as Total Shipment Qty';
//             begin
//                 Clear(VarQty);
//                 RecSalesShipLine.Reset();
//                 RecSalesShipLine.SetRange("Document No.", Rec."LFS Shipment Document No.");
//                 RecSalesShipLine.SetRange("Line No.", Rec."LFS Shipment Document Line No.");
//                 if RecSalesShipLine.FindFirst() then begin
//                     RecEximLine.Reset();
//                     RecEximLine.SetRange("LFS Shipment Document No.", Rec."LFS Shipment Document No.");
//                     RecEximLine.SetRange("LFS Shipment Document Line No.", Rec."LFS Shipment Document Line No.");
//                     RecEximLine.SetFilter("LFS Parent Line No.", '<>%1', 0);
//                     if RecEximLine.Findset() then
//                         repeat
//                             VarQty += RecEximLine."LFS Quantity";
//                         until RecEximLine.Next() = 0;
//                     if (Rec."LFS Quantity" + VarQty) > RecSalesShipLine.Quantity then
//                         Error('You cannot exceed the quantity with respect to Sales Shipment Qty.');
//                 end;
//                 "LFS Total Gross Weight" := "LFS Quantity" + "LFS Total Tare W.T (KG)" + "LFS Total No. of Pallets" * "LFS W.T of Each Pallet";
//                 if (Total[2] + "LFS Quantity") <= "LFS Total Shipment Qty." then begin
//                     if "LFS Quantity" <> 0 then
//                         Total[2] := Total[2] + "LFS Quantity"
//                     else
//                         Total[2] := Total[2] + "LFS Quantity";
//                 end else
//                     Error(Text001Lbl);
//             end;
//         }
//         field(15; "LFS Length"; Decimal)
//         {
//             Caption = 'Length';
//             DataClassification = CustomerContent;
//         }
//         field(16; "LFS Height"; Decimal)
//         {
//             Caption = 'Height';
//             DataClassification = CustomerContent;
//         }
//         field(17; "LFS Width"; Decimal)
//         {
//             Caption = 'Width';
//             DataClassification = CustomerContent;
//         }
//         field(18; "LFS Volume"; Decimal)
//         {
//             Caption = 'Volume';
//             DataClassification = CustomerContent;
//         }
//         field(19; "LFS Total Net Weight"; Decimal)
//         {
//             Caption = 'Total Net Weight';
//             DataClassification = CustomerContent;
//         }
//         field(20; "LFS Total Gross Weight"; Decimal)
//         {
//             Caption = 'Total Gross Weight';
//             DataClassification = CustomerContent;

//             trigger OnValidate()
//             var
//                 EXIMPackingLines: Record "LFS EXIM Packing Lines";
//                 TotalGrWt: Decimal;
//             begin
//                 if "LFS Parent Line No." <> 0 then begin
//                     TotalGrWt := 0;
//                     EXIMPackingLines.Reset();
//                     EXIMPackingLines.SetRange(EXIMPackingLines."LFS Type", "LFS Type");
//                     EXIMPackingLines.SETRANGE(EXIMPackingLines."LFS Packing List No.", "LFS Packing List No.");
//                     EXIMPackingLines.SETRANGE(EXIMPackingLines."LFS Parent Line No.", "LFS Parent Line No.");
//                     EXIMPackingLines.SETFILTER(EXIMPackingLines."LFS Line No.", '<>%1', "LFS Line No.");
//                     if EXIMPackingLines.Findset() then
//                         repeat
//                             TotalGrWt += EXIMPackingLines."LFS Total Gross Weight";
//                         UNTIL EXIMPackingLines.Next() = 0;
//                     EXIMPackingLines.Reset();
//                     EXIMPackingLines.SETRANGE(EXIMPackingLines."LFS Type", "LFS Type");
//                     EXIMPackingLines.SETRANGE(EXIMPackingLines."LFS Packing List No.", "LFS Packing List No.");
//                     EXIMPackingLines.SETRANGE(EXIMPackingLines."LFS Line No.", "LFS Parent Line No.");
//                     if EXIMPackingLines.FINDFIRST() then begin
//                         EXIMPackingLines."LFS Total Gross Weight" := TotalGrWt + "LFS Total Gross Weight";
//                         EXIMPackingLines.MODIFY();
//                     end;
//                 end;
//             end;
//         }
//         field(21; "LFS Shipping Bill No."; Code[50])
//         {
//             Caption = 'Shipping Bill No.';
//             DataClassification = CustomerContent;
//         }
//         field(22; "LFS Shipping Bill Date"; Date)
//         {
//             Caption = 'Shipping Bill Date';
//             DataClassification = CustomerContent;
//         }
//         field(23; "LFS Date of Let Export Order"; Date)
//         {
//             Caption = 'Date of Let Export Order';
//             DataClassification = CustomerContent;
//         }
//         field(24; "LFS Container No."; Code[30])
//         {
//             Caption = 'Container No.';
//             DataClassification = CustomerContent;
//         }
//         field(25; "LFS Container Date"; Date)
//         {
//             Caption = 'Container Date';
//             DataClassification = CustomerContent;
//         }
//         field(26; "LFS Trailor No."; Code[30])
//         {
//             Caption = 'Trailor No.';
//             DataClassification = CustomerContent;
//         }
//         field(27; "LFS Vehicle No."; Code[30])
//         {
//             Caption = 'Vehicle No.';
//             DataClassification = CustomerContent;
//         }
//         field(28; "LFS Agent Seal No."; Code[30])
//         {
//             Caption = 'Agent Seal No.';
//             DataClassification = CustomerContent;
//         }
//         field(29; "LFS RFID E-Seal Nos."; Code[30])
//         {
//             Caption = 'RFID E-Seal Nos.';
//             DataClassification = CustomerContent;
//         }
//         field(30; "LFS Rotation No."; Code[30])
//         {
//             Caption = 'Rotation No.';
//             DataClassification = CustomerContent;
//         }
//         field(31; "LFS Shipping Line"; Code[20])
//         {
//             Caption = 'Shipping Line';
//             TableRelation = "LFS EXIM Shipping Line";
//             DataClassification = CustomerContent;
//         }
//         field(32; "LFS Vessel / Flight Details"; Text[30])
//         {
//             Caption = 'Vessel / Flight Details';
//             DataClassification = CustomerContent;
//         }
//         field(33; "LFS Carriage"; Option)
//         {
//             Caption = 'Carriage';
//             DataClassification = CustomerContent;
//             OptionMembers = " ","By Sea","By Air","By Rail","By Road",Other;
//             OptionCaption = ' ,By Sea,By Air,By Rail,By Road,Other';
//         }
//         field(34; "LFS ETD"; Date)
//         {
//             Caption = 'ETD';
//             DataClassification = CustomerContent;
//         }
//         field(35; "LFS ETA"; Date)
//         {
//             Caption = 'ETA';
//             DataClassification = CustomerContent;
//         }
//         field(36; "LFS Date of Stuffing"; Date)
//         {
//             Caption = 'Date of Stuffing';
//             DataClassification = CustomerContent;
//         }
//         field(37; "LFS Port Cut Off"; Date)
//         {
//             Caption = 'Port Cut Off';
//             DataClassification = CustomerContent;
//         }
//         field(38; "LFS Forwarder No."; Code[20])
//         {
//             Caption = 'Forwarder No.';
//             TableRelation = Vendor;
//             DataClassification = CustomerContent;
//         }
//         field(39; "LFS CHA No."; Code[20])
//         {
//             Caption = 'CHA No.';
//             TableRelation = Vendor;
//             DataClassification = CustomerContent;
//         }
//         field(40; "LFS Transporter No."; Code[20])
//         {
//             Caption = 'Transporter No.';
//             TableRelation = Vendor;
//             DataClassification = CustomerContent;
//         }
//         field(41; "LFS QC Vendor No."; Code[20])
//         {
//             Caption = 'QC Vendor No.';
//             TableRelation = Vendor;
//             DataClassification = CustomerContent;
//         }
//         field(42; "LFS BL No."; Code[20])
//         {
//             Caption = 'BL No.';
//             TableRelation = Vendor;
//             DataClassification = CustomerContent;
//         }
//         field(43; "LFS BL Date"; Date)
//         {
//             Caption = 'BL Date';
//             DataClassification = CustomerContent;
//         }
//         field(44; "LFS Shipment Document No."; Code[20])
//         {
//             Caption = 'Shipment Document No.';
//             DataClassification = CustomerContent;
//         }
//         field(45; "LFS Shipment Document Line No."; Integer)
//         {
//             Caption = 'Shipment Document Line No.';
//             DataClassification = CustomerContent;
//         }
//         field(46; "LFS Unit of Measure Code"; Code[20])
//         {
//             Caption = 'Unit of Measure Code';
//             TableRelation = "Unit of Measure".Code;
//             DataClassification = CustomerContent;
//         }
//         field(47; "LFS CommercialPackingLineExist"; Boolean)
//         {
//             Caption = 'Commercial Packing Line Exists';
//             FieldClass = FlowField;
//             CalcFormula = exist("LFS EXIM Packing Lines" where("LFS Type" = const(Commercial),
//                                                             "LFS Custom Packing No." = field("LFS Packing List No."),
//                                                             "LFS Custom Packing Line No." = field("LFS Line No.")));
//             Editable = false;
//         }
//         field(48; "LFS Custom Packing No."; Code[20])
//         {
//             Caption = 'Custom Packing No.';
//             DataClassification = CustomerContent;
//         }
//         field(49; "LFS Custom Packing Line No."; Integer)
//         {
//             Caption = 'Custom Packing Line No.';
//             DataClassification = CustomerContent;
//         }
//         field(50; "LFS Parent Line No."; Integer)
//         {
//             Caption = 'Parent Line No.';
//             DataClassification = CustomerContent;
//         }
//         field(51; "LFS Qty. To Pack"; Decimal)
//         {
//             Caption = 'Qty. To Pack';
//             DataClassification = CustomerContent;
//         }
//         field(52; "LFS Indentation"; Integer)
//         {
//             Caption = 'Indentation';
//             InitValue = 0;
//             DataClassification = CustomerContent;
//         }
//         field(53; "LFS Lot No."; Code[100])
//         {
//             Caption = 'Lot No.';
//             DataClassification = CustomerContent;
//             trigger OnValidate()
//             begin
//                 "LFS Quantity" := 0;
//                 if "LFS Parent Line No." <> 0 then begin
//                     ItemLedgerEntry.Reset();
//                     ItemLedgerEntry.SETRANGE("Document No.", "LFS Shipment Document No.");
//                     ItemLedgerEntry.SETRANGE("Document Line No.", "LFS Shipment Document Line No.");
//                     ItemLedgerEntry.SETRANGE("Lot No.", "LFS Lot No.");
//                     if ItemLedgerEntry.Findset() then
//                         repeat
//                             Rec."LFS Quantity" += ABS(ItemLedgerEntry.Quantity);
//                         UNTIL ItemLedgerEntry.Next() = 0;
//                 end;
//             end;
//         }
//         field(54; "LFS Lot Entry No."; Integer)
//         {
//             Caption = 'Lot Entry No.';
//             DataClassification = CustomerContent;
//             TableRelation = "Item Ledger Entry"."Entry No." where("Document No." = field("LFS Shipment Document No."),
//                                                                     "Document Line No." = field("LFS Shipment Document Line No."));
//             trigger OnValidate()
//             var
//                 EXIMPackingLines: Record "LFS EXIM Packing Lines";
//             begin
//                 ItemLedgerEntry.Reset();
//                 if ItemLedgerEntry.GET("LFS Lot Entry No.") then begin
//                     EXIMPackingLines.Reset();
//                     EXIMPackingLines.SETRANGE(EXIMPackingLines."LFS Type", "LFS Type");
//                     EXIMPackingLines.SETRANGE(EXIMPackingLines."LFS Packing List No.", "LFS Packing List No.");
//                     EXIMPackingLines.SETFILTER(EXIMPackingLines."LFS Line No.", '<>%1', "LFS Line No.");
//                     EXIMPackingLines.SETRANGE(EXIMPackingLines."LFS Lot Entry No.", "LFS Lot Entry No.");
//                     if not EXIMPackingLines.IsEmpty() then
//                         ERROR('Lot No. already exists in another line');
//                     VALIDATE("LFS Lot No.", ItemLedgerEntry."Lot No.");
//                 end else begin
//                     "LFS Lot No." := '';
//                     "LFS Quantity" := 0;
//                 end
//             end;
//         }
//         field(55; "LFS From Pallet"; Integer)
//         {
//             Caption = 'From Pallet';
//             DataClassification = CustomerContent;
//             trigger OnValidate()
//             begin
//                 VALIDATE("LFS Total Gross Weight", "LFS Quantity" + "LFS Total Tare W.T (KG)" + ("LFS Total No. of Pallets" * "LFS W.T of Each Pallet"));
//                 UpadateParentLineTotal();
//             end;
//         }
//         field(56; "LFS To Pallet"; Integer)
//         {
//             Caption = 'To Pallet';
//             DataClassification = CustomerContent;
//             trigger OnValidate()
//             begin
//                 if "LFS To Pallet" <> 0 then begin
//                     TESTFIELD("LFS From pallet");
//                     "LFS Total No. of Pallets" := ("LFS To Pallet" - "LFS From pallet") + 1;
//                     "LFS Total Tare W.T (KG)" := "LFS Tare W.T of each Bag(KG)" * "LFS Total No of Packages";
//                     EXIMPackingHeader.Reset();
//                     EXIMPackingHeader.GET("LFS Type", "LFS Packing List No.");
//                     "LFS Total Gross Weight" := "LFS Quantity" + "LFS Total Tare W.T (KG)" + ("LFS Total No. of Pallets" * "LFS W.T of Each Pallet");

//                 end
//                 else
//                     "LFS Total No. of Pallets" := 0;

//                 VALIDATE("LFS Total Gross Weight", "LFS Quantity" + "LFS Total Tare W.T (KG)" + ("LFS Total No. of Pallets" * "LFS W.T of Each Pallet"));
//                 UpadateParentLineTotal();
//             end;
//         }
//         field(57; "LFS Total No. of Pallets"; Integer)
//         {
//             Caption = 'Total No. of Pallets';
//             DataClassification = CustomerContent;
//             trigger OnValidate()
//             begin
//                 VALIDATE("LFS Total Gross Weight", "LFS Quantity" + "LFS Total Tare W.T (KG)" + ("LFS Total No. of Pallets" * "LFS W.T of Each Pallet"));
//                 UpadateParentLineTotal();
//             end;
//         }
//         field(58; "LFS Tare W.T of each Bag(KG)"; Decimal)
//         {
//             Caption = 'Tare W.T of each Bag(KG)';
//             DataClassification = CustomerContent;
//             trigger OnValidate()
//             begin
//                 if "LFS Tare W.T of each Bag(KG)" <> 0 then begin
//                     "LFS Total Tare W.T (KG)" := "LFS Tare W.T of each Bag(KG)" * "LFS Total No of Packages";
//                     EXIMPackingHeader.Reset();
//                     EXIMPackingHeader.GET("LFS Type", "LFS Packing List No.");
//                     "LFS Total Gross Weight" := "LFS Quantity" + "LFS Total Tare W.T (KG)" + ("LFS Total No. of Pallets" * "LFS W.T of Each Pallet");
//                 end
//                 else
//                     "LFS Total Tare W.T (KG)" := 0;
//                 VALIDATE("LFS Total Gross Weight", "LFS Quantity" + "LFS Total Tare W.T (KG)" + ("LFS Total No. of Pallets" * "LFS W.T of Each Pallet"));
//             end;
//         }
//         field(59; "LFS Total Tare W.T (KG)"; Decimal)
//         {
//             Caption = 'Total Tare W.T (KG)';
//             DataClassification = CustomerContent;
//             trigger OnValidate()
//             begin
//                 "LFS Total Gross Weight" := "LFS Quantity" + "LFS Total Tare W.T (KG)" + ("LFS Total No. of Pallets" * "LFS W.T of Each Pallet");
//                 UpadateParentLineTotal();
//             end;
//         }
//         field(60; "LFS MFG Date"; Code[20])
//         {
//             Caption = 'MFG Date';
//             DataClassification = CustomerContent;
//         }
//         field(61; "LFS W.T of Each Pallet"; Decimal)
//         {
//             Caption = 'W.T of Each Pallet';
//             DataClassification = CustomerContent;
//             trigger OnValidate()
//             begin
//                 VALIDATE("LFS Total Gross Weight", "LFS Quantity" + "LFS Total Tare W.T (KG)" + ("LFS Total No. of Pallets" * "LFS W.T of Each Pallet"));
//             end;
//         }
//         field(62; "LFS Lot No. From to To"; Text[100])
//         {
//             Caption = 'Lot No. From to To';
//             DataClassification = CustomerContent;
//         }
//         field(63; "LFS Total Weight of Pallet"; Decimal)
//         {
//             Caption = 'Total Weight of Pallet';
//             DataClassification = CustomerContent;
//         }
//         field(64; "LFS Pallet Size"; Text[200])
//         {
//             Caption = 'Pallet Size';
//             DataClassification = CustomerContent;
//         }
//         field(65; "LFS Bag Size"; Text[200])
//         {
//             Caption = 'Bag Size';
//             DataClassification = CustomerContent;
//         }
//         field(66; "LFS Packing Date"; Date)
//         {
//             Caption = 'Packing Date';
//             DataClassification = CustomerContent;
//         }
//         field(67; "LFS Delivery Challan No."; Code[20])
//         {
//             Caption = 'Delivery Challan No.';
//             DataClassification = CustomerContent;
//         }
//         field(68; "LFS Package Type"; Code[100])
//         {
//             Caption = 'Package Type';
//             DataClassification = CustomerContent;
//         }
//         field(69; "LFS Container Size"; Code[30])
//         {
//             Caption = 'Container Size';
//             DataClassification = CustomerContent;
//         }
//     }

//     keys
//     {
//         key(Key1; "LFS Type", "LFS Line No.", "LFS Packing List No.")
//         {
//             Clustered = true;
//         }
//     }

//     trigger OnDelete()
//     begin
//         EXIMPackingLines.Reset();
//         EXIMPackingLines.SETRANGE(EXIMPackingLines."LFS Type", "LFS Type");
//         EXIMPackingLines.SETRANGE(EXIMPackingLines."LFS Packing List No.", "LFS Packing List No.");
//         EXIMPackingLines.SETRANGE(EXIMPackingLines."LFS Parent Line No.", "LFS Line No.");
//         EXIMPackingLines.DELETEALL();
//     end;

//     var
//         Item: Record Item;
//         ItemLedgerEntry: Record "Item Ledger Entry";
//         ItemUOM: Record "Item Unit of Measure";
//         EXIMPackingHeader: Record "LFS EXIM Packing Header";
//         EXIMPackingLines: Record "LFS EXIM Packing Lines";
//         EXIMPackingLines1: Record "LFS EXIM Packing Lines";
//         Total: array[12] of Decimal;

//     procedure UpadateParentLineTotal();
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
//         EXIMPackingLines1.SETRANGE(EXIMPackingLines1."LFS Type", "LFS Type");
//         EXIMPackingLines1.SETRANGE(EXIMPackingLines1."LFS Packing List No.", "LFS Packing List No.");
//         EXIMPackingLines1.SETFILTER("LFS Indentation", '<>%1', 0);
//         EXIMPackingLines1.SETRANGE(EXIMPackingLines1."LFS Parent Line No.", "LFS Parent Line No.");
//         if EXIMPackingLines1.Findset() then
//             repeat
//                 Total[1] += EXIMPackingLines1."LFS Total Net Weight";
//                 Total[2] += EXIMPackingLines1."LFS Quantity";
//                 Total[3] += EXIMPackingLines1."LFS Total Shipment Qty.";
//                 Total[4] += EXIMPackingLines1."LFS From pallet";
//                 Total[5] += EXIMPackingLines1."LFS To Pallet";
//                 Total[6] += EXIMPackingLines1."LFS Total No. of Pallets";
//                 Total[7] += EXIMPackingLines1."LFS From Package No.";
//                 Total[8] += EXIMPackingLines1."LFS To Package No.";
//                 Total[10] += EXIMPackingLines1."LFS Tare W.T of each Bag(KG)";
//             until EXIMPackingLines1.Next() = 0;

//         EXIMPackingLines.Reset();
//         EXIMPackingLines.SETRANGE(EXIMPackingLines."LFS Type", "LFS Type");
//         EXIMPackingLines.SETRANGE(EXIMPackingLines."LFS Packing List No.", "LFS Packing List No.");
//         EXIMPackingLines.SETRANGE(EXIMPackingLines."LFS Line No.", "LFS Parent Line No.");
//         if EXIMPackingLines.FINDFIRST() then begin
//             EXIMPackingLines."LFS Quantity" := Total[2];
//             EXIMPackingLines."LFS Total No. of Pallets" := Total[6];
//             EXIMPackingLines.MODIFY();
//         end;
//     end;
// }