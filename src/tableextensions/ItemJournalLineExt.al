tableextension 55100 "Item Journal Line Ext" extends "Item Journal Line"
{
    fields
    {
        field(55100; "Custom Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                if "Custom Vendor No." <> '' then begin
                    Vendor.Get("Custom Vendor No.");
                    "Custom Vendor Name" := Vendor.Name;
                end else
                    "Custom Vendor Name" := '';
            end;
        }
        field(55101; "Custom Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            DataClassification = CustomerContent;
        }
    }
}
