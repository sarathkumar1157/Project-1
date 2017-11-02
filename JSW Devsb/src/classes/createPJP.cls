public class createPJP{
    
    public String month {get;set;}
    public String year {get;set;}
    //public Integer dt {get;set;}
    public Map<String,Integer> MonthMap {get;set;}
    public Map<Integer,String> MonthMap2 {get;set;}
    public Map<String,Integer> WeekMap {get;set;}
    public Boolean errflag {get; set;}
    public Month_Plan__c mnp1 {get;set;}
    public RecordType rtype {get; set;}
    
    public createPJP(ApexPages.StandardController controller){
    
        MonthMap = new Map<String,Integer>();
        MonthMap2 = new Map<Integer,String>();
        WeekMap = new Map<String,Integer>();
        rtype = [select id,name from RecordType where sObjectType = 'Month_Plan__c' and name = 'PJP'];
        
        MonthMap.put('January',1);
        MonthMap.put('February',2);
        MonthMap.put('March',3);
        MonthMap.put('April',4);
        MonthMap.put('May',5);
        MonthMap.put('June',6);
        MonthMap.put('July',7);
        MonthMap.put('August',8);
        MonthMap.put('September',9);
        MonthMap.put('October',10);
        MonthMap.put('November',11);
        MonthMap.put('December',12);
        
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
        
        WeekMap.put('January',31);
        WeekMap.put('March',31);
        WeekMap.put('April',30);
        WeekMap.put('May',31);
        WeekMap.put('June',30);
        WeekMap.put('July',31);
        WeekMap.put('August',31);
        WeekMap.put('September',30);
        WeekMap.put('October',31);
        WeekMap.put('November',30);
        WeekMap.put('December',31);
        
    }
    
    public pageReference createRecs(){
        /*String idname = String.valueOf(UserInfo.getUserId());
        System.debug('&&&'+idname);*/
        Integer yearnum = Integer.valueOf(year);
        List<Week_Plan__c> weeknames = new List<Week_Plan__c>();
        List<Day_Plan__c> dpnames = new List<Day_Plan__c>();
        
        if(Date.isLeapYear(yearnum))
            WeekMap.put('February',29);
        else
            WeekMap.put('February',28);
        
        DateTime strdate = Date.newinstance(yearnum,MonthMap.get(month),1);
        DateTime enddate = Date.newinstance(yearnum,MonthMap.get(month),weekMap.get(month));
        
        Month_Plan__c mnp = new Month_Plan__c();
        mnp.Name = UserInfo.getFirstName()!=null?UserInfo.getFirstName()+' ':'';
        mnp.Name = mnp.Name + UserInfo.getLastName() + ' ' + month + ' ' + year;
        mnp.User__c = UserInfo.getUserid();
        mnp.Year__c = year;
        mnp.Status__c = 'New Request';
        mnp.Start_Date__c = strdate.date();
        mnp.End_Date__c = enddate.date();
        mnp.RecordTypeId = rtype.id;
        
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
            wp.User__c = UserInfo.getUserid();
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
                dp.User__c = UserInfo.getUserid();
                dp.Date__c = wp.Start_Date__c.date()+i;
                dpnames.add(dp);
            }
        }
        insert dpnames;
        }catch(Exception ex){
            errflag = true;
            mnp1 = [select id,name from Month_Plan__c where name =: mnp.Name];
            String mymsg = 'Calendar already exists for this month. Please find the link to month plan';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,mymsg));
            return null;
        }
        
        PageReference pref = new PageReference('/apex/DailyVisitPlan?id='+mnp.id);
        pref.setRedirect(true);
        return pref;
        //return null;
    }
    
    public pageReference pjptab(){
        Schema.DescribeSObjectResult PJPDest = Month_Plan__c.sObjectType.getDescribe();
        pageReference pref = new pageReference('/'+PJPDest.getKeyPrefix()+'/o');
        pref.setRedirect(true);
        return pref;
    }
}