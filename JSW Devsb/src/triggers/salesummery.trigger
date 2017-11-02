trigger salesummery on Invoice__c (after insert) 
{
    Map<String,Double> invmap = new Map<String,Double>();
    Map<String,String> acmap = new Map<String,String>();
    Map<String,Double> actrgtmap = new Map<String,Double>();
    Map<String,Double> dstrgtmap = new Map<String,Double>();
    Set<String> dstcode = new Set<String>();
    Set<String> accode = new Set<String>();
    Set<String> actrgtcode = new Set<String>();
    for(Invoice__c inv : trigger.new)
    {
        accode.add(inv.Sold_To_Code__c+inv.Distribution_Channel__c+inv.Division__c);
        if(!actrgtmap.containsKey(inv.Sold_To_Code__c+inv.Distribution_Channel__c+inv.Division__c+inv.Month_of_Commercial_Invoice_Date__c+inv.Year__c+inv.Brand_Short_Form__c))
            actrgtmap.put(inv.Sold_To_Code__c+inv.Distribution_Channel__c+inv.Division__c+inv.Month_of_Commercial_Invoice_Date__c+inv.Year__c+inv.Brand_Short_Form__c,inv.Qty__c);
        else
            actrgtmap.put(inv.Sold_To_Code__c+inv.Distribution_Channel__c+inv.Division__c+inv.Month_of_Commercial_Invoice_Date__c+inv.Year__c+inv.Brand_Short_Form__c,actrgtmap.get(inv.Sold_To_Code__c+inv.Distribution_Channel__c+inv.Division__c+inv.Month_of_Commercial_Invoice_Date__c+inv.Year__c+inv.Brand_Short_Form__c)+inv.Qty__c);
        
        dstcode.add(inv.Sales_District__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c);
        if(!dstrgtmap.containsKey(inv.Sales_District__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c))
            dstrgtmap.put(inv.Sales_District__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c,inv.Qty__c);
        else    
            dstrgtmap.put(inv.Sales_District__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c,dstrgtmap.get(inv.Sales_District__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c)+inv.Qty__c);
            
        if(!invmap.containsKey(inv.Plant_Short_Form__c+':'+inv.Sales_District__c+':'+inv.Sold_To_Code__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).substring(0,10)+':'+inv.Brand_Short_Form__c))
            invmap.put(inv.Plant_Short_Form__c+':'+inv.Sales_District__c+':'+inv.Sold_To_Code__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).substring(0,10)+':'+inv.Brand_Short_Form__c,inv.Qty__c);
        else
            invmap.put(inv.Plant_Short_Form__c+':'+inv.Sales_District__c+':'+inv.Sold_To_Code__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).substring(0,10)+':'+inv.Brand_Short_Form__c,invmap.get(inv.Plant_Short_Form__c+':'+inv.Sales_District__c+':'+inv.Sold_To_Code__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).substring(0,10)+':'+inv.Brand_Short_Form__c)+inv.Qty__c);
    }
    
   
    List<District_Targets__c> dsttrgt = [Select id,District_Actuals__c,District_Code__c,Month__c,Product_Group__c,Year__c,District_Trade_Actuals__c,District_Non_Trade_Actuals__c,Code_DT__c from District_Targets__c where Code_DT__c IN: dstcode];
    List<Target__c> trgtlst = [Select id,Code_Target__c,Dealer_Actuals__c from Target__c where Code_Target__c IN :actrgtmap.keySet()];
    List<Daily_Sales__c> sslist = [Select id,Actuals_in_QTY_MT__c,Plant__c,Sales_Office_Description__c,Customer__c,Commercial_Invoice_Date__c,Product_Group__c,Grand_Total__c,Code_Formula__c from Daily_Sales__c where Code_Formula__c IN: invmap.keyset()];
    List<Account> aclist = [Select id,Name,External_ID__c,OwnerId,Owner.FirstName,Owner.LastName,Sales_Office_text__c,Customer_Code__c from Account where External_ID__c IN :accode]; 
    
    for(District_Targets__c dt : dsttrgt)
    {
        if(dstrgtmap.containsKey(dt.Code_DT__c))
            dt.District_Actuals__c = dt.District_Actuals__c==null ? dstrgtmap.get(dt.Code_DT__c) : dt.District_Actuals__c+dstrgtmap.get(dt.Code_DT__c);
    }
    for(Target__c tgt : trgtlst)
    {
        if(actrgtmap.containsKey(tgt.Code_Target__c))
            tgt.Dealer_Actuals__c = tgt.Dealer_Actuals__c==null ? actrgtmap.get(tgt.Code_Target__c) : tgt.Dealer_Actuals__c+actrgtmap.get(tgt.Code_Target__c);
    }
    for(Account ac : aclist)
    {
        acmap.put(ac.Customer_Code__c,ac.id);
    }
    for(Daily_Sales__c ds : sslist)
    {
        if(invmap.containsKey(ds.Code_Formula__c))
        {
            ds.Grand_Total__c = ds.Grand_Total__c==null ?invmap.get(ds.Code_Formula__c):ds.Grand_Total__c+invmap.get(ds.Code_Formula__c);
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
    update trgtlst;
}