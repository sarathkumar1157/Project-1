global class TargetsUpdateDailyScheduler implements Schedulable{
 
    global void execute(SchedulableContext sc){
        String query = 'select id from Target__c where createdDate=YESTERDAY and Dealer_Name__c=null';

        TargetsUpdateDaily updateBatch= new TargetsUpdateDaily (query);
      
         Id BatchProcessId = Database.ExecuteBatch(updateBatch);

    }
}