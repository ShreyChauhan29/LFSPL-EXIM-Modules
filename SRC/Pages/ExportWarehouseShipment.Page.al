namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Warehouse.Document;
using Microsoft.Warehouse.Setup;
using Microsoft.Warehouse.Activity;
using Microsoft.Warehouse.History;
using Microsoft.Warehouse.Request;
using Microsoft.Inventory.Tracking;
using Microsoft.Sales.Document;
using Microsoft.Warehouse.Activity.History;

page 72061 "LFS Export Warehouse Shipment"
{
    ApplicationArea = All;
    Caption = 'Export Warehouse Shipment';
    PageType = Document;
    SourceTable = "Warehouse Shipment Header";
    PopulateAllFields = true;
    RefreshOnActivate = true;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the No.';
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Location Code';
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CurrPage.SAVERECORD();
                        Rec.LookupLocation(Rec);
                        CurrPage.UPDATE(true);
                    end;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Bin Code';
                }
                field("Document Status"; Rec."Document Status")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the Document Status';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Status';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Posting Date';
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the Assigned User ID';
                }
                field("Assignment Date"; Rec."Assignment Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the Assignment Date';
                }
                field("Assignment Time"; Rec."Assignment Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the Assignment Time';
                }
                field("Shipping No. Series"; Rec."Shipping No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shipping No. Series';
                }
                field("Shipping No."; Rec."Shipping No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Shipping No.';
                }
                field("Sorting Method"; Rec."Sorting Method")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Sorting Method';
                    trigger OnValidate()
                    begin
                        SortingMethodOnAfterValidate();
                    end;
                }
            }
            part(WhseShptLines; "LFSExportWhse. ShipmentSubform")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
                SubPageView = SORTING("No.", "Sorting Sequence No.");
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the External Document No.';
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the Shipment Date';
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shipping Agent Code';
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the Shipping Agent Service Code';
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shipment Method Code';
                }

            }
            group(Exim)
            {
                Caption = 'Exim';
                field("Port of Loading"; Rec."LFS Port of Loading")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Port of Loading';
                }
                field("Port of Discharge"; Rec."LFS Port of Discharge")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Port of Discharge';
                }
                field("Country of Final Destination"; Rec."LFS Country of Final Dest.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Country of Final Destination';
                }
                field("Final Destination"; Rec."LFS Final Destination")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Final Destination';
                }
                field("Country of Origin of Goods"; Rec."LFS Country Origin Goods")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Country of Origin of Goods';
                }
                field("Inco Terms"; Rec."LFS Inco Terms")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Inco Terms';
                }
                field("Export Remark"; Rec."LFS Export Remark")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Export Remark';
                }
                field("Custom Currency Code"; Rec."LFS Custom Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Custom Currency Code';
                }
                field("Custom Currency Factor"; Rec."LFS Custom Currency Factor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Custom Currency Factor';
                }
                field("Shipping Line"; Rec."LFS Shpping Line")
                {
                    Caption = 'Shipping Line';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shipping Line';
                }
                field("Pre Carriage"; Rec."LFS Pre Carriage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Pre Carriage';
                }
                // field("Bill of Lading Date"; Rec."LFS Bill of Lading Date")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the Bill of Lading Date';
                // }
                // field("Bill of Lading No."; Rec."LFS Bill of Lading No.")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the Bill of Lading No.';
                // }
                field(ETD; Rec."LFS ETD")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ETD';
                }
                field(ETA; Rec."LFS ETA")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ETA';
                }
                // field("FTT No."; Rec."LFS FTT No.")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the FTT No.';
                // }
                // field("FTT Date"; Rec."LFS FTT Date")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the FTT Date';
                // }
                // field("BIN No."; Rec."LFS BIN No.")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the BIN No.';
                // }
                field("Customs Bank Account"; Rec."LFS Customs Bank Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Customs Bank Account';
                }
                field("Commercial Bank Account"; Rec."LFS Commercial Bank Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Commercial Bank Account';
                }
                // field(Carrier; Rec."LFS Carrier")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the Carrier';
                // }
            }
        }
        area(factboxes)
        {
            part("Item Warehouse FactBox"; "Item Warehouse FactBox")
            {
                ApplicationArea = all;
                Provider = WhseShptLines;
                SubPageLink = "No." = FIELD("Item No.");
                Visible = true;
            }
            systempart(Link; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = all;
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Shipment")
            {
                Caption = '&Shipment';
                Image = Shipment;
                // action(List)
                // {
                //     ApplicationArea = All;
                //     Caption = 'List';
                //     Image = OpportunitiesList;
                // }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    ToolTip = 'Specifies the Comments';
                    Image = ViewComments;
                    RunObject = Page 5776;
                    RunPageLink = "Table Name" = const("Whse. Shipment"),
                                  Type = const(" "),
                                  "No." = FIELD("No.");
                }
                action("Export Information")
                {
                    ApplicationArea = all;
                    Caption = 'Export Information';
                    ToolTip = 'Specifies the Export Information';
                    Image = View;
                    trigger OnAction()
                    var
                        Export: Record "LFS Export Information Header";
                        exportInfor: Page "LFS Export Information";
                    begin
                        export.SetRange("LFS Document Type", Export."LFS Document Type"::Shipment);
                        Export.SetRange("LFS Document No.", Rec."No.");
                        exportInfor.SetTableView(Export);
                        Page.RunModal(Page::"LFS Export Information", Export);
                    end;
                }
                action("Pick Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Pick Lines';
                    ToolTip = 'Specifies the Pick Lines';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity Lines";
                    RunPageLink = "Whse. Document Type" = const(Shipment),
                                  "Whse. Document No." = FIELD("No.");
                    RunPageView = SORTING("Whse. Document No.", "Whse. Document Type", "Activity Type")
                                  where("Activity Type" = const(Pick));
                }
                action("Registered P&ick Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Registered P&ick Lines';
                    ToolTip = 'Specifies the Registered Pick Lines';
                    Image = RegisteredDocs;
                    RunObject = Page "Registered Whse. Act.-Lines";
                    RunPageLink = "Whse. Document No." = FIELD("No.");
                    RunPageView = SORTING("Whse. Document Type", "Whse. Document No.", "Whse. Document Line No.")
                                  where("Whse. Document Type" = const(Shipment));
                }
                action("Posted &Whse. Shipments")
                {
                    ApplicationArea = All;
                    Caption = 'Posted &Whse. Shipments';
                    ToolTip = 'Specifies the Posted Whse. Shipments';
                    Image = PostedReceipt;
                    RunObject = Page "Posted Whse. Shipment List";
                    RunPageLink = "Whse. Shipment No." = FIELD("No.");
                    RunPageView = SORTING("Whse. Shipment No.");
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Use Filters to Get Src. Docs.")
                {
                    ApplicationArea = All;
                    Caption = 'Use Filters to Get Src. Docs.';
                    Ellipsis = true;
                    Image = UseFilters;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Specifies the Use Filters to Get Src. Docs.';
                    trigger OnAction()
                    var
                        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    begin
                        Rec.TESTFIELD(Status, Rec.Status::Open);
                        GetSourceDocOutbound.GetOutboundDocs(Rec);
                    end;
                }
                action("Get Source Documents")
                {
                    ApplicationArea = All;
                    Caption = 'Get Source Documents';
                    Ellipsis = true;
                    Image = GetSourceDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Specifies the Get Source Documents';
                    trigger OnAction()
                    var
                        exportInfo: Record "LFS Export Information Header";
                        exportInfor2: Record "LFS Export Information Header";
                        Salesheader: Record "Sales Header";
                        whseShipmentLine: Record "Warehouse Shipment Line";
                        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    begin
                        Rec.TESTFIELD(Status, Rec.Status::Open);
                        GetSourceDocOutbound.GetSingleOutboundDoc(Rec);
                        updateWhseShipmentheader();
                        exportInfor2.SetRange("LFS Document Type", exportInfor2."LFS Document Type"::Shipment);
                        exportInfor2.SetRange("LFS Document No.", Rec."No.");
                        if not exportInfor2.FindFirst() then begin
                            whseShipmentLine.SetRange("No.", Rec."No.");
                            whseShipmentLine.SetRange("Source Document", whseShipmentLine."Source Document"::"Sales Order");
                            if whseShipmentLine.Findfirst() then begin
                                SalesHeader.Reset();
                                SalesHeader.SetRange("No.", whseShipmentLine."Source No.");
                                if SalesHeader.FindFirst() then begin
                                    exportInfo.Reset();
                                    exportInfo.SetRange("LFS Document Type", SalesHeader."Document Type");
                                    exportInfo.SetRange("LFS Document No.", SalesHeader."No.");
                                    if exportInfo.FindFirst() then begin
                                        Clear(exportInfor2);
                                        exportInfor2."LFS Document Type" := exportInfor2."LFS Document Type"::Shipment;
                                        exportInfor2."LFS Document No." := Rec."No.";
                                        exportInfor2.Insert();
                                        exportInfor2.TransferFields(exportInfo, false);
                                        exportInfor2."LFS Doc. Line No." := whseShipmentLine."Line No.";
                                        exportInfor2.Modify();
                                    end;
                                end;
                            end;
                        end
                        else
                            if exportInfor2.FindFirst() then begin
                                whseShipmentLine.SetRange("No.", Rec."No.");
                                whseShipmentLine.SetRange("Source Document", whseShipmentLine."Source Document"::"Sales Order");
                                if whseShipmentLine.Findfirst() then begin
                                    SalesHeader.Reset();
                                    SalesHeader.SetRange("No.", whseShipmentLine."Source No.");
                                    if SalesHeader.FindFirst() then begin
                                        exportInfo.Reset();
                                        exportInfo.SetRange("LFS Document Type", SalesHeader."Document Type");
                                        exportInfo.SetRange("LFS Document No.", SalesHeader."No.");
                                        if exportInfo.FindFirst() then begin
                                            Clear(exportInfor2);
                                            exportInfor2.TransferFields(exportInfo, false);
                                            exportInfor2."LFS Doc. Line No." := whseShipmentLine."Line No.";
                                            exportInfor2.Modify();
                                        end;
                                    end;
                                end;
                            end;
                    end;
                }
                action("Re&lease")
                {
                    ApplicationArea = All;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Specifies the Release';
                    trigger OnAction()
                    var
                        ReleaseWhseShptDoc: Codeunit "Whse.-Shipment Release";
                    begin
                        CurrPage.UPDATE(true);
                        if Rec.Status = Rec.Status::Open then
                            ReleaseWhseShptDoc.Release(Rec);
                    end;
                }
                action("Re&open")
                {
                    ApplicationArea = All;
                    Caption = 'Re&open';
                    Image = ReOpen;
                    ToolTip = 'Specifies the Reopen';
                    trigger OnAction()
                    var
                        ReleaseWhseShptDoc: Codeunit "Whse.-Shipment Release";
                    begin
                        ReleaseWhseShptDoc.Reopen(Rec);
                    end;
                }
                action("Autofill Qty. to Ship")
                {
                    ApplicationArea = All;
                    Caption = 'Autofill Qty. to Ship';
                    Image = AutofillQtyToHandle;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Specifies the Autofill Qty. to Ship';
                    trigger OnAction()
                    begin
                        AutofillQtyToHandle();
                    end;
                }
                action("Delete Qty. to Ship")
                {
                    ApplicationArea = All;
                    Caption = 'Delete Qty. to Ship';
                    Image = DeleteQtyToHandle;
                    ToolTip = 'Specifies the Delete Qty. to Ship';
                    trigger OnAction()
                    begin
                        DeleteQtyToHandle();
                    end;
                }
                action("Create Pick")
                {
                    ApplicationArea = All;
                    Caption = 'Create Pick';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Specifies the Create Pick';
                    trigger OnAction()
                    begin
                        CurrPage.UPDATE(true);
                        CurrPage.WhseShptLines.PAGE.PickCreate();
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("P&ost Shipment")
                {
                    ApplicationArea = All;
                    Caption = 'P&ost Shipment';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Specifies the Post Shipment';
                    trigger OnAction()
                    begin
                        if Rec.Status = Rec.Status::Open then
                            Error('Document should be Released before posting');
                        checkPackingLinesQty();
                        qtyInEachPack();
                        PostShipmentYesNo();
                    end;
                }
                action(PreviewPosting)
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    ShortCutKey = 'Ctrl+Alt+F9';
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    trigger OnAction()
                    begin
                        if Rec.Status = Rec.Status::Open then
                            Error('Document should be Released before posting');
                        ShowPreview();
                        checkPackingLinesQty();
                        qtyInEachPack();
                        CurrPage.Update(false);
                    end;
                }
                action("Post and &Print")
                {
                    ApplicationArea = All;
                    Caption = 'Post and &Print';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Specifies the Post and Print';
                    trigger OnAction()
                    begin
                        PostShipmentPrintYesNo();
                    end;
                }
            }
            action("&Print")
            {
                ApplicationArea = All;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Specifies the Print';
                trigger OnAction()
                begin
                    WhseDocPrint.PrintShptHeader(Rec);
                end;
            }
        }
    }

    trigger OnFindRecord(Which: Text): Boolean
    begin
        EXIT(Rec.FindFirstAllowedRec(CopyStr(Which, 1, 1024)));
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."LFS EXIM Type" := Rec."LFS EXIM Type"::Export;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        EXIT(Rec.FindNextAllowedRec(Steps));
    end;

    trigger OnOpenPage()
    begin
        Rec.ErrorIfUserIsNotWhseEmployee();
    end;

    var
        WhseDocPrint: Codeunit "Warehouse Document-Print";

    local procedure AutofillQtyToHandle()
    begin
        CurrPage.WhseShptLines.PAGE.AutofillQtyToHandle();
    end;

    local procedure checkPackingLinesQty()
    var
        Packing: record "LFS EXIM Packing List Tab.";
        whseShipLine: Record "Warehouse Shipment Line";
        // Packing2: Record "LFS Packing List";
        // reservation: Record "Reservation Entry";
        SumTotalQtyInPack: Decimal;
    begin
        whseShipLine.setrange("No.", Rec."No.");
        if whseShipLine.Findset() then
            repeat
                SumTotalQtyInPack := 0;
                Packing.SetRange("LFS Source Document No.", whseShipLine."No.");
                Packing.SetRange("LFS Source Doc. Line No.", whseShipLine."Line No.");
                if packing.Findset() then begin
                    repeat
                        SumTotalQtyInPack += packing."LFS Total Quantity in Pack";
                    until packing.Next() = 0;
                    if SumTotalQtyInPack > whseShipLine."Qty. to Ship (Base)" then
                        Error('Sum of total Qty in Pack Should not exceed Qty. to Ship in line No. %1', whseShipLine."Line No.");
                end;

            until whseShipLine.Next() = 0;
    end;

    local procedure DeleteQtyToHandle()
    begin
        CurrPage.WhseShptLines.PAGE.DeleteQtyToHandle();
    end;

    local procedure PostShipmentPrintYesNo()
    begin
        CurrPage.WhseShptLines.PAGE.PostShipmentPrintYesNo();
    end;

    local procedure PostShipmentYesNo()
    begin
        CurrPage.WhseShptLines.PAGE.PostShipmentYesNo();
    end;

    local procedure qtyInEachPack()
    var
        Packing: record "LFS EXIM Packing List Tab.";
        reservation: Record "Reservation Entry";
        whseShipLine: Record "Warehouse Shipment Line";
        // SumTotalQtyInPack: Decimal;
        QtytoHandle: Decimal;
        SumQtyInEachPack: decimal;
    begin
        Clear(QtytoHandle);
        whseShipLine.setrange("No.", Rec."No.");
        if whseShipLine.Findset() then
            repeat
                SumQtyInEachPack := 0;
                QtytoHandle := 0;
                Packing.SetRange("LFS Item Code", whseShipLine."Item No.");
                Packing.SetRange("LFS Source Order No.", whseShipLine."Source No.");
                Packing.SetRange("LFS Source Doc. Line No.", whseShipLine."Line No.");
                if Packing.Findset() then
                    repeat
                        SumQtyInEachPack += Packing."LFS Total Quantity in Pack";
                    until Packing.Next() = 0;
                if not (SumQtyInEachPack = whseShipLine."Qty. to Ship (Base)") then
                    Error('Sum of"Total Quantity in Pack" Should be equal to "Qty. to handle" in Item tracking Lot no. %1, Line No. %2', reservation."Lot No.", reservation."Source Ref. No.");
            until whseShipLine.Next() = 0;
    end;

    local procedure ShowPreview()
    begin
        CurrPage.WhseShptLines.Page.Preview();
    end;

    local procedure SortingMethodOnAfterValidate()
    begin
        CurrPage.UPDATE();
    end;

    local procedure updateWhseShipmentheader()
    var
        Salesheader: Record "Sales Header";
        whseShipmentLine: Record "Warehouse Shipment Line";
    begin
        whseShipmentLine.SetRange("No.", Rec."No.");
        whseShipmentLine.SetRange("Source Document", whseShipmentLine."Source Document"::"Sales Order");
        if whseShipmentLine.Findfirst() then begin
            SalesHeader.Reset();
            SalesHeader.SetRange("No.", whseShipmentLine."Source No.");
            if SalesHeader.FindFirst() then begin
                Rec."Shipment Date" := Salesheader."Shipment Date";
                Rec."Shipping Agent Code" := Salesheader."Shipping Agent Code";
                Rec."Shipping Agent Service Code" := Salesheader."Shipping Agent Service Code";
                Rec."Shipment Method Code" := Salesheader."Shipment Method Code";
                Rec."LFS Port of Loading" := Salesheader."LFS Port of Loading";
                Rec."LFS Port of Discharge" := Salesheader."LFS Port of Discharge";
                Rec."LFS Country of Final Dest." := Salesheader."LFS Country of Final Dest.";
                Rec."LFS Final Destination" := Salesheader."LFS Final Destination";
                Rec."LFS Country Origin Goods" := Salesheader."LFS Country Origin Goods";
                Rec."LFS Inco Terms" := Salesheader."LFS Inco Terms";
                // Rec."LFS Export Remark" := Salesheader."LFS Export Remark";
                Rec."LFS Custom Currency Code" := Salesheader."LFS Custom Currency Code";
                Rec."LFS Custom Currency Factor" := Salesheader."LFS Custom Currency Factor";
                Rec."LFS Pre Carriage" := Salesheader."LFS Pre Carriage";
                // Rec."LFS Bill of Lading Date" := Salesheader."LFS Bill of Lading Date";
                // Rec."LFS Bill of Lading No." := Salesheader."LFS Bill of Lading No.";
                Rec."LFS ETD" := Salesheader."LFS ETD";
                Rec."LFS ETA" := Salesheader."LFS ETA";
                Rec."LFS Shpping Line" := Salesheader."LFS Shipping Line";
                Rec."LFS Customs Bank Account" := Salesheader."LFS Customs Bank Account";
                Rec."LFS Commercial Bank Account" := Salesheader."LFS Commercial Bank Account";
                // Rec."LFS Carrier" := Salesheader."LFS Carrier";
                Rec.Modify();
            end;
        end;
    end;
}