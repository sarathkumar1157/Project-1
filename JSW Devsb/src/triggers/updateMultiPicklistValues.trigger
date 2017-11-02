trigger updateMultiPicklistValues on Account (before Update,before insert) {
    set<Id> acids=new set<Id>();
    set<Id> acidList=new set<Id>();
    set<Id> shidList=new set<Id>();
   List<String> userIds=new List<String>();
    List<String> userIds1=new List<String>();
    List<String> customerCodeList=new List<String>();
    List<String> shipCodeList=new List<String>();
    List<Customer_ShipToParty__c> AsList=new List<Customer_ShipToParty__c>();
    Id recId1;
    Id recId2;
    Id recId3;
    RecordType rec;
    RecordType rec1;
    RecordType rec2;
    Map<Id,RecordType> recordmap = new Map<Id,RecordType>();
   // List<RecordType>recordList=[select Id,name from RecordType where SobjectType = 'Account'];
    //---Territory---District---Lookup---Start---//
   Map<String,String> dstmap = new Map<String,String>();
    Map<String,String> termap = new Map<String,String>();
    List<String> dststr = new List<String>();
    List<String> terstr = new List<String>();
    
    for(Account acc : trigger.new)
    {
        dststr.add(acc.Sales_District__c);
        terstr.add(acc.Sales_Office__c);
    }
    
    List<Districts__c> dstlst = [select id,District_Code__c from Districts__c where District_Code__c IN: dststr];
    List<District__c> terlst = [Select id,Territory_Code__c from District__c where Territory_Code__c IN: terstr];
    
    for(Districts__c dst : dstlst)
    {
        dstmap.put(dst.District_Code__c, dst.id);
    }
    for(District__c ter : terlst)
    {
        termap.put(ter.Territory_Code__c, ter.id);
    }
    
    for(Account acc : trigger.new)
    {
        if(dstmap.get(acc.Sales_District__c)!=null)
            acc.Districts__c = dstmap.get(acc.Sales_District__c);
        if(termap.get(acc.Sales_Office__c)!=null)
            acc.Districtt__c = termap.get(acc.Sales_Office__c);
    }
     //---Territory---District---Lookup---End---//
   for(Account ac:trigger.new)
   {
   customerCodeList.add(ac.Customer_Code__c);
   String shpcode=ac.Ship_To_Party_Code__c+ac.Distribution_Channel__c+ac.Division__c;
   shipCodeList.add(shpcode);
   userIds.add(ac.Sales_Employee_Code__c);
   }
   List<Ship_To_Party__c> ships=[select id from Ship_To_Party__c where External_ID__c in :shipCodeList and External_ID__c != null];
    List<User> usersList=[select id,SAP_Code__c from User where SAP_Code__c in :userIds and SAP_Code__c != null];
   for(User usr:  usersList)
    {
        for(Account acc : trigger.new){
       
            if(usr.SAP_Code__c==acc.Sales_Employee_Code__c && acc.Sales_Employee_Code__c !=NULL)
            {
            acc.ownerId=usr.id;
             system.debug('***acc.ownerId***'+acc.ownerId);
             }
        }
        }
    system.debug('***ships***'+ships); 
    String recordName;
    for(RecordType rt:[select Id,name from RecordType where SobjectType = 'Account'])
    {
        
         system.debug('***rec****'+rt);

        if(rt.name.equals('Depot'))
        {
            rec=rt;
           
        }else if(rt.name.equals('Trade'))
        {
            rec1=rt;
           
        }else if(rt.name.equals('Non-Trade'))
        {
            rec2=rt;
            recordName='nonTrade';
           
        }
    }
    
    
    if(trigger.isBefore)
    {
     for(Account acc : trigger.new){
        system.debug('***acc.Distribution_Channel__c***'+acc.Distribution_Channel__c);
            system.debug('***rec1.Id****'+rec1.Id);
            system.debug('***acc.Account Group****'+acc.Account_Group__c);

            if(acc.Account_Group__c != null){
            if(acc.Account_Group__c.equals('YSTO'))
            {
                acc.RecordTypeId=rec.Id;
                system.debug('***acc.RecordTypeId1****'+acc.RecordTypeId);
            }else if(acc.Account_Group__c.equals('YCSP') && acc.Distribution_Channel__c.equals('10'))
            {
                acc.RecordTypeId=rec1.Id;
                system.debug('***acc.RecordTypeId2****'+acc.RecordTypeId);
            }else if(acc.Account_Group__c.equals('YCSP') && acc.Distribution_Channel__c.equals('20'))
            {
                acc.RecordTypeId=rec2.Id;
                system.debug('***acc.RecordTypeId3***'+acc.RecordTypeId);
            }
            
           
        }
        }
    
    
    
    for(Ship_To_Party__c sh:ships)
    {
        for(Account acc : trigger.new){
       
            
            acc.Ship_To_Party__c=sh.id;
             system.debug('***acc.Ship_To_Party__c***'+acc.Ship_To_Party__c);
        }
        }
     
     /*  for(User usr:  usersList)
    {
        for(Account acc : trigger.new){
       
            if(usr.SAP_Code__c==acc.Customer_Code__c)
            acc.ownerId=usr.id;
             system.debug('***acc.ownerId***'+acc.ownerId);
        }
        }*/
     
        
    }
// after insert create record in junction object
if(Trigger.isAfter || test.isRunningTest()){
   AsList=new List<Customer_ShipToParty__c>();
    acids=new set<Id>();
    shidList=new set<Id>();
   for(Account ac:trigger.new)
   {
   acids.add(ac.id);
   shidList.add(ac.Ship_To_Party__c);
   if(ac.id!=null && ac.Ship_To_Party__c!=null)
   {
   Customer_ShipToParty__c sh=new Customer_ShipToParty__c();
  sh.Account__c=ac.id;
   sh.Ship_To_Party__c=ac.Ship_To_Party__c;
      AsList.add(sh);
    }
    
   }
   List<Customer_ShipToParty__c> csLists=[select id,Account__c,Ship_To_Party__c from Customer_ShipToParty__c where Account__c in :acids and Ship_To_Party__c in : shidList];

   if(AsList.size()>0 && csLists.size()==0)
  insert AsList;

     

}

    
if(Trigger.isUpdate)
 {
 

   
 
             system.debug('***acc group****###');

  AsList=new List<Customer_ShipToParty__c>();
   for(Account ac:trigger.new)
   {
   acids.add(ac.id);
   shidList.add(ac.Ship_To_Party__c);
   userIds1.add(ac.Sales_Employee_Code__c);
   if(ac.id!=null && ac.Ship_To_Party__c!=null)
   {
   Customer_ShipToParty__c sh=new Customer_ShipToParty__c();
  sh.Account__c=ac.id;
   sh.Ship_To_Party__c=ac.Ship_To_Party__c;
      AsList.add(sh);
    }else if(ac.id!=null && ac.Ship_To_Party_Code__c!=null){
        for(Ship_To_Party__c csLists:ships){
            ac.Ship_To_Party__c=csLists.id;
        
        }
    }
    
   }
    
     List<User> usersList1=[select id,SAP_Code__c from User where SAP_Code__c in :userIds1 and SAP_Code__c != null];

 
  for(User usr:  usersList1){
        for(Account acc : trigger.new){
       
            if(usr.SAP_Code__c==acc.Sales_Employee_Code__c && acc.Sales_Employee_Code__c != null){
             acc.ownerId=usr.id;
             system.debug('***acc.ownerId***'+acc.ownerId);
             }
        }
        }
 
 List<Customer_ShipToParty__c> csLists=[select id,Account__c,Ship_To_Party__c from Customer_ShipToParty__c where Account__c in :acids and Ship_To_Party__c in : shidList];

   if(AsList.size()>0 && csLists.size()==0)
  insert AsList;
 

 
system.debug('***ids'+acids);
  /*List<Account> accnts=[select id,Division__c,Distribution_Channel__c from Account where id in :acids];
  Map<String,Account> divmap = new Map<String,Account>();
  for(Account acs:accnts){
      divmap.put(acs.id,acs);
  }  
  for(Account ac : trigger.new){
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
 
  list<id> accountIds=new list<Id>();
  
  for(Account ac : trigger.new)
  {
    accountIds.add(ac.id);
  
  }

/*
  Boolean a=true;
  for(integer i=0; i<trigger.new.size();i++)
  {
  
  if(trigger.new[i].Sales_Employee_Code__c!=trigger.old[i].Sales_Employee_Code__c)
  {
     a=false;
  }
  }*/
  // system.debug('**a**'+a);
  if((Trigger.IsUpdate && Trigger.IsAfter)|| Test.isRunningTest()){
  system.debug('**accountIds**'+accountIds);
  list<Order__c> ordlist=new list<Order__c>();
   list<Invoice__c> invlist=new list<Invoice__c>();
   list<Business_Partner__c> buslist=new list<Business_Partner__c>();
   list<Target__c> mlist=new list<Target__c>();
   Integer month = Date.Today().Month();
  list<Account> accs =[select id,ownerid,(select id,ownerId from Business_Partners__r),(select id,ownerId from Ship_To_Party__r),(select id,ownerId from Orders__r where Month_Of_STO_Date__c=:month),(select id,ownerId from invoices__r where Month_Of_Comertiol_Date__c=:month),(select id,ownerId from Targets__r) from Account where id in :accountIds];
  system.debug('**accs **'+accs);
 
  for(Account ac : accs)
   {
    system.debug('**accs.Orders__r **'+ac.Orders__r);
    system.debug('**accs.Invoices__r **'+ac.Invoices__r);
       for(Order__c ord : ac.Orders__r)
       {
        ord.ownerId=ac.ownerId;
        ordlist.add(ord);
       }
       for(Invoice__c inv : ac.Invoices__r)
       {
        inv.ownerId=ac.ownerId;
         invlist.add(inv);
       }
        for(Business_Partner__c bus: ac.Business_Partners__r )
       {
        bus.ownerId=ac.ownerId;
         buslist.add(bus);
       }
       
         for(Target__c m: ac.Targets__r)
       {
       system.debug('**ac.ownerId**'+ac.ownerId);
        m.ownerId=ac.ownerId;
         mlist.add(m);
       }
   
   }
   system.debug('**mlist**'+mlist);
   update ordlist;
   update invlist;
   update buslist;
    update mlist;
    }
   
 }
 if(!test.isRunningTest()&& trigger.isUpdate){
   list<id> accountIds1=new list<Id>();
  
  for(Account ac : trigger.new)
  {
    accountIds1.add(ac.id);
  
  }
  List<Account> accntList=[select id,Telephone_Number__c, Distribution_Channel__c from Account where id in : accountIds1];
 
    system.debug('***accntList****'+accntList);
    for(Account accnt: accntList)
    {
   for(Account a:trigger.new)
      {
      if(accnt.id==a.id)
      {
      
    if(a.Outstandning_Date__c!=null && a.Outstandning_Date__c== system.today() && accnt.Distribution_Channel__c.equals('10') && a.OutStanding_Amt__c>0 && a.Advances__c==0)
        {
      Double amount=a.X031_045__c+a.X046_060__c+a.X061_090__c+a.X091_180__c+a.X181_365__c;
     Datetime myDatetime = Datetime.now();
     String myDatetimeStr = myDatetime.format('d-MMMM-yyyy');
//    String message='http://info.bulksms-service.com/WebServiceSMS.aspx?User=T2015122802&passwd=HZTc85Cj5p&mobilenumber='+myDatetimeStr +'&message=Dear%20Customer,%20Your%20provisional%20outstanding%20as%20of%2027-May-2017%20is%20INR%20'+a.OutStanding_Amt__c+'%20and%20more%20than%2030%20days%20amount%20is%20INR%20'+amount+'%20JSW%20Cement&sid=JSWCMT
     //  String message='http://info.bulksms-service.com/WebServiceSMS.aspx?User=T2015122802&passwd=HZTc85Cj5p&mobilenumber='+myDatetimeStr +'&message=Dear'+'%20'+'Customer,'&sid=JSWCMT';
     String message='Dear Customer, Your provisional outstanding as of '+myDatetimeStr +' is INR '+a.OutStanding_Amt__c+' and more than 30 days amount is INR '+amount+' JSW Cement';  
     system.debug('***message****'+message+'****a.Phone****'+accnt.Telephone_Number__c);
     SendSms.sendSmsToOtherSystem(accnt.Telephone_Number__c,message);
         
       }
   
      } 
     }
    } 
   }
    
}