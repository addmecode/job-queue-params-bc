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
        }
        field(2; "Object ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Object ID';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = field("Object Type"));
        }
        field(3; "Object Caption"; Text[250])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = field("Object Type"),
                                                                           "Object ID" = field("Object ID")));
            Caption = 'Object Caption';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Parameter Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Parameter Name';
        }
        field(5; "Parameter Description"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Parameter Description';
        }

        field(6; "Default Parameter Value"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Default Parameter Value';
        }
    }

    keys
    {
        key(PK; "Object Type", "Object ID", "Parameter Name")
        {
            Clustered = true;
        }
    }

    procedure CreateIfNotExists()
    var
        JobQueueEntryMgt: Codeunit ADD_JobQueueEntryParameterMgt;
    begin
        JobQueueEntryMgt.CreateJqeParamTemplIfNotExists(Rec);
    end;
}