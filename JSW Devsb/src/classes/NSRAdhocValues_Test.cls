@isTest
public class NSRAdhocValues_Test 
{
    public static testmethod void pdvaluestest()
    {
        String query = 'Select district_code__c,Product__c,distribution_Channel__c,From_Date__c,To_Date__c,Value__c,To_Be_Processed__c from Adhoc_Incentive__c where CreatedDate=TODAY';
        
        Invoice__c inv = new Invoice__c();
        inv.Distribution_Channel__c = '10';
        inv.Plant__c = 'ABC';
        inv.Sales_District__c = 'Dist';
        inv.Brand_Short_Form__c = 'PSC';
        inv.Commercial_Invoice_Date__c = system.today();
        insert inv;
        
        Adhoc_Incentive__c pd = new Adhoc_Incentive__c();
        Pd.Distribution_Channel__c = '10';
        pd.District_Code__c = 'Dist';
        pd.Product__c = 'PSC';
        pd.From_Date__c = System.today() - 1;
        pd.To_Date__c = System.today() + 3;
        insert pd;
        
        List<Adhoc_Incentive__c> pdlist = [Select district_code__c,Product__c,distribution_Channel__c,From_Date__c,To_Date__c,Value__c,To_Be_Processed__c from Adhoc_Incentive__c where CreatedDate=TODAY];
        NSRAdhocValues bat = new NSRAdhocValues(query);
        bat.execute(null,pdlist);
        Database.executeBatch(bat);
    }
}