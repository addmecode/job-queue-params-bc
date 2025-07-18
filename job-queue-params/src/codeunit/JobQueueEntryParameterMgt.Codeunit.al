namespace Addmecode.JobQueueParams;
using System.Threading;
using Microsoft.Projects.Project.Job;

codeunit 50100 "ADD_JobQueueEntryParameterMgt"
{
    procedure CreateJobQueueEntryParam(JQE: Record "Job Queue Entry")
    var
        JQEParam: Record "ADD_JobQueueEntryParameter";
        JQEParamTempl: record ADD_JobQueueEntryParamTemplate;
    begin
        if JQE."Object ID to Run" = 0 then
            exit;
        JQEParamTempl.SetRange("Object ID", JQE."Object ID to Run");
        JQEParamTempl.SetRange("Object Type", JQE."Object Type to Run");
        if JQEParamTempl.FindSet() then
            repeat
                JQEParam.Init();
                JQEParam."Job Queue Entry ID" := JQE.ID;
                JQEParam."Parameter Name" := JQEParamTempl."Parameter Name";
                JQEParam."Parameter Value" := JQEParamTempl."Default Parameter Value";
                JQEParam.Insert();
            until JQEParamTempl.Next() = 0;
    end;

    procedure DeleteJobQueueEntryParam(JQE: Record "Job Queue Entry")
    var
        JQEParam: Record "ADD_JobQueueEntryParameter";
    begin
        if JQE."Object ID to Run" = 0 then
            exit;
        JQEParam.SetRange("Job Queue Entry ID", JQE.ID);
        JQEParam.DeleteAll(true);
    end;

    procedure OverwriteJobQueueEntryParam(JQE: Record "Job Queue Entry"; xJQE: Record "Job Queue Entry")
    var
        JQEParam: Record "ADD_JobQueueEntryParameter";
    begin
        if JQE."Object ID to Run" = 0 then
            exit;
        if (JQE."Object ID to Run" = xJQE."Object ID to Run") and (JQE."Object Type to Run" = xJQE."Object Type to Run") then
            exit;

        DeleteJobQueueEntryParam(JQE);
        CreateJobQueueEntryParam(JQE);
    end;

    internal procedure CreateJqeParamTemplIfNotExists(JqeToCreate: Record ADD_JobQueueEntryParamTemplate)
    var
        JobQueueEntryParamTempl: Record ADD_JobQueueEntryParamTemplate;
    begin
        if (JobQueueEntryParamTempl.Get(JqeToCreate."Object Type", JqeToCreate."Object ID", JqeToCreate."Parameter Name")) then
            exit;
        JqeToCreate.Insert(true);
    end;

    internal procedure GetJobQueueEntryParamValue(Jqe: Record "Job Queue Entry"; ParamName: Text[100]): Text[250]
    var
        JqueParam: Record "ADD_JobQueueEntryParameter";
    begin
        JqueParam.Get(Jqe.ID, ParamName);
        exit(JqueParam."Parameter Value");
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