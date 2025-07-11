namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.Document;

tableextension 72034 "LFS Item ChargeAssignPurch Ext" extends "Item Charge Assignment (Purch)"
{
    fields
    {
        field(72000; "LFS Import & Domestic"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Import & Domestic';
        }
    }
}
