global class batchPJPReport implements Database.Batchable<sObject> {
//public class batchPJPReport {    
    public String qry {get; set;}
    public Set<Id> pjpids {get; set;}
    public Set<Id> vstids {get; set;}
    public List<Visit__c> vstlist {get; set;}
    public Integer pcount {get; set;}
    public Integer pvcount {get; set;}
    public Integer uvcount {get; set;}
    public Integer mkcount {get; set;}
    public Integer prcount {get; set;}
    public Map<Id,String> pjpcount {get; set;}
    public Map<Id,String> vstcount {get; set;}
    //public List<Month_Plan__c> pjplist {get; set;}
    public String[] newcount {get; set;}
    public String countstr {get; set;}
    public List<Market_Information__c> mklist {get; set;}
    
    public batchPJPReport(String query){
        pjpids = new Set<Id>();
        vstids = new Set<Id>();
        pjpcount = new Map<Id,String>();
        vstcount = new Map<Id,String>();
        vstlist = new List<Visit__c>();
        //pjplist = [select id,name,Total_No_of_Visits_Planned__c,Total_No_of_Visits_Check_In_Planned__c,Total_no_of_Visits_Unplanned__c,
        //           Market_Information_Count__c,Price_Reading_Count__c  from Month_Plan__c where RecordType.Name = 'PJP'];
        qry = query;
    
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(qry);
    }
    
    global void execute(Database.BatchableContext BC, List<Month_Plan__c> pjplist) {
        for(Month_Plan__c pjp : pjplist){
            pjpids.add(pjp.id);
        }
        System.debug('@@@@'+pjpids);
        vstlist = [select id,name,Market_Information_Count__c,Price_Reading_Count__c,Planned__c,Visit_Checked_In__c,Day_Plan__r.Month_Plan__c from Visit__c where Day_Plan__r.Month_Plan__c in: pjpids];
        System.debug(vstlist+'@@@@vstlist');
        for(Visit__c vst : vstlist){
            vstids.add(vst.id);
        }
        
        mklist = [select id,name,Visit__c, (select id,name from Market_Information__r) from Market_Information__c where Visit__c in: vstids];
        System.debug(mklist+'@@@@mklist');
        
        for(Market_Information__c mi : mklist){
            mkcount = 0;
            prcount = 0;
            
            if(vstcount.containsKey(mi.Visit__c)){
                mkcount = Integer.valueOf(vstcount.get(mi.Visit__c).split(' ')[0]) + 1;
            } else {
                mkcount = mkcount + 1;
            }
            vstcount.put(mi.Visit__c,String.valueOf(mkcount)+' '+String.valueOf(mi.Market_Information__r.size()>0?mi.Market_Information__r.size():0));
        }
        for(Visit__c vst : vstlist){
            if(vstcount.containskey(vst.id)){
                vst.Market_Information_Count__c = Integer.valueOf(vstcount.get(vst.id).split(' ')[0]);
            	vst.Price_Reading_Count__c = Integer.valueOf(vstcount.get(vst.id).split(' ')[1]);
            } else {
                vst.Market_Information_Count__c = 0;
                vst.Price_Reading_Count__c = 0;
            } 
        }
        
        System.debug(vstcount+'@@@@vstcount');
        
        update vstlist;
        
        
        for(Visit__c vst : vstlist){
            pcount = 0;
            pvcount = 0;
            uvcount = 0;
            mkcount = 0;
            prcount = 0;
            newcount = new List<String>();
            countstr = '';
            
            if(pjpcount.containsKey(vst.Day_Plan__r.Month_Plan__c)){
                newcount = pjpcount.get(vst.Day_Plan__r.Month_Plan__c).split(' ');
                System.debug(newcount.size()+'@@@@newcount'+newcount+'@@@@@'+vst.id);
                mkcount = Integer.valueOf(vst.Market_Information_Count__c) + Integer.valueOf(newcount[3]);
                prcount = Integer.valueOf(vst.Price_Reading_Count__c + newcount[4]);
                countstr = newcount[0]+' '+newcount[1]+' '+newcount[2];
                System.debug('@@@@'+Integer.valueOf(vst.Price_Reading_Count__c + newcount[4]));
                if(vst.Planned__c == true){
                    System.debug('Inside contains key pcount');
                    pcount = Integer.valueOf(newcount[0]) + 1;
                    countstr = String.valueOf(pcount)+' '+newcount[1]+' '+newcount[2];
                }
                if(vst.Planned__c == true && vst.Visit_Checked_In__c == true){
                    System.debug('Inside contains key pvcount');
                    pvcount = Integer.valueOf(newcount[1]) + 1;
                    countstr = newcount[0]+' '+String.valueOf(pvcount)+' '+newcount[2];
                }
                if(vst.Planned__c == false && vst.Visit_Checked_In__c == true){
                    System.debug('Inside contains key uvcount');
                    uvcount = Integer.valueOf(newcount[2]) + 1;
                    countstr = newcount[0]+' '+newcount[1]+' '+String.valueOf(uvcount);
                }
            } else {
                mkcount = Integer.valueOf(vst.Market_Information_Count__c);
                prcount = Integer.valueOf(vst.Price_Reading_Count__c);
                if(vst.Planned__c == true){
                    System.debug('Inside dosen\'t contain key pcount');
                    pcount = pcount + 1;
                }
                if(vst.Planned__c == true && vst.Visit_Checked_In__c == true){
                    System.debug('Inside dosen\'t contain key pvcount');
                    pvcount = pvcount + 1;
                }
                if(vst.Planned__c == false && vst.Visit_Checked_In__c == true){
                    System.debug('Inside dosen\'t contain key ucount');
                    uvcount = uvcount + 1;
                }
                countstr = String.valueOf(pcount)+' '+String.valueOf(pvcount)+' '+String.valueOf(uvcount);
            }
            System.debug('@@@'+countstr);
            pjpcount.put(vst.Day_Plan__r.Month_Plan__c,countstr+' '+String.valueOf(mkcount)+' '+String.valueOf(prcount));
        }
        System.debug('@@@@Inside '+ pjpcount);
        for(Month_Plan__c pjp : pjplist){
            if(pjpcount.containsKey(pjp.id)){
                newcount = pjpcount.get(pjp.id).split(' ');
            	pjp.Total_No_of_Visits_Planned__c = Integer.valueOf(newcount[0]);
            	pjp.Total_No_of_Visits_Check_In_Planned__c = Integer.valueOf(newcount[1]);
            	pjp.Total_no_of_Visits_Unplanned__c = Integer.valueOf(newcount[2]);
            	pjp.Market_Information_Count__c = Integer.valueOf(newcount[3]);
            	pjp.Price_Reading_Count__c = Integer.valueOf(newcount[4]);
            } else {
                pjp.Total_No_of_Visits_Planned__c = 0;
            	pjp.Total_No_of_Visits_Check_In_Planned__c = 0;
            	pjp.Total_no_of_Visits_Unplanned__c = 0;
            	pjp.Market_Information_Count__c = 0;
            	pjp.Price_Reading_Count__c = 0;
            }
        }
        update pjplist;
    }
    
    global void finish(Database.BatchableContext BC) {
    
    }
}