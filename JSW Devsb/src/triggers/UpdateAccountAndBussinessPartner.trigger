trigger UpdateAccountAndBussinessPartner on Customer_Ledger__c (before insert) {
  list<String> custCodeList=new list<String>();
  list<String> PromoList=new list<string>();
  list<String> EmpList=new list<String>();
    for(Customer_Ledger__c cl:Trigger.new)
    {
    
    String soldt=cl.Customer_Code__c+cl.Distribution_Channel__c+cl.Division__c;
    String salePro=cl.Sales_Promoter_Code__c+cl.Distribution_Channel__c+cl.Division__c;
     custCodeList.add(soldt);
     PromoList.add(salePro);
     EmpList.add(cl.Sales_Employee_Code__c);
    }
    
    List<Account> accounts=[select id,Customer_Code__c,ownerid  from Account where External_ID__c in :custCodeList and External_ID__c !=null];
    
    for(Account ac:accounts)
    {
        for(Customer_Ledger__c cl:Trigger.new)
        { 
        if(cl.Customer_Code__c == ac.Customer_Code__c)
          {
        
          cl.Account__c=ac.id;
          cl.ownerid=ac.ownerid;
          }
        }
    
    }
   
 
   List<Business_Partner__c> businesspartner=[select id,Customer_Code__c  from Business_Partner__c where ExternalId__c in :PromoList and ExternalId__c !=null];
   {
   for(Business_Partner__c bp:businesspartner)
   {
     for(Customer_Ledger__c cl:Trigger.new)
     {
      
        
      cl.Sales_Promoter__c=bp.id;
      
     }
   }
  }

List<User> usersList1=[select id,SAP_Code__c from User where SAP_Code__c in :EmpList and SAP_Code__c != null];
 for(User usr:  usersList1)
    {
        
       
             for(Customer_Ledger__c cl:Trigger.new)
                {
                 if(cl.Sales_Employee_Code__c== usr.SAP_Code__c )
                  {
                   cl.Sales_Employee__c=usr.id;
                  }
                }
        }

  /* List<Business_Partner__c> businesspartners=[select id from Business_Partner__c where Customer_Code__c in :EmpList and Customer_Code__c !=null];
   {
   for(Business_Partner__c bp:businesspartners)
   {
     for(Customer_Ledger__c cl:Trigger.new)
     {
      cl.Sales_Employee__c=bp.id;
     }
   }
  }*/
}