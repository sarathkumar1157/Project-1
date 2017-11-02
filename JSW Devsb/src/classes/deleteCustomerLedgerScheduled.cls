global class deleteCustomerLedgerScheduled implements Schedulable{
   /* global static void scheduleMe(String mode)
  {
    deleteCustomerLedgerScheduled msc = new deleteCustomerLedgerScheduled();
    String sch = '00 00 12 * * ?'; // base this on mode or whatever your params are
    String jobID = system.schedule('DepotStock Job', sch, msc);
  }
   */
    global void execute(SchedulableContext sc){
    Integer Year = Date.Today().Year();
    Integer month = Date.Today().Month();
   
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
  /*      
    if(month==1)
    {
    monthOfYear='January';
    }else if(month==2)
    {
    monthOfYear='February';
    }else if(month==3)
    {
    monthOfYear='March';
    }
    else if(month==4)
    {
    monthOfYear='April';
    system.debug('monthOfYear:'+monthOfYear);
    }
    else if(month==5)
    {
    monthOfYear='May';
    }
    else if(month==6)
    {
    monthOfYear='June';
    }
    else if(month==7)
    {
    monthOfYear='July';
    }
    else if(month==8)
    {
    monthOfYear='August';
    }
    else if(month==9)
    {
    monthOfYear='September';
    }else if(month==10)
    {
    monthOfYear='October';
    }else if(month==11)
    {
    monthOfYear='November';
    }else if(month==12)
    {
    monthOfYear='December';
    }*/

        //String query = 'select id from Customer_Ledger__c where Last_Date__c !=yesterday';
      //String query = 'select id from Customer_Ledger__c where Month_of_Year__c='+monthOfYear+' And Year__c='+Year;
       String query = 'select id from Customer_Ledger__c where Month_of_Year__c=\'' + monthOfYear + '\''+' And Year__c=' + Year ;
        DeleteCustomerLedger delBatch = new DeleteCustomerLedger(query);
        //delBatch.deleteCustLed();
         Id BatchProcessId = Database.ExecuteBatch(delBatch);

   //Database.Execute(delBatch);
    }
}