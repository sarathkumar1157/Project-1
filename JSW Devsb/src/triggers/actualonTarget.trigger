trigger actualonTarget on Target_Child__c (after insert) 
{
    List<Actuals__c> actl = new List<Actuals__c>();
    for(Target_Child__c tgt : trigger.new)
    {
        Actuals__c act = new Actuals__c();
        act.Type__c = tgt.Type__c;
        actl.add(act);
    }
    insert actl;
}