namespace LFSEximModule.LFSPLEXIMModule;

page 72037 "LFS RoDTEP Entrie with License"
{
    ApplicationArea = All;
    Caption = 'RoDTEP Entrie with License';
    PageType = List;
    SourceTable = "LFS EXIM RoDTEP Rebate Entry";
    UsageCategory = Lists;
    SourceTableView = where("LFS License Created" = filter(true));
    InsertAllowed = false;
    ModifyAllowed = false;
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
                }
                field("Document No."; Rec."LFS Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                    ApplicationArea = All;
                }
                field("Document Line No."; Rec."LFS Document Line No.")
                {
                    ToolTip = 'Specifies the value of the Document Line No. field.';
                    ApplicationArea = All;
                }
                field("License No."; Rec."LFS License No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the License No.';
                }
                field("Posting Date"; Rec."LFS Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                    ApplicationArea = All;
                }
                field("Type"; Rec."LFS Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    ApplicationArea = All;
                }
                field("No."; Rec."LFS No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                }
                field(Description; Rec."LFS Description")
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."LFS Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure field.';
                    ApplicationArea = All;
                }
                field(Quantity; Rec."LFS Quantity")
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                    ApplicationArea = All;
                }
                field(Rate; Rec."LFS Rate")
                {
                    ToolTip = 'Specifies the value of the Rate field.';
                    ApplicationArea = All;
                }
                field("FCY Amount"; Rec."LFS FCY Amount")
                {
                    ToolTip = 'Specifies the value of the FCY Amount field.';
                    ApplicationArea = All;
                }
                field("LCY Amount"; Rec."LFS LCY Amount")
                {
                    ToolTip = 'Specifies the value of the LCY Amount field.';
                    ApplicationArea = All;
                }
                field("Exchange Rate"; Rec."LFS Exchange Rate")
                {
                    ToolTip = 'Specifies the value of the Exchange Rate field.';
                    ApplicationArea = All;
                }
                field("Custom Exchange Rate"; Rec."LFS Custom Exchange Rate")
                {
                    ToolTip = 'Specifies the value of the Custom Exchange Rate field.';
                    ApplicationArea = All;
                }
                field("FOB (FCY) Per Unit"; Rec."LFS FOB Amount (FCY)")
                {
                    ToolTip = 'Specifies the value of the FOB (FCY) Per Unit field.';
                    ApplicationArea = All;
                }
                field("CIF (FCY) Per Unit"; Rec."LFS CIF Amount (FCY)")
                {
                    ToolTip = 'Specifies the value of the CIF (FCY) Per Unit field.';
                    ApplicationArea = All;
                }
                // field("Category Type"; Rec."LFS Category Type")
                // {
                //     ToolTip = 'Specifies the value of the Category Type field.';
                //     ApplicationArea = All;
                // }
                field("RoDTEP Rebate Rate %"; Rec."LFS RoDTEP Rebate Rate %")
                {
                    ToolTip = 'Specifies the value of the RoDTEP Rebate Rate % field.';
                    ApplicationArea = All;
                }
                field("RoDTEP Rebate Value FCY"; Rec."LFS RoDTEP Rebate Value FCY")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the RoDTEP Rebate Value FCY';
                }
                field("RoDTEP Rebate Value LCY"; Rec."LFS RoDTEP Rebate Value LCY")
                {
                    ToolTip = 'Specifies the value of the RoDTEP Rebate Value LCY field.';
                    ApplicationArea = All;
                }
                field("Claim Amount"; Rec."LFS Claim Amount")
                {
                    ToolTip = 'Specifies the value of the Amount to be Claimed.';
                    ApplicationArea = All;
                }
                field("RoDTEP Consumed Amount (LCY)"; Rec."LFS RoDTEP Con Amount (LCY)")
                {
                    ToolTip = 'Specifies the value of the RoDTEP Consumed Amount (LCY) field.';
                    ApplicationArea = All;
                }
                field("Shipping Bill No."; Rec."LFS Shipping Bill No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shipping Bill No. ';
                }
                field("Shipping Bill Date"; Rec."LFS Shipping Bill Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shipping Bill Date';
                }
                field("License Created"; Rec."LFS License Created")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the License Created';
                }
            }
        }
    }
}