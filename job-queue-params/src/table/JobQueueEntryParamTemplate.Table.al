namespace Addmecode.JobQueueParams;

using System.Reflection;

table 50101 "ADD_JobQueueEntryParamTemplate"
{
    DataClassification = ToBeClassified;
    Caption = 'Job Queue Entry Parameter Template';

    fields
    {
        field(1; "Object Type"; option)
        {
            //todo
            DataClassification = CustomerContent;
            OptionCaption = ',,,Report,,Codeunit';
            OptionMembers = ,,,"Report",,"Codeunit";
            Editable = false;
        }
        field(2; "Object ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Object ID';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = field("Object Type"));
            Editable = false;
        }
        field(3; "Object Caption"; Text[250])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = field("Object Type"),
                                                                           "Object ID" = field("Object ID")));
            Caption = 'Object Caption';
            FieldClass = FlowField;
            Editable = false;
        }
        field(4; "Parameter Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Parameter Name';
            Editable = false;
        }
        field(5; "Parameter Type"; Enum "ADD_JobQueueEntryParameterType")
        {
            DataClassification = CustomerContent;
            Caption = 'Parameter Type';
            Editable = false;
        }
        field(6; "Parameter Description"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Parameter Description';
            Editable = true;
        }
        field(7; "BigInteger Value"; BigInteger)
        {
            DataClassification = CustomerContent;
            Caption = 'BigInteger Value';
            Editable = true;
        }
        field(8; "Blob Value"; Blob)
        {
            DataClassification = CustomerContent;
            Caption = 'Blob Value';
        }
        field(9; "Boolean Value"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Boolean Value';
            Editable = true;
        }
        field(10; "Code Value"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code Value';
            Editable = true;
        }
        field(11; "Date Value"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date Value';
            Editable = true;
        }
        field(12; "DateFormula Value"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'DateFormula Value';
            Editable = true;
        }
        field(13; "DateTime Value"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'DateTime Value';
            Editable = true;
        }
        field(14; "Decimal Value"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Decimal Value';
            Editable = true;
        }
        field(15; "Duration Value"; Duration)
        {
            DataClassification = CustomerContent;
            Caption = 'Duration Value';
            Editable = true;
        }
        field(16; "Guid Value"; Guid)
        {
            DataClassification = CustomerContent;
            Caption = 'Guid Value';
            Editable = true;
        }
        field(17; "Integer Value"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Integer Value';
            Editable = true;
        }
        field(18; "Media Value"; Media)
        {
            DataClassification = CustomerContent;
            Caption = 'Media Value';
            Editable = true;
        }
        field(19; "MediaSet Value"; MediaSet)
        {
            DataClassification = CustomerContent;
            Caption = 'MediaSet Value';
            Editable = true;
        }
        field(20; "Text Value"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Text Value';
            Editable = true;
        }
        field(21; "Time Value"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Time Value';
            Editable = true;
        }
    }

    keys
    {
        key(PK; "Object Type", "Object ID", "Parameter Name")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        JobQueueEntryMgt: Codeunit ADD_JobQueueEntryParameterMgt;
    begin
        //todo
        JobQueueEntryMgt.ValidateParameterType(Rec);
    end;

    trigger OnModify()
    var
        JobQueueEntryMgt: Codeunit ADD_JobQueueEntryParameterMgt;
    begin
        //todo
        JobQueueEntryMgt.ValidateParameterType(Rec);
    end;

    procedure CreateIfNotExists(SetDefValueForExistingJqe: Boolean)
    var
        JobQueueEntryMgt: Codeunit ADD_JobQueueEntryParameterMgt;
    begin
        JobQueueEntryMgt.CreateJqeParamTemplIfNotExists(Rec, SetDefValueForExistingJqe);
    end;

    procedure GetDefaultParameterValue(): Text
    var
        JobQueueEntryMgt: Codeunit ADD_JobQueueEntryParameterMgt;
    begin
        exit(JobQueueEntryMgt.GetDefaultParameterValue(Rec));
    end;
}