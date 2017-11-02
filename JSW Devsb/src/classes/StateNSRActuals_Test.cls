@isTest
public class StateNSRActuals_Test 
{
	public static testmethod void statensrActlTest()
    {
        Date myDate = date.newInstance(2017,06,10);
        String query = 'Select id,name,Sales_Office_Code__c,NSR_T_Value__c,State_Code__c,Territory_Dist_Code__c,Plant_Name__c,Plant__c,Road_Invoice__c,Depot_Invoice__c,District_Actuals_Process__c,Sales_Office_Description__c,Account__c,Commercial_Invoice_Date_Formula__c,Qty__c,Plant_Short_Form__c,Sales_District__c,Brand_Short_Form__c,Sold_To_Code__c,Commercial_Invoice_Date__c,Distribution_Channel__c,Division__c,Month_of_Commercial_Invoice_Date__c,Year__c,Customer_Group_1__c,Cust_Grp1_from_Master__c,Invoice_Processed__c from Invoice__c where Day_only(CreatedDate) = TODAY';
        
        State__c dst = new State__c();
        dst.state_Code__c = '01';
        dst.Name = 'test dst';
        insert dst;
        
        State_MRM_Targets__c mrm = new State_MRM_Targets__c();
        mrm.State__c = dst.id;
        mrm.State_Code_Text__c = '01';
        mrm.Month__c ='June';
        mrm.Year__c = 2017;
        mrm.Product_Group__c = 'PSC';
        mrm.Plant__c = '3001';
        insert mrm;
        
        Invoice__c inv = new Invoice__c();
        inv.Plant__c = '3333';
        inv.Plant_Short_Form__c= '3001';
        inv.Shipping_Type__c = 'Bulker';
        inv.Sales_District__c= 'test1';
        inv.Commercial_Invoice_Date__c=myDate;
        inv.Sold_To_Code__c='test';
        inv.Brand_Short_Form__c='PSC';
        inv.Cust_Grp1_from_Master__c='N01-Institutions';
        inv.Qty__c = 10; 
        inv.Distribution_Channel__c = '10';
        inv.Division__c = '50';
        inv.Sales_Office__c = 'test';
        inv.State_Code__c = '01';
        insert inv;
        
        NSR_New_Targets__c nsr = new NSR_New_Targets__c();
        nsr.District_Code__c = 'test1';
        nsr.State_code__c = '01';
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
        
        List<Invoice__c> invlst1 = [Select id,name,Sales_Office_Code__c,State_Code__c,NSR_T_Value__c,Territory_Dist_Code__c,Plant_Name__c,Plant__c,Road_Invoice__c,Depot_Invoice__c,District_Actuals_Process__c,Sales_Office_Description__c,Account__c,Commercial_Invoice_Date_Formula__c,Qty__c,Plant_Short_Form__c,Sales_District__c,Brand_Short_Form__c,Sold_To_Code__c,Commercial_Invoice_Date__c,Distribution_Channel__c,Division__c,Month_of_Commercial_Invoice_Date__c,Year__c,Customer_Group_1__c,Cust_Grp1_from_Master__c,Invoice_Processed__c from Invoice__c];
        StateNSRActuals bat1 = new StateNSRActuals(query);
        bat1.execute(null,invlst1);
        Database.executeBatch(bat1);
    }
}