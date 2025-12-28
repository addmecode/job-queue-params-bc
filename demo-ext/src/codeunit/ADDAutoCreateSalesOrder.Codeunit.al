codeunit 50125 ADD_AutoCreateSalesOrder
{
    TableNo = "Job Queue Entry";
    trigger OnRun()
    var
        NewSalesOrderNo: Code[20];
    begin
        NewSalesOrderNo := this.CreateSalesOrderHeader(Rec.GetJobQueueEntryParamValue(this.GetCustNoParamName()),
                                                Rec.GetJobQueueEntryParamValue(this.GetLocCodeParamName()));

        this.CreateSalesOrderLines(NewSalesOrderNo,
                            Rec.GetJobQueueEntryParamValue(this.GetItemNoParamName()),
                            Rec.GetJobQueueEntryParamValue(this.GetQuantityParamName()));
    end;

    local procedure CreateSalesOrderHeader(CustomerNo: Code[20]; LocCode: Code[10]): Code[20]
    var
        Customer: Record Customer;
        SalesHeader: Record "Sales Header";
    begin
        Customer.Get(CustomerNo);

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
    begin
        Item.Get(ItemNo);

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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ADD_Install, OnBeforeInstallAppPerCompany, '', false, false)]
    local procedure CreateJqeTemplParams()
    var
        JobQueueEntryParamTempl: Record ADD_JobQueueEntryParamTemplate;
    begin
        JobQueueEntryParamTempl.Init();
        JobQueueEntryParamTempl."Object Type" := JobQueueEntryParamTempl."Object Type"::Codeunit;
        JobQueueEntryParamTempl."Object ID" := Codeunit::ADD_AutoCreateSalesOrder;

        JobQueueEntryParamTempl."Parameter Name" := this.GetCustNoParamName();
        JobQueueEntryParamTempl."Parameter Description" := 'Customer number to auto create sales order.';
        JobQueueEntryParamTempl.Validate("Code Value", 'C00001');
        JobQueueEntryParamTempl.CreateIfNotExists(true);

        JobQueueEntryParamTempl.Init();
        JobQueueEntryParamTempl."Parameter Name" := this.GetItemNoParamName();
        JobQueueEntryParamTempl."Parameter Description" := 'Item number to auto create sales order.';
        JobQueueEntryParamTempl.Validate("Code Value", 'Item0001');
        JobQueueEntryParamTempl.CreateIfNotExists(true);
        JobQueueEntryParamTempl.Init();

        JobQueueEntryParamTempl."Parameter Name" := this.GetQuantityParamName();
        JobQueueEntryParamTempl."Parameter Description" := 'Quantity to auto create sales order.';
        JobQueueEntryParamTempl.Validate("Integer Value", 1);
        JobQueueEntryParamTempl.CreateIfNotExists(true);

        JobQueueEntryParamTempl."Parameter Name" := this.GetLocCodeParamName();
        JobQueueEntryParamTempl."Parameter Description" := 'Location Code to auto create sales order.';
        JobQueueEntryParamTempl.Validate("Code Value", 'MAIN');
        JobQueueEntryParamTempl.CreateIfNotExists(true);
    end;
}