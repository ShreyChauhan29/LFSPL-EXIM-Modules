namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.Vendor;

tableextension 72029 "LFS EXIM Vendor Ext." extends Vendor
{
    fields
    {
        field(72000; "LFS Agent Code"; Boolean)
        {
            Caption = 'Agent Code';
            DataClassification = CustomerContent;
        }
    }
}
