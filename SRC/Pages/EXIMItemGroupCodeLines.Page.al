// namespace LFSEximModule.LFSPLEXIMModule;

// page 72017 "LFS EXIM Item Group Code Lines"
// {
//     ApplicationArea = All;
//     Caption = 'EXIM Item Group Code Lines';
//     PageType = ListPart;
//     SourceTable = "LFS EXIM Item Group Code Line";
//     AutoSplitKey = true;
//     MultipleNewLines = true;

//     layout
//     {
//         area(content)
//         {
//             repeater(General)
//             {
//                 field("Group Code No."; Rec."LFS Group Code No.")
//                 {
//                     Visible = false;
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Group Code No. field.';
//                 }
//                 field("Line No."; Rec."LFS Line No.")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Line No. field.';
//                 }
//                 field("Item No."; Rec."LFS Item No.")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Item No. field.';
//                 }
//                 field(Description; Rec."LFS Description")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Descrition field.';
//                 }
//                 field(UOM; Rec."LFS UOM")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the UOM field.';
//                 }
//             }
//         }
//     }
// }