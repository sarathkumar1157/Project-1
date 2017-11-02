@isTest
public Class AutoPopulateOrderTest{
    
    public static testMethod  void updateOrder()
    {
     list<String>soids=new list<String>();
      User u = [select firstname from user where id=:userinfo.getuserid()];
     account ac=new account();
     ac.Customer_Code__c='abc123';
      ac.External_ID__c='abc1231050';
     ac.name='testing';
        ac.OwnerId=u.id;
     insert ac;
     
      Ship_To_Party__c sh=new Ship_To_Party__c();
     sh.Customer_Code__c='abc123';
      sh.External_ID__c='abc1231050';
     insert sh;
     
      product2 p=new product2();
     p.ProductCode='abc';
     p.name='abc';
     insert p;
     
     Plant_Master__c p2=new Plant_Master__c();
     p2.Plant_Code__c='xyz';
     insert p2;
     
      Invoice__c  inv1=new Invoice__c();
     // ord.CO_Name__c='Test';
      inv1.Sold_To_Code__c ='abc123';
     inv1.Ship_to_Code__c='xyz';
     inv1.Distribution_Channel__c='10';
      inv1.Division__c='50';
          inv1.Product__c='abc';
        inv1.Plant__c='xyz';
    insert inv1;
    
     
     
     // ord.Sales_Emp__c= bp.Customer_Code__c;
     
     // insert inv1;
    
    
     
    
     
     Business_Partner__c bp=new Business_Partner__c();
     bp.Customer_Code__c='abc12345';
     
     insert bp;
     
     Order__c ord1 = new Order__c();
     ord1.SO_STO_No__c ='123456';
     ord1.Sold_To_Party_Name__c='abc123';
        ord1.OwnerId=u.id;
     insert ord1;
     
     
     Delivery__c dl = new Delivery__c();
     dl.Delivery_No__c='xyz';
     insert dl;
     
     List<Invoice__c> orderList = new List<Invoice__c>();
     Invoice__c  ord=new Invoice__c();
     // ord.CO_Name__c='Test';
      ord.Sold_To_Code__c ='abc123';
      ord.Ship_to_Code__c=sh.Customer_Code__c;
      ord.SO_PO_Number__c=ord1.SO_STO_No__c;
      ord.Delivery_Number__c = dl.Delivery_No__c;
     // ord.Sales_Emp__c= bp.Customer_Code__c;
     ord.Qty__c=10.00;
      orderList.add(ord);
      insert orderList;
      
    
    
      
    }
}