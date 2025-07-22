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
        field(5; "Parameter Type"; Integer)
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
        field(20; "BigInteger Value"; BigInteger)
        {
            DataClassification = CustomerContent;
            Caption = 'BigInteger Value';
            Editable = true;
        }
        field(30; "Boolean Value"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Boolean Value';
            Editable = true;
        }
        field(40; "Code Value"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code Value';
            Editable = true;
        }
        field(50; "Date Value"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date Value';
            Editable = true;
        }
        field(60; "DateFormula Value"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Date Formula Value';
            Editable = true;
        }
        field(70; "DateTime Value"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'DateTime Value';
            Editable = true;
        }
        field(80; "Decimal Value"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Decimal Value';
            Editable = true;
        }
        field(90; "Duration Value"; Duration)
        {
            DataClassification = CustomerContent;
            Caption = 'Duration Value';
            Editable = true;
        }
        field(100; "Guid Value"; Guid)
        {
            DataClassification = CustomerContent;
            Caption = 'Guid Value';
            Editable = true;
        }
        field(110; "Integer Value"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Integer Value';
            Editable = true;
        }
        field(120; "Text Value"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Text Value';
            Editable = true;
        }
        field(130; "Time Value"; Time)
        {
            DataClassification = CustomerContent;
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