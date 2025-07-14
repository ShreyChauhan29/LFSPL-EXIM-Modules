namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Warehouse.History;
using Microsoft.Warehouse.Structure;

page 72054 "LFSEXIM PostedWhse.ShipmentSub"
{
    ApplicationArea = All;
    Caption = 'Export Posted Whse. Shipment Subform';
    PageType = ListPart;
    SourceTable = "Posted Whse. Shipment Line";
    DelayedInsert = true;
    Editable = false;
    LinksAllowed = false;
    MultipleNewLines = true;

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
                    Visible = false;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Source No.';
                    Visible = false;
                }
                field("Source Line No."; Rec."Source Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Source Line No.';
                    Visible = false;
                }
                field("Destination Type"; Rec."Destination Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Destination Type';
                    Visible = false;
                }
                field("Destination No."; Rec."Destination No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Destination No.';
                    Visible = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Item No.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Variant Code';
                    Visible = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Description';
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Description 2';
                    Visible = false;
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
                field("Shelf No."; Rec."Shelf No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shelf No.';
                    Visible = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Quantity)';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Unit of Measure Code';
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shipping Advice';
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
                    ToolTip = 'Specifies the License No';
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
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the Insurance Type';
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
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the EXIM Remark';
                // }
                field("Packing List No."; Rec."LFS Packing List No.")
                {
                    ToolTip = 'Specifies the Packing List No.';
                    ApplicationArea = All;
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
                    ToolTip = 'Specifies the Shipping Bill No';
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
                action("Bin Contents List")
                {
                    ApplicationArea = All;
                    Caption = 'Bin Contents List';
                    ToolTip = 'Specifies the Bin Contents List';
                    Image = BinContent;
                    trigger OnAction()
                    begin
                        ShowBinContents();
                    end;
                }
            }
            group(Exim)
            {
                Caption = 'EXIM';
                action("Packing List")
                {
                    ApplicationArea = All;
                    Caption = 'Packing List';
                    ToolTip = 'Specifies the Packing List';
                    Image = ListPage;
                    trigger OnAction()
                    var
                        PackingList: Record "LFS EXIM Posted Packing Table";
                        PackingListPage: page "LFS Posted Packing List";
                    begin
                        PackingList.SetRange("LFS PostedWhseShipment", Rec."No.");
                        PackingList.SetRange("LFS PostWhseShipmentLineNo", Rec."Line No.");
                        PackingListPage.SetTableView(PackingList);
                        Page.RunModal(page::"LFS Posted Packing List", PackingList);
                    end;
                }
            }
        }
    }

    local procedure ShowBinContents()
    var
        BinContent: Record "Bin Content";
    begin
        BinContent.ShowBinContents(Rec."Location Code", Rec."Item No.", Rec."Variant Code", Rec."Bin Code");
    end;

}