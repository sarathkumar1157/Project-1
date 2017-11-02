trigger dealerUpdate on Monthly_Targets__c (after insert,after update) 
{
    Map<String,String> mdtmap = new Map<String,String>();
    Double totalA = 0.00;
    Double totalQ = 0.00;
    Double totalT = 0.00;
    for(Monthly_Targets__c mt : trigger.new)
    {
        if(!mdtmap.containsKey(mt.Monthly_Dealer_Target__c))
        {
            if(mt.Monthly_Actaul__c != null)
            	mdtmap.put(mt.Monthly_Dealer_Target__c,String.valueOf(mt.Monthly_Actaul__c));
            else
                mdtmap.put(mt.Monthly_Dealer_Target__c,'0.00');
            if(mt.Quantity__c != null)
            	mdtmap.put(mt.Monthly_Dealer_Target__c,mdtmap.get(mt.Monthly_Dealer_Target__c)+':'+String.valueOf(mt.Quantity__c));
            else
                mdtmap.put(mt.Monthly_Dealer_Target__c,mdtmap.get(mt.Monthly_Dealer_Target__c)+':'+'0.00');
            if(mt.Monthly_Target__c != null)
            	mdtmap.put(mt.Monthly_Dealer_Target__c,mdtmap.get(mt.Monthly_Dealer_Target__c)+':'+String.valueOf(mt.Monthly_Target__c));
            else
                mdtmap.put(mt.Monthly_Dealer_Target__c,mdtmap.get(mt.Monthly_Dealer_Target__c)+':'+'0.00');
        } 
        else 
        {
            totalA = Double.valueOf(mdtmap.get(mt.Monthly_Dealer_Target__c).split(':')[0]) + Double.valueOf(mt.Monthly_Actaul__c);
            totalQ = Double.valueOf(mdtmap.get(mt.Monthly_Dealer_Target__c).split(':')[1]) + Double.valueOf(mt.Quantity__c);
            totalT = Double.valueOf(mdtmap.get(mt.Monthly_Dealer_Target__c).split(':')[2]) + Double.valueOf(mt.Monthly_Target__c);
            mdtmap.put(mt.Monthly_Dealer_Target__c,totalA+':'+totalQ+':'+totalT );
        }
        /*if(!mdtmap.containsKey(mt.Monthly_Dealer_Target__c))
        {
            if(mt.Monthly_Actaul__c != null && mt.Quantity__c != null)
            {
                totalA = totalA + mt.Monthly_Actaul__c;
                totalQ = totalQ + mt.Quantity__c;
            }	
            else if(mt.Monthly_Actaul__c != null && mt.Quantity__c == null)
            {
                totalA = totalA + Monthly_Actaul__c;
                totalQ = totalQ;
            }
            else if(mt.Monthly_Actaul__c == null && mt.Quantity__c != null)
                mdtmap.put(mt.Monthly_Dealer_Target__c,0.00+':'+mt.Quantity__c);
            else
                mdtmap.put(mt.Monthly_Dealer_Target__c,0.00+':'+0.00);
        } 
        else 
        {
            mdtmap.put(mt.Monthly_Dealer_Target__c,Double.valueOf(mdtmap.get(mt.Monthly_Dealer_Target__c).split(':')[0]) + Double.valueOf(mt.Monthly_Actaul__c)+':'+Double.valueOf(mdtmap.get(mt.Monthly_Dealer_Target__c).split(':')[1]) + Double.valueOf(mt.Quantity__c) );
        }*/
    }
    system.debug('--->'+mdtmap);
    List<Monthly_Dealer_Target__c> mdtlist = [select id, name, Actuals__c,Quantity__c,Target__c from Monthly_Dealer_Target__c where id in: mdtmap.keySet()];
    for(Monthly_Dealer_Target__c mdt : mdtlist)
    {
        mdt.Actuals__c = Double.valueOf(mdtmap.get(mdt.id).split(':')[0]);
        mdt.Quantity__c = Double.valueOf(mdtmap.get(mdt.id).split(':')[1]);
        mdt.Target__c = Double.valueOf(mdtmap.get(mdt.id).split(':')[2]);
    }
    update mdtlist;
}