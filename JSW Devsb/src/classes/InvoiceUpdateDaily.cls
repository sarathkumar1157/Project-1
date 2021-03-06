global class InvoiceUpdateDaily implements Database.Batchable<sObject>{
    global final String Query;
    global InvoiceUpdateDaily (String q){
        Query=q;
    }

    global Database.QueryLocator start(Database.BatchableContext BC){
    system.debug('***query***'+query);
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC,List<Invoice__c> scope){
    system.debug('***scope***'+scope);
        update scope;
    }

    global void finish(Database.BatchableContext BC){}
}