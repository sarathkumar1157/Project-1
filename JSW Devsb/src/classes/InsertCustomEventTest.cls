@isTest
public class InsertCustomEventTest 
{
    public static testmethod void cusevnt()
    {
        Date myDate = System.today();
        Event evnt = new Event();
        evnt.Subject = 'Test Event Subject';
        evnt.Budget__c = 1000;
        evnt.Event__c = myDate;
        evnt.No_Of_Invitees_for_Each_Meet__c = 20;
        evnt.Product__c = 'PSC';
        evnt.Type_of_Meet__c = 'Mason meet';
        evnt.DurationInMinutes = 30;
        evnt.ActivityDateTime = System.now();
        insert evnt;
    }
}