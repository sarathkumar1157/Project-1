@istest
public class createUnplanedVisitTest 
{
    public static testmethod void unplnvst()
    {
        
        String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'Visit_Report__c' and Name = 'Daily Call Report'].Id;
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'standt', Email='standard123@testorg123.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser123@test123.com');
        
        System.runAs(u){
        Date myDate = system.today();
        Account ac = new Account(name='test');
        insert ac;
        Day_Plan__c dp = new Day_Plan__c(name='test dp',Date__c=myDate,User__c=u.id);
        insert dp;
        Visit__c vst = new Visit__c();
        vst.Account__c = ac.id;
        insert vst;
        Visit_Report__c vrp = new Visit_Report__c();
        vrp.Visit__c = vst.Id;
        //vrp.RecordTypeId = strRecordTypeId;
        vrp.Name_of_Customer_Influencer__c = 'test infln';
        vrp.Customer_influencer_Email_ID__c = 'test@test.com';
        vrp.Customer_influencer_Mobile_No__c = '9999999999';
        vrp.Type_of_Customer_Influencer__c = 'Eng';
        insert vrp;
        Visit_Report__c vrp1 = new Visit_Report__c();
        vrp1.Account__c = ac.id;
        vrp1.Name_of_Customer_Influencer__c = 'test inflncr';
        vrp1.Customer_influencer_Email_ID__c = 'test1@test1.com';
        vrp1.Customer_influencer_Mobile_No__c = '8888888888';
        vrp1.Type_of_Customer_Influencer__c = 'Architect';
        insert vrp1;
    }
    }
}