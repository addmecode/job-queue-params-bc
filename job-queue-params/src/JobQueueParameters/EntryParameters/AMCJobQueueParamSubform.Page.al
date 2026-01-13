namespace Addmecode.JobQueueParams;

page 50111 "AMC Job Queue Param Subform"
{
    ApplicationArea = All;
    Caption = 'Job Queue Entry Parameters';
    CardPageId = "AMC Job Queue Param Card";
    Editable = false;
    PageType = ListPart;
    SourceTable = "AMC Job Queue Entry Parameter";

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
