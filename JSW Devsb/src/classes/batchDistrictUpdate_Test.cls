@isTest
public class batchDistrictUpdate_Test 
{
    public static testmethod void batchtest()
    {
        List<Invoice__c> invlst = new List<Invoice__c>();
		Date myDate = date.newInstance(2017,01,01);
        Date myDate1 = date.newInstance(2017,01,01);
        Date myDate2 = date.newInstance(2017,01,01);
        String query1 = 'Select id,name,Plant_Name__c,Plant__c,Sales_Office_Description__c,Account__c,Commercial_Invoice_Date_Formula__c,Qty__c,Plant_Short_Form__c,Sales_District__c,Brand_Short_Form__c,Sold_To_Code__c,Commercial_Invoice_Date__c,Distribution_Channel__c,Division__c,Month_of_Commercial_Invoice_Date__c,Year__c,Customer_Group_1__c,Cust_Grp1_from_Master__c from Invoice__c where CREATEDDATE=TODAY'; 
        for(integer i=1;i<=12;i++)
		{
			Invoice__c inv = new Invoice__c();
			//inv.Plant_Short_Form__c= 'test';
			inv.Sales_District__c= 'test1';
			inv.Commercial_Invoice_Date__c=myDate+30;
			inv.Sold_To_Code__c='test';
			inv.Brand_Short_Form__c='PSC';
			inv.Qty__c = 10; 
			inv.Distribution_Channel__c = '10';
			inv.Division__c = '50';
			invlst.add(inv);
            myDate = myDate+30;
		}
		for(integer i=1;i<=12;i++)
		{
			Invoice__c inv = new Invoice__c();
			//inv.Plant_Short_Form__c= 'test';
			inv.Sales_District__c= 'test1';
			inv.Commercial_Invoice_Date__c=myDate1+30;
			inv.Sold_To_Code__c='test';
			inv.Brand_Short_Form__c='CHD';
			inv.Qty__c = 10; 
			inv.Distribution_Channel__c = '20';
			inv.Division__c = '50';
			inv.Customer_Group_1__c = 'N01-INSTITUTIONS';
			invlst.add(inv);
            myDate1 = myDate1+30;
		}
		for(integer i=1;i<=12;i++)
		{
			Invoice__c inv = new Invoice__c();
			//inv.Plant_Short_Form__c= 'test';
			inv.Sales_District__c= 'test2';
			inv.Commercial_Invoice_Date__c=myDate2+30;
			inv.Sold_To_Code__c='test';
			inv.Brand_Short_Form__c='PSC';
			inv.Qty__c = 10; 
			inv.Distribution_Channel__c = '50';
			inv.Division__c = '50';
			inv.Customer_Group_1__c = 'N01-INSTITUTIONS';
			invlst.add(inv);
            myDate2 = myDate2+30;
		}
        System.debug('-----'+invlst);
		insert invlst;
        
        List<Invoice__c> invlst1 = [Select id,name,Plant_Name__c,Plant__c,Distribution_Channel__c,Sales_Office_Description__c,Account__c,Commercial_Invoice_Date_Formula__c,Qty__c,Plant_Short_Form__c,Customer_Group_1__c,Brand_Short_Form__c,Sales_District__c,Division__c,Month_of_Commercial_Invoice_Date__c,Year__c,Sold_To_Code__c,Cust_Grp1_from_Master__c from Invoice__c];
        batchDistrictUpdate bat1 = new batchDistrictUpdate(query1);
        bat1.execute(null,invlst1);
        Database.executeBatch(bat1);
        
        batchDistrictUpdateDelete bat = new batchDistrictUpdateDelete(query1);
        bat.execute(null,invlst1);
        Database.executeBatch(bat);
    }
}