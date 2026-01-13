namespace Addmecode.JobQueueParams;

using System.Reflection;

table 50105 "ADD_JobQueueEntryParamTemplate"
{
    Caption = 'Job Queue Entry Parameter Template';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Object Type"; option)
        {
            Caption = 'Object Type';
            Editable = false;
            OptionCaption = ',,,Report,,Codeunit';
            OptionMembers = ,,,"Report",,"Codeunit";
        }
        field(2; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            Editable = false;
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
            Caption = 'Parameter Name';
            Editable = false;
        }
        field(5; "Parameter Type"; Integer)
        {
            Caption = 'Parameter Type';
            Editable = false;
        }
        field(6; "Parameter Description"; Text[250])
        {
            Caption = 'Parameter Description';
            Editable = true;
        }
        field(20; "BigInteger Value"; BigInteger)
        {
            Caption = 'BigInteger Value';
            Editable = true;
            trigger OnValidate()
            begin
                Rec."Parameter Type" := Rec.FieldNo("BigInteger Value");
            end;
        }
        field(30; "Boolean Value"; Boolean)
        {
            Caption = 'Boolean Value';
            Editable = true;
            trigger OnValidate()
            begin
                Rec."Parameter Type" := Rec.FieldNo("Boolean Value");
            end;
        }
        field(40; "Code Value"; Code[20])
        {
            Caption = 'Code Value';
            Editable = true;
            trigger OnValidate()
            begin
                Rec."Parameter Type" := Rec.FieldNo("Code Value");
            end;
        }
        field(50; "Date Value"; Date)
        {
            Caption = 'Date Value';
            Editable = true;
            trigger OnValidate()
            begin
                Rec."Parameter Type" := Rec.FieldNo("Date Value");
            end;
        }
        field(60; "DateFormula Value"; DateFormula)
        {
            Caption = 'DateFormula Value';
            Editable = true;
            trigger OnValidate()
            begin
                Rec."Parameter Type" := Rec.FieldNo("DateFormula Value");
            end;
        }
        field(70; "DateTime Value"; DateTime)
        {
            Caption = 'DateTime Value';
            Editable = true;
            trigger OnValidate()
            begin
                Rec."Parameter Type" := Rec.FieldNo("DateTime Value");
            end;
        }
        field(80; "Decimal Value"; Decimal)
        {
            Caption = 'Decimal Value';
            Editable = true;
            trigger OnValidate()
            begin
                Rec."Parameter Type" := Rec.FieldNo("Decimal Value");
            end;
        }
        field(90; "Duration Value"; Duration)
        {
            Caption = 'Duration Value';
            Editable = true;
            trigger OnValidate()
            begin
                Rec."Parameter Type" := Rec.FieldNo("Duration Value");
            end;
        }
        field(100; "Guid Value"; Guid)
        {
            Caption = 'Guid Value';
            Editable = true;
            trigger OnValidate()
            begin
                Rec."Parameter Type" := Rec.FieldNo("Guid Value");
            end;
        }
        field(110; "Integer Value"; Integer)
        {
            Caption = 'Integer Value';
            Editable = true;
            trigger OnValidate()
            begin
                Rec."Parameter Type" := Rec.FieldNo("Integer Value");
            end;
        }
        field(120; "Text Value"; Text[250])
        {
            Caption = 'Text Value';
            Editable = true;
            trigger OnValidate()
            begin
                Rec."Parameter Type" := Rec.FieldNo("Text Value");
            end;
        }
        field(130; "Time Value"; Time)
        {
            Caption = 'Time Value';
            Editable = true;
            trigger OnValidate()
            begin
                Rec."Parameter Type" := Rec.FieldNo("Time Value");
            end;
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

    /// <summary>
    /// Creates the template if it does not exist and initializes related entries.
    /// </summary>
    /// <param name="SetDefaultValueForExistingJobQueueEntries">Specifies whether to set default values for existing entries.</param>
    procedure CreateIfNotExists(SetDefaultValueForExistingJobQueueEntries: Boolean)
    var
        JobQueueEntryMgt: Codeunit ADD_JobQueueEntryParameterMgt;
    begin
        JobQueueEntryMgt.CreateJqeParamTemplIfNotExists(Rec, SetDefaultValueForExistingJobQueueEntries);
    end;

    /// <summary>
    /// Returns the default parameter value as text.
    /// </summary>
    /// <returns>The formatted default parameter value.</returns>
    procedure GetDefaultParameterValue(): Text
    var
        JobQueueEntryMgt: Codeunit ADD_JobQueueEntryParameterMgt;
    begin
        exit(JobQueueEntryMgt.GetDefaultParameterValueAsText(Rec));
    end;

    /// <summary>
    /// Returns the caption of the parameter type.
    /// </summary>
    /// <returns>The parameter type caption.</returns>
    procedure GetTemplParameterTypeCaption(): Text
    var
        JobQueueEntryMgt: Codeunit ADD_JobQueueEntryParameterMgt;
    begin
        exit(JobQueueEntryMgt.GetTemplParameterTypeCaption(Rec));
    end;
}
