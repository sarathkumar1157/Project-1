trigger custupdate on Customer_Incentive__c (before insert,before update) 
{
    Set<String> custcode = new Set<String>();
    Map<String,String> accmap = new Map<String,String>();
    
    for(Customer_Incentive__c ci : trigger.new)
    {
        custcode.add(ci.Customer_Code__c);
    }
    
    List<Account> acclist = [Select id,Customer_Code__c from Account where Customer_Code__c IN: custcode];
    
    for(Account acc : acclist)
    {
        accmap.put(acc.Customer_Code__c,acc.id);
    }
    for(Customer_Incentive__c ci : trigger.new)
    {
        if(accmap.containsKey(ci.Customer_Code__c))
            ci.Customer_Account__c = accmap.get(ci.Customer_Code__c);
    }
}