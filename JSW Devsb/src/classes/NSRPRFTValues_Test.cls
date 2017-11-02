@isTest
public class NSRPRFTValues_Test 
{
    public static testmethod void prftvaluestest()
    {
        String query = 'Select From_Date__c,MFG_Plant__c,Plant__c,PRFT_Value__c,Product__c,Storage_Location__c,To_Be_Processed__c,To_Date__c from NSR_PRFT_Values__c where CreatedDate=TODAY';
        
        Invoice__c inv = new Invoice__c();
        inv.Distribution_Channel__c = '10';
        inv.Plant__c = 'ABC';
        inv.Sales_District__c = 'Dist';
        inv.Brand_Short_Form__c = 'PSC';
        inv.Commercial_Invoice_Date__c = system.today();
        insert inv;
        
        NSR_PRFT_Values__c prft = new NSR_PRFT_Values__c();
        prft.Plant__c = 'ABC';
        prft.Product__c = 'PSC';
        prft.From_Date__c = System.today() - 1;
        prft.To_Date__c = System.today() + 3;
        insert prft;
        
        List<NSR_PRFT_Values__c> pdlist = [Select From_Date__c,MFG_Plant__c,Plant__c,PRFT_Value__c,Product__c,Storage_Location__c,To_Be_Processed__c,To_Date__c from NSR_PRFT_Values__c where CreatedDate=TODAY];
        NSRPRFTValues bat = new NSRPRFTValues(query);
        bat.execute(null,pdlist);
        Database.executeBatch(bat);
    }
}