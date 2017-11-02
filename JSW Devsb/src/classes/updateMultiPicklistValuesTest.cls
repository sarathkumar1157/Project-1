@isTest
public Class updateMultiPicklistValuesTest {
    
    public static testMethod  void updateAccount()
    {
        list<String>soids=new list<String>();
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id,
                          TimeZoneSidKey='America/Los_Angeles', UserName='testbd@testbt.com',SAP_Code__c='123');
        insert u;
        List<Order__c> orderList=new List<Order__c>();
        Ship_To_Party__c sh=new Ship_To_Party__c();
        sh.Sold_to_Code__c='abc123';
        sh.Distribution_Channel__c='10';
        sh.Division__c='50';
        sh.External_Id__c='12341050';
        sh.OwnerId=u.id;
        insert sh;
        account ac=new account();
        ac.Customer_Code__c=sh.Sold_to_Code__c;
        ac.Account_Group__c = 'YCSP';
        ac.Distribution_Channel__c = '10'; 
        ac.Division__c = '50';
        ac.name='testing';
        ac.External_ID__c='1234';
        ac.OwnerId=u.id;
        ac.Sales_Employee_Code__c = '123';
        ac.Ship_To_Party_Code__c = '1234';
        insert ac;
        
        ac.Sales_Employee_Code__c ='254';
        update ac;
        Ship_To_Party__c sh1=new Ship_To_Party__c();
        sh1.Sold_to_Code__c='abc123';
        sh1.Distribution_Channel__c='10';
        sh1.Division__c='50';
        sh1.Account__c=ac.id;
        sh1.External_Id__c='1234';
        sh1.OwnerId=ac.OwnerId;
        insert sh1;
        account ac1=new account();
        ac1.Customer_Code__c=sh.Sold_to_Code__c;
        ac1.Account_Group__c = 'YCSP';
        ac1.Distribution_Channel__c = '20'; 
        ac1.External_ID__c='1234';
        ac1.OwnerId=u.id;
        ac1.name='testing';
        insert ac1;
        Customer_ShipToParty__c csh1=new Customer_ShipToParty__c();
        csh1.Account__c=ac.id;
        csh1.Ship_To_Party__c=sh.id;
        insert csh1;
     }
}