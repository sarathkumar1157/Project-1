trigger actualsUpdate on Invoice__c (before insert,after update) {
    
    Set<String> accid = new Set<String>();
    Set<String> prdid = new Set<String>();
    Set<Integer> mntid = new Set<Integer>();
    Map<String,String> invmap = new Map<String,String>();
    Integer monthnum = system.today().month();
    String acc = '';
    String prd = '';
    
    for(Invoice__c inv : trigger.new){
        accid.add(inv.Account__c);
        prdid.add(inv.Brand_Short_Form__c);
        if(inv.Commercial_Invoice_Date__c!=null)
        mntid.add(inv.Commercial_Invoice_Date__c.month());
        acc = String.valueOf(inv.Account__c);
        prd = String.valueOf(inv.Brand_Short_Form__c);
        acc = acc + prd;
        
        if(invmap.containsKey(acc)){
            invmap.put(acc, invmap.get(acc).split(':')[0] + inv.Total_value__c+':'+invmap.get(acc).split(':')[1] + inv.Qty__c);
        } else {
            if(inv.Total_value__c != null){
                invmap.put(acc,inv.Total_value__c+':'+inv.Qty__c);
            } else {
                invmap.put(acc,0+':'+0);
            }
        }
    }
    System.debug('###Product Ids: '+prdid);
    try{
        List<Monthly_Targets__c> da = [select id,name,Monthly_Dealer_Target__c,Monthly_Actaul__c,Dealer__c,Product_short__c,Quantity__c  from Monthly_Targets__c where Dealer__c in:accid and Product_short__c in:prdid and Month__c in: mntid ];
        System.debug('###Monthly Targets: '+da);
        for(Monthly_Targets__c mt : da){
            if(mt.Monthly_Actaul__c != null)
            {
            mt.Monthly_Actaul__c = mt.Monthly_Actaul__c + Double.valueOf(invmap.get(String.valueof(mt.Dealer__c)+String.valueOf(mt.Product_short__c)).split(':')[0]);
            mt.Quantity__c = mt.Quantity__c + Double.valueOf(invmap.get(String.valueof(mt.Dealer__c)+String.valueOf(mt.Product_short__c)).split(':')[1]);
            }
            else
            {
            mt.Monthly_Actaul__c = Double.valueOf(invmap.get(String.valueof(mt.Dealer__c)+String.valueOf(mt.Product_short__c)).split(':')[0]);
            mt.Quantity__c = Double.valueOf(invmap.get(String.valueof(mt.Dealer__c)+String.valueOf(mt.Product_short__c)).split(':')[1]);
            }
        }
        update da;
        
        Map<String,String> mdtmap = new Map<String,String>();
        for(Monthly_Targets__c mt : da){
            if(!mdtmap.containsKey(mt.Monthly_Dealer_Target__c)){
                mdtmap.put(mt.Monthly_Dealer_Target__c,mt.Monthly_Actaul__c+':'+mt.Quantity__c);
            } else {
                mdtmap.put(mt.Monthly_Dealer_Target__c,mdtmap.get(mt.Monthly_Dealer_Target__c).split(':')[0] + mt.Monthly_Actaul__c+':'+mdtmap.get(mt.Monthly_Dealer_Target__c).split(':')[1] + mt.Quantity__c );
            }
        }
        List<Monthly_Dealer_Target__c> mdtlist = [select id, name, Actuals__c from Monthly_Dealer_Target__c where id in: mdtmap.keySet()];
        for(Monthly_Dealer_Target__c mdt : mdtlist){
            if(mdt.Actuals__c != null && mdt.Actuals__c > 0){
                mdt.Actuals__c = mdt.Actuals__c + Double.valueOf(mdtmap.get(mdt.id).split(':')[0]);
                mdt.Quantity__c = mdt.Quantity__c + Double.valueOf(mdtmap.get(mdt.id).split(':')[1]);
            } else {
                mdt.Actuals__c = Double.valueOf(mdtmap.get(mdt.id).split(':')[0]);
                mdt.Quantity__c = Double.valueOf(mdtmap.get(mdt.id).split(':')[1]);
            }
        }
        update mdtlist;
    }catch(Exception ex){
        System.debug('The following exception occured');
    }
    
}