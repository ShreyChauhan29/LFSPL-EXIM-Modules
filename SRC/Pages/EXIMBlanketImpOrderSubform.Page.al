namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Purchases.Document;
using Microsoft.Finance.GST.StockTransfer;
using Microsoft.Finance.Dimension;
using Microsoft.Purchases.History;
using Microsoft.Inventory.Location;
using Microsoft.Foundation.ExtendedText;
using Microsoft.Inventory.BOM;
using Microsoft.Inventory.Availability;

page 72091 "LFS EXIMBlanketImpOrderSubform"
{
    ApplicationArea = All;
    Caption = 'EXIMBlanketImpOrderSubform';
    PageType = ListPart;
    SourceTable = "Purchase Line";
    SourceTableView = where("Document Type" = filter("Blanket Order"));
    DelayedInsert = true;
    MultipleNewLines = true;
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
                    ToolTip = 'Specifies the document type of this document.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        NoOnAfterValidate();
                    end;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the subcontracting order.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate();
                    end;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies the variant code of the item of this line.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ToolTip = 'Specifies the VAT product posting group of the item this order is linked to.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description.';
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location code of this document.';
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the to total quantity of ordered finished material.';
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the unit of measure code of the item of this line.';
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ToolTip = 'Specifies the unit of measure of the item of this line.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ToolTip = 'Specifies the direct unit cost of this line.';
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    ToolTip = 'Specifies the indirect unit cost % of this line.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ToolTip = 'Specifies the unit cost (LCY) of this line.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                    ToolTip = 'Specifies the unit price (LCY) of this line.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ToolTip = 'Specifies the line amount of this line.';
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ToolTip = 'Specifies the line discount % of this line.';
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ToolTip = 'Specifies the line discount amount of this line.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ToolTip = 'Specifies if invoice discount is allowed in this line.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("GST Credit"; Rec."GST Credit")
                {
                    ToolTip = 'Specifies if the GST Credit has to be availed or not.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("GST Group Code"; Rec."GST Group Code")
                {
                    ToolTip = 'Specifies the GST Group code for the calculation of GST on Transaction line.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("GST Group Type"; Rec."GST Group Type")
                {
                    ToolTip = 'Specifies if the GST group is assigned for goods or service.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    ToolTip = 'Specifies the HSN/SAC code for the calculation of GST on Transaction line.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Exempted; Rec.Exempted)
                {
                    ToolTip = 'Specifies if the service is exempted from GST.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Qty. to Receive"; Rec."Qty. to Receive")
                {
                    ToolTip = 'Specifies the quantity that has to be received form vendor.';
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ToolTip = 'Specifies the quantity of finished material received from vendor.';
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Quantity Invoiced"; REc."Quantity Invoiced")
                {
                    ApplicationArea = all;
                    BlankZero = true;
                    ToolTip = 'Specifies the Quantity Invoiced of this order.';

                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ToolTip = 'Specifies the expected receipt date of this order.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the shortcut dimension 1 code this order is linked to.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the shortcut dimension 2 code this order is linked to.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("License Type"; Rec."LFS License Type")
                {
                    ToolTip = 'Specifies the value of the License Type field.';
                    ApplicationArea = All;
                }
                field("License No."; Rec."LFS License No.")
                {
                    ToolTip = 'Specifies the value of the License No. field.';
                    ApplicationArea = All;
                }
                field("FOB (FCY) Per Unit"; Rec."LFS FOB Amount (FCY)")
                {
                    ToolTip = 'Specifies the value of the FOB (FCY) Per Unit field.';
                    ApplicationArea = All;
                }
                field("CIF (FCY) Per Unit"; Rec."LFS CIF Amount (FCY)")
                {
                    ToolTip = 'Specifies the value of the CIF (FCY) Per Unit field.';
                    ApplicationArea = All;
                }
                field("Freight Amt. FCY Per Unit"; Rec."LFS Freight Amount (FCY)")
                {
                    ToolTip = 'Specifies the value of the Freight Amt. FCY Per Unit field.';
                    ApplicationArea = All;
                }
                field("Insurance Amt FCY Per Unit"; Rec."LFS Insurance Amount (FCY)")
                {
                    ToolTip = 'Specifies the value of the Insurance Amt FCY Per Unit field.';
                    ApplicationArea = All;
                }
                field("Import Duties LCY Per Unit"; Rec."LFS Import Duties Amt. (LCY)")
                {
                    ToolTip = 'Specifies the value of the Import Duties LCY Per Unit field.';
                    ApplicationArea = All;
                }
                // field("EXIM Remark"; Rec."LFS EXIM Remark")
                // {
                //     ToolTip = 'Specifies the value of the EXIM Remark field.';
                //     ApplicationArea = All;
                // }
                field("Currency Exch. Rate"; Rec."LFS Currency Exch. Rate")
                {
                    ToolTip = 'Specifies the value of the Currency Exch. Rate field.';
                    ApplicationArea = All;
                }
                field("Custom Exch. Rate"; Rec."LFS Custom Exch. Rate")
                {
                    ToolTip = 'Specifies the value of the Custom Exch. Rate field.';
                    ApplicationArea = All;
                }
                field("EXIM Item Group"; Rec."LFS EXIM Item Group")
                {
                    ToolTip = 'Specifies the value of the EXIM Item Group field.';
                    ApplicationArea = All;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'ShortcutDimCode3';
                    CaptionClass = '1,2,3';

                    trigger OnValidate()
                    begin
                        ValidateSaveShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'ShortcutDimCode4';
                    CaptionClass = '1,2,4';
                    trigger OnValidate()
                    begin
                        ValidateSaveShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    ApplicationArea = all;
                    ToolTip = 'ShortcutDimCode5';
                    Visible = false;
                    CaptionClass = '1,2,5';
                    trigger OnValidate()
                    begin
                        ValidateSaveShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'ShortcutDimCode6';
                    CaptionClass = '1,2,6';
                    trigger OnValidate()
                    begin
                        ValidateSaveShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    ApplicationArea = all;
                    ToolTip = 'ShortcutDimCode7';
                    Visible = false;
                    CaptionClass = '1,2,7';
                    trigger OnValidate()
                    begin
                        ValidateSaveShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    ApplicationArea = all;
                    ToolTip = 'ShortcutDimCode8';
                    Visible = false;
                    CaptionClass = '1,2,8';
                    trigger OnValidate()
                    begin
                        ValidateSaveShortcutDimCode(8, ShortcutDimCode[8]);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }

                field("Qty. to Receive (Base)"; Rec."Qty. to Receive (Base)")
                {
                    ToolTip = 'Specifies the value of the Qty. to Receive (Base) field.';
                    ApplicationArea = All;
                }
                field("Outstanding Qty. (Base)"; Rec."Outstanding Qty. (Base)")
                {
                    ToolTip = 'Specifies the outstanding quantity expressed in the base units of measure.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = Action;
                action("E&xplode BOM")
                {
                    ApplicationArea = All;
                    Caption = 'E&xplode BOM';
                    AccessByPermission = TableData "BOM Component" = R;
                    Image = ExplodeBOM;
                    ToolTip = 'E&xplode BOM';

                    trigger OnAction()
                    begin
                        ExplodeBOM();
                    end;
                }
                action("InsertExtTexts")
                {
                    ApplicationArea = All;
                    Caption = 'Insert &Ext. Texts';
                    ToolTip = 'Insert &Ext. Texts';
                    AccessByPermission = Tabledata "Extended Text Header" = R;
                    Image = Text;

                    trigger OnAction()
                    begin
                        InsertExtendedText(true);
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                group(ItemAvailabilityBy)
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    action(E_vent)
                    {
                        ApplicationArea = All;
                        Caption = 'Event';
                        ToolTip = 'Event';
                        Image = "Event";

                        trigger OnAction()
                        var
                            PurchaseAvailabilityMgt: Codeunit "Purch. Availability Mgt.";
                        begin
                            PurchaseAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::"Event");
                        end;
                    }
                    action(Period)
                    {
                        ApplicationArea = All;
                        Caption = 'Period';
                        Image = Period;
                        ToolTip = 'Period';

                        trigger OnAction()
                        var
                            PurchaseAvailabilityMgt: Codeunit "Purch. Availability Mgt.";
                        begin
                            PurchaseAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::Period);
                        end;
                    }
                    action(Variant)
                    {
                        ApplicationArea = All;
                        Caption = 'Variant';
                        Image = ItemVariant;
                        ToolTip = 'Variant';

                        trigger OnAction()
                        // begin
                        //     ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByVariant)
                        // end;
                        var
                            PurchaseAvailabilityMgt: Codeunit "Purch. Availability Mgt.";
                        begin
                            PurchaseAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::Variant);
                        end;
                    }
                    action(Location)
                    {
                        ApplicationArea = All;
                        Caption = 'Location';
                        AccessByPermission = tabledata Location = R;
                        Image = Warehouse;
                        ToolTip = 'Location';
                        trigger OnAction()
                        // begin
                        //     ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByLocation)
                        // end;
                        var
                            PurchaseAvailabilityMgt: Codeunit "Purch. Availability Mgt.";
                        begin
                            PurchaseAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::Location);
                        end;
                    }
                    action(BOMLevel)
                    {
                        ApplicationArea = All;
                        ToolTip = 'BOM Level';
                        Caption = 'BOM Level';
                        Image = BOMLevel;

                        trigger OnAction()
                        // begin
                        //     ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByBOM)
                        // end;
                        var
                            PurchaseAvailabilityMgt: Codeunit "Purch. Availability Mgt.";
                        begin
                            PurchaseAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::BOM);
                        end;
                    }
                }
                group(UnpostedLines)
                {
                    Caption = 'Unposted Lines';
                    Image = Order;
                    action(Orders)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Orders';
                        Caption = 'Orders';
                        Image = Document;

                        trigger OnAction()
                        begin
                            ShowOrders();
                        end;
                    }
                    action(Invoices)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Invoices';
                        Caption = 'Invoices';
                        Image = Invoice;

                        trigger OnAction()
                        begin
                            ShowInvoices();
                        end;
                    }
                    action(ReturnOrder)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Return Order';
                        Caption = 'Return Orders';
                        AccessByPermission = TableData "Return Shipment Header" = R;
                        Image = ReturnOrder;

                        trigger OnAction()
                        begin
                            ShowReturnOrders();
                        end;
                    }
                    action(CreditMemos)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Credit Memos';
                        Image = CreditMemo;

                        trigger OnAction()
                        begin
                            ShowCreditMemos();
                        end;
                    }

                }
                group("Posted Lines")
                {
                    Caption = 'Posted Lines';
                    Image = Post;
                    action(Receipts)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Receipts';
                        Caption = 'Receipts';
                        Image = PostedReceipt;

                        trigger OnAction()
                        begin
                            ShowPostedReceipts();
                        end;
                    }
                    action(In_voices)
                    {
                        ApplicationArea = All;
                        Caption = 'Invoices';
                        ToolTip = 'Invoices';
                        Image = Invoice;

                        trigger OnAction()
                        begin
                            ShowPostedInvoices();
                        end;
                    }
                    action(ReturnReceipts)
                    {
                        ApplicationArea = All;
                        Caption = 'Return Receipts';
                        ToolTip = 'Return Receipts';
                        Image = ReturnReceipt;

                        trigger OnAction()
                        begin
                            ShowPostedReturnReceipts();
                        end;
                    }
                    action("Credit Memos")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Credit Memos';
                        Caption = 'Credit Memos';
                        Image = CreditMemo;

                        trigger OnAction()
                        begin
                            ShowPostedCreditMemos();
                        end;
                    }
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    ToolTip = 'Dimensions';
                    AccessByPermission = tabledata Dimension = R;
                    Image = Dimensions;
                    ShortcutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions();
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    ToolTip = 'Co&mments';
                    Caption = 'Co&mments';
                    Image = ViewComments;

                    trigger OnAction()
                    begin
                        Rec.ShowLineComments();
                    end;
                }
                // action("Str&ucture")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Str&ucture Details';
                //     Image = Hierarchy;
                // }
                action(DetailedGSTEntryBuffer)
                {
                    ApplicationArea = All;
                    ToolTip = 'Detailed GST Entry Buffer';

                    Caption = 'Detailed GST Entry Buffer';
                    Image = List;
                    RunObject = page "Detailed GST Entry Buffer";
                    RunPageLink = "Document Type" = field("Document Type"), "Document No." = field("Document No."), "Line No." = field("Line No.");

                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.InitType();
        CLEAR(ShortcutDimCode);
    end;

    var
        CurrentPurchLine: Record "Purchase Line";
        PurchLine: Record "Purchase Line";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        // ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        ShortcutDimCode: array[8] of Code[20];

    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Disc. (Yes/No)", Rec);
    end;

    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.Update(SetSaveRecord);
    end;

    // local procedure CalcInvDisc()
    // begin
    //     CODEUNIT.RUN(CODEUNIT::"Purch.-Calc.Discount", Rec);
    // end;

    local procedure ExplodeBOM()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Explode BOM", Rec);
    end;

    local procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        if TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally) then begin
            CurrPage.SAVERECORD();
            TransferExtendedText.InsertPurchExtText(Rec);
        end;
        if TransferExtendedText.MakeUpdate() then
            UpdateForm(true);
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(FALSE);
    end;

    local procedure ShowCreditMemos()
    begin
        CurrentPurchLine := Rec;
        PurchLine.Reset();
        PurchLine.SETCURRENTKEY("Document Type", "Blanket Order No.", "Blanket Order Line No.");
        PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::"Credit Memo");
        PurchLine.SETRANGE("Blanket Order No.", CurrentPurchLine."Document No.");
        PurchLine.SETRANGE("Blanket Order Line No.", CurrentPurchLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Purchase Lines", PurchLine);
    end;

    local procedure ShowInvoices()
    begin
        CurrentPurchLine := Rec;
        PurchLine.Reset();
        PurchLine.SETCURRENTKEY("Document Type", "Blanket Order No.", "Blanket Order Line No.");
        PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Invoice);
        PurchLine.SETRANGE("Blanket Order No.", CurrentPurchLine."Document No.");
        PurchLine.SETRANGE("Blanket Order Line No.", CurrentPurchLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Purchase Lines", PurchLine);
    end;

    local procedure ShowOrders()
    begin
        CurrentPurchLine := Rec;
        PurchLine.Reset();
        PurchLine.SETCURRENTKEY("Document Type", "Blanket Order No.", "Blanket Order Line No.");
        PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Order);
        PurchLine.SETRANGE("Blanket Order No.", CurrentPurchLine."Document No.");
        PurchLine.SETRANGE("Blanket Order Line No.", CurrentPurchLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Purchase Lines", PurchLine);
    end;

    local procedure ShowPostedCreditMemos()
    var
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
    begin
        CurrentPurchLine := Rec;
        PurchCrMemoLine.Reset();
        PurchCrMemoLine.SETCURRENTKEY("Blanket Order No.", "Blanket Order Line No.");
        PurchCrMemoLine.SETRANGE("Blanket Order No.", CurrentPurchLine."Document No.");
        PurchCrMemoLine.SETRANGE("Blanket Order Line No.", CurrentPurchLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Posted Purchase Cr. Memo Lines", PurchCrMemoLine);
    end;

    local procedure ShowPostedInvoices()
    var
        PurchInvLine: Record "Purch. Inv. Line";
    begin
        CurrentPurchLine := Rec;
        PurchInvLine.Reset();
        PurchInvLine.SETCURRENTKEY("Blanket Order No.", "Blanket Order Line No.");
        PurchInvLine.SETRANGE("Blanket Order No.", CurrentPurchLine."Document No.");
        PurchInvLine.SETRANGE("Blanket Order Line No.", CurrentPurchLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Posted Purchase Invoice Lines", PurchInvLine);
    end;

    local procedure ShowPostedReceipts()
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
        CurrentPurchLine := Rec;
        PurchRcptLine.Reset();
        PurchRcptLine.SETCURRENTKEY("Blanket Order No.", "Blanket Order Line No.");
        PurchRcptLine.SETRANGE("Blanket Order No.", CurrentPurchLine."Document No.");
        PurchRcptLine.SETRANGE("Blanket Order Line No.", CurrentPurchLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Posted Purchase Receipt Lines", PurchRcptLine);
    end;

    local procedure ShowPostedReturnReceipts()
    var
        ReturnShptLine: Record "Return Shipment Line";
    begin
        CurrentPurchLine := Rec;
        ReturnShptLine.Reset();
        ReturnShptLine.SETCURRENTKEY("Blanket Order No.", "Blanket Order Line No.");
        ReturnShptLine.SETRANGE("Blanket Order No.", CurrentPurchLine."Document No.");
        ReturnShptLine.SETRANGE("Blanket Order Line No.", CurrentPurchLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Posted Return Shipment Lines", ReturnShptLine);
    end;

    local procedure ShowReturnOrders()
    begin
        CurrentPurchLine := Rec;
        PurchLine.Reset();
        PurchLine.SETCURRENTKEY("Document Type", "Blanket Order No.", "Blanket Order Line No.");
        PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::"Return Order");
        PurchLine.SETRANGE("Blanket Order No.", CurrentPurchLine."Document No.");
        PurchLine.SETRANGE("Blanket Order Line No.", CurrentPurchLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Purchase Lines", PurchLine);
    end;

    // local procedure CrossReferenceNoOnAfterValidat()
    // begin
    //     InsertExtendedText(FALSE);
    // end;

    // procedure ShowLineComments()
    // begin
    //     ShowLineComments();
    // end;


    local procedure ValidateSaveShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCodes: Code[20])
    begin
        Rec.ValidateShortcutDimCode(FieldNumber, ShortcutDimCodes);
        CurrPage.SAVERECORD();
    end;
}