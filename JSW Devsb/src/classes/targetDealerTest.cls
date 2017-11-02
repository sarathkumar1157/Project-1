@isTest
Public class targetDealerTest
{
    Public static testmethod void trgtdlr()
    {
        Account ac = new Account();
        ac.Name = 'abc';
        ac.Customer_Code__c='123';
        ac.Division__c='50';
        ac.Distribution_Channel__c='10';
        ac.External_ID__c = '1231050';
        insert ac;
        Target__c tgt = new Target__c();
        tgt.Customer_Code__c = '123';
        tgt.Distribution_Channel__c = '10';
        tgt.Division__c = '50';
        tgt.Month__c = 'February';
        tgt.Year__c = '2017';
        tgt.Product__c = 'PSC';
        tgt.Target_in_QTY_MT__c = 20;
        insert tgt;
    }
}