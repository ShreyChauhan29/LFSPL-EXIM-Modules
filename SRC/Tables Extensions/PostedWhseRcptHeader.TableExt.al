namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Warehouse.History;
using Microsoft.Purchases.Vendor;

tableextension 72005 "LFS Posted Whse. Rcpt. Header" extends "Posted Whse. Receipt Header"
{
    fields
    {
        field(72000; "LFS Challan No."; Code[20])
        {
            Caption = 'Challan No.';
            DataClassification = CustomerContent;
        }
        field(72001; "LFS Challan Date"; Date)
        {
            Caption = 'Challan Date';
            DataClassification = CustomerContent;
        }
        field(72002; "LFS Invoice No."; Code[20])
        {
            Caption = 'Invoice No.';
            DataClassification = CustomerContent;
        }
        field(72003; "LFS Driver Name"; Text[100])
        {
            Caption = 'Driver Name';
            DataClassification = CustomerContent;
        }
        field(72004; "LFS Driver License No."; Code[30])
        {
            Caption = 'Driver License No.';
            DataClassification = CustomerContent;
        }
        field(72005; "LFS Commission Agent"; Code[20])
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
        field(72006; "LFS Comm. Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Commission Amount Domestic';
        }
    }
}