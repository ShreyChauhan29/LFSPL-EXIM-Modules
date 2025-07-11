namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Warehouse.History;

page 72064 "LFSExpPostedWhse. ShipmentList"
{
    ApplicationArea = All;
    Caption = 'Export Posted Warehouse Shipment List';
    PageType = List;
    SourceTable = "Posted Whse. Shipment Header";
    UsageCategory = Lists;
    CardPageID = "LFS EXIM Posted Whse. Shipment";
    DataCaptionFields = "No.";
    Editable = false;
    SourceTableView = where("LFS EXIM Type" = const(Export));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
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
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the No. Series';
                }
                field("Whse. Shipment No."; Rec."Whse. Shipment No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Whse. Shipment No.';
                }
                field("Zone Code"; Rec."Zone Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Zone Code';
                    Visible = false;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Bin Code';
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
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shipment Date';
                    Visible = false;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ToolTip = 'Specifies the Shipping Agent Code';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shipping Agent Service Code';
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
                ApplicationArea = All;
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
                    RunPageLink = "Table Name" = const("Posted Whse. Shipment"),
                                  Type = const(" "),
                                  "No." = FIELD("No.");
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
                        PAGE.RUN(PAGE::"Posted Whse. Shipment", Rec);
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