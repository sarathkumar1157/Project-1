global class batchTargetsSchedule Implements Schedulable
{
    global void execute(SchedulableContext sc)
    {
        Integer mnth = (System.today()-1).month();
        Integer yer = (System.today()-1).year();
        String query = 'Select Sold_To_Code__c,Distribution_Channel__c,Division__c,Plant__c,Brand_Short_Form__c,Cust_Grp1_from_Master__c,Month_of_Commercial_Invoice_Date__c,Year__c,Qty__c,Invoice_Processed__c,Plant_Short_Form__c,Sales_District__c,Commercial_Invoice_Date_Formula__c from Invoice__c where CALENDAR_MONTH(Commercial_Invoice_Date_Formula__c)='+mnth+' AND CALENDAR_YEAR(Commercial_Invoice_Date_Formula__c)='+yer+' AND Commercial_Invoice_Date_Formula__c<TODAY AND Invoice_Processed__c=false';
        
        System.debug('----'+query);
        batchTargetsUpdate bat = new batchTargetsUpdate(query); //ur batch class
        database.executebatch(bat);        
    }
}