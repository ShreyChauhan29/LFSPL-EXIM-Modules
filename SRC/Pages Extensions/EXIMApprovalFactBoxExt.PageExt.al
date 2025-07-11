namespace LFSEximModule.LFSPLEXIMModule;

using System.Automation;

pageextension 72001 "LFS EXIM Approval FactBox Ext." extends "Approval FactBox"
{
    procedure RefreshPage(SourceRecordID: RecordID)
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.SETRANGE("Record ID to Approve", SourceRecordID);
        ApprovalEntry.COPY(Rec);
        if ApprovalEntry.FINDFIRST() then
            ApprovalEntry.SETFILTER("Approver ID", '<>%1', ApprovalEntry."Sender ID");
        if not ApprovalEntry.IsEmpty() then;
        CurrPage.UPDATE(FALSE);
    end;
}
