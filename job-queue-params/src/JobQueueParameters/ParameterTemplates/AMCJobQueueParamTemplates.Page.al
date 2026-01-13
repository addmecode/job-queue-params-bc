namespace Addmecode.JobQueueParams;

page 50108 "AMC Job Queue Param Templates"
{
    ApplicationArea = All;
    Caption = 'Job Queue Entry Parameter Templates';
    CardPageId = "AMC Job Queue Param Templ Card";
    Editable = false;
    PageType = List;
    SourceTable = "AMC Job Queue Param Template";
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
                field("Parameter Type"; Rec.GetTemplParameterTypeCaption())
                {
                    Caption = 'Parameter Type';
                    ToolTip = 'Specifies the value of the Parameter Type field.', Comment = '%';
                }
                field("Parameter Value"; Rec.GetDefaultParameterValue())
                {
                    Caption = 'Parameter Value';
                    ToolTip = 'Specifies the default parameter value.', Comment = '%';
                }
            }
        }
    }
}
