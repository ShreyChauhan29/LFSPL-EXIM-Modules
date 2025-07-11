namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Inventory.Item;
using Microsoft.Finance.GST.Base;
using Microsoft.Foundation.UOM;
table 72027 "LFS EXIM DDB Rate Setup"
{
    Caption = 'EXIM DDB Rate Setup';
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
                            // "LFS Unit of Measure Code" := Item."Base Unit of Measure";
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
        // field(4; "LFS Unit of Measure Code"; Code[20])
        // {
        //     TableRelation = "Unit of Measure".Code;
        //     DataClassification = CustomerContent;
        //     Caption = 'Unit of Measure Code';
        // }
        field(5; "LFS Calculation Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Calculation Type';
            OptionMembers = " ",Percentage,"Rate Per Unit";
            OptionCaption = 'Percentage,Rate Per Unit';
        }
        field(6; "LFS DDB Rate"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'DDB Rate';
        }
        field(7; "LFS HSN No."; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "HSN/SAC".code;
            Caption = 'HSN/SAC Code';

            trigger OnValidate()
            begin
                if "LFS Item Code" <> '' then
                    Error('Item Code already selected.');
            end;
        }
        field(8; "LFS Block"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Block';
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