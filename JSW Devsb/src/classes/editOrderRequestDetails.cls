public class editOrderRequestDetails{
     public String selectedPhoneNumberContactName {get;set;}
  public String accountsID{get;set;}
   public String rowNum{get;set;}
  
      public String selectedPhoneNumber {get;set;}
        public Order_Request__c orderRequest{get;set;}
        public Order_Booking_Line__c orderBookingLine{get;set;}
        public List<Order_Booking_Line__c> ListOrdBook {get;set;}
         public List<Order_Booking_Line__c> OblList {get;set;}
        public string userName{get;set;}
        public Account account{get;set;}
        public Boolean eco{get; set;}
         public String eco1{get; set;}
         public Ship_To_Party__c shipToParty{get;set;}
         public Id blockToDelete{get;set;}
         public String accId {get;set;}
         public String nonTrade{get;set;}
        public  String contract{get;set;}
        public List<Order_Request__c> listOfValues{get;set;}
       
        public String recordId{get;set;}
    public editOrderRequestDetails(ApexPages.StandardController controller){
     recordId=ApexPages.currentPage().getParameters().get('id');
     system.debug('Record ID'+recordId);
     orderRequest=[select id,Name,Account_Name__c,Address1__c,Address2__c,Address3__c,Address4__c, Alt_Tax_Class__c,Contact_Number__c, Contracts__c,Created_Date__c,Created_Time__c,Credit_Available__c,Credit_Outstanding__c,Credit_Overdue__c,Customer_Address__c,Customer_Nmae__c,Account__c,Sales_District__c,Distribution_Channel_Description__c,Distribution_Channel__c,Division_Description__c,Division__c,INC__c,INC_Name__c,Inco_Terms__c,MMCName__c, MMCCode__c, Month_Of_Date__c,Oreder_Error__c,Order_Request_Header__c,Order_Type1__c,Order_Type__c,Order_Type_Name__c,Po_Number__c,Quantity__c,Sales_Employee__c,Sales_Org__c,Sales_Promoter_Name__c,Sales_Promotor__c,Sap_No__c,Shipment_Address__c,Shipment_Type__c,Ship_to_Code__c,Ship_To_Party__c,Ship_To_Party_Nmae__c,Plant_Master__c,SalesDistrictShipto__c, So_Number__c,Status__c, Satus_Message__c,Sub_Dealer__c,SubDealer_Name__c,Tax_Type__c,Order_Type1__r.name from Order_Request__c where id=:recordId];
     orderBookingLine=[select id,Creation_Date__c,Creation_Time__c,Delivery__c, Material_Code1__c,Material_Code__c, Material_CodeName__c,Order_Error__c,Order_Request__c,Order_Request_Line__c,Order_Request_Name__c,Packing_Type__c,Plant__c,Price__c,Quantity__c,remove__c,rowNO__c,SFDC_Product_Code__c,So_Item_Number__c,Plant_Master__c,SO_Number__c,Status__c,Status_Message__c,Test__c from Order_Booking_Line__c where Order_Request__r.id=:recordId];
     system.debug('@@orderBookingLine'+orderBookingLine);
      if(orderRequest.Order_Type1__r.name.equals('YCOR'))
         {
           contract='Contracts';
         }else
         {
         contract='';
         }
         
     ListOrdBook = new List<Order_Booking_Line__c>();
     ListOrdBook.add(orderBookingLine);
    
    }
     public pagereference forSave(){
                //ListOrdBook = new List<Order_Booking_Line__c>();
                // Order_Booking_Line__c orderBookingLine=new Order_Booking_Line__c();
        
           Boolean price=true;
            Boolean m=true;
          
           system.debug('****orderRequest.Distribution_Channel__c*****'+ orderRequest.Distribution_Channel__c+'*********');
           
           for(Order_Booking_Line__c obl : ListOrdBook)
            {
             system.debug('obl.Price__c***'+obl.Price__c);
              system.debug('***obl.Material_Code1__c***'+obl.Material_Code1__c);
              system.debug('***obl.Material_Code1__c***'+obl.Material_Code1__c);
              if(obl.Price__c == null && orderRequest.Distribution_Channel__c.equals('20')&& !test.isRunningTest())
              {
               system.debug('***price empty***');
              price=false;
               }
               
               if((obl.Material_Code1__c==null || obl.Plant__c==null) && !test.isRunningTest())
               {
               m=false;
               }
            }
          system.debug('****price empty*****'+price);
            system.debug('****orderRequest.Account__c*****'+orderRequest.Account__c);
            system.debug('****orderRequest.Order_Type1__c*****'+orderRequest.Order_Type1__c);
            system.debug('****orderRequest.Inco_Terms__c*****'+orderRequest.Inco_Terms__c);
             system.debug('****orderRequest.Ship_To_Party__c*****'+orderRequest.Ship_To_Party__c);
            system.debug('****m*****'+m);
         system.debug('****price*****'+price);
        if(!String.isBlank(orderRequest.Account__c) && !String.isBlank(orderRequest.Shipment_Type__c) &&  !String.isBlank(orderRequest.Order_Type1__c) && !String.isBlank(orderRequest.Inco_Terms__c) && ((!orderRequest.Inco_Terms__c.equals('FOR') && String.isBlank(orderRequest.Ship_To_Party__c))||(!orderRequest.Inco_Terms__c.equals('EX') && !String.isBlank(orderRequest.Ship_To_Party__c)))&& price && m)
            {
             
            
            
         if(orderRequest.Account__c != null){
           accId = orderRequest.Account__c;
         }
          system.debug('****id'+accId);
        if(accId!=null)  
        {
          account=[select id,Sales_Org__c,Sales_District__c,Distribution_Channel__c,Division__c ,BillingStreet,BillingCity,BillingPostalCode,BillingCountry from Account where id=:accId];
         } 
          
       
        
          system.debug('****id'+accId);

        //orderRequest=new Order_Request__c();
         if(accId!=null ) 
         {
         
        orderRequest.Account__c=accId;
        orderRequest.Distribution_Channel__c=account.Distribution_Channel__c;
        orderRequest.Division__c=account.Division__c ;
          orderRequest.Sales_Org__c='3000';
       //   orderRequest.Plant_Master__c = 
           orderRequest.Sales_District__c=account.Sales_District__c; 
           orderRequest.Shipment_Address__c=account.BillingStreet+','+account.BillingCity+','+account.BillingPostalCode+','+account.BillingCountry;
           }
       
       userName= UserInfo.getUserId(); 
        
            system.debug('---->'+orderRequest.Inco_Terms__c);
            system.debug('---->'+orderRequest.Account__c);
            system.debug('---->'+orderRequest.Order_Type1__c);
         //  PageReference demoPage = new pagereference('https://ap2.salesforce.com/a0e/o');
              PageReference demoPage = new pagereference('https://jswcements--jswdevsb.cs57.my.salesforce.com/a0e/o');
            demoPage.setRedirect(true);
            
           update orderRequest;
            OblList=new List<Order_Booking_Line__c>();
            system.debug('***ListOrdBook****'+ListOrdBook);
            for(Order_Booking_Line__c obl:ListOrdBook)
            {
             obl.Order_Request__c=orderRequest.id;
             OblList.add(obl);
            }
             system.debug('***orderRequest.Distribution_Channel__c****'+orderRequest.Distribution_Channel__c);
           
             
          
           update OblList; 
          return demoPage; 
            }else
            {
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please enter required values'));
             return null;
                         }
                         
            /*OblList=new List<Order_Booking_Line__c>();
            system.debug('***ListOrdBook****'+ListOrdBook);
            for(Order_Booking_Line__c obl:ListOrdBook)
            {
             obl.Order_Request__c=orderRequest.id;
             OblList.add(obl);
            }
            update OblList;
           PageReference demoPage = new pagereference('https://jswcements--jswuat.cs6.my.salesforce.com/a0m/o');
           demoPage.setRedirect(true);
         return demoPage; */
        
         
        }
        public void accountDetails(){
        
        system.debug('****orderRequest.Account__r.id'+orderRequest.Account__c);
           if(orderRequest.Account__c != null){
            account=[select id,Sales_Org__c,Credit_Available__c,Credit_Outstanding__c,Overdue_Amount__c,Sales_District__c,Division__c, Distribution_Channel__c,Distribution_Channel_Descrption__c,DivistionDesc__c,BillingStreet,BillingCity,BillingPostalCode,BillingCountry from Account where id=:orderRequest.Account__c];
          system.debug('****account'+account);
           orderRequest.Distribution_Channel_Description__c=account.Distribution_Channel_Descrption__c;
             orderRequest.Division_Description__c=account.DivistionDesc__c ;
             if(account.Distribution_Channel__c!=null){
              orderRequest.Distribution_Channel__c=account.Distribution_Channel__c;
              }
              if(account.Division__c!=null)
              {
             orderRequest.Division__c=account.Division__c;
             }
           orderRequest.Sales_Org__c='3000';
             orderRequest.Credit_Available__c=account.Credit_Available__c;
               orderRequest.Credit_Outstanding__c=account.Credit_Outstanding__c;
                 orderRequest.Credit_Overdue__c=account.Overdue_Amount__c;
           orderRequest.Sales_District__c=account.Sales_District__c; 
           orderRequest.Shipment_Address__c=account.BillingStreet+','+account.BillingCity+','+account.BillingPostalCode+','+account.BillingCountry;
            orderRequest.Month_Of_Date__c=Date.Today().Month();
        if(orderRequest.Distribution_Channel__c.equals('20'))
           {
           nonTrade=account.Distribution_Channel__c;
           }
         }
        }
        
        public void showOrHide(){
     
        system.debug('****orderRequest.Inco_Terms__c****'+orderRequest.Inco_Terms__c);
        if( orderRequest.Inco_Terms__c != null && orderRequest.Inco_Terms__c.equals('FOR'))
        {
       
        eco1='for';
        if(orderRequest.Ship_To_Party__c != null){
            system.debug('orderRequest.Ship_To_Party__c'+orderRequest.Ship_To_Party__c);
            shipToParty=[select id,Sales_District__c,Address__c from Ship_To_Party__c where id=:orderRequest.Ship_To_Party__c];
            orderRequest.SalesDistrictShipto__c=shipToParty.Sales_District__c;
            orderRequest.Customer_Address__c=shipToParty.Address__c;
        }
        }else if(orderRequest.Inco_Terms__c != null && (orderRequest.Inco_Terms__c.equals('EXD')||orderRequest.Inco_Terms__c.equals('EXW')))
        {
      
        eco1='exd';
            if(orderRequest.Account__c != null){
          system.debug('orderRequest.Account__c******'+orderRequest.Account__c);
        account=[select id,Customer_Code__c,Sales_Org__c,Sales_District__c,BillingStreet,BillingCity,BillingPostalCode,BillingCountry from Account where id=:orderRequest.Account__c];
          system.debug('****account.Customer_Code__c'+account.Customer_Code__c);
           orderRequest.Ship_to_Code__c=account.Customer_Code__c;
           orderRequest.SalesDistrictShipto__c=account.Sales_District__c; 
          orderRequest.Ship_To_Party__c=null;
           orderRequest.Customer_Address__c=account.BillingStreet+','+account.BillingCity+','+account.BillingPostalCode+','+account.BillingCountry;
           }
        
        }else
        {
           orderRequest.Ship_to_Code__c='';
           orderRequest.SalesDistrictShipto__c=''; 
           orderRequest.Customer_Address__c='';
           
        }
        
        
        
        }
        
           public void addMoreItems(){
        
            //orderRequest=new Order_Request__c();
        orderBookingLine=new Order_Booking_Line__c();
       
        ListOrdBook.add(orderBookingLine);
       }
          
 public void getDivAndDC(){
  if(orderRequest.Order_Type1__c!= null){
        Order_Type__c orderTypes=[select id,Distribution_Channel__c,Division__c from Order_Type__c  where id=:orderRequest.Order_Type1__c];
        orderRequest.Distribution_Channel__c=orderTypes.Distribution_Channel__c;
        orderRequest.Division__c=orderTypes.Division__c;
  
       }
      }
       public void blockDeletion(){
       orderBookingLine.remove__c=true;
       List<Order_Booking_Line__c> obllist=new List<Order_Booking_Line__c>();
       List<Order_Booking_Line__c> obllistdel=new List<Order_Booking_Line__c>();
         
          String rowId=ApexPages.currentPage().getParameters().get('rowNo');  
           
          obllist.add(orderBookingLine);
       
          if(ListOrdBook.size()>0){
      
                    ListOrdBook.remove(ListOrdBook.size()-1);
                    
                  
                 
              
          }
         
       }
       
         public void materialDetails(){
         
        system.debug('****orderRequest.Order_Type__c****'+orderRequest.Order_Type1__c);
        Order_Type__c ord;
        if(orderRequest.Order_Type1__c != null)
          {
        if(orderRequest.Order_Type1__c !=null)
        {
        ord=[select Order_Type__c from Order_Type__c where id=:orderRequest.Order_Type1__c];
        }
        
          system.debug('****ord.Order_Type__c****'+ord.Order_Type__c);
          
        if(ord.Order_Type__c !='YORD' && ord.Order_Type__c !='YNT')
        {
           String rowId=ApexPages.currentPage().getParameters().get('rowNum');
        
        system.debug('****rowId****'+rowId);
        Integer i=integer.valueof(rowId);

           Product2 material=[select id,Plant__c from Product2 where id=:ListOrdBook[i-1].Material_Code1__c];
            system.debug('****material.Source__c****'+material.Plant__c);
           ListOrdBook[i-1].Plant__c= material.Plant__c;
           }else
           {
            String rowId=ApexPages.currentPage().getParameters().get('rowNum');  
        
        system.debug('****rowId****'+rowId);
        Integer i=integer.valueof(rowId);
        ListOrdBook[i-1].Plant__c= '';
           }
           }else
           {
           
             String rowId=ApexPages.currentPage().getParameters().get('rowNum');
        
        system.debug('****rowId****'+rowId);
        Integer i=integer.valueof(rowId);

           Product2 material=[select id,Plant__c from Product2 where id=:ListOrdBook[i-1].Material_Code1__c];
            system.debug('****material.Source__c****'+material.Plant__c);
           ListOrdBook[i-1].Plant__c= material.Plant__c;
           }
         
        }
       
         public void showOrHideContracts(){
         
         system.debug('**orderRequest.Order_Type1__c**'+orderRequest.Order_Type1__c);
         Order_Type__c order=[select id,name from Order_Type__c where id=:orderRequest.Order_Type1__c];
         
         if(order.name.equals('YCOR'))
         {
           contract='Contracts';
         }else
         {
         contract='';
         }
         
         
         }
         
        public void getContractsDetails()
        {
          system.debug('***orderRequest.Contracts__c****'+orderRequest.Contracts__c);
          if(orderRequest.Contracts__c!=null)
          {
        
            Order__c ord=[select id,Incoterm__c,Net_Price__c,Ship_To_Party_ID__c,Ship_To_Party_ID__r.Sales_District__c,Ship_To_Party_ID__r.Address__c,Order_Qty__c,Material__c,Plant__c from Order__c where id=:orderRequest.Contracts__c];
              system.debug('***ord****'+ord);
          orderRequest.Ship_To_Party__c=ord.Ship_To_Party_ID__c;
          ListOrdBook.get(0).Quantity__c=ord.Order_Qty__c;
          ListOrdBook.get(0).Plant__c=ord.Plant__c;
         if(!orderRequest.Distribution_Channel__c.equals('20'))
           {
           ListOrdBook.get(0).Price__c=ord.Net_Price__c;
           }
           orderRequest.Inco_Terms__c=ord.Incoterm__c;
           
           
            orderRequest.SalesDistrictShipto__c=ord.Ship_To_Party_ID__r.Sales_District__c;
            orderRequest.Customer_Address__c=ord.Ship_To_Party_ID__r.Address__c;
         // ordb.Quantity__c=ord.Order_Qty__c;
          }
            
        }
}