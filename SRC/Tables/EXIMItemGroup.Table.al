// namespace LFSEximModule.LFSPLEXIMModule;
// table 72013 "LFS EXIM Item Group"
// {
//     Caption = 'EXIM Item Group';
//     DataClassification = CustomerContent;

//     fields
//     {
//         field(1; "LFS Code"; Code[50])
//         {
//             Caption = 'Code';
//             DataClassification = CustomerContent;
//         }
//         field(2; "LFS Description"; Text[50])
//         {
//             Caption = 'Description';
//             DataClassification = CustomerContent;
//         }
//         field(3; "LFS EXIM Type"; Enum "LFS EXIM Type")
//         {
//             Caption = 'EXIM Type';
//             DataClassification = CustomerContent;
//         }
//     }
//     keys
//     {
//         key(Key1; "LFS Code")
//         {
//             Clustered = true;
//         }
//         key(No; "LFS EXIM Type")
//         { }
//     }
// }