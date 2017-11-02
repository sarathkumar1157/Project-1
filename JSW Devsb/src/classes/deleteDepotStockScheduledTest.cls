@isTest
        private class deleteDepotStockScheduledTest{
           static testmethod void  testschedule(){
           Test.StartTest();
                list<Depot_Stock__c> depo =new list<Depot_Stock__c>();
               Depot_Stock__c dp= new Depot_Stock__c();
               insert dp;
               depo.add(dp);
              
         deleteDepotStockScheduled sh1 = new deleteDepotStockScheduled ();      
         String sch = '0  30 12 * * ?';
           system.schedule('Test', sch, sh1);
               DeleteDepotStock ds=new DeleteDepotStock('ghftrh');
               ds.execute(null,depo);
        Test.stopTest();
               
     }
    }