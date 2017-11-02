global class MaharashtraActualsDelete implements Database.Batchable<sObject> 
{
    public String qrystr;
    public MaharashtraActualsDelete(String str)
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
        List<Maharashtra_Actuals__c> mhlist = new List<Maharashtra_Actuals__c>();
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
            mhlist = [Select id from Maharashtra_Actuals__c where Commercial_Invoice_Date__c>= :frmdate AND Commercial_Invoice_Date__c <= :todat AND Product__c IN: Prodset limit 10000];
        else
            mhlist = [Select id from Maharashtra_Actuals__c where Commercial_Invoice_Date__c>= :frmdate AND Commercial_Invoice_Date__c <= :todat limit 10000];
        Delete mhlist;
    }
    global void finish(Database.BatchableContext BC) 
    {
        MaharashtraActuals distact = new MaharashtraActuals(qrystr); //ur batch class
        database.executebatch(distact); 
    }
}