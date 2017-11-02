global class NSRCIValues implements Database.Batchable<sObject> 
{
    public String qrystr;
    public NSRCIValues(String str)
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
    
    global void execute(Database.BatchableContext BC, List<Customer_Incentive__c> scope) 
    {
        List<Customer_Incentive__c> CIList = new List<Customer_Incentive__c>();
        Set<String> setStoC = new Set<String>();
        Set<String> setProd = new Set<String>();
        Set<String> setDC = new Set<String>();
        Date frmdate;
        Date todat;
        
        for(Customer_Incentive__c pd : scope)
        {
            setStoC.add(pd.Customer_Code__c);
            setDC.add(pd.Distribution_Channel__c);
            setProd.add(pd.Product__c);
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
        
        List<Invoice__c> invList = [Select id,Sold_To_Code__c,Brand_Short_Form__c,distribution_Channel__c,Commercial_Invoice_Date_Formula__c,NSR_C_F_Value__c from Invoice__c where Sold_To_Code__c IN: setStoC AND Brand_Short_Form__c IN: setProd AND distribution_Channel__c IN: setDC AND Commercial_Invoice_Date_Formula__c>=:frmdate AND Commercial_Invoice_Date_Formula__c<=:todat];
        
        for(Customer_Incentive__c pd : scope)
        {
            for(Invoice__c inv : invList)
            {
                 if(inv.Sold_To_Code__c == pd.Customer_Code__c && inv.Brand_Short_Form__c == pd.Product__c && inv.distribution_Channel__c == pd.Distribution_Channel__c && inv.Commercial_Invoice_Date_Formula__c >= pd.From_Date__c && inv.Commercial_Invoice_Date_Formula__c <= pd.To_Date__c)
                    inv.Customer_Incentive_Value__c = pd.Value__c;
            }
            pd.To_Be_Processed__c = False;
            CIList.add(pd);
        }
        update invlist;
        update CIlist;
    }
    
    global void finish(Database.BatchableContext BC) 
    {
        
    }
}