@isTest
public class batchTargetsUpdateTest
{
    public static testmethod void batchtest()
    {
        List<Invoice__c> invlst = new List<Invoice__c>();
        Date myDate = date.newInstance(2017,01,01);
        Date myDate1 = date.newInstance(2017,01,01);
        String query = 'Select id,name,Plant_Name__c,Sales_Office_Description__c,Account__c,Commercial_Invoice_Date_Formula__c,Qty__c,Plant_Short_Form__c,Sales_District__c,Brand_Short_Form__c,Sold_To_Code__c,Commercial_Invoice_Date__c,Distribution_Channel__c,Division__c,Month_of_Commercial_Invoice_Date__c,Year__c,Customer_Group_1__c,Cust_Grp1_from_Master__c,Plant__c from Invoice__c where CreatedDate=TODAY'; 
        String query1 = 'Select id,name,Plant_Name__c,NSR_T_Value__c,Sales_Office_Description__c,Account__c,Commercial_Invoice_Date_Formula__c,Qty__c,Plant_Short_Form__c,Sales_District__c,Brand_Short_Form__c,Sold_To_Code__c,Commercial_Invoice_Date__c,Distribution_Channel__c,Division__c,Month_of_Commercial_Invoice_Date__c,Year__c,Customer_Group_1__c,Cust_Grp1_from_Master__c,Plant__c from Invoice__c where CreatedDate=TODAY'; 
        Account ac = new Account(name='test',Customer_Code__c='test');
        ac.Distribution_Channel__c = '10';
        ac.Division__c = '50';
        insert ac;
        for(integer i=1;i<=12;i++)
		{
            Invoice__c inv = new Invoice__c();
            //inv.Plant_Short_Form__c= 'test';
            inv.Sales_District__c= 'test';
            inv.Commercial_Invoice_Date__c=myDate+28;
            inv.Sold_To_Code__c='test';
            inv.Brand_Short_Form__c='PSC';
            inv.Account__c = ac.id;
            inv.Qty__c = 10; 
            inv.Distribution_Channel__c = '10';
            inv.Division__c = '50';
            invlst.add(inv);
            myDate = myDate+28;
        }
        Invoice__c inv1 = new Invoice__c();
        //inv.Plant_Short_Form__c= 'test';
        inv1.Sales_District__c= 'test1';
        inv1.Commercial_Invoice_Date__c=myDate;
        inv1.Sold_To_Code__c='test';
        inv1.Brand_Short_Form__c='PSC';
        inv1.Account__c = ac.id;
        inv1.Qty__c = 10; 
        inv1.Distribution_Channel__c = '10';
        inv1.Division__c = '50';
        insert invlst;
                
        List<Invoice__c> invlst1 = [Select id,name,NSR_T_Value__c,Plant_Name__c,Distribution_Channel__c,plant__c,Sales_Office_Description__c,Account__c,Commercial_Invoice_Date_Formula__c,Qty__c,Plant_Short_Form__c,Brand_Short_Form__c,Sales_District__c,Division__c,Month_of_Commercial_Invoice_Date__c,Year__c,Sold_To_Code__c,Cust_Grp1_from_Master__c from Invoice__c];
        //invlst.add(inv);
        batchTargetsUpdate bat = new batchTargetsUpdate(query1);
        bat.execute(null,invlst1);
        Database.executeBatch(bat);
        
        batchTargetsUpdateDelete bat1 = new batchTargetsUpdateDelete(query1);
        bat1.execute(null,invlst1);
        Database.executeBatch(bat1);
                
    }
}