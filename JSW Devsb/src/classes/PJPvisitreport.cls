public class PJPvisitreport {

    public static void pjpvisit(){
    
        List<Month_Plan__c> pjplist = new List<Month_Plan__c>();
        List<Messaging.SingleEmailMessage> lstmail = new List<Messaging.SingleEmailMessage>();
        List<user> usrlist = [Select id, Name, Email, ManagerId,(Select id,Name,Status__c,User__r.Name,Start_Date__c from Month_Plan__r
                                 where Status__c='New Request' and Start_Date__c = NEXT_MONTH) from User where 
                                ManagerId != null and (Profile.Name = 'JSW SO' or Profile.Name = 'JSW Technical Services')];
        Map<Id,Id> soasmmap = new Map<Id,Id>();
        Map<Id,User> asmmap = new Map<Id,User>();
        Map<Id,List<Month_Plan__c>> asmpjpmap = new Map<Id,List<Month_Plan__c>>();
        Set<Id> asmids = new Set<Id>();
        
        for(User usr : usrlist){
            asmids.add(usr.ManagerId);
            soasmmap.put(usr.id,usr.ManagerId);    
        }
        
        asmmap = new Map<Id,User>([Select id, Name, Email from User where id in: asmids]);
        
        for(User usr : usrlist){
            if(usr.Month_Plan__r.size() > 0){
                if(asmpjpmap.containsKey(usr.managerid)){
                    pjplist = new List<Month_Plan__c>();
                    pjplist.addAll(usr.Month_Plan__r);
                    pjplist.addAll(asmpjpmap.get(usr.managerid));
                    asmpjpmap.put(usr.managerid,pjplist);
                } else {
                    asmpjpmap.put(usr.managerid,usr.Month_Plan__r);
                }
            }
        }
        
        System.debug(asmpjpmap);
        System.debug(asmpjpmap.keySet());
        for(Id usr : asmpjpmap.keySet()){
            System.debug(asmpjpmap.get(usr));
        }
        
        for(Id usr : asmpjpmap.keySet()){
            string htmlbody = '<html><body>Dear '+ asmmap.get(usr).Name +',<br/><br/>';
            htmlbody = htmlbody + 'Please find the list of unsubmitted pjps below: <br/><br/>';
            htmlbody = htmlbody + '<table border="1"><tr><th>PJP Name</th><th>User</th><th>Date</th><th>Status</th></tr>';
            
            for(Month_Plan__c pjp : asmpjpmap.get(usr)){
                htmlbody = htmlbody + '<tr><td>' + pjp.Name + '</td><td>' + pjp.User__r.Name + '</td><td>' + pjp.Start_Date__c + '</td><td>' + pjp.Status__c + '</td></tr>';
            }
            
            htmlbody = htmlbody + '</table><br/></body></html>';
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.setSenderDisplayName('JSW Cement');
            message.setSubject('Unsubmitted PJPs');
            message.setHtmlBody(htmlbody);
            message.setToAddresses(new String[]{'slomada@bodhtree.com'});
            //message.setCcAddresses(new String[]{asmmap.get(usr).Email});
            lstmail.add(message);
        }
        
        Messaging.sendEmail(lstmail);
    }
}