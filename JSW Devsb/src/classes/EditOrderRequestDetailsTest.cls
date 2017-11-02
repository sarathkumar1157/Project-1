@isTest(SeeAllData=false)
public Class EditOrderRequestDetailsTest {
  
         public static Account account;
  
    public static testMethod  void updateAccount()
    {
    
        
         /*Order_Booking_Line__c ordb=new Order_Booking_Line__c();
        ordb.Price__c  =null;
        insert ordb;*/
         account= new Account();
         account.Name='xyz';
         account.Distribution_Channel__c='20';
         account.Division__c='50';
         account.Sales_District__c='1234';
         insert account;
         
       
         Ship_To_Party__c shipToParty=new Ship_To_Party__c(name='test',Account__c=account.Id,Customer_Code__c='test',External_Id__c='test',Sales_District__c='1234',Address__c='Test');
        insert shipToParty;
        Order_Type__c ordt = new Order_Type__c();
        ordt.Name = 'test ordt';
        ordt.Distribution_Channel__c = '20';
        ordt.Division__c = '50';
        insert ordt;
        
      
        
        Order_Request__c orderRequestRec=new Order_Request__c();
        orderRequestRec.Account__c=account.id;
        orderRequestRec.Distribution_Channel__c=account.Distribution_Channel__c;
        orderRequestRec.Division__c=account.Division__c ;
        orderRequestRec.Sales_Org__c='3000';
        orderRequestRec.Sales_District__c=account.Sales_District__c; 
        orderRequestRec.Inco_Terms__c='EXW';
        //orderRequestRec.Ship_To_Party__c=shipToParty.Id;
        orderRequestRec.Order_Type1__c = ordt.Id;
       orderRequestRec.Shipment_Type__c='Y2-Bulker';
        insert orderRequestRec;
        
        Order_Booking_Line__c ordline=new Order_Booking_Line__c ();
        ordline.Order_Request__c=orderRequestRec.id;
        insert ordline;
        
        product2 p=new product2();
        p.Name='p1';
        insert p;
        system.debug('p.id******'+p.id);
        //Order_Request__c OrderRec=[select id,Name,Inco_Terms__c,Account__c,Order_Type1__c  from Order_Request__c where id=:orderRequestRec.Id];
        Order_Booking_Line__c ordb1 = new Order_Booking_Line__c();
        //ordb1.Price__c  = 50;
        ordb1.Material_Code1__c=p.id;
          system.debug('p.id** ordb1.Material_Code1__c****'+ ordb1.Material_Code1__c);
        ordb1.Plant__c='3001';
       
      
        
        PageReference pageRef = Page.orderRequest; 
        pageRef.getParameters().put('CF00Np00000011pVD_lkid', account.Id);         
        pageRef.getParameters().put('id',orderRequestRec.id);        
        Test.setCurrentPage(pageRef);
         
       ApexPages.StandardController sc = new ApexPages.StandardController(orderRequestRec);
       editOrderRequestDetails ordDetails = new editOrderRequestDetails(sc);
       ordDetails.orderRequest=orderRequestRec;
       ordDetails.selectedPhoneNumberContactName='test';
       ordDetails.accountsID=account.Id;
       ordDetails.rowNum='1';
       ordDetails.selectedPhoneNumber='test';
      //ordDetails.ListOrdBook.add(ordb1);
      //ordDetails.ListOrdBook[1].price__c=null;
       ordDetails.accountDetails();
       ordDetails.forSave();
      
      
      
       /* 
        
        Order_Request__c orderRequestRec1=new Order_Request__c();
        orderRequestRec1.Account__c=account.id;
        orderRequestRec1.Distribution_Channel__c=account.Distribution_Channel__c;
        orderRequestRec1.Division__c=account.Division__c ;
        orderRequestRec1.Sales_Org__c='3000';
        orderRequestRec1.Sales_District__c=account.Sales_District__c; 
        orderRequestRec1.Inco_Terms__c='FOR';
        orderRequestRec1.Order_Type1__c = ordt.Id;
        orderRequestRec1.Ship_To_Party__c=shipToParty.Id;
        insert orderRequestRec1;
       
       
        PageReference pageRef1 = Page.orderRequest; 
        pageRef1.getParameters().put('CF00Np00000011pVD_lkid', account.Id);         
        pageRef1.getParameters().put('id',account.Id);        
        Test.setCurrentPage(pageRef1);
        
       ApexPages.StandardController sc1 = new ApexPages.StandardController(orderRequestRec1);
       OrderRequestDetails ordDetails1 = new OrderRequestDetails(sc1);
       ordDetails1.orderRequest=orderRequestRec1;
         ordDetails.selectedPhoneNumberContactName='test';
       ordDetails.accountsID=account.Id;
       ordDetails.rowNum='1';
       ordDetails.selectedPhoneNumber='test';
        ordDetails1.showOrHide();       
       ordDetails1.getDivAndDC();        
        ordDetails1.blockDeletion();
        ordDetails1.addMoreItems();
       
      
       ordDetails1.showOrHide(); */   
    }
    
    
    
     public static testMethod  void updateAccount1()
    {
    
        
         /*Order_Booking_Line__c ordb=new Order_Booking_Line__c();
        ordb.Price__c  =null;
        insert ordb;*/
         account= new Account();
         account.Name='xyz';
         account.Distribution_Channel__c='10';
         account.Division__c='50';
         account.Sales_District__c='1234';
         insert account;
         
       
         Ship_To_Party__c shipToParty=new Ship_To_Party__c(name='test',Account__c=account.Id,Customer_Code__c='test',External_Id__c='test',Sales_District__c='1234',Address__c='Test');
        insert shipToParty;
        Order_Type__c ordt = new Order_Type__c();
        ordt.Name = 'test ordt';
        ordt.Distribution_Channel__c = '10';
        ordt.Division__c = '50';
        insert ordt;
        
      
        
       
        
        //Order_Request__c OrderRec=[select id,Name,Inco_Terms__c,Account__c,Order_Type1__c  from Order_Request__c where id=:orderRequestRec.Id];
        Order_Booking_Line__c ordb1 = new Order_Booking_Line__c();
        //ordb1.Price__c  = 50;
        insert ordb1;
     
        Order_Request__c orderRequestRec1=new Order_Request__c();
        orderRequestRec1.Account__c=account.id;
        orderRequestRec1.Distribution_Channel__c=account.Distribution_Channel__c;
        orderRequestRec1.Division__c=account.Division__c ;
        orderRequestRec1.Sales_Org__c='3000';
        orderRequestRec1.Sales_District__c=account.Sales_District__c; 
        orderRequestRec1.Inco_Terms__c='FOR';
        orderRequestRec1.Order_Type1__c = ordt.Id;
        orderRequestRec1.Ship_To_Party__c=shipToParty.Id;
        insert orderRequestRec1;
       
        Order_Booking_Line__c ordline=new Order_Booking_Line__c ();
        ordline.Order_Request__c=orderRequestRec1.id;
        insert ordline;
        PageReference pageRef1 = Page.orderRequest; 
        pageRef1.getParameters().put('CF00Np00000011pVD_lkid', account.Id);         
        pageRef1.getParameters().put('id',orderRequestRec1.Id);        
        Test.setCurrentPage(pageRef1);
        
       ApexPages.StandardController sc1 = new ApexPages.StandardController(orderRequestRec1);
       editOrderRequestDetails ordDetails1 = new editOrderRequestDetails(sc1);
       ordDetails1.orderRequest=orderRequestRec1;
        // ordDetails.selectedPhoneNumberContactName='test';
       ordDetails1.accountsID=account.Id;
       ordDetails1.rowNum='1';
       ordDetails1.selectedPhoneNumber='test';
        ordDetails1.ListOrdBook.add(ordb1);
        ordDetails1.showOrHide();       
       ordDetails1.getDivAndDC();        
        ordDetails1.blockDeletion();
        ordDetails1.addMoreItems();
      
       ordDetails1.showOrHide();    
    }
    
     public static testMethod  void updateAccount2()
    {
    
        
         /*Order_Booking_Line__c ordb=new Order_Booking_Line__c();
        ordb.Price__c  =null;
        insert ordb;*/
         account= new Account();
         account.Name='xyz';
         account.Distribution_Channel__c='20';
         account.Division__c='50';
         account.Sales_District__c='1234';
         insert account;
         
       
         Ship_To_Party__c shipToParty=new Ship_To_Party__c(name='test',Account__c=account.Id,Customer_Code__c='test',External_Id__c='test',Sales_District__c='1234',Address__c='Test');
        insert shipToParty;
        Order_Type__c ordt = new Order_Type__c();
        ordt.Name = 'test ordt';
        ordt.Distribution_Channel__c = '10';
        ordt.Division__c = '50';
        insert ordt;
        
        
        product2 p=new product2();
        p.Name='p1';
        insert p;
        
      Order__c ord=new Order__c();
      ord.Incoterm__c='FOR';
      ord.Net_Price__c=100;
      ord.Gr_Rate_mt__c=100;
      ord.PO_No__c='test';
      ord.account__c=account.id;
      ord.SO_STO_Date__c=System.today();
      ord.SO_Type__c='YQC';
      ord.Material__c=p.Name;
      
      insert ord;
        
       
        
        //Order_Request__c OrderRec=[select id,Name,Inco_Terms__c,Account__c,Order_Type1__c  from Order_Request__c where id=:orderRequestRec.Id];
        Order_Booking_Line__c ordb1 = new Order_Booking_Line__c();
        //ordb1.Price__c  = 50;
        insert ordb1;
     
        Order_Request__c orderRequestRec1=new Order_Request__c();
        orderRequestRec1.Account__c=account.id;
        orderRequestRec1.Distribution_Channel__c=account.Distribution_Channel__c;
        orderRequestRec1.Division__c=account.Division__c ;
        orderRequestRec1.Sales_Org__c='3000';
        orderRequestRec1.Sales_District__c=account.Sales_District__c; 
        orderRequestRec1.Inco_Terms__c='EXD';
        orderRequestRec1.Order_Type1__c = ordt.Id;
        orderRequestRec1.Ship_To_Party__c=shipToParty.Id;
           orderRequestRec1.Shipment_Type__c='Y2-Bulker';
           orderRequestRec1.Contracts__c=ord.id;
           orderRequestRec1.Month_Of_Date__c=5;
           orderRequestRec1.Distribution_Channel__c='20';
        insert orderRequestRec1;
        
       
        
        system.debug('p.id******'+p.id);
        //Order_Request__c OrderRec=[select id,Name,Inco_Terms__c,Account__c,Order_Type1__c  from Order_Request__c where id=:orderRequestRec.Id];
        Order_Booking_Line__c ordb5 = new Order_Booking_Line__c();
        //ordb1.Price__c  = 50;
        ordb5.Material_Code1__c=p.id;
          system.debug('p.id** ordb1.Material_Code1__c****'+ ordb1.Material_Code1__c);
            ordb5.Order_Request__c=orderRequestRec1.id;
        ordb5.Plant__c='3001';
      
       insert ordb5;
       
        PageReference pageRef1 = Page.orderRequest; 
        pageRef1.getParameters().put('CF00Np00000011pVD_lkid', account.Id);         
        pageRef1.getParameters().put('id',orderRequestRec1.Id); 
         pageRef1.getParameters().put('rowNum','1');        
        Test.setCurrentPage(pageRef1);
        
       ApexPages.StandardController sc1 = new ApexPages.StandardController(orderRequestRec1);
       editOrderRequestDetails ordDetails1 = new editOrderRequestDetails(sc1);
       ordDetails1.orderRequest=orderRequestRec1;
        // ordDetails.selectedPhoneNumberContactName='test';
       ordDetails1.accountsID=account.Id;
       ordDetails1.rowNum='1';
       ordDetails1.selectedPhoneNumber='test';
        ordDetails1.ListOrdBook.add(ordb1);
        ordDetails1.showOrHide();       
       ordDetails1.getDivAndDC();        
        ordDetails1.blockDeletion();
        ordDetails1.addMoreItems();
      
       ordDetails1.showOrHide();
       ordDetails1.showOrHideContracts();
        ordDetails1.getContractsDetails();
        ordDetails1.materialDetails();
    }
 }