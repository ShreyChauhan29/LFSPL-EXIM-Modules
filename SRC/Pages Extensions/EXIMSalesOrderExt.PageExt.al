namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.Document;
using Microsoft.Sales.Setup;
using Microsoft.Finance.Currency;
using Microsoft.Inventory.Requisition;

pageextension 72026 "LFS EXIM Sales Order Ext." extends "Sales Order"
{
    layout
    {
        // modify("No.")
        // {
        //     Visible = true;
        //     trigger OnAssistEdit()
        //     begin
        //         if (Rec."Document Type" = Rec."Document Type"::Order) and (Rec."LFS EXIM Type" = Rec."LFS EXIM Type"::Export) then begin
        //             if Rec.AssistEditExport(xRec) then begin
        //                 Commit();
        //                 CurrPage.Update();
        //             end;
        //         end
        //         else if Rec."Document Type" = Rec."Document Type"::Order then
        //             if Rec.AssistEdit(xRec) then
        //                 CurrPage.Update();
        //     end;
        // }
        addafter(SalesLines)
        {
            group(EXIM)
            {
                Visible = Rec."LFS EXIM Type" = Rec."LFS EXIM Type"::Export;
                field("Currency Code1"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the currency that is used on the entry.';
                    ApplicationArea = All;
                    Importance = Promoted;
                    Visible = false;
                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE();
                        SalesCalcDiscountByType.ApplyDefaultInvoiceDiscount(0, Rec);
                    end;

                    trigger OnAssistEdit()
                    begin
                        CLEAR(ChangeExchangeRate);
                        if Rec."Posting Date" <> 0D then
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", REc."Currency Factor", Rec."Posting Date")
                        else
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WORKDATE());
                        if ChangeExchangeRate.RUNMODAL() = ACTION::OK then begin
                            Rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter());
                            CurrPage.UPDATE();
                        end;
                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("Custom Currency Code";
                Rec."LFS Custom Currency Code")
                {
                    ApplicationArea = all;
                    Caption = 'Currency Code';
                    ToolTip = 'Specifies the Currency Code';
                    trigger OnValidate()
                    begin
                        rec.Validate("Currency Code", Rec."LFS Custom Currency Code");
                    end;

                    trigger OnAssistEdit()
                    begin
                        CLEAR(ChangeCustomExchangeRate);
                        if Rec."Posting Date" <> 0D then
                            ChangeCustomExchangeRate.SetParameter(Rec."LFS Custom Currency Code", Rec."LFS Custom Currency Factor", Rec."Posting Date", Rec."LFS EXIM Type")
                        else
                            ChangeCustomExchangeRate.SetParameter(Rec."LFS Custom Currency Code", Rec."LFS Custom Currency Factor", WORKDATE(), Rec."LFS EXIM Type");
                        if ChangeCustomExchangeRate.RUNMODAL() = ACTION::OK then begin
                            Rec.VALIDATE("LFS Custom Currency Factor", ChangeCustomExchangeRate.GetParameter());
                            CurrPage.UPDATE();
                        end;
                        CLEAR(ChangeCustomExchangeRate);
                    end;
                }
                field("Port of Loading"; Rec."LFS Port of Loading")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Port of Loading';
                }
                field("Port of Discharge"; Rec."LFS Port of Discharge")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Port of Discharge';
                }
                field("Country of Final Destination"; Rec."LFS Country of Final Dest.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Country of Final Destination';
                }
                field("Final Destination"; Rec."LFS Final Destination")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Final Destination';
                }
                field("Country of Origin of Goods"; Rec."LFS Country Origin Goods")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Country of Origin of Goods';
                }
                field("Inco Terms"; Rec."LFS Inco Terms")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Inco Terms';
                }
                field("Shpping Line"; Rec."LFS Shipping Line")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Shpping Line';
                }
                field("Customs Bank Account"; Rec."LFS Customs Bank Account")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Customs Bank Account';
                }
                field("Commercial  Bank Account"; Rec."LFS Commercial Bank Account")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Commercial Bank Account';
                }
                field("Export Remark"; Rec."LFS Export Remark")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Export Remark';
                }
                field("Pre Carriage"; Rec."LFS Pre Carriage")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Pre Carriage';
                }
                field("LFSPlaceofReceiptPre-Carriage"; Rec."LFSPlaceofReceiptPre-Carriage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Place of Receipt By Pre-Carriage';
                }
                field("FTT No."; Rec."LFS FTT No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the FTT No.';
                }
                field("FTT Date"; Rec."LFS FTT Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the FTT Date';
                }
                field("BIN No."; Rec."LFS BIN No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the BIN No.';
                }
                field(ETA; Rec."LFS ETA")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the ETA';
                }
                field(ETD; Rec."LFS ETD")
                {
                    ApplicationArea = all;
                    Caption = 'EDD';
                    Visible = false;
                    ToolTip = 'Specifies the ETD';
                }
                field("Additional Information"; Rec."LFS Additional Information")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Additional Information';
                }
            }
        }
        addafter("External Document No.")
        {
            field("LFS Your Reference Date"; Rec."LFS Your Reference Date")
            {
                ApplicationArea = all;
                Caption = 'Customer Order Date';
                ToolTip = 'Specifies the Customer Order Date';
            }
        }
        addafter("External Document No.")
        {
            // field("Order Credit Limit"; Rec."Order Credit Limit")
            // {
            //     ToolTip = 'Specifies the order credit limit';
            //     ApplicationArea = all;
            // }
        }
        addafter("Applies-to Doc. No.")
        {
            field("LFS Notify Party 1"; Rec."LFS Notify Party 1")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Notifying Parties values.';
            }
            field("LFS Notify Party 2"; Rec."LFS Notify Party 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Notifying Parties values.';
            }
            field("LFS Notify Party 3"; Rec."LFS Notify Party 3")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Notifying Parties values.';
            }
        }
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
    var
        ChangeCustomExchangeRate: Page "LFSChange Custom Exchange Rate";
        SalesCalcDiscountByType: Codeunit "Sales - Calc Discount By Type";
        ChangeExchangeRate: Page "Change Exchange Rate";
}