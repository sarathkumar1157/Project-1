@isTest
public class StateNSRDelete_Test 
{
	public static testmethod void stateActlTest()
    {
        List<Invoice__c> invlst = new List<Invoice__c>();
        Date myDate = date.newInstance(2017,06,10);
        String query = 'Select id,name,Plant_Name__c,NSR_T_Value__c,Plant__c,State_code__c,Road_Invoice__c,Depot_Invoice__c,District_Actuals_Process__c,Sales_Office_Description__c,Account__c,Commercial_Invoice_Date_Formula__c,Qty__c,Plant_Short_Form__c,Sales_District__c,Brand_Short_Form__c,Sold_To_Code__c,Commercial_Invoice_Date__c,Distribution_Channel__c,Division__c,Month_of_Commercial_Invoice_Date__c,Year__c,Customer_Group_1__c,Cust_Grp1_from_Master__c,Invoice_Processed__c from Invoice__c where Day_only(CreatedDate) = TODAY';
        
        Invoice__c inv2 = new Invoice__c();
        inv2.Plant__c = '3001';
        inv2.State_Code__c= '01';
        inv2.Cust_Grp1_from_Master__c='N01-Institutions';
        inv2.Plant_Short_Form__c= '3001';
        inv2.Shipping_Type__c = 'Rail transport';
        inv2.Sales_District__c= 'test1';
        inv2.Commercial_Invoice_Date__c=myDate;
        inv2.Sold_To_Code__c='test';
        inv2.Brand_Short_Form__c='PSC';
        inv2.Qty__c = 10; 
        inv2.Distribution_Channel__c = '20';
        inv2.Division__c = '50';
        insert inv2;
        
        List<Invoice__c> invlst1 = [Select id,name,Plant_Name__c,NSR_T_Value__c,Plant__c,State_code__c,Road_Invoice__c,Depot_Invoice__c,District_Actuals_Process__c,Sales_Office_Description__c,Account__c,Commercial_Invoice_Date_Formula__c,Qty__c,Plant_Short_Form__c,Sales_District__c,Brand_Short_Form__c,Sold_To_Code__c,Commercial_Invoice_Date__c,Distribution_Channel__c,Division__c,Month_of_Commercial_Invoice_Date__c,Year__c,Customer_Group_1__c,Cust_Grp1_from_Master__c,Invoice_Processed__c from Invoice__c];
        StateNSRDelete bat1 = new StateNSRDelete(query);
        bat1.execute(null,invlst1);
        Database.executeBatch(bat1);
    }
}