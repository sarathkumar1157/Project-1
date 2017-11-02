@isTest
public Class UpdateAccountAndBussinessPartnerTest {
    
    public static testMethod  void updateAccount()
    {
     list<String>soids=new list<String>();
     List<Order__c> orderList=new List<Order__c>();
   
     
     account ac=new account();
     ac.Customer_Code__c='xyz';
     ac.Account_Group__c = 'YCSP';
     // ac.External_ID__c='abc1231020';
     ac.Distribution_Channel__c = '10'; 
      ac.Division__c = '50'; 
     ac.name='testing';
     insert ac;
     
     Business_Partner__c bp = new Business_Partner__c();
     bp.Customer_Code__c='abc';
      bp.Distribution_Channel__c = '10'; 
      bp.Division__c = '50'; 
    // bp.ExternalId__c='abc1050';
     insert bp;
     
     User usr = new User();
     usr.SAP_Code__c='1234';
      usr.profileId = [Select Id From Profile Where  Name='System Administrator'].id;
      usr.username = 'hai123456@gmail.com';
      usr.email = 'pb@ff.com';
                usr.emailencodingkey = 'UTF-8';
                usr.localesidkey = 'en_US'; 
                usr.languagelocalekey = 'en_US';
                usr.timezonesidkey = 'America/Los_Angeles'; 
                usr.alias='nuser';
                usr.lastname='lastname'; 
     insert usr;
     
     Customer_Ledger__c cl = new Customer_Ledger__c();
     cl.Sales_Promoter_Code__c=bp.Customer_Code__c;
     cl.Customer_Code__c = ac.Customer_Code__c;
     cl.Sales_Employee_Code__c=usr.SAP_Code__c;
     
     cl.Account__c=ac.id;
     cl.Sales_Promoter__c=bp.id;
     
     insert cl;
    
    
      
    }
}