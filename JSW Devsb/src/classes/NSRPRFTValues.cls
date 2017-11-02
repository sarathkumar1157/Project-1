global class NSRPRFTValues implements Database.Batchable<sObject> 
{
    public String qrystr;
    public NSRPRFTValues(String str)
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
    
    global void execute(Database.BatchableContext BC, List<NSR_PRFT_Values__c> scope) 
    {
        List<NSR_PRFT_Values__c> PRFTList = new List<NSR_PRFT_Values__c>();
        Set<String> setPSF = new Set<String>();
        Set<String> setPlnt = new Set<String>();
        Set<String> setSLOC = new Set<String>();
        Set<String> setProd = new Set<String>();
        Date frmdate;
        Date todat;
        for(NSR_PRFT_Values__c pd : scope)
        {
            setPSF.add(pd.MFG_Plant__c);
            setPlnt.add(pd.Plant__c);
            setProd.add(pd.Product__c);
            setSLOC.add(pd.Storage_Location__c);
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
        
        List<Invoice__c> invList = [Select id,Plant_Short_Form__c,Brand_Short_Form__c,Plant__c,SLOC__c,Commercial_Invoice_Date_Formula__c,NSR_PRFT_Value__c from Invoice__c where Plant_Short_Form__c IN: setPSF AND Plant__c IN: setPlnt AND SLOC__c IN: setSLOC AND Brand_Short_Form__c IN: setProd AND Commercial_Invoice_Date_Formula__c>=:frmdate AND Commercial_Invoice_Date_Formula__c<=:todat];
        
        for(NSR_PRFT_Values__c pd : scope)
        {
            for(Invoice__c inv : invList)
            {
                if(inv.Plant_Short_Form__c == pd.MFG_Plant__c && inv.Brand_Short_Form__c == pd.Product__c && inv.Plant__c == pd.Plant__c && inv.SLOC__c == pd.Storage_Location__c && inv.Commercial_Invoice_Date_Formula__c >= pd.From_Date__c && inv.Commercial_Invoice_Date_Formula__c <= pd.To_Date__c)
                    inv.NSR_PRFT_Value__c = pd.PRFT_Value__c;
            }
            pd.To_Be_Processed__c = False;
            PRFTList.add(pd);
        }
        update invlist;
        update PRFTlist;
    }
    
    global void finish(Database.BatchableContext BC) 
    {
        
    }
}