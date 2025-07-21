namespace Addmecode.jobqueueparamsbc;

using System.Threading;
using Addmecode.JobQueueParams;

tableextension 50100 "ADD_JobQueueEntry" extends "Job Queue Entry"
{

    procedure CreateJobQueueEntryParam()
    var
        JobQueueEntryMgt: Codeunit ADD_JobQueueEntryParameterMgt;
    begin
        JobQueueEntryMgt.CreateAllJobQueueEntryParamsFromTempl(Rec, true);
    end;

    procedure DeleteJobQueueEntryParam()
    var
        JobQueueEntryMgt: Codeunit ADD_JobQueueEntryParameterMgt;
    begin
        JobQueueEntryMgt.DeleteAllJobQueueEntryParams(Rec);
    end;

    procedure OverwriteJobQueueEntryParam()
    var
        JobQueueEntryMgt: Codeunit ADD_JobQueueEntryParameterMgt;
    begin
        JobQueueEntryMgt.OverwriteAllJobQueueEntryParamsFromTempl(Rec, xRec, true);
    end;

    procedure GetJobQueueEntryParamValue(ParamName: Text[100]): Variant
    var
        JobQueueEntryMgt: Codeunit ADD_JobQueueEntryParameterMgt;
    begin
        exit(JobQueueEntryMgt.GetJobQueueEntryParamValue(Rec, ParamName));
    end;

}
