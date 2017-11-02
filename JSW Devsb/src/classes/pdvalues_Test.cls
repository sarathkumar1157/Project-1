@isTest
public class pdvalues_Test 
{
    public static testmethod void pdval()
    {
        Invoice__c inv = new Invoice__c();
        inv.Plant__c = 'ABC';
        inv.Sales_District__c = 'Dist';
        inv.Brand_Short_Form__c = 'PSC';
        inv.Commercial_Invoice_Date__c = system.today();
        insert inv;
        
        Districts__c dst = new Districts__c();
        dst.District_Code__c = 'Dist';
        dst.Name = 'test dst';
        dst.District_Category__c = 'A';
        insert dst;
        
        product2 p=new product2();
        p.ProductCode='PSC';
        p.name='abc';
        insert p;
        
        Plant_Master__c p2=new Plant_Master__c();
        p2.Plant_Code__c='ABC';
        insert p2;
        
        NSR_Other_Values__c othr = new NSR_Other_Values__c();
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
        pd.District_Code__c = 'Dist';
        pd.Product__c = 'PSC';
        pd.From_Date__c = System.today() - 1;
        pd.To_Date__c = System.today() + 3;
        insert pd;
    }
}