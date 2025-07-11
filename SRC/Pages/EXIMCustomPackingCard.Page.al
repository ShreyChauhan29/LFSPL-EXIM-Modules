namespace LFSEximModule.LFSPLEXIMModule;

page 72031 "LFS EXIM Custom Packing Card"
{
    ApplicationArea = All;
    Caption = 'EXIM Custom Packing Card';
    PageType = Card;
    SourceTable = "LFS EXIM Packing Header";
    DeleteAllowed = false;
    RefreshOnActivate = true;
    UsageCategory = None;

    layout
    {

        area(content)
        {
            group(General)
            {
                field("Packing List No."; Rec."LFS Packing List No.")
                {
                    ToolTip = 'Specifies the value of the Packing List No. field.';
                    ApplicationArea = All;
                }
                field("Total Shipment Qty."; Rec."LFS Total Shipment Qty.")
                {
                    ToolTip = 'Specifies the value of the Total Shipment Qty. field.';
                    ApplicationArea = All;
                }
                field(Status; Rec."LFS Status")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                }
                field("Shipping Bill No."; Rec."LFS Shipping Bill No.")
                {
                    ToolTip = 'Specifies the value of the Shipping Bill No. field.';
                    ApplicationArea = All;
                }
                field("Shipping Bill Date"; Rec."LFS Shipping Bill Date")
                {
                    ToolTip = 'Specifies the value of the Shipping Bill Date field.';
                    ApplicationArea = All;
                }
                field("Sales Shipment Doc. No."; Rec."LFS Sales Shipment Doc. No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Sales Shipment Doc. No.';
                }
                field("Total Gross Weight"; Rec."LFS Total Gross Weight")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Total Gross Weight';
                }
                field("Total Net Weight"; Rec."LFS Total Net Weight")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Total Net Weight';
                }
                field("Total Tare Weight"; Rec."LFS Total Tare Weight")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Total Tare Weight';
                }
                field("Total Corr. Box"; Rec."LFS Total Corr. Box")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Total Corr. Box';
                }
                field("Total Cases"; Rec."LFS Total Cases")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Total Cases';
                }
            }
            part("LFS EXIM Custom Packing Subpage"; "LFS EXIM Custom PackingSubpage")
            {
                ApplicationArea = All;
                SubPageLink = "LFS Packing List No." = field("LFS Packing List No.");

                UpdatePropagation = Both;
            }
            group("Container Details")
            {
                field("Container No."; Rec."LFS Container No.")
                {
                    ToolTip = 'Specifies the value of the Container No. field.';
                    ApplicationArea = All;
                }
                field("Container Size"; Rec."LFS Container Size")
                {
                    ToolTip = 'Specifies the value of the Container Size field.';
                    ApplicationArea = All;
                }
                field("Lot No. From to To"; Rec."LFS Lot No. From to To")
                {
                    ToolTip = 'Specifies the value of the Lot No. From to To field.';
                    ApplicationArea = All;
                }
                field("Trailor No."; Rec."LFS Trailor No.")
                {
                    ToolTip = 'Specifies the value of the Trailor No. field.';
                    ApplicationArea = All;
                }
                field("Vehicle No."; Rec."LFS Vehicle No.")
                {
                    ToolTip = 'Specifies the value of the Vehicle No. field.';
                    ApplicationArea = All;
                }
                field("Agent Seal No."; Rec."LFS Agent Seal No.")
                {
                    ToolTip = 'Specifies the value of the Agent Seal No. field.';
                    ApplicationArea = All;
                }
                field("RFID E-Seal Nos."; Rec."LFS RFID E-Seal Nos.")
                {
                    ToolTip = 'Specifies the value of the RFID E-Seal Nos. field.';
                    ApplicationArea = All;
                }
                field("Rotation No."; Rec."LFS Rotation No.")
                {
                    ToolTip = 'Specifies the value of the Rotation No. field.';
                    ApplicationArea = All;
                }
                field("W.T of each Pallet"; Rec."LFS W.T of each Pallet")
                {
                    ToolTip = 'Specifies the value of the W.T of each Pallet field.';
                    ApplicationArea = All;
                }
                field("MTG Date"; Rec."LFS MTG Date")
                {
                    Caption = 'MFG';
                    ToolTip = 'Specifies the value of the MTG Date field.';
                    ApplicationArea = All;
                }
                field("Tare W.T of each Bag(KG)"; Rec."LFS Tare W.T of each Bag(KG)")
                {
                    ToolTip = 'Specifies the value of the Tare W.T of each Bag(KG) field.';
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Get Posted Shipments")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the Get Posted Shipments';
                Image = GetSourceDoc;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Ellipsis = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    RecCustomPackLine: Record "LFS EXIM Packing Lines";
                    EXIMMngt: Codeunit "LFS EXIM General Functions";
                begin
                    RecCustomPackLine.Reset();
                    RecCustomPackLine.SetRange("LFS Line No.", 1000);
                    RecCustomPackLine.SetRange("LFS Parent Line No.", 0);
                    RecCustomPackLine.SetRange("LFS Type", RecCustomPackLine."LFS Type"::Custom);
                    if RecCustomPackLine.FindFirst() then
                        RecCustomPackLine.Delete();
                    Commit();
                    Clear(EXIMMngt);
                    EXIMMngt."LFS GetPstedShipLinesCustomPacking"(Rec);
                    CurrPage.Update();
                end;
            }
            action("Re-Open")
            {
                ApplicationArea = all;
                Image = ReOpen;
                ToolTip = 'Specifies the ReOpen';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Ellipsis = true;
                trigger OnAction()
                begin
                    Rec."LFS Status" := Rec."LFS Status"::Open;
                    Rec.Modify();

                    CurrPage.Update();
                end;
            }
            action(Release)
            {
                ApplicationArea = all;
                Image = ReleaseDoc;
                ToolTip = 'Specifies the ReleaseDoc';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Ellipsis = true;
                trigger OnAction()
                var
                    EXIMPackingLines: Record "LFS EXIM Packing Lines";
                    EXIMPackingLines1: Record "LFS EXIM Packing Lines";
                    // Text001: Label 'Lot Entry No. must have value in line no. %1';
                    VarSumQty: Decimal;
                begin
                    EXIMPackingLines.Reset();
                    EXIMPackingLines.SetRange("LFS Packing List No.", Rec."LFS Packing List No.");
                    EXIMPackingLines.SetRange("LFS Parent Line No.", 0);
                    if EXIMPackingLines.Findset() then
                        repeat
                            Clear(VarSumQty);
                            EXIMPackingLines1.Reset();
                            EXIMPackingLines1.SetRange("LFS Packing List No.", EXIMPackingLines."LFS Packing List No.");
                            EXIMPackingLines1.SetRange("LFS Parent Line No.", EXIMPackingLines."LFS Line No.");
                            EXIMPackingLines1.SetRange("LFS Shipment Document No.", EXIMPackingLines."LFS Shipment Document No.");
                            EXIMPackingLines1.SetRange("LFS Shipment Document Line No.", EXIMPackingLines."LFS Shipment Document Line No.");
                            if EXIMPackingLines1.Findset() then
                                repeat
                                    EXIMPackingLines1.TestField("LFS Package Type");
                                    EXIMPackingLines1.TestField("LFS Pallet Size");
                                    EXIMPackingLines1.TestField("LFS Bag Size");
                                    VarSumQty += EXIMPackingLines1."LFS Quantity";
                                until EXIMPackingLines1.Next() = 0;
                            if EXIMPackingLines."LFS Total Shipment Qty." < VarSumQty then
                                Error('Quantity %3 should be less than the Total Shipment Qty. %4 for Shipment Document No.%1,Shipment Document Line No.%2',
                                 EXIMPackingLines."LFS Shipment Document No.", EXIMPackingLines."LFS Shipment Document Line No.", VarSumQty, EXIMPackingLines."LFS Total Shipment Qty.");
                        until EXIMPackingLines.Next() = 0;

                    Rec."LFS Status" := Rec."LFS Status"::Released;
                    Rec.Modify();

                    CurrPage.Update();
                end;
            }
            action(Post)
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Ellipsis = true;
                trigger OnAction()
                var
                    EXIMMngt: Codeunit "LFS EXIM General Functions";
                begin
                    Rec.TestField("LFS Status", Rec."LFS Status"::Released);
                    if not Confirm('Do you want to Post the packing List?', false) then
                        exit;

                    EXIMMngt."LFS PostCustomPackingDocument"(Rec);
                    CurrPage.Update();
                end;

            }

        }

    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."LFS Type" := Rec."LFS Type"::Custom;
    end;
}