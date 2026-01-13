namespace Addmecode.JobQueueParams;
using System.Threading;

pageextension 50101 "AMC Job Queue Entry Card" extends "Job Queue Entry Card"
{
    layout
    {
        addafter(General)
        {
            part(JobQueueEntryParameters; "AMC Job Queue Param Subform")
            {
                ApplicationArea = All;
                Editable = Rec.Status = Rec.Status::"On Hold";
                SubPageLink = "Job Queue Entry ID" = field(ID);
                UpdatePropagation = SubPart;
            }
        }
    }
}
