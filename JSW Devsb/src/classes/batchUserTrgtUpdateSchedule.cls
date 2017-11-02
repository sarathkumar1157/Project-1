global class batchUserTrgtUpdateSchedule Implements Schedulable
{
    global void execute(SchedulableContext sc)
    {
        Integer mnth = (System.today()-1).month();
        Integer yer = (System.today()-1).YEAR();
        String query = 'Select Distribution_Channel__c,OwnerId,Month_of_Commercial_Invoice_Date__c,Year__c,Brand_Short_Form__c,Qty__c,Commercial_Invoice_Date_Formula__c,User_Inv_Processed__c from Invoice__c where CALENDAR_MONTH(Commercial_Invoice_Date_Formula__c)='+mnth+' AND CALENDAR_YEAR(Commercial_Invoice_Date_Formula__c)='+yer+' AND Commercial_Invoice_Date_Formula__c<TODAY AND User_Inv_Processed__c=False';
         batchUserTrgtUpdate bat = new batchUserTrgtUpdate(query); //ur batch class
         database.executebatch(bat);        
    }
}