pageextension 55001 "Item Journal Line Ext" extends "Item Journal"
{
    layout
    {
        addafter("Location Code")
        {
            field("Vendor No."; Rec."Vendor No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the vendor number for this item journal line.';
            }

            field("Vendor Name"; Rec."Vendor Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the vendor name for this item journal line.';
            }
        }
    }
}
