codeunit 50140 "ADD_JobQueueParamsTest"
{
    // [FEATURE] [JobQueueParamsTest]
    Subtype = Test;
    TestPermissions = Disabled;

    trigger OnRun()
    begin
    end;

    local procedure Initialize()
    var
        JqeParamTempl: Record "ADD_JobQueueEntryParamTemplate";
        JqeParam: Record "ADD_JobQueueEntryParameter";
        JobQueueEntry: Record "Job Queue Entry";
        ObjType: Integer;
        ObjId: Integer;
    begin
        JqeParamTempl.DeleteAll(false);
        JqeParam.DeleteAll(false);

        GetTestCu1ForJobQueueEntry(ObjType, ObjId);
        JobQueueEntry.SetRange("Object ID to Run", ObjId);
        JobQueueEntry.SetRange("Object Type to Run", ObjType);
        JobQueueEntry.DeleteAll(false);

        GetTestCu2ForJobQueueEntry(ObjType, ObjId);
        JobQueueEntry.SetRange("Object ID to Run", ObjId);
        JobQueueEntry.SetRange("Object Type to Run", ObjType);
        JobQueueEntry.DeleteAll(false);

        GetTestRep1ForJobQueueEntry(ObjType, ObjId);
        JobQueueEntry.SetRange("Object ID to Run", ObjId);
        JobQueueEntry.SetRange("Object Type to Run", ObjType);
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
        JobQueueEntrParamTemplateCard: TestPage ADD_JobQueueEntrParamTemplCard;
    begin
        // [SCENARIO] Modifying Job Queue Entry Parameter Template Description from Card Page should be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template
        // [GIVEN] A Job Queue Entry Parameter Template Card Page opened with the created template in edit mode
        CreateSampleTemplAndOpenItInTemplCardPageEditMode(JobQueueEntrParamTemplateCard);

        // [WHEN] Attempting to edit Parameter Description on the card page
        // [THEN] Modifying a Job Queue Entry Parameter Template Parameter Description from the Card Page should be possible
        Assert.IsTrue(JobQueueEntrParamTemplateCard."Parameter Description".Editable(), 'The Parameter Description on the card page should be editable');

        JobQueueEntrParamTemplateCard.Close();
    end;

    [Test]
    procedure ModifyJobQueEntrParamTemplValueIsPossibleFromCardPage()
    var
        JobQueueEntrParamTemplateCard: TestPage ADD_JobQueueEntrParamTemplCard;
    begin
        // [SCENARIO] Modifying Job Queue Entry Parameter Template Value from Card Page should be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template
        // [GIVEN] A Job Queue Entry Parameter Template Card Page opened with the created template in edit mode
        CreateSampleTemplAndOpenItInTemplCardPageEditMode(JobQueueEntrParamTemplateCard);

        // [WHEN] Attempting to edit Parameter Value on the card page
        // [THEN] Modifying a Job Queue Entry Parameter Template Parameter Value from the Card Page should be possible
        //TODO: it shoould check each possible value type
        Assert.IsTrue(JobQueueEntrParamTemplateCard."Text Value".Editable(), 'The Text Value on the card page should be editable');

        JobQueueEntrParamTemplateCard.Close();
    end;

    [Test]
    procedure ModifyJobQueEntrParamTemplObjTypeIsNotPossibleFromCardPage()
    var
        JobQueueEntrParamTemplateCard: TestPage ADD_JobQueueEntrParamTemplCard;
    begin
        // [SCENARIO] Modifying Job Queue Entry Parameter Template Object Type from Card Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template
        // [GIVEN] A Job Queue Entry Parameter Template Card Page opened with the created template in edit mode
        CreateSampleTemplAndOpenItInTemplCardPageEditMode(JobQueueEntrParamTemplateCard);

        // [WHEN] Attempting to edit Object Type on the card page
        // [THEN] Modifying a Job Queue Entry Parameter Template Object Type from the Card Page should not be possible
        Assert.IsFalse(JobQueueEntrParamTemplateCard."Object Type".Editable(), 'The Object Type on the card page should not be editable');

        JobQueueEntrParamTemplateCard.Close();
    end;

    [Test]
    procedure ModifyJobQueEntrParamTemplObjIDIsNotPossibleFromCardPage()
    var
        JobQueueEntrParamTemplateCard: TestPage ADD_JobQueueEntrParamTemplCard;
    begin
        // [SCENARIO] Modifying Job Queue Entry Parameter Template Object ID from Card Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template
        // [GIVEN] A Job Queue Entry Parameter Template Card Page opened with the created template in edit mode
        CreateSampleTemplAndOpenItInTemplCardPageEditMode(JobQueueEntrParamTemplateCard);

        // [WHEN] Attempting to edit Object ID on the card page
        // [THEN] Modifying a Job Queue Entry Parameter Template Object ID from the Card Page should not be possible
        Assert.IsFalse(JobQueueEntrParamTemplateCard."Object ID".Editable(), 'The Object ID on the card page should not be editable');

        JobQueueEntrParamTemplateCard.Close();
    end;

    [Test]
    procedure ModifyJobQueEntrParamTemplParamNameIsNotPossibleFromCardPage()
    var
        JobQueueEntrParamTemplateCard: TestPage ADD_JobQueueEntrParamTemplCard;
    begin
        // [SCENARIO] Modifying Job Queue Entry Parameter Template Parameter Name from Card Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template
        // [GIVEN] A Job Queue Entry Parameter Template Card Page opened with the created template in edit mode
        CreateSampleTemplAndOpenItInTemplCardPageEditMode(JobQueueEntrParamTemplateCard);

        // [WHEN] Attempting to edit Parameter Name on the card page
        // [THEN] Modifying a Job Queue Entry Parameter Template Parameter Name from the Card Page should not be possible
        Assert.IsFalse(JobQueueEntrParamTemplateCard."Parameter Name".Editable(), 'The Parameter Name on the card page should not be editable');

        JobQueueEntrParamTemplateCard.Close();
    end;

    [Test]
    procedure ModifyJobQueEntrParamTemplParamTypeIsNotPossibleFromCardPage()
    var
        JobQueueEntrParamTemplateCard: TestPage ADD_JobQueueEntrParamTemplCard;
    begin
        // [SCENARIO] Modifying Job Queue Entry Parameter Template Parameter Type from Card Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template
        // [GIVEN] A Job Queue Entry Parameter Template Card Page opened with the created template in edit mode
        CreateSampleTemplAndOpenItInTemplCardPageEditMode(JobQueueEntrParamTemplateCard);

        // [WHEN] Attempting to edit Parameter Type on the card page
        // [THEN] Modifying a Job Queue Entry Parameter Template Parameter Type from the Card Page should not be possible
        Assert.IsFalse(JobQueueEntrParamTemplateCard."Parameter Type".Editable(), 'The Parameter Type on the card page should not be editable');

        JobQueueEntrParamTemplateCard.Close();
    end;

    [Test]
    procedure CreateJobQueEntrParamIsNotPossibleFromListPage()
    var
        JobQueueEntrParams: TestPage ADD_JobQueueEntryParameters;
    begin
        // [SCENARIO] Creating Job Queue Entry Parameter from List Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter List Page
        JobQueueEntrParams.OpenView();

        // [WHEN] Attempting to create a new record on the list page
        // [THEN] Creating a Job Queue Entry Parameter from the List Page should not be possible
        asserterror JobQueueEntrParams.New();
        Assert.ExpectedErrorCode('DB:ClientInsertDenied');

        JobQueueEntrParams.Close();
    end;

    [Test]
    procedure ModifyJobQueEntrParamIsNotPossibleFromListPage()
    var
        JobQueueEntrParams: TestPage ADD_JobQueueEntryParameters;
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueEntryParams: Record "ADD_JobQueueEntryParameter";
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
    begin
        // [SCENARIO] Modifying Job Queue Entry Parameter from List Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template
        // [GIVEN] A Job Queue Entry with parameters from this template
        CreateJobQEntryWithSampleParams(JobQueueEntry, JobQueueEntryParams, JobQueueEntryParamTemplate);

        // [GIVEN] A Job Queue Entry Parameter List Page opened with the parameters
        JobQueueEntrParams.OpenEdit();
        JobQueueEntrParams.GoToRecord(JobQueueEntryParams);

        // [WHEN] Checking if the page is editable
        // [THEN] Modifying a Job Queue Entry Parameter from the List Page should not be possible
        Assert.IsFalse(JobQueueEntrParams.Editable(), 'The list page should not be editable');

        JobQueueEntrParams.Close();
    end;

    [Test]
    procedure CreateJobQueEntrParamIsNotPossibleFromCardPage()
    var
        JobQueueEntrParamCard: TestPage ADD_JobQueueEntrParamCard;
    begin
        // [SCENARIO] Creating Job Queue Entry Parameter from Card Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Card Page
        JobQueueEntrParamCard.OpenView();

        // [WHEN] Attempting to create a new record on the card page
        // [THEN] Creating a Job Queue Entry Parameter from the Card Page should not be possible
        asserterror JobQueueEntrParamCard.New();
        Assert.ExpectedErrorCode('DB:ClientInsertDenied');

        JobQueueEntrParamCard.Close();
    end;

    [Test]
    procedure ModifyJobQueEntrParamDescIsNotPossibleFromCardPage()
    var
        JobQueueEntrParamCard: TestPage ADD_JobQueueEntrParamCard;
        JobQueueEntry: Record "Job Queue Entry";
        JobQEntryParams: Record "ADD_JobQueueEntryParameter";
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
    begin
        // [SCENARIO] Modifying Job Queue Entry Parameter Description from Card Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template
        // [GIVEN] A Job Queue Entry with parameters from this template
        // [GIVEN] A Job Queue Entry Parameter Card Page opened with the parameters
        CreateJobQEntryWithSampleParamsAndOpenItInParamCardPageEditMode(JobQueueEntry, JobQEntryParams, JobQueueEntryParamTemplate, JobQueueEntrParamCard);

        // [WHEN] Attempting to edit Parameter Description on the card page
        // [THEN] Modifying a Job Queue Entry Parameter Description from the Card Page should not be possible
        Assert.IsFalse(JobQueueEntrParamCard."Parameter Description".Editable(), 'The Parameter Description on the parameter card page should not be editable');

        JobQueueEntrParamCard.Close();
    end;

    [Test]
    procedure ModifyJobQueEntrParamValueIsPossibleFromCardPageWhenJobQEntryIsOnHold()
    var
        JobQueueEntrParamCard: TestPage ADD_JobQueueEntrParamCard;
        JobQueueEntry: Record "Job Queue Entry";
        JobQEntryParams: Record "ADD_JobQueueEntryParameter";
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
    begin
        // [SCENARIO] Modifying Job Queue Entry Parameter Value from Parameter Card Page should be possible when Job Queue Entry is On Hold 
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template
        // [GIVEN] A Job Queue Entry with parameters from this template
        CreateJobQEntryWithSampleParams(JobQueueEntry, JobQEntryParams, JobQueueEntryParamTemplate);

        // [GIVEN] The Job Queue Entry is On Hold
        JobQueueEntry.Status := JobQueueEntry.Status::"On Hold";
        JobQueueEntry.Modify(False);

        // [GIVEN] A Job Queue Entry Parameter Card Page opened with the parameters
        JobQueueEntrParamCard.OpenEdit();
        JobQueueEntrParamCard.GoToRecord(JobQEntryParams);

        // [WHEN] Attempting to edit Parameter Value on the card page
        // [THEN] Modifying a Job Queue Entry Parameter Value from the Card Page should not be possible
        //TODO: it shoould check each possible value type
        Assert.IsTrue(JobQueueEntrParamCard."Text Value".Editable(), 'The Parameter Value on the parameter card page should be editable');

        JobQueueEntrParamCard.Close();
    end;

    [Test]
    procedure ModifyJobQueEntrParamValueIsNotPossibleFromCardPageWhenJobQEntryIsNotOnHold()
    var
        JobQueueEntrParamCard: TestPage ADD_JobQueueEntrParamCard;
        JobQueueEntry: Record "Job Queue Entry";
        JobQEntryParams: Record "ADD_JobQueueEntryParameter";
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
    begin
        // [SCENARIO] Modifying Job Queue Entry Parameter Value from Parameter Card Page should not be possible when Job Queue Entry is not On Hold
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template
        // [GIVEN] A Job Queue Entry with parameters from this template
        CreateJobQEntryWithSampleParams(JobQueueEntry, JobQEntryParams, JobQueueEntryParamTemplate);

        // [GIVEN] The Job Queue Entry is not On Hold
        //TODO: it should check each possible status <> OnHold
        JobQueueEntry.Status := JobQueueEntry.Status::Ready;
        JobQueueEntry.Modify(False);

        // [GIVEN] A Job Queue Entry Parameter Card Page opened with the parameters
        JobQueueEntrParamCard.OpenEdit();
        JobQueueEntrParamCard.GoToRecord(JobQEntryParams);

        // [WHEN] Attempting to edit Parameter Value on the card page
        // [THEN] Modifying a Job Queue Entry Parameter Value from the Card Page should not be possible
        //TODO: it shoould check each possible value type
        Assert.IsFalse(JobQueueEntrParamCard."Text Value".Editable(), 'The Parameter Value on the parameter card page should not be editable');

        JobQueueEntrParamCard.Close();
    end;

    [Test]
    procedure ModifyJobQueEntrParamObjTypeIsNotPossibleFromCardPage()
    var
        JobQueueEntrParamCard: TestPage ADD_JobQueueEntrParamCard;
        JobQueueEntry: Record "Job Queue Entry";
        JobQEntryParams: Record "ADD_JobQueueEntryParameter";
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
    begin
        // [SCENARIO] Modifying Job Queue Entry Parameter Object Type from Card Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template
        // [GIVEN] A Job Queue Entry with parameters from this template
        // [GIVEN] A Job Queue Entry Parameter Card Page opened with the parameters
        CreateJobQEntryWithSampleParamsAndOpenItInParamCardPageEditMode(JobQueueEntry, JobQEntryParams, JobQueueEntryParamTemplate, JobQueueEntrParamCard);

        // [WHEN] Attempting to edit Parameter Object Type on the card page
        // [THEN] Modifying a Job Queue Entry Parameter Object Type from the Card Page should not be possible
        Assert.IsFalse(JobQueueEntrParamCard."Object Type".Editable(), 'The Parameter Object Type on the parameter card page should not be editable');

        JobQueueEntrParamCard.Close();
    end;

    [Test]
    procedure ModifyJobQueEntrParamObjIDIsNotPossibleFromCardPage()
    var
        JobQueueEntrParamCard: TestPage ADD_JobQueueEntrParamCard;
        JobQueueEntry: Record "Job Queue Entry";
        JobQEntryParams: Record "ADD_JobQueueEntryParameter";
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
    begin
        // [SCENARIO] Modifying Job Queue Entry Parameter Object ID from Card Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template
        // [GIVEN] A Job Queue Entry with parameters from this template
        // [GIVEN] A Job Queue Entry Parameter Card Page opened with the parameters
        CreateJobQEntryWithSampleParamsAndOpenItInParamCardPageEditMode(JobQueueEntry, JobQEntryParams, JobQueueEntryParamTemplate, JobQueueEntrParamCard);

        // [WHEN] Attempting to edit Parameter Object ID on the card page
        // [THEN] Modifying a Job Queue Entry Parameter Object ID from the Card Page should not be possible
        Assert.IsFalse(JobQueueEntrParamCard."Object ID".Editable(), 'The Parameter Object ID on the parameter card page should not be editable');

        JobQueueEntrParamCard.Close();
    end;

    [Test]
    procedure ModifyJobQueEntrParamParamNameIsNotPossibleFromCardPage()
    var
        JobQueueEntrParamCard: TestPage ADD_JobQueueEntrParamCard;
        JobQueueEntry: Record "Job Queue Entry";
        JobQEntryParams: Record "ADD_JobQueueEntryParameter";
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
    begin
        // [SCENARIO] Modifying Job Queue Entry Parameter Parameter Name from Card Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template
        // [GIVEN] A Job Queue Entry with parameters from this template
        // [GIVEN] A Job Queue Entry Parameter Card Page opened with the parameters
        CreateJobQEntryWithSampleParamsAndOpenItInParamCardPageEditMode(JobQueueEntry, JobQEntryParams, JobQueueEntryParamTemplate, JobQueueEntrParamCard);

        // [WHEN] Attempting to edit Parameter Parameter Name on the card page
        // [THEN] Modifying a Job Queue Entry Parameter Parameter Name from the Card Page should not be possible
        Assert.IsFalse(JobQueueEntrParamCard."Parameter Name".Editable(), 'The Parameter Parameter Name on the parameter card page should not be editable');

        JobQueueEntrParamCard.Close();
    end;

    [Test]
    procedure ModifyJobQueEntrParamParamTypeIsNotPossibleFromCardPage()
    var
        JobQueueEntrParamCard: TestPage ADD_JobQueueEntrParamCard;
        JobQueueEntry: Record "Job Queue Entry";
        JobQEntryParams: Record "ADD_JobQueueEntryParameter";
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
    begin
        // [SCENARIO] Modifying Job Queue Entry Parameter Parameter Type from Card Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template
        // [GIVEN] A Job Queue Entry with parameters from this template
        // [GIVEN] A Job Queue Entry Parameter Card Page opened with the parameters
        CreateJobQEntryWithSampleParamsAndOpenItInParamCardPageEditMode(JobQueueEntry, JobQEntryParams, JobQueueEntryParamTemplate, JobQueueEntrParamCard);

        // [WHEN] Attempting to edit Parameter Parameter Type on the card page
        // [THEN] Modifying a Job Queue Entry Parameter Parameter Type from the Card Page should not be possible
        Assert.IsFalse(JobQueueEntrParamCard."Parameter Type".Editable(), 'The Parameter Parameter Type on the parameter card page should not be editable');

        JobQueueEntrParamCard.Close();
    end;

    [Test]
    procedure JobQueEntrParamSubformPageIsVisibleOnJobQueEntryCardPage()
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        JobQEntryParams: Record "ADD_JobQueueEntryParameter";
        JobQueueEntryCard: TestPage "Job Queue Entry Card";
    begin
        // [SCENARIO] Job Queue Entry Parameter Subform Page should be visible on Job Queue Entry Card Page
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template
        // [GIVEN] A Job Queue Entry with parameters from this template
        CreateJobQEntryWithSampleParams(JobQueueEntry, JobQEntryParams, JobQueueEntryParamTemplate);

        // [WHEN] Job Queue Entry Card Page is opened
        JobQueueEntryCard.OpenEdit();
        JobQueueEntryCard.GoToRecord(JobQueueEntry);

        // [THEN] The Job Queue Entry Parameter Subform Page should be accessible and functional
        Assert.IsTrue(JobQueueEntryCard.JobQueueEntryParameters.First(), 'The Job Queue Entry Parameter Subform should be accessible and contain parameters');

        JobQueueEntryCard.Close();
    end;

    [Test]
    procedure JobQueEntrParamSubformPageDisplayOnlyParametersRelatedToTheJobQue()
    var
        JobQueueEntry1: Record "Job Queue Entry";
        JobQueueEntry2: Record "Job Queue Entry";
        JobQueueEntryParamTemplate1: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntryParamTemplate2: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntryParameterMgt: Codeunit "ADD_JobQueueEntryParameterMgt";
        JobQueueEntryCard: TestPage "Job Queue Entry Card";
        ParameterCount: Integer;
        ObjType: Integer;
        ObjId: Integer;
    begin
        // [SCENARIO] Job Queue Entry Parameter Subform Page should display only parameters related to the Job Queue Entry
        Initialize();

        // [GIVEN] Create 2 Job Queue Entry Parameter Templates, Job Queue Entries and Job Queue Entry Parameter
        GetTestCu1ForJobQueueEntry(ObjType, ObjId);
        CreateJqeParamTemplWithGivenValueAndCreateJobQEntry(ObjType, ObjId, JobQueueEntry1, JobQueueEntryParamTemplate1, 'Param1', JobQueueEntryParamTemplate1.FieldNo("Text Value"), 'Value1');
        GetTestCu2ForJobQueueEntry(ObjType, ObjId);
        CreateJqeParamTemplWithGivenValueAndCreateJobQEntry(ObjType, ObjId, JobQueueEntry2, JobQueueEntryParamTemplate2, 'Param2', JobQueueEntryParamTemplate2.FieldNo("Text Value"), 'Value2');

        // [WHEN] Job Queue Entry Card Page is opened for the first Job Queue Entry
        JobQueueEntryCard.OpenEdit();
        JobQueueEntryCard.GoToRecord(JobQueueEntry1);

        // [THEN] The Job Queue Entry Parameter Subform should display only parameters related to the first Job Queue Entry
        Assert.IsTrue(JobQueueEntryCard.JobQueueEntryParameters.First(), 'The subform should contain at least one parameter');

        // [THEN] Verify the parameter belongs to the correct Job Queue Entry
        Assert.AreEqual('Param1', JobQueueEntryCard.JobQueueEntryParameters."Parameter Name".Value, 'The parameter name should match');

        // [THEN] Verify only one parameter is displayed (the one for this Job Queue Entry)
        ParameterCount := 0;
        repeat
            ParameterCount += 1;
        until not JobQueueEntryCard.JobQueueEntryParameters.Next();
        Assert.AreEqual(1, ParameterCount, 'The subform should display only one parameter related to the Job Queue Entry');

        JobQueueEntryCard.Close();
    end;

    [Test]
    procedure ModifyJobQueEntrParamIsNotPossibleFromSubformPage()
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        JobQEntryParams: Record "ADD_JobQueueEntryParameter";
        JobQueueEntryCard: TestPage "Job Queue Entry Card";
    begin
        // [SCENARIO] Modifying Job Queue Entry Parameter from Subform Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template
        // [GIVEN] A Job Queue Entry with parameters from this template
        CreateJobQEntryWithSampleParams(JobQueueEntry, JobQEntryParams, JobQueueEntryParamTemplate);

        // [WHEN] Job Queue Entry Card Page is opened
        JobQueueEntryCard.OpenEdit();
        JobQueueEntryCard.GoToRecord(JobQueueEntry);

        // [THEN] Modifying a Job Queue Entry Parameter from the Subform Page should not be possible
        Assert.IsFalse(JobQueueEntryCard.JobQueueEntryParameters.Editable(), 'The Job Queue Entry Parameter Subform should not be editable');

        JobQueueEntryCard.Close();
    end;

    [Test]
    procedure CreateJobQueEntrParamIsNotPossibleFromSubformPage()
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        JobQEntryParams: Record "ADD_JobQueueEntryParameter";
        JobQueueEntryCard: TestPage "Job Queue Entry Card";
    begin
        // [SCENARIO] Creating Job Queue Entry Parameter from Subform Page should not be possible
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template
        // [GIVEN] A Job Queue Entry with parameters from this template
        CreateJobQEntryWithSampleParams(JobQueueEntry, JobQEntryParams, JobQueueEntryParamTemplate);

        // [WHEN] Job Queue Entry Card Page is opened
        JobQueueEntryCard.OpenEdit();
        JobQueueEntryCard.GoToRecord(JobQueueEntry);

        // [THEN] Creating a Job Queue Entry Parameter from the Subform Page should not be possible
        asserterror JobQueueEntryCard.JobQueueEntryParameters.New();
        Assert.ExpectedErrorCode('DB:ClientInsertDenied');

        JobQueueEntryCard.Close();
    end;

    [Test]
    procedure JobQueEntryParamsAreCreatedWhenTemplExistsAndJobQueEntryIsCreated()
    var
        JobQueueEntry1: Record "Job Queue Entry";
        JobQueueEntry2: Record "Job Queue Entry";
        JobQueueEntryParamTemplate1: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntryParamTemplate2: Record "ADD_JobQueueEntryParamTemplate";
        JobQEntryParams: Record "ADD_JobQueueEntryParameter";
        JobQEntryParamsCount: Integer;
        ObjType: Integer;
        ObjId: Integer;
    begin
        // [SCENARIO] Job Queue Entry Parameters should be created when a Job Queue Entry is created with an existing template
        Initialize();

        // [GIVEN] Create 2 Job Queue Entry Parameter Templates, Job Queue Entries and Job Queue Entry Parameter
        GetTestCu1ForJobQueueEntry(ObjType, ObjId);
        CreateJqeParamTemplWithGivenValueAndCreateJobQEntry(ObjType, ObjId, JobQueueEntry1, JobQueueEntryParamTemplate1, 'Param1', JobQueueEntryParamTemplate1.FieldNo("Text Value"), 'Value1');
        GetTestCu2ForJobQueueEntry(ObjType, ObjId);
        CreateJqeParamTemplWithGivenValueAndCreateJobQEntry(ObjType, ObjId, JobQueueEntry2, JobQueueEntryParamTemplate2, 'Param2', JobQueueEntryParamTemplate2.FieldNo("Text Value"), 'Value2');

        // [THEN] Job Queue Entry Parameters should be created only from the related template
        JobQEntryParams.SetRange("Job Queue Entry ID", JobQueueEntry1.ID);
        JobQEntryParamsCount := JobQEntryParams.Count();
        Assert.AreEqual(1, JobQEntryParamsCount, 'Job Queue Entry Parameters should be created');

        JobQEntryParams.FindFirst();
        // [THEN] Job Queue Entry Parameters should have the same Parameter name as the template
        Assert.AreEqual(JobQEntryParams."Parameter Name", JobQueueEntryParamTemplate1."Parameter Name", 'Parameter Name should match the Parameter Name from template');

        // [THEN] Job Queue Entry Parameters should have the same Parameter value as the template
        Assert.AreEqual(JobQEntryParams."Text Value", JobQueueEntryParamTemplate1."Text Value", 'Text Value should match the Text Value from template');
    end;

    [Test]
    procedure JobQueEntryParamsAreNotCreatedWhenTemplDoesNotExistAndJobQueEntryIsCreated()
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQEnParamTempl: Record ADD_JobQueueEntryParamTemplate;
        JobQEnParam: Record ADD_JobQueueEntryParameter;
        ObjType: Integer;
        ObjId: Integer;
    begin
        // [SCENARIO] Job Queue Entry Parameters should not be created when a Job Queue Entry is created without an existing template
        Initialize();

        // [GIVEN] A Job Queue Entry Parameter Template exists
        CreateSampleTextJqeParamTempl(JobQEnParamTempl);

        // [WHEN] A Job Queue Entry is created for different object than already existing Template
        GetTestCu2ForJobQueueEntry(ObjType, ObjId);
        CreateJobQueueEntryForCu(ObjId, JobQueueEntry);

        // [GIVEN] A Job Queue Entry Parameter Template for the new Job Queue Entry does not exist
        JobQEnParamTempl.Reset();
        JobQEnParamTempl.SetRange("Object ID", JobQueueEntry."Object ID to Run");
        JobQEnParamTempl.SetRange("Object Type", JobQueueEntry."Object Type to Run");
        Assert.IsFalse(JobQEnParamTempl.FindFirst(), 'Job Queue Entry Parameter Template should not exist');

        // [THEN] Job Queue Entry Parameters for the new Job Queue Entry should not be created
        JobQEnParam.SetRange("Job Queue Entry ID", JobQueueEntry.ID);
        Assert.IsFalse(JobQEnParam.FindFirst(), 'Job Queue Entry Parameters should not be created');
    end;

    [Test]
    procedure JobQueEntryParamsAreDeletedWhenJobQueEntryIsDeleted()
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        JobQEntryParams: Record "ADD_JobQueueEntryParameter";
        ObjType: Integer;
        ObjId: Integer;
    begin
        // [SCENARIO] Job Queue Entry Parameters should be deleted when a Job Queue Entry is deleted
        Initialize();

        // [GIVEN] Create 2 Job Queue Entry Parameter Templates, Job Queue Entries and Job Queue Entry Parameter
        GetTestCu1ForJobQueueEntry(ObjType, ObjId);
        CreateJqeParamTemplWithGivenValueAndCreateJobQEntry(ObjType, ObjId, JobQueueEntry, JobQueueEntryParamTemplate, 'Param1', JobQueueEntryParamTemplate.FieldNo("Text Value"), 'Value1');

        // [WHEN] The Job Queue Entry is deleted
        JobQueueEntry.Delete(True);

        // [THEN] Job Queue Entry Parameters should be deleted
        JobQEntryParams.Reset();
        JobQEntryParams.SetRange("Job Queue Entry ID", JobQueueEntry.ID);
        Assert.AreEqual(0, JobQEntryParams.Count(), 'Job Queue Entry Parameters should be deleted');
    end;

    [Test]
    procedure OverwriteJobQueEntryParamsWhenJobQueEntryObjIdIsChanged()
    var
        JobQueueEntry1: Record "Job Queue Entry";
        JobQueueEntry2: Record "Job Queue Entry";
        JobQueueEntryParamTemplate1: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntryParamTemplate2: Record "ADD_JobQueueEntryParamTemplate";
        JobQEntryParams: Record "ADD_JobQueueEntryParameter";
        JobQEntryParamsCount: Integer;
        ObjType: Integer;
        ObjId: Integer;
    begin
        // [SCENARIO] Job Queue Entry Parameters should be overwritten when the Object ID of a Job Queue Entry is changed   
        Initialize();

        // [GIVEN] Create 2 Job Queue Entry Parameter Templates, Job Queue Entries and Job Queue Entry Parameter
        GetTestCu1ForJobQueueEntry(ObjType, ObjId);
        CreateJqeParamTemplWithGivenValueAndCreateJobQEntry(ObjType, ObjId, JobQueueEntry1, JobQueueEntryParamTemplate1, 'Param1', JobQueueEntryParamTemplate1.FieldNo("Text Value"), 'Value1');
        GetTestCu2ForJobQueueEntry(ObjType, ObjId);
        CreateJqeParamTemplWithGivenValueAndCreateJobQEntry(ObjType, ObjId, JobQueueEntry2, JobQueueEntryParamTemplate2, 'Param2', JobQueueEntryParamTemplate2.FieldNo("Text Value"), 'Value2');

        // [WHEN] The Object ID of the Job Queue Entry is changed
        JobQueueEntry1."Object ID to Run" := JobQueueEntryParamTemplate2."Object ID";
        JobQueueEntry1.Modify(True);

        // [THEN] Job Queue Entry Parameters should be overwritten with the ones for a new Object ID
        JobQEntryParams.Reset();
        JobQEntryParams.SetRange("Job Queue Entry ID", JobQueueEntry1.ID);
        JobQEntryParams.FindFirst();
        Assert.AreEqual(1, JobQEntryParams.Count(), 'Job Queue Entry Parameters should be created');

        // [THEN] Job Queue Entry Parameters should have the same Parameter name as the template
        Assert.AreEqual(JobQueueEntryParamTemplate2."Parameter Name", JobQEntryParams."Parameter Name", 'Parameter Name should match the Parameter Name from template');

        // [THEN] Job Queue Entry Parameters should have the same Parameter value as the template
        Assert.AreEqual(JobQueueEntryParamTemplate2."Text Value", JobQEntryParams."Text Value", 'Text Value should match the Text Value from template');
    end;

    [Test]
    procedure OverwriteJobQueEntryParamsWhenJobQueEntryObjTypeIsChanged()
    var
        JobQueueEntry1: Record "Job Queue Entry";
        JobQueueEntry2: Record "Job Queue Entry";
        JobQueueEntryParamTemplate1: Record "ADD_JobQueueEntryParamTemplate";
        JobQueueEntryParamTemplate2: Record "ADD_JobQueueEntryParamTemplate";
        JobQEntryParams: Record "ADD_JobQueueEntryParameter";
        JobQEntryParamsCount: Integer;
        ObjType: Integer;
        ObjId: Integer;
    begin
        // [SCENARIO] Job Queue Entry Parameters should be overwritten when the Object ID of a Job Queue Entry is changed   
        Initialize();

        // [GIVEN] Create 2 Job Queue Entry Parameter Templates, Job Queue Entries and Job Queue Entry Parameter
        GetTestCu1ForJobQueueEntry(ObjType, ObjId);
        CreateJqeParamTemplWithGivenValueAndCreateJobQEntry(ObjType, ObjId, JobQueueEntry1, JobQueueEntryParamTemplate1, 'Param1', JobQueueEntryParamTemplate1.FieldNo("Text Value"), 'Value1');
        GetTestRep1ForJobQueueEntry(ObjType, ObjId);
        CreateJqeParamTemplWithGivenValueAndCreateJobQEntry(ObjType, ObjId, JobQueueEntry2, JobQueueEntryParamTemplate2, 'Param2', JobQueueEntryParamTemplate2.FieldNo("Text Value"), 'Value2');

        // [WHEN] The Object Type of the Job Queue Entry is changed
        JobQueueEntry1."Object Type to Run" := JobQueueEntryParamTemplate2."Object Type";
        JobQueueEntry1."Object ID to Run" := JobQueueEntryParamTemplate2."Object ID";
        JobQueueEntry1.Modify(True);

        // [THEN] Job Queue Entry Parameters should be overwritten with the ones for a new Object type
        JobQEntryParams.Reset();
        JobQEntryParams.SetRange("Job Queue Entry ID", JobQueueEntry1.ID);
        JobQEntryParams.FindFirst();
        Assert.AreEqual(1, JobQEntryParams.Count(), 'Job Queue Entry Parameters should be created');

        // [THEN] Job Queue Entry Parameters should have the same Parameter name as the template
        Assert.AreEqual(JobQueueEntryParamTemplate2."Parameter Name", JobQEntryParams."Parameter Name", 'Parameter Name should match the Parameter Name from template');

        // [THEN] Job Queue Entry Parameters should have the same Parameter value as the template
        Assert.AreEqual(JobQueueEntryParamTemplate2."Text Value", JobQEntryParams."Text Value", 'Text Value should match the Text Value from template');
    end;

    [Test]
    procedure CorrectParamValueIsDisplayedOnJobQEntryParamTemplListPage()
    var
        JobQueueEntrParamTemplates: TestPage ADD_JobQueueEntrParamTemplates;
        ObjType: Integer;
        ObjId: Integer;
    begin
        //[SCENARIO] Correct Parameter Value should be displayed on Job Queue Entry Parameter Template List Page
        Initialize();

        // [GIVEN] Job Queue Entry Parameter Templates with different parameter types and values
        GetTestCu1ForJobQueueEntry(ObjType, ObjId);
        CreateJqeParamTemplWithAllPossParamTypeAndJobQueueEntry(ObjType, ObjId);

        // [WHEN] The Job Queue Entry Parameter Template List Page is opened
        JobQueueEntrParamTemplates.OpenView();

        // [THEN] The correct Parameter Value should be displayed on the list page for each parameter template
        Assert.IsTrue(JobQueueEntrParamTemplates.First(), 'Should be able to navigate to first record');
        repeat
            TestDefaultParamValue(JobQueueEntrParamTemplates."Object Type".AsInteger(), JobQueueEntrParamTemplates."Object ID".AsInteger(), JobQueueEntrParamTemplates."Parameter Name".Value, JobQueueEntrParamTemplates."Parameter Value".Value);
        until not JobQueueEntrParamTemplates.Next();

        JobQueueEntrParamTemplates.Close();
    end;

    [Test]
    procedure CorrectParamValueIsDisplayedOnJobQEntryParamListPage()
    var
        JobQueueEntrParameters: TestPage ADD_JobQueueEntryParameters;
        ObjType: Integer;
        ObjId: Integer;
    begin
        //[SCENARIO] Correct Parameter Value should be displayed on Job Queue Entry Parameter List Page
        Initialize();

        // [GIVEN] Job Queue Entry Parameter Templates with different parameter types and values, Job Queue Entry and Job Queue Entry Parameters
        GetTestCu1ForJobQueueEntry(ObjType, ObjId);
        CreateJqeParamTemplWithAllPossParamTypeAndJobQueueEntry(ObjType, ObjId);

        // [WHEN] The Job Queue Entry Parameter List Page is opened
        JobQueueEntrParameters.OpenView();

        // [THEN] The correct Parameter Value should be displayed on the list page for each parameter template
        Assert.IsTrue(JobQueueEntrParameters.First(), 'Should be able to navigate to first record');
        repeat
            TestDefaultParamValue(JobQueueEntrParameters."Object Type".AsInteger(), JobQueueEntrParameters."Object ID".AsInteger(), JobQueueEntrParameters."Parameter Name".Value, JobQueueEntrParameters."Parameter Value".Value);
        until not JobQueueEntrParameters.Next();

        JobQueueEntrParameters.Close();
    end;

    [Test]
    procedure CorrectParamValueIsDisplayedOnJobQEntryParamSubformListPage()
    var
        JobQueueEntryCard: TestPage "Job Queue Entry Card";
        JobQueueEntry: Record "Job Queue Entry";
        ObjType: Integer;
        ObjId: Integer;
    begin
        //[SCENARIO] Correct Parameter Value should be displayed on Job Queue Entry Parameter Subform Page
        Initialize();

        // [GIVEN] Job Queue Entry Parameter Templates with different parameter types and values, Job Queue Entry and Job Queue Entry Parameters
        GetTestCu1ForJobQueueEntry(ObjType, ObjId);
        CreateJqeParamTemplWithAllPossParamTypeAndJobQueueEntry(ObjType, ObjId);

        // [WHEN] Job queue entry card page is opened
        JobQueueEntry.SetRange("Object ID to Run", ObjId);
        JobQueueEntry.SetRange("Object Type to Run", ObjType);
        JobQueueEntry.FindFirst();
        JobQueueEntryCard.OpenView();
        JobQueueEntryCard.GoToRecord(JobQueueEntry);

        // [THEN] The correct Parameter Value should be displayed on the subform page for each parameter template
        Assert.IsTrue(JobQueueEntryCard.JobQueueEntryParameters.First(), 'Should be able to navigate to first record');
        repeat
            TestDefaultParamValue(JobQueueEntry."Object Type to Run", JobQueueEntry."Object ID to Run", JobQueueEntryCard.JobQueueEntryParameters."Parameter Name".Value, JobQueueEntryCard.JobQueueEntryParameters."Parameter Value".Value);
        until not JobQueueEntryCard.JobQueueEntryParameters.Next();

        JobQueueEntryCard.Close();
    end;

    [Test]
    procedure CorrectParamValueIsVisibleOnJobQEntryParamTemplCardPage()
    var
        JobQueueEntryParamTemplCard: TestPage ADD_JobQueueEntrParamTemplCard;
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        ObjType: Integer;
        ObjId: Integer;
    begin
        //[SCENARIO] Correct Parameter Value should be Visible on Job Queue Entry Parameter Template Card Page
        Initialize();

        // [GIVEN] Job Queue Entry Parameter Templates with different parameter types and values, Job Queue Entry and Job Queue Entry Parameters
        GetTestCu1ForJobQueueEntry(ObjType, ObjId);
        CreateJqeParamTemplWithAllPossParamTypeAndJobQueueEntry(ObjType, ObjId);

        // [WHEN] Job Queue Entry Parameter Template Card Page is opened
        JobQueueEntryParamTemplate.SetRange("Object ID", ObjId);
        JobQueueEntryParamTemplate.SetRange("Object Type", ObjType);
        JobQueueEntryParamTemplate.FindSet();
        JobQueueEntryParamTemplCard.OpenView();
        repeat
            JobQueueEntryParamTemplCard.GoToRecord(JobQueueEntryParamTemplate);
            // [THEN] The correct value should be visible
            case JobQueueEntryParamTemplate."Parameter Type" of
                JobQueueEntryParamTemplate.FieldNo("BigInteger Value"):
                    Assert.IsTrue(JobQueueEntryParamTemplCard."BigInteger Value".Visible(), 'BigInteger Value should be visible');
                JobQueueEntryParamTemplate.FieldNo("Boolean Value"):
                    Assert.IsTrue(JobQueueEntryParamTemplCard."Boolean Value".Visible(), 'Boolean Value should be visible');
                JobQueueEntryParamTemplate.FieldNo("Code Value"):
                    Assert.IsTrue(JobQueueEntryParamTemplCard."Code Value".Visible(), 'Code Value should be visible');
                JobQueueEntryParamTemplate.FieldNo("Date Value"):
                    Assert.IsTrue(JobQueueEntryParamTemplCard."Date Value".Visible(), 'Date Value should be visible');
                JobQueueEntryParamTemplate.FieldNo("DateFormula Value"):
                    Assert.IsTrue(JobQueueEntryParamTemplCard."DateFormula Value".Visible(), 'DateFormula Value should be visible');
                JobQueueEntryParamTemplate.FieldNo("DateTime Value"):
                    Assert.IsTrue(JobQueueEntryParamTemplCard."DateTime Value".Visible(), 'DateTime Value should be visible');
                JobQueueEntryParamTemplate.FieldNo("Decimal Value"):
                    Assert.IsTrue(JobQueueEntryParamTemplCard."Decimal Value".Visible(), 'Decimal Value should be visible');
                JobQueueEntryParamTemplate.FieldNo("Duration Value"):
                    Assert.IsTrue(JobQueueEntryParamTemplCard."Duration Value".Visible(), 'Duration Value should be visible');
                JobQueueEntryParamTemplate.FieldNo("Guid Value"):
                    Assert.IsTrue(JobQueueEntryParamTemplCard."Guid Value".Visible(), 'Guid Value should be visible');
                JobQueueEntryParamTemplate.FieldNo("Integer Value"):
                    Assert.IsTrue(JobQueueEntryParamTemplCard."Integer Value".Visible(), 'Integer Value should be visible');
                JobQueueEntryParamTemplate.FieldNo("Text Value"):
                    Assert.IsTrue(JobQueueEntryParamTemplCard."Text Value".Visible(), 'Text Value should be visible');
                JobQueueEntryParamTemplate.FieldNo("Time Value"):
                    Assert.IsTrue(JobQueueEntryParamTemplCard."Time Value".Visible(), 'Time Value should be visible');
            end;
        until JobQueueEntryParamTemplate.Next() = 0;

        JobQueueEntryParamTemplCard.Close();
    end;

    [Test]
    procedure CorrectParamValueIsVisibleOnJobQEntryParamCardPage()
    var
        JobQueueEntryParamCard: TestPage ADD_JobQueueEntrParamCard;
        JobQueueEntryParam: Record "ADD_JobQueueEntryParameter";
        ObjType: Integer;
        ObjId: Integer;
    begin
        //[SCENARIO] Correct Parameter Value should be Visible on Job Queue Entry Parameter Template Card Page
        Initialize();

        // [GIVEN] Job Queue Entry Parameter Templates with different parameter types and values, Job Queue Entry and Job Queue Entry Parameters
        GetTestCu1ForJobQueueEntry(ObjType, ObjId);
        CreateJqeParamTemplWithAllPossParamTypeAndJobQueueEntry(ObjType, ObjId);

        // [WHEN] Job Queue Entry Parameter Template Card Page is opened
        JobQueueEntryParam.SetRange("Object ID", ObjId);
        JobQueueEntryParam.SetRange("Object Type", ObjType);
        JobQueueEntryParam.FindSet();
        JobQueueEntryParamCard.OpenView();
        repeat
            JobQueueEntryParamCard.GoToRecord(JobQueueEntryParam);
            // [THEN] The correct value should be visible
            case JobQueueEntryParam."Parameter Type" of
                JobQueueEntryParam.FieldNo("BigInteger Value"):
                    Assert.IsTrue(JobQueueEntryParamCard."BigInteger Value".Visible(), 'BigInteger Value should be visible');
                JobQueueEntryParam.FieldNo("Boolean Value"):
                    Assert.IsTrue(JobQueueEntryParamCard."Boolean Value".Visible(), 'Boolean Value should be visible');
                JobQueueEntryParam.FieldNo("Code Value"):
                    Assert.IsTrue(JobQueueEntryParamCard."Code Value".Visible(), 'Code Value should be visible');
                JobQueueEntryParam.FieldNo("Date Value"):
                    Assert.IsTrue(JobQueueEntryParamCard."Date Value".Visible(), 'Date Value should be visible');
                JobQueueEntryParam.FieldNo("DateFormula Value"):
                    Assert.IsTrue(JobQueueEntryParamCard."DateFormula Value".Visible(), 'DateFormula Value should be visible');
                JobQueueEntryParam.FieldNo("DateTime Value"):
                    Assert.IsTrue(JobQueueEntryParamCard."DateTime Value".Visible(), 'DateTime Value should be visible');
                JobQueueEntryParam.FieldNo("Decimal Value"):
                    Assert.IsTrue(JobQueueEntryParamCard."Decimal Value".Visible(), 'Decimal Value should be visible');
                JobQueueEntryParam.FieldNo("Duration Value"):
                    Assert.IsTrue(JobQueueEntryParamCard."Duration Value".Visible(), 'Duration Value should be visible');
                JobQueueEntryParam.FieldNo("Guid Value"):
                    Assert.IsTrue(JobQueueEntryParamCard."Guid Value".Visible(), 'Guid Value should be visible');
                JobQueueEntryParam.FieldNo("Integer Value"):
                    Assert.IsTrue(JobQueueEntryParamCard."Integer Value".Visible(), 'Integer Value should be visible');
                JobQueueEntryParam.FieldNo("Text Value"):
                    Assert.IsTrue(JobQueueEntryParamCard."Text Value".Visible(), 'Text Value should be visible');
                JobQueueEntryParam.FieldNo("Time Value"):
                    Assert.IsTrue(JobQueueEntryParamCard."Time Value".Visible(), 'Time Value should be visible');
            end;
        until JobQueueEntryParam.Next() = 0;

        JobQueueEntryParamCard.Close();
    end;

    [Test]
    procedure CorrectParamTypeIsDisplayedOnJobQEntryParamTemplListPage()
    var
        JobQueueEntrParamTemplates: TestPage ADD_JobQueueEntrParamTemplates;
        ObjType: Integer;
        ObjId: Integer;
    begin
        //[SCENARIO] Correct Parameter Type should be displayed on Job Queue Entry Parameter Template List Page
        Initialize();

        // [GIVEN] Job Queue Entry Parameter Templates with different parameter types and values
        GetTestCu1ForJobQueueEntry(ObjType, ObjId);
        CreateJqeParamTemplWithAllPossParamTypeAndJobQueueEntry(ObjType, ObjId);

        // [WHEN] The Job Queue Entry Parameter Template List Page is opened
        JobQueueEntrParamTemplates.OpenView();

        // [THEN] The correct Parameter Type should be displayed on the list page
        Assert.IsTrue(JobQueueEntrParamTemplates.First(), 'Should be able to navigate to first record');
        repeat
            TestParamType(JobQueueEntrParamTemplates."Object Type".AsInteger(), JobQueueEntrParamTemplates."Object ID".AsInteger(), JobQueueEntrParamTemplates."Parameter Name".Value, JobQueueEntrParamTemplates."Parameter Type".Value);
        until not JobQueueEntrParamTemplates.Next();

        JobQueueEntrParamTemplates.Close();
    end;

    [Test]
    procedure CorrectParamTypeIsDisplayedOnJobQEntryParamListPage()
    var
        JobQueueEntrParameters: TestPage ADD_JobQueueEntryParameters;
        ObjType: Integer;
        ObjId: Integer;
    begin
        //[SCENARIO] Correct Parameter Type should be displayed on Job Queue Entry Parameter List Page
        Initialize();

        // [GIVEN] Job Queue Entry Parameter Templates with different parameter types and values
        GetTestCu1ForJobQueueEntry(ObjType, ObjId);
        CreateJqeParamTemplWithAllPossParamTypeAndJobQueueEntry(ObjType, ObjId);

        // [WHEN] The Job Queue Entry Parameter List Page is opened
        JobQueueEntrParameters.OpenView();

        // [THEN] The correct Parameter Type should be displayed on the list page
        Assert.IsTrue(JobQueueEntrParameters.First(), 'Should be able to navigate to first record');
        repeat
            TestParamType(JobQueueEntrParameters."Object Type".AsInteger(), JobQueueEntrParameters."Object ID".AsInteger(), JobQueueEntrParameters."Parameter Name".Value, JobQueueEntrParameters."Parameter Type".Value);
        until not JobQueueEntrParameters.Next();

        JobQueueEntrParameters.Close();
    end;

    [Test]
    procedure CorrectParamTypeIsDisplayedOnJobQEntryParamSubformListPage()
    var
        JobQueueEntryCard: TestPage "Job Queue Entry Card";
        JobQueueEntry: Record "Job Queue Entry";
        ObjType: Integer;
        ObjId: Integer;
    begin
        //[SCENARIO] Correct Parameter Type should be displayed on Job Queue Entry Parameter List Page
        Initialize();

        // [GIVEN] Job Queue Entry Parameter Templates with different parameter types and values
        GetTestCu1ForJobQueueEntry(ObjType, ObjId);
        CreateJqeParamTemplWithAllPossParamTypeAndJobQueueEntry(ObjType, ObjId);

        // [WHEN] Job queue entry card page is opened
        JobQueueEntry.SetRange("Object ID to Run", ObjId);
        JobQueueEntry.SetRange("Object Type to Run", ObjType);
        JobQueueEntry.FindFirst();
        JobQueueEntryCard.OpenView();
        JobQueueEntryCard.GoToRecord(JobQueueEntry);

        // [THEN] The correct Parameter Type should be displayed on the subform page
        Assert.IsTrue(JobQueueEntryCard.JobQueueEntryParameters.First(), 'Should be able to navigate to first record');
        repeat
            TestParamType(JobQueueEntry."Object Type to Run", JobQueueEntry."Object ID to Run", JobQueueEntryCard.JobQueueEntryParameters."Parameter Name".Value, JobQueueEntryCard.JobQueueEntryParameters."Parameter Type".Value);
        until not JobQueueEntryCard.JobQueueEntryParameters.Next();

        JobQueueEntryCard.Close();
    end;

    [Test]
    procedure CorrectParamTypeIsDisplayedOnJobQEntryParamTemplCardPage()
    var
        JobQEntryParamTemplCard: TestPage "ADD_JobQueueEntrParamTemplCard";
        ObjType: Integer;
        ObjId: Integer;
    begin
        //[SCENARIO] Correct Parameter Type should be displayed on Job Queue Entry Parameter Template Card Page
        Initialize();

        // [GIVEN] Job Queue Entry Parameter Templates with different parameter types and values
        GetTestCu1ForJobQueueEntry(ObjType, ObjId);
        CreateJqeParamTemplWithAllPossParamTypeAndJobQueueEntry(ObjType, ObjId);

        // [WHEN] Job queue entry parameter template card page is opened
        JobQEntryParamTemplCard.OpenView();

        // [THEN] The correct Parameter Type should be displayed on the subform page
        Assert.IsTrue(JobQEntryParamTemplCard.First(), 'Should be able to navigate to first record');
        repeat
            TestParamType(JobQEntryParamTemplCard."Object Type".AsInteger(), JobQEntryParamTemplCard."Object ID".AsInteger(), JobQEntryParamTemplCard."Parameter Name".Value, JobQEntryParamTemplCard."Parameter Type".Value);
        until not JobQEntryParamTemplCard.Next();

        JobQEntryParamTemplCard.Close();
    end;

    [Test]
    procedure CorrectParamTypeIsDisplayedOnJobQEntryParamCardPage()
    var
        JobQEntryParamCard: TestPage "ADD_JobQueueEntrParamCard";
        ObjType: Integer;
        ObjId: Integer;
    begin
        //[SCENARIO] Correct Parameter Type should be displayed on Job Queue Entry Parameter Template Card Page
        Initialize();

        // [GIVEN] Job Queue Entry Parameter Templates with different parameter types and values
        GetTestCu1ForJobQueueEntry(ObjType, ObjId);
        CreateJqeParamTemplWithAllPossParamTypeAndJobQueueEntry(ObjType, ObjId);

        // [WHEN] Job queue entry parameter template card page is opened
        JobQEntryParamCard.OpenView();

        // [THEN] The correct Parameter Type should be displayed on the subform page
        Assert.IsTrue(JobQEntryParamCard.First(), 'Should be able to navigate to first record');
        repeat
            TestParamType(JobQEntryParamCard."Object Type".AsInteger(), JobQEntryParamCard."Object ID".AsInteger(), JobQEntryParamCard."Parameter Name".Value, JobQEntryParamCard."Parameter Type".Value);
        until not JobQEntryParamCard.Next();

        JobQEntryParamCard.Close();
    end;

    local procedure GetTestCu1ForJobQueueEntry(var ObjectType: Integer; var ObjectID: Integer)
    var
        JobQEntry: Record "Job Queue Entry";
    begin
        ObjectType := JobQEntry."Object Type to Run"::Codeunit;
        ObjectID := 50100;
    end;

    local procedure GetTestCu2ForJobQueueEntry(var ObjectType: Integer; var ObjectID: Integer)
    var
        JobQEntry: Record "Job Queue Entry";
    begin
        ObjectType := JobQEntry."Object Type to Run"::Codeunit;
        ObjectID := 11;
    end;

    local procedure GetTestRep1ForJobQueueEntry(var ObjectType: Integer; var ObjectID: Integer)
    var
        JobQEntry: Record "Job Queue Entry";
    begin
        ObjectType := JobQEntry."Object Type to Run"::Report;
        ObjectID := 101;
    end;

    local procedure GetDefaultParameterValue(ParamType: Integer): Variant
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
    var
        ObjType: Integer;
        ObjId: Integer;
    begin
        GetTestCu1ForJobQueueEntry(ObjType, ObjId);
        JobQueueEntryParamTemplate."Object ID" := ObjId;
        JobQueueEntryParamTemplate."Object Type" := ObjType;
        JobQueueEntryParamTemplate."Parameter Name" := 'SampleParam';
        JobQueueEntryParamTemplate."Parameter Type" := JobQueueEntryParamTemplate.FieldNo("Text Value");
        JobQueueEntryParamTemplate.Insert();
    end;

    local procedure CreateJqeParamTemplWithGivenValueAndCreateJobQEntry(ObjectType: Integer; ObjectId: Integer; var JobQueueEntry: Record "Job Queue Entry"; var JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate"; NewParamName: Text[100]; ParamType: Integer; ParamValue: Variant)
    var
        Any: Codeunit Any;
        DateForm: Text;
    begin
        CreateJqeParamTemplWithGivenValue(ObjectType, ObjectId, JobQueueEntryParamTemplate, NewParamName, ParamType, ParamValue);
        CreateJobQueueEntry(ObjectType, ObjectId, JobQueueEntry);
    end;

    local procedure CreateJqeParamTemplWithAllPossParamTypeAndJobQueueEntry(ObjectType: Integer; ObjectID: Integer)
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        ObjType: Integer;
        ObjId: Integer;
    begin
        GetTestCu1ForJobQueueEntry(ObjType, ObjId);
        CreateJqeParamTemplWithGivenValue(ObjType, ObjId, JobQueueEntryParamTemplate, 'Param1', JobQueueEntryParamTemplate.FieldNo("BigInteger Value"), GetDefaultParameterValue(JobQueueEntryParamTemplate.FieldNo("BigInteger Value")));
        CreateJqeParamTemplWithGivenValue(ObjType, ObjId, JobQueueEntryParamTemplate, 'Param2', JobQueueEntryParamTemplate.FieldNo("Boolean Value"), GetDefaultParameterValue(JobQueueEntryParamTemplate.FieldNo("Boolean Value")));
        CreateJqeParamTemplWithGivenValue(ObjType, ObjId, JobQueueEntryParamTemplate, 'Param3', JobQueueEntryParamTemplate.FieldNo("Code Value"), GetDefaultParameterValue(JobQueueEntryParamTemplate.FieldNo("Code Value")));
        CreateJqeParamTemplWithGivenValue(ObjType, ObjId, JobQueueEntryParamTemplate, 'Param4', JobQueueEntryParamTemplate.FieldNo("Date Value"), GetDefaultParameterValue(JobQueueEntryParamTemplate.FieldNo("Date Value")));
        CreateJqeParamTemplWithGivenValue(ObjType, ObjId, JobQueueEntryParamTemplate, 'Param5', JobQueueEntryParamTemplate.FieldNo("DateFormula Value"), GetDefaultParameterValue(JobQueueEntryParamTemplate.FieldNo("DateFormula Value")));
        CreateJqeParamTemplWithGivenValue(ObjType, ObjId, JobQueueEntryParamTemplate, 'Param6', JobQueueEntryParamTemplate.FieldNo("DateTime Value"), GetDefaultParameterValue(JobQueueEntryParamTemplate.FieldNo("DateTime Value")));
        CreateJqeParamTemplWithGivenValue(ObjType, ObjId, JobQueueEntryParamTemplate, 'Param7', JobQueueEntryParamTemplate.FieldNo("Decimal Value"), GetDefaultParameterValue(JobQueueEntryParamTemplate.FieldNo("Decimal Value")));
        CreateJqeParamTemplWithGivenValue(ObjType, ObjId, JobQueueEntryParamTemplate, 'Param8', JobQueueEntryParamTemplate.FieldNo("Duration Value"), GetDefaultParameterValue(JobQueueEntryParamTemplate.FieldNo("Duration Value")));
        CreateJqeParamTemplWithGivenValue(ObjType, ObjId, JobQueueEntryParamTemplate, 'Param9', JobQueueEntryParamTemplate.FieldNo("Guid Value"), GetDefaultParameterValue(JobQueueEntryParamTemplate.FieldNo("Guid Value")));
        CreateJqeParamTemplWithGivenValue(ObjType, ObjId, JobQueueEntryParamTemplate, 'Param10', JobQueueEntryParamTemplate.FieldNo("Integer Value"), GetDefaultParameterValue(JobQueueEntryParamTemplate.FieldNo("Integer Value")));
        CreateJqeParamTemplWithGivenValue(ObjType, ObjId, JobQueueEntryParamTemplate, 'Param11', JobQueueEntryParamTemplate.FieldNo("Text Value"), GetDefaultParameterValue(JobQueueEntryParamTemplate.FieldNo("Text Value")));
        CreateJqeParamTemplWithGivenValue(ObjType, ObjId, JobQueueEntryParamTemplate, 'Param12', JobQueueEntryParamTemplate.FieldNo("Time Value"), GetDefaultParameterValue(JobQueueEntryParamTemplate.FieldNo("Time Value")));
        CreateJobQueueEntry(ObjectType, ObjectID, JobQueueEntry);
    end;

    local procedure CreateJobQEntryWithSampleParamsAndOpenItInParamCardPageEditMode(var JobQueueEntry: Record "Job Queue Entry"; var JobQEntryParams: Record "ADD_JobQueueEntryParameter"; var JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate"; var JobQueueEntrParamCard: TestPage ADD_JobQueueEntrParamCard)
    begin
        CreateJobQEntryWithSampleParams(JobQueueEntry, JobQEntryParams, JobQueueEntryParamTemplate);
        JobQueueEntrParamCard.OpenEdit();
        JobQueueEntrParamCard.GoToRecord(JobQEntryParams);
    end;

    local procedure CreateJobQEntryWithSampleParams(var JobQueueEntry: Record "Job Queue Entry"; var JobQEntryParams: Record "ADD_JobQueueEntryParameter"; var JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate")
    begin
        CreateSampleTextJqeParamTempl(JobQueueEntryParamTemplate);
        CreateSampleJobQueueEntry(JobQueueEntry);
        JobQEntryParams.SetRange("Job Queue Entry ID", JobQueueEntry.ID);
        JobQEntryParams.FindFirst();
    end;

    local procedure CreateSampleTemplAndOpenItInTemplCardPageEditMode(var JobQueueEntrParamTemplateCard: TestPage ADD_JobQueueEntrParamTemplCard)
    var
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
    begin
        CreateSampleTextJqeParamTempl(JobQueueEntryParamTemplate);
        JobQueueEntrParamTemplateCard.OpenEdit();
        JobQueueEntrParamTemplateCard.GoToRecord(JobQueueEntryParamTemplate);
    end;

    local procedure CreateSampleJobQueueEntry(var JobQueueEntry: Record "Job Queue Entry")
    var
        ObjType: Integer;
        ObjId: Integer;
    begin
        GetTestCu1ForJobQueueEntry(ObjType, ObjId);
        CreateJobQueueEntryForCu(ObjId, JobQueueEntry);
    end;

    local procedure CreateJobQueueEntryForCu(CuId: Integer; var JobQueueEntry: Record "Job Queue Entry")
    begin
        JobQueueEntry.Init();
        JobQueueEntry.Validate("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        JobQueueEntry.Validate("Object ID to Run", CuId);
        JobQueueEntry.Insert(True);
    end;

    local procedure CreateJqeParamTemplWithGivenValue(ObjectType: Integer; ObjectId: Integer; var JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate"; NewParamName: Text[100]; ParamType: Integer; ParamValue: Variant)
    begin
        JobQueueEntryParamTemplate."Object ID" := ObjectId;
        JobQueueEntryParamTemplate."Object Type" := ObjectType;
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

    local procedure CreateJobQueueEntry(var ObjectType: Integer; var ObjectId: Integer; var JobQueueEntry: Record "Job Queue Entry")
    begin
        JobQueueEntry.Init();
        JobQueueEntry.Validate("Object Type to Run", ObjectType);
        JobQueueEntry.Validate("Object ID to Run", ObjectId);
        JobQueueEntry.Insert(True);
    end;

    local procedure GetDefaultParameterValueAsText(var JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate"): Text
    var
        ExpectedValue: Text;
    begin
        ExpectedValue := Format(GetDefaultParameterValue(JobQueueEntryParamTemplate."Parameter Type"));
        if JobQueueEntryParamTemplate."Parameter Type" = JobQueueEntryParamTemplate.FieldNo("Duration Value") then
            ExpectedValue += ' milliseconds';
        exit(ExpectedValue);
    end;

    local procedure TestDefaultParamValue(ObjType: Integer; ObjId: Integer; ParamName: Text; ActualParamValue: Text)
    var
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        ExpectedValue: Text;
    begin
        JobQueueEntryParamTemplate.Get(ObjType, ObjId, ParamName);
        ExpectedValue := GetDefaultParameterValueAsText(JobQueueEntryParamTemplate);
        Assert.AreEqual(ExpectedValue, ActualParamValue, StrSubstNo('Parameter Value should match for parameter %1', JobQueueEntryParamTemplate."Parameter Name"));
    end;

    local procedure TestParamType(ObjType: Integer; ObjId: Integer; ParamName: Text; ActualParamType: Text)
    var
        JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate";
        ExpectedValue: Text;
    begin
        JobQueueEntryParamTemplate.Get(ObjType, ObjId, ParamName);
        ExpectedValue := GetJqeParamTemplTypeAsText(JobQueueEntryParamTemplate);
        Assert.AreEqual(ExpectedValue, ActualParamType, StrSubstNo('Parameter Value should match for parameter %1', JobQueueEntryParamTemplate."Parameter Name"));
    end;

    local procedure GetJqeParamTemplTypeAsText(JobQueueEntryParamTemplate: Record "ADD_JobQueueEntryParamTemplate"): Text[100]
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

    var
        Assert: Codeunit "Library Assert";
}