trigger AdhocValues on Adhoc_Incentive__c(before insert,before update) 
{
    Map<String,String> dstmap = new Map<String,String>();
    List<String> dststr = new List<String>();
    
    for(Adhoc_Incentive__c dt : trigger.new)
    {
        dststr.add(dt.District_Code__c);
    }
    
    List<Districts__c> dstlst = [select id,State__c,District_Code__c,State_Code__c from Districts__c where District_Code__c IN: dststr];
    
    for(Districts__c dst : dstlst)
    {
        dstmap.put(dst.District_Code__c,dst.id);
    }
    
    for(Adhoc_Incentive__c dt : trigger.new)
    {
        if(dstmap.containsKey(dt.District_Code__c))
        {
            dt.Districts__c = dstmap.get(dt.District_Code__c);
        }
    }
}