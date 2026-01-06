namespace Addmecode.JobQueueParams;

page 50111 "ADD_JobQueueEntryParamsSubform"
{
    ApplicationArea = All;
    Caption = 'Job Queue Entry Parameters';
    CardPageId = ADD_JobQueueEntrParamCard;
    Editable = false;
    PageType = ListPart;
    SourceTable = ADD_JobQueueEntryParameter;

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
                field("Parameter Type"; Rec.GetParameterTypeCaption())
                {
                    ToolTip = 'Specifies the value of the Parameter Type field.', Comment = '%';
                }
                field("Parameter Value"; Rec.GetParameterValueAsText())
                {
                    ToolTip = 'Specifies the parameter value.', Comment = '%';
                }
            }
        }
    }
}
