trigger InsertCustomEvent on Event (after insert) {
    List<Event__c> evntlist = new List<Event__c>();
    for(Event evt : trigger.new){
        Event__c newevt = new Event__c();
        newevt.Name = evt.Subject;
        newevt.Event_id__c = evt.id;
        newevt.Ownerid = evt.Ownerid;
        newevt.Budget__c = evt.Budget__c;
        newevt.Event__c = evt.Event__c;
        newevt.No_Of_Invitees_for_Each_Meet__c = evt.No_Of_Invitees_for_Each_Meet__c;
        newevt.Product__c = evt.Product__c;
        newevt.Type_of_Meet__c = evt.Type_of_Meet__c;
        if(evt.Districts__c != null)
        newevt.Districts__c = evt.Districts__c;
        if(evt.Territory__c != null)
        newevt.District__c = evt.Territory__c;
        evntlist.add(newevt);
    }
    insert evntlist;
}