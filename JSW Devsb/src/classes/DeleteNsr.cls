global class DeleteNsr implements Database.Batchable<sObject>{
    global final String Query;
    global DeleteNsr (String q){
        Query=q;
    }

    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC,List<nsr__c> scope){
        delete scope;
    }

    global void finish(Database.BatchableContext BC){}
}