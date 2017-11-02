@isTest(SeeAllData=True)
public Class autoPopulateOnNSRTest {
    
    public static testMethod  void updateAccount()
    {
     list<String>soids=new list<String>();
        list<Account> acclist=new list<Account>();
     account ac=new account();
     ac.Customer_Code__c='abc';
     ac.Account_Group__c = 'YCSP';
     ac.Distribution_Channel__c = '10'; 
     ac.External_ID__c='abc1231020';
     ac.name='testing';
     acclist.add(ac);
        account ac1=new account();
     ac1.Customer_Code__c='abc';
     ac1.Account_Group__c = 'YCSP';
     ac1.Distribution_Channel__c = '10'; 
     ac1.External_ID__c='abc1050';
     ac1.name='testing';
     acclist.add(ac1);
      insert acclist;
      Nsr__c nsr= new Nsr__c ();
     nsr.Account__c=ac.id;
     nsr.Customer_Code__c=ac.Customer_Code__c;
     nsr.Distribution_Channel__c='10';
       nsr.Division__c='50'; 
     nsr.External_Id__c='abc1050';
	 insert nsr;
     }
}