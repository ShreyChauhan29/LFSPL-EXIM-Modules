namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.Document;
using Microsoft.Sales.Setup;
using Microsoft.Inventory.Requisition;

pageextension 72026 "LFS EXIM Sales Order Ext." extends "Sales Order"
{
    layout
    {
        addafter("External Document No.")
        {
            field("LFS Your Reference Date"; Rec."LFS Your Reference Date")
            {
                ApplicationArea = all;
                Caption = 'Customer Order Date';
                ToolTip = 'Specifies the Customer Order Date';
            }
        }
        // addafter("External Document No.")
        // {
        // field("Order Credit Limit"; Rec."Order Credit Limit")
        // {
        //     ToolTip = 'Specifies the order credit limit';
        //     ApplicationArea = all;
        // }
        // }
        // addafter("Applies-to Doc. No.")
        // {
        //     field("LFS Notify Party 1"; Rec."LFS Notify Party 1")
        //     {
        //         ApplicationArea = All;
        //         ToolTip = 'Specifies the Notifying Parties values.';
        //     }
        //     field("LFS Notify Party 2"; Rec."LFS Notify Party 2")
        //     {
        //         ApplicationArea = All;
        //         ToolTip = 'Specifies the Notifying Parties values.';
        //     }
        //     field("LFS Notify Party 3"; Rec."LFS Notify Party 3")
        //     {
        //         ApplicationArea = All;
        //         ToolTip = 'Specifies the Notifying Parties values.';
        //     }
        // }
    }

    actions
    {
        addafter("S&hipments")
        {
            action("LFS Delivery Order")
            {
                Caption = 'Delivery Order';
                ToolTip = 'Specifies the Delivery Order';
                Promoted = true;
                PromotedIsBig = true;
                Image = Report;
                PromotedCategory = Report;
                ApplicationArea = All;
                Visible = false;

                trigger OnAction()
                var
                    SalesHdr: Record "Sales Header";
                begin
                    SalesHdr.Reset();
                    SalesHdr.SETRANGE("No.", Rec."No.");
                    if SalesHdr.FINDFIRST() then
                        REPORT.RUNMODAL(72020, true, true, SalesHdr);
                end;
            }
            action("LFS Sales Order Report")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Sales Order Report';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Ellipsis = false;
                Visible = false;

                trigger OnAction()
                var
                    // SalesOrder: Report "Get Sales Orders";
                    NewReqLine: Record "Requisition Line";
                    SalesAndReceivables: Record "Sales & Receivables Setup";
                    SalesHeader: Record "Sales Header";
                    SalesLine: Record "Sales Line";
                begin
                    Rec.TESTFIELD(Status, Rec.Status::Released);
                    SalesHeader.SETRANGE("Document Type", Rec."Document Type");
                    SalesHeader.SETRANGE("No.", Rec."No.");
                    if SalesHeader.FindFirst() then begin
                        SalesLine.Reset();
                        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
                        SalesLine.SetRange("Document No.", SalesHeader."No.");
                        if SalesLine.FindFirst() then begin
                            SalesAndReceivables.Get();
                            NewReqLine.SetRange("Worksheet Template Name", SalesAndReceivables."LFS WorkSheet Template Name");
                            Report.RunModal(698, true, true, SalesLine);
                        end;
                    end;
                end;
            }
        }
    }
}