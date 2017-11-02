@isTest
        private class OrderUpdateDailyScheduledTest{
           static testmethod void  testschedule(){
           Test.StartTest();
                list<Order__c> depo =new list<Order__c>();
               Order__c custled= new Order__c();
               insert custled;
               depo.add(custled);
         OrderUpdateDailyScheduler sh1 = new OrderUpdateDailyScheduler ();      
         String sch = '0  30 12 * * ?';
           system.schedule('Test', sch, sh1);
      OrderUpdateDaily dld= new OrderUpdateDaily('test');
               dld.execute(null, depo);
        Test.stopTest();
     }
    }