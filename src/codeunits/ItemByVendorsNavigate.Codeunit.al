codeunit 55003 "Item By Vendors Navigate"
{
    // Note: Navigate functionality will be added when the exact event signatures are confirmed
    // For now, users can access Item By Vendors Entries directly from the page

    procedure ShowEntriesForDocument(DocumentNo: Code[20]; PostingDate: Date)
    var
        ItemByVendorsEntry: Record "Item By Vendors Entry";
    begin
        ItemByVendorsEntry.SetRange("Document No.", DocumentNo);
        ItemByVendorsEntry.SetRange("Posting Date", PostingDate);
        Page.Run(Page::"Item By Vendors Entries", ItemByVendorsEntry);
    end;
}
