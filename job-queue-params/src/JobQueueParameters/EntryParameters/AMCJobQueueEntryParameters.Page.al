namespace Addmecode.JobQueueParams;

page 50110 "AMC Job Queue Entry Parameters"
{
    ApplicationArea = All;
    Caption = 'Job Queue Entry Parameters';
    CardPageId = "AMC Job Queue Param Card";
    Editable = false;
    PageType = List;
    SourceTable = "AMC Job Queue Entry Parameter";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Job Queue Entry ID"; Rec."Job Queue Entry ID")
                {
                    ToolTip = 'Specifies the value of the Job Queue Entry ID field.', Comment = '%';
                }
                field("Object Type"; Rec."Object Type")
                {
                    ToolTip = 'Specifies the value of the Object Type field.', Comment = '%';
                }
                field("Object ID"; Rec."Object ID")
                {
                    ToolTip = 'Specifies the value of the Object ID field.', Comment = '%';
                }
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
                    Caption = 'Parameter Type';
                    ToolTip = 'Specifies the value of the Parameter Type field.', Comment = '%';
                }
                field("Parameter Value"; Rec.GetParameterValueAsText())
                {
                    Caption = 'Parameter Value';
                    ToolTip = 'Specifies the parameter value.', Comment = '%';
                }
            }
        }
    }
}
