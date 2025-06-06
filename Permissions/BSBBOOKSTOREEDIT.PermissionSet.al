permissionset 50100 "BSB BOOKSTORE, EDIT"
{
    Caption = 'BOOKSTORE, EDIT';
    // Assignable = true;
    Permissions =
        tabledata "BSB Book" = RIMD,
        table "BSB Book" = X,
        tabledata "BSB AL Issue" = RIMD,
        tabledata "BSB Internal Log" = RIMD,
        table "BSB Internal Log" = X;
}