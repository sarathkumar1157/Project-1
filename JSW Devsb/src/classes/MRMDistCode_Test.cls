@isTest
public class MRMDistCode_Test 
{
	public static testmethod void mrmdisttest()
    {
        Districts__c dst = new Districts__c();
        dst.District_Code__c = 'abcdst';
        dst.Name = 'test dst';
        dst.District_Category__c='test';
         insert dst;
        
        District__c ter = new District__c();
        ter.Territory_Code__c = 'abcter';
        ter.Districts__c = dst.id;
        ter.Name = 'test ter';
        insert ter;
        
        MRM_Targets__c mrm0 = new MRM_Targets__c();
        mrm0.District_Code__c = 'abcdst';
        mrm0.Sales_Office__c = 'abcter';
        mrm0.month__c = 'May';
        insert mrm0;
        
        MRM_Targets__c mrm = new MRM_Targets__c();
        mrm.District_Code__c = 'abcdst';
        mrm.Sales_Office__c = 'abcter';
        mrm.month__c = 'June';
        insert mrm;
        
        MRM_Targets__c mrm1 = new MRM_Targets__c();
        mrm1.District_Code__c = 'abcdst';
        mrm1.Sales_Office__c = 'abcter';
        mrm1.month__c = 'July';
        insert mrm1;
        
        MRM_Targets__c mrm2 = new MRM_Targets__c();
        mrm2.District_Code__c = 'abcdst';
        mrm2.Sales_Office__c = 'abcter';
        mrm2.month__c = 'August';
        insert mrm2;
        
        MRM_Targets__c mrm3 = new MRM_Targets__c();
        mrm3.District_Code__c = 'abcdst';
        mrm3.Sales_Office__c = 'abcter';
        mrm3.month__c = 'April';
        insert mrm3;
        
        MRM_Targets__c mrm4 = new MRM_Targets__c();
        mrm4.District_Code__c = 'abcdst';
        mrm4.Sales_Office__c = 'abcter';
        mrm4.month__c = 'March';
        insert mrm4;
        
        MRM_Targets__c mrm5 = new MRM_Targets__c();
        mrm5.District_Code__c = 'abcdst';
        mrm5.Sales_Office__c = 'abcter';
        mrm5.month__c = 'February';
        insert mrm5;
        
        /*MRM_Targets__c mrm6 = new MRM_Targets__c();
        mrm6.District_Code__c = 'abcdst';
        mrm6.month__c = 'January';
        insert mrm6;*/
        
        MRM_Targets__c mrm7 = new MRM_Targets__c();
        mrm7.District_Code__c = 'abcdst';
        mrm7.Sales_Office__c = 'abcter';
        mrm7.month__c = 'September';
        insert mrm7;
        
        MRM_Targets__c mrm8 = new MRM_Targets__c();
        mrm8.District_Code__c = 'abcdst';
        mrm8.Sales_Office__c = 'abcter';
        mrm8.month__c = 'October';
        insert mrm8;
        
        MRM_Targets__c mrm9 = new MRM_Targets__c();
        mrm9.District_Code__c = 'abcdst';
        mrm9.Sales_Office__c = 'abcter';
        mrm9.month__c = 'November';
        insert mrm9;
    }
}