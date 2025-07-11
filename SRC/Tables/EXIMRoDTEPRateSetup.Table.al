namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Inventory.Item;
using Microsoft.Finance.GST.Base;
table 72024 "LFS EXIM RoDTEP Rate Setup"
{
    Caption = 'EXIM RoDTEP Rate Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "LFS Starting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Starting Date';
        }
        field(2; "LFS Item Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Item;
            Caption = 'Item Code';
            trigger OnValidate()
            begin
                if "LFS HSN No." = '' then begin
                    if xRec."LFS Item Code" <> "LFS Item Code" then
                        if "LFS Item Code" = '' then
                            "LFS Item Description" := ''
                        else begin
                            Item.Get("LFS Item Code");
                            "LFS Item Description" := Item.Description;
                        end;
                end
                else
                    Error('HSN Code already selected.');
            end;
        }
        field(3; "LFS Item Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Item Description';
        }

        field(4; "LFS RoDTEP Rebate Rate %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'RoDTEP Rebate Rate %';
        }
        field(6; "LFS Block"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Block';
        }
        field(5; "LFS HSN No."; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "HSN/SAC".Code;
            Caption = 'HSN/SAC Code';

            trigger OnValidate()
            begin
                if "LFS Item Code" <> '' then
                    Error('Item Code already selected.');
            end;
        }
    }

    keys
    {
        key(Key1; "LFS Starting Date", "LFS Item Code", "LFS HSN No.")
        {
            Clustered = true;
        }
    }
    var
        Item: Record Item;
}