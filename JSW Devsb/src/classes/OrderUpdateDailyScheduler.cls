global class OrderUpdateDailyScheduler implements Schedulable{
 
    global void execute(SchedulableContext sc){
        String query = 'select id from order__c where createdDate=YESTERDAY and Account__c=null';

        OrderUpdateDaily updateBatch= new OrderUpdateDaily(query);
      
         Id BatchProcessId = Database.ExecuteBatch(updateBatch);

    }
}