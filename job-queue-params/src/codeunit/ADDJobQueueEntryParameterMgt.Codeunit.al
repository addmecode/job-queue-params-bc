namespace Addmecode.JobQueueParams;
using System.Threading;

codeunit 50104 "ADD_JobQueueEntryParameterMgt"
{
    /// <summary>
    /// Creates all job queue entry parameters from matching templates.
    /// </summary>
    /// <param name="JobQueueEntry">The job queue entry to receive parameters.</param>
    /// <param name="SetDefaultValue">Specifies whether to copy default values from templates.</param>
    procedure CreateAllJobQueueEntryParamsFromTempl(JobQueueEntry: Record "Job Queue Entry"; SetDefaultValue: Boolean)
    var
        JobQueueEntryParamTemplate: Record ADD_JobQueueEntryParamTemplate;
    begin
        if JobQueueEntry."Object ID to Run" = 0 then
            exit;
        JobQueueEntryParamTemplate.SetRange("Object ID", JobQueueEntry."Object ID to Run");
        JobQueueEntryParamTemplate.SetRange("Object Type", JobQueueEntry."Object Type to Run");
        if JobQueueEntryParamTemplate.FindSet() then
            repeat
                CreateJobQueueEntryParamFromTemplate(JobQueueEntry, JobQueueEntryParamTemplate, SetDefaultValue);
            until JobQueueEntryParamTemplate.Next() = 0;
    end;

    local procedure CreateJobQueueEntryParamFromTemplate(JobQueueEntry: Record "Job Queue Entry"; JobQueueEntryParamTemplate: Record ADD_JobQueueEntryParamTemplate; SetDefaultValue: Boolean)
    var
        JobQueueEntryParam: Record ADD_JobQueueEntryParameter;
        ParameterRecRef: RecordRef;
        TemplateRecRef: RecordRef;
        ParameterFieldRef: FieldRef;
        TemplateFieldRef: FieldRef;
    begin
        TemplateRecRef.GetTable(JobQueueEntryParamTemplate);
        ParameterRecRef.Open(Database::ADD_JobQueueEntryParameter);

        ParameterRecRef.Field(JobQueueEntryParam.FieldNo("Job Queue Entry ID")).Value := JobQueueEntry.ID;
        ParameterRecRef.Field(JobQueueEntryParam.FieldNo("Parameter Name")).Value := JobQueueEntryParamTemplate."Parameter Name";
        if SetDefaultValue then begin
            TemplateFieldRef := TemplateRecRef.Field(JobQueueEntryParamTemplate."Parameter Type");
            ParameterFieldRef := ParameterRecRef.Field(TemplateFieldRef.Number);
            ParameterFieldRef.Value := TemplateFieldRef.Value;
        end;
        ParameterRecRef.Insert();
    end;

    /// <summary>
    /// Deletes all parameters linked to the provided job queue entry.
    /// </summary>
    /// <param name="JobQueueEntry">The job queue entry whose parameters will be deleted.</param>
    procedure DeleteAllJobQueueEntryParams(JobQueueEntry: Record "Job Queue Entry")
    var
        JobQueueEntryParam: Record ADD_JobQueueEntryParameter;
    begin
        JobQueueEntryParam.SetRange("Job Queue Entry ID", JobQueueEntry.ID);
        JobQueueEntryParam.DeleteAll(true);
    end;

    /// <summary>
    /// Recreates job queue entry parameters when the object to run changes.
    /// </summary>
    /// <param name="JobQueueEntry">The job queue entry to update.</param>
    /// <param name="SetDefaultValue">Specifies whether to copy default values from templates.</param>
    procedure OverwriteAllJobQueueEntryParamsFromTempl(JobQueueEntry: Record "Job Queue Entry"; SetDefaultValue: Boolean)
    var
        ExistingJobQueueEntry: Record "Job Queue Entry";
    begin
        if not ExistingJobQueueEntry.Get(JobQueueEntry.ID) then
            exit;

        if (JobQueueEntry."Object ID to Run" = ExistingJobQueueEntry."Object ID to Run") and (JobQueueEntry."Object Type to Run" = ExistingJobQueueEntry."Object Type to Run") then
            exit;

        DeleteAllJobQueueEntryParams(JobQueueEntry);
        CreateAllJobQueueEntryParamsFromTempl(JobQueueEntry, SetDefaultValue);
    end;

    /// <summary>
    /// Creates a parameter template and initializes existing job queue entries when missing.
    /// </summary>
    /// <param name="JobQueueEntryParamTemplateToCreate">The template to create.</param>
    /// <param name="SetDefaultValueForExistingJobQueueEntries">Specifies whether to set default values for existing entries.</param>
    procedure CreateJqeParamTemplIfNotExists(JobQueueEntryParamTemplateToCreate: Record ADD_JobQueueEntryParamTemplate; SetDefaultValueForExistingJobQueueEntries: Boolean)
    var
        ExistingJobQueueEntryParamTemplate: Record ADD_JobQueueEntryParamTemplate;
    begin
        if (ExistingJobQueueEntryParamTemplate.Get(JobQueueEntryParamTemplateToCreate."Object Type", JobQueueEntryParamTemplateToCreate."Object ID", JobQueueEntryParamTemplateToCreate."Parameter Name")) then
            exit;
        JobQueueEntryParamTemplateToCreate.Insert(true);
        CreateJobQueueEntryParamsFromNewTemplateForExistingEntries(JobQueueEntryParamTemplateToCreate, SetDefaultValueForExistingJobQueueEntries);
    end;

    /// <summary>
    /// Gets a parameter value for the specified job queue entry.
    /// </summary>
    /// <param name="JobQueueEntry">The job queue entry.</param>
    /// <param name="ParameterName">The parameter name to read.</param>
    /// <returns>The parameter value as a variant.</returns>
    procedure GetJobQueueEntryParamValue(JobQueueEntry: Record "Job Queue Entry"; ParameterName: Text[100]): Variant
    var
        JobQueueEntryParam: Record ADD_JobQueueEntryParameter;
    begin
        JobQueueEntryParam.Get(JobQueueEntry.ID, ParameterName);
        exit(GetParameterValue(JobQueueEntryParam));
    end;

    /// <summary>
    /// Determines whether the parameter can be edited based on the job queue entry status.
    /// </summary>
    /// <param name="JobQueueEntryParam">The parameter record.</param>
    /// <returns>True if the parameter is editable; otherwise, false.</returns>
    procedure IsParamEditable(JobQueueEntryParam: Record ADD_JobQueueEntryParameter): Boolean
    var
        JobQueueEntry: Record "Job Queue Entry";
    begin
        JobQueueEntry.Get(JobQueueEntryParam."Job Queue Entry ID");
        exit(JobQueueEntry.Status = JobQueueEntry.Status::"On Hold");
    end;

    /// <summary>
    /// Returns the caption of the parameter type stored in the template.
    /// </summary>
    /// <param name="JobQueueEntryParamTemplate">The parameter template record.</param>
    /// <returns>The parameter type caption.</returns>
    procedure GetTemplParameterTypeCaption(var JobQueueEntryParamTemplate: Record ADD_JobQueueEntryParamTemplate): Text
    var
        RecRef: RecordRef;
        FieldRef: FieldRef;
    begin
        RecRef.GetTable(JobQueueEntryParamTemplate);
        FieldRef := RecRef.Field(JobQueueEntryParamTemplate."Parameter Type");
        exit(Format(FieldRef.Type));
    end;

    /// <summary>
    /// Returns the caption of the parameter type stored in the entry.
    /// </summary>
    /// <param name="JobQueueEntryParam">The parameter entry record.</param>
    /// <returns>The parameter type caption.</returns>
    procedure GetParameterTypeCaption(var JobQueueEntryParam: Record ADD_JobQueueEntryParameter): Text
    var
        RecRef: RecordRef;
        FieldRef: FieldRef;
    begin
        JobQueueEntryParam.CalcFields("Parameter Type");
        RecRef.GetTable(JobQueueEntryParam);
        FieldRef := RecRef.Field(JobQueueEntryParam."Parameter Type");
        exit(Format(FieldRef.Type));
    end;

    /// <summary>
    /// Returns the parameter value formatted as text.
    /// </summary>
    /// <param name="JobQueueEntryParam">The parameter entry record.</param>
    /// <returns>The formatted parameter value.</returns>
    procedure GetParameterValueAsText(JobQueueEntryParam: Record ADD_JobQueueEntryParameter): Text
    begin
        exit(Format(GetParameterValue(JobQueueEntryParam)));
    end;

    /// <summary>
    /// Returns the raw parameter value.
    /// </summary>
    /// <param name="JobQueueEntryParam">The parameter entry record.</param>
    /// <returns>The parameter value as a variant.</returns>
    procedure GetParameterValue(JobQueueEntryParam: Record ADD_JobQueueEntryParameter): Variant
    var
        RecRef: RecordRef;
        FieldRef: FieldRef;
    begin
        JobQueueEntryParam.CalcFields("Parameter Type");
        RecRef.GetTable(JobQueueEntryParam);
        FieldRef := RecRef.Field(JobQueueEntryParam."Parameter Type");
        exit(FieldRef.Value());
    end;

    /// <summary>
    /// Returns the default parameter value formatted as text.
    /// </summary>
    /// <param name="JobQueueEntryParamTemplate">The parameter template record.</param>
    /// <returns>The formatted default value.</returns>
    procedure GetDefaultParameterValueAsText(JobQueueEntryParamTemplate: Record ADD_JobQueueEntryParamTemplate): Text
    begin
        exit(Format(GetDefaultParameterValue(JobQueueEntryParamTemplate)));
    end;

    /// <summary>
    /// Returns the raw default parameter value from the template.
    /// </summary>
    /// <param name="JobQueueEntryParamTemplate">The parameter template record.</param>
    /// <returns>The default parameter value as a variant.</returns>
    procedure GetDefaultParameterValue(JobQueueEntryParamTemplate: Record ADD_JobQueueEntryParamTemplate): Variant
    var
        RecRef: RecordRef;
        FieldRef: FieldRef;
    begin
        RecRef.GetTable(JobQueueEntryParamTemplate);
        FieldRef := RecRef.Field(JobQueueEntryParamTemplate."Parameter Type");
        exit(FieldRef.Value());
    end;

    /// <summary>
    /// Validates that the template has a consistent parameter type definition.
    /// </summary>
    /// <param name="JobQueueEntryParamTemplate">The parameter template record.</param>
    procedure ValidateParameterType(JobQueueEntryParamTemplate: Record ADD_JobQueueEntryParamTemplate)
    begin
        //todo validate if there is only one parameter value set and it is the same as the parameter type
    end;

    local procedure CreateJobQueueEntryParamFromTemplateIfMissing(JobQueueEntry: Record "Job Queue Entry"; JobQueueEntryParamTemplate: Record ADD_JobQueueEntryParamTemplate; SetDefaultValue: Boolean)
    var
        JobQueueEntryParam: Record ADD_JobQueueEntryParameter;
    begin
        if JobQueueEntryParam.Get(JobQueueEntry.ID, JobQueueEntryParamTemplate."Parameter Name") then
            exit;
        CreateJobQueueEntryParamFromTemplate(JobQueueEntry, JobQueueEntryParamTemplate, SetDefaultValue);
    end;

    local procedure CreateJobQueueEntryParamsFromNewTemplateForExistingEntries(NewJobQueueEntryParamTemplate: Record ADD_JobQueueEntryParamTemplate; SetDefaultValueForExistingJobQueueEntries: Boolean)
    var
        JobQueueEntry: Record "Job Queue Entry";
    begin
        SetFilterForJobQueueEntriesForTemplate(NewJobQueueEntryParamTemplate, JobQueueEntry);
        if JobQueueEntry.FindSet() then
            repeat
                CreateJobQueueEntryParamFromTemplateIfMissing(JobQueueEntry, NewJobQueueEntryParamTemplate, SetDefaultValueForExistingJobQueueEntries);
            until JobQueueEntry.Next() = 0;
    end;

    local procedure SetFilterForJobQueueEntriesForTemplate(NewJobQueueEntryParamTemplate: Record ADD_JobQueueEntryParamTemplate; var FilteredJobQueueEntry: Record "Job Queue Entry")
    begin
        FilteredJobQueueEntry.SetRange("Object Type to Run", NewJobQueueEntryParamTemplate."Object Type");
        FilteredJobQueueEntry.SetRange("Object ID to Run", NewJobQueueEntryParamTemplate."Object ID");
    end;

    /// <summary>
    /// Ensures the related job queue entry is on hold before allowing changes.
    /// </summary>
    /// <param name="JobQueueEntryParam">The parameter entry record.</param>
    procedure CheckIfJqeIsOnHold(JobQueueEntryParam: Record ADD_JobQueueEntryParameter)
    var
        JobQueueEntry: Record "Job Queue Entry";
    begin
        JobQueueEntry.Get(JobQueueEntryParam."Job Queue Entry ID");
        JobQueueEntry.TestField(Status, JobQueueEntry.Status::"On Hold");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Job Queue Entry", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertJobQueueEntry(var Rec: Record "Job Queue Entry")
    begin
        Rec.CreateJobQueueEntryParam();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Job Queue Entry", 'OnBeforeModifyEvent', '', false, false)]
    local procedure OnBeforeModifyJobQueueEntry(var Rec: Record "Job Queue Entry")
    begin
        Rec.OverwriteJobQueueEntryParam();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Job Queue Entry", 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeleteJobQueueEntry(var Rec: Record "Job Queue Entry")
    begin
        Rec.DeleteJobQueueEntryParam();
    end;
}
