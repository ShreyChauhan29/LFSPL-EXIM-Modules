namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.Document;

pageextension 72021 "LFSEXIM Sales Credit Memo Ext." extends "Sales Credit Memo"
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
    actions
    {
        modify(GetPostedDocumentLinesToReverse)
        {
            trigger OnAfterAction()
            var
                ExportLicense: Record "LFS EXIM Export License";
                PostedExportLicences: Record "LFS EXIM Posted Export Licence";
                SalesCrMemoLine: Record "Sales Line";
            // lineNo: Integer;
            begin
                SalesCrMemoLine.SetRange("Document Type", Rec."Document Type");
                SalesCrMemoLine.SetRange("Document No.", Rec."No.");
                if SalesCrMemoLine.Findset() then
                    repeat
                        PostedExportLicences.SetRange("LFS Source No.", SalesCrMemoLine."LFS Source No.");
                        PostedExportLicences.SetRange("LFS Source line No.", SalesCrMemoLine."LFS Source Line No.");
                        if PostedExportLicences.Findset() then
                            repeat
                                ExportLicense."LFS Source No." := SalesCrMemoLine."Document No.";
                                ExportLicense."LFS Source line No." := SalesCrMemoLine."Line No.";
                                ExportLicense."LFS Line No." := PostedExportLicences."LFS Line No.";
                                ;
                                ExportLicense.Insert();
                                ExportLicense."LFS Source Type" := ExportLicense."LFS Source Type"::"Credit Memo";
                                ExportLicense."LFS Quantity" := PostedExportLicences."LFS Quantity";
                                ExportLicense."LFS License Type" := PostedExportLicences."LFS License Type";
                                ExportLicense."LFS License No." := PostedExportLicences."LFS License No.";
                                ExportLicense."LFS Item No." := PostedExportLicences."LFS Item No.";
                                ExportLicense."LFS FOB (FCY)" := PostedExportLicences."LFS FOB (FCY)";
                                ExportLicense."LFS Export Inv Bal Qty" := PostedExportLicences."LFS Export Inv Bal Qty";
                                // ExportLicense."LFS EXIM Item Group" := PostedExportLicences."LFS EXIM Item Group";
                                ExportLicense."LFS Exim Group No." := SalesCrMemoLine."LFS Exim Group No.";
                                ExportLicense.modify();
                            until PostedExportLicences.Next() = 0;
                    until SalesCrMemoLine.Next() = 0;
            end;
        }
        modify(Post)
        {
            trigger OnbeforeAction()
            begin
                CheckMultipleLicenseTotalQty();
            end;
        }
        modify("Preview Posting")
        {
            trigger OnBeforeAction()
            begin
                CheckMultipleLicenseTotalQty();
            end;
        }
    }
    local procedure CheckMultipleLicenseTotalQty()
    var
        EXIM_License: Record "LFS EXIM Export License";
        SalesCrLine: Record "Sales Line";
        // EximLicense1: Record "LFS EXIM Export License";
        // eximLicenseHeader: Record "LFS EXIM  License Header";
        sumQty: Decimal;
    begin

        SalesCrLine.SetRange("Document No.", Rec."No.");
        SalesCrLine.SetRange("Document Type", Rec."Document Type");
        if SalesCrLine.Findset() then
            repeat
                sumQty := 0;
                EXIM_License.SetRange("LFS Source No.", SalesCrLine."Document No.");
                EXIM_License.SetRange("LFS Source line No.", SalesCrLine."Line No.");
                if EXIM_License.Findset() then
                    repeat
                        sumQty += EXIM_License."LFS Quantity";
                    until EXIM_License.Next() = 0;

                if (sumQty > SalesCrLine.Quantity) then
                    Error('Total License quantity should not exceed the Credit line quantity');
            until SalesCrLine.Next() = 0;
    end;
}