trigger PopulateAccountAndPicklistValues on Business_Partner__c (before Update,before insert) {
set<Id> acids=new set<Id>();
List<String> customerCode=new List<String>();
List<String> bussinessCustomerCode=new List<String>();
  set<Id> acidList=new set<Id>();
    set<Id> shidList=new set<Id>();
List<Account_And_Bussiness__c> AsList=new List<Account_And_Bussiness__c>();
  Id recId1;
    Id recId2;
    Id recId3;
    RecordType rec;
    RecordType rec1;
    RecordType rec2;
     RecordType rec3;
    Map<Id,RecordType> recordmap = new Map<Id,RecordType>();
   // List<RecordType>recordList=[select Id,name from RecordType where SobjectType = 'Account'];
    for(RecordType rt:[select Id,name from RecordType where SobjectType = 'Business_Partner__c'])
    {
        //recordmap.put(rt.id,rt);
    //}
    //system.debug('***recordmap'+recordmap);
    //for (Id id : recordmap.keySet())
    //{ 
        if(rt.name.equals('Sub-Dealers'))
        {
            rec=rt;
            //rec=recordmap.get(id);
            
            system.debug('***recId1'+recId1);
        }else if(rt.name.equals('MMC'))
        {
            rec1=rt;
            //rec1=recordmap.get(id);
            system.debug('***recId2'+recId2);
        }else if(rt.name.equals('Sales Employee'))
        {
            rec2=rt;
          
        }else if(rt.name.equals('Sales Promoters'))
        {
            rec3=rt;
          
        }
    }
    
    if(Trigger.isBefore)
    {
    
     for(Business_Partner__c acc : trigger.new){
      String solto=acc.Sold_to_Code__c+acc.Distribution_Channel__c+acc.Division__c;
          bussinessCustomerCode.add(solto);
          system.debug('******bussinessCustomerCode****'+bussinessCustomerCode);
     }
     if(bussinessCustomerCode.size()>0)
     {
     list<Account> bCodeList=[select id,ownerId from Account where External_ID__c in :bussinessCustomerCode and External_ID__c !=null];
      system.debug('******bCodeList****'+bCodeList);
     for(Account ac : bCodeList)
      {
        for(Business_Partner__c acc : trigger.new){
             acc.Account__c=ac.id;
             acc.ownerId =ac.ownerId;
        }
      
      }
      }
    
    
    for(Business_Partner__c acc : trigger.new){
            system.debug('***acc group****'+acc.Account_Group__c);
            if(acc.Account_Group__c!=null)
            {
            if(acc.Account_Group__c.equals('YSUB'))
            {
                acc.RecordTypeId=rec.Id;
                system.debug('***acc.RecordTypeId1****'+acc.RecordTypeId);
            }else if(acc.Account_Group__c.equals('YMMC'))
            {
                acc.RecordTypeId=rec1.Id;
                system.debug('***acc.RecordTypeId2****'+acc.RecordTypeId);
            }else if(acc.Account_Group__c.equals('YSAL'))
            {
                acc.RecordTypeId=rec2.Id;
                system.debug('***acc.RecordTypeId3***'+acc.RecordTypeId);
            }else if(acc.Account_Group__c.equals('YPRO'))
            {
             system.debug('***YPRO***'+acc.Account_Group__c);
                acc.RecordTypeId=rec3.Id;
                system.debug('***acc.RecordTypeId3***'+acc.RecordTypeId);
            }
            }
        }
        
         for(Business_Partner__c acc : trigger.new){
         
         String solto=acc.Sold_to_Code__c+acc.Distribution_Channel__c+acc.Division__c;
          bussinessCustomerCode.add(solto);
           system.debug('******bussinessCustomerCode****'+bussinessCustomerCode);
     }
     if(bussinessCustomerCode.size()>0)
     {
     list<Account> bCodeList=[select id,ownerId  from Account where External_ID__c in :bussinessCustomerCode and External_ID__c !=null];
     
     for(Account ac : bCodeList)
      {
        for(Business_Partner__c acc : trigger.new){
        
             acc.Account__c=ac.id;
             acc.ownerId =ac.ownerId;
        }
      
      }
      }
    }
    
    
    
    
    
    if(Trigger.isInsert) 
    {
        for(Business_Partner__c acc : trigger.new){
            system.debug('***acc group****'+acc.Account_Group__c);
            if(acc.Account_Group__c!=null)
            {
            if(acc.Account_Group__c.equals('YSUB'))
            {
                acc.RecordTypeId=rec.Id;
                system.debug('***acc.RecordTypeId1****'+acc.RecordTypeId);
            }else if(acc.Account_Group__c.equals('YMMC'))
            {
                acc.RecordTypeId=rec1.Id;
                system.debug('***acc.RecordTypeId2****'+acc.RecordTypeId);
            }else if(acc.Account_Group__c.equals('YSAL'))
            {
                acc.RecordTypeId=rec2.Id;
                system.debug('***acc.RecordTypeId3***'+acc.RecordTypeId);
            }else if(acc.Account_Group__c.equals('YPRO'))
            {
             system.debug('***YPRO***'+acc.Account_Group__c);
                acc.RecordTypeId=rec3.Id;
                system.debug('***acc.RecordTypeId3***'+acc.RecordTypeId);
            }
            }
        }
        
         for(Business_Partner__c acc : trigger.new){
         String solto=acc.Sold_to_Code__c+acc.Distribution_Channel__c+acc.Division__c;
          bussinessCustomerCode.add(solto);
           system.debug('******bussinessCustomerCode****'+bussinessCustomerCode);
     }
     if(bussinessCustomerCode.size()>0)
     {
     list<Account> bCodeList=[select id,ownerId from Account where External_ID__c in :bussinessCustomerCode and External_ID__c !=null];
     
     for(Account ac : bCodeList)
      {
        for(Business_Partner__c acc : trigger.new){
             acc.Account__c=ac.id;
             acc.ownerId =ac.ownerId;
        }
      
      }
      }
      
      
      
    
        
    }

 if(Trigger.isUpdate)
 {
  for(Business_Partner__c ac : trigger.new){
       acids.add(ac.id);
      
      }
system.debug('***ids'+acids);
  List<Business_Partner__c> accnts=[select id,Division__c,Distribution_Channel__c from Business_Partner__c where id in :acids];
  Map<String,Business_Partner__c> divmap = new Map<String,Business_Partner__c>();
  for(Business_Partner__c acs:accnts){
      divmap.put(acs.id,acs);
  }  
 /* for(Business_Partner__c ac : trigger.new){
  if(divmap.get(ac.id).Division__c!= null && ac.Division__c!= null){
  if(!divmap.get(ac.id).Division__c.contains(ac.Division__c)){
   ac.Division__c= divmap.get(ac.id).Division__c+';'+ac.Division__c;
   system.debug('***acs.Division__c'+ac.Division__c);
   
   }else{
       ac.Division__c= divmap.get(ac.id).Division__c;
   }
   }


   if(divmap.get(ac.id).Distribution_Channel__c!= null && ac.Distribution_Channel__c!= null){
  if(!divmap.get(ac.id).Distribution_Channel__c.contains(ac.Distribution_Channel__c)){
   ac.Distribution_Channel__c= divmap.get(ac.id).Distribution_Channel__c+';'+ac.Distribution_Channel__c;
   system.debug('***acs.Distribution_Channel__c'+ac.Distribution_Channel__c);
   
   }else{
       ac.Distribution_Channel__c= divmap.get(ac.id).Distribution_Channel__c;
   }
   }
  

  }*/
 }
 
 // insert record in junction object
 
 
// after insert create record in junction object

   AsList=new List<Account_And_Bussiness__c>();
    acids=new set<Id>();
    shidList=new set<Id>();
   for(Business_Partner__c ac:trigger.new)
   {
   acids.add(ac.id);
   shidList.add(ac.Account__c);
   if(ac.id!=null && ac.Account__c!=null)
   {
   Account_And_Bussiness__c sh=new Account_And_Bussiness__c();
  sh.Account__c=ac.Account__c;
   sh.Business_Partner__c=ac.id;
      AsList.add(sh);
    }
    
   }
    system.debug('***AsList'+AsList);
       system.debug('***acids'+acids);
          system.debug('***shidList'+shidList);
           
   List<Account_And_Bussiness__c> csLists=[select id,Account__c,Business_Partner__c from Account_And_Bussiness__c where Account__c in :acids and Business_Partner__c in : shidList];
  system.debug('***csLists'+csLists);
   system.debug('***AsList.size()'+AsList.size());
   if(AsList.size()>0 && csLists.size()==0)
   {
  insert AsList;
   }
     


 
 
}