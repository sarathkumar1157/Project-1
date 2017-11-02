global class NSRPDValues implements Database.Batchable<sObject> 
{
    public String qrystr;
    public NSRPDValues(String str)
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
    
    global void execute(Database.BatchableContext BC, List<NSR_PD_Values__c> scope) 
    {
        List<NSR_PD_Values__c> PDList = new List<NSR_PD_Values__c>();
        Set<String> setDist = new Set<String>();
        Set<String> setProd = new Set<String>();
        Set<String> setDC = new Set<String>();
        Date frmdate;
        Date todat;
        for(NSR_PD_Values__c pd : scope)
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
        
        List<Invoice__c> invList = [Select id,Sales_District__c,Brand_Short_Form__c,Distribution_channel__c,Commercial_Invoice_Date_Formula__c,NSR_PD_Value__c from Invoice__c where Sales_District__c IN: setDist AND Brand_Short_Form__c IN: setProd AND Distribution_channel__c IN: setDC AND Commercial_Invoice_Date_Formula__c>=:frmdate AND Commercial_Invoice_Date_Formula__c<=:todat];
        
        for(NSR_PD_Values__c pd : scope)
        {
            for(Invoice__c inv : invList)
            {
                if(inv.Sales_District__c == pd.district_code__c && inv.Brand_Short_Form__c == pd.Product__c && inv.distribution_Channel__c == pd.distribution_Channel__c && inv.Commercial_Invoice_Date_Formula__c >= pd.From_Date__c && inv.Commercial_Invoice_Date_Formula__c <= pd.To_Date__c)
                    inv.NSR_PD_Value__c = pd.PD_Value__c;
            }
            pd.To_Be_Processed__c = False;
            PDList.add(pd);
        }
        update invlist;
        update PDlist;
    }
    
    global void finish(Database.BatchableContext BC) 
    {
        
    }
}