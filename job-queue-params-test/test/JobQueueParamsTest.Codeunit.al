codeunit 50140 "ADD_JobQueueParamsTest"
{
    // [FEATURE] [JobQueueParamsTest]
    Subtype = Test;

    trigger OnRun()
    begin
        IsInitialized := false;
    end;

    local procedure Initialize()
    begin
        if IsInitialized then
            exit;

        // CUSTOMIZATION: Prepare setup tables etc. that are used for all test functions
        IsInitialized := true;
        Commit();
    end;

    var
        Assert: Codeunit "Library Assert";
        IsInitialized: Boolean;
        LibrarySales: Codeunit "Library - Sales";
}