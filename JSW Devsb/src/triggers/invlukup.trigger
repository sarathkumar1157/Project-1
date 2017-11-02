trigger invlukup on Invoice_Discounts__c (before insert,before update) 
{
    Set<String> commnumber = new Set<String>();
    Map<String,String> invmap = new Map<String,String>();
    
    for(Invoice_Discounts__c invdisc : trigger.new)
    {
        commnumber.add(invdisc.Commercial_Invoice_Number__c);
    }
    
    List<Invoice__c> invlist = [Select id,Commercial_Invoice_Number__c from Invoice__c where Commercial_Invoice_Number__c IN: commnumber];
    
    for(Invoice__c inv : invlist)
    {
        invmap.put(inv.Commercial_Invoice_Number__c,inv.id);
    }
    for(Invoice_Discounts__c invdisc : trigger.new)
    {
        if(invmap.containsKey(invdisc.Commercial_Invoice_Number__c))
            invdisc.Invoice__c = invmap.get(invdisc.Commercial_Invoice_Number__c);
    }
}