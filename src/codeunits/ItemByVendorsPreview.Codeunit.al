codeunit 55002 "Item By Vendors Preview"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Posting Preview Event Handler", 'OnGetEntries', '', false, false)]
    local procedure OnGetEntries(TableNo: Integer; var RecRef: RecordRef)
    var
        ItemByVendorsEntry: Record "Item By Vendors Entry";
    begin
        case TableNo of
            Database::"Item By Vendors Entry":
                RecRef.GetTable(ItemByVendorsEntry);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Posting Preview Event Handler", 'OnAfterFillDocumentEntry', '', false, false)]
    local procedure OnAfterFillDocumentEntry(var DocumentEntry: Record "Document Entry")
    begin
        InsertDocumentEntry(DocumentEntry, Database::"Item By Vendors Entry", 'Item By Vendors Entries');
    end;

    local procedure InsertDocumentEntry(var DocumentEntry: Record "Document Entry"; TableID: Integer; TableName: Text[100])
    var
        RecRef: RecordRef;
    begin
        RecRef.Open(TableID);
        if RecRef.IsEmpty then
            exit;

        DocumentEntry.Init();
        DocumentEntry."Entry No." := DocumentEntry."Entry No." + 1;
        DocumentEntry."Table ID" := TableID;
        DocumentEntry."Table Name" := TableName;
        DocumentEntry."No. of Records" := RecRef.Count;
        DocumentEntry.Insert();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Posting Preview Event Handler", 'OnAfterShowEntries', '', false, false)]
    local procedure OnAfterShowEntries(TableNo: Integer)
    var
        ItemByVendorsEntry: Record "Item By Vendors Entry";
    begin
        case TableNo of
            Database::"Item By Vendors Entry":
                Page.Run(Page::"Item By Vendors Entries", ItemByVendorsEntry);
        end;
    end;
}
