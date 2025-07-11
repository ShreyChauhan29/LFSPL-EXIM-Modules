namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.Document;

pageextension 72027 "LFS EXIM Sales Order List Ext." extends "Sales Order List"
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
            begin
                DimensionCodeValidation();
            end;
        }
        modify("Preview Posting")
        {

            trigger OnBeforeAction()
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
    }

    trigger OnOpenPage()
    begin
        Rec.SetFilter("LFS EXIM Type", '%1', Rec."LFS EXIM Type"::" ");
    end;

    Procedure DimensionCodeValidation()
    var
    begin
        Rec.TestField("Shortcut Dimension 1 Code");
        Rec.TestField("Shortcut Dimension 2 Code");
    end;
}