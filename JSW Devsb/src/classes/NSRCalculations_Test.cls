@isTest
public class NSRCalculations_Test 
{
    public static testmethod void batchtest()
    {
        //String query1 = 'Select id,name,Plant_Name__c,SLOC__c,Commercial_Invoice_Number__c,Sales_Office_Description__c,Account__c,Commercial_Invoice_Date_Formula__c,Qty__c,Plant_Short_Form__c,Sales_District__c,Brand_Short_Form__c,Sold_To_Code__c,Commercial_Invoice_Date__c,Distribution_Channel__c,Division__c,Month_of_Commercial_Invoice_Date__c,Year__c,Customer_Group_1__c,Cust_Grp1_from_Master__c,Plant__c from Invoice__c where CreatedDate=TODAY'; 
        String query = 'Select Sales_District__c,Brand_Short_Form__c,Distribution_channel__c,Plant_Short_Form__c,Plant__c,SLOC__c,Sold_To_Code__c,Commercial_Invoice_Number__c,NSR_PD_Value__c,Commercial_Invoice_Date_Formula__c,NSR_Other_Value__c,NSR_PRFT_Value__c,NSR_C_F_Value__c,Adhoc_Incentive_Value__c,Customer_Incentive_Value__c,Invoice_Discount_Value__c,Invoice_NSR_Processed__c from Invoice__c where CreatedDate=TODAY';
        Account ac = new Account(name='test',Customer_Code__c='test');
        ac.Distribution_Channel__c = '10';
        ac.Division__c = '50';
        insert ac;
        Invoice__c inv = new Invoice__c();
        inv.Distribution_Channel__c = '10';
        inv.Plant__c = 'ABC';
        inv.Sales_District__c = 'Dist';
        inv.Brand_Short_Form__c = 'PSC';
        inv.Commercial_Invoice_Date__c = system.today();
        insert inv;
        
        NSR_Other_Values__c othr = new NSR_Other_Values__c();
        Othr.Distribution_Channel__c = '10';
        othr.District_Code__c = 'Dist';
        othr.Product__c = 'PSC';
        othr.From_Date__c = System.today() - 1;
        othr.To_Date__c = System.today() + 3;
        insert othr;
        
        NSR_PRFT_Values__c prft = new NSR_PRFT_Values__c();
        prft.Plant__c = 'ABC';
        prft.Product__c = 'PSC';
        prft.From_Date__c = System.today() - 1;
        prft.To_Date__c = System.today() + 3;
        insert prft;
        
        NSR_C_F_Value_Changes__c cf = new NSR_C_F_Value_Changes__c();
        cf.Plant__c = 'ABC';
        cf.Product__c = 'PSC';
        cf.From_Date__c = System.today() - 1;
        cf.To_Date__c = System.today() + 3;
        insert cf;
        
        NSR_PD_Values__c pd = new NSR_PD_Values__c();
        Pd.Distribution_Channel__c = '10';
        pd.District_Code__c = 'Dist';
        pd.Product__c = 'PSC';
        pd.From_Date__c = System.today() - 1;
        pd.To_Date__c = System.today() + 3;
        insert pd;
                
        List<Invoice__c> invlst1 = [Select Sales_District__c,Brand_Short_Form__c,Distribution_channel__c,Plant_Short_Form__c,Plant__c,SLOC__c,Sold_To_Code__c,Commercial_Invoice_Number__c,NSR_PD_Value__c,Commercial_Invoice_Date_Formula__c,NSR_Other_Value__c,NSR_PRFT_Value__c,NSR_C_F_Value__c,Adhoc_Incentive_Value__c,Customer_Incentive_Value__c,Invoice_Discount_Value__c,Invoice_NSR_Processed__c from Invoice__c];
        //invlst.add(inv);
        NSRCalculations bat = new NSRCalculations(query);
        bat.execute(null,invlst1);
        Database.executeBatch(bat);
                
    }
}