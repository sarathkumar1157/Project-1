global class NSRAdhocValues implements Database.Batchable<sObject> 
{
    public String qrystr;
    public NSRAdhocValues(String str)
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
    
    global void execute(Database.BatchableContext BC, List<Adhoc_Incentive__c> scope) 
    {
        List<Adhoc_Incentive__c> AdList = new List<Adhoc_Incentive__c>();
        Set<String> setDist = new Set<String>();
        Set<String> setProd = new Set<String>();
        Set<String> setDC = new Set<String>();
        Date frmdate;
        Date todat;
        for(Adhoc_Incentive__c pd : scope)
        {
            setDist.add(pd.District_Code__c);
            setProd.add(pd.Product__c);
            setDC.add(pd.distribution_Channel__c);
            if(frmdate == null)
            {
                frmdate = pd.From_Date__c;
            }
            else if(frmdate > pd.From_Date__c)
                frmdate = pd.From_Date__c;
            if(todat == null)
            {
                todat = pd.To_Date__c;
            }
            else if(todat < pd.To_Date__c)
                todat = pd.To_Date__c;
        }
        
        List<Invoice__c> invList = [Select id,Sales_District__c,Brand_Short_Form__c,Distribution_channel__c,Commercial_Invoice_Date_Formula__c,Adhoc_Incentive_Value__c from Invoice__c where Sales_District__c IN: setDist AND Brand_Short_Form__c IN: setProd AND Distribution_channel__c IN: setDC AND Commercial_Invoice_Date_Formula__c>=:frmdate AND Commercial_Invoice_Date_Formula__c<=:todat];
        
        for(Adhoc_Incentive__c pd : scope)
        {
            for(Invoice__c inv : invList)
            {
                if(inv.Sales_District__c == pd.district_code__c && inv.Brand_Short_Form__c == pd.Product__c && inv.distribution_Channel__c == pd.Distribution_Channel__c && inv.Commercial_Invoice_Date_Formula__c >= pd.From_Date__c && inv.Commercial_Invoice_Date_Formula__c <= pd.To_Date__c)
                    inv.Adhoc_Incentive_Value__c = pd.Value__c;
            }
            pd.To_Be_Processed__c = False;
            AdList.add(pd);
        }
        update invlist;
        update Adlist;
    }
    
    global void finish(Database.BatchableContext BC) 
    {
        
    }
}