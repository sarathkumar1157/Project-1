global class batchUserTrgtUpdate implements Database.Batchable<sObject> 
{
    public String qrystr;
    public Date myDate;
    public batchUserTrgtUpdate(String str)
    {
        myDate = System.today()-1;
        //qrystr = str+String.valueOf(myDate).substring(0,10);
        qrystr = str;
        System.debug('----->'+qrystr);
    }
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = qrystr;
        System.debug('----->'+query);
        return Database.getQueryLocator(qrystr);
    }
    
    global void execute(Database.BatchableContext BC, List<Invoice__c> scope) 
    {
        Map<String,Double> usrtrgtmapT = new Map<String,Double>();
        Map<String,Double> usrtrgtmapNT = new Map<String,Double>();
        Map<String,Double> nsrtrgtmapT = new Map<String,Double>();
        Map<String,Double> nsrtrgtmapNT = new Map<String,Double>();
        Map<String,Double> usrtrgtmap15 = new Map<String,Double>();
        Map<Id,String> usrmap = new Map<Id,String>();
        List<invoice__c> invlist = new List<Invoice__c>();
        Set<ID> usrids = new Set<ID>();
        Map<ID,integer> newusrmap = new Map<ID,integer>();
        Date mydate = date.newInstance((System.today()-1).year(),(System.today()-1).month(),16);
        List<Account> newaccs = [Select id,Ownerid from Account where CALENDAR_MONTH(CreatedDate)=:mydate.month()];
        System.debug('---mydate---'+mydate);
        for(Account ac : newaccs)
        {
            if(!newusrmap.containsKey(ac.Ownerid))
                newusrmap.put(ac.Ownerid,1);
            else
                newusrmap.put(ac.Ownerid,newusrmap.get(ac.Ownerid)+1);
        }
        
        for(Invoice__c inv : scope)
        {
            usrids.add(inv.OwnerId);
            if(inv.Distribution_Channel__c == '10')
                if(!usrtrgtmapT.containsKey(inv.OwnerId+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c))
                {
                    nsrtrgtmapT.put(inv.OwnerId+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c,inv.NSR_T_Value__c);                 
                    usrtrgtmapT.put(inv.OwnerId+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c,inv.Qty__c);                 
                }
                else
                {
                    nsrtrgtmapT.put(inv.OwnerId+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c,usrtrgtmapT.get(inv.OwnerId+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c)+inv.NSR_T_Value__c);   
                    usrtrgtmapT.put(inv.OwnerId+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c,usrtrgtmapT.get(inv.OwnerId+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c)+inv.Qty__c);  
                }
            if(inv.Distribution_Channel__c == '20')
                if(!usrtrgtmapNT.containsKey(inv.OwnerId+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c))
                {
                    nsrtrgtmapNT.put(inv.OwnerId+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c,inv.NSR_T_Value__c);
                    usrtrgtmapNT.put(inv.OwnerId+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c,inv.Qty__c);
                }
                else
                {
                    nsrtrgtmapNT.put(inv.OwnerId+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c,usrtrgtmapNT.get(inv.OwnerId+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c)+inv.NSR_T_Value__c);
                    usrtrgtmapNT.put(inv.OwnerId+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c,usrtrgtmapNT.get(inv.OwnerId+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c)+inv.Qty__c);
                }
            if(inv.Commercial_Invoice_Date_Formula__c < mydate && inv.Commercial_Invoice_Date_Formula__c.month() == (System.today()-1).month())
            {
                System.debug('---comDate---'+inv.Commercial_Invoice_Date_Formula__c);
                if(!usrtrgtmap15.containsKey(inv.OwnerId+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c))
                    usrtrgtmap15.put(inv.OwnerId+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c,inv.Qty__c);                 
                else
                    usrtrgtmap15.put(inv.OwnerId+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c,usrtrgtmap15.get(inv.OwnerId+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c)+inv.Qty__c);  
            }
            
            inv.User_Inv_Processed__c = true;
            invlist.add(inv);
        }
        
        System.debug('---T'+usrtrgtmapT);
        System.debug('---NT'+usrtrgtmapNT);
        System.debug('---15'+usrtrgtmap15);
        
        List<User_Targets__c> UTList = [Select id,UT_Code__c,User_Trade_Actuals__c,User_Non_Trade_Actuals__c,Ownerid,X15_Days_Actuals__c,NSR_Trade_Actuals__c,NSR_NT_Actuals__c from User_Targets__c where UT_Code__c IN: usrtrgtmapT.keySet() OR UT_Code__c IN: usrtrgtmapNT.keySet()];
        List<User> usrlst = [Select Id,SAP_Code__c from User where Id IN: usrids];
        List<User_Targets__c> UTListInsert = new List<User_Targets__c>();
        
        for(User usr : usrlst)
        {
            usrmap.put(usr.Id,usr.SAP_Code__c);
        }
        
        for(User_Targets__c ut : UTList)
        {
            if(usrtrgtmapT.containsKey(ut.UT_Code__c))
            {
                ut.NSR_Trade_Actuals__c = ut.NSR_Trade_Actuals__c==null ? nsrtrgtmapT.get(ut.UT_Code__c) : ut.NSR_Trade_Actuals__c + nsrtrgtmapT.get(ut.UT_Code__c);
                ut.User_Trade_Actuals__c = ut.User_Trade_Actuals__c==null ? usrtrgtmapT.get(ut.UT_Code__c) : ut.User_Trade_Actuals__c + usrtrgtmapT.get(ut.UT_Code__c);
                usrtrgtmapT.remove(ut.UT_Code__c);
                nsrtrgtmapT.remove(ut.UT_Code__c);
            }
            if(usrtrgtmapNT.containsKey(ut.UT_Code__c))
            {
                ut.NSR_NT_Actuals__c = ut.NSR_NT_Actuals__c ==null ? nsrtrgtmapNT.get(ut.UT_Code__c) : ut.NSR_NT_Actuals__c+ nsrtrgtmapNT.get(ut.UT_Code__c);
                ut.User_Non_Trade_Actuals__c = ut.User_Non_Trade_Actuals__c==null ? usrtrgtmapNT.get(ut.UT_Code__c) : ut.User_Non_Trade_Actuals__c + usrtrgtmapNT.get(ut.UT_Code__c);
                usrtrgtmapNT.remove(ut.UT_Code__c);
                nsrtrgtmapNT.remove(ut.UT_Code__c);
            }
            if(usrtrgtmap15.containsKey(ut.UT_Code__c))
            {
                ut.X15_Days_Actuals__c = ut.X15_Days_Actuals__c ==null ? usrtrgtmap15.get(ut.UT_Code__c) : ut.X15_Days_Actuals__c + usrtrgtmap15.get(ut.UT_Code__c);
                usrtrgtmap15.remove(ut.UT_Code__c);
            }
            if(newusrmap.containsKey(ut.Ownerid))
            {
                ut.No_of_New_Dealers_in_this_Month__c = newusrmap.get(ut.Ownerid);
                newusrmap.remove(ut.Ownerid);
            }
        }
        System.debug('---2'+usrtrgtmapT);
        System.debug('---2'+usrtrgtmapNT);
        for(String str : usrtrgtmapT.keySet())
        {
            User_Targets__c usrtrgt = new User_Targets__c();
            if(usrmap.containsKey(str.split(':')[0]))
                usrtrgt.Employee_ID__c = usrmap.get(str.split(':')[0]);
            usrtrgt.Month__c = str.split(':')[1];
            usrtrgt.Year__c = str.split(':')[2];
            usrtrgt.Product__c = str.split(':')[3];
            usrtrgt.User_Trade_Actuals__c = usrtrgtmapT.get(str);
            usrtrgt.NSR_Trade_Actuals__c = nsrtrgtmapT.get(str);
            usrtrgt.X15_Days_Actuals__c = usrtrgtmap15.get(str);
            if(newusrmap.containsKey(str.split(':')[0]))
            {
                usrtrgt.No_of_New_Dealers_in_this_Month__c = newusrmap.get(str.split(':')[0]);
                newusrmap.remove(str.split(':')[0]);
            }
            if(usrtrgtmapNT.containsKey(str))
            {
                usrtrgt.User_Non_Trade_Actuals__c = usrtrgtmapNT.get(str);
                usrtrgtmapNT.remove(str);
            }
            UTListInsert.add(usrtrgt);
                
        }
        for(String str : usrtrgtmapNT.keySet())
        {
            User_Targets__c usrtrgt = new User_Targets__c();
            if(usrmap.containsKey(str.split(':')[0]))
                usrtrgt.Employee_ID__c = usrmap.get(str.split(':')[0]);
            usrtrgt.Month__c = str.split(':')[1];
            usrtrgt.Year__c = str.split(':')[2];
            usrtrgt.Product__c = str.split(':')[3];
            usrtrgt.User_Non_Trade_Actuals__c = usrtrgtmapNT.get(str);
            usrtrgt.NSR_NT_Actuals__c = nsrtrgtmapNT.get(str);
            usrtrgt.X15_Days_Actuals__c = usrtrgtmap15.get(str);
            if(newusrmap.containsKey(str.split(':')[0]))
            {
                usrtrgt.No_of_New_Dealers_in_this_Month__c = newusrmap.get(str.split(':')[0]);
                newusrmap.remove(str.split(':')[0]);
            }
            if(usrtrgtmapT.containsKey(str))
            {
                usrtrgt.User_Trade_Actuals__c = usrtrgtmapT.get(str);
                usrtrgtmapT.remove(str);
            }
            UTListInsert.add(usrtrgt);
        }
        Update UTList;
        Update invlist;
        Insert UTListInsert;
    }
    global void finish(Database.BatchableContext BC) {
    }
}