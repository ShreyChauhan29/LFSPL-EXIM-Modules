namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Foundation.NoSeries;
using Microsoft.Finance.Currency;
table 72018 "LFS EXIM License Header"
{
    Caption = 'EXIM License Header';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "LFS No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; "LFS Description"; Text[80])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "LFS Issue Date"; Date)
        {
            Caption = 'Issue Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                eximSetup: Record "LFS EXIM Setup";
            begin
                eximsetup.Get();
                Rec."LFS Export Validity Date" := CalcDate(format(eximSetup."LFS Export Validate Date"), Rec."LFS Issue Date");
                Rec."LFS Import Validity Date" := CalcDate(format(eximSetup."LFS Import Validate Date"), Rec."LFS Issue Date")
            end;
        }
        field(4; "LFS Expiry Date"; Date)
        {
            Caption = 'Expiry Date';
            DataClassification = CustomerContent;
        }
        field(5; "LFS Export Validity Date"; Date)
        {
            Caption = 'Export Obligation Validity Date';
            DataClassification = CustomerContent;
        }
        field(6; "LFS Export Extension No."; Text[30])
        {
            Caption = 'Export Extension No.';
            DataClassification = CustomerContent;
        }
        field(7; "LFS Export Extension Date"; Date)
        {
            Caption = 'Export Extension Date';
            DataClassification = CustomerContent;
        }
        // field(8; "LFS Export Expiry Date"; Date)
        // {
        //     Caption = 'Export Expiry Date';
        //     DataClassification = CustomerContent;
        // }
        field(9; "LFS Import Validity Date"; Date)
        {
            Caption = 'Import Validity Date';
            DataClassification = CustomerContent;
        }
        field(10; "LFS Import Extension No."; Text[30])
        {
            Caption = 'Import Extension No.';
            DataClassification = CustomerContent;
        }
        field(11; "LFS Import Extension Date"; Date)
        {
            Caption = 'Import Extension Date';
            DataClassification = CustomerContent;
        }
        // field(12; "LFS Import Expiry Date"; Date)
        // {
        //     Caption = 'Import Expiry Date';
        //     DataClassification = CustomerContent;
        // }
        field(13; "LFS Status"; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionMembers = " ",Created,Active,Closed;
            OptionCaption = ' ,Created,Active,Closed';
        }
        field(14; "LFS Export Type"; Option)
        {
            Caption = 'Export Type';
            DataClassification = CustomerContent;
            OptionMembers = " ",Normal,Deemed;
            OptionCaption = 'Normal,Deemed';
        }
        field(15; "LFS Item Type"; Code[20])
        {
            Caption = 'Item Type';
            TableRelation = "LFS EXIM Item Group"."LFS Code";
            DataClassification = CustomerContent;
        }
        field(16; "LFS Adv. Lic Export Qty."; Decimal)
        {
            FieldClass = FlowField;
            Caption = 'I/O Export Qty.';
            CalcFormula = sum("LFS EXIM License IO Details"."LFS Qty." where("LFS Adv. License No." = field("LFS No."),
                                                                            "LFS Type" = const(Export)));
            Editable = false;
        }
        field(17; "LFS Adv. Lic Exp FOB Value"; Decimal)
        {
            FieldClass = FlowField;
            Caption = 'I/O Export FOB Value (FCY)';
            CalcFormula = sum("LFS EXIM License IO Details"."LFS FOB Value" where("LFS Adv. License No." = field("LFS No."),
                                                                            "LFS Type" = const(Export)));
            Editable = false;
        }
        field(18; "LFS Export Order FOB Value"; Decimal)
        {
            Caption = 'Export Order FOB Value';
            FieldClass = FlowField;
            CalcFormula = sum("LFS EXIM License Lines"."LFS FOB Value" where("LFS Adv. License No." = field("LFS No."),
                                                                            "LFS Type" = const(Export),
                                                                            "LFS Document Type" = const(Order)));
            Editable = false;
        }
        field(19; "LFS Export Inv FOB Value"; Decimal)
        {
            FieldClass = FlowField;
            Caption = 'Export Invoiced FOB Value (FCY)';
            CalcFormula = sum("LFS EXIM License Lines"."LFS FOB Value" where("LFS Adv. License No." = field("LFS No."),
                                                                        "LFS Type" = const(Export),
                                                                        "LFS Document Type" = filter("Posted Invoice" | Opening | "Credit Memo")));
            Editable = false;
        }
        field(20; "LFS Export Order Qty."; Decimal)
        {
            Caption = 'Export Order Qty.';
            FieldClass = FlowField;
            CalcFormula = sum("LFS EXIM License Lines"."LFS Qty." where("LFS Adv. License No." = field("LFS No."),
                                                                    "LFS Type" = const(Export),
                                                                    "LFS Document Type" = const(Order)));
            Editable = false;
        }
        field(21; "LFS Export Invoice Qty."; Decimal)
        {
            Caption = 'Export Invoiced Qty.';
            FieldClass = FlowField;
            CalcFormula = sum("LFS EXIM License Lines"."LFS Qty." where("LFS Adv. License No." = field("LFS No."),
                                                                        "LFS Type" = const(Export),
                                                                        "LFS Document Type" = filter("Posted Invoice" | Opening | "Credit Memo")));
            Editable = false;
        }
        field(22; "LFS Adv. License Imp Qty."; Decimal)
        {
            FieldClass = FlowField;
            Caption = 'I/O Import Qty.';
            CalcFormula = sum("LFS EXIM License IO Details"."LFS Qty." where("LFS Adv. License No." = field("LFS No."),
                                                                        "LFS Type" = const(Import)));
            Editable = false;
        }
        field(23; "LFS Adv. Lic Imp CIF Value"; Decimal)
        {
            FieldClass = FlowField;
            Caption = 'I/O Import CIF Value (FCY)';
            CalcFormula = sum("LFS EXIM License IO Details"."LFS CIF Value" where("LFS Adv. License No." = field("LFS No."),
                                                                                "LFS Type" = const(Import)));
            Editable = false;
        }
        field(24; "LFS Import Order CIF Value"; Decimal)
        {
            Caption = 'Import Order CIF Value';
            FieldClass = FlowField;
            CalcFormula = sum("LFS EXIM License Lines"."LFS CIF Value" where("LFS Adv. License No." = field("LFS No."),
                                                                            "LFS Type" = const(Import),
                                                                            "LFS Document Type" = const(Order)));
            Editable = false;
        }
        field(25; "LFS Import Inv CIF Value"; Decimal)
        {

            FieldClass = FlowField;
            Caption = 'Import Invoiced CIF Value (FCY)';
            CalcFormula = sum("LFS EXIM License Lines"."LFS CIF Value" where("LFS Adv. License No." = field("LFS No."),
                                                                            "LFS Type" = const(Import),
                                                                            "LFS Document Type" = filter("Posted Invoice" | Opening | "Credit Memo")));
            Editable = false;
        }
        field(26; "LFS Import Order Qty."; Decimal)
        {
            Caption = 'Import Order Qty.';
            FieldClass = FlowField;
            CalcFormula = sum("LFS EXIM License Lines"."LFS Qty." where("LFS Adv. License No." = field("LFS No."),
                                                                        "LFS Type" = const(Import),
                                                                        "LFS Document Type" = const(Order)));
            Editable = false;
        }
        field(27; "LFS Import Invoice Qty."; Decimal)
        {
            Caption = 'Import Invoiced Qty.';
            FieldClass = FlowField;
            CalcFormula = sum("LFS EXIM License Lines"."LFS Qty." where("LFS Adv. License No." = field("LFS No."),
                                                                        "LFS Type" = const(Import),
                                                                        "LFS Document Type" = filter("Posted Invoice" | Opening | "Credit Memo")));
            Editable = false;
        }
        field(28; "LFS Export Order CIF Value"; Decimal)
        {
            Caption = 'Export Order CIF Value';
            FieldClass = FlowField;
            CalcFormula = sum("LFS EXIM License Lines"."LFS CIF Value" where("LFS Adv. License No." = field("LFS No."),
                                                                            "LFS Type" = const(Export),
                                                                            "LFS Document Type" = const(Order)));
            Editable = false;
        }
        field(29; "LFS Export Inv CIF Value"; Decimal)
        {
            FieldClass = FlowField;
            Caption = 'Export Invoiced CIF Value (FCY)';
            CalcFormula = sum("LFS EXIM License Lines"."LFS CIF Value" where("LFS Adv. License No." = field("LFS No."),
                                                                            "LFS Type" = const(Export),
                                                                            "LFS Document Type" = filter("Posted Invoice" | Opening | "Credit Memo")));
            Editable = false;
        }
        field(30; "LFS Import Order FOB Value"; Decimal)
        {
            Caption = 'Import Order FOB Value';
            FieldClass = FlowField;
            CalcFormula = sum("LFS EXIM License Lines"."LFS FOB Value" where("LFS Adv. License No." = field("LFS No."),
                                                                            "LFS Type" = const(Import),
                                                                            "LFS Document Type" = const(Order)));
            Editable = false;
        }
        field(31; "LFS Import Inv FOB Value"; Decimal)
        {
            FieldClass = FlowField;
            Caption = 'Import Invoiced FOB Value (FCY)';
            CalcFormula = sum("LFS EXIM License Lines"."LFS FOB Value" where("LFS Adv. License No." = field("LFS No."),
                                                                            "LFS Type" = const(Import),
                                                                            "LFS Document Type" = filter("Posted Invoice" | Opening | "Credit Memo")));
            Editable = false;
        }
        field(32; "LFS Currency Code"; Code[10])
        {
            TableRelation = Currency;
            Caption = 'Currency Code';
            DataClassification = CustomerContent;

        }
        field(33; "LFS Exchange Rate"; Decimal)
        {
            Caption = 'Exchange Rate';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "LFS Exchange Rate" <> 0 then
                    "LFS Currency Factor" := 1 / "LFS Exchange Rate"
                else
                    "LFS Currency Factor" := 1;
                UpdateCurrFactor();
            end;
        }
        field(34; "LFS Currency Factor"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            MinValue = 0;
            Editable = false;
        }
        field(35; "LFS Adv. Lic. FOB Value LCY"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("LFS EXIM License IO Details"."LFS FOB Value (LCY)" where("LFS Adv. License No." = field("LFS No."),
                                                                                    "LFS Type" = const(Export)));
            Caption = 'I/O Export FOB Value (LCY)';
            Editable = false;
        }
        field(36; "LFS Adv. Lic. CIF Value LCY"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("LFS EXIM License IO Details"."LFS CIF Value (LCY)" where("LFS Adv. License No." = field("LFS No."),
                                                                                        "LFS Type" = const(Import)));
            Caption = 'I/O Import CIF Value (LCY)';
            Editable = false;
        }
        field(37; "LFS Import Order Bal Qty"; Decimal)
        {
            Caption = 'Import Ordered Balance Qty.';
            DataClassification = CustomerContent;
        }
        field(38; "LFS Import Inv Bal Qty"; Decimal)
        {
            Caption = 'Import Inv Bal Qty';
            DataClassification = CustomerContent;
        }
        field(40; "LFS Export Inv Bal Qty"; Decimal)
        {
            Caption = 'Export Invoiced Balance Qty.';
            DataClassification = CustomerContent;
        }
        // field(41; "LFS Adv. Lic File No."; Text[30])
        // {
        //     Caption = 'File No.';
        //     DataClassification = CustomerContent;
        // }
        field(42; "LFS Application No."; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Application No.';
        }
        field(43; "LFS Application Date"; Date)
        {
            Caption = 'Application Date';
            DataClassification = CustomerContent;
        }
        field(44; "LFS Redemption Date"; Date)
        {
            Caption = 'Redemption Date';
            DataClassification = CustomerContent;
        }
        field(45; "LFS Redemption Type"; Option)
        {
            Caption = 'Redemption Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Applied';
            OptionMembers = " ",Applied;
        }
        field(46; "LFS Export Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Export Quantity';
        }
        field(47; "LFS Export FOB Value FCY"; Decimal)
        {
            Caption = 'Export FOB Value (FCY)';
            DataClassification = CustomerContent;
        }
        field(48; "LFS Export FOB Value LCY"; Decimal)
        {
            Caption = 'Export FOB Value (LCY)';
            DataClassification = CustomerContent;
        }
        field(49; "LFS Import Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Import Quantity';
        }
        field(50; "LFS Import CIF Value FCY"; Decimal)
        {
            Caption = 'Import CIF Value (FCY)';
            DataClassification = CustomerContent;
        }
        field(51; "LFS Import CIF Value LCY"; Decimal)
        {
            Caption = 'Import CIF Value (LCY)';
            DataClassification = CustomerContent;
        }
        field(52; "LFS License Type"; Option)
        {
            Caption = 'License Type';
            DataClassification = CustomerContent;
            OptionMembers = "Advance Authorization",DFIA,Others;
            OptionCaption = 'Advance Authorization,DFIA,Others';
        }
        field(53; "LFS LUT No."; Code[30])
        {
            Caption = 'LUT No.';
            DataClassification = CustomerContent;
        }
        field(54; "LFS LUT Date"; Date)
        {
            Caption = 'LUT Date';
            DataClassification = CustomerContent;
        }
        field(55; "LFS LUT Status"; option)
        {
            Caption = 'LUT Status';
            DataClassification = CustomerContent;
            OptionMembers = Active,Expired;
            OptionCaption = 'Active,Expired';
        }
        field(56; "LFS LUT Amount"; decimal)
        {
            Caption = 'LUT Amount';
            DataClassification = CustomerContent;
        }
        field(57; "LFS Scheme Type"; Option)
        {
            Caption = 'Scheme Type';
            DataClassification = CustomerContent;
            OptionMembers = SION,"Self-Declared",Others;
            OptionCaption = 'SION,Self-Declared,Others';
        }
        field(58; "LFS Import Exchange Rate"; Decimal)
        {
            Caption = 'Import Exchange Rate';
            DataClassification = CustomerContent;
        }
        field(59; "LFS Export Exchange Rate"; decimal)
        {
            Caption = 'Export Exchange Rate';
            DataClassification = CustomerContent;
        }
        field(60; "LFS File No."; Code[20])
        {
            Caption = 'File No.';
            DataClassification = CustomerContent;
        }
        field(61; "LFS SION No."; Text[50])
        {
            Caption = 'SION No.';
            DataClassification = CustomerContent;
        }
        field(62; "LFS DGFT Status"; Option)
        {
            Caption = 'DGFT Status';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Submitted,Approved,Rejected';
            OptionMembers = " ","Submitted","Approved","Rejected";
        }
    }

    keys
    {
        key(Key1; "LFS No.")
        {
            Clustered = true;
        }
    }
    trigger OnModify()
    // var
    //     myInt: Integer;
    begin
        if rec."LFS Status" = Rec."LFS Status"::Active then
            Error('You Cannot edit an Active license');
    end;

    trigger OnInsert()
    begin
        if "LFS No." = '' then begin
            EXIMSetup.Get();
            EXIMSetup.TestField("LFS Adv. License Nos.");
            "LFS No." := NoSerMngt.GetNextNo(EXIMSetup."LFS Adv. License Nos.", Today, true);
        end;
    end;

    trigger OnDelete()
    begin
        if Rec."LFS Status" = Rec."LFS Status"::Active then
            Error('You Cannot delete an Active license');

        TestField("LFS Import Order Qty.", 0);
        TestField("LFS Export Order Qty.", 0);

        EXIMAdvLicenseLines.Reset();
        EXIMAdvLicenseLines.SetRange(EXIMAdvLicenseLines."LFS Adv. License No.", "LFS No.");
        if EXIMAdvLicenseLines.Findset() then
            EXIMAdvLicenseLines.DeleteAll();
        EXIMAdvLicenseIODetails.Reset();
        EXIMAdvLicenseIODetails.SetRange("LFS Adv. License No.", "LFS No.");
        if EXIMAdvLicenseIODetails.Findset() then
            EXIMAdvLicenseIODetails.DeleteAll();
    end;


    var
        EXIMAdvLicenseIODetails: Record "LFS EXIM License IO Details";
        EXIMAdvLicenseLines: Record "LFS EXIM License Lines";
        EXIMSetup: Record "LFS EXIM Setup";
        // EXIMiodetails: Record "LFS EXIM License IO Details";
        NoSerMngt: Codeunit "No. Series";

    procedure AssistEdit(OldEXIMAdvLicHdr: Record "LFS EXIM License Header"): Boolean;
    begin
        EXIMSetup.GET();
        EXIMSetup.TESTFIELD("LFS Adv. License Nos.");
        if NoSerMngt.LookupRelatedNoSeries(EXIMSetup."LFS Adv. License Nos.", EXIMSetup."LFS Adv. License Nos.", EXIMSetup."LFS Adv. License Nos.") then begin
            EXIMSetup.GET();
            EXIMSetup.TESTFIELD("LFS Adv. License Nos.");
            // NoSerMngt.SetSeries("LFS No.");
            Rec.Validate("LFS No.", NoSerMngt.GetNextNo(EXIMSetup."LFS Adv. License Nos.", WorkDate()));
            EXIT(true);
        end;
    end;

    local procedure UpdateCurrFactor();
    begin
        EXIMAdvLicenseIODetails.Reset();
        EXIMAdvLicenseIODetails.SETRANGE(EXIMAdvLicenseIODetails."LFS Adv. License No.", "LFS No.");
        EXIMAdvLicenseIODetails.MODIFYALL(EXIMAdvLicenseIODetails."LFS Currency Factor", "LFS Currency Factor");
    end;
}