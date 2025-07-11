namespace LFSEximModule.LFSPLEXIMModule;

using Microsoft.Finance.GST.Base;

tableextension 72003 "LFS GST Registration Nos. Ext." extends "GST Registration Nos."
{
    fields
    {
        field(72000; "LFS LUT No."; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'LUT No.';
        }
        field(72001; "LFS LUT Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'LUT Date';
        }
        field(72002; "Client Id"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Client Id';
        }
        field(72003; "Client Secret"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Client Secret';
        }
        field(72004; "IP Address"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'IP Address';
        }
        field(72005; "User Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'User Name';
        }
        field(72006; "Error Log Path"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Error Log Path';
        }
        field(72007; Password; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Password';
        }
        field(72008; "E-Invoice URL"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'E-Invoice URL';
        }
        field(72009; "Authentication URL"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Authentication URL';
        }
        field(72010; "Cancel E-Invoice URL"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Cancel E-Invoice URL';
        }
        field(72011; "E-Way Bill URL"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'E-Way Bill URL';
        }
        field(72012; "E-Way Private Key"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'E-Way Private Key';
        }
        field(72013; "E-Way Private Value"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'E-Way Private Value';
        }
        field(72014; "Eway PDF Path"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Eway PDF Path';
        }
        field(72015; "API User Name"; text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'API User Name';
        }
        field(72016; "E-Way API Key"; Text[100])
        {
            Caption = 'E-Way API Key';
            DataClassification = CustomerContent;
        }
        field(72017; "E-Way API Value"; Text[100])
        {
            Caption = 'E-Way API Value';
            DataClassification = CustomerContent;
        }
        field(72018; "E-Way API URL"; Text[100])
        {
            Caption = 'E-Way API URL';
            DataClassification = CustomerContent;
        }
        field(72019; "E-Way API User Name"; Text[100])
        {
            Caption = 'E-Way API User Name';
            DataClassification = CustomerContent;
        }
        field(72020; "E-Way API Password"; Text[100])
        {
            Caption = 'E-Way API Password';
            DataClassification = CustomerContent;
        }
        field(72021; "E-Way API IP Address"; Text[100])
        {
            Caption = 'E-Way API IP Address';
            DataClassification = CustomerContent;
        }
        field(72022; "E-Way UnderTesting"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'E-Way UnderTesting';
        }
    }
}
