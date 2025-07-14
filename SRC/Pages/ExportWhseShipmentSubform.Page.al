namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Warehouse.Document;
using Microsoft.Inventory.BOM;
using Microsoft.Sales.Document;

page 72063 "LFSExportWhse. ShipmentSubform"
{
    ApplicationArea = All;
    Caption = 'ExportWhse. ShipmentSubform';
    PageType = ListPart;
    SourceTable = "Warehouse Shipment Line";
    DelayedInsert = true;
    InsertAllowed = false;
    LinksAllowed = false;
    MultipleNewLines = true;
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Source Document"; Rec."Source Document")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Source Document';
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Source No.';
                }
                field("Source Line No."; Rec."Source Line No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Source Line No.';
                }
                field("Destination Type"; Rec."Destination Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Destination Type';
                }
                field("Destination No."; Rec."Destination No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Destination No.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Item No.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Variant Code';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Description';
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Location Code';
                }
                field("Zone Code"; Rec."Zone Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Zone Code';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    Visible = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Bin Code';

                    trigger OnValidate()
                    begin
                        BinCodeOnAfterValidate();
                    end;
                }
                field("Shelf No."; Rec."Shelf No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shelf No.';
                    Visible = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Quantity';

                    trigger OnValidate()
                    begin
                        QuantityOnAfterValidate();
                    end;
                }
                field("Qty. (Base)"; Rec."Qty. (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Qty. (Base)';
                    Visible = false;
                }
                field("Qty. to Ship"; Rec."Qty. to Ship")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Qty. to Ship';
                }
                field("Qty. Shipped"; Rec."Qty. Shipped")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Qty. Shipped';
                }
                field("Qty. to Ship (Base)"; Rec."Qty. to Ship (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Qty. to Ship (Base)';
                    Visible = false;
                }
                field("Qty. Shipped (Base)"; Rec."Qty. Shipped (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Qty. Shipped (Base)';
                    Visible = false;
                }
                field("Qty. Outstanding"; Rec."Qty. Outstanding")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Qty. Outstanding';
                    Visible = true;
                }
                field("Qty. Outstanding (Base)"; Rec."Qty. Outstanding (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Qty. Outstanding (Base)';
                    Visible = false;
                }
                field("Pick Qty."; Rec."Pick Qty.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Pick Qty.';
                    Visible = false;
                }
                field("Pick Qty. (Base)"; Rec."Pick Qty. (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Pick Qty. (Base)';
                    Visible = false;
                }
                field("Qty. Picked"; Rec."Qty. Picked")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Qty. Picked';
                    Visible = false;
                }
                field("Qty. Picked (Base)"; Rec."Qty. Picked (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Qty. Picked (Base)';
                    Visible = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the "Due Date"';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Unit of Measure Code';
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Qty. per Unit of Measure';
                }
                field(QtyCrossDockedUOM; QtyCrossDockedUOM)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Qty. on Cross-Dock Bin';
                    Caption = 'Qty. on Cross-Dock Bin';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                    Visible = false;

                    trigger OnDrillDown()
                    begin
                        CrossDockMgt.ShowBinContentsCrossDocked(Rec."Item No.", Rec."Variant Code", Rec."Unit of Measure Code", Rec."Location Code", true);
                    end;
                }
                field(QtyCrossDockedUOMBase; QtyCrossDockedUOMBase)
                {
                    ApplicationArea = All;
                    Caption = 'Qty. on Cross-Dock Bin (Base)';
                    ToolTip = 'Specifies the Qty. on Cross-Dock Bin (Base)';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                    Visible = false;

                    trigger OnDrillDown()
                    begin
                        CrossDockMgt.ShowBinContentsCrossDocked(Rec."Item No.", Rec."Variant Code", Rec."Unit of Measure Code", Rec."Location Code", true);
                    end;
                }
                field(QtyCrossDockedAllUOMBase; QtyCrossDockedAllUOMBase)
                {
                    ApplicationArea = All;
                    Caption = 'Qty. on Cross-Dock Bin (Base all UOM)';
                    ToolTip = 'Specifies the Qty. on Cross-Dock Bin (Base all UOM)';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                    Visible = false;

                    trigger OnDrillDown()
                    begin
                        CrossDockMgt.ShowBinContentsCrossDocked(Rec."Item No.", Rec."Variant Code", Rec."Unit of Measure Code", Rec."Location Code", FALSE);
                    end;
                }
                field("Assemble to Order"; Rec."Assemble to Order")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Assemble to Order';
                    Visible = false;
                }
                field("Incentive Type"; Rec."LFS Incentive Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Incentive Type';
                }
                field("License Type"; Rec."LFS License Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the License Type';
                }
                field("License No."; Rec."LFS License No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the License No.';
                }
                field("FOB (FCY) Per Unit"; Rec."LFS FOB Amount (FCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the FOB (FCY) Per Unit';
                }
                field("CIF (FCY) Per Unit"; Rec."LFS CIF Amount (FCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the CIF (FCY) Per Unit';
                }
                field("No. of Container"; Rec."LFS No. of Container")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the No. of Container';
                }
                // field("Freight Type"; Rec."LFS Freight Type")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the Freight Type';
                // }
                field("Freight Value Per Type (LCY)"; Rec."LFS Freight Value (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Freight Value Per Type (LCY)';
                }
                field("Freight Value Per Type (FCY)"; Rec."LFS Freight Value (FCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Freight Value Per Type (FCY)';
                }
                // field("Insurance Type"; Rec."LFS Insurance Type")
                // {
                //     ToolTip = 'Specifies the Insurance Type';
                //     ApplicationArea = All;
                // }
                field("Insurance Value Per Type (LCY)"; Rec."LFS Insurance Value (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Insurance Value Per Type (LCY)';
                }
                field("Insurance Value Per Type (FCY)"; Rec."LFS Insurance Value (FCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Insurance Value Per Type (FCY)';
                }
                // field("Category Type"; Rec."LFS Category Type")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the Category Type';
                // }
                // field("EXIM Remark"; Rec."LFS EXIM Remark")
                // {
                //     ToolTip = 'Specifies the EXIM Remark';
                //     ApplicationArea = All;
                // }
                field("Packing List No."; Rec."LFS Packing List No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Packing List No.';
                }
                field("Claim DDB"; Rec."LFS Claim DDB")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Claim DDB';
                }
                field("Currency Exch. Rate"; Rec."LFS Currency Exch. Rate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Currency Exch. Rate';
                }
                field("Custom Exch. Rate"; Rec."LFS Custom Exch. Rate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Custom Exch. Rate';
                }
                field("EXIM Item Group"; Rec."LFS EXIM Item Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the EXIM Item Group';
                }
                field("Packing Line Exists"; Rec."LFS Packing Line Exists")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Packing Line Exists';
                }
                field("Packed Qty."; Rec."LFS Packed Qty.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Packed Qty.';
                }
                field("Rem. Qty. To be Packed"; Rec."LFS Rem. Qty. To be Packed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Rem. Qty. To be Packed';
                }
                field("Shipping Bill No."; Rec."LFS Shipping Bill No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shipping Bill No.';
                }
                field("Shipping Bill Date"; Rec."LFS Shipping Bill Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shipping Bill Date';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action("Source &Document Line")
                {
                    ApplicationArea = All;
                    Caption = 'Source &Document Line';
                    ToolTip = 'Specifies the Source &Document Line';
                    Image = SourceDocLine;

                    trigger OnAction()
                    begin
                        ShowSourceLine();
                    end;
                }
                action("&Bin Contents List")
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData 7302 = R;
                    Caption = '&Bin Contents List';
                    ToolTip = 'Specifies the Bin Contents List';
                    Image = BinContent;

                    trigger OnAction()
                    begin
                        ShowBinContents();
                    end;
                }
                action(ItemTrackingLines)
                {
                    ApplicationArea = All;
                    Caption = 'Item &Tracking Lines';
                    ToolTip = 'Specifies the Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';

                    trigger OnAction()
                    begin
                        Rec.OpenItemTrackingLines();
                    end;
                }
                action("Assemble to_Order1")
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData "BOM Component" = R;
                    Caption = 'Assemble to Order';
                    ToolTip = 'Specifies the Assemble to Order';
                    Image = AssemblyBOM;

                    trigger OnAction()
                    var
                        ATOSalesLine: Record 37;
                        ATOLink: Record 904;
                    begin
                        Rec.TESTFIELD("Assemble to Order", true);
                        Rec.TESTFIELD("Source Type", DATABASE::"Sales Line");
                        ATOSalesLine.GET(Rec."Source Subtype", Rec."Source No.", Rec."Source Line No.");
                        ATOLink.ShowAsm(ATOSalesLine);
                    end;
                }
            }
            group(Exim)
            {
                Caption = 'EXIM';
                action("Packing List")
                {
                    ApplicationArea = all;
                    Caption = 'Packing List';
                    ToolTip = 'Specifies the Packing List';
                    Image = ListPage;
                    trigger OnAction()
                    var
                        PackingList: Record "LFS EXIM Packing List Tab.";
                        PackingListPage: page "LFS EXIM Packing List";
                    begin
                        PackingList.SetRange("LFS Source Document No.", Rec."No.");
                        PackingList.SetRange("LFS Source Doc. Line No.", Rec."Line No.");
                        PackingList.SetRange("LFS Source Order No.", Rec."Source No.");
                        PackingList.SetRange("LFS Source Order Line No.", Rec."Source Line No.");
                        if Rec."Source Document" = Rec."Source Document"::"Sales Order" then
                            PackingList.SetRange("LFS Source Document Type", PackingList."LFS Source Document Type"::"Sales Order");
                        PackingListPage.SetTableView(PackingList);
                        Page.Run(page::"LFS EXIM Packing List", PackingList);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CrossDockMgt.CalcCrossDockedItems(Rec."Item No.", Rec."Variant Code", Rec."Unit of Measure Code", Rec."Location Code",
          QtyCrossDockedUOMBase,
          QtyCrossDockedAllUOMBase);
        QtyCrossDockedUOM := 0;
        if Rec."Qty. per Unit of Measure" <> 0 then
            QtyCrossDockedUOM := ROUND(QtyCrossDockedUOMBase / Rec."Qty. per Unit of Measure", 0.00001);
    end;

    var
        CrossDockMgt: Codeunit 5780;
        WMSMgt: Codeunit 7302;
        QtyCrossDockedAllUOMBase: Decimal;
        QtyCrossDockedUOM: Decimal;
        QtyCrossDockedUOMBase: Decimal;

    procedure AutofillQtyToHandle()
    var
        WhseShptLine: Record 7321;
    begin
        WhseShptLine.COPY(Rec);
        Rec.AutofillQtyToHandle(WhseShptLine);
    end;

    procedure DeleteQtyToHandle()
    var
        WhseShptLine: Record 7321;
    begin
        WhseShptLine.COPY(Rec);
        Rec.DeleteQtyToHandle(WhseShptLine);
    end;

    procedure PickCreate()
    var
        WhseShptHeader: Record 7320;
        WhseShptLine: Record 7321;
        ReleaseWhseShipment: Codeunit 7310;
    begin
        WhseShptLine.COPY(Rec);
        WhseShptHeader.GET(WhseShptLine."No.");
        if WhseShptHeader.Status = WhseShptHeader.Status::Open then
            ReleaseWhseShipment.Release(WhseShptHeader);
        Rec.CreatePickDoc(WhseShptLine, WhseShptHeader);
    end;

    procedure PostShipmentPrintYesNo()
    var
        WhseShptLine: Record 7321;
        WhsePostShptPrintShipInvoice: Codeunit 5765;
    begin
        WhseShptLine.COPY(Rec);
        WhsePostShptPrintShipInvoice.RUN(WhseShptLine);
        Rec.Reset();
        Rec.SETCURRENTKEY("No.", "Sorting Sequence No.");
        CurrPage.UPDATE(FALSE);
    end;

    procedure PostShipmentYesNo()
    var
        WhseShptLine: Record 7321;
        WhsePostShptShipInvoice: Codeunit 5764;
    begin
        WhseShptLine.COPY(Rec);
        WhsePostShptShipInvoice.RUN(WhseShptLine);
        Rec.Reset();
        Rec.SETCURRENTKEY("No.", "Sorting Sequence No.");
        CurrPage.UPDATE(FALSE);
    end;

    procedure Preview()
    var
        WhseShptLine: Record "Warehouse Shipment Line";
        WhsePostShipmentYesNo: Codeunit "Whse.-Post Shipment (Yes/No)";
    begin
        WhseShptLine.Copy(Rec);
        WhsePostShipmentYesNo.Preview(WhseShptLine);
        CurrPage.Update(false);
    end;

    // local procedure OpenItemTrackingLines()
    // begin
    //     Rec.OpenItemTrackingLines();
    // end;

    local procedure BinCodeOnAfterValidate()
    begin
        CurrPage.UPDATE();
    end;

    local procedure QuantityOnAfterValidate()
    begin
        CurrPage.UPDATE();
    end;

    local procedure ShowBinContents()
    var
        BinContent: Record 7302;
    begin
        BinContent.ShowBinContents(Rec."Location Code", Rec."Item No.", Rec."Variant Code", Rec."Bin Code");
    end;

    local procedure ShowSourceLine()
    begin
        WMSMgt.ShowSourceDocLine(Rec."Source Type", Rec."Source Subtype", Rec."Source No.", Rec."Source Line No.", 0);
    end;
}