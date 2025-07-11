namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Sales.History;
using Microsoft.Utilities;
using Microsoft.Finance.Dimension;

page 72076 "LFS Posted Export Shipments"
{
    ApplicationArea = All;
    Caption = 'Posted Export Shipments';
    PageType = List;
    SourceTable = "Sales Shipment Header";
    UsageCategory = History;
    SourceTableView = where("LFS Exim Type" = filter(Export));
    InsertAllowed = false;
    DeleteAllowed = false;
    Editable = false;
    CardPageId = "LFS Posted Export Shipment";

    layout
    {
        area(content)
        {
            repeater(General)
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
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ToolTip = 'Specifies the name of customer at the sell-to address.';
                    ApplicationArea = All;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ToolTip = 'Specifies the post code of the customer''s sell-to address.';
                    ApplicationArea = All;
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region of the customer on the sales document.';
                    ApplicationArea = All;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ToolTip = 'Specifies the name of the contact at the customer''s sell-to address.';
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer at the billing address.';
                    ApplicationArea = All;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ToolTip = 'Specifies the name of the customer that you sent the invoice to.';
                    ApplicationArea = All;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ToolTip = 'Specifies the post code of the customer''s bill-to address.';
                    ApplicationArea = All;
                }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country or region of the address.';
                    ApplicationArea = All;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ToolTip = 'Specifies the name of the person you regularly contact at the customer to whom you sent the invoice.';
                    ApplicationArea = All;
                }
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
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ToolTip = 'Specifies the post code of the customer''s ship-to address.';
                    ApplicationArea = All;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ToolTip = 'Specifies the customer''s country/region.';
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ToolTip = 'Specifies the name of the person you regularly contact at the address that the items were shipped to.';
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the posting date for the entry.';
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Specifies a code for the salesperson who normally handles this customer''s account.';
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
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the currency code of the shipment.';
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location from where inventory items to the customer on the sales document are to be shipped by default.';
                    ApplicationArea = All;
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    ToolTip = 'Specifies how many times the document has been printed.';
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
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ToolTip = 'Specifies the shipment method for the shipment.';
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ToolTip = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.';
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ToolTip = 'Specifies when items on the document are shipped or were shipped. A shipment date is usually calculated from a requested delivery date plus lead time.';
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
        area(Processing)
        {
            group("&Shipment")
            {
                Caption = '&Shipment';
                Image = Shipment;
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    ToolTip = 'Specifies the ';
                    AccessByPermission = tabledata Dimension = R;
                    Image = Dimensions;

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions();
                    end;
                }
                action(CertificateOfSupplyDetails)
                {
                    ApplicationArea = All;
                    Caption = 'Certificate of Supply Details';
                    ToolTip = 'Specifies the Certificate of Supply Details';
                    Image = Certificate;
                    RunObject = page "Certificates of Supply";
                    RunPageLink = "Document Type" = filter("Sales Shipment"), "Document No." = field("No.");

                }
                action(PrintCertificateofSupply)
                {
                    ApplicationArea = All;
                    Caption = 'Print Certificate of Supply';
                    ToolTip = 'Specifies the Print Certificate of Supply';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        CertificateOfSupply: Record "Certificate of Supply";
                    begin
                        CertificateOfSupply.SETRANGE("Document Type", CertificateOfSupply."Document Type"::"Sales Shipment");
                        CertificateOfSupply.SETRANGE("Document No.", Rec."No.");
                        CertificateOfSupply.Print();
                    end;
                }

            }
        }
        area(Navigation)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = Action;
                action(TrackPackage)
                {
                    ApplicationArea = All;
                    Image = ItemTracing;
                    ToolTip = 'Specifies the Track Package';

                    trigger OnAction()
                    begin
                        Rec.StartTrackingSite();
                    end;
                }
                action("&Print")
                {
                    ApplicationArea = All;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;
                    Ellipsis = true;
                    ToolTip = 'Specifies the ';

                    trigger OnAction()
                    begin
                        CurrPage.SETSELECTIONFILTER(SalesShptHeader);
                        SalesShptHeader.PrintRecords(true);
                    end;

                }
                action("&Navigate")
                {
                    ApplicationArea = All;
                    Caption = '&Navigate';
                    ToolTip = 'Specifies the Navigate';
                    Image = Navigate;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.Navigate();
                    end;
                }
                action("Custom Invoice Report")
                {
                    ApplicationArea = All;
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    ToolTip = 'Specifies the ';
                    trigger OnAction()
                    begin
                        SalesShptHeader.Reset();
                        SalesShptHeader.SETRANGE("No.", Rec."No.");
                    end;
                }
                // action("Posted Export Shipment Update")
                // {
                //     ApplicationArea = All;
                //     CaptionML = ENU = 'Posted Export Shipment Update';
                //     Image = ViewPage;
                //     Promoted = true;
                //     PromotedIsBig = true;

                //     trigger OnAction()
                //     begin

                //     end;
                // }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetSecurityFilterOnRespCenter();
    end;

    var
        SalesShptHeader: Record "Sales Shipment Header";

    procedure GetResult(VAR SlShipHdr: Record "Sales Shipment Header")
    begin
        CurrPage.SETSELECTIONFILTER(SlShipHdr);
    end;
}