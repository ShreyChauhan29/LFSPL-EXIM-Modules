namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Purchases.Vendor;
using Microsoft.Foundation.NoSeries;
table 72021 "LFS EXIM Packing Header"
{
    Caption = 'EXIM Packing Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "LFS Type"; Option)
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            OptionMembers = " ",Custom,Commercial;
            OptionCaption = ' ,Custom,Commercial';
        }
        field(2; "LFS Packing List No."; Code[20])
        {
            Caption = 'Packing List No.';
            DataClassification = CustomerContent;
        }
        field(3; "LFS Total Shipment Qty."; Decimal)
        {
            Caption = 'Total Shipment Qty.';
            FieldClass = FlowField;
            CalcFormula = sum("LFS EXIM Packing Lines"."LFS Total Shipment Qty." where("LFS Type" = field("LFS Type"),
                                                                                "LFS Packing List No." = field("LFS Packing List No."),
                                                                                "LFS Parent Line No." = filter(= 0)));
            Editable = false;
        }
        field(4; "LFS Status"; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionMembers = " ",Open,Released;
            OptionCaption = ' ,Open,Released';
        }
        field(5; "LFS ExportShipment/Invoice No."; Code[20])
        {
            Caption = 'Export Shipment / Invoice No.';
            DataClassification = CustomerContent;
        }
        field(6; "LFS ExportShipment/InvoiceDate"; Date)
        {
            Caption = 'Export Shipment / Invoice Date';
            DataClassification = CustomerContent;
        }
        field(7; "LFS Shipping Bill No."; Code[20])
        {
            Caption = 'Shipping Bill No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateLines(Format("LFS Shipping Bill No."));
            end;
        }
        field(8; "LFS Shipping Bill Date"; Date)
        {
            Caption = 'Shipping Bill Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateLines(Format("LFS Shipping Bill Date"));
            end;
        }
        field(9; "LFS Commercial Packing No."; Code[20])
        {
            Caption = 'Commercial Packing No.';
            FieldClass = FlowField;
            CalcFormula = lookup("LFS EXIM Packing Lines"."LFS Packing List No." where("LFS Type" = const(Commercial),
                                                                                "LFS Custom Packing No." = field("LFS Packing List No.")));
            Editable = false;
        }
        field(10; "LFS Posted"; Boolean)
        {
            Caption = 'Posted';
            DataClassification = CustomerContent;
        }
        field(24; "LFS Container No."; Code[30])
        {
            Caption = 'Container No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateLines(Format("LFS Container No."));
            end;
        }
        field(25; "LFS Container Size"; Code[30])
        {
            Caption = 'Container Size';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateLines(Format("LFS Container Size"));
            end;
        }
        field(26; "LFS Trailor No."; Code[30])
        {
            Caption = 'Trailor No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateLines(Format("LFS Trailor No."));
            end;
        }
        field(27; "LFS Vehicle No."; Code[30])
        {
            Caption = 'Vehicle No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UpdateLines(Format("LFS Vehicle No."));
            end;
        }
        field(28; "LFS Agent Seal No."; Code[30])
        {
            Caption = 'Agent Seal No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateLines(Format("LFS Agent Seal No."));
            end;
        }
        field(29; "LFS RFID E-Seal Nos."; Text[30])
        {
            Caption = 'RFID E-Seal Nos.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UpdateLines(Format("LFS RFID E-Seal Nos."));
            end;
        }
        field(30; "LFS Rotation No."; Code[30])
        {
            Caption = 'Rotation No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateLines(Format("LFS Rotation No."));
            end;
        }
        field(31; "LFS Shipping Line"; Code[20])
        {
            Caption = 'Shipping Line';
            TableRelation = "LFS EXIM Shipping Line";
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UpdateLines(Format("LFS Shipping Line"));
            end;
        }
        field(32; "LFS Vessel / Flight Details"; Text[30])
        {
            Caption = 'Vessel / Flight Details';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateLines(Format("LFS Vessel / Flight Details"));
            end;
        }
        field(33; "LFS Carriage"; Option)
        {
            Caption = 'Carriage';
            DataClassification = CustomerContent;
            OptionMembers = "By Sea","By Air","By Rail","By Road",Other;
            OptionCaption = ' ,By Sea,By Air,By Rail,By Road,Other';

            trigger OnValidate()
            begin
                UpdateLines(Format("LFS Carriage"));
            end;
        }
        field(34; "LFS ETD"; Date)
        {
            Caption = 'ETD';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UpdateLines(Format("LFS ETD"));
            end;
        }
        field(35; "LFS ETA"; Date)
        {
            Caption = 'ETA';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateLines(Format("LFS ETA"));
            end;
        }
        field(36; "LFS Date of Stuffing"; Date)
        {
            Caption = 'Date of Stuffing';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UpdateLines(Format("LFS Date of Stuffing"));
            end;
        }
        field(37; "LFS Port Cut Off"; Date)
        {
            Caption = 'Port Cut Off';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UpdateLines(Format("LFS Port Cut Off"));
            end;
        }
        field(38; "LFS Forwarder No."; Code[20])
        {
            Caption = 'Forwarder No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateLines(Format("LFS Forwarder No."));
            end;
        }
        field(39; "LFS CHA No."; Code[20])
        {
            Caption = 'CHA No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateLines(Format("LFS CHA No."));
            end;
        }
        field(40; "LFS Transporter No."; Code[20])
        {
            Caption = 'Transporter No.';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UpdateLines(Format("LFS Transporter No."));
            end;
        }
        field(41; "LFS QC Vendor No."; Code[20])
        {
            Caption = 'QC Vendor No.';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UpdateLines(Format("LFS QC Vendor No."));
            end;
        }
        field(42; "LFS BL No."; Code[20])
        {
            Caption = 'BL No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UpdateLines(Format("LFS BL No."));
            end;
        }
        field(43; "LFS BL Date"; Date)
        {
            Caption = 'BL Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UpdateLines(Format("LFS BL Date"));
            end;
        }
        field(44; "LFS W.T of each Pallet"; Decimal)
        {
            Caption = 'W.T of each Pallet';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UpdateLines(Format("LFS W.T of each Pallet"));
            end;
        }
        field(45; "LFS Pallet Size"; Text[50])
        {
            Caption = 'Pallet Size';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UpdateLines(Format("LFS Pallet Size"));
            end;
        }
        field(46; "LFS Bag Size"; Text[50])
        {
            Caption = 'Bag Size';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UpdateLines(Format("LFS Bag Size"));
            end;
        }
        field(47; "LFS Lot No. From to To"; Text[100])
        {
            Caption = 'Lot No. From to To';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UpdateLines(Format("LFS Lot No. From to To"));
            end;
        }
        field(48; "LFS MTG Date"; Code[20])
        {
            Caption = 'MTG Date';
            DataClassification = CustomerContent;
        }
        field(49; "LFS Tare W.T of each Bag(KG)"; Decimal)
        {
            Caption = 'Tare W.T of each Bag(KG)';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UpdateLines(Format("LFS Tare W.T of each Bag(KG)"));
            end;
        }
        field(50; "LFS Packing Date"; Date)
        {
            Caption = 'Packing Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateLines(Format("LFS Packing Date"));
            end;
        }
        field(51; "LFS Sales Shipment Doc. No."; code[50])
        {
            Caption = 'Sales Shipment Doc. No.';
            FieldClass = FlowField;
            CalcFormula = lookup("LFS EXIM Packing Lines"."LFS Shipment Document No." where("LFS Packing List No." = field("LFS Packing List No."),
            "LFS Shipment Document No." = filter(<> '')));
        }
        field(52; "LFS Total Gross Weight"; Code[20])
        {
            Caption = 'Total Gross Weight';
            DataClassification = CustomerContent;
        }
        field(53; "LFS Total Net Weight"; Code[20])
        {
            Caption = 'Total Net Weight';
            DataClassification = CustomerContent;
        }
        field(54; "LFS Total Tare Weight"; Code[20])
        {
            Caption = 'Total Tare Weight';
            DataClassification = CustomerContent;
        }
        field(55; "LFS Total Corr. Box"; Code[20])
        {
            Caption = 'Total Corr. Box';
            DataClassification = CustomerContent;
        }
        field(56; "LFS Total Cases"; Code[20])
        {
            Caption = 'Total Cases';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "LFS Type", "LFS Packing List No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        EXIMSetup.Get();
        if "LFS Packing List No." = '' then
            if "LFS Type" = "LFS Type"::Custom then begin
                EXIMSetup.TestField("LFS Custom Packing List Nos.");
                "LFS Packing List No." := NoSerMngt.GetNextNo(EXIMSetup."LFS Custom Packing List Nos.", Today, true);
            end else
                if "LFS Type" = "LFS Type"::Commercial then begin
                    EXIMSetup.TestField("LFS Commercial PackList Nos.");
                    "LFS Packing List No." := NoSerMngt.GetNextNo(EXIMSetup."LFS Commercial PackList Nos.", Today, true);
                end;
        Validate("LFS Packing Date", WorkDate());
    end;

    trigger OnDelete()
    begin
        EXIMPackingLines.Reset();
        EXIMPackingLines.SetRange(EXIMPackingLines."LFS Type", "LFS Type");
        EXIMPackingLines.SetRange(EXIMPackingLines."LFS Packing List No.", "LFS Packing List No.");
        EXIMPackingLines.DeleteAll(true);
    end;

    var
        EXIMPackingLines: Record "LFS EXIM Packing Lines";
        EXIMSetup: Record "LFS EXIM Setup";
        NoSerMngt: Codeunit "No. Series";

    procedure AssistEdit(OldEXIMPackingHeader: Record "LFS EXIM Packing Header"): Boolean;
    begin
        EXIMSetup.GET();
        CASE "LFS Type" OF
            "LFS Type"::Custom:
                begin
                    EXIMSetup.TESTFIELD("LFS Custom Packing List Nos.");
                    if NoSerMngt.LookupRelatedNoSeries(EXIMSetup."LFS Custom Packing List Nos.", EXIMSetup."LFS Custom Packing List Nos.", EXIMSetup."LFS Custom Packing List Nos.") then begin
                        EXIMSetup.GET();
                        EXIMSetup.TESTFIELD("LFS Custom Packing List Nos.");
                        // NoSerMngt.SetSeries("Packing List No.");
                        Rec.Validate(Rec."LFS Packing List No.", NoSerMngt.GetNextNo(EXIMSetup."LFS Custom Packing List Nos.", WorkDate(), true));
                        EXIT(true);
                    end;
                end;
            "LFS Type"::Commercial:
                begin
                    EXIMSetup.TESTFIELD("LFS Commercial PackList Nos.");
                    if NoSerMngt.LookupRelatedNoSeries(EXIMSetup."LFS Commercial PackList Nos.", EXIMSetup."LFS Commercial PackList Nos.", EXIMSetup."LFS Commercial PackList Nos.") then begin
                        EXIMSetup.GET();
                        EXIMSetup.TESTFIELD("LFS Commercial PackList Nos.");
                        Rec.Validate(Rec."LFS Packing List No.", NoSerMngt.GetNextNo(EXIMSetup."LFS Commercial PackList Nos.", WorkDate(), true));
                        EXIT(true);
                    end;
                end;
        end;
    end;

    LOCAL procedure UpdateLines(ChangedFieldName: Text[100]);
    VAR
        PackingLines: Record "LFS EXIM Packing Lines";
    begin
        PackingLines.Reset();
        PackingLines.SETRANGE(PackingLines."LFS Type", "LFS Type");
        PackingLines.SETRANGE(PackingLines."LFS Packing List No.", "LFS Packing List No.");
        if NOT PackingLines.FINDFIRST() then
            EXIT;

        PackingLines.RESET();
        PackingLines.SETRANGE(PackingLines."LFS Type", "LFS Type");
        PackingLines.SETRANGE(PackingLines."LFS Packing List No.", "LFS Packing List No.");
        if PackingLines.Findset() then
            repeat
                CASE ChangedFieldName OF
                    FIELDCAPTION("LFS Shipping Bill Date"):
                        PackingLines."LFS Shipping Bill Date" := "LFS Shipping Bill Date";
                    FIELDCAPTION("LFS Shipping Bill No."):
                        PackingLines."LFS Shipping Bill No." := "LFS Shipping Bill No.";
                    FIELDCAPTION("LFS Container No."):
                        PackingLines."LFS Container No." := "LFS Container No.";
                    FIELDCAPTION("LFS Container Size"):
                        PackingLines."LFS Container Size" := "LFS Container Size";
                    FIELDCAPTION("LFS Trailor No."):
                        PackingLines."LFS Trailor No." := "LFS Trailor No.";
                    FIELDCAPTION("LFS Vehicle No."):
                        PackingLines."LFS Vehicle No." := "LFS Vehicle No.";
                    FIELDCAPTION("LFS Agent Seal No."):
                        PackingLines."LFS Agent Seal No." := "LFS Agent Seal No.";
                    FIELDCAPTION("LFS RFID E-Seal Nos."):
                        PackingLines."LFS RFID E-Seal Nos." := "LFS RFID E-Seal Nos.";
                    FIELDCAPTION("LFS Rotation No."):
                        PackingLines."LFS Rotation No." := "LFS Rotation No.";
                    FIELDCAPTION("LFS Shipping Line"):
                        PackingLines."LFS Shipping Line" := "LFS Shipping Line";
                    FIELDCAPTION("LFS Vessel / Flight Details"):
                        PackingLines."LFS Vessel / Flight Details" := "LFS Vessel / Flight Details";
                    FIELDCAPTION("LFS Carriage"):
                        PackingLines."LFS Carriage" := "LFS Carriage";
                    FIELDCAPTION("LFS ETD"):
                        PackingLines."LFS ETD" := "LFS ETD";
                    FIELDCAPTION("LFS ETA"):
                        PackingLines."LFS ETA" := "LFS ETA";
                    FIELDCAPTION("LFS Date of Stuffing"):
                        PackingLines."LFS Date of Stuffing" := "LFS Date of Stuffing";
                    FIELDCAPTION("LFS Port Cut off"):
                        PackingLines."LFS Port Cut off" := "LFS Port Cut off";
                    FIELDCAPTION("LFS Forwarder No."):
                        PackingLines."LFS Forwarder No." := "LFS Forwarder No.";
                    FIELDCAPTION("LFS CHA No."):
                        PackingLines."LFS CHA No." := "LFS CHA No.";
                    FIELDCAPTION("LFS Transporter No."):
                        PackingLines."LFS Transporter No." := "LFS Transporter No.";
                    FIELDCAPTION("LFS QC Vendor No."):
                        PackingLines."LFS QC Vendor No." := "LFS QC Vendor No.";
                    FIELDCAPTION("LFS BL No."):
                        PackingLines."LFS BL No." := "LFS BL No.";
                    FIELDCAPTION("LFS BL Date"):
                        PackingLines."LFS BL Date" := "LFS BL Date";
                    FIELDCAPTION("LFS W.T of each Pallet"):
                        PackingLines.VALIDATE("LFS W.T of Each Pallet", "LFS W.T of each Pallet");
                    FIELDCAPTION("LFS Lot No. From to To"):
                        PackingLines."LFS Lot No. From to To" := "LFS Lot No. From to To";
                    FIELDCAPTION("LFS Tare W.T of each Bag(KG)"):
                        PackingLines.VALIDATE("LFS Tare W.T of each Bag(KG)", "LFS Tare W.T of each Bag(KG)");
                    FIELDCAPTION("LFS Pallet Size"):
                        PackingLines."LFS Pallet Size" := "LFS Pallet Size";
                    FIELDCAPTION("LFS Bag Size"):
                        PackingLines."LFS Bag Size" := "LFS Bag Size";
                    FIELDCAPTION("LFS Packing Date"):
                        PackingLines."LFS Packing Date" := "LFS Packing Date";
                end;
                PackingLines.MODIFY();
            UNTIL PackingLines.Next() = 0;
    end;
}