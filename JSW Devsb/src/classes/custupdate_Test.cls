@isTest
public class custupdate_Test 
{
	public static testmethod void custtest()
    {
        Account ac = new Account(name='test',Customer_Code__c='test');
        ac.Distribution_Channel__c = '10';
        ac.Division__c = '50';
        ac.Customer_Code__c = 'abc123';
        insert ac;
        
        Customer_Incentive__c ci = new Customer_Incentive__c();
        ci.Customer_Code__c = 'abc123';
        insert ci;
    }
}