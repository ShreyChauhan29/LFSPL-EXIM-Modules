namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Sales.RoleCenters;
pageextension 72000 "Order Processor Role Cnt. Ext" extends "Order Processor Role Center"
{
    actions
    {
        addafter("Posted Documents")
        {
            group("LFS EXIM")
            {
                Caption = 'EXIM';
                Visible = true;
                group("LFS S&etup")
                {
                    Caption = 'Setup';
                    action("Exim Setup")
                    {
                        Image = Setup;
                        Caption = 'EXIM Setup';
                        ApplicationArea = all;
                        RunObject = page "LFS EXIM Setup";
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Setup is no longer shown in this page.';
                        ObsoleteTag = '19.0';
                        ToolTip = 'Open the EXIM Setup page to configure export/import-related parameters.';
                    }
                }
                group("LFS Master")
                {
                    Caption = 'Master';
                    action(EximSeaPortList)
                    {
                        Image = List;
                        Caption = 'Port Master List';
                        ApplicationArea = all;
                        RunObject = page "LFS Port Master List";
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Setup is no longer shown in this page.';
                        ObsoleteTag = '19.0';
                        ToolTip = 'View or manage the master list of sea ports used in EXIM operations.';
                    }
                    action(EximShippingLines)
                    {
                        Image = ShipmentLines;
                        Caption = 'Shipping Line Master';
                        ApplicationArea = all;
                        RunObject = page "LFS EXIM Shipping Lines";
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Setup is no longer shown in this page.';
                        ObsoleteTag = '19.0';
                        ToolTip = 'View or maintain the master list of shipping lines for EXIM activities.';
                    }
                    action(EximIncoTerms)
                    {
                        Caption = 'Inco Terms';
                        ApplicationArea = all;
                        RunObject = page "LFS EXIM Inco Terms";
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Setup is no longer shown in this page.';
                        ObsoleteTag = '19.0';
                        ToolTip = 'View or manage the EXIM Inco Terms used in export/import transactions.';
                    }
                    action(EximCurrencyExchangeRate)
                    {
                        Caption = 'Custom Currency Exchange Rates';
                        ApplicationArea = all;
                        RunObject = page "LFSEXIM Currency Exchange Rate";
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Setup is no longer shown in this page.';
                        ObsoleteTag = '19.0';
                        ToolTip = 'View or maintain the currency exchange rates used in EXIM transactions.';
                    }
                    action("EXIM LC Terms & Conditions")
                    {
                        Caption = 'EXIM LC Terms & Conditions';
                        ApplicationArea = all;
                        RunObject = page "LFS EXIM LC Terms & Conditions";
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Setup is no longer shown in this page.';
                        ObsoleteTag = '19.0';
                        Visible = false;
                        ToolTip = 'View or manage the terms and conditions for Letters of Credit (LC) in EXIM operations.';
                    }
                    action("LUT Master List")
                    {
                        Caption = 'LUT Master List';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "LFS LUT Master List";
                        ToolTip = 'View or manage the LUT (Letter of Undertaking) master list used in export operations.';
                    }
                    action("Container Type Master")
                    {
                        Caption = 'Container Type Master';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "LFS Container Type Master List";
                        ToolTip = 'View or manage the master list of container types used in shipping.';
                    }
                }
                group("LFS Schemes")
                {
                    Caption = 'Schemes';
                    action("EXIM RoDTEP Rate Setup")
                    {
                        Caption = 'RoDTEP Rate Setup';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "LFS EXIM RoDTEP Rate Setup";
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Setup is no longer shown in this page.';
                        ObsoleteTag = '19.0';
                        ToolTip = 'Open the EXIM RoDTEP Rate Setup page to configure rates for the RoDTEP scheme.';
                    }

                    action("EXIM DDB Rate Setup")
                    {
                        Caption = 'DDB Rate Setup';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "LFS EXIM DDB Rate Setup";
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Setup is no longer shown in this page.';
                        ObsoleteTag = '19.0';
                        ToolTip = 'Open the EXIM DDB Rate Setup page to configure rates for the Duty Drawback (DDB) scheme.';
                    }
                    action("EXIM License List")
                    {
                        Caption = 'Advance Licenses List';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "LFS EXIM License List";
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Setup is no longer shown in this page.';
                        ObsoleteTag = '19.0';
                        ToolTip = 'View or manage the list of EXIM licenses used in export/import operations.';
                    }
                    action("Rodtep License List")
                    {
                        Caption = 'RoDTEP Licenses List';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "LFS Rodtep License List";
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Setup is no longer shown in this page.';
                        ObsoleteTag = '19.0';
                        ToolTip = 'View or manage the list of RoDTEP licenses used in export/import operations.';
                    }
                }
                group("LFS Documents")
                {
                    Caption = 'Documents';
                    action("Export Blanket Sales Orders")
                    {
                        Caption = 'Export Blanket Sales Orders';
                        ApplicationArea = all;
                        RunObject = page "LFS Blanket Export Orders";
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Setup is no longer shown in this page.';
                        ToolTip = 'View or manage blanket export sales orders for international shipments.';
                    }
                    action("Export Sales Orders")
                    {
                        Caption = 'Export Sales Orders';
                        ApplicationArea = all;
                        RunObject = page "LFS Export Sales Orders";
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Setup is no longer shown in this page.';
                        ObsoleteTag = '19.0';
                        ToolTip = 'Access the list of export sales orders processed for overseas customers.';
                    }
                    action("Export Warehouse Shipment List")
                    {
                        Caption = 'Export Warehouse Shipment List';
                        ApplicationArea = all;
                        RunObject = page "LFS Export Whse. Shipment List";
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Setup is no longer shown in this page.';
                        ObsoleteTag = '19.0';
                        ToolTip = 'View export warehouse shipments prepared for dispatch.';
                    }
                    action("Export Sales Invoices")
                    {
                        Caption = 'Export Sales Invoices';
                        ApplicationArea = all;
                        RunObject = page "LFS Export Sales Invoices";
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Setup is no longer shown in this page.';
                        ObsoleteTag = '19.0';
                        ToolTip = 'Display export sales invoices generated for foreign trade customers.';
                    }
                    action("Export Sales Credit Memos")
                    {
                        Caption = 'Export Sales Credit Memos';
                        ApplicationArea = all;
                        RunObject = page "LFS Export Sales Credit Memos";
                        ToolTip = 'Display Export Sales Credit Memos generated for foreign trade customers.';
                    }
                    // action("EXIM Custom Packing List")
                    // {
                    //     Caption = 'EXIM Custom Packing List';
                    //     ApplicationArea = all;
                    //     RunObject = page "LFS EXIM Custom Packing List";
                    //     ObsoleteState = Pending;
                    //     ObsoleteReason = 'Setup is no longer shown in this page.';
                    //     ObsoleteTag = '19.0';
                    //     Visible = false;
                    //     ToolTip = 'Manage the custom packing list required for EXIM export documentation.';
                    // }
                    // action("EXIM Commercial Packing List")
                    // {
                    //     Caption = 'EXIM Commercial Packing List';
                    //     ApplicationArea = Basic, Suite;
                    //     RunObject = page "LFS EXIM CommercialPackingList";
                    //     ObsoleteState = Pending;
                    //     ObsoleteReason = 'Setup is no longer shown in this page.';
                    //     ObsoleteTag = '19.0';
                    //     Visible = false;
                    //     ToolTip = 'Display or generate commercial packing lists for export compliance.';
                    // }
                    action("Blanket Import Orders")
                    {
                        Caption = 'Blanket Import Purchase Orders';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "LFS Blanket Import Orders";
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Setup is no longer shown in this page.';
                        ToolTip = 'Access blanket import purchase orders planned for inbound shipments.';
                    }
                    action("Import Purchase Orders")
                    {
                        Caption = 'Import Purchase Orders';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "LFS Import Purchase Orders";
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Setup is no longer shown in this page.';
                        ObsoleteTag = '19.0';
                        ToolTip = 'Manage purchase orders related to import operations.';
                    }
                    action("Import Purchase Invoices")
                    {
                        Caption = 'Import Purchase Invoices';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "LFS Import Purchase Invoices";
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Setup is no longer shown in this page.';
                        ObsoleteTag = '19.0';
                        ToolTip = 'Review and manage purchase invoices related to imports.';
                    }
                    action("Import Purchase Credit Memos")
                    {
                        Caption = 'Import Purchase Credit Memos';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Import Purchase Credit Memos";
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Setup is no longer shown in this page.';
                        ObsoleteTag = '19.0';
                        ToolTip = 'Review and manage purchase Credit Memos related to imports.';
                    }
                }
                group("LFS Registers")
                {
                    Caption = 'Registers';
                    action("EXIM DDB Entries")
                    {
                        Caption = 'EXIM DDB Entries';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "LFS EXIM DDB Entries";
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Setup is no longer shown in this page.';
                        ObsoleteTag = '19.0';
                        ToolTip = 'View Duty Drawback (DDB) entries submitted under the EXIM scheme.';
                    }
                    action("EXIM RoDTEP Rebate Entries")
                    {
                        Caption = 'EXIM RoDTEP Rebate Entries';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "LFS EXIM RoDTEP Rebate Entries";
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Setup is no longer shown in this page.';
                        ObsoleteTag = '19.0';
                        ToolTip = 'Manage RoDTEP (Remission of Duties and Taxes on Exported Products) rebate entries.';
                    }
                }
                group("LFS Archives")
                {
                    Caption = 'Archives';
                    action("Exp Posted Whse. Shipment List")
                    {
                        Caption = 'Posted Export Whse. Shipment';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "LFSExpPostedWhse. ShipmentList";
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Setup is no longer shown in this page.';
                        ObsoleteTag = '19.0';
                        ToolTip = 'View archived export warehouse shipment records that have been posted.';
                    }
                    action("Posted Export Shipments")
                    {
                        Caption = 'Posted Export Shipments';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "LFS Posted Export Shipments";
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Setup is no longer shown in this page.';
                        ObsoleteTag = '19.0';
                        ToolTip = 'Access the list of posted export shipments for audit or tracking.';
                    }
                    action("Posted Export Invoices")
                    {
                        Caption = 'Posted Export Invoices';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "LFS Posted Export Invoices";
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Setup is no longer shown in this page.';
                        ObsoleteTag = '19.0';
                        ToolTip = 'View posted export invoices issued to overseas customers.';
                    }
                    action("Posted Export Credit Memos")
                    {
                        Caption = 'Posted Export Credit Memos';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Pstd Export Sales Credit Memos";
                        ToolTip = 'View posted export Credit Memos issued to overseas customers.';
                    }
                    // action("EXIM PostedCustom Packing List")
                    // {
                    //     Caption = 'EXIM PostedCustom Packing List';
                    //     ApplicationArea = Basic, Suite;
                    //     RunObject = page "LFSEXIMPostedCustomPackingList";
                    //     ObsoleteState = Pending;
                    //     ObsoleteReason = 'Setup is no longer shown in this page.';
                    //     ObsoleteTag = '19.0';
                    //     Visible = false;
                    //     ToolTip = 'Access the posted version of the EXIM custom packing list for historical reference.';
                    // }
                    action("Posted Import Purch Receipts")
                    {
                        Caption = 'Posted Import Receipts';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "LFS Posted ImportPurchReceipts";
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Setup is no longer shown in this page.';
                        ObsoleteTag = '19.0';
                        ToolTip = 'Review posted import purchase receipt records for completed imports.';
                    }
                    action("Posted Import Invoices")
                    {
                        Caption = 'Posted Import Invoices';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "LFS Posted Import Invoices";
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Setup is no longer shown in this page.';
                        ObsoleteTag = '19.0';
                        ToolTip = 'Access posted invoices for imported goods for accounting and tracking.';
                    }
                    action("Posted Purch Import Cr Memos")
                    {
                        Caption = 'Posted Import Purchase Credit Memos';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Pstd Import Purch Credit Memos";
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Setup is no longer shown in this page.';
                        ObsoleteTag = '19.0';
                        ToolTip = 'View posted credit memos issued for import purchase returns or adjustments.';
                    }
                    action("EXIM Closed Adv. License List")
                    {
                        Caption = 'Closed EXIM License';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "LFS EXIMClosed Adv.LicenseList";
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Setup is no longer shown in this page.';
                        ObsoleteTag = '19.0';
                        ToolTip = 'Display the list of closed EXIM advance licenses for reference and audit.';
                    }
                }
            }
            group("LFS Custom Reports")
            {
                Caption = 'Custom Reports';
            }
        }
    }
}