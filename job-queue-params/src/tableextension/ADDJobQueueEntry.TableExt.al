namespace Addmecode.jobqueueparamsbc;

using Addmecode.JobQueueParams;
using System.Threading;

tableextension 50100 "ADD_JobQueueEntry" extends "Job Queue Entry"
{
    /// <summary>
    /// Creates parameters for the current job queue entry from templates.
    /// </summary>
    procedure CreateJobQueueEntryParam()
    var
        JobQueueEntryMgt: Codeunit ADD_JobQueueEntryParameterMgt;
    begin
        JobQueueEntryMgt.CreateAllJobQueueEntryParamsFromTempl(Rec, true);
    end;

    /// <summary>
    /// Deletes parameters for the current job queue entry.
    /// </summary>
    procedure DeleteJobQueueEntryParam()
    var
        JobQueueEntryMgt: Codeunit ADD_JobQueueEntryParameterMgt;
    begin
        JobQueueEntryMgt.DeleteAllJobQueueEntryParams(Rec);
    end;

    /// <summary>
    /// Recreates parameters when the job queue entry object changes.
    /// </summary>
    procedure OverwriteJobQueueEntryParam()
    var
        JobQueueEntryMgt: Codeunit ADD_JobQueueEntryParameterMgt;
    begin
        JobQueueEntryMgt.OverwriteAllJobQueueEntryParamsFromTempl(Rec, true);
    end;

    /// <summary>
    /// Gets the parameter value for the current job queue entry.
    /// </summary>
    /// <param name="ParameterName">The parameter name to read.</param>
    /// <returns>The parameter value as a variant.</returns>
    procedure GetJobQueueEntryParamValue(ParameterName: Text[100]): Variant
    var
        JobQueueEntryMgt: Codeunit ADD_JobQueueEntryParameterMgt;
    begin
        exit(JobQueueEntryMgt.GetJobQueueEntryParamValue(Rec, ParameterName));
    end;
}
