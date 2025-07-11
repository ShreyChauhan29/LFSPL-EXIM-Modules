namespace LFSEximModule.LFSPLEXIMModule;

page 72029 LFSEXIMPostedCustomPackingCard
{
    ApplicationArea = All;
    Caption = 'EXIM Posted Custom Packing Card';
    PageType = Card;
    SourceTable = "LFS EXIM Packing Header";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
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
            }
            part("LFS EXIM PosCustom Packing Subpage"; "LFSEXIMPosCustomPackingSubpage")
            {
                ApplicationArea = all;
                SubPageLink = "LFS Type" = field("LFS Type"), "LFS Packing List No." = field("LFS Packing List No.");
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."LFS Type" := Rec."LFS Type"::Custom;
    end;
}