global class StateActualsDelete implements Database.Batchable<sObject> 
{
    public String qrystr;
    public StateActualsDelete(String str)
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
        List<State_Actuals__c> statensr = new List<State_Actuals__c>();
        Set<String> Prodset = new Set<String>();
        Date frmdate;
        Date todat;
        for(Invoice__c inv : scope)
        {
            Prodset.add(inv.Brand_Short_Form__c);
            if(frmdate == null && todat == null)
            {
                frmdate = inv.Commercial_Invoice_Date_Formula__c;
                todat = inv.Commercial_Invoice_Date_Formula__c;
            }
            else if(frmdate > inv.Commercial_Invoice_Date_Formula__c)
                frmdate = inv.Commercial_Invoice_Date_Formula__c;
            else if(todat < inv.Commercial_Invoice_Date_Formula__c)
                todat = inv.Commercial_Invoice_Date_Formula__c;
        } 
           
        if(Prodset.size() > 0)
            statensr = [Select id from State_Actuals__c where Commercial_Invoice_Date__c>= :frmdate AND Commercial_Invoice_Date__c <= :todat AND Product__c IN: Prodset limit 10000];
        else
            statensr = [Select id from State_Actuals__c where Commercial_Invoice_Date__c>= :frmdate AND Commercial_Invoice_Date__c <= :todat limit 10000];
        Delete statensr;
    }
    
    global void finish(Database.BatchableContext BC) 
    {
        System.debug('----'+qrystr);
        StateActuals nsr = new StateActuals(qrystr); //ur batch class
        database.executebatch(nsr);
    }
}