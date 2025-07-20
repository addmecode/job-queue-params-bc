namespace Addmecode.JobQueueParams;

using System.Threading;

table 50100 "ADD_JobQueueEntryParameter"
{
    Caption = 'Job Queue Entry Parameter';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Job Queue Entry ID"; Guid)
        {
            DataClassification = CustomerContent;
            Caption = 'Job Queue Entry ID';
            TableRelation = "Job Queue Entry".ID;
            Editable = false;
        }
        field(2; "Object Type"; option)
        {
            //todo: Add enum for Object Type
            OptionCaption = ',,,Report,,Codeunit';
            OptionMembers = ,,,"Report",,"Codeunit";
            FieldClass = FlowField;
            CalcFormula = lookup("Job Queue Entry"."Object Type to Run" where(ID = field("Job Queue Entry ID")));
            Editable = false;
        }

        field(3; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            FieldClass = FlowField;
            CalcFormula = lookup("Job Queue Entry"."Object ID to Run" where(ID = field("Job Queue Entry ID")));
            Editable = false;
        }
        field(4; "Parameter Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Parameter Name';
            NotBlank = true;
            Editable = false;
        }
        field(5; "Parameter Type"; Enum "ADD_JobQueueEntryParameterType")
        {
            Caption = 'Parameter Type';
            FieldClass = FlowField;
            CalcFormula = lookup(ADD_JobQueueEntryParamTemplate."Parameter Type"
                          where("Parameter Name" = field("Parameter Name"),
                                "Object Type" = field("Object Type"),
                                "Object ID" = field("Object ID")));
            Editable = false;
        }
        field(6; "Parameter Description"; Text[250])
        {
            Caption = 'Parameter Description';
            FieldClass = FlowField;
            CalcFormula = lookup(ADD_JobQueueEntryParamTemplate."Parameter Description"
                          where("Parameter Name" = field("Parameter Name"),
                                "Object Type" = field("Object Type"),
                                "Object ID" = field("Object ID")));
            Editable = false;
        }
        field(7; "Parameter Value"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Parameter Value';
            Editable = true;
        }
    }

    keys
    {
        key(PK; "Job Queue Entry ID", "Parameter Name")
        {
            Clustered = true;
        }
    }

    trigger OnModify()
    var
        JobQueueEntryMgt: Codeunit ADD_JobQueueEntryParameterMgt;
    begin
        JobQueueEntryMgt.CheckIfJqeIsOnHold(Rec);
    end;
}