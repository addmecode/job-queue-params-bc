namespace Addmecode.jobqueueparams;

page 50104 "ADD_JobQueueEntrParamCard"
{
    ApplicationArea = All;
    Caption = 'Job Queue Entry Parameter Card';
    PageType = Card;
    SourceTable = ADD_JobQueueEntryParameter;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
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
                field("Parameter Type"; Rec.GetParameterTypeCaption())
                {
                    ToolTip = 'Specifies the value of the Parameter Type field.', Comment = '%';
                }
                group(ModificationInfo)
                {
                    Caption = 'Modification Information';
                    ShowCaption = true;
                    field(SystemModifiedAt; Rec.SystemModifiedAt)
                    {
                        ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                    }
                    field(SystemModifiedBy; Rec.SystemModifiedBy)
                    {
                        ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                    }
                }
            }
            group(Custom)
            {
                ShowCaption = False;
                Editable = IsParamEditable;
                group(ParameterDescription)
                {
                    Caption = 'Parameter Description';
                    ShowCaption = true;

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
                    group(BigIntegerValue)
                    {
                        visible = isValueBigInteger;
                        ShowCaption = false;
                        field("BigInteger Value"; Rec."BigInteger Value")
                        {
                            ToolTip = 'Specifies the value of the BigInteger Value field.', Comment = '%';
                            ShowCaption = false;
                        }
                    }
                    group(BlobValue)
                    {
                        visible = isValueBlob;
                        ShowCaption = false;
                        field("Blob Value"; Rec."Blob Value")
                        {
                            ToolTip = 'Specifies the value of the Blob Value field.', Comment = '%';
                            ShowCaption = false;
                        }
                    }
                    group(BooleanValue)
                    {
                        visible = isValueBoolean;
                        ShowCaption = false;
                        field("Boolean Value"; Rec."Boolean Value")
                        {
                            ToolTip = 'Specifies the value of the Boolean Value field.', Comment = '%';
                            ShowCaption = false;
                        }
                    }
                    group(CodeValue)
                    {
                        visible = isValueCode;
                        ShowCaption = false;
                        field("Code Value"; Rec."Code Value")
                        {
                            ToolTip = 'Specifies the value of the Code Value field.', Comment = '%';
                            ShowCaption = false;
                        }
                    }
                    group(DateValue)
                    {
                        visible = isValueDate;
                        ShowCaption = false;
                        field("Date Value"; Rec."Date Value")
                        {
                            ToolTip = 'Specifies the value of the Date Value field.', Comment = '%';
                            ShowCaption = false;
                        }
                    }
                    group(DateFormulaValue)
                    {
                        visible = isValueDateFormula;
                        ShowCaption = false;
                        field("DateFormula Value"; Rec."DateFormula Value")
                        {
                            ToolTip = 'Specifies the value of the DateFormula Value field.', Comment = '%';
                            ShowCaption = false;
                        }
                    }
                    group(DateTimeValue)
                    {
                        visible = isValueDateTime;
                        ShowCaption = false;
                        field("DateTime Value"; Rec."DateTime Value")
                        {
                            ToolTip = 'Specifies the value of the DateTime Value field.', Comment = '%';
                            ShowCaption = false;
                        }
                    }
                    group(DecimalValue)
                    {
                        visible = isValueDecimal;
                        ShowCaption = false;
                        field("Decimal Value"; Rec."Decimal Value")
                        {
                            ToolTip = 'Specifies the value of the Decimal Value field.', Comment = '%';
                            ShowCaption = false;
                        }
                    }
                    group(DurationValue)
                    {
                        visible = isValueDuration;
                        ShowCaption = false;
                        field("Duration Value"; Rec."Duration Value")
                        {
                            ToolTip = 'Specifies the value of the Duration Value field.', Comment = '%';
                            ShowCaption = false;
                        }
                    }
                    group(GuidValue)
                    {
                        visible = isValueGuid;
                        ShowCaption = false;
                        field("Guid Value"; Rec."Guid Value")
                        {
                            ToolTip = 'Specifies the value of the Guid Value field.', Comment = '%';
                            ShowCaption = false;
                        }
                    }
                    group(IntegerValue)
                    {
                        Visible = isValueInteger;
                        ShowCaption = false;
                        field("Integer Value"; Rec."Integer Value")
                        {
                            ToolTip = 'Specifies the value of the Integer Value field.', Comment = '%';
                            ShowCaption = false;
                        }
                    }
                    group(MediaValue)
                    {
                        visible = isValueMedia;
                        ShowCaption = false;
                        field("Media Value"; Rec."Media Value")
                        {
                            ToolTip = 'Specifies the value of the Media Value field.', Comment = '%';
                            ShowCaption = false;
                        }
                    }
                    group(MediaSetValue)
                    {
                        visible = isValueMediaSet;
                        ShowCaption = false;
                        field("MediaSet Value"; Rec."MediaSet Value")
                        {
                            ToolTip = 'Specifies the value of the MediaSet Value field.', Comment = '%';
                            ShowCaption = false;
                        }
                    }
                    group(TextValue)
                    {
                        visible = isValueText;
                        ShowCaption = false;
                        field("Text Value"; Rec."Text Value")
                        {
                            ToolTip = 'Specifies the value of the Text Value field.', Comment = '%';
                            ShowCaption = false;
                        }
                    }
                    group(TimeValue)
                    {
                        visible = isValueTime;
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

    var
        isValueBigInteger: Boolean;
        isValueBlob: Boolean;
        isValueBoolean: Boolean;
        isValueCode: Boolean;
        isValueDate: Boolean;
        isValueDateFormula: Boolean;
        isValueDateTime: Boolean;
        isValueDecimal: Boolean;
        isValueDuration: Boolean;
        isValueGuid: Boolean;
        isValueInteger: Boolean;
        isValueMedia: Boolean;
        isValueMediaSet: Boolean;
        isValueText: Boolean;
        isValueTime: Boolean;
        IsParamEditable: Boolean;

    trigger OnAfterGetRecord()
    begin
        SetFieldVisibility();
        IsParamEditable := Rec.IsParamEditable();
    end;

    local procedure SetFieldVisibility()
    begin
        Rec.CalcFields("Parameter Type");
        isValueBigInteger := Rec."Parameter Type" = Rec.FieldNo("BigInteger Value");
        isValueBlob := Rec."Parameter Type" = Rec.FieldNo("Blob Value");
        isValueBoolean := Rec."Parameter Type" = Rec.FieldNo("Boolean Value");
        isValueCode := Rec."Parameter Type" = Rec.FieldNo("Code Value");
        isValueDate := Rec."Parameter Type" = Rec.FieldNo("Date Value");
        isValueDateFormula := Rec."Parameter Type" = Rec.FieldNo("DateFormula Value");
        isValueDateTime := Rec."Parameter Type" = Rec.FieldNo("DateTime Value");
        isValueDecimal := Rec."Parameter Type" = Rec.FieldNo("Decimal Value");
        isValueDuration := Rec."Parameter Type" = Rec.FieldNo("Duration Value");
        isValueGuid := Rec."Parameter Type" = Rec.FieldNo("Guid Value");
        isValueInteger := Rec."Parameter Type" = Rec.FieldNo("Integer Value");
        isValueMedia := Rec."Parameter Type" = Rec.FieldNo("Media Value");
        isValueMediaSet := Rec."Parameter Type" = Rec.FieldNo("MediaSet Value");
        isValueText := Rec."Parameter Type" = Rec.FieldNo("Text Value");
        isValueTime := Rec."Parameter Type" = Rec.FieldNo("Time Value");
    end;
}