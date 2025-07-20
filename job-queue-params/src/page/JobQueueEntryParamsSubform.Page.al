namespace Addmecode.JobQueueParams;

page 50102 "ADD_JobQueueEntryParamsSubform"
{
    ApplicationArea = All;
    Caption = 'Job Queue Entry Parameters';
    PageType = ListPart;
    SourceTable = ADD_JobQueueEntryParameter;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Parameter Name"; Rec."Parameter Name")
                {
                    ToolTip = 'Specifies the value of the Parameter Name field.', Comment = '%';
                }
                field("Parameter Description"; Rec."Parameter Description")
                {
                    ToolTip = 'Specifies the value of the Parameter Description field.', Comment = '%';
                }
                field("Parameter Value"; Rec."Parameter Value")
                {
                    ToolTip = 'Specifies the value of the Parameter Value field.', Comment = '%';
                }
            }
        }
    }
}
