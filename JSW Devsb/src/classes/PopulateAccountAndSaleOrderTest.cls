@isTest
public Class PopulateAccountAndSaleOrderTest{
    
    public static testMethod  void updateAccount()
    {
     list<String> soids=new list<String>();
     list<Account> acclist=new list<Account>();
  
     account ac=new account();
     ac.Customer_Code__c='abc123';
     ac.name='testing';
     ac.External_ID__c='abc1231050';
     insert ac;
     //insert acclist;
     
     Order__c or1 = new Order__c();
     or1.SO_STO_No__c='564576';
      insert or1;
     
     Ship_To_Party__c sh = new Ship_To_Party__c(); 
     sh.Customer_Code__c='1234';
     sh.External_Id__c='45';
     insert sh;
     
     Delivery__c dl= new Delivery__c();
     dl.Delivery_No__c='sgdfa';
     dl.Sold_To_Code__c =  ac.Customer_Code__c;
     dl.Sales_Doc__c='564576';
     dl.Account__c=ac.id;
     dl.External_Id__c=ac.External_ID__c;
     dl.Ship_to_Code__c= sh.Id;
        dl.Distribution_Channel__c = '10';
        dl.Division__c = '50';
    insert dl;
   }
}