namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Foundation.Address;
using Microsoft.Finance.TaxBase;

table 72001 "LFS EXIM Port"
{
    Caption = 'EXIM Port';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "LFS Code"; Code[50])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; "LFS Port Name"; Text[80])
        {
            Caption = 'Port Name';
            DataClassification = CustomerContent;
        }
        field(3; "LFS Address"; Text[50])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
        }
        field(4; "LFS Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = CustomerContent;
        }
        field(5; "LFS City"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'City';
            ValidateTableRelation = false;

            TableRelation = if ("LFS Country/Region Code" = const()) "Post Code".City
            else
            if ("LFS Country/Region Code" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("LFS Country/Region Code"));

            trigger OnValidate()
            var
                LFSCounty: Text[30];
            begin
                PostCode.ValidateCity("LFS City", "LFS Post Code", LFSCounty, "LFS Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(6; "LFS Post Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Post Code';
            ValidateTableRelation = false;

            TableRelation = if ("LFS Country/Region Code" = const()) "Post Code"
            else
            if ("LFS Country/Region Code" = FILTER(<> '')) "Post Code" where("Country/Region Code" = FIELD("LFS Country/Region Code"));

            trigger OnValidate()
            var
                LFSCounty: Text[30];
            begin
                PostCode.ValidatePostCode("LFS City", "LFS Post Code", LFSCounty, "LFS Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(7; "LFS State Code"; Code[10])
        {
            TableRelation = State;
            Caption = 'State Code';
            DataClassification = CustomerContent;
        }
        field(8; "LFS Country/Region Code"; Code[10])
        {
            TableRelation = "Country/Region";
            Caption = 'Country/Region Code';
            DataClassification = CustomerContent;
        }
        field(9; "LFS Sea Port"; Boolean)
        {
            Caption = 'Sea Port';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "LFS Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "LFS Code", "LFS Port Name", "LFS Address", "LFS Address 2", "LFS City", "LFS Post Code", "LFS State Code", "LFS Country/Region Code", "LFS Sea Port")
        {
        }
    }

    var
        PostCode: Record "Post Code";
}