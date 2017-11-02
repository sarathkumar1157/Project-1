global class NSRCFValues implements Database.Batchable<sObject> 
{
    public String qrystr;
    public NSRCFValues(String str)
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
    
    global void execute(Database.BatchableContext BC, List<NSR_C_F_Value_Changes__c> scope) 
    {
        List<NSR_C_F_Value_Changes__c> CFList = new List<NSR_C_F_Value_Changes__c>();
        Set<String> setPlnt = new Set<String>();
        Set<String> setProd = new Set<String>();
        Set<String> setSLOC = new Set<String>();
        Date frmdate;
        Date todat;
        for(NSR_C_F_Value_Changes__c pd : scope)
        {
            setPlnt.add(pd.Plant__c);
            setSLOC.add(pd.Storage_Location__c);
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
        
        List<Invoice__c> invList = [Select id,Plant__c,Brand_Short_Form__c,SLOC__c,Commercial_Invoice_Date_Formula__c,NSR_C_F_Value__c from Invoice__c where Plant__c IN: setPlnt AND Brand_Short_Form__c IN: setProd AND SLOC__c IN: setSLOC AND Commercial_Invoice_Date_Formula__c>=:frmdate AND Commercial_Invoice_Date_Formula__c<=:todat];
        
        for(NSR_C_F_Value_Changes__c pd : scope)
        {
            for(Invoice__c inv : invList)
            {
                 if(inv.Plant__c == pd.Plant__c && inv.Brand_Short_Form__c == pd.Product__c && inv.SLOC__c == pd.Storage_Location__c && inv.Commercial_Invoice_Date_Formula__c >= pd.From_Date__c && inv.Commercial_Invoice_Date_Formula__c <= pd.To_Date__c)
                    inv.NSR_C_F_Value__c = pd.Value__c;
            }
            pd.To_Be_Processed__c = False;
            CFList.add(pd);
        }
        update invlist;
        update CFlist;
    }
    
    global void finish(Database.BatchableContext BC) 
    {
        
    }
}