@isTest
public class CustomerSharingRules_Test {
    public static testmethod void CustomerSharingRulesTest(){
        Account acc = new Account();
        acc.Name = 'Sample Account';
        acc.Customer_Code__c = '12345';
        insert acc;
        
        Account acc1 = new Account();
        acc1.Name = 'Sample Account1';
        acc1.Customer_Code__c = '12345';
        acc1.ParentId=acc.id;
        insert acc1;
        
        Contact con = new Contact();
        con.LastName = 'Sample Contact';
        con.Email = 'testmail@org.com';
        con.AccountId = acc.id;
        insert con;
        
        Contact con1 = new Contact();
        con1.LastName = 'Sample Contact1';
        con1.Email = 'testmail1@org.com';
        con1.AccountId = acc1.id;
        insert con1;
        
        Profile prf = [select id,name from Profile where name = 'JSW Customer'];
        
        User usr = new User(Alias = 'standt', Email='standarduser@testorg.com', ContactId = con.id, EmailEncodingKey='UTF-8',
                            LastName='Testing', LanguageLocaleKey='en_US', LocaleSidKey='en_IN', ProfileId = prf.Id, 
                            TimeZoneSidKey='Asia/Kolkata', UserName='standardmnguser@testorg.com');
        insert usr;
        
        Order__c so = new Order__c();
        so.Sold_To_Party__c = '12345';
        so.Account__c = acc.id;
        insert so;
        
        Invoice__c inv = new Invoice__c();
        inv.Sold_To_Code__c = '12345';
        inv.Account__c = acc.id;
        insert inv;
        
        Customer_Ledger__c clr = new Customer_Ledger__c();
        clr.Customer_Code__c = '12345';
        clr.Account__c = acc.id;
        insert clr;
        
        Ship_To_Party__c shp = new Ship_To_Party__c();
        shp.Sold_To_Code__c = '12345';
        shp.Account__c = acc.id;
        insert shp;
        
        Target__c trg = new Target__c();
        trg.Customer_Code__c = '12345';
        trg.Dealer_Name__c = acc.id;
        insert trg;
        
        Test.StartTest();
        CustomerSharingSchedule cus = new CustomerSharingSchedule();
        String sch = '0 15 12 * * ?'; 
        system.schedule('Test batchCustomerSharingRule Check', sch, cus);
        Test.stopTest(); 
    }
}