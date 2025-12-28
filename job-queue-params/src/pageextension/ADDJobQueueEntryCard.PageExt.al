namespace Addmecode.JobQueueParams;
using System.Threading;

pageextension 50120 "ADD_JobQueueEntryCard" extends "Job Queue Entry Card"
{
    layout
    {
        addafter(General)
        {
            part(JobQueueEntryParameters; ADD_JobQueueEntryParamsSubform)
            {
                ApplicationArea = All;
                Editable = Rec.Status = Rec.Status::"On Hold";
                SubPageLink = "Job Queue Entry ID" = field(ID);
                UpdatePropagation = SubPart;
            }
        }
    }
}