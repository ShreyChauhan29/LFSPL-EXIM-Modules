namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.History;

tableextension 72017 "LFS Return Receipt Line Ext." extends "Return Receipt Line"
{
    fields
    {
        field(72051; "LFS RoDTEP License No."; Code[20])
        {
            Caption = 'RoDTEP License No.';
            DataClassification = CustomerContent;
            TableRelation = "LFS Rodtep License Header"."LFS No.";
        }
        field(72052; "LFSRoDTEP License Sales Values"; Decimal)
        {
            Caption = 'RoDTEP License Sales Values';
            DataClassification = CustomerContent;
        }
    }
}