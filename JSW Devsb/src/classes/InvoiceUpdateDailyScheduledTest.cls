@isTest
        private class InvoiceUpdateDailyScheduledTest{
           static testmethod void  testschedule(){
           Test.StartTest();
                list<Invoice__c> depo =new list<Invoice__c>();
               Invoice__c custled= new Invoice__c();
               insert custled;
               depo.add(custled);
         InvoiceUpdateDailyScheduler sh1 = new InvoiceUpdateDailyScheduler();      
         String sch = '0  30 12 * * ?';
           system.schedule('Test', sch, sh1);
     InvoiceUpdateDaily dld= new InvoiceUpdateDaily('test');
               dld.execute(null, depo);
        Test.stopTest();
     }
    }