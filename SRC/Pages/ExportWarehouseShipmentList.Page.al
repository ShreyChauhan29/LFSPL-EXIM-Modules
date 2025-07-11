namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Warehouse.Document;

page 72062 LFSExportWarehouseShipmentList
{
    ApplicationArea = All;
    Caption = 'ExportWarehouseShipmentList';
    PageType = List;
    SourceTable = "Warehouse Shipment Header";
    UsageCategory = Lists;
    DataCaptionFields = "No.";
    Editable = false;
    CardPageID = "LFS Export Warehouse Shipment";
    SourceTableView = where("LFS EXIM Type" = const(Export));
    InsertAllowed = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the No.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Location Code';
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Assigned User ID';
                }
                field("Sorting Method"; Rec."Sorting Method")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Sorting Method';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Status';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Bin Code';
                    Visible = false;
                }
                field("Document Status"; Rec."Document Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Document Status';
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Posting Date';
                    Visible = false;
                }
                field("Assignment Date"; Rec."Assignment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Assignment Date';
                    Visible = false;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ToolTip = 'Specifies the Shipment Date';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shipping Agent Code';
                    Visible = false;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ToolTip = 'Specifies the Shipping Agent Service Code';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shipment Method Code';
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
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
                action("Pick Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Pick Lines';
                    ToolTip = 'Specifies the Pick Lines';
                    Image = PickLines;
                    RunObject = Page 5785;
                    RunPageLink = "Whse. Document Type" = const(Shipment),
                                  "Whse. Document No." = FIELD("No.");
                    RunPageView = SORTING("Whse. Document No.", "Whse. Document Type", "Activity Type")
                                  where("Activity Type" = const(Pick));
                }
                action("Registered P&ick Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Registered P&ick Lines';
                    ToolTip = 'Specifies the Registered P&ick Lines';
                    Image = RegisteredDocs;
                    RunObject = Page 7364;
                    RunPageLink = "Whse. Document No." = FIELD("No.");
                    RunPageView = SORTING("Whse. Document Type", "Whse. Document No.", "Whse. Document Line No.")
                                  where("Whse. Document Type" = const(Shipment));
                }
                action("Posted &Whse. Shipments")
                {
                    ApplicationArea = All;
                    Caption = 'Posted &Whse. Shipments';
                    ToolTip = 'Specifies the Posted &Whse. Shipments';
                    Image = PostedReceipt;
                    RunObject = Page 7340;
                    RunPageLink = "Whse. Shipment No." = FIELD("No.");
                    RunPageView = SORTING("Whse. Shipment No.");
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    ToolTip = 'Specifies the Card';
                    Image = EditLines;

                    trigger OnAction()
                    begin
                        PAGE.RUN(PAGE::"Warehouse Shipment", Rec);
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Re&lease")
                {
                    ApplicationArea = All;
                    Caption = 'Re&lease';
                    ToolTip = 'Specifies the ReleaseDoc';
                    Image = ReleaseDoc;

                    trigger OnAction()
                    var
                        ReleaseWhseShptDoc: Codeunit 7310;
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
                    ToolTip = 'Specifies the ReOpen';
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        ReleaseWhseShptDoc: Codeunit 7310;
                    begin
                        ReleaseWhseShptDoc.Reopen(Rec);
                    end;
                }
            }
        }
    }

    trigger OnFindRecord(Which: Text): Boolean
    begin
        EXIT(Rec.FindFirstAllowedRec(CopyStr(Which, 1, 1024)));
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        EXIT(Rec.FindNextAllowedRec(Steps));
    end;

    trigger OnOpenPage()
    begin
        Rec.ErrorIfUserIsNotWhseEmployee();
    end;
}