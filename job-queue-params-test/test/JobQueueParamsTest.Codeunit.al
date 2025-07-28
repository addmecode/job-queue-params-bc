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
    begin

        // if IsInitialized then
        //     exit;

        // // CUSTOMIZATION: Prepare setup tables etc. that are used for all test functions
        // IsInitialized := true;
        // Commit();
    end;

    [Test]
    procedure DeleteAllJobQueueEntryParams_WithValidJobQueueEntry_DeletesAllParameters()
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
        JobQueueEntry."Object ID to Run" := 50100;
        JobQueueEntry.Insert();
        exit(JobQueueEntry.ID);
    end;


    var
        Assert: Codeunit "Library Assert";
        IsInitialized: Boolean;
}