@isTest
        private class deleteNsrScheduledTest{
           static testmethod void  testschedule(){
           Test.StartTest();
                list<nsr__c> depo =new list<nsr__c>();
               nsr__c nsr= new nsr__c();
               insert nsr;
               depo.add(nsr);
         deleteNsrScheduled sh1 = new deleteNsrScheduled();      
         String sch = '0  30 12 * * ?';
           system.schedule('Test', sch, sh1);
               DeleteNsr dn=new DeleteNsr('test');
               dn.execute(null, depo);
        Test.stopTest();
               
     }
    
}