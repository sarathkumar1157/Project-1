public class WeekPlanController{
    public List<Visit__c> dailyVstList {get; set;}
    public Week_Plan__c wplan {get; set;}
    public String weekid {get; set;}
    public Boolean flag {get; set;}
    
    public WeekPlanController(ApexPages.StandardController controller){
        weekid = ApexPages.currentPage().getParameters().get('id');
        wplan = [select id,name,Start_Date__c,End_Date__c,Month_Plan__c,Status__c from Week_Plan__c where id =: weekid];
        dailyVstList = [select id,Name__c,Planned_Date__c,Visited__c,Past__c,Account__c,Lead__c,Event__c,Customer_Type__c,Area__c from Visit__c where Day_Plan__r.Week_Plan__c =: weekid];
        flag = dailyVstList.isEmpty();
    }
    
    public pageReference pjptab(){
        Schema.DescribeSObjectResult PJPDest = Month_Plan__c.sObjectType.getDescribe();
        pageReference pref = new pageReference('/'+PJPDest.getKeyPrefix()+'/o');
        pref.setRedirect(true);
        return pref;
    }
    
    public pageReference monthtab(){
        pageReference pref = new pageReference('/'+wplan.Month_Plan__c);
        pref.setRedirect(true);
        return pref;
    }
    
    public pageReference directApprove(){
        Approval.ProcessWorkitemRequest[] prWkItems = New Approval.ProcessWorkItemRequest[]{};
            
            ProcessInstance[] pi = [Select ID, Status, TargetObject.Name, 
                                        (SELECT Id, ActorId, ProcessInstanceId FROM Workitems),
                                        (SELECT Id, StepStatus, Comments FROM Steps) From ProcessInstance Where TargetObjectID =:weekid AND Status = 'Pending'];
            
            for(ProcessInstance instance : pi){
                for(ProcessInstanceWorkItem workItem : instance.WorkItems){
                    Approval.ProcessWorkitemRequest prWkItem = new Approval.ProcessWorkitemRequest();
                    
                    prWkItem.setWorkItemID(workItem.id);
                    prWkItem.setComments('Approved by ' + userInfo.getName());
                    prWkItem.setAction('Approve');
                    prWkItems.add(prWkItem);
                  
                }
            }          
            
            if(!prWkItems.isEmpty()){
                Approval.ProcessResult[] appResult = Approval.process(prWkItems);
            }
            
            PageReference pref = new PageReference('/'+weekid);
            pref.setRedirect(true);
            return pref;
    }
    
    public pageReference directReject(){
        String wrkitmid;
        Approval.ProcessWorkitemRequest[] prWkItems = New Approval.ProcessWorkItemRequest[]{};
            
            ProcessInstance[] pi = [Select ID, Status, TargetObject.Name, 
                                        (SELECT Id, ActorId, ProcessInstanceId FROM Workitems),
                                        (SELECT Id, StepStatus, Comments FROM Steps) From ProcessInstance Where TargetObjectID =:weekid AND Status = 'Pending'];
            for(ProcessInstance instance : pi){
                for(ProcessInstanceWorkItem workItem : instance.WorkItems){
                    wrkitmid = String.valueOf(workItem.id);
                }
            }
            PageReference pref = new PageReference('/p/process/ProcessInstanceWorkitemWizardStageManager?id='+wrkitmid);
            pref.setRedirect(true);
            return pref;
    }
}