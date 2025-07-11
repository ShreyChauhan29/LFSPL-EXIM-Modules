namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Foundation.NoSeries;
using Microsoft.Finance.GeneralLedger.Journal;

report 72000 "LFS EXIM Create Rodtep License"
{
    Caption = 'EXIM Create Rodtep License';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = None;
    dataset
    {
        dataitem("EXIM RoDTEP Rebate Entry"; "LFS EXIM RoDTEP Rebate Entry")
        {
            DataItemTableView = sorting("LFS Entry No.");
        }
    }

    trigger OnPostReport()
    var
        RodtepEntries: Record "LFS EXIM RoDTEP Rebate Entry";
        EXIMSetup: Record "LFS EXIM Setup";
        rodtepLicense: Record "LFS Rodtep License Header";
        NoSerMngt: Codeunit "No. Series";
        rodtepLicenseNo: Code[20];
        SumRebate: Decimal;
    begin
        SumRebate := 0;
        rodtepLicenseNo := '';
        EXIMSetup.Get();
        EXIMSetup.TestField("LFS RoDTEP License Nos.");
        rodtepLicenseNo := NoSerMngt.GetNextNo(EXIMSetup."LFS RoDTEP License Nos.", Today, true);

        RodtepEntries.SetRange("LFS Select License", true);
        if RodtepEntries.Findset() then
            repeat
                CreateReDTEPEntriesLine(RodtepEntries, rodtepLicenseNo);
                SumRebate += RodtepEntries."LFS Claim Amount";
                RodtepEntries."LFS License Created" := true;
                RodtepEntries."LFS Select License" := false;
                RodtepEntries."LFS License No." := rodtepLicenseNo;
                RodtepEntries.Modify();
            until RodtepEntries.Next() = 0;
        rodtepLicense.Init();
        rodtepLicense.SetRange("LFS No.", rodtepLicenseNo);
        if rodtepLicense.FindFirst() then
            Error('License already exists')
        else begin
            EXIMSetup.Get();
            rodtepLicense."LFS No." := rodtepLicenseNo;
            rodtepLicense."LFS Description" := Description;
            rodtepLicense."LFS Issue Date" := WorkDate();
            rodtepLicense."LFS Expiry Date" := CalcDate(format(EXIMSetup."LFS Rodtep Lic Expiry Date"), rodtepLicense."LFS Issue Date");
            rodtepLicense."LFS Status" := rodtepLicense."LFS Status"::Created;
            rodtepLicense."LFS Rodtep Value LCY" := SumRebate;
            rodtepLicense."LFS Con Rodtep Value LCY" := 0;
            rodtepLicense."LFS Balance LCY" := rodtepLicense."LFS Rodtep Value LCY" - rodtepLicense."LFS Con Rodtep Value LCY";
            rodtepLicense.Insert();
            Message('License Is created');

            InsertRODTepEntryForLic(rodtepLicense);
        end;
    end;

    var
        Description: Text[80];

    procedure CreateReDTEPEntriesLine(var RodtepEntries: Record "LFS EXIM RoDTEP Rebate Entry"; rodtepLicenseNo: Code[20])
    var
        RodtepEntriesLine: Record "LFS EXIM RoDTEP Rebate Ent Lin";
        EXIMSetup: Record "LFS EXIM Setup";
    begin
        EXIMSetup.Get();
        RodtepEntriesLine.Init();
        RodtepEntriesLine.TransferFields(RodtepEntries);
        RodtepEntriesLine.Insert();
        RodtepEntriesLine."LFS License Created" := true;
        RodtepEntriesLine."LFS Select License" := false;
        RodtepEntriesLine."LFS License No." := rodtepLicenseNo;
        RodtepEntriesLine.Modify();
    end;

    procedure InsertRODTepEntryForLic(var RodtepLicenseHeader: Record "LFS Rodtep License Header")
    var
        RecGenJnlLine: Record "Gen. Journal Line";
        EximSetup: Record "LFS EXIM Setup";
        GenJnlLineNo: Integer;
    begin
        EximSetup.Get();
        RecGenJnlLine.Init();
        recGenJnlLine.SetFilter("Journal Batch Name", '%1', EximSetup."LFS Rdp Lic Batch Name");
        if recGenJnlLine.FindLast() then
            GenJnlLineNo := 10000 + recGenJnlLine."Line No.";
        recGenJnlLine.Init();
        recGenJnlLine."Line No." := GenJnlLineNo;
        recGenJnlLine.Validate("Journal Template Name", EximSetup."LFS Rdp Lic Jour.Temp. Name");
        recGenJnlLine.Validate("Journal Batch Name", EximSetup."LFS Rdp Lic Batch Name");
        recGenJnlLine.Validate("Document No.", RodtepLicenseHeader."LFS No.");
        recGenJnlLine.Validate("Posting Date", RodtepLicenseHeader."LFS Issue Date");
        recGenJnlLine.Validate("Account Type", recGenJnlLine."account type"::"G/L Account");
        recGenJnlLine.Validate("Account No.", EximSetup."LFS Rdp Lic Account No.");
        recGenJnlLine.Validate(Amount, RodtepLicenseHeader."LFS Rodtep Value LCY");
        recGenJnlLine.Validate("Bal. Account Type", recGenJnlLine."bal. account type"::"G/L Account");
        recGenJnlLine.Validate("Bal. Account No.", EximSetup."LFS Rdp Lic Bal Acc. Num");
        if recGenJnlLine.Insert() then
            Message('The RoDTEP license entry is created with Doc. No. %1', RodtepLicenseHeader."LFS No.");
        Page.Run(39, recGenJnlLine);
    end;
}