global class batchAccountUpdate implements Database.Batchable<sObject> {

    public String qrystr;
    public batchAccountUpdate(String str)
    {
        qrystr = str;
    }
    global Database.QueryLocator start(Database.BatchableContext BC) {
        //String query = 'Select id,name,Plant_Name__c,Sales_Office_Description__c,Account__c,Commercial_Invoice_Date_Formula__c,Qty__c from Invoice__c where Commercial_Invoice_Date_Formula__c in (2016-12-23,2016-12-24,2016-12-25,2016-12-26,2016-12-27,2016-12-28,2016-12-29,2016-12-30,2016-12-31) and Account__c != null';
        String query = qrystr;
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Invoice__c> scope) {
        Map<String,Double> invmap = new Map<String,Double>();
        Map<String,String> acmap = new Map<String,String>();
        Map<String,Double> actrgtmap = new Map<String,Double>();
        List<Daily_Sales__c> sslist = new List<Daily_Sales__c>();
        Set<String> accode = new Set<String>();
        for(Invoice__c inv : scope)
        {
            System.debug('------>'+inv);
            accode.add(inv.Sold_To_Code__c+inv.Distribution_Channel__c+inv.Division__c);
            
            if(!actrgtmap.containsKey(inv.Sold_To_Code__c+inv.Distribution_Channel__c+inv.Division__c+inv.Month_of_Commercial_Invoice_Date__c+inv.Year__c+inv.Brand_Short_Form__c))
                actrgtmap.put(inv.Sold_To_Code__c+inv.Distribution_Channel__c+inv.Division__c+inv.Month_of_Commercial_Invoice_Date__c+inv.Year__c+inv.Brand_Short_Form__c,inv.Qty__c);
            else
                actrgtmap.put(inv.Sold_To_Code__c+inv.Distribution_Channel__c+inv.Division__c+inv.Month_of_Commercial_Invoice_Date__c+inv.Year__c+inv.Brand_Short_Form__c,actrgtmap.get(inv.Sold_To_Code__c+inv.Distribution_Channel__c+inv.Division__c+inv.Month_of_Commercial_Invoice_Date__c+inv.Year__c+inv.Brand_Short_Form__c)+inv.Qty__c);
            
            if(!invmap.containsKey(inv.Plant_Short_Form__c+':'+inv.Sales_District__c+':'+inv.Sold_To_Code__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).substring(0,10)+':'+inv.Brand_Short_Form__c))
                invmap.put(inv.Plant_Short_Form__c+':'+inv.Sales_District__c+':'+inv.Sold_To_Code__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).substring(0,10)+':'+inv.Brand_Short_Form__c,inv.Qty__c);
            else
                invmap.put(inv.Plant_Short_Form__c+':'+inv.Sales_District__c+':'+inv.Sold_To_Code__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).substring(0,10)+':'+inv.Brand_Short_Form__c,invmap.get(inv.Plant_Short_Form__c+':'+inv.Sales_District__c+':'+inv.Sold_To_Code__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).substring(0,10)+':'+inv.Brand_Short_Form__c)+inv.Qty__c);
            
            System.debug('------>'+invmap);
            /*if(!invmap.containsKey(inv.Plant_Name__c+':'+inv.Sales_Office_Description__c+':'+inv.Account__c+':'+inv.Commercial_Invoice_Date_Formula__c))
                invmap.put(inv.Plant_Name__c+':'+inv.Sales_Office_Description__c+':'+inv.Account__c+':'+inv.Commercial_Invoice_Date_Formula__c,inv.Qty__c);
            else
                invmap.put(inv.Plant_Name__c+':'+inv.Sales_Office_Description__c+':'+inv.Account__c+':'+inv.Commercial_Invoice_Date_Formula__c,invmap.get(inv.Plant_Name__c+':'+inv.Sales_Office_Description__c+':'+inv.Account__c+':'+inv.Commercial_Invoice_Date_Formula__c)+inv.Qty__c);*/
        }
        sslist = [Select id,Actuals_in_QTY_MT__c,Plant__c,Sales_Office_Description__c,Customer__c,Commercial_Invoice_Date__c,Product_Group__c,Grand_Total__c,Code_Formula__c from Daily_Sales__c where Code_Formula__c IN: invmap.keyset()];
        List<Account> aclist = [Select id,Name,External_ID__c,OwnerId,Owner.FirstName,Owner.LastName,Sales_Office_text__c,Customer_Code__c from Account where External_ID__c IN :accode]; 
        List<Target__c> trgtlst = [Select id,Code_Target__c,Dealer_Actuals__c from Target__c where Code_Target__c IN :actrgtmap.keySet()];
         
        for(Account ac : aclist)
        {
            acmap.put(ac.Customer_Code__c,ac.id);
        }
        
        for(Target__c tgt : trgtlst)
        {
            if(actrgtmap.containsKey(tgt.Code_Target__c))
                tgt.Dealer_Actuals__c = tgt.Dealer_Actuals__c==null ? actrgtmap.get(tgt.Code_Target__c) : tgt.Dealer_Actuals__c+actrgtmap.get(tgt.Code_Target__c);
        }
        
        for(Daily_Sales__c ds : sslist)
        {
            if(invmap.containsKey(ds.Code_Formula__c))
            {
                ds.Grand_Total__c = ds.Grand_Total__c==null ? invmap.get(ds.Code_Formula__c) : ds.Grand_Total__c+invmap.get(ds.Code_Formula__c);
                invmap.remove(ds.Code_Formula__c);
            }
        }
        
        for(String str : invmap.keySet())
        {
            Daily_Sales__c ds=new Daily_Sales__c();
            ds.Plant__c = str.split(':')[0];
            ds.Sales_Office_Description__c = str.split(':')[1];
            if(acmap.containsKey(str.split(':')[2]))
                ds.Account__c = acmap.get(str.split(':')[2]);
            ds.Commercial_Invoice_Date__c = Date.valueOf(str.split(':')[3]);
            ds.Product_Group__c = str.split(':')[4];
            ds.Grand_Total__c=invmap.get(str);
            sslist.add(ds);
        }
        upsert sslist;   
    }   
    
    global void finish(Database.BatchableContext BC) {
    }
}