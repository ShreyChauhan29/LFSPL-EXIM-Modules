namespace LFSEximModule.LFSPLEXIMModule;
page 72000 "LFS EXIM Setup"
{
    AdditionalSearchTerms = 'Exim Module,Exim,Export Setup, Import Setup';
    ApplicationArea = All;
    Caption = 'EXIM Setup';
    PageType = Card;
    SourceTable = "LFS EXIM Setup";
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("RoDTEP %"; Rec."LFS RoDTEP %")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the RoDTEP %';
                }
                field("DDB %"; Rec."LFS DDB %")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the DDB %';
                }
                field("Import Validate Date"; Rec."LFS Import Validate Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Import Validate Date';
                }
                field("Export Validate Date"; Rec."LFS Export Validate Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Export Validate Date';
                }
                field("Rodtep License Expiry Date"; Rec."LFS Rodtep Lic Expiry Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Rodtep License Expiry Date';
                }
            }
            group("Number Series")
            {
                field("Advance License Nos."; Rec."LFS Adv. License Nos.")
                {
                    ToolTip = 'Specifies the value of the Advance License Nos. field.';
                    ApplicationArea = All;
                }
                field("LFS RoDTEP License Nos."; Rec."LFS RoDTEP License Nos.")
                {
                    ToolTip = 'Specifies the value of the Remission of Duties and Taxes on Exported Products License No. field.';
                    ApplicationArea = All;
                }
                field("LFS Export Sales Quote Nos."; Rec."LFS Export Sales Quote Nos.")
                {
                    ToolTip = 'Specifies the value of the Export Sales Quote Nos. field.', Comment = '%';
                }
                field("LFS Blanket Exp Order No."; Rec."LFS Blanket Exp Order No.")
                {
                    ToolTip = 'Specifies the value of the Blanket Export Order No. field.', Comment = '%';
                }
                field("LFS Blanket Imp Order No."; Rec."LFS Blanket Imp Order No.")
                {
                    ToolTip = 'Specifies the value of the Blanket Import Order No. field.', Comment = '%';
                }
                field("Export Order Nos."; Rec."LFS Export Order Nos.")
                {
                    ToolTip = 'Specifies the value of the Export Order Nos. field.';
                    ApplicationArea = All;
                }
                field("Import Order Nos."; Rec."LFS Import Order Nos.")
                {
                    ToolTip = 'Specifies the value of the Import Order Nos. field.';
                    ApplicationArea = All;
                }
                field("Export Invoice Nos."; Rec."LFS Export Invoice Nos.")
                {
                    ToolTip = 'Specifies the value of the Export Invoice Nos. field.';
                    ApplicationArea = All;
                }
                field("LFS Export SalesCreditMemoNos."; Rec."LFS Export SalesCreditMemoNos.")
                {
                    ToolTip = 'Specifies the value of the Export Sales Credit Memo Nos. field.', Comment = '%';
                }
                field("Posted Export Shipment Nos."; Rec."LFS Posted Exp Shipment Nos.")
                {
                    ToolTip = 'Specifies the value of the Posted Export Shipment Nos. field.';
                    ApplicationArea = All;
                }
                field("Posted Export Invoice Nos."; Rec."LFS Posted Exp Invoice Nos.")
                {
                    ToolTip = 'Specifies the value of the Posted Export Invoice Nos. field.';
                    ApplicationArea = All;
                }
                field("LFS Pstd Export SalesCrMemoNos"; Rec."LFS Pstd Export SalesCrMemoNos")
                {
                    ToolTip = 'Specifies the value of the Posted Export Sales Credit Memo Nos. field.', Comment = '%';
                }
                field("Import Invoice Nos."; Rec."LFS Import Invoice Nos.")
                {
                    ToolTip = 'Specifies the value of the Import Invoice Nos. field.';
                    ApplicationArea = All;
                }
                field("Posted Import Invoice Nos."; Rec."LFS Posted Imp Invoice Nos.")
                {
                    ToolTip = 'Specifies the value of the Posted Import Invoice Nos. field.';
                    ApplicationArea = All;
                }
                field("Posted Import Receipt Nos."; Rec."LFS Posted Imp Receipt Nos.")
                {
                    ToolTip = 'Specifies the value of the Posted Import Receipt Nos. field.';
                    ApplicationArea = All;
                }
                field("Custom Packing List Nos."; Rec."LFS Custom Packing List Nos.")
                {
                    ToolTip = 'Specifies the value of the Custom Packing List No. field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Commercial Packing List Nos."; Rec."LFS Commercial PackList Nos.")
                {
                    ToolTip = 'Specifies the value of the Commercial Packing List Nos. field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Commercial Invoice Nos."; Rec."LFS Commercial Invoice Nos.")
                {
                    ToolTip = 'Specifies the value of the Commercial Invoice No. field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Warehouse Shipment Nos."; Rec."LFS Warehouse Shipment Nos.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Warehouse Shipment Nos.';
                }
                field("Posted Warehouse Shipment Nos."; Rec."LFS Post Whse Shipment Nos.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Posted Warehouse Shipment Nos.';
                }
            }
            group("License Setup")
            {
                Visible = false;
                field("Advance License Calc. Type"; Rec."LFS Advance Lic Calc. Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Advance License Calc. Type';
                }
            }
            group("DDB/Rodtep Posting Setup(Export)")
            {
                group("DDB Setup(Export)")
                {
                    ShowCaption = false;
                    field("DDB Jour. Template Name"; Rec."LFS DDB Jour. Template Name")
                    {
                        ApplicationArea = all;
                        ToolTip = 'Specifies the DDB Jour. Template Name';
                    }
                    field("DDB Batch Name"; Rec."LFS DDB Batch Name")
                    {
                        ApplicationArea = all;
                        ToolTip = 'Specifies the DDB Batch Name';
                    }
                    field("DDB Debit A/c No."; Rec."LFS DDB Debit A/c No.")
                    {
                        ApplicationArea = all;
                        Caption = 'DDB Debit A/c No.';
                        ToolTip = 'Specifies the DDB Debit A/c No.';
                    }
                    field("DDB Credit A/c No."; Rec."LFS DDB Credit A/c No.")
                    {
                        ApplicationArea = all;
                        Caption = 'DDB Credit A/c No.';
                        ToolTip = 'Specifies the DDB Credit A/c No.';
                    }
                    field("LFS DDB GL Ent Auto Post"; Rec."LFS DDB GL Ent Auto Post")
                    {
                        ApplicationArea = all;
                        ToolTip = 'Specifies the DDB GL Ent Auto Post';
                    }
                }
                group("Rodtep Posting Setup(Export)")
                {
                    ShowCaption = false;
                    field("Rdp Jour. Template Name"; Rec."LFS Rdp Jour. Template Name")
                    {
                        ApplicationArea = all;
                        ToolTip = 'Specifies the RoDTEP Jour. Template Name';
                        Caption = 'RoDTEP Jour. Template Name';
                    }
                    field("Rdp Batch Name"; Rec."LFS Rdp Batch Name")
                    {
                        ApplicationArea = all;
                        ToolTip = 'Specifies the RoDTEP Batch Name';
                        Caption = 'RoDTEP Batch Name';
                    }
                    field("RoDTEP Debit A/c No."; Rec."LFS RoDTEP Debit A/c No.")
                    {
                        ApplicationArea = ALL;
                        ToolTip = 'Specifies the RoDTEP Debit A/c No.';
                        caption = 'RoDTEP Debit A/c No.';
                    }
                    field("RoDTEP Credit A/c No."; Rec."LFS RoDTEP Credit A/c No.")
                    {
                        ApplicationArea = all;
                        ToolTip = 'Specifies the RoDTEP Credit A/c No.';
                        caption = 'RoDTEP Credit A/c No.';
                    }
                    field("LFS RoDTEP GL Ent Auto Post"; Rec."LFS RoDTEP GL Ent Auto Post")
                    {
                        ApplicationArea = all;
                        ToolTip = 'Specifies the RoDTEP GL Entry Auto Post';
                    }
                }

            }
            group("Rodtep Posting Setup(Import)")
            {
                field("Rdp Lic Jour. Template Name"; Rec."LFS Rdp Lic Jour.Temp. Name")
                {
                    ToolTip = 'Specifies the RoDTEP Lic Jour. Template Name';
                    ApplicationArea = All;
                    Caption = 'RoDTEP Lic Jour. Template Name';
                }
                field("Rdp Lic Batch Name"; Rec."LFS Rdp Lic Batch Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the RoDTEP Lic Batch Name';
                    Caption = 'RoDTEP Lic Batch Name';
                }
                field("Rdp Lic Account No."; Rec."LFS Rdp Lic Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the RoDTEP Lic Debit A/c No.';
                    caption = 'RoDTEP Lic Debit A/c No.';
                }
                field("Rdp Lic Bal Acc. Num"; Rec."LFS Rdp Lic Bal Acc. Num")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the RoDTEP Lic Credit A/c No.';
                    caption = 'RoDTEP Lic Credit A/c No.';
                }
                field("LFS Lic GL Ent Auto Post"; Rec."LFS Lic GL Ent Auto Post")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Lic GL Entry Auto Post';
                }
                field("Rdp Cons Jour. Template Name"; Rec."LFS Rdp cons. Jour. Temp. Name")
                {
                    Caption = 'RoDTEP Lic. Cons Jour. Template Name';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the RoDTEP Lic. Cons Jour. Template Name';
                }
                field("Rdp Cons Batch Name"; Rec."LFS Rdp Cons Batch Name")
                {
                    Caption = 'RoDTEP Lic. Cons Batch Name';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the RoDTEP Lic. Cons Batch Name';
                }
                field("Rdp Cons Account No."; Rec."LFS Rdp Cons Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the RoDTEP Lic. Cons Debit A/c No.';
                    caption = 'RoDTEP Lic. Cons Debit A/c No.';
                }
                field("Rdp Cons Bal Acc. Num"; Rec."LFS Rdp Cons Bal Acc. Num")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the RoDTEP Lic. Cons Credit A/c No.';
                    caption = 'RoDTEP Lic. Cons Credit A/c No.';
                }
                field("LFS Cons GL Ent Auto Post"; Rec."LFS Cons GL Ent Auto Post")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Cons GL Ent Auto Post';
                }

            }
            group("Rodtep Posting Setup(Domestic)")
            {
                // ShowCaption = false;
                field("Rdp EXP Jour. Temp. Name"; Rec."LFS RdpDomesticJourTempName")
                {
                    // Caption = 'RoDTEP Cons Jour. Template Name';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Rdp EXP Jour. Temp. Name';
                }
                field("LFS Rdp EXP Cons Batch Name"; Rec."LFS RdpDomesticConsBatchName")
                {
                    // Caption = 'RoDTEP Cons Batch Name';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Rdp EXP Cons Batch Name';
                }
                field("LFS Rdp EXP Cons Bal Acc. Num"; Rec."LFS RdpDomesticConsBalAccNum")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Rdp EXP Cons Bal Acc. Num';
                    // Caption = 'RoDTEP Cons Debit A/c No.';
                }
                field("LFS Rdp EXP Cons Account No."; Rec."LFSEXRdpDomesticConsAccountNo.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Rdp EXP Cons Account No.';
                    // Caption = 'RoDTEP Cons Credit A/c No.';
                }
                field("LFS Cons EXP GL Ent Auto Post"; Rec."LFS ConsDomesticGLEntAutoPost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Cons EXP GL Ent Auto Post';
                }
                field("Group Wise License"; Rec."LFS Group Wise License")
                {
                    ToolTip = 'Specifies the value of the Group Wise License field.', Comment = '%';
                }
            }
        }
    }
    trigger
        OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}