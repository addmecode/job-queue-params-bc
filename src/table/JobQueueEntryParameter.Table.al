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
        }
        field(2; "Object Type"; option)
        {
            //todo: Add enum for Object Type
            Editable = false;
            OptionCaption = ',,,Report,,Codeunit';
            OptionMembers = ,,,"Report",,"Codeunit";
            FieldClass = FlowField;
            CalcFormula = lookup("Job Queue Entry"."Object Type to Run" where(ID = field("Job Queue Entry ID")));
        }

        field(3; "Object ID"; Integer)
        {
            Editable = false;
            Caption = 'Object ID';
            FieldClass = FlowField;
            CalcFormula = lookup("Job Queue Entry"."Object ID to Run" where(ID = field("Job Queue Entry ID")));
        }
        field(4; "Parameter Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Parameter Name';
            NotBlank = true;
            trigger OnValidate()
            var
                JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
                JobQueueEntry: Record "Job Queue Entry";
            begin
                JobQueueEntry.Get("Job Queue Entry ID");
                JobQueueEntryParamTemplate.Get(JobQueueEntry."Object Type to Run", JobQueueEntry."Object ID to Run", "Parameter Name");
                Rec."Parameter Value" := JobQueueEntryParamTemplate."Default Parameter Value";
            end;

            trigger OnLookup()
            var
                JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
                JobQueueEntry: Record "Job Queue Entry";
            begin
                JobQueueEntry.Get("Job Queue Entry ID");
                JobQueueEntryParamTemplate.SetRange("Object Type", JobQueueEntry."Object Type to Run");
                JobQueueEntryParamTemplate.SetRange("Object ID", JobQueueEntry."Object ID to Run");
                if Page.RunModal(Page::ADD_JobQueueEntrParamTemplates, JobQueueEntryParamTemplate) = Action::LookupOK then begin
                    Rec."Parameter Name" := JobQueueEntryParamTemplate."Parameter Name";
                    Rec."Parameter Value" := JobQueueEntryParamTemplate."Default Parameter Value";
                end;
            end;
        }
        field(5; "Parameter Description"; Text[250])
        {
            Editable = false;
            Caption = 'Parameter Desription';
            FieldClass = FlowField;
            CalcFormula = lookup(ADD_JobQueueEntryParamTemplate."Parameter Description"
                          where("Parameter Name" = field("Parameter Name"),
                                "Object Type" = field("Object Type"),
                                "Object ID" = field("Object ID")));
        }
        field(6; "Parameter Value"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Parameter Value';
        }
    }

    keys
    {
        key(PK; "Job Queue Entry ID", "Parameter Name")
        {
            Clustered = true;
        }
    }
}