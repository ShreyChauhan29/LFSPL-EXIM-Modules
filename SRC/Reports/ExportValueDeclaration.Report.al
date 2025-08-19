report 72013 "Export Value Declaration"
{
    // UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Export Value Declaration';
    DefaultLayout = RDLC;
    RDLCLayout = './SRC/Reports Layouts/ExportValueDeclaration.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            column(Invoice_No; "No.") { }
            column(Invoice_Date; "Posting Date") { }
            column(Delivery_Terms; PostedExportInformation."LFS Terms of Delivery") { }
            column(Payment_Terms; "Payment Terms Code") { }
            column(Shipping_Bill_No_Prev; PostedExportInformation."LFS BL No/ AWB No.") { }
            column(Shipping_Bill_Date_Prev; PostedExportInformation."LFS BL Date/ AWB Date") { }
            column(CommercialTerm; PostedExportInformation."LFS Terms of Delivery") { }
            column(CustomTerm; "Payment Terms Code") { }
            column(Shipping_Bill_No; "LFS Shipping Bill No.") { }
            column(Shipping_Bill_Date; "LFS Shipping Bill Date") { }
            column(Payment_Terms_Code; "Payment Terms Code") { }
            column(CompanyInfoName; CompanyInfo.Name) { }
            trigger OnAfterGetRecord()
            begin
                if PostedExportInformation.get("No.", PostedExportInformation."LFS Document Type"::Invoice) then;
            end;
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get();
    end;

    var
        PostedExportInformation: Record "LFS Posted Export Information";
        CompanyInfo: Record "Company Information";
}