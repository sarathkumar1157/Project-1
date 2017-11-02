public class visitedcontroller {
public string url;
public Map<Integer,String> MonthMap2 {get; set;}
public Visit__c vst {get; set;}

    public VisitEdController() {
    vst=new visit__C();
    MonthMap2 = new Map<Integer,String>();
        MonthMap2.put(1,'Jan');
        MonthMap2.put(2,'Feb');
        MonthMap2.put(3,'Mar');
        MonthMap2.put(4,'Apr');
        MonthMap2.put(5,'May');
        MonthMap2.put(6,'Jun');
        MonthMap2.put(7,'Jul');
        MonthMap2.put(8,'Aug');
        MonthMap2.put(9,'Sep');
        MonthMap2.put(10,'Oct');
        MonthMap2.put(11,'Nov');
        MonthMap2.put(12,'Dec');
    }

    public pagereference save() {
         
         Date currdate = system.today();
         Date vstdate;
         Date vendate;
         if(vst.Start__c != null)
            vstdate = vst.Start__c.date();
          if(vst.End__c != null)
          vendate = vst.End__c.date();
         
         if(vstdate < currdate){
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Cannot create visit for past days'));
             return null;
         } else if(vstdate != vendate){
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter valid start and end timings'));
             return null;
         } else {
             vst.Name = UserInfo.getName() + ' ' + currdate.day() + ' ' + MonthMap2.get(currdate.month()) + ' ' + currdate.year();
             vst.Planned_Date__c = vendate;
             try{
                 insert vst;
             }
             catch(Exception ex){
                 System.debug('Exception occured');
             }
             url =  apexpages.currentpage().getparameters().get('id');
             PageReference pref = new PageReference('/apex/DailyVisitPlanView?id='+url );
             pref.setRedirect(true);
             return pref;
         }
    }   
    public PageReference cancel() {
         url =  apexpages.currentpage().getparameters().get('id');
         system.debug('$$$$$$$$'+url);
         PageReference pref = new PageReference('/apex/DailyVisitPlanView?id='+url );
         system.debug('@@@@@@@'+pref );
         pref.setRedirect(true);
         return pref;
    }

   
}