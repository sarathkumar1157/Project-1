@isTest
public class StateActualsSchedule_Test 
{
    public static testMethod void testschedule() 
    {
        Test.StartTest();
        //String query = 'Select id,name,Sold_To_Code__c,Plant_Name__c,Sales_Office_Description__c,Account__c,Commercial_Invoice_Date_Formula__c,Qty__c,Plant_Short_Form__c,Brand_Short_Form__c,Sales_District__c,Month_of_Commercial_Invoice_Date__c,Year__c,Distribution_Channel__c,Division__c from Invoice__c where DAY_ONLY(CreatedDate) = '; 
        StateActualsSchedule sh1 = new StateActualsSchedule();
        String sch = '0 15 12 * * ?'; 
        system.schedule('Test StateActualsSchedule Check', sch, sh1);
        Test.stopTest(); 
    }
}