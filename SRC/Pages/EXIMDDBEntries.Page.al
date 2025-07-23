namespace LFSEximModule.LFSPLEXIMModule;

page 72005 "LFS EXIM DDB Entries"
{
    ApplicationArea = All;
    Caption = 'EXIM  DDB Entries';
    PageType = List;
    SourceTable = "LFS EXIM DDB Entry";
    UsageCategory = Lists;
    InsertAllowed = false;
    ModifyAllowed = true;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document Type"; Rec."LFS Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document No."; Rec."LFS Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."LFS Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Type"; Rec."LFS Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No."; Rec."LFS No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec."LFS Description")
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit of Measure"; Rec."LFS Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Quantity; Rec."LFS Quantity")
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("FCY Amount"; Rec."LFS FCY Amount")
                {
                    ToolTip = 'Specifies the value of the FCY Amount field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("LCY Amount"; Rec."LFS LCY Amount")
                {
                    ToolTip = 'Specifies the value of the LCY Amount field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("LFS FOB Amount (FCY)"; Rec."LFS FOB Amount (FCY)")
                {
                    ToolTip = 'Specifies the value of the FOB (FCY) Per Unit field.', Comment = '%';
                    Editable = false;
                }
                field("CIF FCY Amount"; Rec."LFS CIF FCY Amount")
                {
                    ToolTip = 'Specifies the value of the CIF FCY Amount field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("LFS CIF LCY Amount"; Rec."LFS CIF LCY Amount")
                {
                    ToolTip = 'Specifies the value of the CIF LCY Amount field.', Comment = '%';
                    Editable = false;
                }
                field("LFS CIF Amount (FCY)"; Rec."LFS CIF Amount (FCY)")
                {
                    ToolTip = 'Specifies the value of the CIF (FCY) Per Unit field.', Comment = '%';
                    Editable = false;
                }
                field("Freight Value (FCY)"; Rec."LFS Freight Value (FCY)")
                {
                    ToolTip = 'Specifies the value of the Freight Value (FCY) field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Freight Value (LCY)"; Rec."LFS Freight Value (LCY)")
                {
                    ToolTip = 'Specifies the value of the Freight Value (LCY) field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Insurance Value (FCY)"; Rec."LFS Insurance Value (FCY)")
                {
                    ToolTip = 'Specifies the value of the Insurance Value (FCY) field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Insurance Value (LCY)"; Rec."LFS Insurance Value (LCY)")
                {
                    ToolTip = 'Specifies the value of the Insurance Value (LCY) field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Custom Exch. Rate"; Rec."LFS Custom Exch. Rate")
                {
                    ToolTip = 'Specifies the value of the Custom Exch. Rate field.';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Incentive Type"; Rec."LFS Incentive Type")
                {
                    ToolTip = 'Specifies the value of the Incentive Type field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Claim DDB"; Rec."LFS Claim DDB")
                {
                    ToolTip = 'Specifies the value of the Claim DDB field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("DDB %"; Rec."LFS DDB %")
                {
                    ToolTip = 'Specifies the value of the DDB % field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("DDB Value FCY"; Rec."LFS DDB Value FCY")
                {
                    ToolTip = 'Specifies the value of the DDB Value FCY field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("DDB Value LCY"; Rec."LFS DDB Value LCY")
                {
                    ToolTip = 'Specifies the value of the DDB Value LCY field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("LFS Actual DDB Value"; Rec."LFS Actual DDB Value")
                {
                    ToolTip = 'Specifies the value of the Actual DDB Value field.', Comment = '%';
                }
                // field("Shipping Bill No."; Rec."LFS Shipping Bill No.")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the Shipping Bill No.';
                //     Editable = false;
                // }
                // field("Shipping Bill Date"; Rec."LFS Shipping Bill Date")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the Shipping Bill Date';
                //     Editable = false;
                // }
                // field("Late export order No."; Rec."LFS Late export order No.")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                //     Visible = false;
                //     ToolTip = 'Specifies the Late export order No.';
                // }
                // field("Late export order date"; Rec."LFS Late export order date")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                //     Visible = false;
                //     ToolTip = 'Specifies the Late export order date';
                // }
                field("Bill No."; Rec."LFS bill No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Bill No.';
                    Editable = false;
                }
                field("Bill Date"; Rec."LFS bill Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Bill Date';
                    Editable = false;
                }
            }
        }
    }
}