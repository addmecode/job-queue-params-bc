namespace jobqueueparamsbc.jobqueueparamsbc;

using Addmecode.JobQueueParams;

page 50101 "ADD_JobQueueEntryParamTemplate"
{
    ApplicationArea = All;
    Caption = 'Job Queue Entry Parameter Template';
    PageType = List;
    SourceTable = ADD_JobQueueEntryParamTemplate;
    UsageCategory = Lists;

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
                field("Default Parameter Value"; Rec."Default Parameter Value")
                {
                    ToolTip = 'Specifies the value of the Default Parameter Value field.', Comment = '%';
                }
            }
        }
    }
}
