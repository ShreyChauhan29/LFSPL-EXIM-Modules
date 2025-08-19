report 72011 "Invoice Back Side"
{
    ApplicationArea = All;
    Caption = 'Invoice Back Side';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './SRC/Reports Layouts/Invoice Back Side.rdl';

    dataset
    {
        dataitem(SalesInvoiceHeader; "Sales Invoice Header")
        {
            column(No; "No.")
            {
            }
            column(Posting_Date; "Posting Date") { }
            column(Location_Code; LocationCode) { }
            column(RFIDESealNo; '"LFS RFID E-Seal No."')
            {
            }
            column(HC; 'HC')
            {
            }
            column(LocName; Name) { }
            column(LocAddress; Address) { }
            column(LocAddress1; Address1) { }
            column(LocPostCode; PostCode) { }
            column(LocCity; City) { }
            column(LocGSTNo; GSTNo) { }
            column(LocState; LocState) { }
            column(LocConutry; Conutry) { }
            column(LocTelNo; LocTelNo) { }
            column(SumQty; SumQty) { }
            column(SumGrossWt; SumGrossWt) { }
            column(ContainerNo; ContainerNo) { }
            column(LocationCode; LocationCode) { }
            column(ConatinerSize; ConatinerSize) { }
            column(NoofPackages; NoofPackages) { }
            trigger OnAfterGetRecord()
            var
                ContainerType: Record "LFS Container Type Master";
                PostedPackingList: Record "LFS EXIM Posted Packing Table";
            begin
                Clear(ConatinerSize);
                if Locationrec.get(SalesInvoiceHeader."Location Code") then begin
                    Name := Locationrec.name;
                    Address := Locationrec.address;
                    Address1 := Locationrec."Address 2";
                    PostCode := Locationrec."Post Code";
                    City := Locationrec.City;
                    GSTNo := Locationrec."GST Registration No.";
                    LocTelNo := Locationrec.Contact;

                    if RecState.get(Locationrec."State Code") then
                        LocState := RecState.Description;

                    if CountReg.Get(Locationrec."Country/Region Code") then
                        Conutry := CountReg.Name;
                end;

                ExpInfo.Reset();
                ExpInfo.SetRange("LFS Document No.", SalesInvoiceHeader."No.");
                if ExpInfo.FindFirst() then begin
                    ContainerNo := ExpInfo."LFS Container No.";
                    ContainerType.Reset();
                    ContainerType.SetRange("LFS Code", ExpInfo."LFS Container Type");
                    if ContainerType.FindFirst() then
                        ConatinerSize := ContainerType."LFS Description"
                end;

                SalesInvLine.Reset();
                SalesInvLine.SetRange("Document No.", SalesInvoiceHeader."No.");
                SalesInvLine.SetFilter(Type, '<>%1', SalesInvLine.Type::"Charge (Item)");
                if SalesInvLine.FindSet() then
                    repeat
                        // SumQty += SalesInvLine.Quantity;
                        // SumGrossWt += SalesInvLine."Gross Weight";
                        PostedPackingList.Reset();
                        PostedPackingList.SetRange("LFS Source Document No.", SalesInvLine."Document No.");
                        PostedPackingList.SetRange("LFS Source Doc. Line No.", SalesInvLine."Line No.");
                        if PostedPackingList.FindSet() then
                            repeat
                                NoofPackages += PostedPackingList."LFS No. of Packs";
                                SumGrossWt += PostedPackingList."LFS Total Gross Weight";
                            until PostedPackingList.next() = 0;
                    until SalesInvLine.Next() = 0;

                Clear(LocationCode);
                if SalesInvoiceHeader."Location Code" = 'DAM-FAC' then
                    LocationCode := 'DAMAN'
                else
                    if SalesInvoiceHeader."Location Code" = 'SIL-FAC' then
                        LocationCode := 'SILVASSA'
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
        CountReg: Record "Country/Region";
        RecState: Record State;
        Locationrec: Record Location;
        ExpInfo: Record "LFS Posted Export Information";
        SalesInvLine: Record "Sales Invoice Line";
        SumQty: Decimal;
        SumGrossWt, NoofPackages : Decimal;
        LocationCode, ConatinerSize : Text[100];
        ContainerNo: code[50];
        Name: text;
        Address: Text;
        Address1: Text;
        City: Text;
        ShippingMrks: Text;
        PostCode: Text;
        Conutry: Text;
        GSTNo: Text;
        LocTelNo: Text[100];
        LocState: Text;
}
