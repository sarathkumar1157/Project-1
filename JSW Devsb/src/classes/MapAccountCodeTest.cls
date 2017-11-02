@isTest
public class MapAccountCodeTest
{
    public static testMethod  void updateAccountId()
    {
          account ac=new account();
          ac.Customer_Code__c='abc123';
          ac.name='testing';
          insert ac;
          
          Plant_Master__c  p=new Plant_Master__c ();
          p.Depot_Customer__c='abc123';
          insert p;
       
       
    }

}