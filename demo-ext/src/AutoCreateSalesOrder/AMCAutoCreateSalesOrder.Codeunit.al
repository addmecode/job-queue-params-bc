codeunit 50106 "AMC Auto Create Sales Order"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        CustomerNo: Code[20];
        ItemNo: Code[20];
        LocCode: Code[10];
        Quantity: Integer;
        SalesOrderNo: Code[20];
    begin
        CustomerNo := Rec.GetJobQueueEntryParamValue(GetCustNoParamName());
        LocCode := Rec.GetJobQueueEntryParamValue(GetLocCodeParamName());
        ItemNo := Rec.GetJobQueueEntryParamValue(GetItemNoParamName());
        Quantity := Rec.GetJobQueueEntryParamValue(GetQuantityParamName());

        SalesOrderNo := this.CreateSalesOrderHeader(CustomerNo, LocCode);
        this.CreateSalesOrderLines(SalesOrderNo, ItemNo, Quantity);
    end;

    local procedure CreateSalesOrderHeader(CustomerNo: Code[20]; LocCode: Code[10]): Code[20]
    var
        Customer: Record Customer;
        SalesHeader: Record "Sales Header";
        CustomerNotFoundErr: Label 'Customer %1 does not exist.', Comment = '%1 = Customer No.';
    begin
        if not Customer.Get(CustomerNo) then
            Error(CustomerNotFoundErr, CustomerNo);

        SalesHeader.Init();
        SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.Insert(true);
        SalesHeader.Validate("Sell-to Customer No.", CustomerNo);
        SalesHeader.Validate("Posting Date", WorkDate());
        SalesHeader.Validate("Location Code", LocCode);
        SalesHeader.Modify(true);
        exit(SalesHeader."No.");
    end;

    local procedure CreateSalesOrderLines(SalesOrderNo: Code[20]; ItemNo: Code[20]; Quantity: Integer)
    var
        Item: Record Item;
        SalesLine: Record "Sales Line";
        ItemNotFoundErr: Label 'Item %1 does not exist.', Comment = '%1 = Item No.';
    begin
        if not Item.Get(ItemNo) then
            Error(ItemNotFoundErr, ItemNo);

        SalesLine.Init();
        SalesLine.Validate("Document Type", SalesLine."Document Type"::Order);
        SalesLine.Validate("Document No.", SalesOrderNo);
        SalesLine.Validate("Type", SalesLine."Type"::Item);
        SalesLine.Validate("No.", ItemNo);
        SalesLine.Validate(Quantity, Quantity);
        SalesLine.Insert(true);
    end;

    local procedure GetCustNoParamName(): Text[100]
    begin
        exit('Customer No.');
    end;

    local procedure GetItemNoParamName(): Text[100]
    begin
        exit('Item No.');
    end;

    local procedure GetQuantityParamName(): Text[100]
    begin
        exit('Quantity');
    end;

    local procedure GetLocCodeParamName(): Text[100]
    begin
        exit('Location Code');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"AMC Install", OnBeforeInstallAppPerCompany, '', false, false)]
    local procedure CreateJobQueueEntryParamTemplatesHandler()
    var
        JobQueueEntryParamTemplate: Record "AMC Job Queue Param Template";
    begin
        InitJobQueueEntryParamTemplate(JobQueueEntryParamTemplate);
        JobQueueEntryParamTemplate."Parameter Name" := this.GetCustNoParamName();
        JobQueueEntryParamTemplate."Parameter Description" := 'Customer number to auto create sales order.';
        JobQueueEntryParamTemplate.Validate("Code Value", 'C00001');
        JobQueueEntryParamTemplate.CreateIfNotExists(true);

        this.InitJobQueueEntryParamTemplate(JobQueueEntryParamTemplate);
        JobQueueEntryParamTemplate."Parameter Name" := this.GetItemNoParamName();
        JobQueueEntryParamTemplate."Parameter Description" := 'Item number to auto create sales order.';
        JobQueueEntryParamTemplate.Validate("Code Value", 'Item0001');
        JobQueueEntryParamTemplate.CreateIfNotExists(true);

        this.InitJobQueueEntryParamTemplate(JobQueueEntryParamTemplate);
        JobQueueEntryParamTemplate."Parameter Name" := this.GetQuantityParamName();
        JobQueueEntryParamTemplate."Parameter Description" := 'Quantity to auto create sales order.';
        JobQueueEntryParamTemplate.Validate("Integer Value", 1);
        JobQueueEntryParamTemplate.CreateIfNotExists(true);

        this.InitJobQueueEntryParamTemplate(JobQueueEntryParamTemplate);
        JobQueueEntryParamTemplate."Parameter Name" := this.GetLocCodeParamName();
        JobQueueEntryParamTemplate."Parameter Description" := 'Location Code to auto create sales order.';
        JobQueueEntryParamTemplate.Validate("Code Value", 'MAIN');
        JobQueueEntryParamTemplate.CreateIfNotExists(true);
    end;

    local procedure InitJobQueueEntryParamTemplate(var JobQueueEntryParamTemplate: Record "AMC Job Queue Param Template")
    begin
        JobQueueEntryParamTemplate.Init();
        JobQueueEntryParamTemplate."Object Type" := JobQueueEntryParamTemplate."Object Type"::Codeunit;
        JobQueueEntryParamTemplate."Object ID" := Codeunit::"AMC Auto Create Sales Order";
    end;
}
