codeunit 50107 "AMC Install"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        this.OnBeforeInstallAppPerCompany();
    end;

    /// <summary>
    /// Publishes an event before install logic runs per company.
    /// </summary>
    [IntegrationEvent(false, false)]
    procedure OnBeforeInstallAppPerCompany()
    begin
    end;
}
