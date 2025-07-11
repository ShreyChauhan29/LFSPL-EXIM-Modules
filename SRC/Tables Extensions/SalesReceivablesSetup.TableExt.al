namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.Setup;
using Microsoft.Inventory.Requisition;

tableextension 72026 "LFS Sales & Receivables Setup" extends "Sales & Receivables Setup"
{
    fields
    {
        field(72000; "LFS WorkSheet Template Name"; Code[20])
        {
            Caption = 'WorkSheet Template Name';
            DataClassification = CustomerContent;
            TableRelation = "Requisition Line"."Worksheet Template Name";
        }
    }
}
