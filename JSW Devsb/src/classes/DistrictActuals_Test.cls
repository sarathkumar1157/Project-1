@isTest
public class DistrictActuals_Test 
{
	public static testmethod void distActlTest()
    {
        List<Invoice__c> invlst = new List<Invoice__c>();
        Date myDate = date.newInstance(2017,06,10);
        String query = 'Select id,name,Plant_Name__c,OwnerId,Plant__c,Territory_Dist_Code__c,Sales_Office_Code__c,Road_Invoice__c,Depot_Invoice__c,District_Actuals_Process__c,Sales_Office_Description__c,Account__c,Commercial_Invoice_Date_Formula__c,Qty__c,Plant_Short_Form__c,Sales_District__c,Brand_Short_Form__c,Sold_To_Code__c,Commercial_Invoice_Date__c,Distribution_Channel__c,Division__c,Month_of_Commercial_Invoice_Date__c,Year__c,Customer_Group_1__c,Cust_Grp1_from_Master__c,Invoice_Processed__c from Invoice__c where Day_only(CreatedDate) = TODAY';
        
        Districts__c dst = new Districts__c();
        dst.District_Code__c = 'test1';
        dst.Name = 'test dst';
        dst.District_Category__c='test';
        insert dst;
        
        District__c ter = new District__c();
        ter.Districts__c = dst.id;
        ter.Territory_Code__c = 'test';
        insert ter;
        
        MRM_Targets__c mrm = new MRM_Targets__c();
        mrm.District__c = dst.id;
        mrm.District_Code__c = 'test1';
        mrm.Month__c ='June';
        mrm.Year__c = '2017';
        mrm.Product__c = 'PSC';
        mrm.Plant__c = '3001';
        mrm.Sales_Office__c = 'test';
        insert mrm;
        
        Invoice__c inv = new Invoice__c();
        inv.Plant__c = '3333';
        inv.Plant_Short_Form__c= '3001';
        inv.Shipping_Type__c = 'Bulker';
        inv.Sales_District__c= 'test1';
        inv.Commercial_Invoice_Date__c=myDate;
        inv.Sold_To_Code__c='test';
        inv.Brand_Short_Form__c='PSC';
        inv.Qty__c = 10; 
        inv.Distribution_Channel__c = '10';
        inv.Division__c = '50';
        inv.Sales_Office__c = 'test';
        insert inv;
        
        Invoice__c inv1 = new Invoice__c();
        inv1.Plant__c = '3001';
        inv1.Plant_Short_Form__c= '3001';
        inv1.Shipping_Type__c = 'Rail transport';
        inv1.Sales_District__c= 'test1';
        inv1.Commercial_Invoice_Date__c=myDate;
        inv1.Sold_To_Code__c='test';
        inv1.Brand_Short_Form__c='PSC';
        inv1.Qty__c = 10; 
        inv1.Distribution_Channel__c = '10';
        inv1.Division__c = '50';
        inv1.Sales_Office__c = 'test';
        insert inv1;
        
        Invoice__c inv2 = new Invoice__c();
        inv2.Plant__c = '3001';
        inv2.Plant_Short_Form__c= '3001';
        inv2.Shipping_Type__c = 'Rail transport';
        inv2.Sales_District__c= 'test1';
        inv2.Commercial_Invoice_Date__c=myDate;
        inv2.Sold_To_Code__c='test';
        inv2.Brand_Short_Form__c='PSC';
        inv2.Qty__c = 10; 
        inv2.Distribution_Channel__c = '20';
        inv2.Division__c = '50';
        inv2.Sales_Office__c = 'test';
        insert inv2;
        
        List<Invoice__c> invlst1 = [Select id,name,OwnerId,Sales_Office_Code__c,Territory_Dist_Code__c,Plant_Name__c,Plant__c,Road_Invoice__c,Depot_Invoice__c,District_Actuals_Process__c,Sales_Office_Description__c,Account__c,Commercial_Invoice_Date_Formula__c,Qty__c,Plant_Short_Form__c,Sales_District__c,Brand_Short_Form__c,Sold_To_Code__c,Commercial_Invoice_Date__c,Distribution_Channel__c,Division__c,Month_of_Commercial_Invoice_Date__c,Year__c,Customer_Group_1__c,Cust_Grp1_from_Master__c,Invoice_Processed__c from Invoice__c];
        DistrictActuals bat1 = new DistrictActuals(query);
        bat1.execute(null,invlst1);
        Database.executeBatch(bat1);
    }
}