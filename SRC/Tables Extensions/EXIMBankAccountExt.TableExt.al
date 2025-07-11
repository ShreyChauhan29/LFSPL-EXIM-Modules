namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Bank.BankAccount;

tableextension 72000 "LFS EXIM Bank Account Ext." extends "Bank Account"
{
    fields
    {
        field(72000; "LFS AD Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Authorized Dealer code';
        }
    }
}
