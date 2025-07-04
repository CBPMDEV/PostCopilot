pageextension 55003 "Item Card Ext" extends "Item Card"
{
    actions
    {
        addafter("Ledger E&ntries")
        {
            action(ItemByVendorsEntries)
            {
                Caption = 'Item By Vendors Entries';
                Image = VendorLedger;
                ApplicationArea = All;
                ToolTip = 'View item entries grouped by vendors.';

                trigger OnAction()
                var
                    ItemByVendorsManagement: Codeunit "Item By Vendors Management";
                begin
                    ItemByVendorsManagement.ShowItemByVendorsEntries(Rec."No.", '', '');
                end;
            }
        }
    }
}
