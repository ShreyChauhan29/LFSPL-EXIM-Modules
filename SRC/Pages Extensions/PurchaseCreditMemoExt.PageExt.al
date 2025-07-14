namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.Document;

pageextension 72018 "LFS Purchase Credit Memo Ext." extends "Purchase Credit Memo"
{
    actions
    {
        modify(GetPostedDocumentLinesToReverse)
        {
            trigger OnAfterAction()
            var
                ImportLicense: Record "LFS EXIM Import License";
                PostedImportLicences: Record "LFS EXIM Posted Import Licence";
                PurchCrMemoLine: Record "Purchase Line";
            // lineNo: Integer;
            begin
                PurchCrMemoLine.SetRange("Document No.", Rec."No.");
                PurchCrMemoLine.SetRange("Document Type", Rec."Document Type");
                if PurchCrMemoLine.Findset() then
                    repeat
                        PostedImportLicences.SetRange("LFS Source No.", PurchCrMemoLine."LFS Source No.");
                        PostedImportLicences.SetRange("LFS Source line No.", PurchCrMemoLine."LFS Source Line No.");
                        if PostedImportLicences.Findset() then
                            repeat
                                ImportLicense."LFS Source Type" := ImportLicense."LFS Source Type"::"Credit Memo";
                                ImportLicense."LFS Source No." := PurchCrMemoLine."Document No.";
                                ImportLicense."LFS Source line No." := PurchCrMemoLine."Line No.";
                                ImportLicense."LFS Line No." := PostedImportLicences."LFS Line No.";
                                ImportLicense."LFS Quantity" := PostedImportLicences."LFS Quantity";
                                ImportLicense."LFS License Type" := PostedImportLicences."LFS License Type";
                                ImportLicense."LFS License No." := PostedImportLicences."LFS License No.";
                                ImportLicense."LFS Item No." := PostedImportLicences."LFS Item No.";
                                ImportLicense."LFS Import Inv Bal Qty" := PostedImportLicences."LFS Import Inv Bal Qty";
                                ImportLicense."LFS CIF Value (FCY)" := PostedImportLicences."LFS CIF Value (FCY)";
                                ImportLicense."LFS EXIM Item Group" := PostedImportLicences."LFS EXIM Item Group";
                                ImportLicense.Insert();
                            until PostedImportLicences.Next() = 0;
                    until PurchCrMemoLine.Next() = 0;
            end;

        }
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                CheckMultipleLicenseTotalQty();
            end;
        }
        modify(Preview)
        {
            trigger OnBeforeAction()
            begin
                CheckMultipleLicenseTotalQty();
            end;
        }
    }
    local procedure CheckMultipleLicenseTotalQty()
    var
        EXIM_License: Record "LFS EXIM Import License";
        PurchCrLine: Record "Purchase Line";
        // EximLicense1: Record "LFS EXIM Import License";
        // eximLicenseHeader: Record "LFS EXIM  License Header";
        sumQty: Decimal;
    begin

        PurchCrLine.SetRange("Document No.", Rec."No.");
        PurchCrLine.SetRange("Document Type", Rec."Document Type");
        if PurchCrLine.Findset() then
            repeat
                sumQty := 0;
                EXIM_License.SetRange("LFS Source No.", PurchCrLine."Document No.");
                EXIM_License.SetRange("LFS Source line No.", PurchCrLine."Line No.");
                if EXIM_License.Findset() then
                    repeat
                        sumQty += EXIM_License."LFS Quantity";
                    until EXIM_License.Next() = 0;
                if (sumQty > PurchCrLine.Quantity) then
                    Error('Total License Quantity should not exceed the Credit line quantity');
            until PurchCrLine.Next() = 0;
    end;
}