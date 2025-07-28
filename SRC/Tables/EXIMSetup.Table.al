namespace LFSEximModule.LFSPLEXIMModule;
using Microsoft.Foundation.NoSeries;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Finance.GeneralLedger.Account;
table 72000 "LFS EXIM Setup"
{
    Caption = 'EXIM Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "LFS Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; "LFS Adv. License Nos."; Code[20])
        {
            Caption = 'Advance License Nos.';
            TableRelation = "No. Series".Code;
            DataClassification = CustomerContent;
        }
        field(4; "LFS Export Order Nos."; Code[20])
        {
            Caption = 'Export Order Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(5; "LFS Import Order Nos."; Code[10])
        {
            Caption = 'Import Order Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(6; "LFS Custom Packing List Nos."; Code[20])
        {
            Caption = 'Custom Packing List Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(7; "LFS Commercial PackList Nos."; Code[20])
        {
            Caption = 'Commercial Packing List Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(8; "LFS Commercial Invoice Nos."; Code[20])
        {
            Caption = 'Commercial Invoice Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(12; "LFS Advance Lic Calc. Type"; Option)
        {
            Caption = 'Advance License Calc. Type';
            OptionMembers = " ","Currency Exch.","Custom Exch.";
            OptionCaption = ' ,Currency Exch.,Custom Exch.';
            DataClassification = CustomerContent;
        }
        field(18; "LFS Export Invoice Nos."; Code[20])
        {
            Caption = 'Export Invoice Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(19; "LFS Import Invoice Nos."; Code[10])
        {
            Caption = 'Import Invoice Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(20; "LFS Posted Exp Shipment Nos."; Code[20])
        {
            Caption = 'Posted Export Shipment Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(21; "LFS Posted Exp Invoice Nos."; Code[20])
        {
            Caption = 'Posted Export Invoice Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(22; "LFS Posted Imp Invoice Nos."; Code[20])
        {
            Caption = 'Posted Import Invoice Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(23; "LFS Posted Imp Receipt Nos."; Code[20])
        {
            Caption = 'Posted Import Receipt Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(24; "LFS Blanket Exp Order No."; Code[20])
        {
            Caption = 'Blanket Export Order No.';
            TableRelation = "No. Series";
        }
        field(25; "LFS Blanket Imp Order No."; Code[10])
        {
            Caption = 'Blanket Import Order No.';
            TableRelation = "No. Series";
        }
        field(26; "LFS Warehouse Shipment Nos."; Code[20])
        {
            Caption = 'Warehouse Shipment Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(27; "LFS Post Whse Shipment Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Posted Whse. Shipment Nos.';
            TableRelation = "No. Series";
        }
        field(28; "LFS Rdp Cons Batch Name"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Rdp Cons Batch Name';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("LFS Rdp Jour. Template Name"));
        }
        field(29; "LFS Rdp Jour. Template Name"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Rdp Cons Jour. Template Name';
            TableRelation = "Gen. Journal Template";
        }
        field(30; "LFS Rdp Cons Account No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Rdp Cons Account No.';
            TableRelation = "G/L Account"."No.";
        }
        field(31; "LFS Rdp Cons Bal Acc. Num"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Rdp Cons Bal Acc. Num';
            TableRelation = "G/L Account"."No.";
        }
        field(32; "LFS RoDTEP %"; decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'RoDTEP %';
        }
        field(33; "LFS DDB %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'DDB %';
        }
        field(34; "LFS Import Validate Date"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Import Adv. License Validity Date';
        }
        field(35; "LFS Export Validate Date"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Export Adv. License Validity Date';
        }
        field(36; "LFS Rodtep Lic Expiry Date"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Rodtep License Validity Date';
        }
        field(37; "LFS DDB Batch Name"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'DDB Batch Name';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("LFS DDB Jour. Template Name"));
        }
        field(38; "LFS DDB Jour. Template Name"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'DDB Jour. Template Name';
            TableRelation = "Gen. Journal Template";
        }
        field(39; "LFS DDB Debit A/c No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'DDB Debit A/c No.';
            TableRelation = "G/L Account";
        }
        field(40; "LFS DDB Credit A/c No."; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'DDB Credit A/c No.';
            TableRelation = "G/L Account";
        }
        field(41; "LFS Rdp Batch Name"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Rdp Batch Name';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("LFS Rdp cons. Jour. Temp. Name"));
        }
        field(42; "LFS Rdp cons. Jour. Temp. Name"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Rdp Jour. Template Name';
            TableRelation = "Gen. Journal Template";
        }
        field(43; "LFS RoDTEP Debit A/c No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'RoDTEP Debit A/c No.';
            TableRelation = "G/L Account";
        }
        field(44; "LFS RoDTEP Credit A/c No."; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'RoDTEP Credit A/c No.';
            TableRelation = "G/L Account";
        }
        field(45; "LFS Rdp Lic Batch Name"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Rdp License Batch Name';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("LFS Rdp Lic Jour.Temp. Name"));
        }
        field(46; "LFS Rdp Lic Jour.Temp. Name"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Rdp Lic Jour. Template Name';
            TableRelation = "Gen. Journal Template";
        }
        field(47; "LFS Rdp Lic Account No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Rdp License Account No.';
            TableRelation = "G/L Account";
        }
        field(48; "LFS Rdp Lic Bal Acc. Num"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Rdp License Bal Acc. Num';
            TableRelation = "G/L Account";
        }
        field(51; "LFS RoDTEP License Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'RoDTEP License Nos.';

            TableRelation = "No. Series";
        }
        field(52; "LFS RoDTEP GL Ent Auto Post"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'RoDTEP G/L Entry Auto Post';
        }
        field(53; "LFS DDB GL Ent Auto Post"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'DDB G/L Entry Auto Post';
        }
        field(54; "LFS Cons GL Ent Auto Post"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'RoDTEP Lic. Cons G/L Entry Auto Post';
        }
        field(55; "LFS Lic GL Ent Auto Post"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'RoDTEP Lic G/L Entry Auto Post';
        }
        field(61; "LFS RdpDomesticJourTempName"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'RoDTEP Cons Jour. Template Name';
            TableRelation = "Gen. Journal Template";
        }
        field(62; "LFS RdpDomesticConsBatchName"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'RoDTEP Cons Batch Name';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("LFS Rdp cons. Jour. Temp. Name"));
        }
        field(63; "LFSEXRdpDomesticConsAccountNo."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'RoDTEP Cons Debit A/c No.';
            TableRelation = "G/L Account";
        }
        field(64; "LFS RdpDomesticConsBalAccNum"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'RoDTEP Cons Credit A/c No.';
            TableRelation = "G/L Account";
        }
        field(65; "LFS ConsDomesticGLEntAutoPost"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'RoDTEP Cons G/L Entry Auto Post';
        }
        field(66; "LFS Group Wise License"; Boolean)
        {
            Caption = 'Group Wise License';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "LFS Primary Key")
        {
            Clustered = true;
        }
    }
}