codeunit 50107 "ADD_Install"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        this.OnBeforeInstallAppPerCompany();
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInstallAppPerCompany()
    begin
    end;
}