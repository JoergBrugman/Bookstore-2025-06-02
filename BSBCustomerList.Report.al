report 50100 "BSB Customer List"
{
    Caption = 'Customer List';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'BSBCustomerList.Report.rdlc';

    dataset
    {
        dataitem(SingleRowData; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = const(1));
            column(COMPANYNAME; CompanyProperty.DisplayName()) { }
            column(ShowBalance; ShowBalance) { }
        }
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Customer Posting Group";

            column(No_Customer; "No.") { IncludeCaption = true; }
            column(Name_Customer; Name) { IncludeCaption = true; }
            column(CustomerPostingGroup_Customer; "Customer Posting Group") { IncludeCaption = true; }
            column(BalanceLCY_Customer; "Balance (LCY)") { IncludeCaption = true; }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ShowBalance; ShowBalance)
                    {
                        Caption = 'Show Balance';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Show Balance field.';
                    }
                }
            }
        }
    }

    labels
    {
        ReportCaptionLbl = 'Customer - List';
    }

    var
        ShowBalance: Boolean;
}