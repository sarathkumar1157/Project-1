@RestResource(urlMapping='/VisitsManagement/*')
global with sharing class VisitsWebservice{

  @HttpPost
    global static List<Visit__c> doPost(String userId) {
        
        User mobusr = [select id,name,userroleid,userrole.name,Profile.Name from user where id =: userId];
        
        list<Visit__c> VisitsList = [SELECT Id,Name,Name__c,Type__c,Account__c,Account__r.Name,Business_Partner__c,Lead__c,Lead__r.Name,
                                    Business_Partner__r.Name,Influencer__c,Influencer__r.Name,Project_Site__c,Project_Site__r.Name,Check_In__c,Check_Out__c,POP_material_comments__c,
                                   Ownerid,Owner.Name,Planned_Date__c,Planned__c,Check_In_Time__c,Check_Out_Time__c,Purpose_of_Visit__c,Any_image_to_be_captured__c,
                                   Payment_Amount_Collected_by_SO__c,Pending_Payment_Amount_Committed_Date__c,JSW_Bag_Visibility__c,Visit_Status__c,
                                   JSW_Shop_Board_Condition__c,Stock_level_JSW__c,Visited_Location__c,Location__c FROM Visit__c where Ownerid =: mobusr.id and Planned__c = true];
        return VisitsList;
    }
 
}