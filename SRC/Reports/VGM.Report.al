report 72010 VGM
{
    ApplicationArea = All;
    Caption = 'VGM';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './SRC/Reports Layouts/VGM.rdl';
    PreviewMode = PrintLayout;
    dataset
    {
        dataitem(SalesInvoiceHeader; "Sales Invoice Header")
        {
            column(Booking_No; BookingNo)
            {

            }
            column(Name_of_Shipper; CompanyInfo.Name)
            {

            }
            column(Shipper_Registration; 'CompanyInfo."I.E.C. CODE NO."')
            {

            }
            column(Name_and_Designation; 'Mr. CHENAL BHANDARI')
            {

            }
            column(Contact_Details; '+91-7227905820')
            {

            }
            column(Container_No; ContainerNo)
            {

            }
            column(Container_Size; 'SalesInvoiceHeader.HC')
            {

            }
            column(Maximum_Weight; VRC)
            {

            }
            column(Reg_No_and_Address; 'N/A')
            {

            }
            column(Weighing_Method; Weighing_Method)
            {

            }
            column(Gross_Mass_of_Container; Gross_Mass_of_Container)
            {

            }
            column(Unit_of_Measure; 'KG')
            {

            }
            column(Date_and_Time; Date_and_Time)
            {

            }
            column(Weighing_Slip_No; 'N/A')
            {

            }
            column(Un_No; 'N/A')
            {

            }
            column(Type; 'Normal')
            {

            }
            column(BookingNoExpInfo; BookingNoExpInfo) { }
            column(ContainerWeight; ContainerWeight) { }
            column(Posting_Date; "Posting Date") { }

            trigger OnPreDataItem()
            begin

                Clear(BookingNo);
                Clear(ContainerNo);
                Clear(Date_and_Time);
                Clear(VRC);
                Clear(Gross_Mass_of_Container);
                Clear(Weighing_Method);
                Clear(BookingNoExpInfo);
                Clear(ContainerWeight);

                CompanyInfo.Get();
            end;

            trigger OnAfterGetRecord()
            begin
                SalesInvLine.Reset();
                SalesInvLine.SetRange("Document No.", SalesInvoiceHeader."No.");
                SalesInvLine.SetFilter("No.", '<>%1', '');
                if SalesInvLine.FindFirst() then begin
                    WhsExpshipLine.Reset();
                    WhsExpshipLine.SetRange("Posted Source No.", SalesInvLine."Shipment No.");
                    if WhsExpshipLine.FindFirst() then begin
                        WhsExpship.Reset();
                        WhsExpship.SetRange("No.", WhsExpshipLine."No.");
                        if WhsExpship.FindFirst() then
                            BookingNo := WhsExpship."Whse. Shipment No.";
                    end;
                end;

                ExpInfo.Reset();
                ExpInfo.SetRange("LFS Document No.", SalesInvoiceHeader."No.");
                if ExpInfo.FindFirst() then
                    // begin
                    ContainerNo := ExpInfo."LFS Container No.";
                // Date_and_Time := ExpInfo."LFS Date and time of weighing";
                // VRC := ExpInfo."LFS VRC No.";
                // Gross_Mass_of_Container := ExpInfo."LFS Gross Mass of the Container";
                // Weighing_Method := Format(ExpInfo."LFS Weighing Method");
                // BookingNoExpInfo := ExpInfo."LFS Booking No.";
                // ContainerWeight := ExpInfo."LFS Container Weight";
                // end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        CompanyInfo: Record "Company Information";
        SalesInvLine: Record "Sales Invoice Line";
        WhsExpship: Record "Posted Whse. Shipment Header";
        WhsExpshipLine: Record "Posted Whse. Shipment Line";
        ExpInfo: Record "LFS Posted Export Information";
        ContainerNo: code[50];
        Date_and_Time: DateTime;
        Gross_Mass_of_Container: Decimal;
        VRC: Decimal;
        Weighing_Method: Text[50];
        BookingNoExpInfo: Code[20];
        BookingNo: Code[20];
        ContainerWeight: Decimal;

}
