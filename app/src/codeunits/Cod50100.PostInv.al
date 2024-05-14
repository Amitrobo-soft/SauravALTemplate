codeunit 50100 PostInv
{
    EventSubscriberInstance = StaticAutomatic;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnRunOnAfterPostInvoice', '', false, false)]
    local procedure OnAfterPostInvoice(var PurchInvHeader: Record "Purch. Inv. Header"; var PurchaseHeader: Record "Purchase Header")
    var
        AutoInvoicesPurDocuments: Record StagingTable;
    begin
        AutoInvoicesPurDocuments.RESET;
        AutoInvoicesPurDocuments.SETRANGE(AutoInvoicesPurDocuments."Document Type", PurchaseHeader."Document Type");
        AutoInvoicesPurDocuments.SETRANGE(AutoInvoicesPurDocuments."Purchase Invoice No.", PurchaseHeader."No.");
        IF AutoInvoicesPurDocuments.FIND('-') THEN BEGIN
            REPEAT
                IF PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice THEN BEGIN
                    AutoInvoicesPurDocuments.VALIDATE(AutoInvoicesPurDocuments."PostedPurchInvNo.", PurchInvHeader."No.");
                    AutoInvoicesPurDocuments."Document Posted" := TRUE;
                    AutoInvoicesPurDocuments.MODIFY(TRUE);
                END;
            UNTIL AutoInvoicesPurDocuments.NEXT = 0;
        END;
        Message('Invoice Posted Succesfully...');
    end;
}