trigger updatevisits on Week_Plan__c (after update) {
    
    Set<String> wpsubids = new Set<String>();
    Set<String> wpunsubids = new Set<String>();
    Set<String> dpids = new Set<String>();
    List<Day_Plan__c> dplist = new List<Day_Plan__c>();
    
    for(Week_Plan__c wp : trigger.new){
        if(wp.Status__c == 'Submitted'){
            wpsubids.add(wp.id);
        } else if(wp.Status__c == 'Approved'){
            wpunsubids.add(wp.id);
        }     
    }
    
    if(!wpsubids.isEmpty()){
        dplist = [select id,name from Day_Plan__c where Week_Plan__c in: wpsubids];
    } else if(!wpunsubids.isEmpty()){
        dplist = [select id,name from Day_Plan__c where Week_Plan__c in: wpunsubids];
    }
    
    if(dplist.size() > 0){
        for(Day_Plan__c dp : dplist){
            dpids.add(dp.id);
        }
    }
    
    List<Visit__c> vstlist = [select id,name,Week_Plan_Submitted__c from Visit__c where Day_Plan__c in: dpids];
    if(vstlist.size() > 0){
        for(Visit__c vst : vstlist){
            if(vst.Week_Plan_Submitted__c == false){
                vst.Week_Plan_Submitted__c = true;
            } else if(vst.Week_Plan_Submitted__c == true){
                vst.Week_Plan_Submitted__c = false;
            }
        }
        
        update vstlist;
    }
}