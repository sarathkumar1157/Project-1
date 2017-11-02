trigger RemoveRelatedVisits on Month_Plan__c (before delete) {
    if(trigger.isDelete){
        Set<Id> mnpids = new Set<Id>();
        for(Month_Plan__c mnp : trigger.old){
            mnpids.add(mnp.id);
        }
        List<Week_Plan__c> wplanlist = [select id,name from Week_Plan__c where Month_Plan__c in: mnpids];
        List<Day_Plan__c> dplanlist = [select id,name from Day_Plan__c where Month_Plan__c in: mnpids];
        List<Visit__c> vplanlist = [select id,name from Visit__c where Day_Plan__r.Month_Plan__c in: mnpids];
        List<Visit__c> vplanlistmp = [select id,name from Visit__c where Month_Plan__c in: mnpids];
        
        delete vplanlist;
        delete vplanlistmp;
        delete dplanlist;
        delete wplanlist;
    }
}