trigger User_Target on User_Targets__c (before insert) 
{
    Map<String,Id> usrmap = new Map<String,Id>();
    List<String> empcode = new List<String>();
    
    for(User_Targets__c ut : trigger.new)
    {
        empcode.add(ut.Employee_ID__c);
    }
    
    List<User> usrlst = [select id,SAP_Code__c from User where SAP_Code__c IN: empcode and IsActive=true];
    for(User usr : usrlst)
    {
        usrmap.put(usr.SAP_Code__c,usr.id);
    }
    
    for(User_Targets__c ut : trigger.new)
    {
        if(usrmap.containsKey(ut.Employee_ID__c))
        {
            ut.OwnerId = usrmap.get(ut.Employee_ID__c);
        }
    }
}