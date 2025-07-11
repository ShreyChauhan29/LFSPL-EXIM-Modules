namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.Document;
using Microsoft.Utilities;

pageextension 72019 "LFS Purchase Order List Ext." extends "Purchase Order List"
{
    actions
    {
        modify(Release)
        {
            trigger OnBeforeAction()
            begin
                DimensionCodeValidation();
            end;
        }
        modify(Post)
        {
            trigger OnBeforeAction()
            var
            begin
                DimensionCodeValidation();
            end;
        }
        modify(Preview)
        {
            trigger OnBeforeAction()
            var
            begin
                DimensionCodeValidation();
            end;
        }
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            begin
                DimensionCodeValidation();
            end;
        }
        modify(Reopen)
        {
            trigger OnBeforeAction()
            var
                ArchiveManagement: Codeunit ArchiveManagement;
            begin
                ArchiveManagement.ArchPurchDocumentNoConfirm(Rec);
                CurrPage.Update(false);
            end;
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetFilter("LFS EXIM Type", '%1', Rec."LFS EXIM Type"::" ");
    end;

    Procedure DimensionCodeValidation()
    begin
        Rec.TestField("Shortcut Dimension 1 Code");
        Rec.TestField("Shortcut Dimension 2 Code");
    end;

}