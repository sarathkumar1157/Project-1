@isTest
public class NSRIDValues_Test 
{
    public static testmethod void pdvaluestest()
    {
        String query = 'Select Commercial_Invoice_Number__c,Invoice_Discount_Value__c,To_Be_Processed__c from Invoice_Discounts__c where CreatedDate=TODAY';
        
        Invoice__c inv = new Invoice__c();
        inv.Distribution_Channel__c = '10';
        inv.Plant__c = 'ABC';
        inv.Sales_District__c = 'Dist';
        inv.Brand_Short_Form__c = 'PSC';
        inv.Commercial_Invoice_Date__c = system.today();
        inv.Commercial_Invoice_Number__c = '1234';
        insert inv;
        
        Invoice_Discounts__c pd = new Invoice_Discounts__c();
        pd.Commercial_Invoice_Number__c = '1234';
        pd.Invoice_Discount_Value__c = 100;
        insert pd;
        
        List<Invoice_Discounts__c> pdlist = [Select Commercial_Invoice_Number__c,Invoice_Discount_Value__c,To_Be_Processed__c from Invoice_Discounts__c where CreatedDate=TODAY];
        NSRIDValues bat = new NSRIDValues(query);
        bat.execute(null,pdlist);
        Database.executeBatch(bat);
    }
}