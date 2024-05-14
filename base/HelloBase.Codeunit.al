codeunit 50130 HelloBase
{
    trigger OnRun()
    begin
        //amit
    end;

    procedure GetText() returnvalue: Text;
    begin
        returnvalue := 'App Published: Hello World Base!';
    end;
}