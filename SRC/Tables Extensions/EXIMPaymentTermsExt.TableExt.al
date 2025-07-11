namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Foundation.PaymentTerms;

tableextension 72033 "LFS EXIM Payment Terms Ext." extends "Payment Terms"
{
    fields
    {
        field(72000; "LFS Calc. Based On Inv. Date"; Boolean)
        {
            Caption = 'Calc. Based On Inv. Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if Rec."LFS Calc. Based On BL Date" = true then
                    Error('Calculate based on BL Date is alrady true.');
            end;
        }
        field(72001; "LFS Calc. Based On BL Date"; Boolean)
        {
            Caption = 'Calc. Based On BL Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if Rec."LFS Calc. Based On Inv. Date" = true then
                    Error('Calculate based on Invoice Date is alrady true.');
            end;
        }
    }
}
