namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Foundation.PaymentTerms;

pageextension 72035 "LFS EXIM Payment Terms Ext." extends "Payment Terms"
{
    layout
    {
        addlast(Control1)
        {

            field("LFS Calc. Based On BL Date"; Rec."LFS Calc. Based On BL Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the LFS Calc. Based On BL Date field.', Comment = '%';
            }
            field("LFS Calc. Based On Inv. Date"; Rec."LFS Calc. Based On Inv. Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the LFS Calc. Based On Inv. Date field.', Comment = '%';
            }
        }
    }
}
