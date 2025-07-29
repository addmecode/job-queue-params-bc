codeunit 50140 "ADD_JobQueueParamsTest"
{
    // [FEATURE] [JobQueueParamsTest]
    Subtype = Test;
    TestPermissions = Disabled;

    trigger OnRun()
    begin
        IsInitialized := false;
    end;

    local procedure Initialize()
    var
        JqeParamTempl: Record "ADD_JobQueueEntryParamTemplate";
        JqeParam: Record "ADD_JobQueueEntryParameter";
        JobQueueEntry: Record "Job Queue Entry";
    begin
        JqeParamTempl.DeleteAll(false);
        JqeParam.DeleteAll(false);

        JobQueueEntry.SetRange("Object ID to Run", GetTestObjectId());
        JobQueueEntry.DeleteAll(false);
    end;

    [Test]
    procedure DeleteAllJobQueueEntryParams_DeletesAllParameters()
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueEntryParameter: Record "ADD_JobQueueEntryParameter";
        JobQueueEntryParameterMgt: Codeunit "ADD_JobQueueEntryParameterMgt";
        JobQueueEntryId: Guid;
        ParameterCount: Integer;
    begin
        // [SCENARIO] DeleteAllJobQueueEntryParams should delete all parameters associated with a Job Queue Entry
        Initialize();

        // [GIVEN] A Job Queue Entry with parameters
        JobQueueEntryId := CreateJobQueueEntryWithParameters(JobQueueEntry, 3);

        // [GIVEN] Verify parameters exist before deletion
        JobQueueEntryParameter.SetRange("Job Queue Entry ID", JobQueueEntryId);
        ParameterCount := JobQueueEntryParameter.Count();
        Assert.AreEqual(3, ParameterCount, 'Parameters should exist before deletion');

        // [WHEN] DeleteAllJobQueueEntryParams is called
        JobQueueEntryParameterMgt.DeleteAllJobQueueEntryParams(JobQueueEntry);

        // [THEN] All parameters should be deleted
        JobQueueEntryParameter.SetRange("Job Queue Entry ID", JobQueueEntryId);
        ParameterCount := JobQueueEntryParameter.Count();
        Assert.AreEqual(0, ParameterCount, 'All parameters should be deleted');
    end;

    [Test]
    procedure DeleteAllJobQueueEntryParams_NoParametersExist()
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueEntryParameter: Record "ADD_JobQueueEntryParameter";
        JobQueueEntryParameterMgt: Codeunit "ADD_JobQueueEntryParameterMgt";
        JobQueueEntryId: Guid;
    begin
        // [SCENARIO] DeleteAllJobQueueEntryParams should handle the case when no parameters exist gracefully
        Initialize();

        // [GIVEN] A Job Queue Entry without parameters
        JobQueueEntryId := CreateJobQueueEntryWithoutParameters(JobQueueEntry);

        // [WHEN] DeleteAllJobQueueEntryParams is called
        JobQueueEntryParameterMgt.DeleteAllJobQueueEntryParams(JobQueueEntry);

        // [THEN] No error should occur and parameter count should remain 0
        JobQueueEntryParameter.SetRange("Job Queue Entry ID", JobQueueEntry.ID);
        Assert.AreEqual(0, JobQueueEntryParameter.Count(), 'Parameter count should remain 0 when no parameters exist');
    end;

    [Test]
    procedure CreateAllJobQueueEntryParamsFromTempl_CreatesParameterWithDefaultValue()
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueEntryParameterMgt: Codeunit "ADD_JobQueueEntryParameterMgt";
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntryParameter: Record "ADD_JobQueueEntryParameter";
        JobQueueEntryId: Guid;
        TemplFieldRef: FieldRef;
        ParamFieldRef: FieldRef;
        ParamTypes: List of [Integer];
    begin
        // [SCENARIO] CreateAllJobQueueEntryParamsFromTempl with SetDefValue should create parameters with the default value from the templates
        Initialize();

        // [GIVEN] A Job Queue Entry and a parameter templates
        JobQueueEntryId := CreateJobQueueEntryWithoutParameters(JobQueueEntry);
        CreateJqeParamTemplWithAllPossParamType(JobQueueEntry, JobQueueEntryParamTemplate, ParamTypes);

        // [WHEN] CreateAllJobQueueEntryParamsFromTempl is called with SetDefValue = true
        JobQueueEntryParameterMgt.CreateAllJobQueueEntryParamsFromTempl(JobQueueEntry, true);

        // [THEN] The Parameters number should match the number of templates
        JobQueueEntryParameter.SetRange("Job Queue Entry ID", JobQueueEntry.ID);
        Assert.AreEqual(ParamTypes.Count(), JobQueueEntryParameter.Count(), 'Number of parameters created should match the number of templates');

        // [THEN] Parameters should have the default value from the templates
        JobQueueEntryParameter.FindSet();
        repeat
            JobQueueEntryParamTemplate.Get(JobQueueEntry."Object Type to Run", JobQueueEntry."Object ID to Run", JobQueueEntryParameter."Parameter Name");
            Assert.AreEqual(JobQueueEntryParameterMgt.GetDefaultParameterValue(JobQueueEntryParamTemplate), JobQueueEntryParameterMgt.GetParameterValue(JobQueueEntryParameter), 'A parameter should be created with the default value from the template');
        until JobQueueEntryParameter.Next() = 0;
    end;

    [Test]
    procedure CreateAllJobQueueEntryParamsFromTempl_CreatesParameterWithoutDefaultValue()
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueEntryParameterMgt: Codeunit "ADD_JobQueueEntryParameterMgt";
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntryParameter: Record "ADD_JobQueueEntryParameter";
        JobQueueEntryId: Guid;
        TemplFieldRef: FieldRef;
        ParamFieldRef: FieldRef;
        ParamTypes: List of [Integer];
    begin
        // [SCENARIO] CreateAllJobQueueEntryParamsFromTempl with SetDefValue = false should create parameters without the default value from the templates
        Initialize();

        // [GIVEN] A Job Queue Entry and a parameter templates
        JobQueueEntryId := CreateJobQueueEntryWithoutParameters(JobQueueEntry);
        CreateJqeParamTemplWithAllPossParamType(JobQueueEntry, JobQueueEntryParamTemplate, ParamTypes);

        // [WHEN] CreateAllJobQueueEntryParamsFromTempl is called with SetDefValue = false
        JobQueueEntryParameterMgt.CreateAllJobQueueEntryParamsFromTempl(JobQueueEntry, false);

        // [THEN] The Parameters number should match the number of templates
        JobQueueEntryParameter.SetRange("Job Queue Entry ID", JobQueueEntry.ID);
        Assert.AreEqual(ParamTypes.Count(), JobQueueEntryParameter.Count(), 'Number of parameters created should match the number of templates');

        // [THEN] Parameters should not have the default value from the templates
        JobQueueEntryParameter.FindSet();
        repeat
            JobQueueEntryParamTemplate.Get(JobQueueEntry."Object Type to Run", JobQueueEntry."Object ID to Run", JobQueueEntryParameter."Parameter Name");
            Assert.AreNotEqual(JobQueueEntryParameterMgt.GetDefaultParameterValue(JobQueueEntryParamTemplate), JobQueueEntryParameterMgt.GetParameterValue(JobQueueEntryParameter), 'A parameter should be created without the default value from the template');
        until JobQueueEntryParameter.Next() = 0;
    end;

    [Test]
    procedure CreateAllJobQueueEntryParamsFromTempl_EmptyObjectIdToRun()
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueEntryParameterMgt: Codeunit "ADD_JobQueueEntryParameterMgt";
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntryParameter: Record "ADD_JobQueueEntryParameter";
        JobQueueEntryId: Guid;
        ParamTypes: List of [Integer];
    begin
        // [SCENARIO] CreateAllJobQueueEntryParamsFromTempl with Object ID to Run = 0 should not create any parameters
        Initialize();

        // [GIVEN] A Job Queue Entry with Object ID to Run = 0 and a parameter templates
        JobQueueEntryId := CreateJobQueueEntryWithoutParameters(JobQueueEntry);
        CreateJqeParamTemplWithAllPossParamType(JobQueueEntry, JobQueueEntryParamTemplate, ParamTypes);
        JobQueueEntry."Object ID to Run" := 0;
        JobQueueEntry.Modify(False);

        // [WHEN] CreateAllJobQueueEntryParamsFromTempl is called
        JobQueueEntryParameterMgt.CreateAllJobQueueEntryParamsFromTempl(JobQueueEntry, false);

        // [THEN] The Parameters number should be 0
        JobQueueEntryParameter.SetRange("Job Queue Entry ID", JobQueueEntry.ID);
        Assert.AreEqual(0, JobQueueEntryParameter.Count(), 'No parameters should be created when Object ID to Run is 0');
    end;

    [Test]
    procedure CreateAllJobQueueEntryParamsFromTempl_NoTemplatesExist()
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueEntryParameterMgt: Codeunit "ADD_JobQueueEntryParameterMgt";
        JobQueueEntryParameter: Record "ADD_JobQueueEntryParameter";
        JobQueueEntryId: Guid;
    begin
        // [SCENARIO] CreateAllJobQueueEntryParamsFromTempl should not create parameters when no templates exist
        Initialize();

        // [GIVEN] A Job Queue Entry without any matching parameter templates
        JobQueueEntryId := CreateJobQueueEntryWithoutParameters(JobQueueEntry);

        // [WHEN] CreateAllJobQueueEntryParamsFromTempl is called
        JobQueueEntryParameterMgt.CreateAllJobQueueEntryParamsFromTempl(JobQueueEntry, true);

        // [THEN] No parameters should be created
        JobQueueEntryParameter.SetRange("Job Queue Entry ID", JobQueueEntry.ID);
        Assert.AreEqual(0, JobQueueEntryParameter.Count(), 'No parameters should be created when no templates exist');
    end;

    [Test]
    procedure OverwriteAllJobQueueEntryParamsFromTempl_DoNotOverwriteExistingParameters()
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueEntryParameterMgt: Codeunit "ADD_JobQueueEntryParameterMgt";
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntryParameter: Record "ADD_JobQueueEntryParameter";
        JobQueueEntryId: Guid;
        ParamTypes: List of [Integer];
    begin
        // [SCENARIO] OverwriteAllJobQueueEntryParamsFromTempl should not overwrite existing parameters if the Object ID and Type match
        Initialize();

        // [GIVEN] A Job Queue Entry with existing parameters and a parameter templates
        JobQueueEntryId := CreateJobQueueEntryWithoutParameters(JobQueueEntry);
        CreateJqeParamTemplWithGivenValue(JobQueueEntry, JobQueueEntryParamTemplate, 'Param1', JobQueueEntryParamTemplate.FieldNo("Text Value"), 'TEST 1');
        JobQueueEntryParameterMgt.CreateAllJobQueueEntryParamsFromTempl(JobQueueEntry, true);

        // [GIVEN] A new Job Queue Entry Parameter Template with a different default value
        JobQueueEntryParamTemplate.Reset();
        JobQueueEntryParamTemplate.DeleteAll(False);
        CreateJqeParamTemplWithGivenValue(JobQueueEntry, JobQueueEntryParamTemplate, 'Param1', JobQueueEntryParamTemplate.FieldNo("Text Value"), 'TEST 2');

        // [WHEN] OverwriteAllJobQueueEntryParamsFromTempl is called with the same Job Queue Entry
        JobQueueEntryParameterMgt.OverwriteAllJobQueueEntryParamsFromTempl(JobQueueEntry, JobQueueEntry, true);

        // [THEN] No parameters should be deleted or inserted
        JobQueueEntryParameter.SetRange("Job Queue Entry ID", JobQueueEntry.ID);
        Assert.AreEqual(1, JobQueueEntryParameter.Count(), 'No parameters should be deleted or inserted when Object ID and Type match');

        // [THEN] The parameter should retain the original value
        JobQueueEntryParameter.FindSet();
        repeat
            JobQueueEntryParamTemplate.Get(JobQueueEntry."Object Type to Run", JobQueueEntry."Object ID to Run", JobQueueEntryParameter."Parameter Name");
            Assert.AreNotEqual(JobQueueEntryParameterMgt.GetDefaultParameterValue(JobQueueEntryParamTemplate), JobQueueEntryParameterMgt.GetParameterValue(JobQueueEntryParameter), 'A parameter should retain the original value when Object ID and Type match');
        until JobQueueEntryParameter.Next() = 0;
    end;

    [Test]
    procedure OverwriteAllJobQueueEntryParamsFromTempl_OverwriteExistingParameters()
    var
        OldJobQueueEntry: Record "Job Queue Entry";
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueEntryParameterMgt: Codeunit "ADD_JobQueueEntryParameterMgt";
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntryParameter: Record "ADD_JobQueueEntryParameter";
        JobQueueEntryId: Guid;
        ParamTypes: List of [Integer];
    begin
        // [SCENARIO] OverwriteAllJobQueueEntryParamsFromTempl should overwrite existing parameters if the Object ID or Type is changed
        Initialize();

        // [GIVEN] A Job Queue Entry with existing parameters and a parameter templates
        JobQueueEntryId := CreateJobQueueEntryWithoutParameters(JobQueueEntry);
        CreateJqeParamTemplWithGivenValue(JobQueueEntry, JobQueueEntryParamTemplate, 'Param1', JobQueueEntryParamTemplate.FieldNo("Text Value"), 'TEST 1');
        JobQueueEntryParameterMgt.CreateAllJobQueueEntryParamsFromTempl(JobQueueEntry, true);

        // [GIVEN] A new Job Queue Entry with a different Object ID or Type
        OldJobQueueEntry := JobQueueEntry;
        JobQueueEntry."Object ID to Run" := GetSecondTestObjectId();
        JobQueueEntry.Modify(False);

        // [GIVEN] A new parameter template with a different default value
        JobQueueEntryParamTemplate.Reset();
        JobQueueEntryParamTemplate.DeleteAll(False);
        CreateJqeParamTemplWithGivenValue(JobQueueEntry, JobQueueEntryParamTemplate, 'Param1', JobQueueEntryParamTemplate.FieldNo("Text Value"), 'TEST 2');

        // [WHEN] OverwriteAllJobQueueEntryParamsFromTempl is called with the same Job Queue Entry
        JobQueueEntryParameterMgt.OverwriteAllJobQueueEntryParamsFromTempl(JobQueueEntry, OldJobQueueEntry, true);

        // [THEN] All existing parameters should be deleted
        JobQueueEntryParameter.SetRange("Job Queue Entry ID", JobQueueEntry.ID);
        Assert.AreEqual(1, JobQueueEntryParameter.Count(), 'Only one parameter should exist after overwriting');

        // [THEN] The parameter should be overwritten with the new default value
        JobQueueEntryParameter.FindSet();
        repeat
            JobQueueEntryParamTemplate.Get(JobQueueEntry."Object Type to Run", JobQueueEntry."Object ID to Run", JobQueueEntryParameter."Parameter Name");
            Assert.AreEqual(JobQueueEntryParameterMgt.GetDefaultParameterValue(JobQueueEntryParamTemplate), JobQueueEntryParameterMgt.GetParameterValue(JobQueueEntryParameter), 'A parameter should be overwritten with the new default value when Object ID or Type is changed');
        until JobQueueEntryParameter.Next() = 0;
    end;

    local procedure CreateJobQueueEntryWithParameters(var JobQueueEntry: Record "Job Queue Entry"; ParameterCount: Integer): Guid
    var
        JobQueueEntryParameter: Record "ADD_JobQueueEntryParameter";
        i: Integer;
    begin
        CreateJobQueueEntryWithoutParameters(JobQueueEntry);
        for i := 1 to ParameterCount do begin
            JobQueueEntryParameter.Init();
            JobQueueEntryParameter."Job Queue Entry ID" := JobQueueEntry.ID;
            JobQueueEntryParameter."Parameter Name" := 'TestParam' + Format(i);
            JobQueueEntryParameter.Insert();
        end;
        exit(JobQueueEntry.ID);
    end;

    local procedure CreateJobQueueEntryWithoutParameters(var JobQueueEntry: Record "Job Queue Entry"): Guid
    begin
        JobQueueEntry.Init();
        JobQueueEntry.ID := CreateGuid();
        JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
        JobQueueEntry."Object ID to Run" := GetTestObjectId();
        JobQueueEntry.Insert();
        exit(JobQueueEntry.ID);
    end;

    local procedure GetTestObjectId(): Integer
    begin
        exit(50100);
    end;

    local procedure GetSecondTestObjectId(): Integer
    begin
        exit(11);
    end;

    local procedure CreateJqeParamTempl(var JobQueueEntry: Record "Job Queue Entry"; var JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate"; NewParamName: Text[100]; ParamType: Integer)
    var
        Any: Codeunit Any;
        DateForm: Text;
        ParamValue: Variant;
    begin
        case ParamType of
            JobQueueEntryParamTemplate.FieldNo("BigInteger Value"):
                ParamValue := Any.IntegerInRange(1, 1000000);
            JobQueueEntryParamTemplate.FieldNo("Boolean Value"):
                ParamValue := true;
            JobQueueEntryParamTemplate.FieldNo("Code Value"):
                ParamValue := 'TEST CODE';
            JobQueueEntryParamTemplate.FieldNo("Date Value"):
                ParamValue := Today;
            JobQueueEntryParamTemplate.FieldNo("DateFormula Value"):
                begin
                    DateForm := 'CM+' + Format(Any.IntegerInRange(1, 31)) + 'D';
                    ParamValue := DateForm;
                end;
            JobQueueEntryParamTemplate.FieldNo("DateTime Value"):
                ParamValue := CurrentDateTime;
            JobQueueEntryParamTemplate.FieldNo("Decimal Value"):
                ParamValue := Any.DecimalInRange(10, 2);
            JobQueueEntryParamTemplate.FieldNo("Duration Value"):
                ParamValue := Any.IntegerInRange(1, 100);
            JobQueueEntryParamTemplate.FieldNo("Guid Value"):
                ParamValue := CreateGuid();
            JobQueueEntryParamTemplate.FieldNo("Integer Value"):
                ParamValue := Any.IntegerInRange(1, 1000);
            JobQueueEntryParamTemplate.FieldNo("Text Value"):
                ParamValue := 'Sample Text';
            JobQueueEntryParamTemplate.FieldNo("Time Value"):
                ParamValue := DT2Time(CurrentDateTime);
        end;
        CreateJqeParamTemplWithGivenValue(JobQueueEntry, JobQueueEntryParamTemplate, NewParamName, ParamType, ParamValue);
    end;

    local procedure CreateJqeParamTemplWithGivenValue(var JobQueueEntry: Record "Job Queue Entry"; var JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate"; NewParamName: Text[100]; ParamType: Integer; ParamValue: Variant)
    var
        Any: Codeunit Any;
        DateForm: Text;
    begin
        JobQueueEntryParamTemplate."Object ID" := JobQueueEntry."Object ID to Run";
        JobQueueEntryParamTemplate."Object Type" := JobQueueEntry."Object Type to Run";
        JobQueueEntryParamTemplate."Parameter Name" := NewParamName;
        JobQueueEntryParamTemplate."Parameter Type" := ParamType;
        case ParamType of
            JobQueueEntryParamTemplate.FieldNo("BigInteger Value"):
                JobQueueEntryParamTemplate."BigInteger Value" := ParamValue;
            JobQueueEntryParamTemplate.FieldNo("Boolean Value"):
                JobQueueEntryParamTemplate."Boolean Value" := ParamValue;
            JobQueueEntryParamTemplate.FieldNo("Code Value"):
                JobQueueEntryParamTemplate."Code Value" := ParamValue;
            JobQueueEntryParamTemplate.FieldNo("Date Value"):
                JobQueueEntryParamTemplate."Date Value" := ParamValue;
            JobQueueEntryParamTemplate.FieldNo("DateFormula Value"):
                Evaluate(JobQueueEntryParamTemplate."DateFormula Value", ParamValue);
            JobQueueEntryParamTemplate.FieldNo("DateTime Value"):
                JobQueueEntryParamTemplate."DateTime Value" := ParamValue;
            JobQueueEntryParamTemplate.FieldNo("Decimal Value"):
                JobQueueEntryParamTemplate."Decimal Value" := ParamValue;
            JobQueueEntryParamTemplate.FieldNo("Duration Value"):
                JobQueueEntryParamTemplate."Duration Value" := ParamValue;
            JobQueueEntryParamTemplate.FieldNo("Guid Value"):
                JobQueueEntryParamTemplate."Guid Value" := ParamValue;
            JobQueueEntryParamTemplate.FieldNo("Integer Value"):
                JobQueueEntryParamTemplate."Integer Value" := ParamValue;
            JobQueueEntryParamTemplate.FieldNo("Text Value"):
                JobQueueEntryParamTemplate."Text Value" := ParamValue;
            JobQueueEntryParamTemplate.FieldNo("Time Value"):
                JobQueueEntryParamTemplate."Time Value" := ParamValue;
        end;
        JobQueueEntryParamTemplate.Insert();
    end;

    local procedure CreateParamTypeIntList(var ParamTypes: List of [Integer])
    var
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
    begin
        ParamTypes.Add(JobQueueEntryParamTemplate.FieldNo("BigInteger Value"));
        ParamTypes.Add(JobQueueEntryParamTemplate.FieldNo("Boolean Value"));
        ParamTypes.Add(JobQueueEntryParamTemplate.FieldNo("Code Value"));
        ParamTypes.Add(JobQueueEntryParamTemplate.FieldNo("Date Value"));
        ParamTypes.Add(JobQueueEntryParamTemplate.FieldNo("DateFormula Value"));
        ParamTypes.Add(JobQueueEntryParamTemplate.FieldNo("DateTime Value"));
        ParamTypes.Add(JobQueueEntryParamTemplate.FieldNo("Decimal Value"));
        ParamTypes.Add(JobQueueEntryParamTemplate.FieldNo("Duration Value"));
        ParamTypes.Add(JobQueueEntryParamTemplate.FieldNo("Guid Value"));
        ParamTypes.Add(JobQueueEntryParamTemplate.FieldNo("Integer Value"));
        ParamTypes.Add(JobQueueEntryParamTemplate.FieldNo("Text Value"));
        ParamTypes.Add(JobQueueEntryParamTemplate.FieldNo("Time Value"));
    end;

    local procedure CreateJqeParamTemplWithAllPossParamType(var JobQueueEntry: Record "Job Queue Entry"; var JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate"; var ParamTypes: List of [Integer])
    var
        TemplCounter: Integer;
        NewParamName: Text[100];
    begin
        CreateParamTypeIntList(ParamTypes);
        for TemplCounter := 1 to ParamTypes.Count() do begin
            NewParamName := 'TestParameter' + Format(TemplCounter);
            CreateJqeParamTempl(JobQueueEntry, JobQueueEntryParamTemplate, NewParamName, ParamTypes.Get(TemplCounter));
        end;
    end;

    // local procedure GetJqeParamTemplParamValueFieldRef(var JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate"; var TemplFieldRef: FieldRef)
    // var
    //     RecRefTempl: RecordRef;
    // begin
    //     RecRefTempl.GetTable(JobQueueEntryParamTemplate);
    //     TemplFieldRef := RecRefTempl.Field(JobQueueEntryParamTemplate."Parameter Type");
    // end;

    // local procedure GetJqeParamParamValueFieldRef(var JobQueueEntryParameter: Record "ADD_JobQueueEntryParameter"; var ParamFieldRef: FieldRef)
    // var
    //     RecRefParam: RecordRef;
    // begin
    //     RecRefParam.GetTable(JobQueueEntryParameter);
    //     ParamFieldRef := RecRefParam.Field(JobQueueEntryParameter."Parameter Type");
    // end;


    var
        Assert: Codeunit "Library Assert";
        IsInitialized: Boolean;
}