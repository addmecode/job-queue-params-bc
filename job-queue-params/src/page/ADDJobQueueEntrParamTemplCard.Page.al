namespace Addmecode.JobQueueParams;

page 50122 "ADD_JobQueueEntrParamTemplCard"
{
    ApplicationArea = All;
    Caption = 'Job Queue Entry Parameter Template Card';
    DeleteAllowed = false;
    InsertAllowed = false;
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
                field("Parameter Type"; Rec.GetTemplParameterTypeCaption())
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
                ShowCaption = false;
                group(ParameterDescription)
                {
                    Caption = 'Parameter Description';
                    Editable = true;
                    ShowCaption = true;

                    field("Parameter Description"; Rec."Parameter Description")
                    {
                        ShowCaption = false;
                        ToolTip = 'Specifies the value of the Parameter Description field.', Comment = '%';
                    }
                }
                group(ParameterValue)
                {
                    Caption = 'Parameter Value';
                    Editable = true;
                    ShowCaption = true;
                    group(BigIntegerValue)
                    {
                        ShowCaption = false;
                        Visible = isValueBigInteger;
                        field("BigInteger Value"; Rec."BigInteger Value")
                        {
                            ShowCaption = false;
                            ToolTip = 'Specifies the value of the BigInteger Value field.', Comment = '%';
                        }
                    }
                    group(BooleanValue)
                    {
                        ShowCaption = false;
                        Visible = isValueBoolean;
                        field("Boolean Value"; Rec."Boolean Value")
                        {
                            ShowCaption = false;
                            ToolTip = 'Specifies the value of the Boolean Value field.', Comment = '%';
                        }
                    }
                    group(CodeValue)
                    {
                        ShowCaption = false;
                        Visible = isValueCode;
                        field("Code Value"; Rec."Code Value")
                        {
                            ShowCaption = false;
                            ToolTip = 'Specifies the value of the Code Value field.', Comment = '%';
                        }
                    }
                    group(DateValue)
                    {
                        ShowCaption = false;
                        Visible = isValueDate;
                        field("Date Value"; Rec."Date Value")
                        {
                            ShowCaption = false;
                            ToolTip = 'Specifies the value of the Date Value field.', Comment = '%';
                        }
                    }
                    group(DateFormulaValue)
                    {
                        ShowCaption = false;
                        Visible = isValueDateFormula;
                        field("DateFormula Value"; Rec."DateFormula Value")
                        {
                            ShowCaption = false;
                            ToolTip = 'Specifies the value of the DateFormula Value field.', Comment = '%';
                        }
                    }
                    group(DateTimeValue)
                    {
                        ShowCaption = false;
                        Visible = isValueDateTime;
                        field("DateTime Value"; Rec."DateTime Value")
                        {
                            ShowCaption = false;
                            ToolTip = 'Specifies the value of the DateTime Value field.', Comment = '%';
                        }
                    }
                    group(DecimalValue)
                    {
                        ShowCaption = false;
                        Visible = isValueDecimal;
                        field("Decimal Value"; Rec."Decimal Value")
                        {
                            ShowCaption = false;
                            ToolTip = 'Specifies the value of the Decimal Value field.', Comment = '%';
                        }
                    }
                    group(DurationValue)
                    {
                        ShowCaption = false;
                        Visible = isValueDuration;
                        field("Duration Value"; Rec."Duration Value")
                        {
                            ShowCaption = false;
                            ToolTip = 'Specifies the value of the Duration Value field.', Comment = '%';
                        }
                    }
                    group(GuidValue)
                    {
                        ShowCaption = false;
                        Visible = isValueGuid;
                        field("Guid Value"; Rec."Guid Value")
                        {
                            ShowCaption = false;
                            ToolTip = 'Specifies the value of the Guid Value field.', Comment = '%';
                        }
                    }
                    group(IntegerValue)
                    {
                        ShowCaption = false;
                        Visible = isValueInteger;
                        field("Integer Value"; Rec."Integer Value")
                        {
                            ShowCaption = false;
                            ToolTip = 'Specifies the value of the Integer Value field.', Comment = '%';
                        }
                    }
                    group(TextValue)
                    {
                        ShowCaption = false;
                        Visible = isValueText;
                        field("Text Value"; Rec."Text Value")
                        {
                            ShowCaption = false;
                            ToolTip = 'Specifies the value of the Text Value field.', Comment = '%';
                        }
                    }
                    group(TimeValue)
                    {
                        ShowCaption = false;
                        Visible = isValueTime;
                        field("Time Value"; Rec."Time Value")
                        {
                            ShowCaption = false;
                            ToolTip = 'Specifies the value of the Time Value field.', Comment = '%';
                        }
                    }
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetFieldVisibility();
    end;

    var
        isValueBigInteger: Boolean;
        isValueBoolean: Boolean;
        isValueCode: Boolean;
        isValueDate: Boolean;
        isValueDateFormula: Boolean;
        isValueDateTime: Boolean;
        isValueDecimal: Boolean;
        isValueDuration: Boolean;
        isValueGuid: Boolean;
        isValueInteger: Boolean;
        isValueText: Boolean;
        isValueTime: Boolean;

    local procedure SetFieldVisibility()
    begin
        isValueBigInteger := Rec."Parameter Type" = Rec.FieldNo("BigInteger Value");
        isValueBoolean := Rec."Parameter Type" = Rec.FieldNo("Boolean Value");
        isValueCode := Rec."Parameter Type" = Rec.FieldNo("Code Value");
        isValueDate := Rec."Parameter Type" = Rec.FieldNo("Date Value");
        isValueDateFormula := Rec."Parameter Type" = Rec.FieldNo("DateFormula Value");
        isValueDateTime := Rec."Parameter Type" = Rec.FieldNo("DateTime Value");
        isValueDecimal := Rec."Parameter Type" = Rec.FieldNo("Decimal Value");
        isValueDuration := Rec."Parameter Type" = Rec.FieldNo("Duration Value");
        isValueGuid := Rec."Parameter Type" = Rec.FieldNo("Guid Value");
        isValueInteger := Rec."Parameter Type" = Rec.FieldNo("Integer Value");
        isValueText := Rec."Parameter Type" = Rec.FieldNo("Text Value");
        isValueTime := Rec."Parameter Type" = Rec.FieldNo("Time Value");
    end;
}
