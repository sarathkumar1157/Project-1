trigger AutopopulateDepotId on Depot_Stock__c (before update,before insert) {
    
     List<String> depotList= new List<String>();
     List<String> productList= new List<String>();
     for(Depot_Stock__c  ds: trigger.new)
     {
     depotList.add(ds.Depot_Account_Code__c);
     productList.add(ds.Material__c);
     }
     
     List<Account> accounts=new List<Account>();
     if(depotList.size()>0)
      {
       accounts=[select id,Customer_Code__c,ownerId  from Account where Customer_Code__c in :depotList and Customer_Code__c != null];
      }
      
      
      for(Account acc: accounts)
      {
         for(Depot_Stock__c  ds: trigger.new)
         {
        if(ds.Depot_Account_Code__c== acc.Customer_Code__c)
          {
          ds.Depot__c=acc.id;
          ds.ownerId = acc.ownerId;
          }
          
         }
      
      }
      
      List<Product2> products=new List<Product2>();
     if(productList.size()>0)
      {
       products=[select id,ProductCode from Product2 where ProductCode in :productList and ProductCode != null];
      }
      
      
      for(Product2 acc: products)
      {
         for(Depot_Stock__c  ds: trigger.new)
         {
            if(ds.Material__c== acc.ProductCode)
          ds.Product__c=acc.id;
          
         }
      
      }
}