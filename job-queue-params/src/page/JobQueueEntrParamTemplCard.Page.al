namespace Addmecode.jobqueueparams;

page 50103 "ADD_JobQueueEntrParamTemplCard"
{
    ApplicationArea = All;
    Caption = 'Job Queue Entry Parameter Template Card';
    PageType = Card;
    SourceTable = ADD_JobQueueEntryParamTemplate;

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

                field("Parameter Description"; Rec."Parameter Description")
                {
                    ToolTip = 'Specifies the value of the Parameter Description field.', Comment = '%';
                    Editable = True;
                }
                group(BigIntegerValue)
                {
                    visible = Rec."Parameter Type" = Rec."Parameter Type"::BigInteger;
                    Caption = '';
                    field("BigInteger Value"; Rec."BigInteger Value")
                    {
                        ToolTip = 'Specifies the value of the BigInteger Value field.', Comment = '%';
                        Caption = 'Parameter Value';
                    }
                }
                group(BlobValue)
                {
                    visible = Rec."Parameter Type" = Rec."Parameter Type"::Blob;
                    Caption = '';
                    field("Blob Value"; Rec."Blob Value")
                    {
                        ToolTip = 'Specifies the value of the Blob Value field.', Comment = '%';
                        Caption = 'Parameter Value';
                    }
                }
                group(BooleanValue)
                {
                    visible = Rec."Parameter Type" = Rec."Parameter Type"::Boolean;
                    Caption = '';
                    field("Boolean Value"; Rec."Boolean Value")
                    {
                        ToolTip = 'Specifies the value of the Boolean Value field.', Comment = '%';
                        Caption = 'Parameter Value';
                    }
                }
                group(CodeValue)
                {
                    visible = Rec."Parameter Type" = Rec."Parameter Type"::Code;
                    Caption = '';
                    field("Code Value"; Rec."Code Value")
                    {
                        ToolTip = 'Specifies the value of the Code Value field.', Comment = '%';
                        Caption = 'Parameter Value';
                    }
                }
                group(DateValue)
                {
                    visible = Rec."Parameter Type" = Rec."Parameter Type"::Date;
                    Caption = '';
                    field("Date Value"; Rec."Date Value")
                    {
                        ToolTip = 'Specifies the value of the Date Value field.', Comment = '%';
                        Caption = 'Parameter Value';
                    }
                }
                group(DateFormulaValue)
                {
                    visible = Rec."Parameter Type" = Rec."Parameter Type"::DateFormula;
                    Caption = '';
                    field("DateFormula Value"; Rec."DateFormula Value")
                    {
                        ToolTip = 'Specifies the value of the DateFormula Value field.', Comment = '%';
                        Caption = 'Parameter Value';
                    }
                }
                group(DateTimeValue)
                {
                    visible = Rec."Parameter Type" = Rec."Parameter Type"::DateTime;
                    Caption = '';
                    field("DateTime Value"; Rec."DateTime Value")
                    {
                        ToolTip = 'Specifies the value of the DateTime Value field.', Comment = '%';
                        Caption = 'Parameter Value';
                    }
                }
                group(DecimalValue)
                {
                    visible = Rec."Parameter Type" = Rec."Parameter Type"::Decimal;
                    Caption = '';
                    field("Decimal Value"; Rec."Decimal Value")
                    {
                        ToolTip = 'Specifies the value of the Decimal Value field.', Comment = '%';
                        Caption = 'Parameter Value';
                    }
                }
                group(DurationValue)
                {
                    visible = Rec."Parameter Type" = Rec."Parameter Type"::Duration;
                    Caption = '';
                    field("Duration Value"; Rec."Duration Value")
                    {
                        ToolTip = 'Specifies the value of the Duration Value field.', Comment = '%';
                        Caption = 'Parameter Value';
                    }
                }
                group(GuidValue)
                {
                    visible = Rec."Parameter Type" = Rec."Parameter Type"::Guid;
                    Caption = '';
                    field("Guid Value"; Rec."Guid Value")
                    {
                        ToolTip = 'Specifies the value of the Guid Value field.', Comment = '%';
                        Caption = 'Parameter Value';
                    }
                }
                group(IntegerValue)
                {
                    Visible = Rec."Parameter Type" = Rec."Parameter Type"::Integer;
                    Caption = '';
                    field("Integer Value"; Rec."Integer Value")
                    {
                        ToolTip = 'Specifies the value of the Integer Value field.', Comment = '%';
                        Caption = 'Parameter Value';
                    }
                }
                group(MediaValue)
                {
                    visible = Rec."Parameter Type" = Rec."Parameter Type"::Media;
                    Caption = '';
                    field("Media Value"; Rec."Media Value")
                    {
                        ToolTip = 'Specifies the value of the Media Value field.', Comment = '%';
                        Caption = 'Parameter Value';
                    }
                }
                group(MediaSetValue)
                {
                    visible = Rec."Parameter Type" = Rec."Parameter Type"::MediaSet;
                    Caption = '';
                    field("MediaSet Value"; Rec."MediaSet Value")
                    {
                        ToolTip = 'Specifies the value of the MediaSet Value field.', Comment = '%';
                        Caption = 'Parameter Value';
                    }
                }
                group(TextValue)
                {
                    visible = Rec."Parameter Type" = Rec."Parameter Type"::Text;
                    Caption = '';
                    field("Text Value"; Rec."Text Value")
                    {
                        ToolTip = 'Specifies the value of the Text Value field.', Comment = '%';
                        Caption = 'Parameter Value';
                    }
                }
                group(TimeValue)
                {
                    visible = Rec."Parameter Type" = Rec."Parameter Type"::Time;
                    Caption = '';
                    field("Time Value"; Rec."Time Value")
                    {
                        ToolTip = 'Specifies the value of the Time Value field.', Comment = '%';
                        Caption = 'Parameter Value';
                    }
                }
            }
        }
    }
}
