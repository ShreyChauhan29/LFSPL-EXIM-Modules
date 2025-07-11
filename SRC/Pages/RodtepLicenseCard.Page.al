namespace LFSEximModule.LFSPLEXIMModule;

page 72051 "LFS Rodtep License Card"
{
    ApplicationArea = All;
    Caption = 'Rodtep License Card';
    PageType = Card;
    SourceTable = "LFS Rodtep License Header";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."LFS No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the No.';
                }
                field(Description; Rec."LFS Description")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Description';
                }
                field("Issue Date"; Rec."LFS Issue Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Issue Date';
                }
                field("Expiry Date"; Rec."LFS Expiry Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Expiry Date';
                }
                field(Status; Rec."LFS Status")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Status';
                }
                field(Remarks; Rec."LFS Remarks")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Remarks';
                }
                field("Rodtep Value LCY"; Rec."LFS Rodtep Value LCY")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Rodtep Value LCY';
                }
                field("Balance LCY"; Rec."LFS Balance LCY")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Balance LCY';
                }
                field("Consumed Rodtep Value LCY"; Rec."LFS Con Rodtep Value LCY")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Consumed Rodtep Value LCY';
                }
            }
            part("LFS Rodtep License Subform"; "LFS Rodtep License Subform")
            {
                ApplicationArea = all;
                Caption = 'Lines';
                SubPageLink = "LFS License No." = field("LFS No.");
            }
            part("EXIM RoDTEP Rebate Entries Lin"; "EXIM RoDTEP Rebate Entrie Line")
            {
                ApplicationArea = all;
                Caption = 'Rodtep Entries';
                SubPageLink = "LFS License No." = field("LFS No.");
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec."LFS Balance LCY" := rec."LFS Rodtep Value LCY" - Rec."LFS Con Rodtep Value LCY";
        Rec.Modify();
    end;
}