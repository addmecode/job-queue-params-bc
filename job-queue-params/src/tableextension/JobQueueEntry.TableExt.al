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

    procedure GetJobQueueEntryParamValue(ParamName: Text[100]): Text[250]
    var
        JobQueueEntryMgt: Codeunit ADD_JobQueueEntryParameterMgt;
    begin
        exit(JobQueueEntryMgt.GetJobQueueEntryParamValue(Rec, ParamName));
    end;

}
