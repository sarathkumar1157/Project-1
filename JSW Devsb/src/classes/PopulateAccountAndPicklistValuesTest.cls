@isTest
public Class PopulateAccountAndPicklistValuesTest{
    
    public static testMethod  void updateAccount()
    {
     list<String>soids=new list<String>();
    
  
     account ac=new account();
     ac.Customer_Code__c='abc123';
     ac.name='testing';
        ac.External_ID__c = 'abc1231050';
     insert ac;
     
    
     
     List<Business_Partner__c> orderList=new List<Business_Partner__c>();
      Business_Partner__c bp2=new Business_Partner__c();
      bp2.Customer_Code__c='abc12345';
      bp2.Sold_to_Code__c= ac.Customer_Code__c;
      bp2.Distribution_Channel__c='10';
       bp2.Division__c='50';
      bp2.Account_Group__c='YSAL';
      insert bp2;
      
      Business_Partner__c bp1=new Business_Partner__c();
      bp1.Customer_Code__c='abc12345';
      bp1.Sold_to_Code__c= ac.Customer_Code__c;
      bp1.Distribution_Channel__c='10.0';
       bp1.Division__c='50';
      bp1.Account_Group__c='YPRO';
      insert bp1;
      
      Business_Partner__c bp=new Business_Partner__c();
      bp.Customer_Code__c='abc12345';
      bp.Sold_to_Code__c= ac.Customer_Code__c;
      bp.Distribution_Channel__c='10.0';
       bp.Division__c='50';
      bp.Account_Group__c='YSUB';
     // orderList.add(bp);
      insert bp;
      
       Business_Partner__c bp3=new Business_Partner__c();
      bp3.Customer_Code__c='abc12345';
      bp3.Sold_to_Code__c= ac.Customer_Code__c;
      bp3.Distribution_Channel__c='10.0';
       bp3.Division__c='50';
      bp3.Account_Group__c='YMMC';
     // orderList.add(bp);
      insert bp3;
    
    
    
      
    }
}