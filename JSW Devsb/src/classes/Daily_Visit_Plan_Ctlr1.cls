public with sharing class Daily_Visit_Plan_Ctlr1 {

    public List<String> searchAccountName{get; set;}
    public List<String> districtName{get; set;}
    public List<Visit__c> dailyVistitList {get; set;}
    public List<Visit__c> dailyVsttList {get; set;}
    public List<Day_Plan__c> dayPlans{get;set;}
    public Set<string> planneddays {get; set;}
    public Month_Plan__c PJP {get; set;}
    public String PJPId {get; set;}
    public String AcctName {get; set;}
    public String pickval {get; set;}
    public Boolean errflag {get; set;}
    public String bpval {get; set;}
    public String trnt {get; set;}
    public String trnt1 {get; set;}
    public Boolean accflag {get; set;}
    public Boolean leadflag {get; set;}
    public Boolean actflag {get; set;}
    public Boolean areaflag {get; set;}
    public Boolean subdflag {get; set;}
    public Boolean genflag {get; set;}
    public Boolean prjflag {get; set;}
    public Boolean cnfflag {get; set;}
    public Boolean wrhflag {get; set;}
    public Boolean infflag {get; set;}
    public Boolean accflag1 {get; set;}
    public Boolean leadflag1 {get; set;}
    public Boolean subdflag1 {get; set;} 
    public Boolean infflag1 {get; set;}
    public Boolean evtflag1 {get; set;}
    public Boolean acct {get; set;}
    public String queryStr{get;set;}
    public List<Account> acctList{get;set;}
    public List<Lead> leadList{get;set;}
    public List<District__c> areaList{get;set;}
    public List<Event__c> evntlist{get;set;}
    public List<Business_Partner__c> bplist {get; set;}
    public List<Project_Site__c> pjlist {get; set;}
    public List<Influencer__c> inlist {get; set;}
    public List<String> genlist {get; set;}
    public Boolean searchRes{get;set;}
    public Integer day {get; set;}
    public Integer month {get; set;}
    public Integer year {get; set;}
    public Boolean flag {get; set;}
    public Integer totalVisits {get; set;}
    public Integer VisitedCount {get; set;}
    public Integer DayCount {get;set;}
    public boolean currentuser{get;set;}
    public boolean manageruser{get;set;}
    public boolean newvisit {get; set;}
    public Visit__c vst {get; set;}
    public String vstype {get; set;}
    public Lead flead {get; set;}
    public Account facc {get; set;}
    public Influencer__c finf {get; set;}
    public Event__c fevnt {get; set;}
    public String dist {get; set;}
    public String acctype {get; set;}
    public Date cdate {get; set;}
    public List<User> sublist {get; set;}
    public List<String> subusers {get; set;}
    public String subuser {get; set;}
    public Boolean hasusers {get; set;}
    public Boolean tmptype {get; set;}
    public Integer month1 {get;set;}
    public String year1 {get;set;}
    public User currid {get;set;}
    public String vstobj {get; set;}
    
    public Daily_Visit_Plan_Ctlr1(ApexPages.StandardController controller){
        newvisit = false;
        accflag1 = false;
        leadflag1 = false;
        subdflag1 = false;
        hasusers = false;
        tmptype = false;
        facc = new Account();
        flead = new Lead();
        finf = new Influencer__c();
        fevnt = new Event__c();
        subusers = new List<String>();
        planneddays = new set<string>();
        
        Schema.DescribeSObjectResult VisitDest = Visit__c.sObjectType.getDescribe();
        vstobj = VisitDest.getKeyPrefix();
        
        PJPId = ApexPages.currentPage().getParameters().get('id');
        PJP = [select id,name,User__c,Start_Date__c,End_Date__c,Status__c,RecordType.Name from Month_Plan__c where id =: PJPId];
        
        id managerid = [select id,ManagerId from user where id =: PJP.User__c].ManagerId;
        User currid = [select id,name,UserRole.Name,UserRoleId from user where id =: UserInfo.getUserId()];
        User pjpusrid = [select id,ManagerId,UserRoleId from user where id =: PJP.User__c];
        sublist = new List<User>();
        String rolename = '';
        if(currid.UserRole.Name.contains('ASM')){
            rolename = '%'+currid.UserRole.Name.split(' ')[0]+'%';
            sublist = [select id,name,UserRoleId from User where UserRole.Name like :rolename];
        } else if(currid.UserRole.Name.contains('Technical Services Officer') || currid.UserRole.Name.contains('TSO')){
            rolename = '%'+currid.UserRole.Name.split(' ')[0]+'%';
            sublist = [select id,name,UserRoleId from User where UserRole.Name like :rolename and UserRole.Name like '%Sales Officer%'];
        }
        
        if(sublist.size() > 0){
            for(User usr : sublist){
                if(usr.UserRoleId != pjpusrid.UserRoleId)
                    subusers.add(usr.Name);
            }
        }
        
        if(subusers.size() > 0){
            hasusers = true;
        }
        
        day = PJP.Start_Date__c.day();
        month = PJP.Start_Date__c.month();
        year = PJP.Start_Date__c.year();
        cdate = PJP.Start_Date__c;
        
        if(PJP.RecordType.Name == 'Template'){
        dailyVsttList = [select id,name,General_Visit_Type__c,Visit_Completed__c,Week_Plan_Submitted__c,Attendees__c,Month_Plan__c,Start__c,Region__c, Type__c, Event__r.Event_id__c, Joined__c,Visited__c,Day_Plan__c,Planned_Date__c,Lead__c,Account__c,Territory__c,
        Event__c,Past__c,Name__c,Planned__c,General_Visit__c,Business_Partner__c,Project_Site__c,Influencer__c,Visit_Checked_In__c from Visit__c where Month_Plan__c =: PJPId];
        tmptype = true;
        } else {
        dailyVsttList = [select id,name,Visit_Checked_In__c,General_Visit_Type__c,Visit_Completed__c,Week_Plan_Submitted__c,Month_Plan__c,Start__c,Region__c, Type__c, Event__r.Event_id__c, Joined__c,Visited__c,Day_Plan__c,Planned_Date__c,Lead__c,Account__c,Territory__c,
        Event__c,Past__c,Name__c,Planned__c,General_Visit__c,Business_Partner__c,Project_Site__c,Influencer__c,Attendees__c from Visit__c where Day_Plan__r.Month_Plan__c =: PJPId];
        }
        
        for(Visit__c vt : dailyVsttList){
            planneddays.add(vt.Day_Plan__c);
        }
        
        if(managerid == UserInfo.getUserId())
            manageruser=true;
        else
            manageruser=false;
        if(PJP.User__c == UserInfo.getUserId())
            currentuser=true;
        else
            currentuser=false;
        
        flag = dailyVsttList.isEmpty();
        totalVisits = 0;
        VisitedCount = 0;
        for(Visit__c vst : dailyVsttList){
            if(vst.Visit_Checked_In__c == true)
            VisitedCount++;
            if(vst.General_Visit__c == false)
            totalVisits++;
        }
      
        DayCount = planneddays.size();
        districtName = new List<String>();
        List<District__c> dstlist = [select id,name from District__c];
        for(District__c dst : dstlist){
            districtName.add(dst.Name);
        }
    }
    
    public pageReference pjptab(){
        Schema.DescribeSObjectResult PJPDest = Month_Plan__c.sObjectType.getDescribe();
        pageReference pref = new pageReference('/'+PJPDest.getKeyPrefix()+'/o');
        pref.setRedirect(true);
        return pref;
    }
    
    public pageReference summarytab(){
        pageReference pref = new pageReference('https://jswcements--jswuat.cs6.my.salesforce.com/00O/o');
        pref.setRedirect(true);
        return pref;
    }
    
    public pageReference submitforapproval(){
        pageReference pref = new pageReference('/apex/ApprovalSubmission?id='+PJPId);
        pref.setRedirect(true);
        return pref;
    }
    
    public void search(){
        if(pickval == 'account'){
            accflag = true;
            leadflag = false;
            actflag = false;
            areaflag = false;
            subdflag = false;
            genflag = false;
            prjflag = false;
            cnfflag = false;
            wrhflag = false;
            infflag = false;
            
            queryStr = 'select Id, Name, BillingCity,Sales_Office_text__c, Account_Type__c, RecordType.Name, Birthdate__c from Account where RecordType.Name != \'Depot\'';
            if(subuser != '' && subuser != null){
                queryStr = queryStr+' and Owner.Name = \''+subuser+'\'';
            }
            if(AcctName != ''){
                queryStr = queryStr+' and Name like \'%'+AcctName+'%\'';
            }
            if(dist != ''){
                queryStr = queryStr+' and Sales_Office_text__c like \'%'+dist+'%\'';
            }
            if(trnt != null){
                if(trnt == 'tr'){
                    queryStr = queryStr+' and RecordType.Name = \'Trade\'';
                }
                else if(trnt == 'nt'){
                    queryStr = queryStr+' and RecordType.Name = \'Non-Trade\'';
                    /*if(trnt1 != null){
                        if(trnt1 == 'nontrade')
                            queryStr = queryStr+' and Account_Type__c = \'Non Trade Customer\'';
                        else if(trnt1 == 'institute')
                            queryStr = queryStr+' and Account_Type__c = \'Institutional\'';
                    }*/
                }
            }
            
            if(subuser != '' && subuser != null){
                queryStr = queryStr+' and Owner.Name = \''+subuser+'\'';
            }
            
            queryStr = queryStr+' LIMIT 100';
            acctList = Database.query(queryStr);
            searchRes = true;
            if(acctList.size() == 0){
                searchRes = false;
            }
        } else if(pickval == 'lead'){
            accflag = false;
            leadflag = true;
            actflag = false;
            areaflag = false;
            subdflag = false;
            genflag = false;
            prjflag = false;
            cnfflag = false;
            wrhflag = false;
            infflag = false;
            
            queryStr = 'select Id, Name, Type__c, Category__c, District__r.Name, City, BirthDate__c from Lead where isConverted = false';
            if(subuser != '' && subuser != null){
                queryStr = queryStr+' and Owner.Name = \''+subuser+'\'';
            }
            if(AcctName != ''){
                queryStr = queryStr+' and Name like \'%'+AcctName+'%\'';
            }
            if(dist != ''){
                queryStr = queryStr+' and District__r.Name like \'%'+dist+'%\'';
            }
            if(flead.Type__c != null){
                queryStr = queryStr+' and Type__c = \''+flead.Type__c+'\'';
            }
            queryStr = queryStr+' LIMIT 100';
            system.debug('****** '+queryStr);
            leadList = Database.query(queryStr);
            searchRes = true;
            if(leadList.size() == 0){
                searchRes = false;
            }
        } else if(pickval == 'territory'){
            accflag = false;
            leadflag = false;
            actflag = false;
            areaflag = true;
            subdflag = false;
            genflag = false;
            prjflag = false;
            cnfflag = false;
            wrhflag = false;
            infflag = false;
            
            queryStr = 'select Id, Name from District__c';
            
            if(AcctName != ''){
                queryStr = queryStr+' where Name like \'%'+AcctName+'%\'';
            }
            
            areaList = Database.query(queryStr);
            searchRes = true;
            if(areaList.size() == 0){
                searchRes = false;
            }
            
        } else if(pickval == 'event'){
            accflag = false;
            leadflag = false;
            actflag = true;
            areaflag = false;
            subdflag = false;
            genflag = false;
            prjflag = false;
            cnfflag = false;
            wrhflag = false;
            infflag = false;
            
            queryStr = 'select Id,Name,Type_of_Meet__c,Event__c,District__r.Name,Name_of_Counter__c from Event__c where CALENDAR_MONTH(Event__c) =: month and CALENDAR_YEAR(Event__c) =: year';
            
            if(dist != ''){
                queryStr = queryStr+' and District__r.Name like \'%'+dist+'%\'';
            }
            if(fevnt.Type_of_Meet__c != null){
                queryStr = queryStr+' and Type_of_Meet__c = \''+fevnt.Type_of_Meet__c+'\'';
            }
            evntlist = Database.query(queryStr);
            searchRes = true;
            if(evntlist.size() == 0){
                searchRes = false;
            }
        } else if(pickval == 'bpartner'){
            accflag = false;
            leadflag = false;
            actflag = false;
            areaflag = false;
            subdflag = true;
            genflag = false;
            prjflag = false;
            cnfflag = false;
            wrhflag = false;
            infflag = false;
            
            queryStr = 'select Id,Name, District__r.Name,RecordType.Name from Business_Partner__c where name != null';
            if(bpval == 'subdealer'){
                queryStr = queryStr+' and RecordType.Name = \'Sub-Dealers\'';
            } else if(bpval == 'mmc'){
                queryStr = queryStr+' and RecordType.Name = \'MMC\'';
            } else if(bpval == 'salesprom'){
                queryStr = queryStr+' and RecordType.Name = \'Sales Promoters\'';
            }
            if(subuser != '' && subuser != null){
                queryStr = queryStr+' and Owner.Name = \''+subuser+'\'';
            }
            if(AcctName != ''){
                queryStr = queryStr+' and Name like \'%'+AcctName+'%\'';
            }
            if(dist != ''){
                queryStr = queryStr+' and District__r.Name like \'%'+dist+'%\'';
            }
            queryStr = queryStr+' LIMIT 100';
            bplist = Database.query(queryStr);
            searchRes = true;
            if(bplist.size() == 0){
                searchRes = false;
            }
        } else if(pickval == 'project'){
            accflag = false;
            leadflag = false;
            actflag = false;
            areaflag = false;
            subdflag = false;
            genflag = false;
            prjflag = true;
            cnfflag = false;
            wrhflag = false;
            infflag = false;
            
            queryStr = 'select Id,Name from Project_Site__c where name != null';
            if(subuser != '' && subuser != null){
                queryStr = queryStr+' and Owner.Name = \''+subuser+'\'';
            }
            if(AcctName != ''){
                queryStr = queryStr+' and Name like \'%'+AcctName+'%\'';
            }
            System.debug('$$$'+queryStr);
            pjlist = Database.query(queryStr);
            searchRes = true;
            if(pjlist.size() == 0){
                searchRes = false;
            }
        } else if(pickval == 'depot'){
            accflag = false;
            leadflag = false;
            actflag = false;
            areaflag = false;
            subdflag = false;
            genflag = false;
            prjflag = false;
            cnfflag = true;
            wrhflag = false;
            infflag = false;
            
            queryStr = 'select Id,Name,Account_Category__c,Sales_Office_text__c from Account where RecordType.Name = \'Depot\'';
            if(subuser != '' && subuser != null){
                queryStr = queryStr+' and Owner.Name = \''+subuser+'\'';
            }
            if(AcctName != ''){
                queryStr = queryStr+' and Name like \'%'+AcctName+'%\'';
            }
            if(dist != ''){
                queryStr = queryStr+' and Sales_Office_text__c like \'%'+dist+'%\'';
            }
            queryStr = queryStr+' LIMIT 100';
            acctList = Database.query(queryStr);
            searchRes = true;
            if(acctList.size() == 0){
                searchRes = false;
            }
        } else if(pickval == 'influencer'){
            accflag = false;
            leadflag = false;
            actflag = false;
            areaflag = false;
            subdflag = false;
            genflag = false;
            prjflag = false;
            cnfflag = false;
            wrhflag = false;
            infflag = true;
            
            queryStr = 'select Id,Name,Type__c,District__r.Name from Influencer__c where name != null';
            if(subuser != '' && subuser != null){
                queryStr = queryStr+' and Owner.Name = \''+subuser+'\'';
            }
            if(finf.Type__c != null){
                queryStr = queryStr+' and Type__c = \''+finf.Type__c+'\'';
            }
            if(AcctName != ''){
                queryStr = queryStr+' and Name like \'%'+AcctName+'%\'';
            }
            queryStr = queryStr+' LIMIT 100';
            System.debug('!!!!'+queryStr);
            inlist = Database.query(queryStr);
            searchRes = true;
            if(inlist.size() == 0){
                searchRes = false;
            }
        } else if(pickval == 'general'){
            accflag = false;
            leadflag = false;
            actflag = false;
            areaflag = false;
            subdflag = false;
            genflag = true;
            prjflag = false;
            cnfflag = false;
            wrhflag = false;
            infflag = false;
        }
    }
    
    @RemoteAction
    public static String SaveCal(List<String> objlistdel, List<String> objlist, List<String> objlistupd, String pjpid){
        Map<String,Integer> weekmap = new Map<String,Integer>();
        Map<Date,Id> dpmap = new Map<Date,Id>();
        Map<Id,Integer> dpsize = new Map<Id,Integer>();
        List<Event> evntlist = new List<Event>();
        List<Id> dpidlist = new List<Id>();
        Set<Id> dpids = new Set<Id>();
        List<Day_Plan__c> dplist = [select id,name,date__c from Day_Plan__c where Week_Plan__r.Month_Plan__c =: pjpid];
        
        Schema.DescribeSObjectResult LeadDest = Lead.sObjectType.getDescribe();
        Schema.DescribeSObjectResult AccDest = Account.sObjectType.getDescribe();
        Schema.DescribeSObjectResult EvnDest = Event__c.sObjectType.getDescribe();
        Schema.DescribeSObjectResult AreaDest = District__c.sObjectType.getDescribe();
        Schema.DescribeSObjectResult BPartDest = Business_Partner__c.sObjectType.getDescribe();
        Schema.DescribeSObjectResult PSiteDest = Project_Site__c.sObjectType.getDescribe();
        Schema.DescribeSObjectResult InfluDest = Influencer__c.sObjectType.getDescribe();
        
        for(Day_Plan__c dp : dplist){
            dpmap.put(dp.Date__c,dp.id);
        }
        
        weekmap.put('Jan',1);
        weekmap.put('Feb',2);
        weekmap.put('Mar',3);
        weekmap.put('Apr',4);
        weekmap.put('May',5);
        weekmap.put('Jun',6);
        weekmap.put('Jul',7);
        weekmap.put('Aug',8);
        weekmap.put('Sep',9);
        weekmap.put('Oct',10);
        weekmap.put('Nov',11);
        weekmap.put('Dec',12);
        
        String evntname;
        String dte;
        Date day;
        
        List<Visit__c> visitcount = new List<Visit__c>();
        List<Task> tsklist = new List<Task>();
        List<Visit__c> visitlist = new List<Visit__c>();
        List<Visit__c> visitlistdel = new List<Visit__c>();
        Set<Id> delids = new Set<Id>();
        Map<Id,Date> updmap = new Map<Id,Date>();
        
        System.debug('@@@@'+objlistupd);
        for(String s : objlistupd){
            evntname = s.split('@')[0];
            dte = s.split('@')[1];
            day = date.parse(dte.split(' ')[2]+'/'+weekmap.get(dte.split(' ')[1])+'/'+dte.split(' ')[3]);
            delids.add(evntname);
            updmap.put(evntname,day);
        }
        
        System.debug('@@@@'+updmap);
        visitlistdel = [select id,name from Visit__c where id in: delids];
        for(Visit__c vst : visitlistdel){
            vst.Planned_Date__c = updmap.get(vst.id);
        }
        System.debug('@@@@'+visitlistdel);
        update visitlistdel;
        
        delids = new Set<Id>();
        for(String s : objlistdel){
            delids.add(s);
        }
        
        visitlistdel = [select id,name from Visit__c where id in: delids];
        delete visitlistdel;
        
        for(String s : objlist){
            evntname = s.split('@')[0];
            dte = s.split('@')[1];
            day = date.parse(dte.split(' ')[2]+'/'+weekmap.get(dte.split(' ')[1])+'/'+dte.split(' ')[3]);
            
            Visit__c vst = new Visit__c();
            
            if(String.valueOf(evntname).startswith(LeadDest.getKeyPrefix())){
                vst.Lead__c = evntname;
            } else if(String.valueOf(evntname).startswith(AccDest.getKeyPrefix())){
                vst.Account__c = evntname;
            } else if(String.valueOf(evntname).startswith(AreaDest.getKeyPrefix())){
                vst.Territory__c = evntname;
            } else if(String.valueOf(evntname).startswith(EvnDest.getKeyPrefix())){
                vst.Event__c = evntname;
            } else if(String.valueOf(evntname).startswith(BPartDest.getKeyPrefix())){
                vst.Business_Partner__c = evntname;
            } else if(String.valueOf(evntname).startswith(PSiteDest.getKeyPrefix())){
                vst.Project_Site__c = evntname;
            } else if(String.valueOf(evntname).startswith(InfluDest.getKeyPrefix())){
                vst.Influencer__c = evntname;
            } else if(String.valueOf(evntname).contains('Holiday')){
                vst.General_Visit__c = true;
                vst.General_Visit_Type__c = 'Holiday';
            } else if(String.valueOf(evntname).contains('Leave')){
                vst.General_Visit__c = true;
                vst.General_Visit_Type__c = 'Leave';
            } else if(String.valueOf(evntname).contains('Weekly')){
                vst.General_Visit__c = true;
                vst.General_Visit_Type__c = 'Weekly Review';
            } else if(String.valueOf(evntname).contains('General')){
                vst.General_Visit__c = true;
                vst.General_Visit_Type__c = 'General Visit';
            } else if(String.valueOf(evntname).contains('Cold')){
                vst.General_Visit__c = true;
                vst.General_Visit_Type__c = 'Cold Call';
            } 
            
            vst.Name = UserInfo.getName() + ' ' + dte.split(' ')[1] + ' ' +dte.split(' ')[2] + ' ' +dte.split(' ')[3];
            vst.Planned_Date__c = day;
            vst.Start__c = DateTime.newInstance(vst.Planned_Date__c.year(),vst.Planned_Date__c.month(),vst.Planned_Date__c.day(),9,0,0);
            vst.End__c = DateTime.newInstance(vst.Planned_Date__c.year(),vst.Planned_Date__c.month(),vst.Planned_Date__c.day(),10,0,0);
            vst.Planned__c = true;
            if(dpmap.containsKey(day)){
                vst.Day_Plan__c = dpmap.get(day);
            }
            visitlist.add(vst);
            dpids.add(vst.Day_Plan__c);
        }
        insert visitlist;
        /*for(Visit__c vst : visitlist){
            Event evnt = new Event();
            evnt.StartDateTime = vst.Start__c;
            evnt.EndDateTime = vst.End__c;
            evnt.Subject = vst.Name__c;
            evnt.WhatId = vst.id;
            evntlist.add(evnt);
        }
        insert evntlist;
        dplist = [select id,name from Day_Plan__c where id in: dpids];
        Integer i = 0;
        Integer j = 0;
        
        for(Day_Plan__c dp : dplist){
            j = 9;
            if(dpsize.get(dp.id) != null)
            i = dpsize.get(dp.id);
            else
            i = 0;
            for(Visit__c vst : visitlist){
                if(vst.Day_Plan__c == dp.id){
                     vst.Start__c = DateTime.newInstance(vst.Planned_Date__c.year(),vst.Planned_Date__c.month(),vst.Planned_Date__c.day(),i+j,0,0);
                     vst.End__c = DateTime.newInstance(vst.Planned_Date__c.year(),vst.Planned_Date__c.month(),vst.Planned_Date__c.day(),i+j+1,0,0);
                     j = j + 2;
                }
            }
        }
        update visitlist;*/
        
        return PJPId;
    }
    
    public pagereference submitmonth(){
        if(PJP.Status__c == 'New Request' || PJP.Status__c == 'Pending' || PJP.Status__c == 'Rejected'){
            //if(date.daysInMonth(year, month) == DayCount){
                try{
                    Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                    req1.setComments('Submitting request for approval');
                    req1.setObjectId(PJPId);
                    req1.setSubmitterId(userInfo.getUserId());
                    Approval.ProcessResult result = Approval.process(req1);
                }catch(Exception ex){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please select your approver as Manager'));
                }
            /*} else {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please select all days for approval submission'));
            }*/ 
        } else {
           ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Plan already Submitted for Approval')); 
        }
        PageReference pref = new PageReference('/'+pjpid);
        pref.setRedirect(true);
        return pref;
    }
    
    @RemoteAction
    public static String dayPlanUrl(String dtstring, String pjp){
        String dt = dtstring.split('T')[0];
        Date actdt = Date.parse(dt.split('-')[2]+'/'+dt.split('-')[1]+'/'+dt.split('-')[0]);
        Day_Plan__c dp = [select id,name from Day_Plan__c where Date__c =: actdt and Month_Plan__c =: pjp];
        return String.valueOf(dp.id);
    }
    
    public pagereference join()
    {
        pageReference pref = new pageReference('/apex/DailyVisitPlan?id='+PJP.id);
        pref.setRedirect(true);
        return pref;
    }
    
    public pageReference cloning(){
        RecordType rtype = [select id,name from RecordType where sObjectType = 'Month_Plan__c' and name = 'Template'];
        
        List<Visit__c> newvstlist = new List<Visit__c>();
        Month_Plan__c mnp = new Month_Plan__c();
        mnp.Name = UserInfo.getFirstName()!=null?UserInfo.getFirstName()+' ':'';
        mnp.Name = mnp.Name + UserInfo.getLastName() + ' Template';
        mnp.User__c = UserInfo.getUserId();
        mnp.Start_Date__c = Date.newinstance(2017,1,1);
        mnp.End_Date__c = Date.newinstance(2017,1,31);
        mnp.RecordTypeId = rtype.id;
        
        try{
        insert mnp;
        } catch(Exception ex){
            String qry = 'select id,name from Month_Plan__c where name like \'%'+mnp.Name+'%\'';
            List<Month_Plan__c> mnplist = Database.query(qry);
            mnp.Name = mnp.Name + ' ' + String.valueOf(mnplist.size());
            insert mnp;
        }
        
        for(Visit__c vstpln : dailyVsttList){
            Visit__c vst = new Visit__c();
            vst.Name = 'Template Visit';
            vst.Planned__c = true;
            vst.Planned_Date__c = Date.newInstance(2017,1,vstpln.Planned_Date__c.day());
            vst.Start__c = Date.newInstance(2017,1,vstpln.Planned_Date__c.day());
            vst.End__c = Date.newInstance(2017,1,vstpln.Planned_Date__c.day());
            vst.Month_Plan__c = mnp.id;
            if(vstpln.General_Visit__c == true){
                vst.General_Visit__c = true;
                vst.General_Visit_Type__c = vstpln.General_Visit_Type__c;
            }
            if(vstpln.Account__c != null)
            vst.Account__c = vstpln.Account__c;
            else if(vstpln.Business_Partner__c != null)
            vst.Business_Partner__c = vstpln.Business_Partner__c;
            else if(vstpln.Event__c != null)
            vst.Event__c = vstpln.Event__c;
            else if(vstpln.Influencer__c != null)
            vst.Influencer__c = vstpln.Influencer__c;
            else if(vstpln.Lead__c != null)
            vst.Lead__c = vstpln.Lead__c;
            else if(vstpln.Project_Site__c != null)
            vst.Project_Site__c = vstpln.Project_Site__c;
            else if(vstpln.Territory__c != null)
            vst.Territory__c = vstpln.Territory__c;
            newvstlist.add(vst);
        }
        insert newvstlist;
        
        PageReference pref = new PageReference('/'+mnp.id);
        pref.setRedirect(true);
        return pref;
    }
    
    @RemoteAction
    public static String managerjoin(List<String> objlistdel,String pjpid){
        System.debug('Join Method');
        
        Map<Integer,String> MonthMap2 = new Map<Integer,String>();
        MonthMap2.put(1,'January');
        MonthMap2.put(2,'February');
        MonthMap2.put(3,'March');
        MonthMap2.put(4,'April');
        MonthMap2.put(5,'May');
        MonthMap2.put(6,'June');
        MonthMap2.put(7,'July');
        MonthMap2.put(8,'August');
        MonthMap2.put(9,'September');
        MonthMap2.put(10,'October');
        MonthMap2.put(11,'November');
        MonthMap2.put(12,'December');
        
        List<Week_Plan__c> weeknames = new List<Week_Plan__c>();
        List<Day_Plan__c> dpnames = new List<Day_Plan__c>();
        List<Task> tsklist = new List<Task>();
        List<Visit__c> visitlist = new List<Visit__c>();
        List<Visit__c> visitlistdel = new List<Visit__c>();
        Map<Date,Id> dpmap = new Map<Date,Id>();
        Set<Id> delids = new Set<Id>();
        
        for(String s : objlistdel){
            delids.add(s);
        }
        
        visitlistdel = [select id,name,Lead__c,Account__c ,Territory__c ,Event__c,Business_Partner__c,Project_Site__c,Influencer__c,General_Visit__c,
                        General_Visit_Type__c,Planned_Date__c,Start__c,End__c,Planned__c,Attendees__c from Visit__c where id in: delids];
        Month_Plan__c currpjp = [select id, name, Start_Date__c from Month_Plan__c where id =: pjpid];
        Integer ij = 0; 
        while (ij < visitlistdel.size()){
            Visit__c vst = visitlistdel.get(ij);
            if(vst.Attendees__c == null){
                vst.Attendees__c = UserInfo.getName();
                ij++;
            } else if(!vst.Attendees__c.contains(UserInfo.getName())){
                vst.Attendees__c = vst.Attendees__c + ', ' + UserInfo.getName();
                ij++;
            } else {
                visitlistdel.remove(ij);
            }
        }
        
        Integer month = currpjp.Start_Date__c.month();
        Integer year = currpjp.Start_Date__c.year();
        
        System.debug('###'+month+'###'+year);
        Month_Plan__c mnp = new Month_Plan__c();
        mnp.Name = UserInfo.getFirstName()!=null?UserInfo.getFirstName()+' ':'';
        mnp.Name = mnp.Name + UserInfo.getLastName() + ' ' + MonthMap2.get(month) + ' ' + year;
        mnp.User__c = UserInfo.getUserId();
        mnp.Year__c = String.valueOf(year);
        mnp.Status__c = 'New Request';
        mnp.Start_Date__c = Date.newinstance(year,month,1);
        mnp.End_Date__c = Date.newinstance(year,month,Date.daysinmonth(year,month));
        
        List<Month_Plan__c> mnplist = [select id,name from Month_Plan__c where name=: mnp.Name];
        if(mnplist.size()>0){
            mnp = mnplist.get(0);
            dpnames = [select id,name,Date__c from Day_Plan__c where Month_Plan__c =: mnp.id];
        } else {
        
            insert mnp;
            
            System.debug('@@@Month Plan'+mnp);
            DateTime strdate = mnp.Start_Date__c;
            DateTime enddate = mnp.End_Date__c;
            DateTime enddt = strdate;
            
            do{
                Integer diff = enddt.date().daysBetween(enddate.date());
                if(diff > 0){
                    System.debug('!!!Inside if');
                    if(strdate.format('EEEE') == 'Sunday'){
                        enddt = strdate.date() + 6;
                    } else if(strdate.format('EEEE') == 'Monday'){
                        enddt = strdate.date() + 5;
                    } else if(strdate.format('EEEE') == 'Tuesday'){
                        enddt = strdate.date() + 4;
                    } else if(strdate.format('EEEE') == 'Wednesday'){
                        enddt = strdate.date() + 3;
                    } else if(strdate.format('EEEE') == 'Thursday'){
                        enddt = strdate.date() + 2;
                    } else if(strdate.format('EEEE') == 'Friday'){
                        enddt = strdate.date() + 1;
                    } else if(strdate.format('EEEE') == 'Saturday'){
                        enddt = strdate.date();
                    }
                }else{
                    enddt = enddate;
                }
                
                Week_Plan__c wp = new Week_Plan__c();
                wp.Name = strdate.day() + ' ' + strdate.format('MMM') + ' - ' + enddt.day() + ' ' + enddt.format('MMM');
                wp.User__c = UserInfo.getUserId();
                wp.Month_Plan__c = mnp.id;
                wp.Start_Date__c = strdate;
                wp.End_Date__c = enddt;
                wp.Status__c = 'New Request';
                wp.Size__c = strdate.date().daysBetween(enddt.date())+1;
                weeknames.add(wp);
                
                strdate = enddt + 1;
                enddt = strdate + 6;
                
            }while(strdate <= enddate);
            insert weeknames;
            
            for(Week_Plan__c wp : weeknames){
                for(Integer i=0; i<Integer.valueOf(wp.Size__c); i++){
                    Day_Plan__c dp = new Day_Plan__c();
                    dp.Name = wp.Start_Date__c.day()+i + ' ' + MonthMap2.get(wp.Start_Date__c.month()) + ' ' + wp.Start_Date__c.year();
                    dp.Month_Plan__c = mnp.id;
                    dp.Week_Plan__c = wp.id;
                    dp.User__c = UserInfo.getUserId();
                    dp.Date__c = wp.Start_Date__c.date()+i;
                    dpnames.add(dp);
                }
            }
            insert dpnames;
        }
        for(Day_Plan__c dp : dpnames){
            dpmap.put(dp.Date__c,dp.id);
        }
        List<Visit__c> dpvisits = [select id,name from Visit__c where Day_Plan__c in: dpmap.values()];
        for(Visit__c vstjn : visitlistdel){
            Visit__c vt = new Visit__c();
            vt.Name = UserInfo.getName() + ' ' + MonthMap2.get(vstjn.Planned_Date__c.month()).left(3) + ' ' + String.valueOf(vstjn.Planned_Date__c.day()) + ' ' + String.valueOf(vstjn.Planned_Date__c.year());
            vt.Lead__c = vstjn.Lead__c;
            vt.Account__c = vstjn.Account__c;
            vt.Territory__c = vstjn.Territory__c;
            vt.Event__c = vstjn.Event__c;
            vt.Business_Partner__c = vstjn.Business_Partner__c;
            vt.Project_Site__c = vstjn.Project_Site__c;
            vt.Influencer__c = vstjn.Influencer__c;
            vt.General_Visit__c = vstjn.General_Visit__c;
            vt.Planned_Date__c = vstjn.Planned_Date__c;
            vt.Day_Plan__c = dpmap.get(vt.Planned_Date__c);
            vt.ownerId = UserInfo.getUserId();
            vt.Start__c = vstjn.Start__c;
            vt.End__c = vstjn.End__c;
            vt.General_Visit_Type__c = vstjn.General_Visit_Type__c;
            vt.Planned__c = vstjn.Planned__c;
            vt.Joined__c = true;
            vt.Parent_Visit__c = vstjn.id;
            visitlist.add(vt);
        }
        
        insert visitlist;
        update visitlistdel;
        return mnp.id;
    }
    
    public void filterSearch(){
        AcctName = '';
        dist = '';
        System.debug('@@@Inside filtersearch');
        if(pickval == 'account'){
            accflag1 = true;
            leadflag1 = false;
            subdflag1 = false;
            infflag1 = false;
            evtflag1 = false;
            acctList = new List<Account>();
            searchAccountName = new List<String>();
            acctList = [select Id, Name, BillingCity from Account where RecordType.Name != 'Depot' Limit 200];
        
            if(acctList.size() > 0){
                for(Account acc:acctList){
                    searchAccountName.add(acc.name);
                }
                searchRes = false;
            }
        } else if(pickval == 'lead'){
            leadflag1 = true;
            accflag1 = false;
            subdflag1 = false;
            infflag1 = false;
            evtflag1 = false;
            
            searchAccountName = new List<String>();
            leadList = [select Id, Name, City from Lead where isConverted = false Limit 200];
            
            if(leadList.size() > 0){
                for(Lead acc:leadList){
                    searchAccountName.add(acc.name);
                }  
            }
            System.debug('@@@'+searchAccountName);
        } else if(pickval == 'territory'){
            leadflag1 = false;
            accflag1 = false;
            subdflag1 = false;
            infflag1 = false;
            evtflag1 = false;
            areaList = [select Id, Name from District__c Limit 200];
            searchAccountName=new List<String>();
          
            if(areaList.size() > 0){
                for(District__c acc:areaList ){
                    searchAccountName.add(acc.name);
                 }
            }
            
        } else if(pickval == 'event'){
          leadflag1 = false;
          accflag1 = false;
          subdflag1 = false;
          infflag1 = false;
          evtflag1 = true;
          evntlist = [select Id,Name from Event__c Limit 200];
          searchAccountName = new List<String>();
          
            if(evntlist.size()> 0){
                for(Event__c acc:evntlist ){
                    searchAccountName.add(acc.name);
                }
            }
        } else if(pickval == 'bpartner'){
            leadflag1 = false;
            accflag1 = false;
            subdflag1 = true;
            infflag1 = false;
            evtflag1 = false;
            bplist = new List<Business_Partner__c >();
            bplist = [select Id,Name from Business_Partner__c Limit 200];
            searchAccountName=new List<String>();
            if(bplist.size() >0){
                for(Business_Partner__c acc:bplist){
                    searchAccountName.add(acc.name);
                }
            }
        } else if(pickval == 'project'){
            leadflag1 = false;
            accflag1 = false;
            subdflag1 = false;
            infflag1 = false;
            evtflag1 = false;
            pjlist = new List<Project_Site__c>();
            searchAccountName=new List<String>();
            pjlist = [select Id,Name from Project_Site__c Limit 200];
          
            if(pjlist.size() >0){
               for(Project_Site__c acc:pjlist){
                   searchAccountName.add(acc.name);
                }
            }
        } else if(pickval == 'depot'){
            leadflag1 = false;
            accflag1 = false;
            subdflag1 = false;
            infflag1 = false;
            evtflag1 = false;
            acctList = new List<Account>();
            searchAccountName = new List<String>();
            acctList = [select Id,Name from Account where RecordType.Name = 'Depot' Limit 200];
           
            if(acctList.size()> 0){
                for(Account acc:acctList ){
                    searchAccountName.add(acc.name);
                }
            }
        } else if(pickval == 'influencer'){
            leadflag1 = false;
            accflag1 = false;
            subdflag1 = false;
            infflag1 = true;
            evtflag1 = false;
            searchAccountName = new List<String>();
            inlist = [select Id,Name from Influencer__c Limit 200];
            
            if(inlist.size() > 0){
                for(Influencer__c acc:inlist){
                    searchAccountName.add(acc.name);
                } 
            }
        } else if(pickval == 'general'){
            leadflag1 = false;
            accflag1 = false;
            subdflag1 = false;
            infflag1 = false;
            evtflag1 = false;
            searchAccountName = new List<String>();
        }
    }
    
    public PageReference newVisit(){
        newvisit = true;
        vst = new Visit__c();
        PageReference pref = new PageReference('/apex/VisitPage?id='+PJPId);
        pref.setRedirect(true);
        return pref;
    }
    
    public pageReference directApprove(){
        Approval.ProcessWorkitemRequest[] prWkItems = New Approval.ProcessWorkItemRequest[]{};
            
            ProcessInstance[] pi = [Select ID, Status, TargetObject.Name, 
                                        (SELECT Id, ActorId, ProcessInstanceId FROM Workitems),
                                        (SELECT Id, StepStatus, Comments FROM Steps) From ProcessInstance Where TargetObjectID =:PJPId AND Status = 'Pending'];
            
            for(ProcessInstance instance : pi){
                for(ProcessInstanceWorkItem workItem : instance.WorkItems){
                    Approval.ProcessWorkitemRequest prWkItem = new Approval.ProcessWorkitemRequest();
                    
                    prWkItem.setWorkItemID(workItem.id);
                    prWkItem.setComments('Approved by ' + userInfo.getName());
                    prWkItem.setAction('Approve');
                    prWkItems.add(prWkItem);
                  
                }
            }          
            
            if(!prWkItems.isEmpty()){
                Approval.ProcessResult[] appResult = Approval.process(prWkItems);
            }
            
            PageReference pref = new PageReference('/'+PJPId);
            pref.setRedirect(true);
            return pref;
    }
    
    public pageReference directReject(){
        String wrkitmid;
        Approval.ProcessWorkitemRequest[] prWkItems = New Approval.ProcessWorkItemRequest[]{};
            
            ProcessInstance[] pi = [Select ID, Status, TargetObject.Name, 
                                        (SELECT Id, ActorId, ProcessInstanceId FROM Workitems),
                                        (SELECT Id, StepStatus, Comments FROM Steps) From ProcessInstance Where TargetObjectID =:PJPId AND Status = 'Pending'];
            for(ProcessInstance instance : pi){
                for(ProcessInstanceWorkItem workItem : instance.WorkItems){
                    wrkitmid = String.valueOf(workItem.id);
                }
            }
            PageReference pref = new PageReference('/p/process/ProcessInstanceWorkitemWizardStageManager?id='+wrkitmid);
            pref.setRedirect(true);
            return pref;
    }
    
    public pageReference createRecs(){
        
        Integer yearnum = Integer.valueOf(year1);
        List<Week_Plan__c> weeknames = new List<Week_Plan__c>();
        List<Day_Plan__c> dpnames = new List<Day_Plan__c>();
        List<Visit__c> vstlst = new List<Visit__c>();
        RecordType rtype = [select id,name from RecordType where sObjectType = 'Month_Plan__c' and name = 'PJP'];
        Map<Integer,String> MonthMap2 = new Map<Integer,String>();
        Map<Integer,Integer> WeekMap = new Map<Integer,Integer>();
        Map<Integer,Day_Plan__c> dpmap = new Map<Integer,Day_Plan__c>();
        
        MonthMap2.put(1,'January');
        MonthMap2.put(2,'February');
        MonthMap2.put(3,'March');
        MonthMap2.put(4,'April');
        MonthMap2.put(5,'May');
        MonthMap2.put(6,'June');
        MonthMap2.put(7,'July');
        MonthMap2.put(8,'August');
        MonthMap2.put(9,'September');
        MonthMap2.put(10,'October');
        MonthMap2.put(11,'November');
        MonthMap2.put(12,'December');
        
        WeekMap.put(1,31);
        WeekMap.put(3,31);
        WeekMap.put(4,30);
        WeekMap.put(5,31);
        WeekMap.put(6,30);
        WeekMap.put(7,31);
        WeekMap.put(8,31);
        WeekMap.put(9,30);
        WeekMap.put(10,31);
        WeekMap.put(11,30);
        WeekMap.put(12,31);
        if(Date.isLeapYear(yearnum))
            WeekMap.put(2,29);
        else
            WeekMap.put(2,28);
        
        DateTime strdate = Date.newinstance(yearnum,month1,1);
        DateTime enddate = Date.newinstance(yearnum,month1,weekMap.get(month1));
        
        Month_Plan__c mnp = new Month_Plan__c();
        mnp.Name = UserInfo.getFirstName()!=null?UserInfo.getFirstName()+' ':'';
        mnp.Name = mnp.Name + UserInfo.getLastName() + ' ' + MonthMap2.get(month1) + ' ' + year1;
        mnp.User__c = UserInfo.getUserId();
        mnp.Year__c = year1;
        mnp.Status__c = 'New Request';
        mnp.Start_Date__c = strdate.date();
        mnp.End_Date__c = enddate.date();
        mnp.RecordTypeId = rtype.id;
        System.debug('@@@'+mnp.Name);
        try{
        insert mnp;
        
        DateTime enddt = strdate;
        
        do{
            Integer diff = enddt.date().daysBetween(enddate.date());
            if(diff > 0){
                System.debug('!!!Inside if');
                if(strdate.format('EEEE') == 'Sunday'){
                    enddt = strdate.date() + 6;
                } else if(strdate.format('EEEE') == 'Monday'){
                    enddt = strdate.date() + 5;
                } else if(strdate.format('EEEE') == 'Tuesday'){
                    enddt = strdate.date() + 4;
                } else if(strdate.format('EEEE') == 'Wednesday'){
                    enddt = strdate.date() + 3;
                } else if(strdate.format('EEEE') == 'Thursday'){
                    enddt = strdate.date() + 2;
                } else if(strdate.format('EEEE') == 'Friday'){
                    enddt = strdate.date() + 1;
                } else if(strdate.format('EEEE') == 'Saturday'){
                    enddt = strdate.date();
                }
            }else{
                enddt = enddate;
            }
            
            Week_Plan__c wp = new Week_Plan__c();
            wp.Name = strdate.day() + ' ' + strdate.format('MMM') + ' - ' + enddt.day() + ' ' + enddt.format('MMM');
            wp.User__c = UserInfo.getUserId();
            wp.Month_Plan__c = mnp.id;
            wp.Start_Date__c = strdate;
            wp.End_Date__c = enddt;
            wp.Status__c = 'New Request';
            wp.Size__c = strdate.date().daysBetween(enddt.date())+1;
            weeknames.add(wp);
            
            strdate = enddt + 1;
            enddt = strdate + 6;
            
        }while(strdate <= enddate);
        insert weeknames;
        
        for(Week_Plan__c wp : weeknames){
            for(Integer i=0; i<Integer.valueOf(wp.Size__c); i++){
                Day_Plan__c dp = new Day_Plan__c();
                dp.Name = wp.Start_Date__c.day()+i + ' ' + MonthMap2.get(wp.Start_Date__c.month()) + ' ' + wp.Start_Date__c.year();
                dp.Month_Plan__c = mnp.id;
                dp.Week_Plan__c = wp.id;
                dp.User__c = UserInfo.getUserId();
                dp.Date__c = wp.Start_Date__c.date()+i;
                dpnames.add(dp);
            }
        }
        insert dpnames;
        }catch(Exception ex){
            errflag = true;
            Month_Plan__c mnp1 = [select id,name from Month_Plan__c where name =: mnp.Name];
            String mymsg = 'Calendar already exists for this month. Please find the link to month plan';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,mymsg));
            return null;
        }
        
        for(Day_Plan__c dp : dpnames){
            dpmap.put(dp.Date__c.day(),dp);
        }
        Integer dtnum;
        for(Visit__c vsttmp : dailyVsttList){
            dtnum = vsttmp.Planned_Date__c.day();
            Visit__c vst = new Visit__c();
            vst.Day_Plan__c = dpmap.get(dtnum).id;
            vst.Planned_Date__c = dpmap.get(dtnum).Date__c;
            vst.Name = UserInfo.getName() + ' ' + vst.Planned_Date__c.day() + ' ' + MonthMap2.get(vst.Planned_Date__c.month()).substring(0,3) + ' ' + String.valueOf(vst.Planned_Date__c.year());
            vst.Planned__c = true;
            vst.Start__c = DateTime.newInstance(vst.Planned_Date__c.year(),vst.Planned_Date__c.month(),dtnum);
            vst.End__c = DateTime.newInstance(vst.Planned_Date__c.year(),vst.Planned_Date__c.month(),dtnum);
            if(vsttmp.General_Visit__c == true){
                vst.General_Visit__c = true;
                vst.General_Visit_Type__c = vsttmp.General_Visit_Type__c;
            }else{
                if(vsttmp.Account__c != null)
                vst.Account__c = vsttmp.Account__c;
                else if(vsttmp.Business_Partner__c != null)
                vst.Business_Partner__c = vsttmp.Business_Partner__c;
                else if(vsttmp.Event__c != null)
                vst.Event__c = vsttmp.Event__c;
                else if(vsttmp.Influencer__c != null)
                vst.Influencer__c = vsttmp.Influencer__c;
                else if(vsttmp.Lead__c != null)
                vst.Lead__c = vsttmp.Lead__c;
                else if(vsttmp.Project_Site__c != null)
                vst.Project_Site__c = vsttmp.Project_Site__c;
                else if(vsttmp.Territory__c != null)
                vst.Territory__c = vsttmp.Territory__c;
            }
            vstlst.add(vst);
        }
        insert vstlst;
        
        PageReference pref = new PageReference('/'+mnp.id);
        pref.setRedirect(true);
        return pref;
        
    }
}