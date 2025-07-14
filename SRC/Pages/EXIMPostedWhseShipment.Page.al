namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Warehouse.History;
using Microsoft.Warehouse.Activity;

page 72053 "LFS EXIM Posted Whse. Shipment"
{
    ApplicationArea = All;
    Caption = 'Export Posted Warehouse Shipment';
    PageType = Document;
    SourceTable = "Posted Whse. Shipment Header";
    InsertAllowed = false;
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
                    Editable = false;
                    Importance = Promoted;
                    ToolTip = 'No.';
                }
                field("Whse. Shipment No."; Rec."Whse. Shipment No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Promoted;
                    ToolTip = 'Whse. Shipment No.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Location Code';
                }
                field("Zone Code"; Rec."Zone Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Zone Code';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Bin Code';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Posting Date';
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Promoted;
                    ToolTip = 'Assigned User ID';
                }
                field("Assignment Date"; Rec."Assignment Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Assignment Date';
                }
                field("Assignment Time"; Rec."Assignment Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Assignment Time';
                }
            }
            part(WhseShptLines; "LFSEXIM PostedWhse.ShipmentSub")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
                SubPageView = SORTING("No.", "Line No.");
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Promoted;
                    ToolTip = 'External Document No.';
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Promoted;
                    ToolTip = 'Shipment Date';
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Shipping Agent Code';
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Promoted;
                    ToolTip = 'Shipping Agent Service Code';
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Shipment Method Code';
                }
            }
            group(Exim)
            {
                Caption = 'Exim';
                field("Port of Loading"; Rec."LFS Port of Loading")
                {
                    ApplicationArea = All;
                    ToolTip = 'Port of Loading';
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
                field("Shpping Line"; Rec."LFS Shpping Line")
                {
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
                //     Editable = false;
                // }
                // field("FTT Date"; Rec."LFS FTT Date")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the FTT Date';
                //     Editable = false;
                // }
                // field("BIN No."; Rec."LFS BIN No.")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the BIN No.';
                //     Editable = false;
                // }
                field("Customs Bank Account"; Rec."LFS Customs Bank Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Customs Bank Account';
                }
                field("Commercial  Bank Account"; Rec."LFS Commercial Bank Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Commercial  Bank Account';
                }
                // field(Carrier; Rec."LFS Carrier")
                // {
                //     ToolTip = 'Specifies the Carrier';
                //     ApplicationArea = All;
                // }
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
                action(List)
                {
                    ApplicationArea = All;
                    Caption = 'List';
                    ToolTip = 'Specifies the List';
                    Image = OpportunitiesList;
                    trigger OnAction()
                    begin
                        Rec.LookupPostedWhseShptHeader(Rec);
                    end;
                }
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
                action("Export Information")
                {
                    ApplicationArea = all;
                    Caption = 'Export Information';
                    Image = View;
                    ToolTip = 'Export Information';
                    trigger OnAction()
                    var
                        Export: Record "LFS Posted Export Information";
                        exportInfor: Page "LFS Posted Export Information";
                    begin
                        export.SetRange("LFS Document Type", Export."LFS Document Type"::Shipment);
                        Export.SetRange("LFS Document No.", Rec."No.");
                        exportInfor.SetTableView(Export);
                        Page.RunModal(Page::"LFS Posted Export Information", Export);
                    end;
                }
            }
        }
        area(processing)
        {
            action("&Print")
            {
                ApplicationArea = All;
                Caption = '&Print';
                ToolTip = 'Specifies the Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    WhseDocPrint.PrintPostedShptHeader(Rec);
                end;
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

    var
        WhseDocPrint: Codeunit "Warehouse Document-Print";
}