codeunit 50112 "BSB Book Type Default Impl." implements "BSB Book Type Process"
{
    procedure StartDeployBook()
    begin
        Message('Cannot be deployed');
    end;

    procedure StartDeliverBook()
    begin
        Message('Cannot be delivered');
    end;
}