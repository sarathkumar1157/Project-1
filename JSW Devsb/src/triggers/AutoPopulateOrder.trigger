trigger AutoPopulateOrder on Invoice__c (before insert, before update) {
 system.debug('**enterd***');


   List<String> saleOrderNos=new List<String>();
  // List<Order__c> orderList=new List<Order__c>();
   List<String> ShiftToPartycode=new List<String>();
   List<String> SoldTocode=new List<String>();
   List<String> deliveryNumber=new List<String>();
   //---Territory---District---Lookup---Start---//
    Map<String,String> dstmap = new Map<String,String>();
    Map<String,String> termap = new Map<String,String>();
    Map<String,String> prodmap = new Map<String,String>();
    Map<String,String> plntmap = new Map<String,String>();
    Set<String> dststr = new Set<String>();
    Set<String> terstr = new Set<String>();
      List<String> prodList= new List<String>();
    List<String> plantList= new List<String>();
 if(!System.isBatch())
{   
    for(Invoice__c inv : trigger.new)
    {
        if(!String.isBlank(inv.Sales_District__c))
            dststr.add(inv.Sales_District__c);
        if(!String.isBlank(inv.Ship_To_District__c))
            dststr.add(inv.Ship_To_District__c);
        if(!String.isBlank(inv.Sales_Office_Code__c))
            terstr.add(inv.Sales_Office_Code__c);
        if(!String.isBlank(inv.Product__c))
             prodList.add(inv.Product__c);
        if(!String.isBlank(inv.Plant__c))
            plantList.add(inv.Plant__c);
    }
    System.debug('---!!'+terstr);
    List<Districts__c> dstlst = [select id,District_Code__c from Districts__c where District_Code__c IN: dststr];
    List<District__c> terlst = [Select id,Territory_Code__c from District__c where Territory_Code__c IN: terstr];
      List<product2> prodLists= [Select id,ProductCode from product2 where ProductCode IN: prodList];
    List<Plant_Master__c> plantLists= [Select id,Plant_Code__c from Plant_Master__c where Plant_Code__c IN: plantList];
    for(product2 p:prodLists)
    {
        prodmap.put(p.ProductCode,p.id);
    }
    for(Plant_Master__c p:plantLists)
    {
        plntmap.put(p.Plant_Code__c ,p.id);
    }
    for(Invoice__c ord:trigger.new)
   {
     if(prodmap.containsKey(ord.Product__c))
     {
        ord.Products__c=prodmap.get(ord.Product__c);
     }
   }
    
    
     for(Invoice__c ord:trigger.new)
       {
         if(plntmap.containsKey(ord.Plant__c))
         {
            ord.Plant_Master__c=plntmap.get(ord.Plant__c);
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
    
    for(Invoice__c inv : trigger.new)
    {
        inv.Districts__c = dstmap.get(inv.Sales_District__c);
        inv.Ship_To_District_L__c = dstmap.get(inv.Ship_To_District__c);
        inv.Territory__c = termap.get(inv.Sales_Office_Code__c);
    }
    //---Territory---District---Lookup---End---//
    }
   for(Invoice__c inv:trigger.new)
   {
   String soldt=inv.Sold_To_Code__c+inv.Distribution_Channel__c+inv.Division__c;
     String shipto=inv.Ship_to_Code__c+inv.Distribution_Channel__c+inv.Division__c;
     saleOrderNos.add(inv.SO_PO_Number__c);
     ShiftToPartycode.add(shipto);
     SoldTocode.add(soldt);
     deliveryNumber.add(inv.Delivery_Number__c);
      system.debug('SoldTocode****'+SoldTocode);
   
     inv.Original_Invoice_Number__c=inv.Commercial_Invoice_Number__c;
     if(inv.Cancelled_Invoice__c!=null &&  !inv.Commercial_Invoice_Number__c.contains(inv.Cancelled_Invoice__c))
     {
     inv.Commercial_Invoice_Number__c=inv.Commercial_Invoice_Number__c+inv.Cancelled_Invoice__c;
     }else
     {
      inv.Commercial_Invoice_Number__c=inv.Commercial_Invoice_Number__c;

     }
     
   }
   system.debug('SoldTocode****'+SoldTocode);
   
   
  List<Account> accountlist=[select id,Customer_Code__c,ownerid from Account where External_ID__c in:SoldTocode  and External_ID__c != null];
  
  for(Account acclist:accountlist)
  {
    for(Invoice__c inv:trigger.new)
    {
        if(acclist.Customer_Code__c ==inv.Sold_To_Code__c)
        {
           inv.Account__c=acclist.id;
           inv.ownerid=acclist.ownerid;
        }
   
    }
  }
   if(Trigger.isInsert){
  List<Order__c> orderList=[select id,SO_STO_No__c,Invoice_Quantity__c from Order__c where SO_STO_No__c in : saleOrderNos and SO_STO_No__c !=null];
  
    system.debug('orderList****'+orderList);
  
   for(Order__c ord:orderList)
   {
      for(Invoice__c inv:trigger.new)
      {
      if(inv.SO_PO_Number__c==ord.SO_STO_No__c )
        {
         system.debug('ord.Invoice_Quantity__c****'+ord.Invoice_Quantity__c);
         if(ord.Invoice_Quantity__c==null)
         {
           ord.Invoice_Quantity__c=0.00;
         }
          inv.Sales_Orders__c=ord.id;
          ord.Invoice_Quantity__c=ord.Invoice_Quantity__c+inv.Qty__c;
       }
      }
   }
   update orderList;
   }
   List<Ship_To_Party__c> shiptoPartylist=[select id,Customer_Code__c from Ship_To_Party__c where External_ID__c in:ShiftToPartycode  and External_ID__c != null];
   /*List<Ship_To_Party__c> shiptoPartylist1=[select id,Customer_Code__c from Ship_To_Party__c where External_ID__c in:ShiftToPartycode  and External_ID__c != null];
   List<Ship_To_Party__c> shiptoPartylist2=[select id,Customer_Code__c from Ship_To_Party__c where External_ID__c in:ShiftToPartycode  and External_ID__c != null];*/
    
   for(Ship_To_Party__c stplist:shiptoPartylist)
   {
    for(Invoice__c inv:trigger.new)
    {
        if(stplist.Customer_Code__c ==inv.Ship_to_Code__c)
        {
            inv.Ship_To_Party__c=stplist.id;
         }
     }
   
    }
 
  
 List<Delivery__c> deliveryList=[select id,Delivery_No__c from Delivery__c where Delivery_No__c in:deliveryNumber and Delivery_No__c !=null];
  
   for(Delivery__c dellist:deliveryList)
  {
    for(Invoice__c inv:trigger.new)
    {
        if(inv.Delivery_Number__c==dellist.Delivery_No__c)
        {
           inv.Delivery__c=dellist.id;
        }
   
    }
  }
  
}