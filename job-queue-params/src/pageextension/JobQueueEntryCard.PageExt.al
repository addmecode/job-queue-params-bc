namespace Addmecode.JobQueueParams;
using System.Threading;

pageextension 50101 "ADD_JobQueueEntryCard" extends "Job Queue Entry Card"
{
    layout
    {
        addafter(General)
        {
            part(JobQueueEntryParameters; ADD_JobQueueEntryParamsSubform)
            {
                SubPageLink = "Job Queue Entry ID" = FIELD(ID);
                ApplicationArea = All;
                UpdatePropagation = SubPart;
                Editable = Rec.Status = Rec.Status::"On Hold";
            }
        }
    }
}