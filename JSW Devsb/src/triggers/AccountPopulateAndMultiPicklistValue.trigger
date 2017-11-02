trigger AccountPopulateAndMultiPicklistValue on Ship_To_Party__c (Before insert,before update) {

    List<String> customerCode=new List<String>();
    set<Id> acids=new set<Id>();
    set<Id> acidList=new set<Id>();
    set<Id> shidList=new set<Id>();
    List<String> customerCodeList=new List<String>();
    List<String> shipCodeList=new List<String>();
    List<Customer_ShipToParty__c> AsList=new List<Customer_ShipToParty__c>();

  
   for(Ship_To_Party__c sp:trigger.new)
   {
  
    String soldto=sp.Sold_to_Code__c+sp.Distribution_Channel__c+sp.Division__c;
     system.debug('***soldto***'+soldto);
    customerCode.add(soldto);
    
   }
   
   List<Account> spList=[select id,ownerid,Customer_Code__c,External_ID__c   from Account where External_ID__c in :customerCode and External_ID__c !=null];
   system.debug('***spList***'+spList);
 
  for(Account spl:spList)
  {
     for(Ship_To_Party__c acc : trigger.new)
     {
    if(spl.Customer_Code__c  == acc.Sold_to_Code__c)
        acc.Account__c=spl.id;
        acc.ownerid=spl.ownerid;
      }
  
   }

 
  for(Ship_To_Party__c ac : trigger.new){
       acids.add(ac.id);
       
      shidList.add(ac.Account__c);
   if(ac.id!=null && ac.Account__c!=null)
   {
   Customer_ShipToParty__c sh=new Customer_ShipToParty__c();
  sh.Account__c=ac.Account__c;
   sh.Ship_To_Party__c=ac.id;
      AsList.add(sh);
    }
      
      }
    List<Customer_ShipToParty__c> csLists1=[select id,Account__c,Ship_To_Party__c from Customer_ShipToParty__c where Account__c in :shidList and Ship_To_Party__c in : acids];

   if(AsList.size()>0 && csLists1.size()==0)
   {
   insert AsList;
   }
system.debug('***ids'+acids);
  
 

/*
// after insert create record in junction object
if(Trigger.isAfter || Test.isRunningTest()){
   AsList=new List<Customer_ShipToParty__c>();
   acids=new set<Id>();
   shidList=new set<Id>();
   for(Ship_To_Party__c ac:trigger.new)
   {
     acids.add(ac.id);
     shidList.add(ac.Account__c);
   if(ac.id!=null && ac.Account__c!=null)
   {
   Customer_ShipToParty__c sh=new Customer_ShipToParty__c();
  sh.Account__c=ac.Account__c;
   sh.Ship_To_Party__c=ac.id;
      AsList.add(sh);
    }
    
   }
   List<Customer_ShipToParty__c> csLists=[select id,Account__c,Ship_To_Party__c from Customer_ShipToParty__c where Account__c in :shidList and Ship_To_Party__c in : acids];

   if(AsList.size()>0 && csLists.size()==0)
   {
   insert AsList;
   }
}
*/
}