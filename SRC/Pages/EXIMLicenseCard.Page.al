namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Foundation.Attachment;

page 72021 "LFS EXIM License Card"
{
    ApplicationArea = All;
    Caption = 'License Card';
    PageType = Card;
    SourceTable = "LFS EXIM License Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."LFS No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Adv. Lic File No."; Rec."LFS File No.")
                {
                    ToolTip = 'Specifies the value of the File No.';
                    ApplicationArea = all;
                }
                field(Description; Rec."LFS Description")
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("License Type"; Rec."LFS License Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the License Type';
                }

                field("Scheme Type"; Rec."LFS Scheme Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Scheme Type';
                    trigger OnValidate()
                    var
                        IOdetails: Record "LFS EXIM License IO Details";
                    begin
                        IOdetails.SetRange("LFS Adv. License No.", Rec."LFS No.");
                        if IOdetails.Findset() then begin
                            IOdetails."LFS Scheme Type" := Rec."LFS Scheme Type";
                            IOdetails.Modify(false);
                        end;
                    end;
                }
                field("SION No."; Rec."LFS SION No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the SION No.';
                }
                // field("Issue Date"; Rec."LFS Issue Date")
                // {
                //     ToolTip = 'Specifies the value of the Issue Date field.';
                //     ApplicationArea = All;
                // }
                field("Expiry Date"; Rec."LFS Expiry Date")
                {
                    ToolTip = 'Specifies the value of the Expiry Date field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Status; Rec."LFS Status")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                // field("Currency Code"; Rec."LFS Currency Code")
                // {
                //     ToolTip = 'Specifies the value of the Currency Code field.';
                //     ApplicationArea = All;
                //     trigger OnValidate()
                //     var
                //         EXIMcurrExch: Record "LFSEXIM Currency Exchange Rate";
                //     begin
                //         EXIMcurrExch.reset();
                //         EXIMcurrExch.SetRange("LFS Currency Code", Rec."LFS Currency Code");
                //         EXIMcurrExch.SetCurrentKey("LFS Starting Date");
                //         if EXIMcurrExch.FindLast() then
                //             Rec.Validate("LFS Exchange Rate", EXIMcurrExch."LFS Rel Exch Rate Amt (Imp)");
                //         Rec.Validate("LFS Import Exchange Rate", EXIMcurrExch."LFS Rel Exch Rate Amt (Imp)");
                //         Rec.Validate("LFS Export Exchange Rate", EXIMcurrExch."LFS Rel Exch Rate Amt (Exp)");
                //         Rec.Modify();
                //     end;
                // }
                // field("Import Exchange Rate"; Rec."LFS Import Exchange Rate")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the Import Exchange Rate';
                // }
                // field("Export Exchange Rate"; Rec."LFS Export Exchange Rate")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the Export Exchange Rate';
                // }
                field("Exchange Rate"; Rec."LFS Exchange Rate")
                {
                    ToolTip = 'Specifies the value of the Exchange Rate field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                // field("Export Type"; Rec."LFS Export Type")
                // {
                //     ToolTip = 'Specifies the value of the Export Type field.';
                //     ApplicationArea = All;
                // }
            }
            group("Application Tracking")
            {
                Caption = 'Application Tracking';

                field("LFS Application No."; Rec."LFS Application No.")
                {
                    ToolTip = 'Specifies the value of the Application No. field.';
                }
                field("LFS Application Date"; Rec."LFS Application Date")
                {
                    ToolTip = 'Specifies the value of the Application Date field.';
                }
                field("LFS DGFT Status"; Rec."LFS DGFT Status")
                {
                    ToolTip = 'Specifies the value of the DGFT Status field.', Comment = '%';
                }
            }
            group("Exchange Rates")
            {
                Caption = 'Exchange Rates';

                field("LFS Import Exchange Rate"; Rec."LFS Import Exchange Rate")
                {
                    ToolTip = 'Specifies the value of the Import Exchange Rate field.';
                }
                field("LFS Export Exchange Rate"; Rec."LFS Export Exchange Rate")
                {
                    ToolTip = 'Specifies the value of the Export Exchange Rate field.';
                }
            }
            group("Dates and Validity")
            {
                Caption = 'Dates and Validity';

                field("LFS Issue Date"; Rec."LFS Issue Date")
                {
                    ToolTip = 'Specifies the value of the Issue Date field.';
                }
                field("LFS Import Validity Date"; Rec."LFS Import Validity Date")
                {
                    ToolTip = 'Specifies the value of the Import Validity Date field.';
                }
                field("LFS Import Extension Date"; Rec."LFS Import Extension Date")
                {
                    ToolTip = 'Specifies the value of the Import Extension Date field.';
                }
                field("LFS Export Extension Date"; Rec."LFS Export Extension Date")
                {
                    ToolTip = 'Specifies the value of the Export Extension Date field.';
                }
                field("LFS Export Validity Date"; Rec."LFS Export Validity Date")
                {
                    ToolTip = 'Specifies the value of the Export Validity Date field.';
                }
                field("LFS Redemption Date"; Rec."LFS Redemption Date")
                {
                    ToolTip = 'Specifies the value of the Redemption Date field.', Comment = '%';
                }
            }
            group("License Values")
            {
                Caption = 'License Values';
                field("LFS Org Import Quantity"; Rec."LFS Import Quantity")
                {
                    ToolTip = 'Specifies the value of the Original Import Quantity field.', Comment = '%';
                }
                field("LFS Original CIF Value FC"; Rec."LFS Import CIF Value FCY")
                {
                    ToolTip = 'Specifies the value of the Original CIF Value (FCY) field.', Comment = '%';
                }
                field("LFS Original CIF Value LC"; Rec."LFS Import CIF Value LCY")
                {
                    ToolTip = 'Specifies the value of the Original CIF Value (LCY) field.', Comment = '%';
                }
                field("LFS Org Export Quantity"; Rec."LFS Export Quantity")
                {
                    ToolTip = 'Specifies the value of the Original Export Quantity field.', Comment = '%';
                }
                field("LFS Original FOB Value FC"; Rec."LFS Export FOB Value FCY")
                {
                    ToolTip = 'Specifies the value of the Original FOB Value (FCY) field.', Comment = '%';
                }
                field("LFS Original FOB Value LC"; Rec."LFS Export FOB Value LCY")
                {
                    ToolTip = 'Specifies the value of the Original FOB Value (LCY) field.', Comment = '%';
                }
                field("LFS Currency Code"; Rec."LFS Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                    trigger OnValidate()
                    var
                        EXIMcurrExch: Record "LFSEXIM Currency Exchange Rate";
                    begin
                        EXIMcurrExch.reset();
                        EXIMcurrExch.SetRange("LFS Currency Code", Rec."LFS Currency Code");
                        EXIMcurrExch.SetCurrentKey("LFS Starting Date");
                        if EXIMcurrExch.FindLast() then
                            Rec.Validate("LFS Exchange Rate", EXIMcurrExch."LFS Rel Exch Rate Amt (Imp)");
                        Rec.Validate("LFS Import Exchange Rate", EXIMcurrExch."LFS Rel Exch Rate Amt (Imp)");
                        Rec.Validate("LFS Export Exchange Rate", EXIMcurrExch."LFS Rel Exch Rate Amt (Exp)");
                        Rec.Modify();
                    end;
                }
            }
            group("LUT/Bond Info")
            {
                Caption = 'LUT/Bond Info';

                field("LFS LUT No."; Rec."LFS LUT No.")
                {
                    ToolTip = 'Specifies the value of the LUT No. field.', Comment = '%';
                }
                field("LFS LUT Date"; Rec."LFS LUT Date")
                {
                    ToolTip = 'Specifies the value of the LUT Date field.', Comment = '%';
                }
                field("LFS LUT Amount"; Rec."LFS LUT Amount")
                {
                    ToolTip = 'Specifies the value of the LUT Amount field.', Comment = '%';
                }
                field("LFS LUT Status"; Rec."LFS LUT Status")
                {
                    ToolTip = 'Specifies the value of the LUT Status field.', Comment = '%';
                }
            }
            // group("Validation")
            // {
            //     field("Export Validity Date"; Rec."LFS Export Validity Date")
            //     {
            //         ApplicationArea = all;
            //         ToolTip = 'Specifies the Export Validity Date';
            //     }
            //     field("Export Extension No."; Rec."LFS Export Extension No.")
            //     {
            //         ApplicationArea = all;
            //         ToolTip = 'Specifies the Export Extension No.';
            //     }
            //     field("Export Extension Date"; Rec."LFS Export Extension Date")
            //     {
            //         ApplicationArea = all;
            //         ToolTip = 'Specifies the Export Extension Date';
            //     }
            //     // field("Export Expiry Date"; Rec."LFS Export Expiry Date")
            //     // {
            //     //     ApplicationArea = all;
            //     //     ToolTip = 'Specifies the Export Expiry Date';
            //     // }
            //     field("Import Validity Date"; Rec."LFS Import Validity Date")
            //     {
            //         ApplicationArea = all;
            //         ToolTip = 'Specifies the Import Validity Date';
            //     }
            //     field("Import Extension No."; Rec."LFS Import Extension No.")
            //     {
            //         ApplicationArea = all;
            //         ToolTip = 'Specifies the Import Extension No.';
            //     }
            //     field("Import Extension Date"; Rec."LFS Import Extension Date")
            //     {
            //         ApplicationArea = all;
            //         ToolTip = 'Specifies the Import Extension Date';
            //     }
            //     // field("Import Expiry Date"; Rec."LFS Import Expiry Date")
            //     // {
            //     //     ApplicationArea = all;
            //     //     ToolTip = 'Specifies the Import Expiry Date';
            //     // }
            // }
            // group("Application")
            // {
            // field("Application No."; Rec."LFS Application No.")
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Specifies the Application No.';
            // }
            // field("Application Date"; Rec."LFS Application Date")
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Specifies the Application Date';
            // }
            // field("Redemption Date"; Rec."LFS Redemption Date")
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Specifies the Redemption Date';
            // }
            // field("Redemption Type"; Rec."LFS Redemption Type")
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Specifies the Redemption Type';
            // }
            // field("Original Export Quantity"; Rec."LFS Export Quantity")
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Specifies the Original Export Quantity';
            // }
            // field("Original FOB Value FC"; Rec."LFS Export FOB Value FCY")
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Specifies the Original FOB Value FCY';
            // }
            // field("Original FOB Value LC"; Rec."LFS Export FOB Value LCY")
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Specifies the Original FOB Value LCY';
            // }
            // field("Original Import Quantity"; Rec."LFS Import Quantity")
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Specifies the Original Import Quantity';
            // }
            // field("Original CIF Value FC"; Rec."LFS Import CIF Value FCY")
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Specifies the Original CIF Value FCY';
            // }
            // field("Original CIF Value LC"; Rec."LFS Import CIF Value LCY")
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Specifies the Original CIF Value LCY';
            // }
            // field("LUT No."; Rec."LFS LUT No.")
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Specifies the LUT No.';
            // }
            // field("LUT Date"; Rec."LFS LUT Date")
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Specifies the LUT Date';
            // }
            // field("LUT Status"; Rec."LFS LUT Status")
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Specifies the LUT Status';
            // }
            // field("LUT Amount"; Rec."LFS LUT Amount")
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Specifies the LUT Amount';

            // }
            // }
            group(Export)
            {
                field("Adv. License Export Qty."; Rec."LFS Adv. Lic Export Qty.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Adv. License Export Qty.';
                }
                field("Adv. License Export FOB Value"; Rec."LFS Adv. Lic Exp FOB Value")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Adv. License Export FOB Value';
                }
                field("Adv. Lic. Exp. FOB Value (LCY)"; Rec."LFS Adv. Lic. FOB Value LCY")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Adv. Lic. Exp. FOB Value (LCY)';
                }
                field("Export Invoice Qty."; Rec."LFS Export Invoice Qty.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Export Invoice Qty.';
                }
                field("Export Invoice FOB Value"; Rec."LFS Export Inv FOB Value")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Export Invoice FOB Value';
                }
                field("Export Invoice CIF Value"; Rec."LFS Export Inv CIF Value")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Export Invoice CIF Value';
                }
                field("Export Inv Bal Qty"; Rec."LFS Export Inv Bal Qty")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Export Inv Bal Qty';
                }
            }
            group(Import)
            {
                field("Adv. License Import Qty."; Rec."LFS Adv. License Imp Qty.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Adv. License Import Qty.';
                }
                field("Adv. License Import CIF Value"; Rec."LFS Adv. Lic Imp CIF Value")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Adv. License Import CIF Value';
                }
                field("Adv. Lic. Imp. CIF Value (LCY)"; Rec."LFS Adv. Lic. CIF Value LCY")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Adv. Lic. Imp. CIF Value (LCY)';
                }
                field("Import Invoice Qty."; Rec."LFS Import Invoice Qty.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Import Invoice Qty.';
                }
                field("Import Invoice FOB Value"; Rec."LFS Import Inv FOB Value")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Import Invoice FOB Value';
                }
                field("Import Invoice CIF Value"; Rec."LFS Import Inv CIF Value")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Import Invoice CIF Value';
                }
                field("Import Order Bal Qty"; Rec."LFS Import Order Bal Qty")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Import Invoice Bal. Qty.';
                    ToolTip = 'Specifies the Import Invoice Bal. Qty.';
                }
            }
            part("LFS EXIM License Subpage"; "LFS EXIM License Line Subpage")
            {
                ApplicationArea = all;
                Caption = 'License Utilization Line';
                SubPageLink = "LFS Adv. License No." = field("LFS No.");
            }
        }
        area(FactBoxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"LFS EXIM License Header"),
                              "No." = field("LFS No.");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group(Card)
            {
                Caption = '&Card';
                action("I/O Details")
                {
                    ApplicationArea = all;
                    Caption = 'I/O Details';
                    ToolTip = 'Specifies the I/O Details';
                    Image = Line;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Ellipsis = true;
                    RunObject = page "LFS EXIM Lic. IO Detail List";
                    RunPageLink = "LFS Adv. License No." = field("LFS No.");
                }
                action(Active)
                {
                    ApplicationArea = All;
                    Caption = 'Active';
                    ToolTip = 'Changes the status of the license to "Active"';
                    Image = Line;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Ellipsis = true;

                    trigger OnAction()
                    var
                        IOdetails: Record "LFS EXIM License IO Details";
                    begin
                        Rec.TestField("LFS LUT No.");
                        Rec.TestField("LFS LUT Date");
                        Rec.TestField("LFS LUT Amount");
                        if Rec."LFS LUT Status" <> Rec."LFS LUT Status"::Active then
                            Error('LUT Status should be open');
                        Rec."LFS Status" := Rec."LFS Status"::Active;
                        Rec.Modify();

                        IOdetails.SetRange("LFS Adv. License No.", Rec."LFS No.");
                        if IOdetails.Findset() then
                            repeat
                                IOdetails."LFS Status" := IOdetails."LFS Status"::Active;
                                IOdetails.Modify(false);
                            until IOdetails.Next() = 0;
                        Message('Document has been Active');
                    end;
                }
                action(close)
                {
                    ApplicationArea = All;
                    Caption = 'Close';
                    ToolTip = 'Changes the status of the license to "Closed"';
                    Image = Line;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Ellipsis = true;

                    trigger OnAction()
                    var
                        IOdetails: Record "LFS EXIM License IO Details";
                    begin
                        if (Rec."LFS Redemption Date" = 0D) and (Rec."LFS Redemption Type" <> rec."LFS Redemption Type"::" ") then
                            Error('Redemption Date & Redemption Type is not updated');
                        Rec."LFS Status" := Rec."LFS Status"::Closed;
                        Rec.Modify();
                        IOdetails.SetRange("LFS Adv. License No.", Rec."LFS No.");
                        if IOdetails.Findset() then begin
                            IOdetails."LFS Status" := IOdetails."LFS Status"::Closed;
                            IOdetails.Modify(false);
                        end;
                        Message('Document has been Closed');
                    end;
                }
                action(Open)
                {
                    ApplicationArea = All;
                    Caption = 'Re-Open';
                    ToolTip = 'Changes the status of the license to "Open"';
                    Image = Line;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Ellipsis = true;

                    trigger OnAction()
                    var
                        IOdetails: Record "LFS EXIM License IO Details";
                    begin
                        Rec."LFS Status" := Rec."LFS Status"::Created;
                        Rec.Modify();
                        IOdetails.SetRange("LFS Adv. License No.", Rec."LFS No.");
                        if IOdetails.Findset() then begin
                            IOdetails."LFS Status" := IOdetails."LFS Status"::Created;
                            IOdetails.Modify(false);
                        end;
                        Message('Document has been Re-Opened');
                    end;
                }
            }
        }
    }
    trigger OnNewRecord(Belowrec: Boolean)
    begin
        Rec."LFS Status" := Rec."LFS Status"::Created;
        EximLicenseLine.Init();
        EximLicenseLine."LFS Adv. License No." := Rec."LFS No.";
        if not EximLicenseLine.Insert() then EximLicenseLine.Modify();
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("LFS Adv. Lic Export Qty.", "LFS Adv. License Imp Qty.", "LFS Export Invoice Qty.", "LFS Export Order Qty.", "LFS Import Invoice Qty.", "LFS Import Order Qty.");
        Rec."LFS Import Inv Bal Qty" := Rec."LFS Adv. License Imp Qty." + Rec."LFS Import Order Qty.";
        Rec."LFS Import Order Bal Qty" := Rec."LFS Adv. License Imp Qty." + Rec."LFS Import Invoice Qty.";
        Rec."LFS Export Inv Bal Qty" := Rec."LFS Adv. Lic Export Qty." - Rec."LFS Export Invoice Qty.";
    end;

    trigger OnAfterGetCurrRecord()
    begin
        Rec.CalcFields("LFS Adv. Lic Export Qty.", "LFS Adv. License Imp Qty.", "LFS Export Invoice Qty.", "LFS Export Order Qty.", "LFS Import Invoice Qty.", "LFS Import Order Qty.");
        Rec."LFS Import Inv Bal Qty" := Rec."LFS Adv. License Imp Qty." + Rec."LFS Import Order Qty.";
        Rec."LFS Import Order Bal Qty" := Rec."LFS Adv. License Imp Qty." + Rec."LFS Import Invoice Qty.";
        Rec."LFS Export Inv Bal Qty" := Rec."LFS Adv. Lic Export Qty." - Rec."LFS Export Invoice Qty.";
    end;

    var
        EximLicenseLine: Record "LFS EXIM License Lines";
}