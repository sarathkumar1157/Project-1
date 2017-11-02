global class NSRDelete implements Database.Batchable<sObject> 
{
    public String qrystr;
    public NSRDelete(String str)
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
    
    global void execute(Database.BatchableContext BC, List<Invoice__c> scope) 
    {
        Date frmdate;
        Date todat;
        List<NSR_New_Actual__c> distnsr = new List<NSR_New_Actual__c>();
        Set<String> Prodset = new Set<String>();
        
        for(Invoice__c nsr : scope)
        {
            Prodset.add(nsr.Brand_Short_Form__c);
            if(frmdate == null && todat == null)
            {
                frmdate = nsr.Commercial_Invoice_Date_Formula__c;
                todat = nsr.Commercial_Invoice_Date_Formula__c;
            }
            else if(frmdate > nsr.Commercial_Invoice_Date_Formula__c)
                frmdate = nsr.Commercial_Invoice_Date_Formula__c;
            else if(todat < nsr.Commercial_Invoice_Date_Formula__c)
                todat = nsr.Commercial_Invoice_Date_Formula__c;
                
        } 
        
        if(Prodset.size() > 0)
            distnsr = [Select id from NSR_New_Actual__c where Commercial_Invoice_Date__c>= :frmdate AND Commercial_Invoice_Date__c <= :todat AND Product__c IN: Prodset limit 10000];
        else
            distnsr = [Select id from NSR_New_Actual__c where Commercial_Invoice_Date__c>= :frmdate AND Commercial_Invoice_Date__c <= :todat limit 10000];
        Delete distnsr;
    }
    global void finish(Database.BatchableContext BC) 
    {
        System.debug('----'+qrystr);
        NSRActuals nsr = new NSRActuals(qrystr); //ur batch class
        database.executebatch(nsr);
    }
}