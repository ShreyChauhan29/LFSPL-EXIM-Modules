namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.History;
using Microsoft.Sales.Comment;
using Microsoft.Utilities;
using System.Automation;
using Microsoft.Finance.Dimension;

page 72075 "LFS Posted Export Shipment"
{
    ApplicationArea = All;
    Caption = 'Posted Export Shipment';
    PageType = Document;
    SourceTable = "Sales Shipment Header";
    Permissions = TableData "Sales Shipment Header" = rm, TableData "Sales Shipment Line" = rm;
    InsertAllowed = false;
    DeleteAllowed = false;
    SourceTableView = where("LFS Exim Type" = filter(Export));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the record.';
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer.';
                    ApplicationArea = All;
                }
                field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                {
                    ToolTip = 'Specifies the contact number.';
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ToolTip = 'Specifies the name of customer at the sell-to address.';
                    ApplicationArea = All;
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    ToolTip = 'Specifies the customer''s sell-to address.';
                    ApplicationArea = All;
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    ToolTip = 'Specifies the customer''s extended sell-to address.';
                    ApplicationArea = All;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ToolTip = 'Specifies the post code of the customer''s sell-to address.';
                    ApplicationArea = All;
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ToolTip = 'Specifies the city of the customer on the sales document.';
                    ApplicationArea = All;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ToolTip = 'Specifies the name of the contact at the customer''s sell-to address.';
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the posting date for the entry.';
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the posting date of the document.';
                    ApplicationArea = All;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ToolTip = 'Specifies the date that the customer has asked for the order to be delivered.';
                    ApplicationArea = All;
                }
                field("Quote No."; Rec."Quote No.")
                {
                    ToolTip = 'Specifies the number of the sales quote document if a quote was used to start the sales process.';
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    ToolTip = 'Specifies the number of the sales order that this invoice was posted from.';
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the number that the customer uses in their own system to refer to this sales document.';
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Specifies a code for the salesperson who normally handles this customer''s account.';
                    ApplicationArea = All;
                }

            }
            group("Shipping Bill Details")
            {
                field("Shipping Bill No."; Rec."LFS Shipping Bill No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shipping Bill No.';
                }
                field("Shipping Bill Date"; Rec."LFS Shipping Bill Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shipping Bill Date';
                }
                // field("Late export order No."; Rec."LFS Late export order No.")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the Late export order No.';
                // }
                // field("Late export order date"; Rec."LFS Late export order date")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the Late export order date';
                // }
                // field("bill No."; Rec."LFS bill No.")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the Bill No.';
                // }
                // field("bill Date"; Rec."LFS bill Date")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the Bill Date';
                // }
            }
            part(SalesShipmLines; "LFS EXIM Posted Shpt. Subform")
            {
                ApplicationArea = all;
                Editable = false;
                SubPageLink = "Document No." = field("No.");
            }
            group(Invoicing)
            {
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer at the billing address.';
                    ApplicationArea = All;
                }
                field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                {
                    ToolTip = 'Specifies the number of the contact person at the customer''s bill-to address.';
                    ApplicationArea = All;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ToolTip = 'Specifies the name of the customer that you sent the invoice to.';
                    ApplicationArea = All;
                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    ToolTip = 'Specifies the address that you sent the invoice to.';
                    ApplicationArea = All;
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                    ToolTip = 'Specifies the extended address that you sent the invoice to.';
                    ApplicationArea = All;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ToolTip = 'Specifies the post code of the customer''s bill-to address.';
                    ApplicationArea = All;
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                    ToolTip = 'Specifies the city of the customer on the sales document.';
                    ApplicationArea = All;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ToolTip = 'Specifies the name of the person you regularly contact at the customer to whom you sent the invoice.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    ApplicationArea = All;
                }
            }
            group(EXIM)
            {
                field("Port of Loading"; Rec."LFS Port of Loading")
                {
                    ToolTip = 'Specifies the value of the Port of Loading field.';
                    ApplicationArea = All;
                }
                field("Port of Discharge"; Rec."LFS Port of Discharge")
                {
                    ToolTip = 'Specifies the value of the Port of Discharge field.';
                    ApplicationArea = All;
                }
                field("Country of Final Destination"; Rec."LFS Country of Final Dest.")
                {
                    ToolTip = 'Specifies the value of the Country of Final Destination field.';
                    ApplicationArea = All;
                }
                field("Final Destination"; Rec."LFS Final Destination")
                {
                    ToolTip = 'Specifies the value of the Final Destination field.';
                    ApplicationArea = All;
                }
                field("Country of Origin of Goods"; Rec."LFS Country Origin Goods")
                {
                    ToolTip = 'Specifies the value of the Country of Origin of Goods field.';
                    ApplicationArea = All;
                }
                field("Inco Terms"; Rec."LFS Inco Terms")
                {
                    ToolTip = 'Specifies the value of the Inco Terms field.';
                    ApplicationArea = All;
                }
                field("Customs Bank Account"; Rec."LFS Customs Bank Account")
                {
                    ToolTip = 'Specifies the value of the Customs Bank Account field.';
                    ApplicationArea = All;
                }
                field("Commercial  Bank Account"; Rec."LFS Commercial Bank Account")
                {
                    ToolTip = 'Specifies the value of the Commercial  Bank Account field.';
                    ApplicationArea = All;
                }
                field("Export Remark"; Rec."LFS Export Remark")
                {
                    ToolTip = 'Specifies the value of the Export Remark field.';
                    ApplicationArea = All;
                }
                field("Pre Carriage"; Rec."LFS Pre Carriage")
                {
                    ToolTip = 'Specifies the value of the Pre Carriage field.';
                    ApplicationArea = All;
                }
                field(ETA; Rec."LFS ETA")
                {
                    ToolTip = 'Specifies the value of the ETA field.';
                    ApplicationArea = All;
                }
                field(ETD; Rec."LFS ETD")
                {
                    ToolTip = 'Specifies the value of the ETD field.';
                    ApplicationArea = All;
                }
                // field("FTT No."; Rec."LFS FTT No.")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     ToolTip = 'Specifies the FTT No.';
                // }
                // field("FTT Date"; Rec."LFS FTT Date")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     ToolTip = 'Specifies the FTT Date';
                // }
                // field("BIN No."; Rec."LFS BIN No.")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     ToolTip = 'Specifies the BIN No.';
                // }
                // field("Additional Information"; Rec."LFS Additional Information")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the Additional Information';
                // }
            }
            group(Shipping)
            {
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies the code for the customer''s additional shipment address.';
                    ApplicationArea = All;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTip = 'Specifies the name of the customer that you delivered the items to.';
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ToolTip = 'Specifies the address that you delivered the items to.';
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ToolTip = 'Specifies the extended address that you delivered the items to.';
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ToolTip = 'Specifies the post code of the customer''s ship-to address.';
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ToolTip = 'Specifies the city of the customer on the sales document.';
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ToolTip = 'Specifies the name of the person you regularly contact at the address that the items were shipped to.';
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location from where inventory items to the customer on the sales document are to be shipped by default.';
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ToolTip = 'Specifies the shipment method for the shipment.';
                    ApplicationArea = All;
                }
                field("Package Tracking No."; Rec."Package Tracking No.")
                {
                    ToolTip = 'Specifies the shipping agent''s package number.';
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ToolTip = 'Specifies when items on the document are shipped or were shipped. A shipment date is usually calculated from a requested delivery date plus lead time.';
                    ApplicationArea = All;
                }
                field("Time of Removal"; Rec."Time of Removal")
                {
                    ToolTip = 'Specifies the time of removal.';
                    ApplicationArea = All;
                }
                field("Mode of Transport"; Rec."Mode of Transport")
                {
                    ToolTip = 'Specifies the transportation mode e.g. by road, by air etc.';
                    ApplicationArea = All;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ToolTip = 'Specifies the value of the Vehicle No. field.';
                    ApplicationArea = All;
                }

                field("E-Way Bill No."; Rec."E-Way Bill No.")
                {
                    ToolTip = 'Specifies the value of the E-Way Bill No. field.';
                    ApplicationArea = All;
                }
            }
            group("Tax Information")
            {
                field("GST Bill-to State Code"; Rec."GST Bill-to State Code")
                {
                    ToolTip = 'Specifies the bill-to state code of the customer on the sales document.';
                    ApplicationArea = All;
                }
                field("GST Ship-to State Code"; Rec."GST Ship-to State Code")
                {
                    ToolTip = 'Specifies the ship-to state code of the customer on the sales document.';
                    ApplicationArea = All;
                }
                field("Location State Code"; Rec."Location State Code")
                {
                    ToolTip = 'Specifies the sate code mentioned of the location on the sales document.';
                    ApplicationArea = All;
                }
                field("GST Customer Type"; Rec."GST Customer Type")
                {
                    ToolTip = 'Specifies the type of the customer. For example, Registered, Unregistered, Export etc..';
                    ApplicationArea = All;
                }
                field("GST Without Payment of Duty"; Rec."GST Without Payment of Duty")
                {
                    ToolTip = 'Specifies if the invoice is a GST invoice with or without payment of duty.';
                    ApplicationArea = All;
                }
                field("Invoice Type"; Rec."Invoice Type")
                {
                    ToolTip = 'Specifies the invoice type on the sales document. For example, Bill of supply, export, supplementary, debit note, non-GST and taxable.';
                    ApplicationArea = All;
                }
                field("Bill Of Export No."; Rec."Bill Of Export No.")
                {
                    ToolTip = 'Specifies the bill of export number. It is a document number which is submitted to custom department.';
                    ApplicationArea = All;
                }
                field("Bill Of Export Date"; Rec."Bill Of Export Date")
                {
                    ToolTip = 'Specifies the entry date defined in bill of export document.';
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Notes; Notes)
            {
                ApplicationArea = all;
                Visible = true;
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("&Shipment")
            {
                Caption = '&Shipment';
                Image = Shipment;
                action(Statistics)
                {
                    ApplicationArea = Suite;
                    Caption = 'Statistics';
                    Image = Statistics;
                    RunObject = Page "Sales Shipment Statistics";
                    RunPageLink = "No." = field("No.");
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';
                }
                action("Co&mments")
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = const(Shipment),
                                  "No." = field("No."),
                                  "Document Line No." = const(0);
                    ToolTip = 'View or add comments for the record.';
                }
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
                action(Approvals)
                {
                    AccessByPermission = TableData "Posted Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ShowPostedApprovalEntries(Rec.RecordId);
                    end;
                }
                action(CertificateOfSupplyDetails)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Certificate of Supply Details';
                    Image = Certificate;
                    RunObject = Page "Certificates of Supply";
                    RunPageLink = "Document Type" = filter("Sales Shipment"),
                                  "Document No." = field("No.");
                    ToolTip = 'View the certificate of supply that you must send to your customer for signature as confirmation of receipt. You must print a certificate of supply if the shipment uses a combination of VAT business posting group and VAT product posting group that have been marked to require a certificate of supply in the VAT Posting Setup window.';
                }
                action(PrintCertificateofSupply)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Print Certificate of Supply';
                    Image = PrintReport;
                    ToolTip = 'Print the certificate of supply that you must send to your customer for signature as confirmation of receipt.';

                    trigger OnAction()
                    var
                        CertificateOfSupply: Record "Certificate of Supply";
                    begin
                        CertificateOfSupply.SetRange("Document Type", CertificateOfSupply."Document Type"::"Sales Shipment");
                        CertificateOfSupply.SetRange("Document No.", Rec."No.");
                        CertificateOfSupply.Print();
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("&Track Package")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Track Package';
                    Image = ItemTracking;
                    ToolTip = 'Open the shipping agent''s tracking page to track the package. ';

                    trigger OnAction()
                    begin
                        Rec.StartTrackingSite();
                    end;
                }
            }
            action("&Print")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                ToolTip = 'Print the shipping notice.';

                trigger OnAction()
                begin
                    SalesShptHeader := Rec;
                    CurrPage.SetSelectionFilter(SalesShptHeader);
                    SalesShptHeader.PrintRecords(true);
                end;
            }
            action("&Navigate")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Find entries...';
                Image = Navigate;
                ShortCutKey = 'Ctrl+Alt+Q';
                ToolTip = 'Find entries and documents that exist for the document number and posting date on the selected document. (Formerly this action was named Navigate.)';

                trigger OnAction()
                begin
                    Rec.Navigate();
                end;
            }
            action("Update Document")
            {
                ApplicationArea = Suite;
                Caption = 'Update Document';
                Image = Edit;
                ToolTip = 'Add new information that is relevant to the document, such as information from the shipping agent. You can only edit a few fields because the document has already been posted.';

                trigger OnAction()
                var
                    PostedSalesShipmentUpdate: Page "Posted Sales Shipment - Update";
                begin
                    PostedSalesShipmentUpdate.LookupMode := true;
                    PostedSalesShipmentUpdate.SetRec(Rec);
                    PostedSalesShipmentUpdate.RunModal();
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

                actionref("Update Document_Promoted"; "Update Document")
                {
                }
                actionref("&Print_Promoted"; "&Print")
                {
                }
                actionref("&Navigate_Promoted"; "&Navigate")
                {
                }
                actionref("&Track Package_Promoted"; "&Track Package")
                {
                }
                group(Category_Category4)
                {
                    Caption = 'Print/Send', Comment = 'Generated from the PromotedActionCategories property index 3.';
                }
            }
            group(Category_Category5)
            {
                Caption = 'Shipment', Comment = 'Generated from the PromotedActionCategories property index 4.';

                actionref(Dimensions_Promoted; Dimensions)
                {
                }
                actionref(Statistics_Promoted; Statistics)
                {
                }
                actionref(Approvals_Promoted; Approvals)
                {
                }
                actionref("Co&mments_Promoted"; "Co&mments")
                {
                }
            }
            group("Category_Certificate of Supply")
            {
                Caption = 'Certificate of Supply';

                actionref(PrintCertificateofSupply_Promoted; PrintCertificateofSupply)
                {
                }
                actionref(CertificateOfSupplyDetails_Promoted; CertificateOfSupplyDetails)
                {
                }
            }
            group(Category_Report)
            {
                Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetSecurityFilterOnRespCenter();
    end;

    var
        SalesShptHeader: Record "Sales Shipment Header";
}