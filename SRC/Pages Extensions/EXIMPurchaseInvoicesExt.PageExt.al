namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.Document;

pageextension 72020 "LFS EXIM Purchase Invoices Ext" extends "Purchase Invoices"
{
    layout
    {
        modify(Status)
        {
            Visible = true;
        }
    }
    actions
    {
        modify(PostSelected)
        {
            trigger OnBeforeAction()
            begin
                DimensionCodeValidation();
            end;
        }
        modify(Preview)
        {
            trigger OnBeforeAction()
            begin
                DimensionCodeValidation();
            end;

        }
        modify(Release)
        {
            trigger OnBeforeAction()
            var
#pragma warning disable AA0470
                ConfirmMsgLbl: Label 'Have you done the preview posting for Document No.: %1?';
#pragma warning restore AA0470
            begin
                Message(ConfirmMsgLbl, Rec."No.");
                DimensionCodeValidation();
            end;
        }
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
#pragma warning disable AA0470
                ConfirmMsgLbl: Label 'Have you done the preview posting for Document No.: %1?';
#pragma warning restore AA0470
            begin
                Message(ConfirmMsgLbl, Rec."No.");
                DimensionCodeValidation();
            end;
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetFilter("LFS EXIM Type", '<>%1', Rec."LFS EXIM Type"::Import);
    end;

    Procedure DimensionCodeValidation()
    begin
        Rec.TestField("Shortcut Dimension 1 Code");
        Rec.TestField("Shortcut Dimension 2 Code");
    end;
}