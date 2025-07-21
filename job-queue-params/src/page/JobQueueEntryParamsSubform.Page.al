namespace Addmecode.JobQueueParams;

page 50102 "ADD_JobQueueEntryParamsSubform"
{
    ApplicationArea = All;
    Caption = 'Job Queue Entry Parameters';
    PageType = ListPart;
    SourceTable = ADD_JobQueueEntryParameter;
    CardPageId = ADD_JobQueueEntrParamCard;
    Editable = false;

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
                field("Parameter Type"; Rec."Parameter Type")
                {
                    ToolTip = 'Specifies the value of the Parameter Type field.', Comment = '%';
                }
                field("Parameter Value"; Rec.GetParameterValue())
                {
                    ToolTip = 'Specifies the parameter value.', Comment = '%';
                }
            }
        }
    }
}
