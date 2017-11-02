@isTest
public Class AccountPopulateAndMultiPicklistValueTest{
    
    public static testMethod  void updateAccount()
    {
     list<String>soids=new list<String>();
    
   User u = [select firstname from user where id=:userinfo.getuserid()];
    
     Ship_To_Party__c sh2=new Ship_To_Party__c();
     sh2.Sold_to_Code__c='abc123';
     sh2.External_Id__c='xyz1';
     sh2.ownerid=u.id;
     sh2.Distribution_Channel__c='10';
     sh2.Division__c='50';
     insert sh2;
    
     account ac=new account();
     ac.Customer_Code__c='abc123';
     ac.External_Id__c='abc1231050';
     ac.ownerid=u.id;
     ac.Distribution_Channel__c='10';
     ac.Division__c='50';
     ac.name='testing';
     insert ac;
     
     List<Order__c> orderList=new List<Order__c>();
     Ship_To_Party__c sh=new Ship_To_Party__c();
     sh.Sold_to_Code__c=ac.Customer_Code__c;
     sh.External_Id__c='xyz12';
     sh.ownerid=u.id;
     sh.Distribution_Channel__c='10';
     sh.Division__c='50';
     insert sh;
     
     
     
     Customer_ShipToParty__c sh1=new Customer_ShipToParty__c();
     sh1.Account__c=ac.id;
     sh1.Ship_To_Party__c=sh.id;
     insert sh1;
     
    
    
    
      
    }
}