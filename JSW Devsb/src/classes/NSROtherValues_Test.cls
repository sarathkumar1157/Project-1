@isTest
public class NSROtherValues_Test 
{
    public static testmethod void pdvaluestest()
    {
        String query = 'Select distribution_Channel__c,District_Code__c,From_Date__c,Other_Value__c,Product__c,To_Be_Processed__c,To_Date__c from NSR_Other_Values__c where CreatedDate=TODAY';
        
        Invoice__c inv = new Invoice__c();
        inv.Distribution_Channel__c = '10';
        inv.Plant__c = 'ABC';
        inv.Sales_District__c = 'Dist';
        inv.Brand_Short_Form__c = 'PSC';
        inv.Commercial_Invoice_Date__c = system.today();
        insert inv;
        
        NSR_Other_Values__c othr = new NSR_Other_Values__c();
        Othr.Distribution_Channel__c = '10';
        othr.District_Code__c = 'Dist';
        othr.Product__c = 'PSC';
        othr.From_Date__c = System.today() - 1;
        othr.To_Date__c = System.today() + 3;
        insert othr;
        
        List<NSR_Other_Values__c> pdlist = [Select distribution_Channel__c,District_Code__c,From_Date__c,Other_Value__c,Product__c,To_Be_Processed__c,To_Date__c from NSR_Other_Values__c where CreatedDate=TODAY];
        NSROtherValues bat = new NSROtherValues(query);
        bat.execute(null,pdlist);
        Database.executeBatch(bat);
    }
}