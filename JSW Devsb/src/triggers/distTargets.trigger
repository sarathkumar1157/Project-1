trigger distTargets on District_Targets__c (before insert,before update) 
{
    Map<String,String> dstmap = new Map<String,String>();
    List<String> dststr = new List<String>();
    Map<String,String> stmap = new Map<String,String>();
    List<String> ststr = new List<String>();
    
    for(District_Targets__c dt : trigger.new)
    {
        dststr.add(dt.District_Code__c);
        //ststr.add(dt.State_Code__c);
    }
    
    List<Districts__c> dstlst = [select id,State__c,District_Code__c,State_Code__c from Districts__c where District_Code__c IN: dststr];
    //List<State__c> stlst = [select id,State_Code__c from State__c where State_Code__c IN: ststr];
    for(Districts__c dst : dstlst)
    {
        dstmap.put(dst.District_Code__c,dst.id+':'+dst.State_Code__c+':'+dst.State__c);
    }
    /*for(State__c st : stlst)
    {
        stmap.put(st.State_Code__c,st.id);
    }*/
    for(District_Targets__c dt : trigger.new)
    {
        if(dstmap.containsKey(dt.District_Code__c))
        {
            dt.District__c = dstmap.get(dt.District_Code__c).split(':')[0];
            dt.State_Code__c = dstmap.get(dt.District_Code__c).split(':')[1];
            dt.State__c = dstmap.get(dt.District_Code__c).split(':')[2];
        }
        /*if(stmap.containsKey(dt.State_Code__c)) 
            dt.State__c = stmap.get(dt.State_Code__c);*/
    }
}