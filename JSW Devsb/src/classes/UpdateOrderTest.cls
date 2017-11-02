@isTest
public Class UpdateOrderTest{
    
    public static testMethod  void updateAccount()
    {
     list<String>soids=new list<String>();
    
  
     account ac=new account();
     ac.Customer_Code__c='abc123';
     ac.name='testing';
        ac.External_ID__c = 'abc123';
     insert ac;
     
     product2 p=new product2();
     p.ProductCode='abc';
     p.name='abc';
     insert p;
     
     Plant_Master__c p2=new Plant_Master__c();
     p2.Plant_Code__c='xyz';
     insert p2;
     
        account ac1=new account();
     ac1.Customer_Code__c='abc123';
     ac1.name='testing';
        ac1.External_ID__c = 'abc1231050';
     insert ac1;
        
     Ship_To_Party__c sh=new Ship_To_Party__c();
     sh.Customer_Code__c='abc123';
        sh.External_ID__c = 'abc1231050';
     insert sh;
     
     Business_Partner__c bp=new Business_Partner__c();
     bp.Customer_Code__c='abc123';
        bp.ExternalId__c='abc1231050';
     insert bp;
     
     Order_Request__c odr= new Order_Request__c();
        odr.Account__c=ac.id;
       insert odr;
        system.debug('odr.name****'+odr.name);
        
        
     List<Order__c> orderList=new List<Order__c>();
     order__c ord=new order__c();
      ord.CO_Name__c='Test';
     
      ord.Sold_To_Party__c =ac.Customer_Code__c;
      ord.Shp_To_Party__c=sh.Customer_Code__c;
      ord.Sales_Emp__c= bp.Customer_Code__c;
        ord.Distribution_Channel__c = '10';
        ord.Division__c = '50';
        ord.Order_Request_Number__c='or001';
        ord.Material__c='abc';
        ord.Plant__c='xyz';
      orderList.add(ord);
      insert orderList;
    
    
    
      
    }
}