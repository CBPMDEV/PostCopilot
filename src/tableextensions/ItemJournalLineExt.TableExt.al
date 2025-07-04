tableextension 55001 "Item Journal Line Vendor Ext" extends "Item Journal Line"
{
    fields
    {
        field(55001; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Vendor No." <> '' then begin
                    Vendor.Get("Vendor No.");
                    "Vendor Name" := Vendor.Name;
                end else
                    "Vendor Name" := '';
            end;
        }

        field(55002; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    var
        Vendor: Record Vendor;
}
