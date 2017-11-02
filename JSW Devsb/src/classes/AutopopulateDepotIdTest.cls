@isTest
public class AutopopulateDepotIdTest 
{
    public static testmethod void autodepo()
    {
        account ac = new account(name = 'test',Customer_Code__c='test123');
        insert ac;
        Depot_Stock__c ds = new Depot_Stock__c();
        ds.Depot_Account_Code__c = 'test123';
        //ds.Depot__c = ac.id;
        insert ds;
    }
}