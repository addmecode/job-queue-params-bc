namespace Addmecode.JobQueueParams;
using System.Threading;
using Microsoft.Projects.Project.Job;
using Microsoft.Projects.Project.Archive;

codeunit 50100 "ADD_JobQueueEntryParameterMgt"
{
    procedure CreateAllJobQueueEntryParamsFromTempl(JQE: Record "Job Queue Entry"; SetDefValue: Boolean)
    var
        JQEParamTempl: record ADD_JobQueueEntryParamTemplate;
    begin
        if JQE."Object ID to Run" = 0 then
            exit;
        JQEParamTempl.SetRange("Object ID", JQE."Object ID to Run");
        JQEParamTempl.SetRange("Object Type", JQE."Object Type to Run");
        if JQEParamTempl.FindSet() then
            repeat
                CreateJqeParamFromTempl(JQE, JQEParamTempl, SetDefValue);
            until JQEParamTempl.Next() = 0;
    end;

    local procedure CreateJqeParamFromTempl(JQE: Record "Job Queue Entry"; JQEParamTempl: record ADD_JobQueueEntryParamTemplate; SetDefValue: Boolean)
    var
        JQEParam: Record "ADD_JobQueueEntryParameter";
    begin
        JQEParam.Init();
        JQEParam."Job Queue Entry ID" := JQE.ID;
        JQEParam."Parameter Name" := JQEParamTempl."Parameter Name";
        //todo this is not the best way to do it, but it works for now
        case JqeParamTempl."Parameter Type" of
            JqeParamTempl."Parameter Type"::BigInteger:
                JQEParam."BigInteger Value" := JQEParamTempl."BigInteger Value";
            JqeParamTempl."Parameter Type"::Blob:
                begin
                    JQEParamTempl.CalcFields("Blob Value");
                    JQEParam."Blob Value" := JQEParamTempl."Blob Value";
                end;
            JqeParamTempl."Parameter Type"::Boolean:
                JQEParam."Boolean Value" := JqeParamTempl."Boolean Value";
            JqeParamTempl."Parameter Type"::Code:
                JQEParam."Code Value" := JqeParamTempl."Code Value";
            JqeParamTempl."Parameter Type"::Date:
                JQEParam."Date Value" := JqeParamTempl."Date Value";
            JqeParamTempl."Parameter Type"::DateFormula:
                JQEParam."DateFormula Value" := JqeParamTempl."DateFormula Value";
            JqeParamTempl."Parameter Type"::DateTime:
                JQEParam."DateTime Value" := JqeParamTempl."DateTime Value";
            JqeParamTempl."Parameter Type"::Decimal:
                JQEParam."Decimal Value" := JqeParamTempl."Decimal Value";
            JqeParamTempl."Parameter Type"::Duration:
                JQEParam."Duration Value" := JqeParamTempl."Duration Value";
            JqeParamTempl."Parameter Type"::Guid:
                JQEParam."Guid Value" := JqeParamTempl."Guid Value";
            JqeParamTempl."Parameter Type"::Integer:
                JQEParam."Integer Value" := JqeParamTempl."Integer Value";
            JqeParamTempl."Parameter Type"::Media:
                JQEParam."Media Value" := JqeParamTempl."Media Value"; //todo calcfield?
            JqeParamTempl."Parameter Type"::MediaSet:
                JQEParam."MediaSet Value" := JqeParamTempl."MediaSet Value"; //todo calcfield?
            JqeParamTempl."Parameter Type"::Text:
                JQEParam."Text Value" := JqeParamTempl."Text Value";
            JqeParamTempl."Parameter Type"::Time:
                JQEParam."Time Value" := JqeParamTempl."Time Value";
        end;
        JQEParam.Insert();
    end;

    procedure DeleteAllJobQueueEntryParams(JQE: Record "Job Queue Entry")
    var
        JQEParam: Record "ADD_JobQueueEntryParameter";
    begin
        if JQE."Object ID to Run" = 0 then
            exit;
        JQEParam.SetRange("Job Queue Entry ID", JQE.ID);
        JQEParam.DeleteAll(true);
    end;

    procedure OverwriteAllJobQueueEntryParamsFromTempl(JQE: Record "Job Queue Entry"; xJQE: Record "Job Queue Entry"; SetDefValue: Boolean)
    var
        JQEParam: Record "ADD_JobQueueEntryParameter";
    begin
        if JQE."Object ID to Run" = 0 then
            exit;
        if (JQE."Object ID to Run" = xJQE."Object ID to Run") and (JQE."Object Type to Run" = xJQE."Object Type to Run") then
            exit;

        DeleteAllJobQueueEntryParams(JQE);
        CreateAllJobQueueEntryParamsFromTempl(JQE, SetDefValue);
    end;

    internal procedure CreateJqeParamTemplIfNotExists(JqeTemplToCreate: Record ADD_JobQueueEntryParamTemplate; SetDefValueForExistingJqe: Boolean)
    var
        JobQueueEntryParamTempl: Record ADD_JobQueueEntryParamTemplate;
    begin
        if (JobQueueEntryParamTempl.Get(JqeTemplToCreate."Object Type", JqeTemplToCreate."Object ID", JqeTemplToCreate."Parameter Name")) then
            exit;
        JqeTemplToCreate.Insert(true);
        CreateJqeParamFromNewTempForExistingJqe(JqeTemplToCreate, SetDefValueForExistingJqe);
    end;

    internal procedure GetJobQueueEntryParamValue(Jqe: Record "Job Queue Entry"; ParamName: Text[100]): Text[250]
    var
        JqueParam: Record "ADD_JobQueueEntryParameter";
    begin
        JqueParam.Get(Jqe.ID, ParamName);
        //todo: this is not the best way to do it, but it works for now
        case JqueParam."Parameter Type" of
            JqueParam."Parameter Type"::None:
                exit('');
            JqueParam."Parameter Type"::BigInteger:
                exit(Format(JqueParam."BigInteger Value"));
            JqueParam."Parameter Type"::Blob:
                exit(''); //todo
            JqueParam."Parameter Type"::Boolean:
                exit(Format(JqueParam."Boolean Value"));
            JqueParam."Parameter Type"::Code:
                exit(JqueParam."Code Value");
            JqueParam."Parameter Type"::Date:
                exit(Format(JqueParam."Date Value"));
            JqueParam."Parameter Type"::DateFormula:
                exit(Format(JqueParam."DateFormula Value"));
            JqueParam."Parameter Type"::DateTime:
                exit(Format(JqueParam."DateTime Value"));
            JqueParam."Parameter Type"::Decimal:
                exit(Format(JqueParam."Decimal Value"));
            JqueParam."Parameter Type"::Duration:
                exit(Format(JqueParam."Duration Value"));
            JqueParam."Parameter Type"::Guid:
                exit(Format(JqueParam."Guid Value"));
            JqueParam."Parameter Type"::Integer:
                exit(Format(JqueParam."Integer Value"));
            JqueParam."Parameter Type"::Media:
                exit(''); //todo
            JqueParam."Parameter Type"::MediaSet:
                exit(''); //todo
            JqueParam."Parameter Type"::Text:
                exit(JqueParam."Text Value");
            JqueParam."Parameter Type"::Time:
                exit(Format(JqueParam."Time Value"));
            else
                exit('');
        end;
    end;

    procedure GetParameterValue(JqeParam: Record ADD_JobQueueEntryParameter): Text
    begin
        //todo: this is not the best way to do it, but it works for now
        case JqeParam."Parameter Type" of
            JqeParam."Parameter Type"::None:
                exit('');
            JqeParam."Parameter Type"::BigInteger:
                exit(Format(JqeParam."BigInteger Value"));
            JqeParam."Parameter Type"::Blob:
                exit(''); //todo
            JqeParam."Parameter Type"::Boolean:
                exit(Format(JqeParam."Boolean Value"));
            JqeParam."Parameter Type"::Code:
                exit(JqeParam."Code Value");
            JqeParam."Parameter Type"::Date:
                exit(Format(JqeParam."Date Value"));
            JqeParam."Parameter Type"::DateFormula:
                exit(Format(JqeParam."DateFormula Value"));
            JqeParam."Parameter Type"::DateTime:
                exit(Format(JqeParam."DateTime Value"));
            JqeParam."Parameter Type"::Decimal:
                exit(Format(JqeParam."Decimal Value"));
            JqeParam."Parameter Type"::Duration:
                exit(Format(JqeParam."Duration Value"));
            JqeParam."Parameter Type"::Guid:
                exit(Format(JqeParam."Guid Value"));
            JqeParam."Parameter Type"::Integer:
                exit(Format(JqeParam."Integer Value"));
            JqeParam."Parameter Type"::Media:
                exit(''); //todo
            JqeParam."Parameter Type"::MediaSet:
                exit(''); //todo
            JqeParam."Parameter Type"::Text:
                exit(JqeParam."Text Value");
            JqeParam."Parameter Type"::Time:
                exit(Format(JqeParam."Time Value"));
            else
                exit('');
        end;
    end;

    procedure GetDefaultParameterValue(JqeParamTempl: Record ADD_JobQueueEntryParamTemplate): Text
    begin
        //todo: this is not the best way to do it, but it works for now
        case JqeParamTempl."Parameter Type" of
            JqeParamTempl."Parameter Type"::None:
                exit('');
            JqeParamTempl."Parameter Type"::BigInteger:
                exit(Format(JqeParamTempl."BigInteger Value"));
            JqeParamTempl."Parameter Type"::Blob:
                exit(''); //todo
            JqeParamTempl."Parameter Type"::Boolean:
                exit(Format(JqeParamTempl."Boolean Value"));
            JqeParamTempl."Parameter Type"::Code:
                exit(JqeParamTempl."Code Value");
            JqeParamTempl."Parameter Type"::Date:
                exit(Format(JqeParamTempl."Date Value"));
            JqeParamTempl."Parameter Type"::DateFormula:
                exit(Format(JqeParamTempl."DateFormula Value"));
            JqeParamTempl."Parameter Type"::DateTime:
                exit(Format(JqeParamTempl."DateTime Value"));
            JqeParamTempl."Parameter Type"::Decimal:
                exit(Format(JqeParamTempl."Decimal Value"));
            JqeParamTempl."Parameter Type"::Duration:
                exit(Format(JqeParamTempl."Duration Value"));
            JqeParamTempl."Parameter Type"::Guid:
                exit(Format(JqeParamTempl."Guid Value"));
            JqeParamTempl."Parameter Type"::Integer:
                exit(Format(JqeParamTempl."Integer Value"));
            JqeParamTempl."Parameter Type"::Media:
                exit(''); //todo
            JqeParamTempl."Parameter Type"::MediaSet:
                exit(''); //todo
            JqeParamTempl."Parameter Type"::Text:
                exit(JqeParamTempl."Text Value");
            JqeParamTempl."Parameter Type"::Time:
                exit(Format(JqeParamTempl."Time Value"));
            else
                exit('');
        end;
    end;

    procedure ValidateParameterType(JqeParamTempl: Record ADD_JobQueueEntryParamTemplate)
    begin
        //todo validate if there is only one parameter value set and it is the same as the parameter type
    end;

    local procedure CreateJqeParamFromTemplIfNotExists(JQE: Record "Job Queue Entry"; JQEParamTempl: record ADD_JobQueueEntryParamTemplate; SetDefValue: Boolean)
    var
        JqeParam: record ADD_JobQueueEntryParameter;
    begin
        if JqeParam.Get(JQE.ID, JQEParamTempl."Parameter Name") then
            exit;
        CreateJqeParamFromTempl(JQE, JQEParamTempl, SetDefValue);
    end;

    local procedure CreateJqeParamFromNewTempForExistingJqe(NewJqeParamTempl: record ADD_JobQueueEntryParamTemplate; SetDefValueForExistingJqe: Boolean)
    var
        JqeParam: record ADD_JobQueueEntryParameter;
        Jqe: Record "Job Queue Entry";
    begin
        SetFilterToFindJobQueueEntriesRelatedToJqeTempl(NewJqeParamTempl, Jqe);
        if Jqe.FindSet() then
            repeat
                CreateJqeParamFromTemplIfNotExists(Jqe, NewJqeParamTempl, SetDefValueForExistingJqe);
            until Jqe.Next() = 0;
    end;

    local procedure SetFilterToFindJobQueueEntriesRelatedToJqeTempl(NewJqeParamTempl: record ADD_JobQueueEntryParamTemplate; var FilteredJqe: Record "Job Queue Entry")
    begin
        FilteredJqe.SetRange("Object Type to Run", NewJqeParamTempl."Object Type");
        FilteredJqe.SetRange("Object ID to Run", NewJqeParamTempl."Object ID");
    end;

    procedure CheckIfJqeIsOnHold(JqeParam: Record "ADD_JobQueueEntryParameter")
    var
        JobQueueEntry: Record "Job Queue Entry";
    begin
        JobQueueEntry.Get(JqeParam."Job Queue Entry ID");
        JobQueueEntry.TestField(Status, JobQueueEntry.Status::"On Hold");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Job Queue Entry", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertJQE(var Rec: Record "Job Queue Entry")
    begin
        Rec.CreateJobQueueEntryParam();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Job Queue Entry", 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyJQE(var Rec: Record "Job Queue Entry")
    begin
        Rec.OverwriteJobQueueEntryParam();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Job Queue Entry", 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeleteJQE(var Rec: Record "Job Queue Entry")
    begin
        Rec.DeleteJobQueueEntryParam();
    end;
}