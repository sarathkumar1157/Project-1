@isTest
public class NSRCFValues_Test 
{
    public static testmethod void pdvaluestest()
    {
        String query = 'Select From_Date__c,MFG_Plant__c,Plant__c,Product__c,Storage_Location__c,To_Be_Processed__c,To_Date__c,Value__c from NSR_C_F_Value_Changes__c where CreatedDate=TODAY';
        
        Invoice__c inv = new Invoice__c();
        inv.Distribution_Channel__c = '10';
        inv.Plant__c = 'ABC';
        inv.Sales_District__c = 'Dist';
        inv.Brand_Short_Form__c = 'PSC';
        inv.Commercial_Invoice_Date__c = system.today();
        insert inv;
        
        NSR_C_F_Value_Changes__c cf = new NSR_C_F_Value_Changes__c();
        cf.Plant__c = 'ABC';
        cf.Product__c = 'PSC';
        cf.From_Date__c = System.today() - 1;
        cf.To_Date__c = System.today() + 3;
        insert cf;
        
        List<NSR_C_F_Value_Changes__c> pdlist = [Select From_Date__c,MFG_Plant__c,Plant__c,Product__c,Storage_Location__c,To_Be_Processed__c,To_Date__c,Value__c from NSR_C_F_Value_Changes__c where CreatedDate=TODAY];
        NSRCFValues bat = new NSRCFValues(query);
        bat.execute(null,pdlist);
        Database.executeBatch(bat);
    }
}