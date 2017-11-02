@isTest
public class batchAccountUpdateTest
{
    public static testmethod void batchtest()
    {
        Date myDate = system.today();
        String query = 'Select id,name,Sold_To_Code__c,Plant_Name__c,Sales_Office_Description__c,Account__c,Commercial_Invoice_Date_Formula__c,Qty__c,Plant_Short_Form__c,Brand_Short_Form__c,Sales_District__c,Month_of_Commercial_Invoice_Date__c,Year__c,Distribution_Channel__c,Division__c from Invoice__c where Account__c != null'; 
        Account ac = new Account(name='test',Customer_Code__c='test');insert ac;
        Invoice__c inv = new Invoice__c();
        inv.Plant_Short_Form__c= 'test';
        inv.Sales_District__c= 'test';
        inv.Commercial_Invoice_Date__c=myDate;
        inv.Sold_To_Code__c='test';
        inv.Brand_Short_Form__c='PSC';
        inv.Account__c = ac.id;
        inv.Qty__c = 10; 
        insert inv;
        List<Invoice__c> invlst = [Select id,name,Plant_Name__c,Distribution_Channel__c,Sales_Office_Description__c,Account__c,Commercial_Invoice_Date_Formula__c,Qty__c,Plant_Short_Form__c,Brand_Short_Form__c,Sales_District__c,Division__c,Month_of_Commercial_Invoice_Date__c,Year__c,Sold_To_Code__c from Invoice__c where id=:inv.Id];
        //invlst.add(inv);
        batchAccountUpdate bat = new batchAccountUpdate(query);
        bat.execute(null,invlst);
        Database.executeBatch(bat);
        
    }
}