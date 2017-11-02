@isTest
        private class DeleteCustomerLedgerPreviousTest{
           static testmethod void  testschedule(){
           Test.StartTest();
                list<Customer_Ledger__c> depo =new list<Customer_Ledger__c>();
               Customer_Ledger__c custled= new Customer_Ledger__c();
               insert custled;
               depo.add(custled);
         DeleteCustomerLedgerPreviousScheduled sh1 = new DeleteCustomerLedgerPreviousScheduled();      
         String sch = '0  30 12 * * ?';
           system.schedule('Test', sch, sh1);
      DeleteCustomerLedgerPrevious dld= new DeleteCustomerLedgerPrevious('test');
               dld.execute(null, depo);
        Test.stopTest();
     }
    }