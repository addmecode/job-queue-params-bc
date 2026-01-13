namespace Addmecode.JobQueueParams;

page 50107 "AMC Job Queue Param Card"
{
    ApplicationArea = All;
    Caption = 'Job Queue Entry Parameter Card';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "AMC Job Queue Entry Parameter";

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
                    Caption = 'Parameter Type';
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
                Editable = IsParamEditable;
                ShowCaption = false;
                group(ParameterDescription)
                {
                    Caption = 'Parameter Description';
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
                    ShowCaption = true;
                    group(BigIntegerValue)
                    {
                        ShowCaption = false;
                        Visible = IsValueBigInteger;
                        field("BigInteger Value"; Rec."BigInteger Value")
                        {
                            ShowCaption = false;
                            ToolTip = 'Specifies the value of the BigInteger Value field.', Comment = '%';
                        }
                    }
                    group(BooleanValue)
                    {
                        ShowCaption = false;
                        Visible = IsValueBoolean;
                        field("Boolean Value"; Rec."Boolean Value")
                        {
                            ShowCaption = false;
                            ToolTip = 'Specifies the value of the Boolean Value field.', Comment = '%';
                        }
                    }
                    group(CodeValue)
                    {
                        ShowCaption = false;
                        Visible = IsValueCode;
                        field("Code Value"; Rec."Code Value")
                        {
                            ShowCaption = false;
                            ToolTip = 'Specifies the value of the Code Value field.', Comment = '%';
                        }
                    }
                    group(DateValue)
                    {
                        ShowCaption = false;
                        Visible = IsValueDate;
                        field("Date Value"; Rec."Date Value")
                        {
                            ShowCaption = false;
                            ToolTip = 'Specifies the value of the Date Value field.', Comment = '%';
                        }
                    }
                    group(DateFormulaValue)
                    {
                        ShowCaption = false;
                        Visible = IsValueDateFormula;
                        field("DateFormula Value"; Rec."DateFormula Value")
                        {
                            ShowCaption = false;
                            ToolTip = 'Specifies the value of the DateFormula Value field.', Comment = '%';
                        }
                    }
                    group(DateTimeValue)
                    {
                        ShowCaption = false;
                        Visible = IsValueDateTime;
                        field("DateTime Value"; Rec."DateTime Value")
                        {
                            ShowCaption = false;
                            ToolTip = 'Specifies the value of the DateTime Value field.', Comment = '%';
                        }
                    }
                    group(DecimalValue)
                    {
                        ShowCaption = false;
                        Visible = IsValueDecimal;
                        field("Decimal Value"; Rec."Decimal Value")
                        {
                            ShowCaption = false;
                            ToolTip = 'Specifies the value of the Decimal Value field.', Comment = '%';
                        }
                    }
                    group(DurationValue)
                    {
                        ShowCaption = false;
                        Visible = IsValueDuration;
                        field("Duration Value"; Rec."Duration Value")
                        {
                            ShowCaption = false;
                            ToolTip = 'Specifies the value of the Duration Value field.', Comment = '%';
                        }
                    }
                    group(GuidValue)
                    {
                        ShowCaption = false;
                        Visible = IsValueGuid;
                        field("Guid Value"; Rec."Guid Value")
                        {
                            ShowCaption = false;
                            ToolTip = 'Specifies the value of the Guid Value field.', Comment = '%';
                        }
                    }
                    group(IntegerValue)
                    {
                        ShowCaption = false;
                        Visible = IsValueInteger;
                        field("Integer Value"; Rec."Integer Value")
                        {
                            ShowCaption = false;
                            ToolTip = 'Specifies the value of the Integer Value field.', Comment = '%';
                        }
                    }
                    group(TextValue)
                    {
                        ShowCaption = false;
                        Visible = IsValueText;
                        field("Text Value"; Rec."Text Value")
                        {
                            ShowCaption = false;
                            ToolTip = 'Specifies the value of the Text Value field.', Comment = '%';
                        }
                    }
                    group(TimeValue)
                    {
                        ShowCaption = false;
                        Visible = IsValueTime;
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
        IsParamEditable := Rec.IsParamEditable();
    end;

    var
        IsParamEditable: Boolean;
        IsValueBigInteger: Boolean;
        IsValueBoolean: Boolean;
        IsValueCode: Boolean;
        IsValueDate: Boolean;
        IsValueDateFormula: Boolean;
        IsValueDateTime: Boolean;
        IsValueDecimal: Boolean;
        IsValueDuration: Boolean;
        IsValueGuid: Boolean;
        IsValueInteger: Boolean;
        IsValueText: Boolean;
        IsValueTime: Boolean;

    local procedure SetFieldVisibility()
    begin
        Rec.CalcFields("Parameter Type");
        IsValueBigInteger := Rec."Parameter Type" = Rec.FieldNo("BigInteger Value");
        IsValueBoolean := Rec."Parameter Type" = Rec.FieldNo("Boolean Value");
        IsValueCode := Rec."Parameter Type" = Rec.FieldNo("Code Value");
        IsValueDate := Rec."Parameter Type" = Rec.FieldNo("Date Value");
        IsValueDateFormula := Rec."Parameter Type" = Rec.FieldNo("DateFormula Value");
        IsValueDateTime := Rec."Parameter Type" = Rec.FieldNo("DateTime Value");
        IsValueDecimal := Rec."Parameter Type" = Rec.FieldNo("Decimal Value");
        IsValueDuration := Rec."Parameter Type" = Rec.FieldNo("Duration Value");
        IsValueGuid := Rec."Parameter Type" = Rec.FieldNo("Guid Value");
        IsValueInteger := Rec."Parameter Type" = Rec.FieldNo("Integer Value");
        IsValueText := Rec."Parameter Type" = Rec.FieldNo("Text Value");
        IsValueTime := Rec."Parameter Type" = Rec.FieldNo("Time Value");
    end;
}
