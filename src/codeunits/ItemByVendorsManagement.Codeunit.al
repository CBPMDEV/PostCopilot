codeunit 55001 "Item By Vendors Management"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInsertItemLedgEntry', '', false, false)]
    local procedure OnAfterInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line")
    var
        ItemByVendorsEntry: Record "Item By Vendors Entry";
    begin
        if ItemJournalLine."Vendor No." = '' then
            exit;

        ItemByVendorsEntry.Init();
        ItemByVendorsEntry."Item No." := ItemLedgerEntry."Item No.";
        ItemByVendorsEntry.Validate("Item No.");
        ItemByVendorsEntry."Location Code" := ItemLedgerEntry."Location Code";
        ItemByVendorsEntry."Vendor No." := ItemJournalLine."Vendor No.";
        ItemByVendorsEntry.Validate("Vendor No.");
        ItemByVendorsEntry.Quantity := ItemLedgerEntry.Quantity;
        ItemByVendorsEntry."Unit of Measure Code" := ItemLedgerEntry."Unit of Measure Code";
        ItemByVendorsEntry."Posting Date" := ItemLedgerEntry."Posting Date";
        ItemByVendorsEntry."Document No." := ItemLedgerEntry."Document No.";
        ItemByVendorsEntry."External Document No." := ItemLedgerEntry."External Document No.";
        ItemByVendorsEntry."Entry Type" := ItemLedgerEntry."Entry Type";
        ItemByVendorsEntry."Source Type" := ItemLedgerEntry."Source Type";
        ItemByVendorsEntry."Source No." := ItemLedgerEntry."Source No.";
        ItemByVendorsEntry.Insert(true);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Journal", 'OnAfterGetCurrRecordEvent', '', false, false)]
    local procedure OnAfterGetCurrRecordItemJournal(var Rec: Record "Item Journal Line")
    begin
        // This ensures the vendor fields are available in the page
    end;

    procedure ShowItemByVendorsEntries(ItemNo: Code[20]; VendorNo: Code[20]; LocationCode: Code[10])
    var
        ItemByVendorsEntry: Record "Item By Vendors Entry";
    begin
        ItemByVendorsEntry.SetRange("Item No.", ItemNo);
        if VendorNo <> '' then
            ItemByVendorsEntry.SetRange("Vendor No.", VendorNo);
        if LocationCode <> '' then
            ItemByVendorsEntry.SetRange("Location Code", LocationCode);

        Page.Run(Page::"Item By Vendors Entries", ItemByVendorsEntry);
    end;

    procedure GetItemByVendorsEntries(ItemNo: Code[20]; VendorNo: Code[20]; LocationCode: Code[10]; var TempItemByVendorsEntry: Record "Item By Vendors Entry" temporary)
    var
        ItemByVendorsEntry: Record "Item By Vendors Entry";
    begin
        TempItemByVendorsEntry.DeleteAll();

        ItemByVendorsEntry.SetRange("Item No.", ItemNo);
        if VendorNo <> '' then
            ItemByVendorsEntry.SetRange("Vendor No.", VendorNo);
        if LocationCode <> '' then
            ItemByVendorsEntry.SetRange("Location Code", LocationCode);

        if ItemByVendorsEntry.FindSet() then
            repeat
                TempItemByVendorsEntry := ItemByVendorsEntry;
                TempItemByVendorsEntry.Insert();
            until ItemByVendorsEntry.Next() = 0;
    end;
}
