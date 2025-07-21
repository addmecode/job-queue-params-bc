namespace Addmecode.jobqueueparams;

page 50103 "ADD_JobQueueEntrParamTemplCard"
{
    ApplicationArea = All;
    Caption = 'Job Queue Entry Parameter Template Card';
    PageType = Card;
    SourceTable = ADD_JobQueueEntryParamTemplate;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
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
                field("Parameter Type"; Rec."Parameter Type")
                {
                    ToolTip = 'Specifies the value of the Parameter Type field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                }
            }
            group(Custom)
            {
                ShowCaption = False;
                group(ParameterDescription)
                {
                    Caption = 'Parameter Description';
                    ShowCaption = true;
                    Editable = True;

                    field("Parameter Description"; Rec."Parameter Description")
                    {
                        ToolTip = 'Specifies the value of the Parameter Description field.', Comment = '%';
                        ShowCaption = false;
                    }
                }
                group(ParameterValue)
                {
                    Caption = 'Parameter Value';
                    ShowCaption = true;
                    Editable = true;
                    group(BigIntegerValue)
                    {
                        visible = Rec."Parameter Type" = Rec."Parameter Type"::BigInteger;
                        ShowCaption = false;
                        field("BigInteger Value"; Rec."BigInteger Value")
                        {
                            ToolTip = 'Specifies the value of the BigInteger Value field.', Comment = '%';
                            ShowCaption = false;
                        }
                    }
                    group(BlobValue)
                    {
                        visible = Rec."Parameter Type" = Rec."Parameter Type"::Blob;
                        ShowCaption = false;
                        field("Blob Value"; Rec."Blob Value")
                        {
                            ToolTip = 'Specifies the value of the Blob Value field.', Comment = '%';
                            ShowCaption = false;
                        }
                    }
                    group(BooleanValue)
                    {
                        visible = Rec."Parameter Type" = Rec."Parameter Type"::Boolean;
                        ShowCaption = false;
                        field("Boolean Value"; Rec."Boolean Value")
                        {
                            ToolTip = 'Specifies the value of the Boolean Value field.', Comment = '%';
                            ShowCaption = false;
                        }
                    }
                    group(CodeValue)
                    {
                        visible = Rec."Parameter Type" = Rec."Parameter Type"::Code;
                        ShowCaption = false;
                        field("Code Value"; Rec."Code Value")
                        {
                            ToolTip = 'Specifies the value of the Code Value field.', Comment = '%';
                            ShowCaption = false;
                        }
                    }
                    group(DateValue)
                    {
                        visible = Rec."Parameter Type" = Rec."Parameter Type"::Date;
                        ShowCaption = false;
                        field("Date Value"; Rec."Date Value")
                        {
                            ToolTip = 'Specifies the value of the Date Value field.', Comment = '%';
                            ShowCaption = false;
                        }
                    }
                    group(DateFormulaValue)
                    {
                        visible = Rec."Parameter Type" = Rec."Parameter Type"::DateFormula;
                        ShowCaption = false;
                        field("DateFormula Value"; Rec."DateFormula Value")
                        {
                            ToolTip = 'Specifies the value of the DateFormula Value field.', Comment = '%';
                            ShowCaption = false;
                        }
                    }
                    group(DateTimeValue)
                    {
                        visible = Rec."Parameter Type" = Rec."Parameter Type"::DateTime;
                        ShowCaption = false;
                        field("DateTime Value"; Rec."DateTime Value")
                        {
                            ToolTip = 'Specifies the value of the DateTime Value field.', Comment = '%';
                            ShowCaption = false;
                        }
                    }
                    group(DecimalValue)
                    {
                        visible = Rec."Parameter Type" = Rec."Parameter Type"::Decimal;
                        ShowCaption = false;
                        field("Decimal Value"; Rec."Decimal Value")
                        {
                            ToolTip = 'Specifies the value of the Decimal Value field.', Comment = '%';
                            ShowCaption = false;
                        }
                    }
                    group(DurationValue)
                    {
                        visible = Rec."Parameter Type" = Rec."Parameter Type"::Duration;
                        ShowCaption = false;
                        field("Duration Value"; Rec."Duration Value")
                        {
                            ToolTip = 'Specifies the value of the Duration Value field.', Comment = '%';
                            ShowCaption = false;
                        }
                    }
                    group(GuidValue)
                    {
                        visible = Rec."Parameter Type" = Rec."Parameter Type"::Guid;
                        ShowCaption = false;
                        field("Guid Value"; Rec."Guid Value")
                        {
                            ToolTip = 'Specifies the value of the Guid Value field.', Comment = '%';
                            ShowCaption = false;
                        }
                    }
                    group(IntegerValue)
                    {
                        Visible = Rec."Parameter Type" = Rec."Parameter Type"::Integer;
                        ShowCaption = false;
                        field("Integer Value"; Rec."Integer Value")
                        {
                            ToolTip = 'Specifies the value of the Integer Value field.', Comment = '%';
                            ShowCaption = false;
                        }
                    }
                    group(MediaValue)
                    {
                        visible = Rec."Parameter Type" = Rec."Parameter Type"::Media;
                        ShowCaption = false;
                        field("Media Value"; Rec."Media Value")
                        {
                            ToolTip = 'Specifies the value of the Media Value field.', Comment = '%';
                            ShowCaption = false;
                        }
                    }
                    group(MediaSetValue)
                    {
                        visible = Rec."Parameter Type" = Rec."Parameter Type"::MediaSet;
                        ShowCaption = false;
                        field("MediaSet Value"; Rec."MediaSet Value")
                        {
                            ToolTip = 'Specifies the value of the MediaSet Value field.', Comment = '%';
                            ShowCaption = false;
                        }
                    }
                    group(TextValue)
                    {
                        visible = Rec."Parameter Type" = Rec."Parameter Type"::Text;
                        ShowCaption = false;
                        field("Text Value"; Rec."Text Value")
                        {
                            ToolTip = 'Specifies the value of the Text Value field.', Comment = '%';
                            ShowCaption = false;
                        }
                    }
                    group(TimeValue)
                    {
                        visible = Rec."Parameter Type" = Rec."Parameter Type"::Time;
                        ShowCaption = false;
                        field("Time Value"; Rec."Time Value")
                        {
                            ToolTip = 'Specifies the value of the Time Value field.', Comment = '%';
                            ShowCaption = false;
                        }
                    }
                }
            }
        }
    }
}
