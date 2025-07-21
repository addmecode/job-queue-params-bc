namespace Addmecode.JobQueueParams;

page 50101 "ADD_JobQueueEntrParamTemplates"
{
    ApplicationArea = All;
    Caption = 'Job Queue Entry Parameter Templates';
    PageType = List;
    SourceTable = ADD_JobQueueEntryParamTemplate;
    UsageCategory = Lists;
    CardPageId = "ADD_JobQueueEntrParamTemplCard";
    Editable = False;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Object Type"; Rec."Object Type")
                {
                    ToolTip = 'Specifies the value of the Object Type field.', Comment = '%';
                }
                field("Object ID"; Rec."Object ID")
                {
                    ToolTip = 'Specifies the value of the Object ID field.', Comment = '%';
                }
                field("Object Caption"; Rec."Object Caption")
                {
                    ToolTip = 'Specifies the value of the Object Caption field.', Comment = '%';
                }
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
                field("Parameter Value"; Rec.GetDefaultParameterValue())
                {
                    ToolTip = 'Specifies the default parameter value.', Comment = '%';
                }
            }
        }
    }
}
