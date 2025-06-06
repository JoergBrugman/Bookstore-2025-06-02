codeunit 50102 "BSB Notif. Subscriber Store"
{
    var
        MyNotifications: Record "My Notifications";
        CredLimitNotif: Notification;
        CreditLimitNotifDescTxt: Label 'Balace of Customer is lager than Credit Limit';
        CreditLimitNotifEditCustomerTxt: Label 'Edit Customer';
        CreditLimitNotifIDTxt: Label '77b296fe-eb5b-4816-b49f-be360af3685e', Locked = true;
        CreditLimitNotifMsg: Label '%1 %2 of %3 %4 %5 is lager than %6';
        CreditLimitNotifTxt: Label 'Customer Balance exceeds Credit Limit';


    [EventSubscriber(ObjectType::Page, Page::"Sales Order", OnAfterGetCurrRecordEvent, '', true, true)]
    local procedure CheckCreditLimit(var Rec: Record "Sales Header")
    var
        Customer: Record Customer;
    begin
        if Rec."Bill-to Customer No." = '' then
            exit;

        Customer.SetAutoCalcFields("Balance (LCY)");
        Customer.Get(Rec."Bill-to Customer No.");
        if Customer."Credit Limit (LCY)" = 0 then
            exit;

        if (Customer."Balance (LCY)" > Customer."Credit Limit (LCY)") and
            MyNotifications.IsEnabledForRecord(CreditLimitNotifIDTxt, Customer)
        then begin
            CredLimitNotif.Id := CreditLimitNotifIDTxt;
            CredLimitNotif.Scope := CredLimitNotif.Scope::LocalScope;
            CredLimitNotif.Message(
                StrSubstNo(CreditLimitNotifMsg,
                Customer.FieldCaption("Balance (LCY)"),
                Customer."Balance (LCY)",
                Customer.TableCaption,
                Customer."No.",
                Customer.Name,
                Customer."Credit Limit (LCY)")
            );
            CredLimitNotif.SetData('CustomerNo', Customer."No.");
            CredLimitNotif.AddAction(CreditLimitNotifEditCustomerTxt, Codeunit::"BSB Notif. Subscriber Store", 'OpenCustomerCard');
            CredLimitNotif.Send();
        end;
    end;

    procedure OpenCustomerCard(Notification: Notification)
    var
        Customer: Record Customer;
    begin
        Customer.Get(Notification.GetData('CustomerNo'));
        Page.Run(Page::"Customer Card", Customer);
    end;

    [EventSubscriber(ObjectType::Page, Page::"My Notifications", OnInitializingNotificationWithDefaultState, '', false, false)]
    local procedure "My Notifications_OnInitializingNotificationWithDefaultState"()
    begin
        MyNotifications.InsertDefaultWithTableNum(
            CreditLimitNotifIDTxt,
            CreditLimitNotifTxt,
            CreditLimitNotifDescTxt,
            Database::Customer);
    end;

}