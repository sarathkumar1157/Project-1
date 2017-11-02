trigger PopulateAccountAndSaleOrder on Delivery__c (before insert,before update) {
/*
Set<String> dlids = new Set<String>();
 for(Delivery__c Delv:trigger.new){
  dlids.add(delv.Sold_To_Code__c);
}
list<account> acclist=[select id,name,Sold_To_Code__c from account where Sold_To_Code__c in: dlids];
Map<String,account> accmapping = new Map<String,account>();
   
    for(account act: acclist){
        if(dlids.contains(act.Sold_To_Code__c )){
            accmapping.put(act.Sold_To_Code__c ,act);
        }
    }
    
  for(Delivery__c delvord:trigger.new){
   delvord.ownerid=accmapping.get(delvord.Sold_To_Code__c).ownerid;
  }
*/

 List<String> delivryAccount=new List<String>();
 List<String> delivryShip=new List<String>();
 List<String> delivrySaleO=new List<String>();
 List<Ship_To_Party__c> shList;
 List<Account> accList;
 List<Order__c> odList;
   for(Delivery__c ins: Trigger.new)
   {
    String soldt=ins.Sold_To_Code__c+ins.Distribution_Channel__c+ins.Division__c;
    String shpto=ins.Ship_to_Code__c+ins.Distribution_Channel__c+ins.Division__c;
   
     delivryAccount.add(soldt);
     delivryShip.add(shpto);
     delivrySaleO.add(ins.Sales_Doc__c);
      
   }
   if(delivryAccount.size()>0)
   {
    accList=[select id,External_ID__c from Account where External_ID__c in : delivryAccount and External_ID__c !=null];
   }
    if(delivrySaleO.size()>0)
   {
    odList=[select id,SO_STO_No__c from Order__c where SO_STO_No__c in : delivrySaleO and SO_STO_No__c !=null];
   }
    if(delivryShip.size()>0)
   {
    shList=[select id,External_ID__c from Ship_To_Party__c where External_ID__c in : delivryShip and External_ID__c !=null];
   }
   
   for(Account ac: accList)
   {
   
      for(Delivery__c ins: Trigger.new)
      {
        if(ins.External_ID__c == ac.External_ID__c)
        ins.Account__c=ac.id;
      }
   
   }
    for(Order__c od: odList)
   {
   
      for(Delivery__c ins: Trigger.new)
      {
      if(ins.Sales_Doc__c == od.SO_STO_No__c )
        ins.Sales_Orders__c=od.id;
      }
   
   }
    for(Ship_To_Party__c sh: shList)
   {
   
      for(Delivery__c ins: Trigger.new)
      {
      if(ins.External_ID__c == sh.External_ID__c)
        ins.Ship_To_Party__c=sh.id;
      }
   
   }
 }