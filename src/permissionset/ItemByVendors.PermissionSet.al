permissionset 55001 "Item By Vendors"
{
    Assignable = true;
    Caption = 'Item By Vendors';

    Permissions = tabledata "Item By Vendors Entry" = RIMD,
                  table "Item By Vendors Entry" = X,
                  page "Item By Vendors Entries" = X,
                  codeunit "Item By Vendors Management" = X,
                  codeunit "Item By Vendors Preview" = X,
                  codeunit "Item By Vendors Navigate" = X;
}
