global class NSRIDValues implements Database.Batchable<sObject> 
{
    public String qrystr;
    public NSRIDValues(String str)
    {
        qrystr = str;
        System.debug('----->'+qrystr);
    }
    global Database.QueryLocator start(Database.BatchableContext BC) 
    {
        String query = qrystr;
        System.debug('----->'+query);
        return Database.getQueryLocator(qrystr);
    }
    
    global void execute(Database.BatchableContext BC, List<Invoice_Discounts__c> scope) 
    {
        List<Invoice_Discounts__c> IDList = new List<Invoice_Discounts__c>();
        Set<String> setCIN = new Set<String>();
        for(Invoice_Discounts__c pd : scope)
        {
            setCIN.add(pd.Commercial_Invoice_Number__c);
        }
        
        List<Invoice__c> invList = [Select id,Commercial_Invoice_Number__c,Invoice_Discount_Value__c from Invoice__c where Commercial_Invoice_Number__c IN: setCIN];
        
        for(Invoice_Discounts__c pd : scope)
        {
            for(Invoice__c inv : invList)
            {
                 if(inv.Commercial_Invoice_Number__c== pd.Commercial_Invoice_Number__c)
                    inv.Invoice_Discount_Value__c = pd.Invoice_Discount_Value__c;
            }
            pd.To_Be_Processed__c = False;
            IDList.add(pd);
        }
        update invlist;
        update IDlist;
    }
    
    global void finish(Database.BatchableContext BC) 
    {
        
    }
}