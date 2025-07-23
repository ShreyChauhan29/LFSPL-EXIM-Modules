namespace LFSEximModule.LFSPLEXIMModule;

page 72039 "LFS EXIM RoDTEP Rebate Entries"
{
    ApplicationArea = All;
    Caption = 'EXIM RoDTEP Rebate Entries';
    PageType = List;
    SourceTable = "LFS EXIM RoDTEP Rebate Entry";
    UsageCategory = Lists;
    SourceTableView = where("LFS License Created" = filter(false));
    InsertAllowed = false;
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
                field("Document Line No."; Rec."LFS Document Line No.")
                {
                    ToolTip = 'Specifies the value of the Document Line No. field.';
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
                field(Rate; Rec."LFS Rate")
                {
                    ToolTip = 'Specifies the value of the Rate field.';
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
                field("FOB (FCY) Per Unit"; Rec."LFS FOB Amount (FCY)")
                {
                    ToolTip = 'Specifies the value of the FOB (FCY) Per Unit field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("CIF (FCY)"; Rec."LFS CIF Value (FCY)")
                {
                    ToolTip = 'Specifies the value of the CIF (FCY) field.', Comment = '%';
                }
                field("CIF (LCY)"; Rec."LFS CIF Value (LCY)")
                {
                    ToolTip = 'Specifies the value of the CIF (LCY) field.', Comment = '%';
                }
                field("CIF (FCY) Per Unit"; Rec."LFS CIF Amount (FCY)")
                {
                    ToolTip = 'Specifies the value of the CIF (FCY) Per Unit field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                // field("LFS Freight Type"; Rec."LFS Freight Type")
                // {
                //     ToolTip = 'Specifies the value of the Freight Type field.', Comment = '%';
                //     Visible = false;
                // }
                field("LFS Freight Value (FCY)"; Rec."LFS Freight Value (FCY)")
                {
                    ToolTip = 'Specifies the value of the Freight Value (FCY) field.', Comment = '%';
                }
                field("LFS Freight Value (LCY)"; Rec."LFS Freight Value (LCY)")
                {
                    ToolTip = 'Specifies the value of the Freight Value (LCY) field.', Comment = '%';
                }
                // field("LFS Insurance Type"; Rec."LFS Insurance Type")
                // {
                //     ToolTip = 'Specifies the value of the Insurance Type field.', Comment = '%';
                //     Visible = false;
                // }
                field("LFS Insurance Value (FCY)"; Rec."LFS Insurance Value (FCY)")
                {
                    ToolTip = 'Specifies the value of the Insurance Value (FCY) field.', Comment = '%';
                }
                field("LFS Insurance Value (LCY)"; Rec."LFS Insurance Value (LCY)")
                {
                    ToolTip = 'Specifies the value of the Insurance Value (LCY) field.', Comment = '%';
                }

                field("Exchange Rate"; Rec."LFS Exchange Rate")
                {
                    ToolTip = 'Specifies the value of the Exchange Rate field.';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("RoDTEP Rebate Rate %"; Rec."LFS RoDTEP Rebate Rate %")
                {
                    ToolTip = 'Specifies the value of the RoDTEP Rebate Rate % field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("RoDTEP Rebate Value FCY"; Rec."LFS RoDTEP Rebate Value FCY")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the RoDTEP Rebate Value FCY';
                    Editable = false;
                }
                field("RoDTEP Rebate Value LCY"; Rec."LFS RoDTEP Rebate Value LCY")
                {
                    ToolTip = 'Specifies the value of the RoDTEP Rebate Value LCY field.';
                    ApplicationArea = All;
                    Editable = false;
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
                    Editable = false;
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
                field("Bill No."; Rec."LFS bill No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Bill No.';
                }
                field("Bill Date"; Rec."LFS bill Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Bill Date';
                }
                field("Select License"; Rec."LFS Select License")
                {
                    ApplicationArea = All;
                    ToolTip = 'Select entires to create Rodtep License for';
                }
                field("License Created"; Rec."LFS License Created")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the License Created';
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Create Rodtep License")
            {
                ApplicationArea = all;
                Image = CreateDocument;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Caption = 'Create Rodtep License';
                ToolTip = 'Specifies the Create Rodtep License';
                trigger OnAction()
                begin
                    Report.Run(Report::"LFS EXIM Create Rodtep License", false, false, Rec);
                    CurrPage.Update();
                end;
            }
        }
    }
}