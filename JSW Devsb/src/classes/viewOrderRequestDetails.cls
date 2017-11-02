public class viewOrderRequestDetails{
    public String id{get;set;}
    public Order_Request__c orderRequest{get;set;}
    public Order_Booking_Line__c orderBookingLine{get;set;}
        public viewOrderRequestDetails(ApexPages.StandardController controller){
          id=ApexPages.currentPage().getParameters().get('id');
          system.debug('@@ID'+id);
          orderRequest=[select id,Name,Address1__c,Address2__c,Address3__c,Address4__c, Alt_Tax_Class__c,Contact_Number__c, Contracts__c,Created_Date__c,Created_Time__c,Credit_Available__c,Credit_Outstanding__c,Credit_Overdue__c,Customer_Address__c,Customer_Nmae__c,Account__c,Sales_District__c,Distribution_Channel_Description__c,Distribution_Channel__c,Division_Description__c,Division__c,INC__c,INC_Name__c,Inco_Terms__c,MMCName__c, MMCCode__c, Month_Of_Date__c,Oreder_Error__c,Order_Request_Header__c,Order_Type1__c,Order_Type__c,Order_Type_Name__c,Po_Number__c,Quantity__c,Sales_Employee__c,Sales_Org__c,Sales_Promoter_Name__c,Sales_Promotor__c,Sap_No__c,Shipment_Address__c,Shipment_Type__c,Ship_to_Code__c,Ship_To_Party__c,Ship_To_Party_Nmae__c,SalesDistrictShipto__c, So_Number__c,Status__c, Satus_Message__c,Sub_Dealer__c,SubDealer_Name__c,Tax_Type__c from Order_Request__c where id=:id];
          orderBookingLine=[select id,Creation_Date__c,Creation_Time__c,Delivery__c, Material_Code1__c,Material_Code__c, Material_CodeName__c,Order_Error__c,Order_Request__c,Order_Request_Line__c,Order_Request_Name__c,Packing_Type__c,Plant__c,Price__c,Quantity__c,remove__c,rowNO__c,SFDC_Product_Code__c,So_Item_Number__c,SO_Number__c,Status__c,Status_Message__c,Test__c from Order_Booking_Line__c where Order_Request__r.id=:id];
      
    }
   public pagereference editPage(){
    id=ApexPages.currentPage().getParameters().get('id');
    system.debug('@@@id'+id);
    PageReference editPage= new pagereference('https://jswcements--jswdevsb--c.cs57.visual.force.com/apex/editOrderRequestDetails?id='+id);
           editPage.setRedirect(true);
         return editPage; 
   }
}