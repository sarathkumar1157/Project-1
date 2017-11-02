@isTest
public class NSRActuals_Test 
{
	public static testmethod void nsrActlTest()
    {
        List<Invoice__c> invlst = new List<Invoice__c>();
        Date myDate = date.newInstance(2017,06,10);
        String query = 'Select Total_value__c,NSR_PD_Value__c,NSR_Other_Discount__c,NSR_PRFT_Dump_Discout__c,NSR_C_F_Discount__c,Packing_Cost__c,Freight__c,Total_Tax__c,NSR_Rake_Discount__c,Adhoc_Incentive_Value__c,MMC__c,Qty__c,NSR_T_Value__c,NSR_Targets_Processed__c,Sales_Office_Code__c,Brand_Short_Form__c,Month_of_Commercial_Invoice_Date__c,Year__c,Plant_Short_Form__c,Commercial_Invoice_Date_Formula__c,Distribution_Channel__c from Invoice__c where Day_only(CreatedDate) = TODAY';
        
        Districts__c dst = new Districts__c();
        dst.District_Code__c = 'test1';
        dst.District_Category__c='test';
        dst.Name = 'test dst';
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
        
        NSR_New_Targets__c nsr = new NSR_New_Targets__c();
        nsr.District_Code__c = 'test1';
        nsr.Distribution_Channel__c = 10;
        nsr.Product_Group__c = 'PSC';
        nsr.Plant_Short_Form__c = '3001';
        nsr.Quantity__c = 10;
        nsr.C_F_Value__c = 11;
        nsr.Commercial_Invoice_Date__c = myDate;
        nsr.Discount__c = 12;
        nsr.Discount_Value__c = 13;
        nsr.Frieght__c = 14;
        nsr.Total_Basic_Price__c = 15;
        nsr.Toatl_Value__c = 16;
        nsr.PD_SPL_ADDL__c = 17;
        nsr.Packing_Cost__c = 18;
        nsr.MMC__c = 19;
        nsr.NSR_Value__c = 20;
        nsr.PRFT_Dump_Value__c = 21;
        nsr.Other__c = 22;
        insert nsr;
        
        NSR_New_Targets__c nsr1 = new NSR_New_Targets__c();
        nsr1.District_Code__c = 'test1';
        nsr1.Distribution_Channel__c = 20;
        nsr1.Product_Group__c = 'PSC';
        nsr1.Plant_Short_Form__c = '3001';
        nsr1.Quantity__c = 10;
        nsr1.C_F_Value__c = 11;
        nsr1.Commercial_Invoice_Date__c = myDate;
        nsr1.Discount__c = 12;
        nsr1.Discount_Value__c = 13;
        nsr1.Frieght__c = 14;
        nsr1.Total_Basic_Price__c = 15;
        nsr1.Toatl_Value__c = 16;
        nsr1.PD_SPL_ADDL__c = 17;
        nsr1.Packing_Cost__c = 18;
        nsr1.MMC__c = 19;
        nsr1.NSR_Value__c = 20;
        nsr1.PRFT_Dump_Value__c = 21;
        nsr1.Other__c = 22;
        insert nsr1;
        
        Invoice__c inv = new Invoice__c();
        inv.Plant__c = '3333';
        inv.Plant_Short_Form__c= '3001';
        inv.Shipping_Type__c = 'Bulker';
        inv.Sales_District__c= 'test1';
        inv.NSR_PD_Value__c = 10;
        inv.NSR_C_F_Value__c =20;
        inv.NSR_Other_Value__c = 10;
        inv.NSR_PRFT_Value__c = 20;
        inv.Total_tax__c = 10;
        inv.Total_value__c = 20;
        inv.PAcking_Cost__c = 10;
        inv.Freight__c = 10;
        inv.Adhoc_Incentive_Value__c  = 10;
        inv.MMC__c = 10;
        inv.Commercial_Invoice_Date__c=myDate;
        inv.Sold_To_Code__c='test';
        inv.Brand_Short_Form__c='PSC';
        inv.Qty__c = 10; 
        inv.Distribution_Channel__c = '10';
        inv.Division__c = '50';
        inv.Sales_Office__c = 'test';
        insert inv;
        Invoice__c inv1 = new Invoice__c();
        inv1.Plant__c = '3333';
        inv1.Plant_Short_Form__c= '3001';
        inv1.Shipping_Type__c = 'Bulker';
        inv1.Sales_District__c= 'test1';
        inv1.NSR_PD_Value__c = 10;
        inv1.NSR_C_F_Value__c =20;
        inv1.NSR_Other_Value__c = 10;
        inv1.NSR_PRFT_Value__c = 20;
        inv1.PAcking_Cost__c = 15;
        inv1.Total_tax__c = 10;
        inv1.Total_value__c = 20;
        inv1.Freight__c = 15;
        inv1.Adhoc_Incentive_Value__c  = 10;
        inv1.MMC__c = 19;
        inv1.Commercial_Invoice_Date__c=myDate;
        inv1.Sold_To_Code__c='test';
        inv1.Brand_Short_Form__c='PSC';
        inv1.Qty__c = 10; 
        inv1.Distribution_Channel__c = '20';
        inv1.Division__c = '50';
        inv1.Sales_Office__c = 'test';
        insert inv1;
        
        List<Invoice__c> nsrlst1 = [Select Total_value__c,NSR_PD_Value__c,NSR_Other_Discount__c,NSR_PRFT_Dump_Discout__c,NSR_C_F_Discount__c,Packing_Cost__c,Freight__c,Total_Tax__c,NSR_Rake_Discount__c,Adhoc_Incentive_Value__c,MMC__c,Qty__c,NSR_T_Value__c,NSR_Targets_Processed__c,Sales_Office_Code__c,Brand_Short_Form__c,Month_of_Commercial_Invoice_Date__c,Year__c,Plant_Short_Form__c,Commercial_Invoice_Date_Formula__c,Distribution_Channel__c from Invoice__c];
        NSRActuals bat1 = new NSRActuals(query);
        bat1.execute(null,nsrlst1);
        Database.executeBatch(bat1);
    }
}