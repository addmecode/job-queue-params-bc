namespace Addmecode.jobqueueparamsbc;

using System.Threading;
using Addmecode.JobQueueParams;

tableextension 50100 "ADD_JobQueueEntry" extends "Job Queue Entry"
{

    procedure CreateJobQueueEntryParam()
    var
        JobQueueEntryMgt: Codeunit ADD_JobQueueEntryParameterMgt;
    begin
        JobQueueEntryMgt.CreateJobQueueEntryParam(Rec);
    end;

    procedure DeleteJobQueueEntryParam()
    var
        JobQueueEntryMgt: Codeunit ADD_JobQueueEntryParameterMgt;
    begin
        JobQueueEntryMgt.DeleteJobQueueEntryParam(Rec);
    end;

    procedure OverwriteJobQueueEntryParam()
    var
        JobQueueEntryMgt: Codeunit ADD_JobQueueEntryParameterMgt;
    begin
        JobQueueEntryMgt.OverwriteJobQueueEntryParam(Rec, xRec);
    end;

}
