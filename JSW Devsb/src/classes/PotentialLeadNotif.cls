global class PotentialLeadNotif implements Database.batchable<sObject>{
    public String qry {get; set;}
    public Set<Id> ownerids {get; set;}
    public Set<Id> managerids {get; set;}
    public Set<Id> siteids {get; set;}
    public List<User> vstowners {get; set;}
    public List<User> asmlist {get; set;}
    public List<User> templist {get; set;}
    public Set<Id> tempidlist {get; set;}
    public List<String> ccaddress {get; set;}
    public List<Project_Site__c> tempsitelist {get; set;}
    public Map<Id,Project_Site__c> sitemap {get; set;}
    public Map<Id,Set<Id>> ownersite {get; set;}
    public Map<Id,List<User>> asmusrmap {get; set;}
    public Map<Id,List<Project_Site__c>> asmsitemap {get; set;}
    public String html {get; set;}
    
    public PotentialLeadNotif(String query){
        qry = query;
        ownerids = new Set<Id>();
        managerids = new Set<Id>();
        siteids = new Set<Id>();
        vstowners = new List<User>();
        asmlist = new List<User>();
        sitemap = new Map<Id,Project_Site__c>();
        ownersite = new Map<Id,Set<Id>>();
        asmusrmap = new Map<Id,List<User>>();
        asmsitemap = new Map<Id,List<Project_Site__c>>();
    }    
        
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(qry);
    }
    
    global void execute(Database.BatchableContext BC, List<Visit__c> scope){    
        for(Visit__c vst : scope){
            ownerids.add(vst.Ownerid);
            siteids.add(vst.Project_Site__c);
        }
        sitemap = new Map<Id,Project_Site__c>([select id,name,Type__c,Site_Sub_Type__c,Site_Status__c,Product_Quantity_Required__c,Volume_Potential_in_MT__c,End_Customer_Name__c from Project_Site__c where id in: siteids]);
        
        for(Visit__c vst : scope){
            tempidlist = new Set<Id>();
            if(ownersite.containsKey(vst.Ownerid)){
                tempidlist = ownersite.get(vst.Ownerid);
                tempidlist.add(vst.Project_Site__c);
                ownersite.put(vst.Ownerid,tempidlist);
            } else {
                tempidlist.add(vst.Project_Site__c);
                ownersite.put(vst.Ownerid,tempidlist);
            }
        }
        vstowners = [select id,name,Managerid,Email from User where id in: ownerids];
        
        for(User usr : vstowners){
            managerids.add(usr.Managerid);
            templist = new List<User>();
            if(asmusrmap.containsKey(usr.Managerid)){
                templist = asmusrmap.get(usr.Managerid);
                templist.add(usr);
                asmusrmap.put(usr.Managerid,templist);
            } else {
                templist.add(usr);
                asmusrmap.put(usr.Managerid,templist);
            }
        }
        
        asmlist = [select id,name,Email from User where id in: managerids];
        for(User usr : asmlist){
            tempsitelist = new List<Project_Site__c>();
            for(User usr1 : asmusrmap.get(usr.id)){
                for(Id tmp : ownersite.get(usr1.id)){
                    tempsitelist.add(sitemap.get(tmp));
                }
            }
            asmsitemap.put(usr.Id,tempsitelist);
        }
        List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>();
        for(User usr : asmlist){
            ccaddress = new List<String>();
            for(User usr1 : asmusrmap.get(usr.id)){
                ccaddress.add(usr1.Email);
            }
            String body = '<html><body>Hi '+ usr.Name + ', <br/><br/>Please find the list of potential leads for today. <br/><br/>'+
            '<table border="1" cellpadding="0"><tr><th>Name</th><th>Type</th><th>Sub Type</th><th>End Customer Name</th><th>Product Quantity Required in MT</th><th>Volume Potential in MT</th><th>Status</th></tr>';
            html = '';
            for(Project_Site__c prj : asmsitemap.get(usr.id)){
                html = html + '<tr><td align="center">' + prj.Name + '</td>';
                html = html + '<td align="center">' + String.valueOf(prj.Type__c != null ? prj.Type__c : '') + '</td>';
                html = html + '<td align="center">' + String.valueOf(prj.Site_Sub_Type__c != null ? prj.Site_Sub_Type__c : '') + '</td>';
                html = html + '<td align="center">' + String.valueOf(prj.End_Customer_Name__c != null ? prj.End_Customer_Name__c : '') + '</td>';
                html = html + '<td align="center">' + String.valueOf(prj.Product_Quantity_Required__c != null ? String.valueOf(prj.Product_Quantity_Required__c) : '0') + '</td>';
                html = html + '<td align="center">' + String.valueOf(prj.Volume_Potential_in_MT__c != null ? String.valueOf(prj.Volume_Potential_in_MT__c) : '0') + '</td>';
                html = html + '<td align="center">' + String.valueOf(prj.Site_Status__c != null ? prj.Site_Status__c : '') + '</td></tr>';
            }
            body = body + html + '</table><br/><br/>Regards,<br/>SFDC<br/></body></html>';
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.toAddresses = new String[]{usr.Email};
            mail.CcAddresses = ccaddress;
            mail.BccAddresses = new String[]{'slomada@bodhtree.com'};
            mail.HtmlBody = body;
            mail.Subject = 'Potential Lead List';
            messages.add(mail);
        }
        
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        if(results[0].success) {
            System.debug('The email was sent successfully.');
        } else {
            System.debug('The email failed to send: '
                         + results[0].errors[0].message);
        }
    }
    
    global void finish(Database.BatchableContext BC){
    
    }
}