global class batchDistrictSchedule Implements Schedulable
{
    global void execute(SchedulableContext sc)
    {
        Integer mnth = (System.today()-1).month();
        Integer yer = (System.today()-1).year();
        String query = 'Select Brand_Short_Form__c,Distribution_Channel__c,Division__c,Sales_District__c,Month_of_Commercial_Invoice_Date__c,Year__c,District_Inv_Process__c,Qty__c,Cust_Grp1_from_Master__c from Invoice__c where CALENDAR_MONTH(Commercial_Invoice_Date_Formula__c)='+mnth+' AND CALENDAR_YEAR(Commercial_Invoice_Date_Formula__c)='+yer+' AND Commercial_Invoice_Date_Formula__c<TODAY AND District_Inv_Process__c =False';
        batchDistrictUpdate bat = new batchDistrictUpdate(query); //ur batch class
        
        database.executebatch(bat);        
    }
}