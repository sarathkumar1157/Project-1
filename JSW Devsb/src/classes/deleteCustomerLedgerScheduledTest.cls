@isTest
        private class deleteCustomerLedgerScheduledTest{
           static testmethod void  testschedule(){
           Test.StartTest();
                list<Customer_Ledger__c> depo =new list<Customer_Ledger__c>();
               Customer_Ledger__c custled= new Customer_Ledger__c();
               insert custled;
               depo.add(custled);
         deleteCustomerLedgerScheduled  sh1 = new deleteCustomerLedgerScheduled();      
         String sch = '0  30 12 * * ?';
           system.schedule('Test', sch, sh1);
      DeleteCustomerLedger dld= new DeleteCustomerLedger('test');
               dld.execute(null, depo);
        Test.stopTest();
     }
    }