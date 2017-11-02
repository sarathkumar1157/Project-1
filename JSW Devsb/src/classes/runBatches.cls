global class runBatches{
   @InvocableMethod
   public static void runBatches(List<String> details) 
   {
       /*if(batchname = 'NSRPDClass')
       {
           String query = 'Select district_code__c,Product__c,distribution_Channel__c,From_Date__c,To_Date__c,PD_Value__c,To_Be_Processed__c from NSR_PD_Values__c where From_Date__c>='+fromdate+' AND To_Date__c<='+todate+'';
           NSRPDValues bat = new NSRPDValues(query);
           Database.executeBatch(bat,1);
       }  */
       System.debug('List'+details); 
   }
}