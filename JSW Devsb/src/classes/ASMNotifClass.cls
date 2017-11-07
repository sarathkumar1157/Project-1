global class ASMNotifClass implements Database.batchable<sObject>{
    public List<User> solist {get; set;}
    public Set<Id> soids {get; set;}
    public List<Month_Plan__c> pjplist {get; set;}
    public Map<Integer,String> MonthMap {get; set;}
    public Map<Id,Id> sopjpmap {get; set;}
    public String monthname {get; set;}
    public String body {get; set;}
    public Integer curmonth {get; set;}
    public User pjpusr {get; set;}
    public String qry {get; set;}
     
    
    public ASMNotifClass(){
        solist = new List<User>();
        soids = new Set<Id>();
        pjplist = new List<Month_Plan__c>();
        MonthMap = new Map<Integer,String>();
        sopjpmap = new Map<Id,Id>();
        monthname = '';
        pjpusr = new User();
        
        MonthMap.put(1,'January');
        MonthMap.put(2,'February');
        MonthMap.put(3,'March');
        MonthMap.put(4,'April');
        MonthMap.put(5,'May');
        MonthMap.put(6,'June');
        MonthMap.put(7,'July');
        MonthMap.put(8,'August');
        MonthMap.put(9,'September');
        MonthMap.put(10,'October');
        MonthMap.put(11,'November');
        MonthMap.put(12,'December');
        
        if(system.today().day() >= 1 && system.today().day() <= 5){
            curmonth = system.today().month();
            monthname = MonthMap.get(curmonth);
        } else {
            curmonth = system.today().month()+1;
            monthname = MonthMap.get(curmonth);
        }
        qry = 'select id,name,Start_Date__c,Status__c,Ownerid from Month_Plan__c where Status__c != \'Approved\' and Status__c != \'Submitted\' and CALENDAR_MONTH(Start_Date__c) =: curmonth';
    }
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(qry);
    }
    global void execute(Database.BatchableContext BC, List<Month_Plan__c> pjplist){
        if(pjplist.size() > 0){
            for(Month_Plan__c pjp : pjplist){
                soids.add(pjp.Ownerid);
            }
        }
        solist = [select id,name,UserRole.Name,Email,Manager.Email from User where Id in: soids and Profile.Name != 'System Administrator'];
        if(solist.size()> 0){
            List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>();
            for(User usr : solist){
                body = '';
                body = '<html><body>Dear Mr. '+ usr.Name + ',<br/><br/>';
                body = body + 'Your PJP for the month of '+ monthname +' is due for submission. Kindly create and submit your PJP at the earliest.';
                body = body + '<br/><br/>Regards,<br/>SFDC<br/><br/>';
                body = body + '</body></html>';
                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                message.toAddresses = new String[]{usr.Email};
                if(usr.Manager.Email != null)
                message.CcAddresses = new String[]{usr.Manager.Email};
                message.BCcAddresses = new String[]{'slomada@bodhtree.com'};
                message.subject = 'PJP Submission Reminder';
                message.HtmlBody = body;
                messages.add(message);
                
            }
            
            Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
            if (results[0].success) {
                System.debug('The email was sent successfully.');
            } else {
                System.debug('The email failed to send: '
                             + results[0].errors[0].message);
            }
        }
    }
    global void finish(Database.BatchableContext BC){
    }
}