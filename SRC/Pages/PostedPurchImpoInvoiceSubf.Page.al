namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.History;
using Microsoft.Foundation.Navigate;
using Microsoft.Foundation.Attachment;
using Microsoft.Finance.Dimension;

page 72082 "LFSPostedPurch.ImpoInvoiceSubf"
{
    ApplicationArea = All;
    Caption = 'PostedPurch.ImpoInvoiceSubf';
    PageType = ListPart;
    SourceTable = "Purch. Inv. Line";
    DeleteAllowed = false;
    Editable = false;
    LinksAllowed = false;
    SourceTableView = where("LFS EXIM Type" = FILTER(Import));
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Type';
                }
                field("No."; REc."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the No.';
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the IC Partner Code';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Variant Code';
                    Visible = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Description';
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Return Reason Code';
                    Visible = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Quantity';
                    BlankZero = true;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Unit of Measure Code';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Unit of Measure';
                    Visible = false;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Direct Unit Cost';
                    BlankZero = true;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Indirect Cost %';
                    Visible = false;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Unit Cost (LCY)';
                    Visible = false;
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Unit Price (LCY)';
                    Visible = false;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Line Amount';
                    BlankZero = true;
                }
                field("GST Assesable Value INR"; Rec."LFS GST Assesable Value INR")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the GST Assesable Value INR';
                }
                field("GST Assessable Value"; Rec."GST Assessable Value")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the GST Assessable Value';
                }
                field("Import Duties LCY Per Unit"; Rec."LFS Import Duties Amt. (LCY)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Custom Duties LCY';
                    Caption = 'Custom Duties LCY';
                }
                field("Custom Duty Amount"; Rec."Custom Duty Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Custom Duty Amount';
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Line Discount %';
                    BlankZero = true;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ToolTip = 'Specifies the Line Discount Amount';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Allow Invoice Disc.';
                    Visible = false;
                }
                field("GST Credit"; Rec."GST Credit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the GST Credit';
                    Editable = false;
                    Visible = false;
                }
                field("GST Group Code"; Rec."GST Group Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the GST Group Code';
                    Editable = false;
                    Visible = false;
                }
                field("GST Group Type"; Rec."GST Group Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the GST Group Type';
                    Visible = false;
                }
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the HSN/SAC Code';
                    Editable = false;
                    Visible = false;
                }
                field("CIF (FC)"; Rec."LFS CIF Amount (FCY)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the CIF (FCY)';
                    Caption = 'CIF (FCY)';
                }
                field("CIF (LC)"; Rec."LFS CIF Amount (LCY)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the CIF (LCY)';
                    Caption = 'CIF (LCY)';
                }
                field("License Type"; Rec."LFS License Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the License Type';
                    Visible = false;
                }
                field("License No."; Rec."LFS License No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the License No.';
                    Visible = false;
                }
                field("RoDTEP Value (LCY)"; Rec."LFS RoDTEP Value (LCY)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the RoDTEP Value (LCY)';
                    Visible = false;
                }
                field(Exempted; Rec.Exempted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Exempted';
                    Visible = false;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Job No.';
                    Visible = false;
                }
                field("Insurance No."; Rec."Insurance No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Insurance No.';
                    Visible = false;
                }
                field("Budgeted FA No."; Rec."Budgeted FA No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Budgeted FA No.';
                    Visible = false;
                }
                field("FA Posting Type"; Rec."FA Posting Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the FA Posting Type';
                    Visible = false;
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Depr. until FA Posting Date';
                    Visible = false;
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Depreciation Book Code';
                    Visible = false;
                }
                field("Depr. Acquisition Cost"; Rec."Depr. Acquisition Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Depr. Acquisition Cost';
                    Visible = false;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Appl.-to Item Entry';
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shortcut Dimension 1 Code';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the Shortcut Dimension 2 Code';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Tax Area Code';
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Tax Group Code';
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
                action(Licenses)
                {
                    Caption = 'Multiple License';
                    ApplicationArea = all;
                    Image = Task;
                    ToolTip = 'Specifies the Licenses';
                    trigger OnAction()
                    var
                        EXIM_License2: Record "LFS EXIM Posted Import Licence";
                        EXIM_licenseList: Page "LFS Posted Import Licences";
                    // PurchInvHeader: Record "Purch. Inv. Header";

                    begin
                        EXIM_License2.setrange("LFS Source No.", Rec."Document No.");
                        EXIM_License2.setrange("LFS Source line No.", Rec."Line No.");
                        EXIM_License2.SetRange("LFS Source Type", EXIM_License2."LFS Source Type"::Invoice);
                        EXIM_licenseList.SetTableView(EXIM_License2);
                        EXIM_licenseList.SetRecord(EXIM_License2);
                        EXIM_licenseList.run();
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
                action(ItemReceiptLines)
                {
                    AccessByPermission = TableData "Purch. Rcpt. Header" = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Receipt &Lines';
                    Image = ReceiptLines;
                    ToolTip = 'View posted receipts for the item.';

                    trigger OnAction()
                    begin
                        if not (Rec.Type in [Rec.Type::Item, Rec.Type::"Charge (Item)"]) then
                            Rec.TestField(Type);
                        Rec.ShowItemReceiptLines();
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
                    Image = PaymentPeriod;
                    ToolTip = 'View the deferral schedule that governs how expenses paid with this purchase document were deferred to different accounting periods when the document was posted.';

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
        }
    }
    procedure ShowDocumentLineTracking()
    var
        DocumentLineTracking1: Page "Document Line Tracking";
        NewSourceDocType: Enum "Document Line Source Type";
    begin
        Clear(DocumentLineTracking1);
        DocumentLineTracking1.SetSourceDoc(NewSourceDocType::"Purchase Invoice", Rec."Document No.", Rec."Line No.", Rec."Blanket Order No.", Rec."Blanket Order Line No.", Rec."Order No.", Rec."Order Line No.");
        DocumentLineTracking1.RunModal();
    end;
}