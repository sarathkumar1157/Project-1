@isTest
public class RouteMapExtensionTest 
{
    public static testmethod void rtmap()
    {
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'standt', Email='standard1234@testorg1234.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser1234@test1234.com');
        Date myDate = system.today();
        Account ac = new Account(name='test');
        insert ac;
        Day_Plan__c dp = new Day_Plan__c(name='test dp',Date__c=myDate,User__c=u.id);
        insert dp;
        ApexPages.StandardController sc = new ApexPages.StandardController(dp);
        RouteMapExtension rme = new RouteMapExtension(sc);
        RouteMapExtension.getDetails(dp.id);
        RouteMapExtension.getDetailsBasedOnCreatedDate(dp.id);
    }
}