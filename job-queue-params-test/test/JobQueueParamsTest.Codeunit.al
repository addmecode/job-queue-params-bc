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
    procedure CreateJobQueEntrParamTemplIsNotPossibleFromListPage()
    var
        JobQueueEntrParamTemplates: TestPage ADD_JobQueueEntrParamTemplates;
    begin
        // [SCENARIO] Creating Job Queue Entry Parameter Template from List Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template List Page
        JobQueueEntrParamTemplates.OpenView();

        // [WHEN] Attempting to create a new record on the list page
        // [THEN] Creating a Job Queue Entry Parameter Template from the List Page should not be possible
        asserterror JobQueueEntrParamTemplates.New();
        Assert.ExpectedErrorCode('DB:ClientInsertDenied');

        JobQueueEntrParamTemplates.Close();
    end;

    [Test]
    procedure ModifyJobQueEntrParamTemplIsNotPossibleFromListPage()
    var
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntrParamTemplates: TestPage ADD_JobQueueEntrParamTemplates;
    begin
        // [SCENARIO] Modifying Job Queue Entry Parameter Template from List Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template
        CreateSampleTextJqeParamTempl(JobQueueEntryParamTemplate);

        // [GIVEN] A Job Queue Entry Parameter Template List Page opened with the created template
        JobQueueEntrParamTemplates.OpenEdit();
        JobQueueEntrParamTemplates.GoToRecord(JobQueueEntryParamTemplate);

        // [WHEN] Checking if the page is editable
        // [THEN] The Job Queue Entry Parameter Template List Page should not be editable
        Assert.IsFalse(JobQueueEntrParamTemplates.Editable(), 'The list page should not be editable');

        JobQueueEntrParamTemplates.Close();
    end;

    [Test]
    procedure CreateJobQueEntrParamTemplIsNotPossibleFromCardPage()
    var
        JobQueueEntrParamTemplateCard: TestPage ADD_JobQueueEntrParamTemplCard;
    begin
        //TODO
        // [SCENARIO] Creating Job Queue Entry Parameter Template from Card Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template Card Page
        JobQueueEntrParamTemplateCard.OpenView();

        // [WHEN] Attempting to create a new record on the card page
        // [THEN] Creating a Job Queue Entry Parameter Template from the Card Page should not be possible
        asserterror JobQueueEntrParamTemplateCard.New();
        Assert.ExpectedErrorCode('DB:ClientInsertDenied');

        JobQueueEntrParamTemplateCard.Close();
    end;

    [Test]
    procedure ModifyJobQueEntrParamTemplDescIsPossibleFromCardPage()
    var
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntrParamTemplateCard: TestPage ADD_JobQueueEntrParamTemplCard;
    begin
        // [SCENARIO] Modifying Job Queue Entry Parameter Template Description from Card Page should be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template
        CreateSampleTextJqeParamTempl(JobQueueEntryParamTemplate);

        // [GIVEN] A Job Queue Entry Parameter Template Card Page opened with the created template
        JobQueueEntrParamTemplateCard.OpenEdit();
        JobQueueEntrParamTemplateCard.GoToRecord(JobQueueEntryParamTemplate);

        // [WHEN] Attempting to edit Parameter Description on the card page
        // [THEN] Modifying a Job Queue Entry Parameter Template Parameter Description from the Card Page should be possible
        Assert.IsTrue(JobQueueEntrParamTemplateCard."Parameter Description".Editable(), 'The Parameter Description on the card page should be editable');

        JobQueueEntrParamTemplateCard.Close();
    end;

    [Test]
    procedure ModifyJobQueEntrParamTemplValueIsPossibleFromCardPage()
    var
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntrParamTemplateCard: TestPage ADD_JobQueueEntrParamTemplCard;
    begin
        // [SCENARIO] Modifying Job Queue Entry Parameter Template Value from Card Page should be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template
        CreateSampleTextJqeParamTempl(JobQueueEntryParamTemplate);

        // [GIVEN] A Job Queue Entry Parameter Template Card Page opened with the created template
        JobQueueEntrParamTemplateCard.OpenEdit();
        JobQueueEntrParamTemplateCard.GoToRecord(JobQueueEntryParamTemplate);

        // [WHEN] Attempting to edit Parameter Value on the card page
        // [THEN] Modifying a Job Queue Entry Parameter Template Parameter Value from the Card Page should be possible
        //TODO: it shoould check each possible value type
        Assert.IsTrue(JobQueueEntrParamTemplateCard."Text Value".Editable(), 'The Text Value on the card page should be editable');

        JobQueueEntrParamTemplateCard.Close();
    end;

    [Test]
    procedure ModifyJobQueEntrParamTemplObjTypeIsNotPossibleFromCardPage()
    var
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntrParamTemplateCard: TestPage ADD_JobQueueEntrParamTemplCard;
    begin
        // [SCENARIO] Modifying Job Queue Entry Parameter Template Object Type from Card Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template
        CreateSampleTextJqeParamTempl(JobQueueEntryParamTemplate);

        // [GIVEN] A Job Queue Entry Parameter Template Card Page opened with the created template
        JobQueueEntrParamTemplateCard.OpenEdit();
        JobQueueEntrParamTemplateCard.GoToRecord(JobQueueEntryParamTemplate);

        // [WHEN] Attempting to edit Object Type on the card page
        // [THEN] Modifying a Job Queue Entry Parameter Template Object Type from the Card Page should not be possible
        Assert.IsFalse(JobQueueEntrParamTemplateCard."Object Type".Editable(), 'The Object Type on the card page should not be editable');

        JobQueueEntrParamTemplateCard.Close();
    end;

    [Test]
    procedure ModifyJobQueEntrParamTemplObjIDIsNotPossibleFromCardPage()
    var
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntrParamTemplateCard: TestPage ADD_JobQueueEntrParamTemplCard;
    begin
        // [SCENARIO] Modifying Job Queue Entry Parameter Template Object ID from Card Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template
        CreateSampleTextJqeParamTempl(JobQueueEntryParamTemplate);

        // [GIVEN] A Job Queue Entry Parameter Template Card Page opened with the created template
        JobQueueEntrParamTemplateCard.OpenEdit();
        JobQueueEntrParamTemplateCard.GoToRecord(JobQueueEntryParamTemplate);

        // [WHEN] Attempting to edit Object ID on the card page
        // [THEN] Modifying a Job Queue Entry Parameter Template Object ID from the Card Page should not be possible
        Assert.IsFalse(JobQueueEntrParamTemplateCard."Object ID".Editable(), 'The Object ID on the card page should not be editable');

        JobQueueEntrParamTemplateCard.Close();
    end;

    [Test]
    procedure ModifyJobQueEntrParamTemplParamNameIsNotPossibleFromCardPage()
    var
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntrParamTemplateCard: TestPage ADD_JobQueueEntrParamTemplCard;
    begin
        // [SCENARIO] Modifying Job Queue Entry Parameter Template Parameter Name from Card Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template
        CreateSampleTextJqeParamTempl(JobQueueEntryParamTemplate);

        // [GIVEN] A Job Queue Entry Parameter Template Card Page opened with the created template
        JobQueueEntrParamTemplateCard.OpenEdit();
        JobQueueEntrParamTemplateCard.GoToRecord(JobQueueEntryParamTemplate);

        // [WHEN] Attempting to edit Parameter Name on the card page
        // [THEN] Modifying a Job Queue Entry Parameter Template Parameter Name from the Card Page should not be possible
        Assert.IsFalse(JobQueueEntrParamTemplateCard."Parameter Name".Editable(), 'The Parameter Name on the card page should not be editable');

        JobQueueEntrParamTemplateCard.Close();
    end;

    [Test]
    procedure ModifyJobQueEntrParamTemplParamTypeIsNotPossibleFromCardPage()
    var
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntrParamTemplateCard: TestPage ADD_JobQueueEntrParamTemplCard;
    begin
        // [SCENARIO] Modifying Job Queue Entry Parameter Template Parameter Type from Card Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template
        CreateSampleTextJqeParamTempl(JobQueueEntryParamTemplate);

        // [GIVEN] A Job Queue Entry Parameter Template Card Page opened with the created template
        JobQueueEntrParamTemplateCard.OpenEdit();
        JobQueueEntrParamTemplateCard.GoToRecord(JobQueueEntryParamTemplate);

        // [WHEN] Attempting to edit Parameter Type on the card page
        // [THEN] Modifying a Job Queue Entry Parameter Template Parameter Type from the Card Page should not be possible
        Assert.IsFalse(JobQueueEntrParamTemplateCard."Parameter Type".Editable(), 'The Parameter Type on the card page should not be editable');

        JobQueueEntrParamTemplateCard.Close();
    end;

    [Test]
    procedure CreateJobQueEntrParamIsNotPossibleFromListPage()
    begin
        //TODO
        // [SCENARIO] Creating Job Queue Entry Parameter from List Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter List Page

        // [THEN] Creating a Job Queue Entry Parameter from the List Page should not be possible
    end;

    [Test]
    procedure ModifyJobQueEntrParamIsNotPossibleFromListPage()
    begin
        //TODO
        // [SCENARIO] Modifying Job Queue Entry Parameter from List Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter List Page

        // [THEN] Modifying a Job Queue Entry Parameter from the List Page should not be possible
    end;

    [Test]
    procedure CreateJobQueEntrParamIsNotPossibleFromCardPage()
    begin
        //TODO
        // [SCENARIO] Creating Job Queue Entry Parameter from Card Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Card Page

        // [THEN] Creating a Job Queue Entry Parameter from the Card Page should not be possible
    end;

    [Test]
    procedure ModifyJobQueEntrParamDescIsNotPossibleFromCardPage()
    begin
        //TODO
        // [SCENARIO] Modifying Job Queue Entry Parameter Description from Card Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Card Page

        // [THEN] Modifying a Job Queue Entry Parameter Description from the Card Page should not be possible
    end;

    [Test]
    procedure ModifyJobQueEntrParamValueIsPossibleFromCardPage()
    begin
        //TODO
        // [SCENARIO] Modifying Job Queue Entry Parameter Value from Card Page should be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Card Page

        // [THEN] Modifying a Job Queue Entry Parameter Value from the Card Page should be possible
    end;

    [Test]
    procedure ModifyJobQueEntrParamObjTypeIsNotPossibleFromCardPage()
    begin
        //TODO
        // [SCENARIO] Modifying Job Queue Entry Parameter Object Type from Card Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Card Page

        // [THEN] Modifying a Job Queue Entry Parameter Object Type from the Card Page should not be possible
    end;

    [Test]
    procedure ModifyJobQueEntrParamObjIDIsNotPossibleFromCardPage()
    begin
        //TODO
        // [SCENARIO] Modifying Job Queue Entry Parameter Object ID from Card Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Card Page

        // [THEN] Modifying a Job Queue Entry Parameter Object ID from the Card Page should not be possible
    end;

    [Test]
    procedure ModifyJobQueEntrParamParamNameIsNotPossibleFromCardPage()
    begin
        //TODO
        // [SCENARIO] Modifying Job Queue Entry Parameter Parameter Name from Card Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Card Page

        // [THEN] Modifying a Job Queue Entry Parameter Parameter Name from the Card Page should not be possible
    end;

    [Test]
    procedure ModifyJobQueEntrParamParamTypeIsNotPossibleFromCardPage()
    begin
        //TODO
        // [SCENARIO] Modifying Job Queue Entry Parameter Parameter Type from Card Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Card Page

        // [THEN] Modifying a Job Queue Entry Parameter Parameter Type from the Card Page should not be possible
    end;

    [Test]
    procedure JobQueEntrParamSubformPageIsVisibleOnJobQueEntryCardPage()
    begin
        //TODO
        // [SCENARIO] Job Queue Entry Parameter Subform Page should be visible on Job Queue Entry Card Page
        Initialize();

        // [GIVEN] A Job Queue Entry

        // [WHEN] Job Queue Entry Card Page is opened

        // [THEN] The Job Queue Entry Parameter Subform Page should be visible
    end;

    [Test]
    procedure JobQueEntrParamSubformPageDisplayOnlyParametersRelatedToTheJobQue()
    begin
        //TODO
        // [SCENARIO] Job Queue Entry Parameter Subform Page should display only parameters related to the Job Queue
        Initialize();

        // [GIVEN] A Job Queue Entry

        // [WHEN] Job Queue Entry Card Page is opened

        // [THEN] The Job Queue Entry Parameter Subform displays only parameters related to the Job Queue Entry
    end;

    [Test]
    procedure ModifyJobQueEntrParamIsNotPossibleFromSubformPage()
    begin
        //TODO
        // [SCENARIO] Modifying Job Queue Entry Parameter from Subform Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Subform Page

        // [THEN] Modifying a Job Queue Entry Parameter from the Subform Page should not be possible
    end;

    [Test]
    procedure CreateJobQueEntrParamIsNotPossibleFromSubformPage()
    begin
        //TODO
        // [SCENARIO] Creating Job Queue Entry Parameter from Subform Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Subform Page

        // [THEN] Creating a Job Queue Entry Parameter from the Subform Page should not be possible
    end;

    [Test]
    procedure JobQueEntryParamsAreCreatedWhenTemplExistsAndJobQueEntryIsCreated()
    begin
        // [SCENARIO] Job Queue Entry Parameters should be created when a Job Queue Entry is created with an existing template
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template exists

        // [WHEN] A Job Queue Entry is created with this template

        // [THEN] Job Queue Entry Parameters should be created
    end;

    [Test]
    procedure JobQueEntryParamsAreNotCreatedWhenTemplDoesNotExistAndJobQueEntryIsCreated()
    begin
        // [SCENARIO] Job Queue Entry Parameters should not be created when a Job Queue Entry is created without an existing template
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template does not exist

        // [WHEN] A Job Queue Entry is created with this template

        // [THEN] Job Queue Entry Parameters should not be created
    end;

    [Test]
    procedure JobQueEntryParamsAreDeletedWhenJobQueEntryIsDeleted()
    begin
        // [SCENARIO] Job Queue Entry Parameters should be deleted when a Job Queue Entry is deleted
        Initialize();
        // [GIVEN] A Job Queue Entry

        // [GIVEN] Job Queue Entry Parameters exist for this Job Queue Entry

        // [WHEN] The Job Queue Entry is deleted

        // [THEN] Job Queue Entry Parameters should be deleted
    end;

    [Test]
    procedure OverwriteJobQueEntryParamsWhenJobQueEntryObjIdIsChanged()
    begin
        // [SCENARIO] Job Queue Entry Parameters should be overwritten when the Object ID of a Job Queue Entry is changed   
        Initialize();
        // [GIVEN] A Job Queue Entry

        // [GIVEN] Job Queue Entry Parameters exist for this Job Queue Entry

        // [GIVEN] A Job Queue Entry Parameter Template exists for the new Object ID

        // [WHEN] The Object ID of the Job Queue Entry is changed

        // [THEN] Job Queue Entry Parameters should be overwritten with the ones for a new Object ID
    end;

    [Test]
    procedure OverwriteJobQueEntryParamsWhenJobQueEntryObjTypeIsChanged()
    begin
        // [SCENARIO] Job Queue Entry Parameters should be overwritten when the Object ID of a Job Queue Entry is changed   
        Initialize();
        // [GIVEN] A Job Queue Entry

        // [GIVEN] Job Queue Entry Parameters exist for this Job Queue Entry

        // [GIVEN] A Job Queue Entry Parameter Template exists for the new Object Type

        // [WHEN] The Object Type of the Job Queue Entry is changed

        // [THEN] Job Queue Entry Parameters should be overwritten with the ones for a new Object Type
    end;

    [Test]
    procedure ModifyJobQueueEntryParameterWhenJobQueueEntryIsOnHoldIsPossible()
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueEntryParameter: Record "ADD_JobQueueEntryParameter";
        JobQueueEntryParameterMgt: Codeunit "ADD_JobQueueEntryParameterMgt";
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntryId: Guid;
        ParamName: Text[100];
        ModParamValue: Text[100];
    begin
        // [SCENARIO] Modify Job Queue Entry Parameter should not throw an error if the Job Queue Entry is OnHold
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template and a Job Queue Entry with Status = OnHold and with parameters from this template
        ParamName := 'Test Param';
        JobQueueEntryId := CreateJobQueueEntryWithoutParameters(JobQueueEntry);
        CreateJqeParamTemplWithGivenValue(JobQueueEntry, JobQueueEntryParamTemplate, ParamName, JobQueueEntryParamTemplate.FieldNo("Text Value"), 'Test Value');
        JobQueueEntryParameterMgt.CreateAllJobQueueEntryParamsFromTempl(JobQueueEntry, true);
        JobQueueEntry.Status := JobQueueEntry.Status::"On Hold";
        JobQueueEntry.Modify(false);

        // [WHEN] Modify Job Queue Entry Parameter is called
        ModParamValue := 'Modified Value';
        JobQueueEntryParameter.Get(JobQueueEntryId, ParamName);
        JobQueueEntryParameter."Text Value" := 'Modified Value';
        JobQueueEntryParameter.Modify(True);

        // [THEN] The Job Queue Entry Parameter should be modified without error
        JobQueueEntryParameter.Get(JobQueueEntryId, ParamName);
        Assert.AreEqual(ModParamValue, JobQueueEntryParameter."Text Value", 'The Job Queue Entry Parameter should be modified successfully when the Job Queue Entry is On Hold');
    end;

    [Test]
    procedure ModifyJobQueueEntryParameterWhenJobQueueEntryIsNotOnHoldIsNotPossible()
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueEntryParameter: Record "ADD_JobQueueEntryParameter";
        JobQueueEntryParameterMgt: Codeunit "ADD_JobQueueEntryParameterMgt";
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntryId: Guid;
        ParamName: Text[100];
        ModParamValue: Text[100];
        StatusesToTest: List of [Integer];
        StatusIndex: Integer;
    begin
        // [SCENARIO] Modify Job Queue Entry Parameter should throw an error if the Job Queue Entry is not OnHold
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template and a Job Queue Entry with parameters from this template
        ParamName := 'Test Param';
        ModParamValue := 'Modified Value';
        JobQueueEntryId := CreateJobQueueEntryWithoutParameters(JobQueueEntry);
        CreateJqeParamTemplWithGivenValue(JobQueueEntry, JobQueueEntryParamTemplate, ParamName, JobQueueEntryParamTemplate.FieldNo("Text Value"), 'Test Value');
        JobQueueEntryParameterMgt.CreateAllJobQueueEntryParamsFromTempl(JobQueueEntry, true);
        commit();

        // [GIVEN] Prepare list of all statuses except "On Hold"
        StatusesToTest.Add(JobQueueEntry.Status::Ready);
        StatusesToTest.Add(JobQueueEntry.Status::"In Process");
        StatusesToTest.Add(JobQueueEntry.Status::Error);
        StatusesToTest.Add(JobQueueEntry.Status::Finished);

        // [WHEN] IsParamEditable is called for each non-"On Hold" status
        JobQueueEntryParameter.Get(JobQueueEntryId, ParamName);
        for StatusIndex := 1 to StatusesToTest.Count() do begin
            // [GIVEN] Job Queue Entry with status not "On Hold"
            JobQueueEntry.Status := StatusesToTest.Get(StatusIndex);
            JobQueueEntry.Modify(false);

            JobQueueEntryParameter."Text Value" := ModParamValue;
            // [THEN] An error should be thrown
            asserterror JobQueueEntryParameter.Modify(True);
            Assert.ExpectedErrorCode('TestField');
        end;
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
    begin
        // [SCENARIO] CreateAllJobQueueEntryParamsFromTempl with SetDefValue should create parameters with the default value from the templates
        Initialize();

        // [GIVEN] A Job Queue Entry and a parameter templates
        JobQueueEntryId := CreateJobQueueEntryWithoutParameters(JobQueueEntry);
        CreateJqeParamTemplWithAllPossParamType(JobQueueEntry, JobQueueEntryParamTemplate);

        // [WHEN] CreateAllJobQueueEntryParamsFromTempl is called with SetDefValue = true
        JobQueueEntryParameterMgt.CreateAllJobQueueEntryParamsFromTempl(JobQueueEntry, true);

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
    begin
        // [SCENARIO] CreateAllJobQueueEntryParamsFromTempl with SetDefValue = false should create parameters without the default value from the templates
        Initialize();

        // [GIVEN] A Job Queue Entry and a parameter templates
        JobQueueEntryId := CreateJobQueueEntryWithoutParameters(JobQueueEntry);
        CreateJqeParamTemplWithAllPossParamType(JobQueueEntry, JobQueueEntryParamTemplate);

        // [WHEN] CreateAllJobQueueEntryParamsFromTempl is called with SetDefValue = false
        JobQueueEntryParameterMgt.CreateAllJobQueueEntryParamsFromTempl(JobQueueEntry, false);

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
    begin
        // [SCENARIO] CreateAllJobQueueEntryParamsFromTempl with Object ID to Run = 0 should not create any parameters
        Initialize();

        // [GIVEN] A Job Queue Entry with Object ID to Run = 0 and a parameter templates
        JobQueueEntryId := CreateJobQueueEntryWithoutParameters(JobQueueEntry);
        CreateJqeParamTemplWithAllPossParamType(JobQueueEntry, JobQueueEntryParamTemplate);
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
        OriginalParameterValue: Variant;
    begin
        // [SCENARIO] OverwriteAllJobQueueEntryParamsFromTempl should not overwrite existing parameters if the Object ID and Type match
        Initialize();

        // [GIVEN] A Job Queue Entry with existing parameters and a parameter template
        JobQueueEntryId := CreateJobQueueEntryWithoutParameters(JobQueueEntry);
        CreateJqeParamTemplWithGivenValue(JobQueueEntry, JobQueueEntryParamTemplate, 'Param1', JobQueueEntryParamTemplate.FieldNo("Text Value"), 'TEST 1');
        JobQueueEntryParameterMgt.CreateAllJobQueueEntryParamsFromTempl(JobQueueEntry, true);

        // [GIVEN] Store the original parameter value for comparison
        JobQueueEntryParameter.SetRange("Job Queue Entry ID", JobQueueEntry.ID);
        JobQueueEntryParameter.FindFirst();
        OriginalParameterValue := JobQueueEntryParameterMgt.GetParameterValue(JobQueueEntryParameter);

        // [GIVEN] A new Job Queue Entry Parameter Template with a different default value
        JobQueueEntryParamTemplate.Reset();
        JobQueueEntryParamTemplate.DeleteAll(False);
        CreateJqeParamTemplWithGivenValue(JobQueueEntry, JobQueueEntryParamTemplate, 'Param1', JobQueueEntryParamTemplate.FieldNo("Text Value"), 'TEST 2');

        // [WHEN] OverwriteAllJobQueueEntryParamsFromTempl is called with the same Job Queue Entry
        JobQueueEntryParameterMgt.OverwriteAllJobQueueEntryParamsFromTempl(JobQueueEntry, JobQueueEntry, true);

        // [THEN] No parameters should be deleted or inserted
        JobQueueEntryParameter.SetRange("Job Queue Entry ID", JobQueueEntry.ID);
        Assert.AreEqual(1, JobQueueEntryParameter.Count(), 'No parameters should be deleted or inserted when Object ID and Type match');

        // [THEN] The parameter should retain the original value, not the new template value
        JobQueueEntryParameter.FindFirst();
        Assert.AreEqual(OriginalParameterValue, JobQueueEntryParameterMgt.GetParameterValue(JobQueueEntryParameter), 'Parameter should retain the original value when Object ID and Type match');

        // [THEN] Verify it's different from the new template value
        JobQueueEntryParamTemplate.Get(JobQueueEntry."Object Type to Run", JobQueueEntry."Object ID to Run", JobQueueEntryParameter."Parameter Name");
        Assert.AreNotEqual(JobQueueEntryParameterMgt.GetDefaultParameterValue(JobQueueEntryParamTemplate), JobQueueEntryParameterMgt.GetParameterValue(JobQueueEntryParameter), 'Parameter value should be different from the new template value');
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
        JobQueueEntryParameter.FindFirst();
        JobQueueEntryParamTemplate.Get(JobQueueEntry."Object Type to Run", JobQueueEntry."Object ID to Run", JobQueueEntryParameter."Parameter Name");
        Assert.AreEqual(JobQueueEntryParameterMgt.GetDefaultParameterValue(JobQueueEntryParamTemplate), JobQueueEntryParameterMgt.GetParameterValue(JobQueueEntryParameter), 'A parameter should be overwritten with the new default value when Object ID or Type is changed');
    end;

    [Test]
    procedure OverwriteAllJobQueueEntryParamsFromTempl_NoTemplatesForNewObjectId()
    var
        OldJobQueueEntry: Record "Job Queue Entry";
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueEntryParameterMgt: Codeunit "ADD_JobQueueEntryParameterMgt";
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntryParameter: Record "ADD_JobQueueEntryParameter";
    begin
        // [SCENARIO] OverwriteAllJobQueueEntryParamsFromTempl should delete all parameters when Object ID changes but no templates exist for the new Object ID
        Initialize();

        // [GIVEN] A Job Queue Entry with existing parameters
        CreateJobQueueEntryWithoutParameters(JobQueueEntry);
        CreateJqeParamTemplWithGivenValue(JobQueueEntry, JobQueueEntryParamTemplate, 'Param1', JobQueueEntryParamTemplate.FieldNo("Text Value"), 'TEST VALUE');
        JobQueueEntryParameterMgt.CreateAllJobQueueEntryParamsFromTempl(JobQueueEntry, true);

        // [GIVEN] Change the Object ID to one that has no templates
        OldJobQueueEntry := JobQueueEntry;
        JobQueueEntry."Object ID to Run" := GetSecondTestObjectId();
        JobQueueEntry.Modify(False);

        // [WHEN] OverwriteAllJobQueueEntryParamsFromTempl is called
        JobQueueEntryParameterMgt.OverwriteAllJobQueueEntryParamsFromTempl(JobQueueEntry, OldJobQueueEntry, true);

        // [THEN] All parameters should be deleted and none created
        JobQueueEntryParameter.SetRange("Job Queue Entry ID", JobQueueEntry.ID);
        Assert.AreEqual(0, JobQueueEntryParameter.Count(), 'No parameters should exist when Object ID changes and no templates exist for the new Object ID');
    end;

    [Test]
    procedure CreateJqeParamTemplIfNotExists_DoNotCreateIfExists()
    var
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntryParameterMgt: Codeunit "ADD_JobQueueEntryParameterMgt";
        JobQueueEntry: Record "Job Queue Entry";
        JqeTemplToCreate: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntryId: Guid;
    begin
        // [SCENARIO] CreateJqeParamTemplIfNotExists should not create a template if it already exists
        Initialize();
        // [GIVEN] A Job Queue Entry and a parameter template
        JobQueueEntryId := CreateJobQueueEntryWithoutParameters(JobQueueEntry);
        CreateJqeParamTempl(JobQueueEntry, JobQueueEntryParamTemplate, 'TestParam', JobQueueEntryParamTemplate.FieldNo("Text Value"));
        JqeTemplToCreate := JobQueueEntryParamTemplate;

        // [WHEN] CreateJqeParamTemplIfNotExists is called with the same template
        JobQueueEntryParameterMgt.CreateJqeParamTemplIfNotExists(JqeTemplToCreate, True);

        // [THEN] The template should not be created again
        Assert.AreEqual(1, JobQueueEntryParamTemplate.Count(), 'Template should not be created again if it already exists');
    end;

    [Test]
    procedure CreateJqeParamTemplIfNotExists_CreateIfNotExists()
    var
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntryParameterMgt: Codeunit "ADD_JobQueueEntryParameterMgt";
    begin
        // [SCENARIO] CreateJqeParamTemplIfNotExists should create a template if it does not exist
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template
        CreateJqeParamTemplWithTextVal(JobQueueEntryParamTemplate, 'TestParam', 'TestValue');

        // [WHEN] CreateJqeParamTemplIfNotExists is called with a new template
        JobQueueEntryParameterMgt.CreateJqeParamTemplIfNotExists(JobQueueEntryParamTemplate, True);

        // [THEN] The template should be created
        Assert.AreEqual(1, JobQueueEntryParamTemplate.Count(), 'Template should be created if it does not exist');
    end;

    [Test]
    procedure CreateJqeParamTemplIfNotExists_CreateTemplAndCreateParamsForJobQueueEntry()
    var
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntryParameterMgt: Codeunit "ADD_JobQueueEntryParameterMgt";
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueEntryParameter: Record "ADD_JobQueueEntryParameter";
        JobQueueEntryId: Guid;
    begin
        // [SCENARIO] CreateJqeParamTemplIfNotExists should create a template if it does not exist
        Initialize();

        // [GIVEN] A Job Queue Entry without parameters
        JobQueueEntryId := CreateJobQueueEntryWithoutParameters(JobQueueEntry);

        // [GIVEN] A Job Queue Entry Parameter Template
        CreateJqeParamTemplWithTextVal(JobQueueEntryParamTemplate, 'TestParam', 'TestValue');

        // [WHEN] CreateJqeParamTemplIfNotExists is called with a new template
        JobQueueEntryParameterMgt.CreateJqeParamTemplIfNotExists(JobQueueEntryParamTemplate, True);

        // [THEN] The template should be created
        Assert.AreEqual(1, JobQueueEntryParamTemplate.Count(), 'Template should be created if it does not exist');

        // [THEN] Parameters should be created for the Job Queue Entry
        JobQueueEntryParameter.SetRange("Job Queue Entry ID", JobQueueEntryId);
        Assert.AreEqual(1, JobQueueEntryParameter.Count(), 'Parameter should be created for the Job Queue Entry');
    end;

    [Test]
    procedure GetJobQueueEntryParamValue_ParameterDoesNotExist()
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueEntryParameterMgt: Codeunit "ADD_JobQueueEntryParameterMgt";
        JobQueueEntryId: Guid;
        ParamName: Text[100];
        ParamValue: Variant;
    begin
        // [SCENARIO] GetJobQueueEntryParamValue should throw an error if the parameter does not exist
        Initialize();

        // [GIVEN] A Job Queue Entry without parameters
        JobQueueEntryId := CreateJobQueueEntryWithoutParameters(JobQueueEntry);
        ParamName := 'NonExistingParam';

        // [WHEN] GetJobQueueEntryParamValue is called for a non-existent parameter
        // [THEN] An error should be thrown because the parameter does not exist
        asserterror ParamValue := JobQueueEntryParameterMgt.GetJobQueueEntryParamValue(JobQueueEntry, ParamName);
    end;

    [Test]
    procedure GetJobQueueEntryParamValue_ReturnsCorrectValue()
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueEntryParameterMgt: Codeunit "ADD_JobQueueEntryParameterMgt";
        ParamName: Text[100];
        ParamValue: Variant;
        ParamValueReturned: Variant;
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
    begin
        // [SCENARIO] GetJobQueueEntryParamValue should throw an error if the parameter does not exist
        Initialize();

        // [GIVEN] A Job Queue Entry with a template and a parameter
        ParamName := 'TestParam';
        ParamValue := 'TestValue';
        CreateJobQueueEntryWithoutParameters(JobQueueEntry);
        CreateJqeParamTemplWithGivenValue(JobQueueEntry, JobQueueEntryParamTemplate, ParamName, JobQueueEntryParamTemplate.FieldNo("Text Value"), ParamValue);
        JobQueueEntryParameterMgt.CreateAllJobQueueEntryParamsFromTempl(JobQueueEntry, true);

        // [WHEN] GetJobQueueEntryParamValue is called for an existing parameter
        ParamValueReturned := JobQueueEntryParameterMgt.GetJobQueueEntryParamValue(JobQueueEntry, ParamName);

        // [THEN] The correct value should be returned
        Assert.AreEqual(ParamValueReturned, ParamValue, 'The returned parameter value is incorrect');
    end;

    [Test]
    procedure IsParamEditable_ReturnsTrue()
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueEntryParameterMgt: Codeunit "ADD_JobQueueEntryParameterMgt";
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntryParameter: Record "ADD_JobQueueEntryParameter";
        JobQueueEntryId: Guid;
        IsEditable: Boolean;
    begin
        // [SCENARIO] IsParamEditable should return true for a parameter when the Job Queue Entry is on hold
        Initialize();

        // [GIVEN] A Job Queue Entry with a parameter
        JobQueueEntryId := CreateJobQueueEntryWithoutParameters(JobQueueEntry);
        CreateJqeParamTemplWithGivenValue(JobQueueEntry, JobQueueEntryParamTemplate, 'TestParam', JobQueueEntryParamTemplate.FieldNo("Text Value"), 'TestValue');
        JobQueueEntryParameterMgt.CreateAllJobQueueEntryParamsFromTempl(JobQueueEntry, true);

        // [GIVEN] Set the Job Queue Entry status to "On Hold"
        JobQueueEntry.Status := JobQueueEntry.Status::"On Hold";
        JobQueueEntry.Modify(false);

        // [WHEN] IsParamEditable is called for the parameter
        JobQueueEntryParameter.SetRange("Job Queue Entry ID", JobQueueEntry.ID);
        JobQueueEntryParameter.FindFirst();
        IsEditable := JobQueueEntryParameterMgt.IsParamEditable(JobQueueEntryParameter);

        // [THEN] It should return true
        Assert.IsTrue(IsEditable, 'The parameter should be editable when the Job Queue Entry is on hold');
    end;

    [Test]
    procedure IsParamEditable_ReturnsFalse()
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueEntryParameterMgt: Codeunit "ADD_JobQueueEntryParameterMgt";
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntryParameter: Record "ADD_JobQueueEntryParameter";
        JobQueueEntryId: Guid;
        IsEditable: Boolean;
        StatusesToTest: List of [Integer];
        StatusIndex: Integer;
    begin
        // [SCENARIO] IsParamEditable should return false for a parameter when the Job Queue Entry is not on hold
        Initialize();

        // [GIVEN] A Job Queue Entry with a parameter
        JobQueueEntryId := CreateJobQueueEntryWithoutParameters(JobQueueEntry);
        CreateJqeParamTemplWithGivenValue(JobQueueEntry, JobQueueEntryParamTemplate, 'TestParam', JobQueueEntryParamTemplate.FieldNo("Text Value"), 'TestValue');
        JobQueueEntryParameterMgt.CreateAllJobQueueEntryParamsFromTempl(JobQueueEntry, true);

        // [GIVEN] Prepare list of all statuses except "On Hold"
        StatusesToTest.Add(JobQueueEntry.Status::Ready);
        StatusesToTest.Add(JobQueueEntry.Status::"In Process");
        StatusesToTest.Add(JobQueueEntry.Status::Error);
        StatusesToTest.Add(JobQueueEntry.Status::Finished);

        // [WHEN] IsParamEditable is called for each non-"On Hold" status
        for StatusIndex := 1 to StatusesToTest.Count() do begin
            JobQueueEntry.Status := StatusesToTest.Get(StatusIndex);
            JobQueueEntry.Modify(false);

            JobQueueEntryParameter.SetRange("Job Queue Entry ID", JobQueueEntry.ID);
            JobQueueEntryParameter.FindFirst();
            IsEditable := JobQueueEntryParameterMgt.IsParamEditable(JobQueueEntryParameter);

            // [THEN] It should return false for all statuses except "On Hold"
            Assert.IsFalse(IsEditable, StrSubstNo('The parameter should not be editable when the Job Queue Entry status is %1', JobQueueEntry.Status));
        end;
    end;

    [Test]
    procedure GetTemplParameterTypeCaption_ReturnsCorrectCaption()
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntryParameterMgt: Codeunit "ADD_JobQueueEntryParameterMgt";
    begin
        // [SCENARIO] GetTemplParameterTypeCaption should return the correct caption for each parameter type
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template with all possible parameter types
        CreateJobQueueEntryWithoutParameters(JobQueueEntry);
        CreateJqeParamTemplWithAllPossParamType(JobQueueEntry, JobQueueEntryParamTemplate);

        // [WHEN] GetTemplParameterTypeCaption is called
        // [THEN] The returned caption should match the expected caption
        JobQueueEntryParamTemplate.FindSet();
        repeat
            Assert.AreEqual(JobQueueEntryParameterMgt.GetTemplParameterTypeCaption(JobQueueEntryParamTemplate), GetJqeParamTemplCaption(JobQueueEntryParamTemplate), 'The caption for the parameter type should match the expected caption');
        until JobQueueEntryParamTemplate.Next() = 0;
    end;

    [Test]
    procedure GetParameterTypeCaption_ReturnsCorrectCaption()
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntryParameter: Record "ADD_JobQueueEntryParameter";
        JobQueueEntryParameterMgt: Codeunit "ADD_JobQueueEntryParameterMgt";
    begin
        // [SCENARIO] GetParameterTypeCaption should return the correct caption for each parameter type
        Initialize();

        // [GIVEN] A Job Queue Entry, a Job Queue Entry Parameter Template with all possible parameter types, and parameters created from the template
        CreateJobQueueEntryWithoutParameters(JobQueueEntry);
        CreateJqeParamTemplWithAllPossParamType(JobQueueEntry, JobQueueEntryParamTemplate);
        JobQueueEntryParameterMgt.CreateAllJobQueueEntryParamsFromTempl(JobQueueEntry, true);

        // [WHEN] GetParameterTypeCaption is called
        // [THEN] The returned caption should match the expected caption
        JobQueueEntryParameter.FindSet();
        repeat
            Assert.AreEqual(JobQueueEntryParameterMgt.GetParameterTypeCaption(JobQueueEntryParameter), GetJqeParamCaption(JobQueueEntryParameter), 'The caption for the parameter type should match the expected caption');
        until JobQueueEntryParameter.Next() = 0;
    end;

    [Test]
    procedure GetParameterValue_ReturnsCorrectValue()
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueEntryParameterMgt: Codeunit "ADD_JobQueueEntryParameterMgt";
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntryParameter: Record "ADD_JobQueueEntryParameter";
        ParamValue: Variant;
        ExpectedParamValue: Variant;
    begin
        // [SCENARIO] GetParameterValue should return the correct value for a parameter
        Initialize();

        // [GIVEN] A Job Queue Entry with a parameter template and a parameter
        CreateJobQueueEntryWithoutParameters(JobQueueEntry);
        CreateJqeParamTemplWithAllPossParamType(JobQueueEntry, JobQueueEntryParamTemplate);
        JobQueueEntryParameterMgt.CreateAllJobQueueEntryParamsFromTempl(JobQueueEntry, true);

        // [WHEN] GetParameterValue is called for the parameter
        // [THEN] The correct value should be returned
        JobQueueEntryParameter.SetAutoCalcFields("Parameter Type");
        JobQueueEntryParameter.FindSet();
        repeat
            ParamValue := JobQueueEntryParameterMgt.GetParameterValue(JobQueueEntryParameter);
            ExpectedParamValue := GetDefaultParameterTemplValue(JobQueueEntryParameter."Parameter Type");
            AssertVariantsAreEqual(ExpectedParamValue, ParamValue, 'The returned parameter value should match the expected value');
        until JobQueueEntryParameter.Next() = 0;
    end;

    [Test]
    procedure GetParameterValueAsText_ReturnsCorrectValue()
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueEntryParameterMgt: Codeunit "ADD_JobQueueEntryParameterMgt";
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntryParameter: Record "ADD_JobQueueEntryParameter";
        ParamValueAsText: Text;
        ExpectedParamValueAsText: Text;
    begin
        // [SCENARIO] GetParameterValue should return the correct value for a parameter
        Initialize();

        // [GIVEN] A Job Queue Entry with a parameter template and a parameter
        CreateJobQueueEntryWithoutParameters(JobQueueEntry);
        CreateJqeParamTemplWithAllPossParamType(JobQueueEntry, JobQueueEntryParamTemplate);
        JobQueueEntryParameterMgt.CreateAllJobQueueEntryParamsFromTempl(JobQueueEntry, true);

        // [WHEN] GetParameterValue is called for the parameter
        // [THEN] The correct value should be returned
        JobQueueEntryParameter.SetAutoCalcFields("Parameter Type");
        JobQueueEntryParameter.FindSet();
        repeat
            ParamValueAsText := JobQueueEntryParameterMgt.GetParameterValueAsText(JobQueueEntryParameter);
            ExpectedParamValueAsText := Format(JobQueueEntryParameterMgt.GetParameterValue(JobQueueEntryParameter));
            Assert.AreEqual(ExpectedParamValueAsText, ParamValueAsText, 'The returned parameter value as text should match the expected value as text');
        until JobQueueEntryParameter.Next() = 0;
    end;

    [Test]
    procedure GetDefaultParameterValue_ReturnsCorrectValue()
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueEntryParameterMgt: Codeunit "ADD_JobQueueEntryParameterMgt";
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        ParamValue: Variant;
        ExpectedParamValue: Variant;
    begin
        // [SCENARIO] GetDefaultParameterValue should return the correct value for a parameter
        Initialize();

        // [GIVEN] A Job Queue Entry and a parameter template with all possible parameter types
        CreateJobQueueEntryWithoutParameters(JobQueueEntry);
        CreateJqeParamTemplWithAllPossParamType(JobQueueEntry, JobQueueEntryParamTemplate);

        // [WHEN] GetDefaultParameterValue is called for the parameter
        // [THEN] The correct value should be returned
        JobQueueEntryParamTemplate.FindSet();
        repeat
            ParamValue := JobQueueEntryParameterMgt.GetDefaultParameterValue(JobQueueEntryParamTemplate);
            ExpectedParamValue := GetDefaultParameterTemplValue(JobQueueEntryParamTemplate."Parameter Type");
            AssertVariantsAreEqual(ExpectedParamValue, ParamValue, 'The returned parameter value should match the expected value');
        until JobQueueEntryParamTemplate.Next() = 0;
    end;

    [Test]
    procedure GetDefaultParameterValueAsText_ReturnsCorrectValue()
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueEntryParameterMgt: Codeunit "ADD_JobQueueEntryParameterMgt";
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        ParamValueAsText: Text;
        ExpectedParamValueAsText: Text;
    begin
        // [SCENARIO] GetDefaultParameterValueAsText should return the correct value for a parameter
        Initialize();

        // [GIVEN] A Job Queue Entry and a parameter template with all possible parameter types
        CreateJobQueueEntryWithoutParameters(JobQueueEntry);
        CreateJqeParamTemplWithAllPossParamType(JobQueueEntry, JobQueueEntryParamTemplate);

        // [WHEN] GetDefaultParameterValue is called for the parameter
        // [THEN] The correct value should be returned
        JobQueueEntryParamTemplate.FindSet();
        repeat
            ParamValueAsText := JobQueueEntryParameterMgt.GetDefaultParameterValueAsText(JobQueueEntryParamTemplate);
            ExpectedParamValueAsText := Format(JobQueueEntryParameterMgt.GetDefaultParameterValue(JobQueueEntryParamTemplate));
            Assert.AreEqual(ExpectedParamValueAsText, ParamValueAsText, 'The returned parameter value as text should match the expected value as text');
        until JobQueueEntryParamTemplate.Next() = 0;
    end;

    local procedure GetJqeParamCaption(JobQueueEntryParam: Record "ADD_JobQueueEntryParameter"): Text[100]
    begin
        case JobQueueEntryParam."Parameter Type" of
            JobQueueEntryParam.FieldNo("BigInteger Value"):
                exit('BigInteger');
            JobQueueEntryParam.FieldNo("Boolean Value"):
                exit('Boolean');
            JobQueueEntryParam.FieldNo("Code Value"):
                exit('Code');
            JobQueueEntryParam.FieldNo("Date Value"):
                exit('Date');
            JobQueueEntryParam.FieldNo("DateFormula Value"):
                exit('DateFormula');
            JobQueueEntryParam.FieldNo("DateTime Value"):
                exit('DateTime');
            JobQueueEntryParam.FieldNo("Decimal Value"):
                exit('Decimal');
            JobQueueEntryParam.FieldNo("Duration Value"):
                exit('Duration');
            JobQueueEntryParam.FieldNo("Guid Value"):
                exit('GUID');
            JobQueueEntryParam.FieldNo("Integer Value"):
                exit('Integer');
            JobQueueEntryParam.FieldNo("Text Value"):
                exit('Text');
            JobQueueEntryParam.FieldNo("Time Value"):
                exit('Time');
        end;
    end;

    local procedure GetJqeParamTemplCaption(JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate"): Text[100]
    begin
        case JobQueueEntryParamTemplate."Parameter Type" of
            JobQueueEntryParamTemplate.FieldNo("BigInteger Value"):
                exit('BigInteger');
            JobQueueEntryParamTemplate.FieldNo("Boolean Value"):
                exit('Boolean');
            JobQueueEntryParamTemplate.FieldNo("Code Value"):
                exit('Code');
            JobQueueEntryParamTemplate.FieldNo("Date Value"):
                exit('Date');
            JobQueueEntryParamTemplate.FieldNo("DateFormula Value"):
                exit('DateFormula');
            JobQueueEntryParamTemplate.FieldNo("DateTime Value"):
                exit('DateTime');
            JobQueueEntryParamTemplate.FieldNo("Decimal Value"):
                exit('Decimal');
            JobQueueEntryParamTemplate.FieldNo("Duration Value"):
                exit('Duration');
            JobQueueEntryParamTemplate.FieldNo("Guid Value"):
                exit('GUID');
            JobQueueEntryParamTemplate.FieldNo("Integer Value"):
                exit('Integer');
            JobQueueEntryParamTemplate.FieldNo("Text Value"):
                exit('Text');
            JobQueueEntryParamTemplate.FieldNo("Time Value"):
                exit('Time');
        end;
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
        ParamValue: Variant;
    begin
        ParamValue := GetDefaultParameterTemplValue(ParamType);
        CreateJqeParamTemplWithGivenValue(JobQueueEntry, JobQueueEntryParamTemplate, NewParamName, ParamType, ParamValue);
    end;

    local procedure GetDefaultParameterTemplValue(ParamType: Integer): Variant
    var
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
    begin
        case ParamType of
            JobQueueEntryParamTemplate.FieldNo("BigInteger Value"):
                Exit(1000000);
            JobQueueEntryParamTemplate.FieldNo("Boolean Value"):
                Exit(true);
            JobQueueEntryParamTemplate.FieldNo("Code Value"):
                Exit('SAMPLE CODE');
            JobQueueEntryParamTemplate.FieldNo("Date Value"):
                Exit(DMY2Date(01, 01, 2025));
            JobQueueEntryParamTemplate.FieldNo("DateFormula Value"):
                Exit('+1D');
            JobQueueEntryParamTemplate.FieldNo("DateTime Value"):
                Exit(CreateDateTime(DMY2Date(01, 01, 2025), 115900T));
            JobQueueEntryParamTemplate.FieldNo("Decimal Value"):
                Exit(0.5);
            JobQueueEntryParamTemplate.FieldNo("Duration Value"):
                Exit(60);
            JobQueueEntryParamTemplate.FieldNo("Guid Value"):
                Exit('{10000000-0000-0000-0000-000000000000}');
            JobQueueEntryParamTemplate.FieldNo("Integer Value"):
                Exit(100);
            JobQueueEntryParamTemplate.FieldNo("Text Value"):
                Exit('Sample Text');
            JobQueueEntryParamTemplate.FieldNo("Time Value"):
                Exit(115900T);
        end;
    end;

    local procedure CreateSampleTextJqeParamTempl(var JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate")
    begin
        JobQueueEntryParamTemplate."Object ID" := GetTestObjectId();
        JobQueueEntryParamTemplate."Object Type" := JobQueueEntryParamTemplate."Object Type"::Codeunit;
        JobQueueEntryParamTemplate."Parameter Name" := 'SampleParam';
        JobQueueEntryParamTemplate."Parameter Type" := JobQueueEntryParamTemplate.FieldNo("Text Value");
        JobQueueEntryParamTemplate.Insert();
    end;

    local procedure CreateJqeParamTemplWithGivenValue(var JobQueueEntry: Record "Job Queue Entry"; var JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate"; NewParamName: Text[100]; ParamType: Integer; ParamValue: Variant)
    var
        Any: Codeunit Any;
        DateForm: Text;
    begin
        //TODO: JobQueueEntry should be deleted from the paramater
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

    local procedure CreateJqeParamTemplWithAllPossParamType(var JobQueueEntry: Record "Job Queue Entry"; var JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate")
    var
        TemplCounter: Integer;
        NewParamName: Text[100];
        ParamTypes: List of [Integer];
    begin
        CreateParamTypeIntList(ParamTypes);
        for TemplCounter := 1 to ParamTypes.Count() do begin
            NewParamName := 'TestParameter' + Format(TemplCounter);
            CreateJqeParamTempl(JobQueueEntry, JobQueueEntryParamTemplate, NewParamName, ParamTypes.Get(TemplCounter));
        end;
    end;

    local procedure CreateJqeParamTemplWithTextVal(var JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate"; ParamName: Text[100]; TextVal: Text[250])
    begin
        JobQueueEntryParamTemplate."Object ID" := GetTestObjectId();
        JobQueueEntryParamTemplate."Object Type" := JobQueueEntryParamTemplate."Object Type"::Codeunit;
        JobQueueEntryParamTemplate."Parameter Name" := ParamName;
        JobQueueEntryParamTemplate."Parameter Type" := JobQueueEntryParamTemplate.FieldNo("Text Value");
        JobQueueEntryParamTemplate."Text Value" := TextVal;
        JobQueueEntryParamTemplate.Insert();
    end;

    local procedure AssertVariantsAreEqual(var ExpectedValue: Variant; var CurrValue: Variant; Msg: Text)
    begin
        case True of
            CurrValue.IsBigInteger():
                AssertBigIntegersAreEqual(ExpectedValue, CurrValue, Msg);
            CurrValue.IsBoolean():
                AssertBooleansAreEqual(ExpectedValue, CurrValue, Msg);
            CurrValue.IsCode():
                AssertCodesAreEqual(ExpectedValue, CurrValue, Msg);
            CurrValue.IsDate():
                AssertDatesAreEqual(ExpectedValue, CurrValue, Msg);
            CurrValue.IsDateFormula():
                AssertDateFormulasAreEqual(ExpectedValue, CurrValue, Msg);
            CurrValue.IsDateTime():
                AssertDateTimesAreEqual(ExpectedValue, CurrValue, Msg);
            CurrValue.IsDecimal():
                AssertDecimalsAreEqual(ExpectedValue, CurrValue, Msg);
            CurrValue.IsDuration():
                AssertDurationsAreEqual(ExpectedValue, CurrValue, Msg);
            CurrValue.IsGuid():
                AssertGuidsAreEqual(ExpectedValue, CurrValue, Msg);
            CurrValue.IsInteger():
                AssertIntegersAreEqual(ExpectedValue, CurrValue, Msg);
            CurrValue.IsText():
                AssertTextsAreEqual(ExpectedValue, CurrValue, Msg);
            CurrValue.IsTime():
                AssertTimesAreEqual(ExpectedValue, CurrValue, Msg);
        end;
    end;

    local procedure AssertBigIntegersAreEqual(ExpectedValue: BigInteger; CurrValue: BigInteger; Msg: Text)
    begin
        Assert.AreEqual(ExpectedValue, CurrValue, Msg);
    end;

    local procedure AssertBooleansAreEqual(ExpectedValue: Boolean; CurrValue: Boolean; Msg: Text)
    begin
        Assert.AreEqual(ExpectedValue, CurrValue, Msg);
    end;

    local procedure AssertCodesAreEqual(ExpectedValue: Code[100]; CurrValue: Code[100]; Msg: Text)
    begin
        Assert.AreEqual(ExpectedValue, CurrValue, Msg);
    end;

    local procedure AssertDatesAreEqual(ExpectedValue: Date; CurrValue: Date; Msg: Text)
    begin
        Assert.AreEqual(ExpectedValue, CurrValue, Msg);
    end;

    local procedure AssertDateFormulasAreEqual(ExpectedValue: DateFormula; CurrValue: DateFormula; Msg: Text)
    begin
        Assert.AreEqual(ExpectedValue, CurrValue, Msg);
    end;

    local procedure AssertDateTimesAreEqual(ExpectedValue: DateTime; CurrValue: DateTime; Msg: Text)
    begin
        Assert.AreEqual(ExpectedValue, CurrValue, Msg);
    end;

    local procedure AssertDecimalsAreEqual(ExpectedValue: Decimal; CurrValue: Decimal; Msg: Text)
    begin
        Assert.AreEqual(ExpectedValue, CurrValue, Msg);
    end;

    local procedure AssertDurationsAreEqual(ExpectedValue: Duration; CurrValue: Duration; Msg: Text)
    begin
        Assert.AreEqual(ExpectedValue, CurrValue, Msg);
    end;

    local procedure AssertGuidsAreEqual(ExpectedValue: Guid; CurrValue: Guid; Msg: Text)
    begin
        Assert.AreEqual(ExpectedValue, CurrValue, Msg);
    end;

    local procedure AssertIntegersAreEqual(ExpectedValue: Integer; CurrValue: Integer; Msg: Text)
    begin
        Assert.AreEqual(ExpectedValue, CurrValue, Msg);
    end;

    local procedure AssertTextsAreEqual(ExpectedValue: Text; CurrValue: Text; Msg: Text)
    begin
        Assert.AreEqual(ExpectedValue, CurrValue, Msg);
    end;

    local procedure AssertTimesAreEqual(ExpectedValue: Time; CurrValue: Time; Msg: Text)
    begin
        Assert.AreEqual(ExpectedValue, CurrValue, Msg);
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