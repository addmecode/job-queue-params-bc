namespace Addmecode.JobQueueParams;

using System.Threading;

table 50120 "ADD_JobQueueEntryParameter"
{
    Caption = 'Job Queue Entry Parameter';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Job Queue Entry ID"; Guid)
        {
            Caption = 'Job Queue Entry ID';
            Editable = false;
            TableRelation = "Job Queue Entry".ID;
        }
        field(2; "Object Type"; option)
        {
            CalcFormula = lookup("Job Queue Entry"."Object Type to Run" where(ID = field("Job Queue Entry ID")));
            Caption = 'Object Type';
            Editable = false;
            FieldClass = FlowField;
            //todo: Add enum for Object Type
            OptionCaption = ',,,Report,,Codeunit';
            OptionMembers = ,,,"Report",,"Codeunit";
        }
        field(3; "Object ID"; Integer)
        {
            CalcFormula = lookup("Job Queue Entry"."Object ID to Run" where(ID = field("Job Queue Entry ID")));
            Caption = 'Object ID';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Parameter Name"; Text[100])
        {
            Caption = 'Parameter Name';
            Editable = false;
            NotBlank = true;
        }
        field(5; "Parameter Type"; Integer)
        {
            CalcFormula = lookup(ADD_JobQueueEntryParamTemplate."Parameter Type"
                          where("Parameter Name" = field("Parameter Name"),
                                "Object Type" = field("Object Type"),
                                "Object ID" = field("Object ID")));
            Caption = 'Parameter Type';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Parameter Description"; Text[250])
        {
            CalcFormula = lookup(ADD_JobQueueEntryParamTemplate."Parameter Description"
                          where("Parameter Name" = field("Parameter Name"),
                                "Object Type" = field("Object Type"),
                                "Object ID" = field("Object ID")));
            Caption = 'Parameter Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "BigInteger Value"; BigInteger)
        {
            Caption = 'BigInteger Value';
            Editable = true;
        }
        field(30; "Boolean Value"; Boolean)
        {
            Caption = 'Boolean Value';
            Editable = true;
        }
        field(40; "Code Value"; Code[20])
        {
            Caption = 'Code Value';
            Editable = true;
        }
        field(50; "Date Value"; Date)
        {
            Caption = 'Date Value';
            Editable = true;
        }
        field(60; "DateFormula Value"; DateFormula)
        {
            Caption = 'Date Formula Value';
            Editable = true;
        }
        field(70; "DateTime Value"; DateTime)
        {
            Caption = 'DateTime Value';
            Editable = true;
        }
        field(80; "Decimal Value"; Decimal)
        {
            Caption = 'Decimal Value';
            Editable = true;
        }
        field(90; "Duration Value"; Duration)
        {
            Caption = 'Duration Value';
            Editable = true;
        }
        field(100; "Guid Value"; Guid)
        {
            Caption = 'Guid Value';
            Editable = true;
        }
        field(110; "Integer Value"; Integer)
        {
            Caption = 'Integer Value';
            Editable = true;
        }
        field(120; "Text Value"; Text[250])
        {
            Caption = 'Text Value';
            Editable = true;
        }
        field(130; "Time Value"; Time)
        {
            Caption = 'Time Value';
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

    procedure GetParameterValue(): Variant
    var
        JobQueueEntryMgt: Codeunit ADD_JobQueueEntryParameterMgt;
    begin
        exit(JobQueueEntryMgt.GetParameterValue(Rec));
    end;

    procedure GetParameterValueAsText(): Text
    var
        JobQueueEntryMgt: Codeunit ADD_JobQueueEntryParameterMgt;
    begin
        exit(JobQueueEntryMgt.GetParameterValueAsText(Rec));
    end;

    procedure GetParameterTypeCaption(): Text
    var
        JobQueueEntryMgt: Codeunit ADD_JobQueueEntryParameterMgt;
    begin
        exit(JobQueueEntryMgt.GetParameterTypeCaption(Rec));
    end;

    procedure IsParamEditable(): Boolean
    var
        JobQueueEntryMgt: Codeunit ADD_JobQueueEntryParameterMgt;
    begin
        exit(JobQueueEntryMgt.IsParamEditable(Rec));
    end;
}