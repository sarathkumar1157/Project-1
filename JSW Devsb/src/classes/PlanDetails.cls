public class PlanDetails{
    @AuraEnabled
    public static list<Monthly_Dealer_Target__c> getRecord(string id1)
    {
        return [select id, name, ASM_Target__c, ASM_Target__r.Name,Districts__r.Name,Target_Date__c,Products__c,Sales_Officer__c,Sales_Officer__r.name,Territorys__c,Target__c,Actuals__c,Quantity__c from Monthly_Dealer_Target__c where id=:id1 Order By Name];
    }
    @AuraEnabled
    public static list<Monthly_Targets__c> getChdRecord(string id1)
    {
        return [select id,Dealer__c,Dealer__r.Name,Dealer_Name__c,name,Last_Month_Actual__c,Last_Year_Same_Month_Actual__c,Monthly_Dealer_Target__c,Monthly_Dealer_Target__r.Name,Monthly_Target__c,Monthly_Actaul__c,Quantity__c from Monthly_Targets__c where Monthly_Dealer_Target__c=:id1 Order By Dealer__r.Name];
    }
    @AuraEnabled
    public static boolean getmtso(String cdate,String prod,String uname)
    {
        //Date myDate = Date.newInstance(cdate.year(),cdate.month(),cdate.day());
        Integer year = Integer.valueOf(cdate.split('-')[0]);
        Integer mnth = Integer.valueOf(cdate.split('-')[1]);
        Integer day = Integer.valueOf(cdate.split('-')[2]);
        Date myDate = Date.newInstance(year,mnth,day);
        system.debug('myDate'+myDate);
        list<Monthly_Dealer_Target__c> mt = [select id from Monthly_Dealer_Target__c where Products__c=:prod and CALENDAR_MONTH(Target_Date__c)=:mnth and Sales_Officer__r.Name=:uname];
        return (mt.size()>0);
    }
    @AuraEnabled
    public static list<String> getAllProducts()
    {
        list<Product2> prdlist = [select Group__c from Product2 Order By Name];
        set<String> prdset = new set<string>();
        list<String> prdlst = new list<string>();
        for(Product2 str:prdlist)
        prdset.add(str.group__c);
        prdlst.addAll(prdset);
        return prdlst;
    }
    @AuraEnabled
    public static list<ASM_Targets__c> getAllasms()
    {
        return [select id, name from ASM_Targets__c Order By Name];
    }
    @AuraEnabled
    public static list<Account> getAllAccounts()
    {
        system.debug('----');
        return [select id, name from Account Order By Name];
    }
    @AuraEnabled
    public static list<District__c> getAllters(string dist)
    {
        return [select id, name from District__c where Districts__c = :dist Order By Name];
    }
    @AuraEnabled
    public static list<Districts__c> getAlldists()
    {
        return [select id, name from Districts__c Order By Name];
    }
    @AuraEnabled
    public static String getNT(String cdate,String prod)
    {
        Integer samemonth=Integer.valueOf(cdate.split('-')[1]);
        AggregateResult[] groupedResults = [select SUM(Total_value__c)tv from invoice__c where Account__r.OwnerId = :Userinfo.getUserId() and Account__r.RecordType.Name = 'Non-Trade' and Brand_Short_Form__c=:prod and CALENDAR_MONTH(Commercial_Invoice_Date__c)=:samemonth];
        if(groupedResults[0].get('tv') == null)
            return '0.00';
        else
            return String.valueOf(groupedResults[0].get('tv'));
    }
    @AuraEnabled
    public static List<wrapperlightning> getAccounts(String cdate,String prod)
    {
        Integer lastmonth=Integer.valueOf(cdate.split('-')[1])-1;
        Integer samemonth=Integer.valueOf(cdate.split('-')[1]);
        if(lastmonth == 0)
            lastmonth = 12;
        Integer cyear=Integer.valueOf(cdate.split('-')[0]);
        Integer pyear=Integer.valueOf(cdate.split('-')[0])-1;
        
        list<id> accid = new list<id>();
        Map<String,String> invmap = new Map<String,String>();
        List<wrapperlightning> dlrrecrds = new List<wrapperlightning>();

        List<Account> acc = [select id,name from Account where ownerID = :UserInfo.getUserId() and RecordType.Name = 'Trade' Order By Name LIMIT 50];
        for(Account dlrid : acc)
        {
            accid.add(dlrid.id);
        }
        
        List<Monthly_Targets__c> dlrtrgts = [select id,name,Monthly_Actaul__c,Dealer__c,Dealer_Name__c,Last_Month_Actual__c,Last_Year_Same_Month_Actual__c,month__c,year__c from Monthly_Targets__c where Dealer__c IN :accid];     
        list<invoice__c> inv =[select Account__c,Total_Basic_Price__c,Total_value__c,Qty__c from invoice__c where Account__c IN :accid and Brand_Short_Form__c=:prod and CALENDAR_MONTH(Commercial_Invoice_Date__c)=:samemonth];
        AggregateResult[] groupedResults = [select SUM(Total_value__c)tv,SUM(Qty__c)qty from invoice__c where Account__r.OwnerId = :Userinfo.getUserId() and Account__r.RecordType.Name = 'Non-Trade' and Brand_Short_Form__c=:prod and CALENDAR_MONTH(Commercial_Invoice_Date__c)=:samemonth];
        for(Account ac : acc)
        {
            Double total = 0.00;
            Double totalq = 0.00;
            for(invoice__c ivc : inv)
            {
                if(ac.id == ivc.Account__c)
                {
                    if(ivc.Total_value__c != null)
                        total = total + ivc.Total_value__c;
                    if(ivc.Qty__c != null)
                        totalq = totalq + ivc.Qty__c;
                }
            }
            invmap.put(ac.Name,total+':'+totalq);
        }
        wrapperlightning wln = new wrapperlightning();
        wln.dealer = 'Non Trade';
        wln.dlractual = groupedResults[0].get('tv') == null ? 0.00 : Double.valueOf(groupedResults[0].get('tv')) ;
        wln.dlrqty = groupedResults[0].get('qty') == null ? 0.00 : Double.valueOf(groupedResults[0].get('qty')) ;
        dlrrecrds.add(wln);
        for(String acname : invmap.keySet())
        {
            wrapperlightning wl = new wrapperlightning();
            wl.dealer = acname;
            for(Monthly_Targets__c mtid : dlrtrgts)
            {
                if(acname == mtid.Dealer_Name__c) 
                {   
                    if(mtid.Month__c == samemonth && Integer.valueOf(mtid.Year__c) == pyear)
                        wl.LYSMactual = mtid.Monthly_Actaul__c;
                    if(lastmonth == 12)
                    {
                            if(mtid.Month__c == lastmonth && Integer.valueOf(mtid.Year__c) == pyear)
                                wl.LMactual = mtid.Monthly_Actaul__c; 
                    }
                    else if(mtid.Month__c == lastmonth && Integer.valueOf(mtid.Year__c) == cyear)
                        wl.LMactual = mtid.Monthly_Actaul__c; 
                }
            }
            wl.dlractual = double.valueOf(invmap.get(acname).split(':')[0]);
            wl.dlrqty = double.valueOf(invmap.get(acname).split(':')[1]);
            system.debug('dlractual'+wl.dlractual);
            system.debug('dlractual1'+invmap.get('acname'));
            dlrrecrds.add(wl);
        }
        return dlrrecrds;
    }
    @AuraEnabled
    public static String getUserName() {
    return userinfo.getName();
  }
    @AuraEnabled
    public static void mnthtargts(string newdlrtrgt,Monthly_Dealer_Target__c newmdt,String cdate)
    {
        User usr = [select id,managerid from user where id=:Userinfo.getUserId()];
        Integer samemonth=Integer.valueOf(cdate.split('-')[1]);
        newmdt.Sales_Officer__c = usr.id; 
        //ASM_Targets__c asm = [select id from ASM_Targets__c where CreatedById=:usr.ManagerId and CALENDAR_MONTH(Date__c)=:samemonth];
        insert newmdt;
        
        List<Monthly_Targets__c> mtinsert = new List<Monthly_Targets__c>();
        wrapperlightning[] values = (List<wrapperlightning>) JSON.deserialize(newdlrtrgt,List<wrapperlightning>.Class);
        system.debug('=====values'+values);
        system.debug('==='+newmdt);
        Monthly_Dealer_Target__c mdt = [select id,name,Products__c,Target__c,Actuals__c,Quantity__c from Monthly_Dealer_Target__c where id=:newmdt.Id];
        system.debug('---mdt---'+mdt);
        if(values != null)
        for(wrapperlightning wl:values)
        {
            if(wl.dealer != 'Non Trade' && wl.dlrtrget != 0)
            {
                Monthly_Targets__c mt = new Monthly_Targets__c();
                account acc=[select id,name from account where name=:wl.dealer limit 1];
                mt.Dealer__c = acc.id;
                mt.Monthly_Dealer_Target__c = newmdt.id;
                mt.product_short__c = mdt.Products__c;
                mt.Last_Month_Actual__c = wl.LMactual;
                mt.Last_Year_Same_Month_Actual__c = wl.LYSMactual;
                mt.Monthly_Target__c = Double.valueof(wl.dlrtrget);
                mt.Monthly_Actaul__c = wl.dlractual;
                mt.Quantity__c = wl.dlrqty;
                mtinsert.add(mt);
                system.debug('==='+mdt.Target__c);
                system.debug('==='+newmdt.ASM_Target__c);
                /*mdt.Target__c = mdt.Target__c + Double.valueof(wl.dlrtrget);
                mdt.Actuals__c = mdt.Actuals__c==null ? wl.dlractual : mdt.Actuals__c+ wl.dlractual;
                mdt.Quantity__c = mdt.Quantity__c==null ? wl.dlrqty : mdt.Quantity__c+ wl.dlrqty;*/
            }
            else if(wl.dealer == 'Non Trade')
            {
                Monthly_Targets__c nt = new Monthly_Targets__c();
                nt.Dealer_NT_ND__c = 'Non Trade';
                nt.Monthly_Dealer_Target__c = newmdt.id;
                nt.product_short__c = mdt.Products__c;
                nt.Monthly_Target__c = Double.valueof(wl.dlrtrget);
                nt.Monthly_Actaul__c = wl.dlractual;
                nt.Quantity__c = wl.dlrqty;
                mtinsert.add(nt);
            }
        }  
        system.debug('--->'+mtinsert);
        /*Monthly_Targets__c nd = new Monthly_Targets__c();
        nd.Dealer_NT_ND__c = 'New Dealer';
        mtinsert.add(nd);*/
        if(mtinsert.size() > 0)
        insert mtinsert;
        update mdt;
    }
    //---------------Edit----------------//
    @AuraEnabled
    public static Void edittargts(String editmt,String editmdt) 
    {
        Monthly_Targets__c[] values = (List<Monthly_Targets__c>) JSON.deserialize(editmt,List<Monthly_Targets__c>.Class);
        Monthly_Dealer_Target__c[] values1 = (List<Monthly_Dealer_Target__c>) JSON.deserialize(editmdt,List<Monthly_Dealer_Target__c>.Class);
        system.debug('--0--'+values);
        system.debug('--1--'+values1);
        update values;
        update values1;
    }
}