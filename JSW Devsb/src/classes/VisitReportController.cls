public class VisitReportController{
    public List<User> usrlist {get; set;}
    public set<id> setids {get; set;}
    public List<Month_Plan__c> pjplist {get; set;}
    public Map<String,Integer> visitcount {get; set;}
    public Map<String,Integer> plannedcount {get; set;}
    public List<Visit__c> vstlist {get; set;}
    public Integer totalvst {get; set;}
    public Integer plandvst {get; set;}
    public List<ReportWrapper> rwplist {get; set;}
    
    public VisitReportController(){
        setids = new set<id>();
        visitcount = new Map<String,Integer>();
        plannedcount = new Map<String,Integer>();
        usrlist = [select id,name,UserRole.Name from User where ContactId = null and UserRoleId != null];
        for(User usr : usrlist){
            setids.add(usr.id);
        }
        
        vstlist = [select id,name,Ownerid,Visit_Checked_In__c from Visit__c where Ownerid in: setids];
        for(Visit__c vst : vstlist){
            if(plannedcount.containsKey(vst.Ownerid)){
                totalvst = plannedcount.get(vst.ownerid) + 1;
            } else {
                totalvst = 1;
            }
            plannedcount.put(vst.Ownerid,totalvst);
            if(vst.Visit_Checked_In__c == true){
                if(visitcount.containsKey(vst.Ownerid)){
                    plandvst = visitcount.get(vst.ownerid) + 1;
                } else {
                    plandvst = 1;
                }
                plannedcount.put(vst.Ownerid,plandvst);
            }
        }
        System.debug('@@@'+plannedcount);
        System.debug('@@@'+visitcount);
        rwplist = new List<ReportWrapper>();
        for(User usr : usrlist){
            ReportWrapper rwp = new ReportWrapper();
            rwp.name = usr.Name;
            rwp.role = usr.UserRole.Name;
            rwp.perdaytrg = 150;
            if(plannedcount.containsKey(usr.id))
            rwp.totalvst = plannedcount.get(usr.id);
            else
            rwp.totalvst = 0;
            if(visitcount.containsKey(usr.id))
            rwp.vstact = visitcount.get(usr.id);
            else
            rwp.vstact = 0;
            rwplist.add(rwp);
        }
    }
    
    
    public class ReportWrapper{
        public String name {get; set;}
        public String role {get; set;}
        public Integer totalvst {get; set;}
        public Integer vstact {get; set;}
        public Integer perdaytrg {get; set;}
    }
}