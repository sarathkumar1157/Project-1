trigger updatelookupsActuals on Actuals__c (before insert) 
{
    Map<String,String> cstmap = new Map<String,String>();
    List<String> cststr = new List<String>();
    Map<String,String> termap = new Map<String,String>();
    List<String> terstr = new List<String>();
    
    for(Actuals__c act : trigger.new)
    {
        cststr.add(act.Customer_Code__c+act.Distribution_Channel__c+act.Division__c);
        terstr.add(act.Territory__c);
    }
    
    List<Account> aclist = [Select id,Name,External_ID__c,OwnerId,Owner.FirstName,Owner.LastName,Sales_Office_text__c from Account where External_ID__c IN :cststr];
    List<District__c> terlist = [Select id,name,Territory_Code__c from District__c where Territory_Code__c IN: terstr];
    
     for(Account ac : aclist)
    {
        cstmap.put(ac.External_ID__c,ac.id+':'+ac.ownerId);
    }
    
    for(District__c dst : terlist)
    {
        termap.put(dst.Territory_Code__c,dst.id);
    }
    
    /*for(Actuals__c actl : trigger.new)
    {
        if(cstmap.containsKey(actl.Customer_Code__c+actl.Distribution_Channel__c+actl.Division__c))
        {
            actl.Customer_Name__c = cstmap.get(actl.Customer_Code__c+actl.Distribution_Channel__c+actl.Division__c).split(':')[0];
            actl.OwnerId = cstmap.get(actl.Customer_Code__c+actl.Distribution_Channel__c+actl.Division__c).split(':')[1];
        }
        if(termap.containsKey(actl.Territory__c))
            actl.Territory__c = termap.get(actl.Territory__c);
    }*/
}