global class InvoiceUpdateDailyScheduler implements Schedulable{
 
    global void execute(SchedulableContext sc){
        String query = 'select id from Invoice__c where createdDate=YESTERDAY and Account__c=null';

        InvoiceUpdateDaily updateBatch= new InvoiceUpdateDaily(query);
      
         Id BatchProcessId = Database.ExecuteBatch(updateBatch);

    }
}