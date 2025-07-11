namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.Payables;

pageextension 72033 "LFS Vendor Ledger Entries Ext." extends "Vendor Ledger Entries"
{
    layout
    {
        moveafter("Document No."; "Invoice Received Date")
        modify("Invoice Received Date")
        {
            Caption = 'Vendor Invoice Date';
        }
    }
}