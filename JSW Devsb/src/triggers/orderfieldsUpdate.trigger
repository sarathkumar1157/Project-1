trigger orderfieldsUpdate on Order_Request__c (before update,before insert) 
{
  system.debug('--Order_Request_Header__c-->');
if(Trigger.isInsert){
   for(Order_Request__c ordrq : trigger.new)
    {
      
        system.debug('--Order_Request_Header__c-->'+ordrq.Order_Request_Header__c);
      
   }
   }else
   {
    Map<String,Order_Request__c> ordmap = new Map<String,Order_Request__c>();
    for(Order_Request__c ordrq : trigger.new)
    {
    
    system.debug('--ordrq.Satus_Message__c-->'+ordrq.Satus_Message__c);
    system.debug('--ordrq.So_Number__c-->'+ordrq.So_Number__c);
    if(ordrq.Status__c== 'E' && ordrq.So_Number__c==null)
       {
         ordrq.Oreder_Error__c=true;
          system.debug('-- ordrq.Oreder_Error__c-->'+ ordrq.Oreder_Error__c);
         }
        Order_Request__c ordold = Trigger.oldMap.get(ordrq.Id);
        system.debug('---->'+ordold.Order_Request_Header__c);
        system.debug('---->'+ordold);
        system.debug('--Order_Request_Header__c-->'+ordrq.Order_Request_Header__c);
        if(ordold.Order_Request_Header__c == ordrq.Order_Request_Header__c)
        {
            ordmap.put(ordrq.Id,ordrq);
        }
    }
    list<Order_Booking_Schedule__c> obslist = [select id,name,Order_Request__c,Status_Message__c,Status__c,SO_Number__c from Order_Booking_Schedule__c where Order_Request__c in: ordmap.keySet()];
    list<Order_Booking_Line__c> obllist = [select id,name,Order_Request__c,Status_Message__c,Status__c,SO_Number__c from Order_Booking_Line__c where Order_Request__c in: ordmap.keySet()];
    for(Order_Booking_Schedule__c obs : obslist)
    {
        obs.Status_Message__c = ordmap.get(obs.Order_Request__c).Satus_Message__c;
        obs.Status__c = ordmap.get(obs.Order_Request__c).Status__c;
        obs.SO_Number__c = ordmap.get(obs.Order_Request__c).SO_Number__c;
        if(ordmap.get(obs.Order_Request__c).Status__c=='E')
        obs.Order_Error__c=true;
    }
    for(Order_Booking_Line__c obl : obllist)
    {
        obl.Status_Message__c = ordmap.get(obl.Order_Request__c).Satus_Message__c;
        obl.Status__c = ordmap.get(obl.Order_Request__c).Status__c;
        obl.SO_Number__c = ordmap.get(obl.Order_Request__c).SO_Number__c;
        if(ordmap.get(obl.Order_Request__c).Status__c=='E')
        obl.Order_Error__c=true;
    }
    update obslist;
    update obllist;
    }
}