namespace Addmecode.JobQueueParams;
using System.Threading;

pageextension 50101 "ADD_JobQueueEntryCard" extends "Job Queue Entry Card"
{
    actions
    {
        addbefore("Set Status to Ready")
        {
            action(ADD_ShowParameters)
            {
                ApplicationArea = All;
                Caption = 'Show Parameters';
                Image = ShowMatrix;
                ToolTip = 'Show Job Queue Entry Parameters';
                trigger OnAction()
                var
                    JobQueueEntryParameter: Record "ADD_JobQueueEntryParameter";
                    JobQueueEntry: Record "Job Queue Entry";
                begin
                    JobQueueEntryParameter.SetRange("Job Queue Entry ID", Rec.ID);
                    Page.RunModal(Page::ADD_JobQueueEntryParamsLookUp, JobQueueEntryParameter);
                end;
            }
        }
        addbefore("Set Status to Ready_Promoted")
        {
            actionref(ADD_ShowParameters_Promoted; ADD_ShowParameters)
            {
            }
        }
    }

}