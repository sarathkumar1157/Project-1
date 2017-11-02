global class deleteDepotStockScheduled implements Schedulable{
   /* global static void scheduleMe(String mode)
  {
    deleteDepotStockScheduled msc = new deleteDepotStockScheduled ();
    String sch = '00 00 12 * * ?'; // base this on mode or whatever your params are
    String jobID = system.schedule('DepotStock Job', sch, msc);
  }
   */
    global void execute(SchedulableContext sc){
     
       String query = 'select id from Depot_Stock__c';
        DeleteDepotStock delBatch = new DeleteDepotStock(query);
      
   Id BatchProcessId = Database.ExecuteBatch(delBatch);
    }
}