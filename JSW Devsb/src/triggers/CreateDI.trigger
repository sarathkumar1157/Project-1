trigger CreateDI on Investigation__c (after insert) {
    List<Investigation__c> dinvlist = new List<Investigation__c>();
    RecordType dtype = [select id,name from RecordType where SObjectType = 'Investigation__c' and name = 'Detailed Investigation'];
    RecordType ftype = [select id,name from RecordType where SObjectType = 'Investigation__c' and name = 'First Investigation'];
    Set<Id> caseids = new Set<Id>();
    List<Case> caselist = new List<Case>();
    Map<Id,Id> casetsomap = new Map<Id,Id>();
    
    for(Investigation__c inv : trigger.new){
        caseids.add(inv.Case__c);
    }
    
    caselist = [select id,TSO__c from Case where id in: caseids];
    for(Case cs : caselist){
        casetsomap.put(cs.id,cs.TSO__c);
    }
    
    for(Investigation__c inv : trigger.new){
        if(inv.RecordTypeId == ftype.id){
            Investigation__c dinv = new Investigation__c();
            dinv.Complaint_Type__c = inv.Complaint_Type__c;
            dinv.Primary_Defect__c = inv.Primary_Defect__c;
            dinv.Dealer_Sub_Dealer__c = inv.Dealer_Sub_Dealer__c;
            dinv.Invoice_No__c = inv.Invoice_No__c;
            dinv.MT__c = inv.MT__c;
            dinv.Supply_Plant__c = inv.Supply_Plant__c;
            dinv.Grade__c = inv.Grade__c;
            dinv.Batch_Details__c = inv.Batch_Details__c;
            dinv.Date_of_Supply__c = inv.Date_of_Supply__c;
            dinv.Date_of_Use__c = inv.Date_of_Use__c;
            dinv.Visit_Comments__c = inv.Visit_Comments__c;
            dinv.No_Of_Bags__c = inv.No_Of_Bags__c;
            dinv.Transport_Type__c = inv.Transport_Type__c;
            dinv.RR_CDN_No__c = inv.RR_CDN_No__c;
            dinv.RR_CDN_Date__c = inv.RR_CDN_Date__c;
            dinv.Gate_Pass_No__c = inv.Gate_Pass_No__c;
            dinv.Gate_Pass_Date__c = inv.Gate_Pass_Date__c;
            dinv.Rake_No__c = inv.Rake_No__c;
            dinv.Priority_Type__c = inv.Priority_Type__c;
            dinv.Case__c = inv.Case__c;
            dinv.RecordTypeId = dtype.id;
            dinv.OwnerId = casetsomap.get(inv.Case__c);
            dinvlist.add(dinv);
        }
    }
    System.debug(dinvlist+'@@@');
    insert dinvlist;
}