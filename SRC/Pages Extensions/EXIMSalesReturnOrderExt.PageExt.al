namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.Document;

pageextension 72030 "LFSEXIM Sales Return Order Ext" extends "Sales Return Order"
{
    layout
    {
        modify("Posting Date")
        {
            trigger OnAfterValidate()
            var
                SalesLine: Record "Sales Line";
            begin
                CurrPage.Update(true);
                SalesLine.SetRange("Document No.", Rec."No.");
                SalesLine.SetRange("Document Type", Rec."Document Type");
                if SalesLine.FindSet() then
                    repeat
                        SalesLine.CalculateRoDTEPandDDB();
                    until SalesLine.Next() = 0;
            end;
        }
    }
}