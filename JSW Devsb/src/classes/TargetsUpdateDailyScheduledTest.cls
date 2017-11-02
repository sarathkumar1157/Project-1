@isTest
        private class TargetsUpdateDailyScheduledTest{
           static testmethod void  testschedule(){
           Test.StartTest();
                list<Target__c> depo =new list<Target__c>();
               Target__c custled= new Target__c();
               insert custled;
               depo.add(custled);
         TargetsUpdateDailyScheduler sh1 = new TargetsUpdateDailyScheduler();      
         String sch = '0  30 12 * * ?';
           system.schedule('Test', sch, sh1);
     TargetsUpdateDaily dld= new TargetsUpdateDaily('test');
               dld.execute(null, depo);
        Test.stopTest();
     }
    }