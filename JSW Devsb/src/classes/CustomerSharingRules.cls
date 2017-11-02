global class CustomerSharingRules implements Database.batchable<sObject>{
    
    public List<Account> cuslist {get; set;}
    public List<Account> acclist {get; set;}
    public List<Contact> conlist {get; set;}
    public List<Contact> tmpconlist {get; set;}
    public List<User> usrlist {get; set;}
    public Set<Id> accids {get; set;}
    public Set<Id> conids {get; set;}
    public Set<String> acccodes {get; set;}
    public Set<String> cusids {get; set;}
    public Map<String,List<Account>> cusmap {get; set;}
    public List<Order__c> solist {get; set;}
    public List<Invoice__c> invlist {get; set;}
    //public List<Customer_Ledger__c> clrlist {get; set;}
    public List<Target__c> trglist {get; set;}
    //public List<Ship_To_Party__c> shplist {get; set;}
    public List<AccountShare> listAccShr {get; set;}
    public List<Order__Share> listOrdShr {get; set;}
    public List<Invoice__Share> listInvShr {get; set;}
    //public List<Customer_Ledger__share> listClrShr {get; set;}
    public List<Target__Share> listTrgShr {get; set;}
    //public List<Ship_To_Party__Share> listShpShr {get; set;}
    public Map<String,List<Contact>> acconmap {get; set;}
    public Map<Id,Id> conusrmap {get; set;}
    public List<Account> accidlist {get; set;}
    public List<Contact> contlist {get; set;}
    public String qry {get; set;}
    public static String body {get; set;}
    
    public CustomerSharingRules(String query){
        qry = query;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(qry);
        //return Database.getQueryLocator('select id,name,Customer_code__c from Account where isCustomerPortal = true');
    }
    
    global void execute(Database.BatchableContext BC, List<Account> scope){
        accids = new Set<Id>();
        acccodes = new Set<String>();
        cusids = new Set<String>();
        
        acconmap = new Map<String,List<Contact>>();
        cusmap = new Map<String,List<Account>>();
        
        //getting Customer Portal Accounts
        acclist = new List<Account>();
        acclist.addAll(scope);
        
        for(Account acc : acclist){
            acccodes.add(acc.Customer_code__c);
        }
        
        acclist = [select id,name,Customer_code__c,(select id,name,Account.Name from Contacts) from Account where Customer_code__c in: acccodes];
        
        for(Account acc : acclist){
            accidlist = new List<Account>();
            contlist = new List<Contact>();
            accids.add(acc.id);
            cusids.add(acc.Customer_code__c);
            if(!cusmap.containsKey(acc.Customer_Code__c)){
                accidlist.add(acc);
                cusmap.put(acc.Customer_Code__c,accidlist);
            } else {
                accidlist = cusmap.get(acc.Customer_Code__c);
                accidlist.add(acc);
                cusmap.put(acc.Customer_Code__c,accidlist);
            }
            if(acc.Contacts.size() > 0){
                if(!acconmap.containsKey(acc.Customer_Code__c)){
                    contlist.addAll(acc.Contacts);
                    acconmap.put(acc.Customer_Code__c,contlist);
                } else {
                    contlist = acconmap.get(acc.Customer_Code__c);
                    contlist.addAll(acc.Contacts);
                    acconmap.put(acc.Customer_Code__c,contlist);
                }
            }
        }
        
        conids = new Set<Id>();
        
        //getting Contacts related to Portal Accounts
        conlist = [select id,name,Accountid,Account.Name from Contact where Accountid in: accids];
        for(Contact con : conlist){
            conids.add(con.id);
        }
        
        //mapping user ids to contact ids
        usrlist = [select id,name,ContactId from User where ContactId in: conids];
        
        conusrmap = new Map<Id,Id>();
        for(User usr : usrlist){
            conusrmap.put(usr.Contactid,usr.Id);
        }
        
        body = 'Account ID,Account Name,Shared To,User ID,User Name\n';
        
        //get accounts related to Customer Portal Accounts
        cuslist = [select id,name,Customer_Code__c,ParentId,Parent.Name from Account where Customer_Code__c in: cusids];
        
        listAccShr = new List<AccountShare>();
        tmpconlist = new List<Contact>();
        if(cuslist.size() > 0){
            for(String str : cusmap.KeySet()){
                for(Account acc : cusmap.get(str)){
                    if(acconmap.containsKey(acc.Customer_Code__c)){
                        tmpconlist = acconmap.get(acc.Customer_Code__c);
                    }
                    if(tmpconlist.size() > 0){
                        for(Contact con : tmpconlist){
                            AccountShare AccShr = new AccountShare();
                            AccShr.AccountId = acc.Id;
                            AccShr.UserOrGroupId = conusrmap.get(con.id);
                            AccShr.AccountAccessLevel = 'Read';
                            AccShr.OpportunityAccessLevel = 'Read';
                            AccShr.RowCause = Schema.AccountShare.RowCause.Manual;
                            listAccShr.add(AccShr);
                            
                            body = body + acc.id + ',' + acc.Name + ',------->,'+conusrmap.get(con.id)+','+con.Name+'\n';
                            
                            if(acc.ParentId != null){
                            
                                AccountShare AccShr1 = new AccountShare();
                                AccShr1.AccountId = acc.ParentId;
                                AccShr1.UserOrGroupId = conusrmap.get(con.id);
                                AccShr1.AccountAccessLevel = 'Read';
                                AccShr1.OpportunityAccessLevel = 'Read';
                                AccShr1.RowCause = Schema.AccountShare.RowCause.Manual;
                                listAccShr.add(AccShr1);
                                
                                body = body + acc.parentid + ',' + acc.Parent.Name + ',------->,'+conusrmap.get(con.id)+','+con.Name+'\n';
                            }
                        }
                    }
                }    
            }
        }
        
        Database.SaveResult[] sracc = Database.insert(listAccShr,false);
        
        body = body + '\nSO ID,SO Name,Shared To,User ID,User Name\n';
        //get sale orders related to Customer Portal Accounts
        solist = [select id,name,Sold_To_Party__c from Order__c where Account__c in: accids and CreatedDate = TODAY];
        
        listOrdShr = new List<Order__Share>();
        tmpconlist = new List<Contact>();
        if(solist.size() > 0){
            for(Order__c ord : solist){
                if(acconmap.containsKey(ord.Sold_To_Party__c))
                    tmpconlist = acconmap.get(ord.Sold_To_Party__c);
                if(tmpconlist.size() > 0){
                    for(Contact con : tmpconlist){
                        Order__Share OrdShr = new Order__Share();
                        OrdShr.ParentId = ord.Id;
                        OrdShr.UserOrGroupId = conusrmap.get(con.id);
                        OrdShr.AccessLevel = 'Read';
                        OrdShr.RowCause = Schema.Order__Share.RowCause.Manual;
                        listOrdShr.add(OrdShr);
                        
                        body = body + ord.id + ',' + ord.Name + ',------->,'+conusrmap.get(con.id)+','+con.Name+'\n';
                    }
                }
            }
        }
        
        Database.SaveResult[] srord = Database.insert(listOrdShr,false);
        
        body = body + '\nInvoice ID,Invoice Name,Shared To,User ID,User Name\n';
        //get invoices related to Customer Portal Accounts
        invlist = [select id,name,Sold_To_Code__c from Invoice__c where Account__c in: accids and CreatedDate = TODAY];
        
        listInvShr = new List<Invoice__Share>();
        tmpconlist = new List<Contact>();
        if(invlist.size() > 0){
            for(Invoice__c inv : invlist){
                if(acconmap.containsKey(inv.Sold_To_Code__c))
                    tmpconlist = acconmap.get(inv.Sold_To_Code__c);
                if(tmpconlist.size() > 0){
                    for(Contact con : tmpconlist){
                        Invoice__Share InvShr = new Invoice__Share();
                        InvShr.ParentId = inv.Id;
                        InvShr.UserOrGroupId = conusrmap.get(con.id);
                        InvShr.AccessLevel = 'Read';
                        InvShr.RowCause = Schema.Invoice__Share.RowCause.Manual;
                        listInvShr.add(InvShr);
                        
                        body = body + inv.id + ','+ inv.Name + ',------->,' + conusrmap.get(con.id) + ',' + con.Name + '\n';
                    }
                }
            }
        }
        Database.SaveResult[] srinv = Database.insert(listInvShr,false);
        
        //get customer ledgers related to Customer Portal Accounts
        /*clrlist = [select id,name,Customer_Code__c from Customer_Ledger__c where Account__c in: accids and CreatedDate = TODAY];
        
        listClrShr = new List<Customer_Ledger__Share>();
        tmpconlist = new List<Contact>();
        if(clrlist.size() > 0){
            for(Customer_Ledger__c clr : clrlist){
                if(acconmap.containsKey(clr.Customer_Code__c))
                    tmpconlist = acconmap.get(clr.Customer_Code__c);
                if(tmpconlist.size() > 0){
                    for(Contact con : tmpconlist){
                        Customer_Ledger__Share ClrShr = new Customer_Ledger__Share();
                        ClrShr.ParentId = clr.Id;
                        ClrShr.UserOrGroupId = conusrmap.get(con.id);
                        ClrShr.AccessLevel = 'Read';
                        ClrShr.RowCause = Schema.Customer_Ledger__Share.RowCause.Manual;
                        listClrShr.add(ClrShr);
                    }
                }
            }
        }
        
        Database.SaveResult[] srclr = Database.insert(listClrShr,false);
        
        //get ship to parties related to Customer Portal Accounts
        shplist = [select id,name,Sold_to_Code__c from Ship_To_Party__c where Account__c in: accids and CreatedDate = TODAY];
        listShpShr = new List<Ship_To_Party__Share>();
        tmpconlist = new List<Contact>();
        if(shplist.size() > 0){
            for(Ship_To_Party__c shp : shplist){
                if(acconmap.containsKey(shp.Sold_to_Code__c))
                    tmpconlist = acconmap.get(shp.Sold_to_Code__c);
                if(tmpconlist.size() > 0){
                    for(Contact con : tmpconlist){
                        Ship_To_Party__Share ShpShr = new Ship_To_Party__Share();
                        ShpShr.ParentId = shp.Id;
                        ShpShr.UserOrGroupId = conusrmap.get(con.id);
                        ShpShr.AccessLevel = 'Read';
                        ShpShr.RowCause = Schema.Ship_To_Party__Share.RowCause.Manual;
                        listShpShr.add(ShpShr);
                    }
                }
            }
        }
        
        Database.SaveResult[] srshp = Database.insert(listShpShr,false);*/
        
        body = body + '\nTarget ID,Target Name,Shared To,User ID,User Name\n';
        //get targets related to Customer Portal Accounts
        trglist = [select id,name,Customer_Code__c from Target__c where Dealer_Name__c in: accids and CreatedDate = TODAY];
        
        listTrgShr = new List<Target__Share>();
        tmpconlist = new List<Contact>();
        if(trglist.size() > 0){
            for(Target__c trg : trglist){
                if(acconmap.containsKey(trg.Customer_Code__c))
                    tmpconlist = acconmap.get(trg.Customer_Code__c);
                if(tmpconlist.size() > 0){
                    for(Contact con : tmpconlist){
                        Target__Share TrgShr = new Target__Share();
                        TrgShr.ParentId = trg.Id;
                        TrgShr.UserOrGroupId = conusrmap.get(con.id);
                        TrgShr.AccessLevel = 'Read';
                        TrgShr.RowCause = Schema.Target__Share.RowCause.Manual;
                        listTrgShr.add(TrgShr);
                        
                        body = body + trg.id + ',' + trg.Name + ',------->,' + conusrmap.get(con.id) + ',' + con.Name + '\n';
                    }
                }
            }
        }
        Database.SaveResult[] srtrg = Database.insert(listTrgShr,false);
        
        Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
        blob csvBlob = Blob.valueOf(body);
        string csvname= 'Sharing.csv';
        csvAttc.setFileName(csvname);
        csvAttc.setBody(csvBlob);
        
        List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[]{'slomada@bodhtree.com'};
        message.subject = 'Sharing Report';
        message.PlainTextBody = 'PFA';
        message.FileAttachments = new Messaging.EmailFileAttachment[]{csvAttc};
        messages.add(message);
            
        Messaging.SendEmailResult[] result = Messaging.sendEmail(messages);
        if (result[0].success) {
            System.debug('The email was sent successfully.');
        } else {
            System.debug('The email failed to send: '+ result[0].errors[0].message);
        }
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
}