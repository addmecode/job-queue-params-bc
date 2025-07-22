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
        RecRefTempl: RecordRef;
        RecRefParam: RecordRef;
        TemplFieldRef: FieldRef;
        ParamFieldRef: FieldRef;
    begin
        RecRefTempl.GetTable(JQEParamTempl);
        RecRefParam.Open(Database::ADD_JobQueueEntryParameter);

        RecRefParam.Field(JQEParam.FieldNo("Job Queue Entry ID")).Value := JQE.ID;
        RecRefParam.Field(JQEParam.FieldNo("Parameter Name")).Value := JQEParamTempl."Parameter Name";
        if SetDefValue then begin
            TemplFieldRef := RecRefTempl.Field(JQEParamTempl."Parameter Type");
            ParamFieldRef := RecRefParam.Field(TemplFieldRef.Number);
            ParamFieldRef.Value := TemplFieldRef.Value;
        end;
        RecRefParam.Insert();
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

    internal procedure GetJobQueueEntryParamValue(Jqe: Record "Job Queue Entry"; ParamName: Text[100]): Variant
    var
        JqueParam: Record "ADD_JobQueueEntryParameter";
    begin
        JqueParam.Get(Jqe.ID, ParamName);
        exit(GetParameterValue(JqueParam));
    end;

    procedure IsParamEditable(JqeParam: Record ADD_JobQueueEntryParameter): Boolean
    var
        JobQueueEntry: Record "Job Queue Entry";
    begin
        JobQueueEntry.Get(JqeParam."Job Queue Entry ID");
        exit(JobQueueEntry.Status = JobQueueEntry.Status::"On Hold");
    end;

    procedure GetTemplParameterTypeCaption(var JqeParamTempl: Record ADD_JobQueueEntryParamTemplate): Text
    var
        RecRef: RecordRef;
        FieldRef: FieldRef;
    begin
        RecRef.GetTable(JqeParamTempl);
        FieldRef := RecRef.Field(JqeParamTempl."Parameter Type");
        exit(Format(FieldRef.Type));
    end;

    procedure GetParameterTypeCaption(var JqeParam: Record ADD_JobQueueEntryParameter): Text
    var
        RecRef: RecordRef;
        FieldRef: FieldRef;
    begin
        JqeParam.CalcFields("Parameter Type");
        RecRef.GetTable(JqeParam);
        FieldRef := RecRef.Field(JqeParam."Parameter Type");
        exit(Format(FieldRef.Type));
    end;

    procedure GetParameterValueAsText(JqeParam: Record ADD_JobQueueEntryParameter): Text
    begin
        exit(Format(GetParameterValue((JqeParam))));
    end;

    procedure GetParameterValue(JqeParam: Record ADD_JobQueueEntryParameter): Variant
    var
        RecRef: RecordRef;
        FieldRef: FieldRef;
    begin
        JqeParam.CalcFields("Parameter Type");
        case JqeParam."Parameter Type" of
            // TODO
            JqeParam.FieldNo("Blob Value"):
                exit('');
            JqeParam.FieldNo("Media Value"):
                exit('');
            JqeParam.FieldNo("MediaSet Value"):
                exit('');
            else begin
                RecRef.GetTable(JqeParam);
                FieldRef := RecRef.Field(JqeParam."Parameter Type");
                exit(FieldRef.Value());
            end;
        end;
    end;

    procedure GetDefaultParameterValue(JqeParamTempl: Record ADD_JobQueueEntryParamTemplate): Text
    var
        RecRef: RecordRef;
        FieldRef: FieldRef;
    begin
        case JqeParamTempl.FieldNo("Parameter Type") of
            // TODO
            JqeParamTempl.FieldNo("Blob Value"):
                exit('');
            JqeParamTempl.FieldNo("Media Value"):
                exit('');
            JqeParamTempl.FieldNo("MediaSet Value"):
                exit('');
            else begin
                RecRef.GetTable(JqeParamTempl);
                FieldRef := RecRef.Field(JqeParamTempl."Parameter Type");
                exit(Format(FieldRef.Value()));
            end;
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