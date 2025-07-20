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
        if SetDefValue then
            JQEParam."Parameter Value" := JQEParamTempl."Default Parameter Value";
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
        exit(JqueParam."Parameter Value");
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