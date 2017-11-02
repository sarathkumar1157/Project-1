public class ApprovalSubmission{
    public String pjpid {get; set;}
    public List<Week_Plan__c> wplist {get; set;}
    
    public ApprovalSubmission(){
        pjpid = ApexPages.currentPage().getParameters().get('id');
        wplist = [select id,name,Start_Date__c,End_Date__c,Month_Plan__c,Size__c,Submitted_for_Approval__c,Status__c from Week_Plan__c where Month_Plan__c =: pjpid and (Status__c = 'New Request' or Status__c = 'Rejected')];
    }
    
    public pageReference pjptab(){
        pageReference pref = new pageReference('/a04/o');
        pref.setRedirect(true);
        return pref;
    }
    
    public pageReference submitforapproval(){
        List<Week_Plan__c> sublist = new List<Week_Plan__c>();
        for(Week_Plan__c wp : wplist){
            if(wp.Submitted_for_Approval__c == true)
            sublist.add(wp);
        }
        
        for(Week_Plan__c wp : sublist){
            try{
            Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
            req1.setComments('Submitting request for approval');
            req1.setObjectId(wp.id);
            req1.setSubmitterId(userInfo.getUserId());
            Approval.ProcessResult result = Approval.process(req1);
            }catch(Exception ex){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please select your approver as Manager'));
            }
        }
        
        //PageReference pref = new PageReference('/apex/DailyVisitPlanView?id='+pjpid);
        PageReference pref = new PageReference('/'+pjpid);
        pref.setRedirect(true);
        return pref;
    }
}