namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Foundation.Company;

tableextension 72001 "LFS Company Information Ext." extends "Company Information"
{
    fields
    {
        field(72000; "LFS R.B.I. CODE NO."; Code[20])
        {
            Caption = 'R.B.I. CODE NO.';
            DataClassification = CustomerContent;
        }
        field(72001; "LFS I.E.C. CODE NO."; code[20])
        {
            Caption = 'I.E.C. CODE NO.';
            DataClassification = CustomerContent;
        }
    }
}
