trigger createUnplanedVisit on Visit_Report__c (before insert,after insert) {
  set<Id>ids=new set<Id>();
  List<Day_Plan__c> dayPlan=new List<Day_Plan__c>();
   List<Lead> leads=new List<Lead>();
   List<Visit__c> visitList=new List<Visit__c>();
   List<Visit_Report__c> visitRepoertList=new List<Visit_Report__c>();
  for(Visit_Report__c  vr:trigger.new)
  {
  if(Trigger.isAfter)
  {
  
       ids.add(vr.id);
      visitRepoertList=new List<Visit_Report__c>();
      visitRepoertList=[select id,Name_of_Customer_Influencer__c,Type_of_Customer_Influencer__c,Customer_influencer_Email_ID__c,Customer_influencer_Mobile_No__c,State__c,District__c,Place_Address__c,RecordType.name from Visit_Report__c where id in:ids];
      leads=new List<Lead>();
     if(visitRepoertList.size()>0)
     {
      for(Visit_Report__c vrp:visitRepoertList)
      {
     
      system.debug('***vr.RecordType'+vrp.RecordType.name);
      if(vrp.RecordType.name=='Daily Call Report')
      {
            Lead ld=new Lead();
     
            ld.LastName = vrp.Name_of_Customer_Influencer__c;
            ld.Email = vrp.Customer_influencer_Email_ID__c;
            ld.Phone = vrp.Customer_influencer_Mobile_No__c;
            ld.Type__c=vrp.Type_of_Customer_Influencer__c;
            ld.Company='abc';
            insert ld;
      }
      
      }
     } 
     
     
   }else
   {
    if(vr.Visit__c == null){
    String userName=UserInfo.getUserId();
    system.debug('***userName'+userName);
    dayPlan=[select id, Account_Name__c,Date__c from Day_Plan__c where User__c=:userName and Date__c=TODAY];
    visitList=[select id,Name from Visit__c where OwnerId=:userName and createdDate=TODAY];
    Map<Integer,String> MonthMap2 = new Map<Integer,String>();
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
    
     system.debug('***dayPlan'+dayPlan);
     for(Day_Plan__c dp:dayPlan)
     {  
         Visit__c visit=new Visit__c();
        if(vr.Account__c!=null)
          {
           
            visit.Account__c=vr.Account__c;
          }else if(vr.Lead__c!=null)
          {            
            visit.Lead__c=vr.Lead__c;
          }
           visit.Name = UserInfo.getName() + ' ' + system.today().day() + ' ' + MonthMap2.get(system.today().month()) + ' ' + system.today().year();
           visit.Planned_Date__c = dp.Date__c;
           visit.Start__c = system.now();
           visit.End__c = system.now().addHours(2);
           visit.Day_Plan__c = dp.id;
           //visit.Visited__c = true;
           insert visit;
           system.debug('visit id****'+visit.id);
           vr.Visit__c=visit.id;
     
     }
   }  
   }
  }
}