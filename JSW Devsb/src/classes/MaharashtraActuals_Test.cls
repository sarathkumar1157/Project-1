@isTest
public class MaharashtraActuals_Test 
{
	public static testmethod void distActlTest()
    {
        List<Invoice__c> invlst = new List<Invoice__c>();
        Date myDate = date.newInstance(2017,06,10);
        String query = 'Select id,name,Plant_Name__c,Plant__c,Ship_To_District__c,Sales_Office_Code__c,Road_Invoice__c,Depot_Invoice__c,District_Actuals_Process__c,Sales_Office_Description__c,Account__c,Commercial_Invoice_Date_Formula__c,Qty__c,Plant_Short_Form__c,Sales_District__c,Brand_Short_Form__c,Sold_To_Code__c,Commercial_Invoice_Date__c,Distribution_Channel__c,Division__c,Month_of_Commercial_Invoice_Date__c,Year__c,Customer_Group_1__c,Cust_Grp1_from_Master__c,Invoice_Processed__c from Invoice__c where Day_only(CreatedDate) = TODAY';
        
        Districts__c dst = new Districts__c();
        dst.District_Code__c = 'test1';
        dst.Name = 'test dst';
        dst.District_Category__c='test';
        insert dst;
        
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
        inv.Ship_To_District__c= 'test1';
        inv.Commercial_Invoice_Date__c=myDate;
        inv.Sold_To_Code__c='test';
        inv.Brand_Short_Form__c='PSC';
        inv.Qty__c = 10; 
        inv.Distribution_Channel__c = '10';
        inv.Division__c = '50';
        inv.Sales_Office__c = 'test';
        inv.Total_value__c = 500;
        inv.Packing_Cost__c = 10;
        inv.Freight__c = 20;
        inv.MMC__c = 35;
        //inv.NSR_T_Value__c = 10;
        insert inv;
        
        Invoice__c inv1 = new Invoice__c();
        inv1.Plant__c = '3001';
        inv1.Plant_Short_Form__c= '3001';
        inv1.Shipping_Type__c = 'Rail transport';
        inv1.Sales_District__c= 'test1';
        inv1.Ship_To_District__c= 'test1';
        inv1.Commercial_Invoice_Date__c=myDate;
        inv1.Sold_To_Code__c='test';
        inv1.Brand_Short_Form__c='PSC';
        inv1.Qty__c = 10; 
        inv1.Distribution_Channel__c = '10';
        inv1.Division__c = '50';
        inv1.Sales_Office__c = 'test';
        inv1.Total_value__c = 500;
        inv1.Packing_Cost__c = 10;
        inv1.Freight__c = 20;
        inv1.MMC__c = 35;
        insert inv1;
        
        Invoice__c inv2 = new Invoice__c();
        inv2.Plant__c = '3001';
        inv2.Plant_Short_Form__c= '3001';
        inv2.Shipping_Type__c = 'Rail transport';
        inv2.Sales_District__c= 'test1';
        inv2.Ship_To_District__c= 'test1';
        inv2.Commercial_Invoice_Date__c=myDate;
        inv2.Sold_To_Code__c='test';
        inv2.Brand_Short_Form__c='PSC';
        inv2.Qty__c = 10; 
        inv2.Distribution_Channel__c = '20';
        inv2.Division__c = '50';
        inv2.Sales_Office__c = 'test';
        inv2.Total_value__c = 500;
        inv2.Packing_Cost__c = 10;
        inv2.NSR_C_F_Value__c = 15;
        inv2.Freight__c = 20;
        inv2.MMC__c = 35;
        insert inv2;
        
        Invoice__c inv3 = new Invoice__c();
        inv3.Plant__c = '3001';
        inv3.Plant_Short_Form__c= '3001';
        inv3.Shipping_Type__c = 'Rail transport';
        inv3.Sales_District__c= 'test1';
        inv3.Ship_To_District__c= 'test1';
        inv3.Commercial_Invoice_Date__c=myDate;
        inv3.Sold_To_Code__c='test';
        inv3.Brand_Short_Form__c='PSC';
        inv3.Qty__c = 10; 
        inv3.Distribution_Channel__c = '20';
        inv3.Division__c = '50';
        inv3.Sales_Office__c = 'test';
        inv3.Total_value__c = 500;
        insert inv3;
        List<Invoice__c> invlst1 = [Select id,name,Sales_Office_Code__c,Ship_To_District__c,Plant_Name__c,Plant__c,Road_Invoice__c,Depot_Invoice__c,District_Actuals_Process__c,Sales_Office_Description__c,Account__c,Commercial_Invoice_Date_Formula__c,Qty__c,Plant_Short_Form__c,Sales_District__c,Brand_Short_Form__c,Sold_To_Code__c,Commercial_Invoice_Date__c,Distribution_Channel__c,Division__c,Month_of_Commercial_Invoice_Date__c,Year__c,Customer_Group_1__c,Cust_Grp1_from_Master__c,Invoice_Processed__c,Total_value__c,MMC__c,NSR_PD__c,Packing_Cost__c,Freight__c,Total_Adhoc_Discount__c,NSR_C_F_Discount__c,NSR_PRFT_Dump_Discout__c from Invoice__c];
        MaharashtraActuals bat1 = new MaharashtraActuals(query);
        bat1.execute(null,invlst1);
        Database.executeBatch(bat1);
    }
}