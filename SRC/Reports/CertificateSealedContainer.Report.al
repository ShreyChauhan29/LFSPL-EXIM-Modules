report 72005 "Certificate Sealed Container"
{
    ApplicationArea = All;
    Caption = 'Certificate Of Self Sealed Container';
    DefaultLayout = RDLC;
    RDLCLayout = './SRC/Reports Layouts/Certificate Of Self Sealed Container.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            column(Inv_No; "No.") { }
            column(Place; Place) { }
            column(Shipping_Bill_No_; "LFS Shipping Bill No.") { }
            column(Shipping_Bill_Date; "LFS Shipping Bill Date") { }
            column(Posting_Date; "Posting Date") { }
            column(Bill_to_Name; "Bill-to Name") { }
            column(Bill_to_Address; "Bill-to Address" + "Sales Invoice Header"."Bill-to Address 2") { }
            column(LFS_No__of_Packages; '') { }
            column(locationName; UpperCase(location.Name)) { }
            column(LocationGStNo; location."GST Registration No.") { }
            // column(LocationAddress; location.Address + "Location"."Address 2") { }
            column(GST_Without_Payment_of_Duty; "GST Without Payment of Duty") { }
            column(Bill_Of_Export_No; "Bill Of Export No.") { }
            column(Bill_Of_Export_Date; "Bill Of Export Date") { }
            column(Container_No; PostedExportInformation."LFS Container No.") { }
            column(Seal_Code; PostedExportInformation."LFS Container Seal No.") { }
            column(Container_Size; '') { }
            column(RFID_Seal_No; PostedExportInformation."LFS RFID Seal No.") { }
            column(Actual_Dispatch_Date; '') { }
            column(Vehicle_No_; "Vehicle No.") { }
            column(BuyersAddressName; BuyersAddress) { }
            column(ConsigneeAddress; ConsigneeAddress) { }
            column(LocationAddress; LocationAdress) { }
            column(ShippingLineSealNo; ShippingLineSealNo) { }
            column(SizeofContainer; SizeofContainer) { }
            column(TotalGrossWeight; TotalGrossWeight) { }
            trigger OnAfterGetRecord()
            var
                ContainerType: Record "LFS Container Type Master";
                SalesInvLine: Record "Sales Invoice Line";
                PostedPackingList: Record "LFS EXIM Posted Packing Table";
            begin
                Clear(LocationAdress);
                Clear(LocationState);
                Clear(LocationCountry);
                Clear(BuyersAddress);
                Clear(ConsigneeAddress);
                Clear(ShippingLineSealNo);
                Clear(SizeofContainer);
                if location.Get("Sales Invoice Header"."Location Code") then begin
                    if State_Rec.get(location."State Code") then LocationState := State_Rec.Description;
                    if Country_Rec.get(location."Country/Region Code") then LocationCountry := Country_Rec.Name;
                    LocationAdress := location.Address + ', ' + location."Address 2" + ', ' + location.City + '-' + location."Post Code" + ', ' + LocationState + ', ' + LocationCountry;
                end;

                Clear(Place);
                Dimension.Reset();
                Dimension.SetRange("Dimension Set ID", "Dimension Set ID");
                Dimension.SetRange("Dimension Value Code", "Shortcut Dimension 1 Code");
                if Dimension.FindFirst() then
                    Place := Dimension."Dimension Value Code";

                Clear(BuyersAddress);
                Clear(ConsigneeAddress);
                PostedExportInformation.Reset();
                PostedExportInformation.SetRange("LFS Document No.", "Sales Invoice Header"."No.");
                if PostedExportInformation.FindFirst() then begin
                    // BuyersAddress :=PostedExportInformation.add;
                    ShippingLineSealNo := PostedExportInformation."LFS Container Seal No.";
                    ContainerType.Reset();
                    ContainerType.SetRange("LFS Code", PostedExportInformation."LFS Container Type");
                    if ContainerType.FindFirst() then
                        SizeofContainer := ContainerType."LFS Description";
                    ConsigneeAddress := PostedExportInformation."LFS Consignee Name & Address";
                end;

                Clear(BuyerState);
                Clear(BuyerCountry);
                if BuyersAddress = '' then begin
                    if State_Rec.get("Location State Code") then BuyerState := State_Rec.Description;
                    if Country_Rec.get("Sell-to Country/Region Code") then BuyerCountry := Country_Rec.Name;
                    BuyersAddress := "Sell-to Address" + ', ' + "Sell-to Address 2" + ', ' + "Sell-to City" + '-' + "Sell-to Post Code" + ', ' + BuyerState + ', ' + BuyerCountry;
                end;

                Clear(ConsingneeState);
                Clear(ConsingneeCountry);
                if ConsigneeAddress = '' then begin
                    if State_Rec.get("GST Ship-to State Code") then ConsingneeState := State_Rec.Description;
                    if Country_Rec.get("Ship-to Country/Region Code") then ConsingneeCountry := Country_Rec.Name;
                    ConsigneeAddress := "Sell-to Address" + ', ' + "Sell-to Address 2" + ', ' + "Sell-to City" + '-' + "Sell-to Post Code" + ', ' + ConsingneeState + ', ' + ConsingneeCountry;
                end;

                SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                SalesInvLine.SetRange(Type, SalesInvLine.Type::"Item");
                if SalesInvLine.FindSet() then
                    repeat
                        PostedPackingList.Reset();
                        PostedPackingList.SetRange("LFS Source Document No.", "Sales Invoice Header"."No.");
                        PostedPackingList.SetRange("LFS Source Doc. Line No.", SalesInvLine."Line No.");
                        if PostedPackingList.FindSet() then
                            repeat
                                TotalGrossWeight += PostedPackingList."LFS Total Gross Weight";
                            until PostedPackingList.Next() = 0;
                    until SalesInvLine.Next() = 0;
            end;
        }
    }
    var
        Country_Rec: Record "Country/Region";
        Dimension: Record "Dimension Set Entry";
        location: Record "Location";

        PostedExportInformation: Record "LFS Posted Export Information";
        State_Rec: Record State;
        BuyerCountry, BuyerState : Text;
        ConsingneeCountry, ConsingneeState : Text;
        LocationCountry, LocationState : Text;
        Place: Text;
        BuyersAddress, ConsigneeAddress, LocationAdress, SizeofContainer : Text[2048];
        ShippingLineSealNo: Code[50];
        TotalGrossWeight: Decimal;

    procedure GetBlobBuyersAddressNameAsText(PostedExportInfo: Record "LFS Posted Export Information"): Text
    var
        InStr: InStream;
        BlobText: Text;
    begin
        // PostedExportInfo.CalcFields("Buyer Name & Address");
        // if PostedExportInfo."Buyer Name & Address".HasValue then begin
        //     PostedExportInfo."Buyer Name & Address".CreateInStream(InStr);
        //     InStr.Read(BlobText);
        // end;
        exit(BlobText);
    end;

    procedure GetBlobConsineeAsText(PostedExportInfo: Record "LFS Posted Export Information"): Text
    var
        InStr: InStream;
        BlobText: Text;
    begin
        // PostedExportInfo.CalcFields("Consignee Address");
        // if PostedExportInfo."Consignee Address".HasValue then begin
        //     PostedExportInfo."Consignee Address".CreateInStream(InStr);
        //     InStr.Read(BlobText);
        // end;
        exit(BlobText);
    end;
}