// this trigger for map plant record to account with depot customer code
// Written by Sivakanth 
//Date 17/07/2017
trigger MapAccountCode on Plant_Master__c (before insert,before update) {

   list<String> depotCodeList=new list<String>();
   for(Plant_Master__c plant: trigger.new)
   {
       depotCodeList.add(plant.Depot_Customer__c);
   }
    list<Account>acclist=[select id,Customer_Code__c from Account where Customer_Code__c=:depotCodeList];
    
    for(Account ac:acclist)
    {
      for(Plant_Master__c plant: trigger.new)
      {
        if(ac.Customer_Code__c==plant.Depot_Customer__c)
        {
           
        plant.Customer__c =ac.id;
        }
      }
    }

}