trigger targetDealer on Target__c (before insert, before update) 
{
    Map<String,String> accmap = new Map<String,String>();
    Map<String,String> termap = new Map<String,String>();
    List<String> accstr = new List<String>();
    List<String> terstr = new List<String>();
    
    for(Target__c tgt : trigger.new)
    {
        accstr.add(tgt.Customer_Code__c+tgt.Distribution_Channel__c+tgt.Division__c);
        terstr.add(tgt.Territory_Code__c);
        System.debug('--->'+accstr);
    }
    
    List<Account> aclist = [Select id,Name,External_ID__c,OwnerId,Owner.FirstName,Owner.LastName,Sales_Office_text__c from Account where External_ID__c IN :accstr]; 
    List<District__c> terlist = [Select id,name,Territory_Code__c from District__c where Territory_Code__c IN: terstr];
    System.debug('--->'+aclist);
    System.debug('--->'+terlist);
    
    for(Account ac : aclist)
    {
        accmap.put(ac.External_ID__c,ac.id+':'+ac.ownerId);
    }
    
    for(District__c dst : terlist)
    {
        termap.put(dst.Territory_Code__c,dst.id);
    }
    
    for(Target__c tgt : trigger.new)
    {
        if(accmap.containsKey(tgt.Customer_Code__c+tgt.Distribution_Channel__c+tgt.Division__c))
        {
            tgt.Dealer_Name__c = accmap.get(tgt.Customer_Code__c+tgt.Distribution_Channel__c+tgt.Division__c).split(':')[0];
            tgt.OwnerId = accmap.get(tgt.Customer_Code__c+tgt.Distribution_Channel__c+tgt.Division__c).split(':')[1];
        }
        if(termap.containsKey(tgt.Territory_Code__c))
            tgt.Territory__c = termap.get(tgt.Territory_Code__c);
    }
    /*for(Target__c tgt : trigger.new)
    {
        for(Account ac : aclist)
        {
            if(tgt.Customer_Code__c+tgt.Distribution_Channel__c+tgt.Division__c == ac.External_ID__c)
            {
                tgt.Dealer_Name__c = ac.id;
                tgt.OwnerId = ac.ownerId;
            }
        }
    }  
     
    for(Target__c tgt : trigger.new)
    {
        for(District__c ter : terlist)
        {
            if(tgt.Territory_Code__c == ter.Territory_Code__c)
            {
                tgt.Territory__c = ter.id;
            }
        }
    }*/
}