@isTest
public class populateOrderRequestTest {
    public static testmethod void orderMethod(){
        account ac=new account();
        ac.name='test';
        insert ac;
        Order_Request__c orq=new Order_Request__c();
        orq.Order_Request_Header__c = '1234';
        orq.Satus_Message__c = 'okay';
        orq.Account__c=ac.id;
        orq.Status__c = 'Good';
        orq.SO_Number__c = '1234';
        insert orq;
        orq.Contact_Number__c='56456';
        update orq;
        Order_Booking_Line__c obl=new Order_Booking_Line__c();
        obl.Order_Request__c = orq.id;
        insert obl;
        Order_Booking_Schedule__c obs=new Order_Booking_Schedule__c();
        obs.Order_Request__c = orq.id;
        obs.Schedule_Date__c = System.today();
        obs.Schedule_Qty__c = '100';
        obs.Order_Booking_Line_Item__c = obl.id;
        insert obs;
        Order_Request__c ordr = [select Order_Request_Header__c,Satus_Message__c,Status__c,SO_Number__c from Order_Request__c where id=:orq.id];
        ordr.Satus_Message__c = 'Okay 2';
        Update ordr;
    }
}