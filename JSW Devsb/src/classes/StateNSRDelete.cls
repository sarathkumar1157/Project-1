global class StateNSRDelete implements Database.Batchable<sObject> 
{
    public String qrystr;
    public StateNSRDelete(String str)
    {
        qrystr = str;
        System.debug('----->'+qrystr);
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) 
    {
        return Database.getQueryLocator(qrystr);
    }
    
    global void execute(Database.BatchableContext BC, List<Invoice__c> scope) 
    {
        List<State_NSR_Actuals__c> statensr = new List<State_NSR_Actuals__c>();
        Set<String> Prodset = new Set<String>();
        Date frmdate;
        Date todat;
        
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
            statensr = [Select id from State_NSR_Actuals__c where Commercial_Invoice_Date__c>= :frmdate AND Commercial_Invoice_Date__c <= :todat AND Product__c IN: Prodset limit 10000];
        else
            statensr = [Select id from State_NSR_Actuals__c where Commercial_Invoice_Date__c>= :frmdate AND Commercial_Invoice_Date__c <= :todat limit 10000];
        Delete statensr;
    }
    global void finish(Database.BatchableContext BC) 
    {
        System.debug('----->'+qrystr);
        StateNSRActuals nsr = new StateNSRActuals(qrystr); //ur batch class
        database.executebatch(nsr);  
    }
}