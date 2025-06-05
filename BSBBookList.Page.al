page 50101 "BSB Book List"
{
    Caption = 'Books';
    PageType = List;
    SourceTable = "BSB Book";
    Editable = false;
    CardPageId = "BSB Book Card";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Books)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Type; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field(ISBN; Rec.ISBN)
                {
                    ToolTip = 'Specifies the value of the ISBN field.', Comment = '%';
                }
                field(Author; Rec.Author)
                {
                    ToolTip = 'Specifies the value of the Author field.', Comment = '%';
                }
                field("No. of Pages"; Rec."No. of Pages")
                {
                    ToolTip = 'Specifies the value of the No. of Pages field.', Comment = '%';
                    Visible = false;
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links) { ApplicationArea = RecordLinks; }
            systempart(Notes; Notes) { ApplicationArea = Notes; }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ClassicImpl)
            {
                Caption = 'Classic Impl.';
                Image = Action;
                ApplicationArea = All;

                trigger OnAction()
                var
                    BSBBookTypeDefaultImpl: Codeunit "BSB Book Type Default Impl.";
                    BSBBookTypeHardcoverImpl: Codeunit "BSB Book Type Hardcover Impl.";
                    BSBBookTypePaperbackImpl: Codeunit "BSB Book Type Paperback Impl.";
                begin
                    case Rec.Type of
                        "BSB Book Type"::" ":
                            begin
                                BSBBookTypeDefaultImpl.StartDeployBook();
                                BSBBookTypeDefaultImpl.StartDeliverBook();
                            end;
                        "BSB Book Type"::Hardcover:
                            begin
                                BSBBookTypeHardcoverImpl.StartDeployBook();
                                BSBBookTypeHardcoverImpl.StartDeliverBook();
                            end;
                        "BSB Book Type"::Paperback:
                            begin
                                BSBBookTypePaperbackImpl.StartDeployBook();
                                BSBBookTypePaperbackImpl.StartDeliverBook();
                            end;
                    end;
                end;
            }
            action("Interface")
            {
                Caption = 'With Interface';
                Image = Action;
                ApplicationArea = All;

                trigger OnAction()
                var
                    BSBBookTypeDefaultImpl: Codeunit "BSB Book Type Default Impl.";
                    BSBBookTypeHardcoverImpl: Codeunit "BSB Book Type Hardcover Impl.";
                    BSBBookTypePaperbackImpl: Codeunit "BSB Book Type Paperback Impl.";
                    BSBBookTypeProcess: Interface "BSB Book Type Process";
                begin
                    case Rec.Type of
                        "BSB Book Type"::" ":
                            BSBBookTypeProcess := BSBBookTypeDefaultImpl;
                        "BSB Book Type"::Hardcover:
                            BSBBookTypeProcess := BSBBookTypeHardcoverImpl;
                        "BSB Book Type"::Paperback:
                            BSBBookTypeProcess := BSBBookTypePaperbackImpl;
                    end;
                    BSBBookTypeProcess.StartDeployBook();
                    BSBBookTypeProcess.StartDeliverBook();
                end;
            }
            action(InterfaceAndEnum)
            {
                Caption = 'With Interface and Enum';
                Image = Action;
                ApplicationArea = All;

                trigger OnAction()
                var
                    BSBBookTypeProcess: Interface "BSB Book Type Process";
                begin
                    BSBBookTypeProcess := Rec.Type;
                    BSBBookTypeProcess.StartDeployBook();
                    BSBBookTypeProcess.StartDeliverBook();
                end;
            }
        }
    }
}