namespace Addmecode.JobQueueParams;

enum 50100 "AMC Job Queue Param Type"
{
    Extensible = true;

    value(0; None) { Caption = ''; }
    value(1; BigInteger) { Caption = 'BigInteger'; }
    value(2; Blob) { Caption = 'Blob'; }
    value(3; Boolean) { Caption = 'Boolean'; }
    value(4; Code) { Caption = 'Code'; }
    value(5; Date) { Caption = 'Date'; }
    value(6; DateFormula) { Caption = 'DateFormula'; }
    value(7; DateTime) { Caption = 'DateTime'; }
    value(8; Decimal) { Caption = 'Decimal'; }
    value(9; Duration) { Caption = 'Duration'; }
    value(10; Guid) { Caption = 'Guid'; }
    value(11; Integer) { Caption = 'Integer'; }
    value(12; Media) { Caption = 'Media'; }
    value(13; MediaSet) { Caption = 'MediaSet'; }
    value(14; Text) { Caption = 'Text'; }
    value(15; Time) { Caption = 'Time'; }
}
