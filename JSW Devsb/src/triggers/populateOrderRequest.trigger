trigger populateOrderRequest on Order_Booking_Schedule__c (before insert) 
{
    Set<Id> oblIds=new Set<Id>();
    for(Order_Booking_Schedule__c obs:trigger.new)
    {
         oblIds.add(obs.Order_Booking_Line_Item__c);      
    }
    Map<Id,Id> obmap=new Map<Id,Id>() ;
    List<Order_Booking_Line__c> obList=[Select id,Order_Request__c from Order_Booking_Line__c where id in:oblIds];
    for(Order_Booking_Line__c obl: obList)
    {
        obmap.put(obl.id,obl.Order_Request__c );
        System.debug('$$$$$$$'+ obmap);
    }
    for(Order_Booking_Schedule__c obs:trigger.new)
    {
          obs.Order_Request__c=obmap.get(obs.Order_Booking_Line_Item__c);
          System.debug('@@@@@@@'+ obs.Order_Request__c);
    }

}