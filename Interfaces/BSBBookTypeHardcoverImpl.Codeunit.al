codeunit 50110 "BSB Book Type Hardcover Impl." implements "BSB Book Type Process"
{
    procedure StartDeployBook()
    begin
        Message('Pick from Inventory');
    end;

    procedure StartDeliverBook()
    begin
        Message('Send by UPS PREMIUM');
    end;
}