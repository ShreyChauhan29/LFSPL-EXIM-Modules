namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.History;
using Microsoft.Foundation.Navigate;
using Microsoft.Foundation.Attachment;
using Microsoft.Finance.Dimension;

page 72092 "LFS EXIMPostedExportInvoiceSub"
{
    ApplicationArea = All;
    Caption = 'EXIMPostedExportInvoiceSub';
    PageType = ListPart;
    SourceTable = "Sales Invoice Line";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    AutoSplitKey = true;
    LinksAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the line type.';
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies the variant of the item on the line.';
                    ApplicationArea = All;
                    Visible = true;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the item or service on the line.';
                    ApplicationArea = All;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    ToolTip = 'Specifies the code explaining why the item was returned.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the number of units of the item specified on the line.';
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ToolTip = 'Specifies the unit of measure code for the item.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the price for one unit on the sales line.';
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ToolTip = 'Specifies the net amount, excluding any invoice discount amount, that must be paid for products on the line.';
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("GST Place of Supply"; Rec."GST Place of Supply")
                {
                    ToolTip = 'Specifies the value of the GST Place of Supply field.';
                    ApplicationArea = All;
                }
                field("GST Group Code"; Rec."GST Group Code")
                {
                    ToolTip = 'Specifies the value of the GST Group Code field.';
                    ApplicationArea = All;
                }
                field("GST Group Type"; Rec."GST Group Type")
                {
                    ToolTip = 'Specifies the value of the GST Group Type field.';
                    ApplicationArea = All;
                }
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    ToolTip = 'Specifies the value of the HSN/SAC Code field.';
                    ApplicationArea = All;
                }
                field("LFS HS Code"; Rec."LFS HS Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the HS Code';
                }
                field("GST Jurisdiction Type"; Rec."GST Jurisdiction Type")
                {
                    ToolTip = 'Specifies the value of the GST Jurisdiction Type field.';
                    ApplicationArea = All;
                }
                field("FOB (FC)"; Rec."LFS FOB Amount (FCY)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the FOB (FCY)';
                }
                field("FOB (LC)"; Rec."LFS FOB Amount (LCY)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the FOB (LCY)';
                }
                field("FOB (FCY) Per Unit"; Rec."LFS FOB Amount (FCY)")
                {
                    ToolTip = 'Specifies the value of the FOB (FCY) Per Unit field.';
                    ApplicationArea = All;
                }
                field("LFS CIF(FCY)"; Rec."LFS CIF Value (FCY)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the CIF(FCY)';
                }
                field("LFS CIF(LCY)"; Rec."LFS CIF Value (LCY)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the CIF(LCY)';
                }
                field("CIF (FCY) Per Unit"; Rec."LFS CIF Amount (FCY)")
                {
                    ToolTip = 'Specifies the value of the CIF (FCY) Per Unit field.';
                    ApplicationArea = All;
                }

                field("Currency Exch. Rate"; Rec."LFS Currency Exch. Rate")
                {
                    ToolTip = 'Specifies the value of the Currency Exch. Rate field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Custom Exch. Rate"; Rec."LFS Custom Exch. Rate")
                {
                    ToolTip = 'Specifies the value of the Custom Exch. Rate field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Freight Value Per Type (FCY)"; Rec."LFS Freight Value (FCY)")
                {
                    ToolTip = 'Specifies the value of the Freight Value Per Type (FCY) field.';
                    ApplicationArea = All;
                }
                field("LFS Freight Value (LCY)"; Rec."LFS Freight Value (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Freight Value (LCY)';
                }
                field("Insurance Value Per Type (FCY)"; Rec."LFS Insurance Value (FCY)")
                {
                    ToolTip = 'Specifies the value of the Insurance Value Per Type (FCY) field.';
                    ApplicationArea = All;
                }
                field("LFS Insurance Value (LCY)"; Rec."LFS Insurance Value (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Insurance Value (LCY)';
                }
                field("Invoice Discount Amount"; TotalSalesInvoiceHeader."Invoice Discount Amount")
                {
                    ApplicationArea = all;
                    Caption = 'Invoice Discount Amount';
                    ToolTip = 'Specifies the Invoice Discount Amount';
                    Editable = false;
                    AutoFormatType = 1;
                }
                field("Packing Details"; Rec."LFS Packing Details")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the Packing Details';
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions();
                    end;
                }
                action(Comments)
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    ToolTip = 'View or add comments for the record.';

                    trigger OnAction()
                    begin
                        Rec.ShowLineComments();
                    end;
                }
                action(ItemTrackingEntries)
                {
                    ApplicationArea = ItemTracking;
                    Caption = 'Item &Tracking Entries';
                    Image = ItemTrackingLedger;
                    ToolTip = 'View serial or lot numbers that are assigned to items.';

                    trigger OnAction()
                    begin
                        Rec.ShowItemTrackingLines();
                    end;
                }
                action(ItemShipmentLines)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Shipment &Lines';
                    Image = ShipmentLines;
                    ToolTip = 'View posted sales shipments for the item.';

                    trigger OnAction()
                    begin
                        if not (Rec.Type in [Rec.Type::Item, Rec.Type::"Charge (Item)"]) then
                            Rec.TestField(Type);
                        Rec.ShowItemShipmentLines();
                    end;
                }
                action(DocumentLineTracking)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Document &Line Tracking';
                    Image = Navigate;
                    ToolTip = 'View related open, posted, or archived documents or document lines.';

                    trigger OnAction()
                    begin
                        ShowDocumentLineTracking();
                    end;
                }
                action(DeferralSchedule)
                {
                    ApplicationArea = Suite;
                    Caption = 'Deferral Schedule';
                    Enabled = Rec."Deferral Code" <> '';
                    Image = PaymentPeriod;
                    ToolTip = 'View the deferral schedule that governs how revenue made with this sales document was deferred to different accounting periods when the document was posted.';

                    trigger OnAction()
                    begin
                        Rec.ShowDeferrals();
                    end;
                }
                action(DocAttach)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal();
                    end;
                }

            }
            group("Exim")
            {
                Caption = 'EXIM';
                action("Packing List")
                {
                    ApplicationArea = all;
                    Caption = 'Packing List';
                    ToolTip = 'Specifies the Packing List';
                    Image = List;
                    trigger OnAction()
                    var
                        postedPacking: Record "LFS EXIM Posted Packing Table";
                        PostedPackingList: Page "LFS Posted Packing List";
                    begin
                        postedPacking.SetRange("LFS Posted Export Shipment", Rec."Shipment No.");
                        postedPacking.SetRange("LFS PostExShipmentLineNo.", Rec."Shipment Line No.");
                        PostedPackingList.SetTableView(postedPacking);
                        Page.RunModal(page::"LFS Posted Packing List", postedPacking);
                    end;
                }
                action(Licenses)
                {
                    Caption = 'Multiple License';
                    ToolTip = 'Specifies the Multiple License';
                    ApplicationArea = all;
                    Image = Task;
                    trigger OnAction()
                    var
                        // EXIM_License: record "LFS EXIM Posted Export Licence";
                        // EXIM_license1: Record "LFS EXIM Posted Export Licence";
                        EXIM_License2: Record "LFS EXIM Posted Export Licence";
                        EXIM_licenseList: Page "LFS Posted Export Licence List";

                    begin
                        EXIM_License2.Reset();
                        EXIM_License2.SetRange("LFS Source Type", EXIM_License2."LFS Source Type"::Invoice);
                        EXIM_License2.setrange("LFS Source No.", Rec."Document No.");
                        EXIM_License2.setrange("LFS Source line No.", Rec."Line No.");
                        EXIM_licenseList.SetTableView(EXIM_License2);
                        EXIM_licenseList.SetRecord(EXIM_License2);
                        EXIM_licenseList.run();
                    end;
                }
            }

        }
    }
    // DocumentTotals: Codeunit "Document Totals";

    trigger OnAfterGetCurrRecord()
    begin
        if TotalSalesInvoiceHeader.GET(Rec."Document No.") then
            TotalSalesInvoiceHeader.CALCFIELDS("Invoice Discount Amount");
    end;

    var
        TotalSalesInvoiceHeader: Record "Sales Invoice Header";

    procedure ShowDocumentLineTracking()
    var
        DocumentLineTrackings: Page "Document Line Tracking";
        DocumentLineSourceType: Enum "Document Line Source Type";
    begin
        Clear(DocumentLineTrackings);
        DocumentLineTrackings.SetSourceDoc(
          DocumentLineSourceType::"Sales Invoice", Rec."Document No.", Rec."Line No.", Rec."Blanket Order No.", Rec."Blanket Order Line No.", Rec."Order No.", Rec."Order Line No.");
        DocumentLineTrackings.RunModal();
    end;
}