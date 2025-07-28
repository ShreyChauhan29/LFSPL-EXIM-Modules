namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.Document;
using Microsoft.Inventory.Item;

tableextension 72018 "LFS EXIM Sales Line Ext." extends "Sales Line"
{
    fields
    {
        field(72000; "LFS No. of Packages"; Integer)
        {
            Caption = 'No. of Packages';
            DataClassification = CustomerContent;
        }
        // field(72001; "LFS Purity"; Decimal)
        // {
        //     Caption = 'Purity';
        //     DataClassification = CustomerContent;
        // }
        // field(72002; "LFS Total Taxes"; Decimal)
        // {
        //     Caption = 'Total Taxes';
        //     DataClassification = CustomerContent;
        // }
        field(72003; "LFS Container No/Shipp. Marks"; Text[250])
        {
            Caption = 'Container No. & Shipping Marks';
            DataClassification = CustomerContent;
        }
        field(72004; "LFS No. & Kind of Packages"; Text[250])
        {
            Caption = 'No. & Kind of Packages';
            DataClassification = CustomerContent;
        }
        field(72005; "LFS EXIM Type"; Enum "LFS EXIM Type")
        {
            Caption = 'EXIM Type';
            Editable = false;
            Description = 'Lf-EXIM';
            DataClassification = CustomerContent;
        }
        field(72006; "LFS Incentive Type"; Enum "LFS Incentive Type")
        {
            Caption = 'Incentive Type';
            Description = 'Lf-EXIM';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                CalculateRoDTEPandDDB();
            end;
        }
        field(72007; "LFS License Type"; Enum "LFS License Type")
        {
            Caption = 'License Type';
            Description = 'Lf-EXIM';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                Clear("LFS License No.");
            end;
        }
        field(72008; "LFS License No."; Code[20])
        {
            Caption = 'License No.';
            Description = 'Lf-EXIM';
            TableRelation = if ("LFS License Type" = const("Adv. License")) "LFS EXIM License Header";
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                EXIMAdvLicenseIODetails: Record "LFS EXIM License IO Details";
            begin
                if "LFS License No." <> '' then
                    CASE "LFS License Type" OF
                        "LFS License Type"::"Adv. License":
                            begin
                                // EXIMAdvLicenseIODetails.Reset();
                                // EXIMAdvLicenseIODetails.SETRANGE(EXIMAdvLicenseIODetails."LFS Adv. License No.", "LFS License No.");
                                // EXIMAdvLicenseIODetails.SETRANGE(EXIMAdvLicenseIODetails."LFS Item Type", "LFS EXIM Item Group");
                                // if NOT EXIMAdvLicenseIODetails.FINDFIRST() then
                                //     ERROR('Item Group %1 is not defined in the I/O Details of License No. %2', "LFS EXIM Item Group", "LFS License No.");
                                PromptAdvLicUsageMsg();
                                EXIMAdvLicenseIODetails.Reset();
                                EXIMAdvLicenseIODetails.SETRANGE(EXIMAdvLicenseIODetails."LFS Adv. License No.", "LFS License No.");
                                EXIMAdvLicenseIODetails.SETRANGE(EXIMAdvLicenseIODetails."LFS Item No.", "No.");
                                EXIMAdvLicenseIODetails.SetRange("LFS Type", EXIMAdvLicenseIODetails."LFS Type"::Export);
                                EXIMAdvLicenseIODetails.SetAutoCalcFields("LFS Consumed Export Qty.");
                                if EXIMAdvLicenseIODetails.FINDFIRST() then
                                    if (EXIMAdvLicenseIODetails."LFS Qty." + EXIMAdvLicenseIODetails."LFS Consumed Export Qty.") < Rec.Quantity then
                                        Error('Quantity should not exceed more than %1, as defined in EXIM Adv. Lic No.%2',
                                        (EXIMAdvLicenseIODetails."LFS Qty." + EXIMAdvLicenseIODetails."LFS Consumed Import Qty."),
                                         EXIMAdvLicenseIODetails."LFS Adv. License No.");

                            end;
                    end;
            end;

        }
        field(72009; "LFS FOB Amount (FCY)"; Decimal)
        {
            Caption = 'FOB Amount (FCY)';
            DecimalPlaces = 2 : 5;
            Description = 'Lf-EXIM';
            DataClassification = CustomerContent;

        }
        field(72010; "LFS CIF Amount (FCY)"; Decimal)
        {
            Caption = 'CIF Amount (FCY)';
            DecimalPlaces = 2 : 5;
            DataClassification = CustomerContent;
        }
        field(72011; "LFS No. of Container"; Integer)
        {
            Caption = 'No. of Container';
            DataClassification = CustomerContent;
        }
        // field(72012; "LFS Freight Type"; Enum "LFS Freight Type")
        // {
        //     Caption = 'Freight Type';
        //     DataClassification = CustomerContent;
        // }
        field(72013; "LFS Freight Value (LCY)"; Decimal)
        {
            Caption = 'Freight Value (LCY)';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(72014; "LFS Freight Value (FCY)"; Decimal)
        {
            Caption = 'Freight Value (FCY)';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            var
                SalesHeader: Record "Sales Header";
            begin
                FOBvalue();
                CalculateRoDTEPandDDB();
                SalesHeader.Reset();
                SalesHeader.SetRange("No.", Rec."Document No.");
                SalesHeader.SetFilter("LFS Custom Currency Code", '<>%1', '');
                if not SalesHeader.IsEmpty() then begin
                    if (Rec."LFS FOB Currency Factor" <> 0) then
                        Rec."LFS FOB in USD" := (Rec."LFS FOB Amount (LCY)") / Rec."LFS FOB Currency Factor";
                end else
                    if (Rec."LFS FOB Currency Factor" <> 0) then
                        Rec."LFS FOB in USD" := (Rec."Line Amount" - Rec."LFS Insurance Value (FCY)" - Rec."LFS Freight Value (FCY)") / Rec."LFS FOB Currency Factor";
            end;
        }
        // field(72015; "LFS Insurance Type"; Enum "LFS Insurance Type")
        // {
        //     Caption = 'Insurance Type';
        //     DataClassification = CustomerContent;
        // }
        field(72016; "LFS Insurance Value (LCY)"; Decimal)
        {
            Caption = 'Insurance Value (LCY)';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(72017; "LFS Insurance Value (FCY)"; Decimal)
        {
            Caption = 'Insurance Value (FCY)';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            var
                SalesHeader: Record "Sales Header";
            begin
                FOBvalue();
                CalculateRoDTEPandDDB();
                SalesHeader.Reset();
                SalesHeader.SetRange("No.", Rec."Document No.");
                SalesHeader.SetFilter("LFS Custom Currency Code", '<>%1', '');
                if not SalesHeader.IsEmpty() then begin
                    if (Rec."LFS FOB Currency Factor" <> 0) then
                        Rec."LFS FOB in USD" := (Rec."LFS FOB Amount (LCY)") / Rec."LFS FOB Currency Factor";
                end else
                    if (Rec."LFS FOB Currency Factor" <> 0) then
                        Rec."LFS FOB in USD" := (Rec."Line Amount" - Rec."LFS Insurance Value (FCY)" - Rec."LFS Freight Value (FCY)") / Rec."LFS FOB Currency Factor";
            end;
        }
        // field(72018; "LFS Category Type"; Enum "LFS Category Type")
        // {
        //     Caption = 'Category Type';
        //     DataClassification = CustomerContent;
        // }
        // field(72024; "LFS EXIM Remark"; Text[250])
        // {
        //     Caption = 'EXIM Remark';
        //     DataClassification = CustomerContent;
        // }
        // field(72025; "LFS Packing List No."; Code[20])
        // {
        //     Caption = 'Packing List No.';
        //     DataClassification = CustomerContent;
        // }
        field(72026; "LFS Claim DDB"; Boolean)
        {
            Caption = 'Claim DDB';
            DataClassification = CustomerContent;
            Editable = false;
        }
        // field(72027; "LFS Currency Exch. Rate"; Decimal)
        // {
        //     Caption = 'Currency Exch. Rate';
        //     Editable = false;
        //     DataClassification = CustomerContent;
        // }
        field(72028; "LFS Custom Exch. Rate"; Decimal)
        {
            Caption = 'Custom Exch. Rate';
            Editable = false;
            DataClassification = CustomerContent;
        }
        // field(72029; "LFS EXIM Item Group"; Code[20])
        // {
        //     Caption = 'EXIM Item Group';
        //     Editable = false;
        //     TableRelation = "LFS EXIM Item Group";
        //     DataClassification = CustomerContent;
        // }
        // field(72030; "LFS Packing Line Exists"; Boolean)
        // {
        //     Caption = 'Packing Line Exists';
        //     FieldClass = FlowField;
        //     CalcFormula = Exist("LFS EXIM Packing Lines" where("LFS Shipment Document No." = FIELD("Document No."), "LFS Shipment Document Line No." = FIELD("Line No.")));
        //     Editable = false;
        // }
        // field(72031; "LFS Packed Qty."; Decimal)
        // {
        //     Caption = 'Packed Qty.';
        //     DataClassification = CustomerContent;
        // }
        // field(72032; "LFS Rem. Qty. To be Packed"; Decimal)
        // {
        //     Caption = 'Rem. Qty. To be Packed';
        //     DataClassification = CustomerContent;
        // }
        // field(72033; "LFS Shipping Bill No."; Code[50])
        // {
        //     Caption = 'Shipping Bill No.';
        //     DataClassification = CustomerContent;
        // }
        // field(72034; "LFS Shipping Bill Date"; Date)
        // {
        //     Caption = 'Shipping Bill Date';
        //     DataClassification = CustomerContent;
        // }
        field(72035; "LFS RoDTEP Rebate Rate %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'RoDTEP Rebate Rate %';
        }
        field(72036; "LFS RoDTEP Rebate Value"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Editable = false;
            Caption = 'RoDTEP Rebate Value';
        }
        field(72037; "LFS Source No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Source No.';
        }
        field(72038; "LFS Source Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Source Line No.';
        }
        // field(72039; "LFS FOB Amount (LCY)"; decimal)
        // {
        //     DataClassification = CustomerContent;
        //     DecimalPlaces = 0 : 5;
        //     Caption = 'FOB (LC)';
        // }
        // field(72040; "LFS FOB Amount (FCY)"; Decimal)
        // {
        //     DataClassification = CustomerContent;
        //     DecimalPlaces = 0 : 5;
        //     Caption = 'FOB (FC)';
        // }
        field(72041; "LFS DDB Rate"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'DDB Rate';
        }
        field(72042; "LFS DDB Value (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Caption = 'DDB Value (LCY)';
        }
        // field(72043; "LFS Dispatch Instruction"; Text[1000])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Dispatch Instruction';
        // }
        // field(72044; "LFS Packing Details"; Text[500])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Packing Details';
        // }
        // field(72045; "LFS No. & Kind Of PKDG"; Code[50])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'No. & Kind Of PKDG';
        // }
        field(72046; "LFS CIF Value (FCY)"; decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Caption = 'CIF Value (FCY)';
            Editable = false;
        }
        field(72047; "LFS CIF Value (LCY)"; decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Caption = 'CIF Value (LCY)';
            Editable = false;
        }
        field(72048; "LFS FOB CIF Calc. Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'FOB/CIF Calculation Type';
            OptionCaption = 'FOB,CIF';
            OptionMembers = FOB,CIF;
        }
        // field(72049; "LFS Salesperson Comm %"; Decimal)
        // {
        //     Caption = 'Salesperson Commission %';
        //     DataClassification = CustomerContent;
        // }
        // field(72050; "LFS Salesperson Comm Amount"; Decimal)
        // {
        //     Caption = 'Salesperson Commission Amount';
        //     DataClassification = CustomerContent;
        // }
        field(72051; "LFS RoDTEP License No."; Code[20])
        {
            Caption = 'RoDTEP License No.';
            DataClassification = CustomerContent;
            TableRelation = "LFS Rodtep License Header"."LFS No." where("LFS Balance LCY" = filter(<> 0));
            trigger OnValidate()
            var
                RodtepLicenseHeader: Record "LFS Rodtep License Header";
            begin
                if Rec."LFS RoDTEP License No." <> '' then begin
                    RodtepLicenseHeader.SetRange("LFS No.", Rec."LFS RoDTEP License No.");
                    if RodtepLicenseHeader.FindFirst() then begin
                        if Rec."LFSRoDTEP License Sales Values" > RodtepLicenseHeader."LFS Balance LCY" then
                            Error('RoDTEP Sales Amount is Exceeding the License Balance.')
                        else
                            Rec.Validate("LFSRoDTEP License Sales Values", RodtepLicenseHeader."LFS Balance LCY");
                        Rec.Modify();
                    end;
                end else
                    Rec."LFSRoDTEP License Sales Values" := 0;
            end;
        }
        field(72052; "LFSRoDTEP License Sales Values"; Decimal)
        {
            Caption = 'RoDTEP License Sales Values';
            DataClassification = CustomerContent;
        }
        field(72053; "LFS HS Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'HS Code';
        }
        field(72056; "LFS FOB Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 5;
            Caption = 'FOB Amount (LCY)';
        }
        field(72057; "LFS Exim Group No."; Code[20])
        {
            Caption = 'Exim Group No.';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "EXIM Group Master"."LFS Group No.";
        }
        field(72058; "LFS FOB in USD"; decimal)
        {
            Caption = 'FOB in USD';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(72059; "LFS FOB Currency Code"; Code[10])
        {
            Caption = 'FOB Currency Code';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "LFSEXIM Currency Exchange Rate";
        }
        field(72060; "LFS FOB Currency Factor"; Decimal)
        {
            Caption = 'FOB Currency Factor';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 15;
            MinValue = 0;
            trigger OnValidate()
            var
                SalesHeader: Record "Sales Header";
            begin
                SalesHeader.Reset();
                SalesHeader.SetRange("No.", Rec."Document No.");
                SalesHeader.SetFilter("LFS Custom Currency Code", '<>%1', '');
                if not SalesHeader.IsEmpty() then begin
                    if (Rec."LFS FOB Currency Factor" <> 0) then
                        Rec."LFS FOB in USD" := (Rec."LFS FOB Amount (LCY)") / Rec."LFS FOB Currency Factor";
                end else
                    if (Rec."LFS FOB Currency Factor" <> 0) then
                        Rec."LFS FOB in USD" := (Rec."Line Amount" - Rec."LFS Insurance Value (FCY)" - Rec."LFS Freight Value (FCY)") / Rec."LFS FOB Currency Factor";
            end;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                Item: Record Item;
                EXIMCurrExRate: Record "LFSEXIM Currency Exchange Rate";
                // SalesHeader: Record "Sales Header";
                Exc_Rate: Decimal;
            begin
                if (Rec."No." <> '') then begin
                    Clear(Rec."LFS Exim Group No.");
                    if Rec.Type = Rec.Type::Item then begin
                        Item.Get(Rec."No.");
                        Rec."LFS Exim Group No." := Item."LFS Exim Group No.";
                    end;

                    Exc_Rate := 0;
                    Rec.Validate("LFS FOB Currency Code", 'USD');

                    // SalesHeader.Reset();
                    // SalesHeader.SetRange("Document Type", Rec."Document Type");
                    // SalesHeader.SetRange("No.", Rec."Document No.");
                    // if SalesHeader.FindFirst() then;

                    EXIMCurrExRate.Reset();
                    EXIMCurrExRate.SetRange("LFS Currency Code", Rec."LFS FOB Currency Code");
                    EXIMCurrExRate.SetAscending("LFS Starting Date", true);
                    if EXIMCurrExRate.FindLast() then begin
                        Exc_Rate := 1 / EXIMCurrExRate.ExchangeRate(EXIMCurrExRate."LFS Starting Date", Rec."LFS FOB Currency Code", 1);
                        Rec.Validate("LFS FOB Currency Factor", Exc_Rate);
                    end;
                end
                else
                    Rec."LFS Exim Group No." := '';
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                SalesHeader: Record "Sales Header";
            begin
                FOBvalue();
                CalculateRoDTEPandDDB();

                SalesHeader.Reset();
                SalesHeader.SetRange("No.", Rec."Document No.");
                SalesHeader.SetFilter("LFS Custom Currency Code", '<>%1', '');
                if not SalesHeader.IsEmpty() then begin
                    if (Rec."LFS FOB Currency Factor" <> 0) then
                        Rec."LFS FOB in USD" := (Rec."LFS FOB Amount (LCY)") / Rec."LFS FOB Currency Factor";
                end else
                    if (Rec."LFS FOB Currency Factor" <> 0) then
                        Rec."LFS FOB in USD" := (Rec."Line Amount" - Rec."LFS Insurance Value (FCY)" - Rec."LFS Freight Value (FCY)") / Rec."LFS FOB Currency Factor";
            end;
        }

        modify("Unit Price")
        {
            trigger OnAfterValidate()
            var
                SalesHeader: Record "Sales Header";
            begin
                FOBvalue();
                CalculateRoDTEPandDDB();

                SalesHeader.Reset();
                SalesHeader.SetRange("No.", Rec."Document No.");
                SalesHeader.SetFilter("LFS Custom Currency Code", '<>%1', '');
                if not SalesHeader.IsEmpty() then begin
                    if (Rec."LFS FOB Currency Factor" <> 0) then
                        Rec."LFS FOB in USD" := (Rec."LFS FOB Amount (LCY)") / Rec."LFS FOB Currency Factor";
                end else
                    if (Rec."LFS FOB Currency Factor" <> 0) then
                        Rec."LFS FOB in USD" := (Rec."Line Amount" - Rec."LFS Insurance Value (FCY)" - Rec."LFS Freight Value (FCY)") / Rec."LFS FOB Currency Factor";
            end;
        }
        modify("Line Amount")
        {
            trigger OnAfterValidate()
            begin
                FOBvalue();
                CalculateRoDTEPandDDB();
            end;
        }
        modify("HSN/SAC Code")
        {
            trigger OnAfterValidate()
            begin
                CalculateRoDTEPandDDB();
            end;
        }
        modify("Posting Date")
        {
            trigger OnAfterValidate()
            begin
                CalculateRoDTEPandDDB();
            end;
        }
    }
    trigger OnAfterModify()
    var
        RodtepLicenseHeader: Record "LFS Rodtep License Header";
    begin
        if Rec."LFS RoDTEP License No." <> '' then begin
            if Rec."LFSRoDTEP License Sales Values" <> xRec."LFSRoDTEP License Sales Values" then begin
                RodtepLicenseHeader.SetRange("LFS No.", Rec."LFS RoDTEP License No.");
                if RodtepLicenseHeader.FindFirst() then
                    if RodtepLicenseHeader."LFS Balance LCY" < Rec."LFSRoDTEP License Sales Values" then
                        Error('License Sales Value cannot Exceed License Balance.');
            end;
        end
        else
            if Rec."LFSRoDTEP License Sales Values" <> xRec."LFSRoDTEP License Sales Values" then
                Error('RoDTEP License is Blank.');

    end;

    trigger OnDelete()
    var
        ExportLicense: record "LFS EXIM Export License";
    begin
        ExportLicense.SetRange("LFS Source No.", Rec."Document No.");
        ExportLicense.SetRange("LFS Source line No.", Rec."Line No.");
        if ExportLicense.Findset() then
            ExportLicense.DeleteAll();
    end;

    procedure CalculateRoDTEPandDDB()
    var
        ddbSetup: Record "LFS EXIM DDB Rate Setup";
        EXIMRoDTEP: Record "LFS EXIM RoDTEP Rate Setup";
        Salesheader: Record "Sales Header";
    begin
        if Rec."Line No." <> 0 then
            if (Rec."Document Type" = Rec."Document Type"::Invoice) or (Rec."Document Type" = Rec."Document Type"::Order) then begin

                if Rec."LFS Incentive Type" = Rec."LFS Incentive Type"::DDB then begin
                    Rec."LFS Claim DDB" := true;
                    Salesheader.SetRange("No.", Rec."Document No.");
                    Salesheader.SetRange("Document Type", Rec."Document Type");
                    if Salesheader.FindFirst() then begin
                        ddbSetup.SETfilter("LFS Starting Date", '<=%1', Salesheader."Posting Date");
                        ddbSetup.SETRANGE("LFS Item Code", rec."No.");
                        // ddbSetup.SETRANGE("LFS Unit of Measure Code", rec."Unit of Measure Code");
                        ddbSetup.SetCurrentKey("LFS Starting Date");
                        if ddbSetup.FindLast() then begin
                            rec."LFS DDB Rate" := ddbSetup."LFS DDB Rate";
                            if Rec."LFS Custom Exch. Rate" <> 0 then
                                Rec."LFS DDB Value (LCY)" := Rec."LFS FOB Amount (LCY)" * rec."LFS DDB Rate" / 100
                            else
                                rec."LFS DDB Value (LCY)" := ("LFS FOB in USD" * Rec."LFS FOB Currency Factor") * rec."LFS DDB Rate" / 100;
                            // Commit();
                            // Rec.Modify();
                        end
                        else begin
                            rec."LFS Claim DDB" := false;
                            Rec."LFS DDB Rate" := 0;
                            Rec."LFS DDB Value (LCY)" := 0;
                            // Commit();
                            // Rec.Modify();
                            if Rec."HSN/SAC Code" <> '' then begin
                                ddbSetup.Reset();
                                ddbSetup.SETfilter("LFS Starting Date", '<=%1', Salesheader."Posting Date");
                                ddbSetup.SETRANGE("LFS HSN No.", Rec."HSN/SAC Code");
                                // ddbSetup.SetCurrentKey("LFS Starting Date");
                                if ddbSetup.FindLast() then begin
                                    rec."LFS Claim DDB" := true;
                                    Rec."LFS DDB Rate" := ddbSetup."LFS DDB Rate";
                                    if Rec."LFS Custom Exch. Rate" <> 0 then
                                        Rec."LFS DDB Value (LCY)" := Rec."LFS FOB Amount (LCY)" * rec."LFS DDB Rate" / 100
                                    else
                                        rec."LFS DDB Value (LCY)" := ("LFS FOB in USD" * Rec."LFS FOB Currency Factor") * rec."LFS DDB Rate" / 100;
                                    // Commit();
                                    // Rec.Modify();
                                end
                                else begin
                                    rec."LFS Claim DDB" := false;
                                    Rec."LFS DDB Rate" := 0;
                                    Rec."LFS DDB Value (LCY)" := 0;
                                    // Commit();
                                    // Rec.Modify();
                                end;
                            end;
                        end;
                    end;
                end
                else begin
                    rec."LFS Claim DDB" := false;
                    Rec."LFS DDB Rate" := 0;
                    Rec."LFS DDB Value (LCY)" := 0;
                    // Commit();
                    // Rec.Modify();
                end;

                Salesheader.Reset();
                Salesheader.SetRange("No.", Rec."Document No.");
                Salesheader.SetRange("Document Type", Rec."Document Type");
                if Salesheader.FindFirst() then begin
                    EXIMRoDTEP.Reset();
                    EXIMRoDTEP.SetRange("LFS Item Code", Rec."No.");
                    EXIMRoDTEP.SetFilter("LFS Starting Date", '<=%1', Salesheader."Posting Date");
                    EXIMRoDTEP.SetFilter("LFS Block", '%1', False);
                    if EXIMRoDTEP.FindFirst() then begin
                        Rec."LFS RoDTEP Rebate Rate %" := EXIMRoDTEP."LFS RoDTEP Rebate Rate %";
                        if Rec."LFS Custom Exch. Rate" <> 0 then
                            Rec."LFS RoDTEP Rebate Value" := Rec."LFS FOB Amount (LCY)" * (rec."LFS RoDTEP Rebate Rate %" / 100)
                        else
                            Rec."LFS RoDTEP Rebate Value" := ("LFS FOB in USD" * Rec."LFS FOB Currency Factor") * (rec."LFS RoDTEP Rebate Rate %" / 100);
                        // Commit();
                        // Rec.Modify();
                    end
                    else begin
                        Rec."LFS RoDTEP Rebate Rate %" := 0;
                        Rec."LFS RoDTEP Rebate Value" := 0;
                        // Commit();
                        // Rec.Modify();
                        if Rec."HSN/SAC Code" <> '' then begin
                            EXIMRoDTEP.Reset();
                            EXIMRoDTEP.SetRange("LFS HSN No.", Rec."HSN/SAC Code");
                            EXIMRoDTEP.SetFilter("LFS Starting Date", '<=%1', Salesheader."Posting Date");
                            EXIMRoDTEP.SetFilter("LFS Block", '%1', False);
                            if EXIMRoDTEP.FindFirst() then begin
                                Rec."LFS RoDTEP Rebate Rate %" := EXIMRoDTEP."LFS RoDTEP Rebate Rate %";
                                if Rec."LFS Custom Exch. Rate" <> 0 then
                                    Rec."LFS RoDTEP Rebate Value" := Rec."LFS FOB Amount (LCY)" * (rec."LFS RoDTEP Rebate Rate %" / 100)
                                else
                                    Rec."LFS RoDTEP Rebate Value" := ("LFS FOB in USD" * Rec."LFS FOB Currency Factor") * (rec."LFS RoDTEP Rebate Rate %" / 100);
                                // Commit();
                                // Rec.Modify();
                            end
                            else begin
                                Rec."LFS RoDTEP Rebate Rate %" := 0;
                                Rec."LFS RoDTEP Rebate Value" := 0;
                                // Commit();
                                // Rec.Modify();
                            end;
                        end;
                    end;
                end;
            end else

                if (Rec."Document Type" = Rec."Document Type"::"Return Order") or (Rec."Document Type" = Rec."Document Type"::"Credit Memo") then begin

                    if Rec."LFS Incentive Type" = Rec."LFS Incentive Type"::DDB then begin
                        Rec."LFS Claim DDB" := true;
                        Salesheader.SetRange("No.", Rec."Document No.");
                        Salesheader.SetRange("Document Type", Rec."Document Type");
                        if Salesheader.FindFirst() then begin
                            ddbSetup.SETfilter("LFS Starting Date", '<=%1', Salesheader."Posting Date");
                            ddbSetup.SETRANGE("LFS Item Code", rec."No.");
                            // ddbSetup.SETRANGE("LFS Unit of Measure Code", rec."Unit of Measure Code");
                            ddbSetup.SetCurrentKey("LFS Starting Date");
                            ddbSetup.setfilter("LFS block", '<>%1', true);
                            if ddbSetup.FindLast() then begin
                                rec."LFS DDB Rate" := ddbSetup."LFS DDB Rate";
                                if Rec."LFS Custom Exch. Rate" <> 0 then
                                    Rec."LFS DDB Value (LCY)" := Rec."LFS FOB Amount (LCY)" * rec."LFS DDB Rate" / 100
                                else
                                    rec."LFS DDB Value (LCY)" := ("LFS FOB in USD" * Rec."LFS FOB Currency Factor") * rec."LFS DDB Rate" / 100;
                                // Commit();
                                // Rec.Modify();
                            end
                            else begin
                                rec."LFS Claim DDB" := false;
                                Rec."LFS DDB Rate" := 0;
                                Rec."LFS DDB Value (LCY)" := 0;
                                // Commit();
                                // Rec.Modify();
                                if Rec."HSN/SAC Code" <> '' then begin
                                    ddbSetup.Reset();
                                    ddbSetup.SETfilter("LFS Starting Date", '<=%1', Salesheader."Posting Date");
                                    ddbSetup.SETRANGE("LFS HSN No.", Rec."HSN/SAC Code");
                                    // ddbSetup.SetCurrentKey("LFS Starting Date");
                                    ddbSetup.setfilter("LFS block", '<>%1', true);
                                    if ddbSetup.FindLast() then begin
                                        rec."LFS Claim DDB" := true;
                                        Rec."LFS DDB Rate" := ddbSetup."LFS DDB Rate";
                                        if Rec."LFS Custom Exch. Rate" <> 0 then
                                            Rec."LFS DDB Value (LCY)" := Rec."LFS FOB Amount (LCY)" * rec."LFS DDB Rate" / 100
                                        else
                                            rec."LFS DDB Value (LCY)" := ("LFS FOB in USD" * Rec."LFS FOB Currency Factor") * rec."LFS DDB Rate" / 100;
                                        Commit();
                                        // Rec.Modify();
                                    end else begin
                                        rec."LFS Claim DDB" := false;
                                        Rec."LFS DDB Rate" := 0;
                                        Rec."LFS DDB Value (LCY)" := 0;
                                        // Commit();
                                        // Rec.Modify();
                                    end;
                                end;
                            end;
                        end
                    end
                    else begin
                        rec."LFS Claim DDB" := false;
                        Rec."LFS DDB Rate" := 0;
                        Rec."LFS DDB Value (LCY)" := 0;
                        // Commit();
                        // Rec.Modify();
                    end;

                    Salesheader.Reset();
                    Salesheader.SetRange("No.", Rec."Document No.");
                    Salesheader.SetRange("Document Type", Rec."Document Type");
                    if Salesheader.FindFirst() then begin
                        EXIMRoDTEP.Reset();
                        EXIMRoDTEP.SetRange("LFS Item Code", Rec."No.");
                        EXIMRoDTEP.SetFilter("LFS Starting Date", '<=%1', Salesheader."Posting Date");
                        EXIMRoDTEP.SetFilter("LFS Block", '%1', False);
                        if EXIMRoDTEP.FindFirst() then begin
                            Rec."LFS RoDTEP Rebate Rate %" := EXIMRoDTEP."LFS RoDTEP Rebate Rate %";
                            if Rec."LFS Custom Exch. Rate" <> 0 then
                                Rec."LFS RoDTEP Rebate Value" := -Rec."LFS FOB Amount (LCY)" * (rec."LFS RoDTEP Rebate Rate %" / 100)
                            else
                                Rec."LFS RoDTEP Rebate Value" := -("LFS FOB in USD" * Rec."LFS FOB Currency Factor") * (rec."LFS RoDTEP Rebate Rate %" / 100);
                            // Commit();
                            // Rec.Modify();
                        end
                        else begin
                            Rec."LFS RoDTEP Rebate Rate %" := 0;
                            Rec."LFS RoDTEP Rebate Value" := 0;
                            // Commit();
                            // Rec.Modify();
                            if Rec."HSN/SAC Code" <> '' then begin
                                EXIMRoDTEP.Reset();
                                EXIMRoDTEP.SetRange("LFS HSN No.", Rec."HSN/SAC Code");
                                EXIMRoDTEP.SetFilter("LFS Starting Date", '<=%1', Salesheader."Posting Date");
                                EXIMRoDTEP.SetFilter("LFS Block", '%1', False);
                                if EXIMRoDTEP.FindFirst() then begin
                                    Rec."LFS RoDTEP Rebate Rate %" := EXIMRoDTEP."LFS RoDTEP Rebate Rate %";
                                    if Rec."LFS Custom Exch. Rate" <> 0 then
                                        Rec."LFS RoDTEP Rebate Value" := -Rec."LFS FOB Amount (LCY)" * (rec."LFS RoDTEP Rebate Rate %" / 100)
                                    else
                                        Rec."LFS RoDTEP Rebate Value" := -("LFS FOB in USD" * Rec."LFS FOB Currency Factor") * (rec."LFS RoDTEP Rebate Rate %" / 100);
                                    // Commit();
                                    // Rec.Modify();
                                end else begin
                                    Rec."LFS RoDTEP Rebate Rate %" := 0;
                                    Rec."LFS RoDTEP Rebate Value" := 0;
                                    // Commit();
                                    // Rec.Modify();
                                end;
                            end;
                        end;
                    end;
                end;
    end;

    procedure Details(No: Code[20])
    var
        Saleshdr: Record "Sales Header";
        PostDate: Date;
    begin
        Clear(PostDate);
        if Rec."LFS EXIM Type" = "LFS EXIM Type"::Export then begin
            Saleshdr.Reset();
            Saleshdr.SetRange("No.", Rec."Document No.");
            if Saleshdr.FindFirst() then
                PostDate := Saleshdr."Posting Date";

        end;
    end;

    procedure HasTypeToFillMandatotyFields(): Boolean
    begin
        EXIT(Type <> Type::" ");
    end;

    local procedure FOBvalue()
    var
        SalesHeader: Record "Sales Header";
        exchRate: decimal;
    begin
        exchRate := 0;
        SalesHeader.SetRange("Document Type", Rec."Document Type");
        SalesHeader.SetRange("No.", Rec."Document No.");
        if SalesHeader.FindFirst() then
            if SalesHeader."Currency Factor" <> 0 then begin
                exchRate := 1 / SalesHeader."Currency Factor";
                Rec."LFS Custom Exch. Rate" := exchRate;
                if SalesHeader."LFS FOB CIF Calc. Type" = SalesHeader."LFS FOB CIF Calc. Type"::FOB then begin
                    Rec."LFS FOB Amount (FCY)" := Rec."Line Amount";
                    Rec."LFS FOB Amount (LCY)" := Rec."Line Amount" * exchRate;
                    Rec."LFS Freight Value (LCY)" := Rec."LFS Freight Value (FCY)" * exchRate;
                    Rec."LFS Insurance Value (LCY)" := Rec."LFS Insurance Value (FCY)" * exchRate;
                    Rec."LFS CIF Value (FCY)" := Rec."LFS Freight Value (FCY)" + Rec."LFS Insurance Value (FCY)" + Rec."LFS FOB Amount (FCY)";
                    Rec."LFS CIF Value (LCY)" := Rec."LFS CIF Value (FCY)" * exchRate;
                    // if Rec.Quantity <> 0 then begin
                    //     Rec."LFS FOB Amount (FCY)" := Rec."LFS FOB Amount (FCY)" / rec.quantity;
                    //     Rec."LFS CIF Amount (FCY)" := Rec."LFS CIF value (FCY)" / Rec.Quantity;
                    // end;
                end
                else
                    if SalesHeader."LFS FOB CIF Calc. Type" = SalesHeader."LFS FOB CIF Calc. Type"::CIF then begin
                        Rec."LFS Freight Value (LCY)" := Rec."LFS Freight Value (FCY)" * exchRate;
                        Rec."LFS Insurance Value (LCY)" := Rec."LFS Insurance Value (FCY)" * exchRate;
                        Rec."LFS CIF Value (FCY)" := Rec."Line Amount";
                        Rec."LFS CIF Value (LCY)" := Rec."Line Amount" * exchRate;
                        Rec."LFS FOB Amount (FCY)" := rec."LFS CIF Value (FCY)" - Rec."LFS Freight Value (FCY)" - Rec."LFS Insurance Value (FCY)";
                        Rec."LFS FOB Amount (LCY)" := Rec."LFS FOB Amount (FCY)" * exchRate;
                        // if Rec.Quantity <> 0 then begin
                        //     Rec."LFS FOB Amount (FCY)" := Rec."LFS FOB Amount (FCY)" / rec.quantity;
                        //     Rec."LFS CIF Amount (FCY)" := Rec."LFS CIF Value (FCY)" / Rec.Quantity;
                        // end;
                    end;
                if Rec."LFS Incentive Type" = Rec."LFS Incentive Type"::DDB then
                    if Rec."LFS Custom Exch. Rate" <> 0 then
                        Rec."LFS DDB Value (LCY)" := Rec."LFS FOB Amount (LCY)" * rec."LFS DDB Rate" / 100
                    else
                        rec."LFS DDB Value (LCY)" := ("LFS FOB in USD" * Rec."LFS FOB Currency Factor") * rec."LFS DDB Rate" / 100;
                if Rec."LFS Custom Exch. Rate" <> 0 then
                    Rec."LFS RoDTEP Rebate Value" := Rec."LFS FOB Amount (LCY)" * (rec."LFS RoDTEP Rebate Rate %" / 100)
                else
                    Rec."LFS RoDTEP Rebate Value" := ("LFS FOB in USD" * Rec."LFS FOB Currency Factor") * (rec."LFS RoDTEP Rebate Rate %" / 100);
            end;
    end;

    local procedure PromptAdvLicUsageMsg()
    var
        EXIMAdvLicenseIODetails: Record "LFS EXIM License IO Details";
    begin
        if "LFS License Type" <> "LFS License Type"::"Adv. License" then
            EXIT;
        if "LFS License No." = '' then
            EXIT;
        EXIMAdvLicenseIODetails.Reset();
        EXIMAdvLicenseIODetails.SETRANGE(EXIMAdvLicenseIODetails."LFS Adv. License No.", "LFS License No.");
        // EXIMAdvLicenseIODetails.SETRANGE(EXIMAdvLicenseIODetails."LFS Item Type", "LFS EXIM Item Group");
        EXIMAdvLicenseIODetails.FINDFIRST();
        if Quantity + EXIMAdvLicenseIODetails."LFS Consumed Export Qty." > EXIMAdvLicenseIODetails."LFS Qty." then
            MESSAGE('ALERT: Consumption for License No. %1 is going to exceed or has exceeded already.', "LFS License No.");
    end;
}