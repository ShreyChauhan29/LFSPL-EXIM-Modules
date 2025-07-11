namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Foundation.UOM;
using Microsoft.Finance.Currency;
using Microsoft.Inventory.Item;
table 72019 "LFS EXIM License IO Details"
{
    Caption = 'EXIM License IO Details';
    DataClassification = CustomerContent;
    DrillDownPageId = "LFS EXIM Lic. IO Detail List";

    fields
    {
        field(1; "LFS Adv. License No."; Code[20])
        {
            Caption = 'Adv. License No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                EXIMAdvLicenseHeader1: Record "LFS EXIM License Header";
            begin
                EXIMAdvLicenseHeader1.Get("LFS Adv. License No.");
                "LFS Currency Code" := EXIMAdvLicenseHeader1."LFS Currency Code";
            end;
        }
        field(2; "LFS Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "LFS Type"; Enum "LFS EXIM Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                IODetails: Record "LFS EXIM License IO Details";
            begin
                if Rec."LFS Item No." <> '' then
                    IODetails.SetRange("LFS Adv. License No.", Rec."LFS Adv. License No.");
                IODetails.SetRange("LFS Type", Rec."LFS Type");
                IODetails.SetRange("LFS Item No.", Rec."LFS Item No.");
                if not IODetails.IsEmpty() then
                    Error('Same Item already exists for this license type');
            end;
        }
        field(4; "LFS Item Type"; Code[20])
        {
            Caption = 'Item Type';
            TableRelation = "LFS EXIM Item Group"."LFS Code" where("LFS EXIM Type" = field("LFS Type"));
            DataClassification = CustomerContent;
        }
        field(5; "LFS Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                IODetails: Record "LFS EXIM License IO Details";
            begin
                IODetails.SetRange("LFS Adv. License No.", Rec."LFS Adv. License No.");
                IODetails.SetRange("LFS Type", Rec."LFS Type");
                IODetails.SetRange("LFS Item No.", Rec."LFS Item No.");
                if not IODetails.IsEmpty() then
                    Error('Same Item already exists for this license type');
                if Item.Get("LFS Item No.") then begin
                    "LFS Item Description" := Item.Description;
                    "LFS UOM" := Item."Base Unit of Measure";
                end;
                if "LFS Item No." = '' then begin
                    "LFS Item Description" := '';
                    "LFS UOM" := '';
                end;
            end;
        }
        field(6; "LFS Item Description"; Text[100])
        {
            Caption = 'Item Description';
            DataClassification = CustomerContent;
        }
        field(7; "LFS UOM"; Code[20])
        {
            Caption = 'UOM';
            TableRelation = "Unit of Measure".Code;
            DataClassification = CustomerContent;
        }
        field(8; "LFS Qty."; Decimal)
        {
            Caption = 'Qty.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestField("LFS Consumed Export Qty.", 0);
                TestField("LFS Consumed Import Qty.", 0);
                if Rec."LFS Type" = rec."LFS Type"::Import then begin
                    CalcFields("LFS Consumed Import Qty.");
                    "LFS Import Inv Bal Qty" := "LFS Qty." - "LFS Consumed Import Qty.";
                end;
                if Rec."LFS Type" = rec."LFS Type"::Export then begin
                    CalcFields("LFS Consumed Export Qty.");
                    "LFS Export Inv Bal Qty" := "LFS Qty." - "LFS Consumed Export Qty.";
                end;
            end;
        }
        field(9; "LFS Currency Code"; Code[20])
        {
            Caption = 'Currency Code';
            TableRelation = Currency.Code;
            DataClassification = CustomerContent;
        }
        field(10; "LFS FOB Value"; Decimal)
        {
            Caption = 'FOB Value';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                EXIMAdvLicenseHeader.Reset();
                EXIMAdvLicenseHeader.SetRange("LFS No.", Rec."LFS Adv. License No.");
                if EXIMAdvLicenseHeader.FindFirst() then
                    "LFS FOB Value (LCY)" := "LFS FOB Value" * EXIMAdvLicenseHeader."LFS Export Exchange Rate";
            end;
        }
        field(11; "LFS CIF Value"; Decimal)
        {
            Caption = 'CIF Value';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                EXIMAdvLicenseHeader.Reset();
                EXIMAdvLicenseHeader.SetRange("LFS No.", Rec."LFS Adv. License No.");
                if EXIMAdvLicenseHeader.FindFirst() then
                    "LFS CIF Value (LCY)" := "LFS CIF Value" * EXIMAdvLicenseHeader."LFS Import Exchange Rate";
            end;
        }
        field(12; "LFS Consumed Export Qty."; Decimal)
        {
            AutoFormatType = 1;
            FieldClass = FlowField;
            CalcFormula = sum("LFS EXIM License Lines"."LFS Qty." where("LFS Adv. License No." = field("LFS Adv. License No."),
                                                                    "LFS Type" = field("LFS Type"),
                                                                    "LFS Item No." = field("LFS Item No."),
                                                                    "LFS EXIM Item Group" = field("LFS Item Type"),
                                                                    "LFS Isexport" = filter(true)));
            Editable = false;
            Caption = 'Consumed Export Qty.';

        }
        field(13; "LFS Consumed FOB Value"; Decimal)
        {
            Caption = 'Consumed FOB Value';
            FieldClass = FlowField;
            CalcFormula = sum("LFS EXIM License Lines"."LFS FOB Value" where("LFS Adv. License No." = field("LFS Adv. License No."),
                                                                            "LFS Type" = field("LFS Type"),
                                                                             "LFS Item No." = field("LFS Item No."),
                                                                            "LFS EXIM Item Group" = field("LFS Item Type"),
                                                                            "LFS Isexport" = filter(true)));
            Editable = false;
        }
        field(14; "LFS Consumed Import Qty."; Decimal)
        {
            AutoFormatType = 1;
            FieldClass = FlowField;
            CalcFormula = sum("LFS EXIM License Lines"."LFS Qty." where("LFS Adv. License No." = field("LFS Adv. License No."),
                                                                    "LFS Type" = field("LFS Type"),
                                                                    "LFS Item No." = field("LFS Item No."),
                                                                    "LFS EXIM Item Group" = field("LFS Item Type"),
                                                                    "LFS IsImport" = filter(true)));
            Caption = 'Consumed Import Qty.';
            Editable = false;
        }
        field(15; "LFS Consumed CIF Value"; Decimal)
        {
            Caption = 'Consumed CIF Value';
            FieldClass = FlowField;
            CalcFormula = sum("LFS EXIM License Lines"."LFS CIF Value" where("LFS Adv. License No." = field("LFS Adv. License No."),
                                                                            "LFS Type" = field("LFS Type"),
                                                                             "LFS Item No." = field("LFS Item No."),
                                                                                       "LFS EXIM Item Group" = field("LFS Item Type"),
                                                                                       "LFS IsImport" = filter(true)));
            Editable = false;
        }
        field(16; "LFS Currency Factor"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            MinValue = 0;
            Editable = false;
        }
        field(17; "LFS FOB Value (LCY)"; Decimal)
        {
            Caption = 'FOB Value (LCY)';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(18; "LFS CIF Value (LCY)"; Decimal)
        {
            Caption = 'CIF Value (LCY)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(19; "LFS Export Inv Bal Qty"; Decimal)
        {
            Caption = 'Export Inv Bal Qty';
            DataClassification = CustomerContent;
        }
        field(20; "LFS Import Inv Bal Qty"; Decimal)
        {
            Caption = 'Import Inv Bal Qty';
            DataClassification = CustomerContent;
        }
        field(21; "LFS Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            DataClassification = CustomerContent;
        }
        field(22; "LFS Scheme Type"; Option)
        {
            Caption = 'Scheme Type';
            OptionMembers = " ","Advance License",RoDTEP;
            OptionCaption = ' ,Advance License,RoDTEP';
            DataClassification = CustomerContent;
        }
        field(23; "LFS Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = " ",Created,Active,Closed;
            OptionCaption = ' ,Created,Active,Closed';
            DataClassification = CustomerContent;
        }
        field(24; "LFS IsExport"; Boolean)
        {
            Caption = 'Is Export';
            DataClassification = CustomerContent;
        }
        field(25; "LFS IsImport"; Boolean)
        {
            Caption = 'Is Import';
            DataClassification = CustomerContent;
        }
        field(26; "LFS Norm Factor"; Decimal)
        {
            Caption = 'Norm Factor';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                LicenseIO: Record "LFS EXIM License IO Details";
                Qty: Decimal;
            begin
                LicenseIO.Reset();
                LicenseIO.SetRange("LFS Adv. License No.", Rec."LFS Adv. License No.");
                LicenseIO.SetRange("LFS Type", LicenseIO."LFS Type"::Export);
                if LicenseIO.Findset() then begin
                    repeat
                        Qty += LicenseIO."LFS Qty.";
                    until LicenseIO.Next() = 0;
                    Rec."LFS Qty." := Qty * Rec."LFS Norm Factor";
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "LFS Adv. License No.", "LFS Line No.")
        {
            Clustered = true;
        }
        key(Key2; "LFS Item Type")
        {
        }
    }

    trigger OnInsert()
    begin
        GetAdvLicHdr();
        "LFS Currency Factor" := EXIMAdvLicenseHeader."LFS Currency Factor";
        "LFS Currency Code" := EXIMAdvLicenseHeader."LFS Currency Code";
        "LFS Status" := EXIMAdvLicenseHeader."LFS Status";
        "LFS Scheme Type" := EXIMAdvLicenseHeader."LFS Scheme Type";
    end;

    trigger OnModify()
    begin
        EXIMAdvLicenseHeader.Reset();
        EXIMAdvLicenseHeader.SetRange("LFS No.", "LFS Adv. License No.");
        EXIMAdvLicenseHeader.SetRange("LFS Status", EXIMAdvLicenseHeader."LFS Status"::Created);
        if NOT EXIMAdvLicenseHeader.FindFirst() then
            Error('Status must be in created stage');
    end;

    trigger OnDelete()
    begin
        EXIMAdvLicenseHeader.Reset();
        EXIMAdvLicenseHeader.Get("LFS Adv. License No.");
        if EXIMAdvLicenseHeader."LFS Status" <> EXIMAdvLicenseHeader."LFS Status"::Created then
            Error('Status must be in created stage');

        TestField("LFS Consumed Export Qty.", 0);
        TestField("LFS Consumed Import Qty.", 0);
    end;

    var
        Item: Record Item;
        EXIMAdvLicenseHeader: Record "LFS EXIM License Header";

    procedure GetAdvLicHdr();
    begin
        EXIMAdvLicenseHeader.Get("LFS Adv. License No.");
    end;
}