global class batchDPReport implements Database.Batchable<sObject> {
    
    String qry {get; set;}
    Set<Date> dateset {get; set;}
    List<Working_Days__c> wrklist {get; set;}
    Map<Date,Boolean> wrkmap {get; set;}
    Map<String,List<Visit__c>> vstmap {get; set;}
    
    public batchDPReport(){
        qry = 'select id,name,Date__c,Number_of_planned_visits__c,Present__c,Accounts__c,Depots__c,Business_Partners__c,Leads__c,Sites__c,Influencers__c,Working_Day__c,(select id,name,Type__c,Visit_Checked_In__c,Planned__c from Visits__r) from Day_Plan__c where Processed__c = false';
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(qry);
    }
    
    global void execute(Database.BatchableContext BC, List<Day_Plan__c> dplist) {
        dateset = new Set<Date>();
        wrkmap = new Map<Date,Boolean>();
        vstmap = new Map<String,List<Visit__c>>();
        for(Day_Plan__c dp : dplist){
            dateset.add(dp.Date__c);
            vstmap.put(dp.id,dp.Visits__r);
        }
        wrklist = [select id,name,Date__c from Working_Days__c where Date__c in: dateset];
        for(Working_Days__c wrk : wrklist){
            wrkmap.put(wrk.Date__c,true);
        }
        for(Day_Plan__c dp : dplist){
            if(wrkmap.containsKey(dp.Date__c)){
                if(wrkmap.get(dp.Date__c) == true){
                    dp.Working_Day__c = true;
                } else {
                    dp.Working_Day__c = false;
                }
            }
            for(Visit__c vst : dp.Visits__r){
                if(vst.Visit_Checked_In__c == true){
                    dp.Present__c = true;
                }
                if(vst.Planned__c == true){
                    if(dp.Number_of_planned_visits__c != null)
                    dp.Number_of_planned_visits__c = dp.Number_of_planned_visits__c + 1;
                    else
                    dp.Number_of_planned_visits__c = 0;
                }
                if(vst.Type__c == 'Account'){
                    if(dp.Accounts__c != null)
                    dp.Accounts__c = dp.Accounts__c + 1;
                    else
                    dp.Accounts__c = 0;
                } else if(vst.Type__c == 'Business Partner'){
                    if(dp.Business_Partners__c != null)
                    dp.Business_Partners__c = dp.Business_Partners__c + 1;
                    else
                    dp.Business_Partners__c = 0;
                } else if(vst.Type__c == 'Depot'){
                    if(dp.Depots__c != null)
                    dp.Depots__c = dp.Depots__c + 1;
                    else
                    dp.Depots__c = 0;
                } else if(vst.Type__c == 'Lead'){
                    if(dp.Leads__c != null)
                    dp.Leads__c = dp.Leads__c + 1;
                    else
                    dp.Leads__c = 0;
                } else if(vst.Type__c == 'Project Site'){
                    if(dp.Sites__c != null)
                    dp.Sites__c = dp.Sites__c + 1;
                    else
                    dp.Sites__c = 0;
                } else if(vst.Type__c == 'Influencer'){
                    if(dp.Influencers__c != null)
                    dp.Influencers__c = dp.Influencers__c + 1;
                    else
                    dp.Influencers__c = 0;
                } 
                dp.Processed__c = true;
            }
        }
        update dplist;
    }
    
    global void finish(Database.BatchableContext BC) {
    
    }
}