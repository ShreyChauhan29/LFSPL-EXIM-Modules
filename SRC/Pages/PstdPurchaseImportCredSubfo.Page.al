namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Purchases.History;
using Microsoft.Finance.Dimension;

page 72071 LFSPstdPurchaseImportCredSubfo
{
    ApplicationArea = All;
    Caption = 'Posted Purchase Import Credit Subform';
    PageType = ListPart;
    AutoSplitKey = true;
    DeleteAllowed = false;
    LinksAllowed = false;
    SourceTable = "Purch. Cr. Memo Line";
    SourceTableView = where("LFS EXIM Type" = FILTER(Import));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Type';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the No.';
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the IC Partner Code';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    Visible = true;
                    ToolTip = 'Specifies the Variant Code';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Description';
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Return Reason Code';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    ToolTip = 'Specifies the Quantity';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Unit of Measure Code';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Unit of Measure';
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    ToolTip = 'Specifies the Direct Unit Cost';
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Indirect Cost %';
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Unit Cost (LCY)';
                }
                field("Unit Price (LCY)"; REc."Unit Price (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Unit Price (LCY)';
                }
                field("Line Amount"; REc."Line Amount")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    ToolTip = 'Specifies the Line Amount';
                }
                field("Line Discount %"; REc."Line Discount %")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    ToolTip = 'Specifies the Line Discount %';
                }
                field("Line Discount Amount"; REc."Line Discount Amount")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Line Discount Amount';
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Allow Invoice Disc.';
                }
                field("GST Credit"; Rec."GST Credit")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the GST Credit';
                }
                field("GST Group Code"; Rec."GST Group Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the GST Group Code';
                }
                field("GST Group Type"; Rec."GST Group Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the GST Group Type';
                }
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the HSN/SAC Code';
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Job No.';
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Prod. Order No.';
                }
                field("Insurance No."; Rec."Insurance No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Insurance No.';
                }
                field("Budgeted FA No."; Rec."Budgeted FA No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Budgeted FA No.';
                }
                field("FA Posting Type"; Rec."FA Posting Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the FA Posting Type';
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Depr. until FA Posting Date';
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Depreciation Book Code';
                }
                field("Depr. Acquisition Cost"; Rec."Depr. Acquisition Cost")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Depr. Acquisition Cost';
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the Appl.-to Item Entry';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shortcut Dimension 1 Code';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shortcut Dimension 2 Code';
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
                action(Dimensions)
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'Specifies the Dimensions';
                    trigger OnAction()
                    begin
                        Rec.ShowDimensions();
                    end;
                }
                action(Comments)
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    ToolTip = 'Specifies the Comments';
                    trigger OnAction()
                    begin
                        Rec.ShowLineComments();
                    end;
                }
                action(ItemTrackingEntries)
                {
                    ApplicationArea = All;
                    Caption = 'Item &Tracking Entries';
                    Image = ItemTrackingLedger;
                    ToolTip = 'Specifies the Item &Tracking Entries';
                    trigger OnAction()
                    begin
                        Rec.ShowItemTrackingLines();
                    end;
                }
                action(ItemReturnShipmentLines)
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData "Return Shipment Header" = R;
                    Caption = 'Item Return Shipment &Lines';
                    ToolTip = 'Specifies the Item Return Shipment &Lines';
                    Image = ReturnShipment;
                    trigger OnAction()
                    begin
                        if NOT (Rec.Type IN [Rec.Type::Item, Rec.Type::"Charge (Item)"]) then
                            Rec.TESTFIELD(Type);
                        Rec.ShowItemReturnShptLines();
                    end;
                }
                action(DeferralSchedule)
                {
                    ApplicationArea = All;
                    Caption = 'Deferral Schedule';
                    Image = PaymentPeriod;
                    ToolTip = 'Specifies the Deferral Schedule';
                    trigger OnAction()
                    begin
                        Rec.ShowDeferrals();
                    end;
                }
            }
        }
    }
}