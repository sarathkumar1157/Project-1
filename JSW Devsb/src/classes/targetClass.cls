Public class targetClass
{
    public Targets__c tgt{set;get;}
    public List<Target_Child__c> tgtchd{set;get;}
    public Targets__c tgtrec{set;get;}
    public List<Target_Child__c> tgtchdrec{set;get;}
    public id tgtid{set;get;}
    public Target_Child__c tgtc{set;get;}
    public List<String> acnames{set;get;}
      public integer rindex{get;set;}
      public integer rowindex{get;set;}
      public integer rowIndex1{get;set;}
      public Object avgAmount{set;get;}
    public string tgtchunique;
    public boolean first{set;get;}  
    public boolean scnd{set;get;}  
      
    Public targetClass()
    {
        
    }
    Public targetClass(ApexPages.StandardController controller)
    {
        tgt = new Targets__c();
        tgt.ownerId = userinfo.getUserId();
        tgtc = new Target_Child__c(Nature__c='Existing');
        tgtchd = new List<Target_Child__c>();
        tgtrec = new Targets__c();
        tgtchdrec = new List<Target_Child__c>();
        acnames = new List<String>();
        first = false;
        scnd = false;
        tgtId = Apexpages.currentpage().getParameters().get('id');
        //this.erObject = (Target_Child__c)controller.getrecord();
        tgtchd.add(tgtc);
        List<Account> custs = [Select id,name from Account where OwnerId=:userinfo.getUserId()];
        for(Account ac:custs)
            acnames.add(ac.name);
        system.debug('--->'+tgtchd);
        if(tgtid!=null)
        {
            tgtrec = [select id,OwnerId,Month__c,Year__c,Product_Group__c,Territory__c,Target_Start_Date__c from Targets__c where id=:tgtid limit 1];
            tgtchdrec = [select id,Type__c,Targets__c,Nature__c,Customer_Name__c,Sales_Promoter__c,Territory__c,Target__c,No_of_Dealers__c from Target_Child__c where Targets__c =:tgtid];
            AggregateResult[] groupedResults = [SELECT sum(Target__c)aver FROM Target_Child__c where Product_Group__c ='PSC'];
            avgAmount = groupedResults[0].get('aver');
            System.debug('----SUM----'+avgAmount);
        }
    }
    
    public void addrow()
    {
        Target_Child__c tgtc1 = new Target_Child__c(Nature__c='Existing');
        tgtchd.add(tgtc1);
        tgtchdrec.add(tgtc1);
    }
    
    public void deleteRow() 
    {
        System.debug('TESTing BItBucket1111');
        system.debug('------IN Deleterow');
        rowIndex1 = Integer.valueOf(ApexPages.currentPage().getParameters().get('rowIndex1'));
        system.debug('------IN rowIndex1 '+rowIndex1 );
        rowIndex1 =rowIndex1-1;
        if(rowIndex1 ==0 && tgtchd.size()==1)
            tgtchd.add(new Target_Child__c(Nature__c='Existing'));
        
            tgtchd.remove(rowIndex1);
            
        //cd = cd1.remove(rowIndex1);
        //deletList.add(cd);
    }
    
    Public pagereference saveTo()
    {
        List<string> tcids = new List<String>();
        Map<String,Decimal> tcmap = new Map<String,Decimal>();
        List<Actuals__c> insertactls = new List<Actuals__c>();
        List<String> chdstrlst = new List<String>();
        map<String,integer> chdmap = new map<string,integer>();
        Boolean dup = false;
        
        try
        {
            system.debug('++++Unique++++'+tgt.OwnerId);
            system.debug('++++Unique++++'+tgt.Territory__c);
            String tgtunique = String.valueOf(tgt.OwnerId).left(15)+':'+String.valueOf(tgt.Territory__c).left(15)+':'+tgt.Product_Group__c+':'+tgt.Month__c+':'+tgt.Year__c;
            system.debug('++++Unique++++'+tgtunique);
            List<Targets__c> tgtdup = [Select id from Targets__c where Unique_ID__c =: tgtunique limit 1];
            
            if(tgtdup.size()>0)
            {
                String htmlText = 'Record already Exist <a href="/'+tgtdup[0].Id+'"><b>View Record</b></a>';
                first = true;
                scnd = false;
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, htmlText));
                return null;
            }
            else
            {
                for(Target_Child__c tc : tgtchd)
                {
                    if(tc.Nature__c == 'Existing' && tc.Customer_Name__c == null && tc.Type__c == 'Trade'){
                        first = false;
                        scnd = true;
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please Select Customer'));
                        return null;
                    }
                    if(tc.Target__c == null){
                        first = false;
                        scnd = true;
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please Enter Target'));
                        return null;
                    }
                }
                //insert tgt;
            }
                
        for(Target_Child__c tc : tgtchd)
        {
            if(tc.Customer_Name__c!=null)
            {
                //chdstrlst.add(String.valueOf(tc.Customer_Name__c).left(10)+':'+tc.Nature__c+':'+tc.Type__c);
                if(!chdmap.containsKey(String.valueOf(tc.Customer_Name__c).left(15)+':'+tc.Nature__c+':'+tc.Type__c))
                    chdmap.put(String.valueOf(tc.Customer_Name__c).left(15)+':'+tc.Nature__c+':'+tc.Type__c,0);
                else
                    dup = true;
            }
            else
            {
                //chdstrlst.add(''+':'+tc.Nature__c+':'+tc.Type__c);
                if(!chdmap.containsKey(''+':'+tc.Nature__c+':'+tc.Type__c))
                    chdmap.put(''+':'+tc.Nature__c+':'+tc.Type__c,0);
                else
                    dup = true;
            }
        }
        //List<Target_Child__c> tgtchddup = [Select id from Target_Child__c where Unique_Code__c IN: chdstr];
        system.debug('++++chdstrlst++++'+chdstrlst.size());
        if(dup)
        {
            first = false;
            scnd = true;
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please Remove Duplicate Rows'));
            return null;
        }
        else
        {
            insert tgt;
            for(Target_Child__c tc : tgtchd)
            {
                tc.Targets__c = tgt.id;
                tc.Month__c = tgt.Month__c;
                tc.Year__c = tgt.Year__c;
                tc.Product_Group__c = tgt.Product_Group__c;
                if(tc.Nature__c == 'New'){
                    tc.Customer_Name__c = null;
                }
                /*tgtchunique = tc.year__c+':'+tc.Month__c+':'+tc.Distribution_Channel__c +':'+ tc.Customer_Code__c +':'+ tc.Sales_Promoter__c +':'+ tc.Product_Group__c +':'+ tc.Targets__c;
                List<Targets__c> tgtchddup = [Select id from Targets__c where Unique_ID__c =: tgtchunique];
                if(tgtchddup.size() > 0){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Record already Exist'));
                    return null;
                }*/
            }
            system.debug('----++----'+tgtchd);
            
            insert tgtchd;
        }
        
        for(Target_Child__c tcd : tgtchd)
        {
            tcids.add(tcd.id);
        }
        
        List<Target_Child__c> tchdlist = [Select Unique_ID__c,Target__c from Target_Child__c where id IN:tcids];
        
        for(Target_Child__c tcu : tchdlist)
            tcmap.put(tcu.Unique_ID__c,tcu.Target__c);
        
        System.debug('--->'+tgtchd);
        
        List<Actuals__c> actls = [Select Id,Actuals__c,Target__c,Customer_Code__c,Customer_Name__c,Distribution_Channel__c,District__c,Division__c,Employee_ID__c,Month__c,Product_Group__c,State__c,Target_Start_Date__c,Territory__c,Type__c,Year__c,Unique_ID__c from Actuals__c where Unique_ID__c IN: tcmap.keySet()];
        
         for(Actuals__c act : actls)
        {
            if(tcmap.containsKey(act.Unique_ID__c))
            {
                act.Target__c = act.Target__c==null ? tcmap.get(act.Unique_ID__c) : (act.Target__c + tcmap.get(act.Unique_ID__c));
                tcmap.remove(act.Unique_ID__c);
            }
        }
        
        for(String str : tcmap.keySet())
        {
            Actuals__c actl = new Actuals__c();
            actl.Sales_Promoter__c = str.split(':')[5];
            actl.Product_Group__c = str.split(':')[4];
            actl.Customer_Code__c = str.split(':')[3];
            actl.Distribution_Channel__c = str.split(':')[2];
            actl.Month__c = str.split(':')[1];
            actl.Year__c = str.split(':')[0];
            actl.Target__c = tcmap.get(str);
            if(str.split(':')[2] == '10')
                actl.Type__c = 'Trade';
            else if(str.split(':')[2] == '20' && str.split(':')[4]=='GGBS')
                actl.Type__c = 'GGBS';
            else if(str.split(':')[2] == '20' && (str.split(':')[4] == 'PSC' || str.split(':')[4]=='CHD'))
                actl.Type__c = 'Non Trade';
            if(str.split(':')[3] != null)
                actl.Nature__c = 'Existing';
            else
                actl.Nature__c = 'New';
            insertactls.add(actl);
        }
        Insert insertactls;
        Update actls;
    
        pagereference pr = new pagereference('/'+tgt.id);
        return pr;
        }
        catch(Exception ex)
        {
            ApexPages.addMessages(ex);
            System.debug('---'+ex.getLinenumber());
        }
        return null;
    }
    
    public pagereference editSave()
    {
        List<string> tcids = new List<String>();
        Map<String,Decimal> tcmap = new Map<String,Decimal>();
        List<Actuals__c> insertactls = new List<Actuals__c>();
        try
        {
            System.debug('-->tcr'+tgtchdrec);
            System.debug('-->tr'+tgtrec);
            for(Target_Child__c tc : tgtchdrec)
            {
                if(tc.Target__c == null){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please Enter Target'));
                    return null;
                }
            }
            
            for(Target_Child__c tc : tgtchdrec)
            {
                if(tc.Targets__c==null)
                    tc.Targets__c = tgtrec.id;
                tc.Month__c = tgtrec.Month__c;
                tc.Year__c = tgtrec.Year__c;
                tc.Product_Group__c = tgtrec.Product_Group__c;
                if(tc.Nature__c == 'New'){
                    tc.Customer_Name__c = null;
                }
            }
            upsert tgtchdrec;
            
            for(Target_Child__c tcd : tgtchdrec)
            {
                tcids.add(tcd.id);
            }
            
            List<Target_Child__c> tchdlist = [Select Unique_ID__c,Target__c from Target_Child__c where id IN:tcids];
            
            for(Target_Child__c tcu : tchdlist)
                tcmap.put(tcu.Unique_ID__c,tcu.Target__c);
            
            System.debug('--->'+tgtchdrec);
            
            List<Actuals__c> actls = [Select Id,Actuals__c,Target__c,Customer_Code__c,Customer_Name__c,Distribution_Channel__c,District__c,Division__c,Employee_ID__c,Month__c,Product_Group__c,State__c,Target_Start_Date__c,Territory__c,Type__c,Year__c,Unique_ID__c from Actuals__c where Unique_ID__c IN: tcmap.keySet()];
            
             for(Actuals__c act : actls)
            {
                if(tcmap.containsKey(act.Unique_ID__c))
                {
                    //act.Target__c = act.Target__c==null ?tcmap.get(act.Unique_ID__c) : (act.Target__c + tcmap.get(act.Unique_ID__c));
                    act.Target__c = tcmap.get(act.Unique_ID__c);
                    tcmap.remove(act.Unique_ID__c);
                }
            }
            System.debug('--->'+actls);
            for(String str : tcmap.keySet())
            {
                Actuals__c actl = new Actuals__c();
                actl.Sales_Promoter__c = str.split(':')[5];
                actl.Product_Group__c = str.split(':')[4];
                actl.Customer_Code__c = str.split(':')[3];
                actl.Distribution_Channel__c = str.split(':')[2];
                actl.Month__c = str.split(':')[1];
                actl.Year__c = str.split(':')[0];
                actl.Target__c = tcmap.get(str);
                if(str.split(':')[2] == '10')
                    actl.Type__c = 'Trade';
                else if(str.split(':')[2] == '20' && str.split(':')[4]=='GGBS')
                    actl.Type__c = 'GGBS';
                else if(str.split(':')[2] == '20' && (str.split(':')[4] == 'PSC' || str.split(':')[4]=='CHD'))
                    actl.Type__c = 'Non Trade';
                if(str.split(':')[3] != null)
                    actl.Nature__c = 'Existing';
                else
                    actl.Nature__c = 'New';
                insertactls.add(actl);
            }
            System.debug('--->'+insertactls);
            Insert insertactls;
            Update actls;
            pagereference pr = new pagereference('/'+tgtrec.id);
            return pr;
        }
        catch(Exception ex)
        {
            ApexPages.addMessages(ex);
            System.debug('---'+ex.getLinenumber());
        }
        return null;
    }
    
    Public pagereference cloning()
    {
        Targets__c  tgt1 = [select OwnerId,Month__c,Year__c,Territory__c,Product_Group__c from Targets__c where id=:tgtid limit 1];
        List<Target_Child__c> tgtchd1 = [select Type__c,Nature__c,Customer_Name__c,Sales_Promoter__c,Territory__c,Target__c,No_of_Dealers__c from Target_Child__c where Targets__c =:tgtid];
        System.debug('*tgt1*'+tgt);
        System.debug('*tgtchd1*'+tgtchd);
        
        tgt.OwnerId = tgt1.OwnerId;
        tgt.Month__c = tgt1.Month__c;
        tgt.Year__c = tgt1.Year__c;
        tgt.Territory__c = tgt1.Territory__c;
        tgt.Product_Group__c = tgt1.Product_Group__c;
        tgtchd.clear();
        for(Target_Child__c tgc : tgtchd1)
        {
            Target_Child__c tgtch = new Target_Child__c();
            tgtch.Type__c = tgc.Type__c;
            tgtch.Nature__c = tgc.Nature__c;
            tgtch.Customer_Name__c = tgc.Customer_Name__c;
            tgtch.Sales_Promoter__c = tgc.Sales_Promoter__c;
            tgtch.Territory__c = tgc.Territory__c;
            tgtch.Target__c = tgc.Target__c;
            tgtch.No_of_Dealers__c = tgc.No_of_Dealers__c;
            tgtchd.add(tgtch);
        }
        System.debug('*tgt*'+tgt);
        System.debug('*tgtchd*'+tgtchd);
        pagereference pr = new pagereference('/apex/New_Targets');
        //pr.setRedirect(true);
        return pr;
    }
    
    Public void submit()
    {
    }
    Public pagereference edit()
    {
        pagereference pr = new pagereference('/apex/Target_Edit?id='+tgtId);
        pr.setRedirect(true);
        return pr;
    }
    
    Public pagereference cancel()
    {
        pagereference pr = new pagereference('/a0x/o');
        return pr;
    }

    Public void myActionInController()
    {
       String lookupacc;
       rindex=integer.valueof(apexpages.currentpage().getparameters().get('lookupindex'));
       system.debug('***'+rindex);
        rindex--;
        //rindex--;
        if(tgtchd[rindex].Customer_Name__c != null && tgt.Territory__c !=null){
            System.debug('---->0'+tgtchd[rindex].Customer_Name__c);
            lookupacc=[select id,Sales_office__c from account where id=:tgtchd[rindex].Customer_Name__c limit 1].Sales_office__c;
            String tercode = [Select id,Territory_Code__c from District__c where id = :tgt.Territory__c].Territory_Code__c;
            //tgtchd[rindex].Territory__c = lookupacc;
            System.debug('---->1'+lookupacc);
            System.debug('---->2'+tercode);
            if(lookupacc != tercode)
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please Enter Territory related Customer only')); 
        }
    }
    Public void myActionInControllerEdit()
    {
       rindex=integer.valueof(apexpages.currentpage().getparameters().get('lookupindex'));
       system.debug('***'+rindex);
        rindex--;
        //rindex--;
        if(tgtchdrec[rindex].Customer_Name__c != null){
            System.debug('---->0'+tgtchdrec[rindex].Customer_Name__c);
            String lookupacc=[select id,Sales_office__c from account where id=:tgtchdrec[rindex].Customer_Name__c limit 1].Sales_office__c;
            String tercode = [Select id,Territory_Code__c from District__c where id = :tgtrec.Territory__c].Territory_Code__c;
            //tgtchdrec[rindex].Territory__c = lookupacc;
            if(lookupacc != tercode)
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please Enter Territory related Customer only')); 
        }
    }
}