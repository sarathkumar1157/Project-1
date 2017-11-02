@isTest
public class MaharashtraActualsDelete_Test 
{
    public static testmethod void distActlTest()
    {
        List<Invoice__c> invlst = new List<Invoice__c>();
        Date myDate = date.newInstance(2017,06,10);
        String query = 'Select id,name,Plant_Name__c,Plant__c,Ship_To_District__c,Sales_Office_Code__c,Road_Invoice__c,Depot_Invoice__c,District_Actuals_Process__c,Sales_Office_Description__c,Account__c,Commercial_Invoice_Date_Formula__c,Qty__c,Plant_Short_Form__c,Sales_District__c,Brand_Short_Form__c,Sold_To_Code__c,Commercial_Invoice_Date__c,Distribution_Channel__c,Division__c,Month_of_Commercial_Invoice_Date__c,Year__c,Customer_Group_1__c,Cust_Grp1_from_Master__c,Invoice_Processed__c from Invoice__c where Day_only(CreatedDate) = TODAY';
        
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
        List<Invoice__c> invlst1 = [Select id,name,Sales_Office_Code__c,Ship_To_District__c,Plant_Name__c,Plant__c,Road_Invoice__c,Depot_Invoice__c,District_Actuals_Process__c,Sales_Office_Description__c,Account__c,Commercial_Invoice_Date_Formula__c,Qty__c,Plant_Short_Form__c,Sales_District__c,Brand_Short_Form__c,Sold_To_Code__c,Commercial_Invoice_Date__c,Distribution_Channel__c,Division__c,Month_of_Commercial_Invoice_Date__c,Year__c,Customer_Group_1__c,Cust_Grp1_from_Master__c,Invoice_Processed__c,Total_value__c,MMC__c,NSR_PD__c,Freight__c,Total_Adhoc_Discount__c,NSR_C_F_Discount__c,NSR_PRFT_Dump_Discout__c from Invoice__c];
        MaharashtraActualsDelete bat1 = new MaharashtraActualsDelete(query);
        bat1.execute(null,invlst1);
        Database.executeBatch(bat1);
    }
}