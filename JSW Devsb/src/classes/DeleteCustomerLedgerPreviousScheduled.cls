global class DeleteCustomerLedgerPreviousScheduled implements Schedulable{
  
    global void execute(SchedulableContext sc){
    Integer Year = Date.Today().Year();
    Integer month = Date.Today().Month()-1;
   
        Map<Integer,String>MonthMap2 = new Map<Integer,String>();
         MonthMap2.put(1,'January');
        MonthMap2.put(2,'February');
        MonthMap2.put(3,'March');
        MonthMap2.put(4,'April');
        MonthMap2.put(5,'May');
        MonthMap2.put(6,'June');
        MonthMap2.put(7,'July');
        MonthMap2.put(8,'August');
        MonthMap2.put(9,'September');
        MonthMap2.put(10,'October');
        MonthMap2.put(11,'November');
        MonthMap2.put(12,'December');
       String monthOfYear=MonthMap2.get(month);
 
       String query = 'select id from Customer_Ledger__c where Month_of_Year__c=\'' + monthOfYear + '\''+' And Year__c=' + Year ;
        DeleteCustomerLedgerPrevious delBatch = new DeleteCustomerLedgerPrevious(query);
       
         Id BatchProcessId = Database.ExecuteBatch(delBatch);

   
    }
}