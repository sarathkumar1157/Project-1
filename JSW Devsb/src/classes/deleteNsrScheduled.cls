global class deleteNsrScheduled implements Schedulable{
   /* global static void scheduleMe(String mode)
  {
    deleteNsrScheduled msc = new deleteNsrScheduled ();
    String sch = '00 00 12 * * ?'; // base this on mode or whatever your params are
    String jobID = system.schedule('DepotStock Job', sch, msc);
  }*/
   
    global void execute(SchedulableContext sc){
       String query = 'select id from nsr__c';
        DeleteNsr delBatch = new DeleteNsr(query);
       // delBatch.deleteNsr();
        Id BatchProcessId = Database.ExecuteBatch(delBatch);
 
    }
}