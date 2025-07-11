namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Bank.BankAccount;

pageextension 72002 "LFS Bank Account Card Ext." extends "Bank Account Card"
{
    layout
    {
        addafter(IBAN)
        {
            field("LFS AD Code"; Rec."LFS AD Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Authorized Dealer Code';
            }
        }
    }
}
