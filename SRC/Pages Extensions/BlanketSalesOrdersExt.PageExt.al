namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.Document;
using System.Security.AccessControl;

pageextension 72003 "LFS Blanket Sales Orders Ext." extends "Blanket Sales Orders"
{
    layout
    {
        modify("Posting Date")
        {
            Visible = false;
        }
        addafter("Posting Date")
        {
            field("Document Date"; Rec."Document Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Document Date';
            }
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        addafter("Assigned User ID")
        {
            field(SystemCreatedBy; GetNameFromSystemId(Rec.SystemCreatedBy))
            {
                ToolTip = 'Specifies the user who has created';
                ApplicationArea = all;
                Caption = 'Created By';
                Editable = false;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetFilter("LFS EXIM Type", '%1', Rec."LFS EXIM Type"::" ");
    end;

    procedure GetNameFromSystemId(SystemId: Guid): Code[50]
    var
        User: Record User;
    begin
        if User.Get(SystemId) then
            exit(User."User Name");
    end;
}
