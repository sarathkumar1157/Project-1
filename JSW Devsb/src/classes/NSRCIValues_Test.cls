@isTest
public class NSRCIValues_Test 
{
    public static testmethod void pdvaluestest()
    {
        String query = 'Select Customer_Code__c,Distribution_Channel__c,District_Code__c,From_Date__c,Product__c,To_Date__c,To_Be_Processed__c,Value__c from Customer_Incentive__c where CreatedDate=TODAY';
        
        Invoice__c inv = new Invoice__c();
        inv.Distribution_Channel__c = '10';
        inv.Plant__c = 'ABC';
        inv.Sales_District__c = 'Dist';
        inv.Brand_Short_Form__c = 'PSC';
        inv.Sold_To_Code__c = 'xyz';
        inv.Commercial_Invoice_Date__c = system.today();
        insert inv;
        
        Customer_Incentive__c ci = new Customer_Incentive__c();
        ci.Customer_Code__c = 'xyz';
        ci.Product__c = 'PSC';
        ci.Distribution_Channel__c = '10';
        insert ci;
        
        List<Customer_Incentive__c> pdlist = [Select Customer_Code__c,Distribution_Channel__c,District_Code__c,From_Date__c,Product__c,To_Date__c,To_Be_Processed__c,Value__c from Customer_Incentive__c where CreatedDate=TODAY];
        NSRCIValues bat = new NSRCIValues(query);
        bat.execute(null,pdlist);
        Database.executeBatch(bat);
    }
}