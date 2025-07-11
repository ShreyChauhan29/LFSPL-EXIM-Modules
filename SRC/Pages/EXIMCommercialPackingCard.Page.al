namespace LFSEximModule.LFSPLEXIMModule;

page 72033 "LFS EXIM CommercialPackingCard"
{
    ApplicationArea = All;
    Caption = 'EXIM CommercialPackingCard';
    PageType = Card;
    SourceTable = "LFS EXIM Packing Header";
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
            part("LFS EXIM Commercia Packing Subpage"; "LFSEXIMCommerciaPackingSubpage")
            {
                SubPageLink = "LFS Type" = field("LFS Type"), "LFS Packing List No." = field("LFS Packing List No.");
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
                field("Shipping Line"; Rec."LFS Shipping Line")
                {
                    ToolTip = 'Specifies the value of the Shipping Line field.';
                    ApplicationArea = All;
                }
                field("Vessel / Flight Details"; Rec."LFS Vessel / Flight Details")
                {
                    ToolTip = 'Specifies the value of the Vessel / Flight Details field.';
                    ApplicationArea = All;
                }
                field(Carriage; Rec."LFS Carriage")
                {
                    ToolTip = 'Specifies the value of the Carriage field.';
                    ApplicationArea = All;
                }
                field(ETD; Rec."LFS ETD")
                {
                    ToolTip = 'Specifies the value of the ETD field.';
                    ApplicationArea = All;
                }
                field(ETA; Rec."LFS ETA")
                {
                    ToolTip = 'Specifies the value of the ETA field.';
                    ApplicationArea = All;
                }
                field("Date of Stuffing"; Rec."LFS Date of Stuffing")
                {
                    ToolTip = 'Specifies the value of the Date of Stuffing field.';
                    ApplicationArea = All;
                }
                field("Port Cut Off"; Rec."LFS Port Cut Off")
                {
                    ToolTip = 'Specifies the value of the Port Cut Off field.';
                    ApplicationArea = All;
                }
                field("Forwarder No."; Rec."LFS Forwarder No.")
                {
                    ToolTip = 'Specifies the value of the Forwarder No. field.';
                    ApplicationArea = All;
                }
                field("CHA No."; Rec."LFS CHA No.")
                {
                    ToolTip = 'Specifies the value of the CHA No. field.';
                    ApplicationArea = All;
                }
                field("Transporter No."; Rec."LFS Transporter No.")
                {
                    ToolTip = 'Specifies the value of the Transporter No. field.';
                    ApplicationArea = All;
                }
                field("QC Vendor No."; Rec."LFS QC Vendor No.")
                {
                    ToolTip = 'Specifies the value of the QC Vendor No. field.';
                    ApplicationArea = All;
                }
                field("BL No."; Rec."LFS BL No.")
                {
                    ToolTip = 'Specifies the value of the BL No. field.';
                    ApplicationArea = All;
                }
                field("BL Date"; Rec."LFS BL Date")
                {
                    ToolTip = 'Specifies the value of the BL Date field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Get Custom Packing Lines")
            {
                Image = GetSourceDoc;
                ToolTip = 'Specifies the Get Custom Packing Lines';
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Ellipsis = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    EXIMMngt: Codeunit "LFS EXIM General Functions";
                begin
                    Clear(EXIMMngt);
                    EXIMMngt."LFS GetRelCusPackingLinesCommPacking"(Rec);

                    CurrPage.Update();
                end;
            }
            action(Release)
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the Release';
                Promoted = true;
                Image = ReleaseDoc;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Ellipsis = true;

                trigger OnAction()
                begin
                    Rec."LFS Status" := Rec."LFS Status"::Released;
                    Rec.Modify();

                    CurrPage.Update();
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."LFS Type" := Rec."LFS Type"::Commercial;
    end;
}