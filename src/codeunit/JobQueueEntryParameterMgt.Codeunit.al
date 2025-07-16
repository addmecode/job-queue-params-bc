namespace Addmecode.JobQueueParams;
using System.Threading;

codeunit 50100 "ADD_JobQueueEntryParameterMgt"
{
    internal procedure CreateDefualtJobQueueEntryParameters(JobQueueEntry: Record "Job Queue Entry")
    var
        IsHandled: Boolean;
    begin
        OnBeforeMethodName(JobQueueEntry, IsHandled);

        DoMethodName(JobQueueEntry, IsHandled);

        OnAfterMethodName(JobQueueEntry);
    end;

    local procedure DoMethodName(JobQueueEntry: Record "Job Queue Entry"; IsHandled: Boolean)
    var
        JobQueueEntryParameter: Record "ADD_JobQueueEntryParameter";
    begin
        if IsHandled then
            exit;



    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeMethodName(JobQueueEntry: Record "Job Queue Entry"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterMethodName(JobQueueEntry: Record "Job Queue Entry")
    begin
    end;
}