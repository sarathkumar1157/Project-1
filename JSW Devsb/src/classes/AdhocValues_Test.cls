@isTest
public class AdhocValues_Test 
{
    public static testmethod void adhocdisttest()
    {
        Districts__c dst = new Districts__c();
        dst.District_Code__c = 'abcdst';
        dst.Name = 'test dst';
        dst.District_Category__c = 'A';
        insert dst;
        
        Adhoc_Incentive__c ad = new Adhoc_Incentive__c();
        ad.District_Code__c = 'abcdst';
        insert ad;
    }
}