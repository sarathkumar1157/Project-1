public class incentive_netdealer
{
    Set<id> acids = new Set<id>();
    Map<String,String> usrmap = new Map<String,String>();
    public void m1()
    {
        Integer mnthnum = System.today().month();
        List<Account> newaccs = [Select id,Ownerid from Account where CALENDAR_MONTH(CreatedDate)=:mnthnum];
        for(Account ac : newaccs)
        {
            acids.add(ac.Ownerid);
        }
        Integer newdlrs = acids.size();
        
        List<Invoice__c> inv = [Select id,ownerId from Invoice__c where ownerId IN:acids];
        for(Invoice__c iv : inv)
        {
            usrmap.put(iv.ownerId,iv.id);
        }
        Integer newdlrbills = acids.size() - usrmap.size();
        
        List<User> userslst = [Select id from User where id IN: usrmap.keyset()];
        
        for(User usr : userslst)
        {
            if(usrmap.containsKey(usr.id))
            {
                //usr.PSC_Sales_Acheivement__c = usrmap.get(usr.id);
                //user field = (newdlrs - newdlrbills)/newdlrs;
            }
        }
        
        /*List<User_Targets__c> usrtgt = [Select id,User_Pro_Rata_Acheivement__c,ownerId from User_Targets__c where ownerId IN: acids];
        
        for(User_Targets__c ut : usrtgt)
        {
            usrmap.put(ut.ownerId,ut.User_Pro_Rata_Acheivement__c);
        }
        
        List<User> userslst = [Select id,PSC_Sales_Acheivement__c from User where id IN: usrmap.keyset()];
        
        for(User usr : userslst)
        {
            if(usrmap.containsKey(usr.id))
            {
                usr.PSC_Sales_Acheivement__c = usrmap.get(usr.id);
            }
        }*/
    }
}