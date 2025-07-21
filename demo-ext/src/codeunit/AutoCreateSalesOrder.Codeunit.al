codeunit 50130 "ADD_AutoCreateSalesOrder"
{
    TableNo = 472;
    trigger OnRun()
    var
        NewSalesOrderNo: code[20];
    begin
        NewSalesOrderNo := CreateSalesOrderHeader(Rec.GetJobQueueEntryParamValue(GetCustNoParamName()),
                                                Rec.GetJobQueueEntryParamValue(GetLocCodeParamName()));

        CreateSalesOrderLines(NewSalesOrderNo,
                            Rec.GetJobQueueEntryParamValue(GetItemNoParamName()),
                            Rec.GetJobQueueEntryParamValue(GetQuantityParamName()));
    end;

    local procedure CreateSalesOrderHeader(CustomerNo: code[20]; LocCode: code[10]): code[20]
    var
        SalesHeader: Record "Sales Header";
        Customer: Record Customer;
    begin
        Customer.Get(CustomerNo);

        SalesHeader.init();
        SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.Insert(true);
        SalesHeader.Validate("Sell-to Customer No.", CustomerNo);
        SalesHeader.Validate("Posting Date", WorkDate());
        SalesHeader.Validate("Location Code", LocCode);
        SalesHeader.Modify(true);
        exit(SalesHeader."No.");
    end;

    local procedure CreateSalesOrderLines(SalesOrderNo: Code[20]; ItemNo: code[20]; Quantity: Integer)
    var
        SalesLine: Record "Sales Line";
        Item: Record Item;
    begin
        Item.Get(ItemNo);

        SalesLine.init();
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
        Exit('Location Code');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ADD_Install, OnBeforeInstallAppPerCompany, '', false, false)]
    local procedure CreateJqeTemplParams()
    var
        JobQueueEntryParamTempl: Record "ADD_JobQueueEntryParamTemplate";
    begin
        JobQueueEntryParamTempl.Init();
        JobQueueEntryParamTempl."Object Type" := JobQueueEntryParamTempl."Object Type"::Codeunit;
        JobQueueEntryParamTempl."Object ID" := 50130;

        JobQueueEntryParamTempl."Parameter Name" := GetCustNoParamName();
        JobQueueEntryParamTempl."Parameter Description" := 'Customer number to auto create sales order.';
        JobQueueEntryParamTempl.Validate("Code Value", 'C00001');
        JobQueueEntryParamTempl.CreateIfNotExists(true);

        JobQueueEntryParamTempl.Init();
        JobQueueEntryParamTempl."Parameter Name" := GetItemNoParamName();
        JobQueueEntryParamTempl."Parameter Description" := 'Item number to auto create sales order.';
        JobQueueEntryParamTempl.Validate("Code Value", 'Item0001');
        JobQueueEntryParamTempl.CreateIfNotExists(true);
        JobQueueEntryParamTempl.Init();

        JobQueueEntryParamTempl."Parameter Name" := GetQuantityParamName();
        JobQueueEntryParamTempl."Parameter Description" := 'Quantity to auto create sales order.';
        JobQueueEntryParamTempl.Validate("Integer Value", 1);
        JobQueueEntryParamTempl.CreateIfNotExists(true);

        JobQueueEntryParamTempl."Parameter Name" := GetLocCodeParamName();
        JobQueueEntryParamTempl."Parameter Description" := 'Location Code to auto create sales order.';
        JobQueueEntryParamTempl.Validate("Code Value", 'MAIN');
        JobQueueEntryParamTempl.CreateIfNotExists(true);
    end;
}