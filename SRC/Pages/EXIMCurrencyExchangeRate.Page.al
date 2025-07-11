namespace LFSEximModule.LFSPLEXIMModule;

page 72004 "LFSEXIM Currency Exchange Rate"
{
    ApplicationArea = All;
    Caption = 'EXIM Currency Exchange Rate';
    PageType = List;
    SourceTable = "LFSEXIM Currency Exchange Rate";
    UsageCategory = Lists;
    DataCaptionFields = "LFS Currency Code";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Starting Date"; Rec."LFS Starting Date")
                {
                    ToolTip = 'Specifies the value of the Starting Date field.';
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."LFS Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                    ApplicationArea = All;
                }
                field("Exchange Rate Amount (Imp)"; Rec."LFS Exch Rate Amount (Imp)")
                {
                    ToolTip = 'Specifies the value of the Exchange Rate Amount (Imp) field.';
                    ApplicationArea = All;
                }
                field("Relational Exch Rate Amt (Imp)"; Rec."LFS Rel Exch Rate Amt (Imp)")
                {
                    ToolTip = 'Specifies the value of the Relational Exch Rate Amt (Imp) field.';
                    ApplicationArea = All;
                }
                field("Exchange Rate Amount (Exp)"; Rec."LFS Exch Rate Amount (Exp)")
                {
                    ToolTip = 'Specifies the value of the Exchange Rate Amount (Exp) field.';
                    ApplicationArea = All;
                }
                field("Relational Exch Rate Amt (Exp)"; Rec."LFS Rel Exch Rate Amt (Exp)")
                {
                    ToolTip = 'Specifies the value of the Relational Exch Rate Amt (Exp) field.';
                    ApplicationArea = All;
                }
                field("Fix Exchange Rate Amount"; Rec."LFS Fix Exch Rate Amount")
                {
                    ToolTip = 'Specifies the value of the Fix Exchange Rate Amount field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        CurrExchRate: Record "LFSEXIM Currency Exchange Rate";
    begin
        CurrExchRate := xRec;
        if not BelowxRec then begin
            CurrExchRate.CopyFilters(Rec);
            if CurrExchRate.Next(-1) <> 0 then
                Rec.TransferFields(CurrExchRate, false)
        end else
            Rec.TransferFields(CurrExchRate, false);
    end;
}
