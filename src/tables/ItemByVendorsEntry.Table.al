table 55001 "Item By Vendors Entry"
{
    Caption = 'Item By Vendors Entry';
    DataClassification = CustomerContent;
    LookupPageId = "Item By Vendors Entries";
    DrillDownPageId = "Item By Vendors Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }

        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;

            trigger OnValidate()
            begin
                if "Item No." <> '' then begin
                    Item.Get("Item No.");
                    Description := Item.Description;
                    "Base Unit of Measure" := Item."Base Unit of Measure";
                end else begin
                    Description := '';
                    "Base Unit of Measure" := '';
                end;
            end;
        }

        field(3; Description; Text[100])
        {
            Caption = 'Description';
            Editable = false;
        }

        field(4; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }

        field(5; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                if "Vendor No." <> '' then begin
                    Vendor.Get("Vendor No.");
                    "Vendor Name" := Vendor.Name;
                end else
                    "Vendor Name" := '';
            end;
        }

        field(6; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            Editable = false;
        }

        field(7; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }

        field(8; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Item No."));
        }

        field(9; "Base Unit of Measure"; Code[10])
        {
            Caption = 'Base Unit of Measure';
            Editable = false;
            TableRelation = "Unit of Measure";
        }

        field(10; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }

        field(11; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }

        field(12; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
        }

        field(13; "Entry Type"; Enum "Item Ledger Entry Type")
        {
            Caption = 'Entry Type';
        }

        field(14; "Source Type"; Enum "Analysis Source Type")
        {
            Caption = 'Source Type';
        }

        field(15; "Source No."; Code[20])
        {
            Caption = 'Source No.';
        }

        field(16; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = User."User Name";
        }

        field(17; "Created DateTime"; DateTime)
        {
            Caption = 'Created DateTime';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }

        key(ItemVendor; "Item No.", "Vendor No.", "Location Code", "Posting Date")
        {
        }

        key(PostingDate; "Posting Date")
        {
        }
    }

    trigger OnInsert()
    begin
        "Created DateTime" := CurrentDateTime;
        "User ID" := CopyStr(UserId, 1, MaxStrLen("User ID"));
    end;

    var
        Item: Record Item;
        Vendor: Record Vendor;
}
