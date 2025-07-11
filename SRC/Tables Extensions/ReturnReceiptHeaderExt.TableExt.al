namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.History;
using Microsoft.Purchases.Vendor;

tableextension 72016 "LFS Return Receipt Header Ext." extends "Return Receipt Header"
{
    fields
    {
        field(72047; "LFS Commission Agent"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Commission Agent Domestic';
            trigger OnLookup()
            var
                vendor: Record Vendor;
            begin
                if vendor.Findset() then
                    if page.Runmodal(page::"Vendor List", vendor) = action::LookupOK then
                        Rec."LFS Commission Agent" := vendor."No.";
            end;
        }
        field(72048; "LFS Comm. Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Commission Amount Domestic';
        }
    }
}