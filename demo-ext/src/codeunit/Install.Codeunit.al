codeunit 50131 "ADD_Install"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany();
    var
        myAppInfo: ModuleInfo;
    begin
        OnBeforeInstallAppPerCompany();
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInstallAppPerCompany()
    begin
    end;
}