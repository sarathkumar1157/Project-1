trigger orderUpdate on Order__c (before insert,before update) {


Set<String> soids = new Set<String>();

    //---Territory---District---Lookup---Start---//
    Map<String,String> dstmap = new Map<String,String>();
    Map<String,String> termap = new Map<String,String>();
    List<String> dststr = new List<String>();
    List<String> terstr = new List<String>();
    List<String> prodList= new List<String>();
    List<String> plantList= new List<String>();
    for(Order__c ord : trigger.new)
    {
        dststr.add(ord.Ship_To_Sales_District__c);
        dststr.add(ord.Sold_To_Sales_District__c);
        terstr.add(ord.Sales_Off__c);
        prodList.add(ord.Material__c);
        plantList.add(ord.Plant__c);
    }
    
    List<Districts__c> dstlst = [select id,District_Code__c from Districts__c where District_Code__c IN: dststr];
    List<District__c> terlst = [Select id,Territory_Code__c from District__c where Territory_Code__c IN: terstr];
    List<product2> prodLists= [Select id,ProductCode from product2 where ProductCode IN: prodList];
    List<Plant_Master__c> plantLists= [Select id,Plant_Code__c from Plant_Master__c where Plant_Code__c IN: plantList];
    for(product2 p:prodLists)
    {
       
       for(Order__c ord:trigger.new)
       {
         if(ord.Material__c==p.ProductCode)
         {
            ord.Product__c=p.id;
         }
       }
    }
    
     for(Plant_Master__c p:plantLists)
    {
       
       for(Order__c ord:trigger.new)
       {
         if(ord.Plant__c==p.Plant_Code__c )
         {
            ord.Plant_Master__c=p.id;
         }
       }
    }
    
    
    
    for(Districts__c dst : dstlst)
    {
        dstmap.put(dst.District_Code__c, dst.id);
    }
    for(District__c ter : terlst)
    {
        termap.put(ter.Territory_Code__c, ter.id);
    }
    
    for(Order__c ord : trigger.new)
    {
        ord.Districts__c = dstmap.get(ord.Ship_To_Sales_District__c);
        ord.Sold_To_District__c = dstmap.get(ord.Sold_To_Sales_District__c);
        ord.Territory__c = termap.get(ord.Sales_Off__c);
    }
    //---Territory---District---Lookup---End---//
    
 for(Order__c ord:trigger.new){
  soids.add(ord.Sold_To_Party__c );
}
list<account> aclist=[select id,name,ownerid,Customer_Code__c from account where External_ID__c in:soids];

List<String> SoldToPartycode=new List<String>();
List<String> ShiftToPartycode=new List<String>();
List<String> SalesEmpcode=new List<String>();
List<String> orderRequestList=new List<String>();

for(Order__c order:trigger.new){
String soldt=order.Sold_To_Party__c+order.Distribution_Channel__c+order.Division__c;
String shipTo=order.Shp_To_Party__c+order.Distribution_Channel__c+order.Division__c;
String salesEmp=order.Sales_Emp__c+order.Distribution_Channel__c+order.Division__c;
SoldToPartycode.add(soldt);
ShiftToPartycode.add(shipTo);
SalesEmpcode.add(salesEmp);
    system.debug('***order.Order_Request_Number__c**'+order.Order_Request_Number__c);
orderRequestList.add(order.Order_Request_Number__c);
}

List<Account> acclist=[select id,Customer_Code__c,ownerid from Account where External_ID__c in:SoldToPartycode and External_ID__c !=null];
system.debug('***acclist**'+acclist);
for(Account acc:acclist){
for(Order__c ord:trigger.new){
if(ord.Sold_To_Party__c==acc.Customer_Code__c){
ord.Account__c=acc.id;
system.debug('***acc.ownerid**'+acc.ownerid);
ord.ownerid=acc.ownerid;
 }
 }
}

List<Ship_To_Party__c> shiptoPartylist=[select id,Customer_Code__c from Ship_To_Party__c where External_ID__c in:ShiftToPartycode and External_ID__c !=null];
system.debug('***ShiftToPartycode**'+ShiftToPartycode);
    system.debug('***shiptoPartylist**'+shiptoPartylist);
for(Ship_To_Party__c stplist:shiptoPartylist){
for(Order__c ord:trigger.new){
if(ord.Shp_To_Party__c==stplist.Customer_Code__c){
ord.Ship_To_Party_ID__c=stplist.id;
 }
 }
}

List<Business_Partner__c> businesslist=[select id,Customer_Code__c from Business_Partner__c where ExternalId__c in:SalesEmpcode and ExternalId__c !=null];
for(Business_Partner__c bpartnerlist:businesslist){
for(Order__c ord:trigger.new){
if(ord.Sales_Emp__c==bpartnerlist.Customer_Code__c){
ord.Sales_Employee__c =bpartnerlist.id;
 }
 }
}

List<Order_Request__c> ordReqList=[select id,name from Order_Request__c where name in:orderRequestList];
List<Order_Booking_Line__c> ordLineList=[select id,name,Order_Request_Name__c,Quantity__c  from Order_Booking_Line__c where Order_Request_Name__c in:orderRequestList];
for(Order_Request__c orlist: ordReqList){
for(Order__c ord:trigger.new){
if(ord.Order_Request_Number__c == orlist.name){
ord.Order_Request__c = orlist.id;
 }
 }
}


for(Order_Booking_Line__c orlist1: ordLineList){
for(Order__c ord:trigger.new){
if(ord.Order_Request_Number__c == orlist1.Order_Request_Name__c){
ord.Ordered_Quantity__c= orlist1.Quantity__c;
 }
 }
}

  


}