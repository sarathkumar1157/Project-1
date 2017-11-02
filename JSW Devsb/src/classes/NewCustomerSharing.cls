global class NewCustomerSharing implements Database.batchable<sObject>{
    
    public String qry {get; set;}
    public Set<Id> contactids {get; set;}
    public Set<Id> accids {get; set;}
    public Set<String> cusids {get; set;}
    public List<Account> acclist {get; set;}
    public List<Contact> conlist {get; set;}
    public List<Order__c > solist {get; set;}
    public List<Invoice__c> invlist {get; set;}
    public List<Target__c> trglist {get; set;}
    public List<Order__Share> listOrdShr {get; set;}
    public List<Invoice__Share> listInvShr {get; set;}
    public List<Target__Share> listTrgShr {get; set;}
    public Map<String,List<contact>> conMap{get; set;}
    public Map<Id,String> accMap{get; set;} 
    public List<Contact> tempContactList{get; set;}
    public List<Contact> tmpconlist {get; set;}
    public Map<Id,Id> conusrmap{get; set;}
    
    public NewCustomerSharing(String query){
        qry = query;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(qry);
    }
    
    global void execute(Database.BatchableContext BC, List<User> scope){
        if(scope.size() > 0){
            conusrmap = new Map<Id,Id>();
            contactids = new Set<Id>();
            accids = new Set<Id>();
            cusids = new Set<String>();
            
            for(User usr : scope){
                contactids.add(usr.Contactid);
                conusrmap.put(usr.Contactid,usr.id);
            }
            
            conMap = new Map<String,List<contact>>();
            accMap = new Map<Id,String>();
            
            conlist = [select id,name,AccountId from Contact where id in: contactids];
            for(Contact con : conlist){
                accids.add(con.Accountid);    
            }
            
            acclist = [select id,name,Customer_Code__c from Account where id in: accids];
            for(Account acc: acclist){
                cusids.add(acc.Customer_Code__c);
                accMap.put(acc.id,acc.Customer_Code__c);            
            }
            
            acclist = [select id,name,Customer_Code__c from Account where Customer_Code__c in:cusids];
            for(Account acc: acclist){
                accids.add(acc.Id);
            }
            
            for(Contact con : conlist){
                tempContactList = new List<Contact>();
                if(!conMap.containsKey(accMap.get(con.AccountId)))
                {
                    tempContactList.add(con);
                    conMap.put(accMap.get(con.AccountId),tempContactList);
                }
            }
            
            //get sale orders related to Customer Portal Accounts
            solist = [select id,name,Sold_To_Party__c from Order__c where Account__c in:accids];
            listOrdShr = new List<Order__Share>();
            tmpconlist = new List<Contact>();
            if(solist.size() > 0){
                for(Order__c ord : solist){
                    if(conMap.containsKey(ord.Sold_To_Party__c))
                        tmpconlist = conMap.get(ord.Sold_To_Party__c);
                    if(tmpconlist.size() > 0){
                        for(Contact con : tmpconlist){   
                            Order__Share OrdShr = new Order__Share();
                            OrdShr.ParentId = ord.Id;
                            OrdShr.UserOrGroupId = conusrmap.get(con.id);
                            OrdShr.AccessLevel = 'Read';
                            OrdShr.RowCause = Schema.Order__Share.RowCause.Manual;
                            System.debug(OrdShr+ ' ==> '+OrdShr.UserorGroupId);
                            listOrdShr.add(OrdShr);
                        }
                    }
                }
            }
            Database.SaveResult[] srord = Database.insert(listOrdShr,false);
            
             //get invoices related to Customer Portal Accounts
            invlist = [select id,name,Sold_To_Code__c from Invoice__c where Account__c in: accids];
            
            listInvShr = new List<Invoice__Share>();
            tmpconlist = new List<Contact>();
            if(invlist.size() > 0){
                for(Invoice__c inv : invlist){
                    if(conMap.containsKey(inv.Sold_To_Code__c))
                        tmpconlist = conMap.get(inv.Sold_To_Code__c);
                    if(tmpconlist.size() > 0){
                        for(Contact con : tmpconlist){
                            Invoice__Share InvShr = new Invoice__Share();
                            InvShr.ParentId = inv.Id;
                            InvShr.UserOrGroupId = conusrmap.get(con.id);
                            InvShr.AccessLevel = 'Read';
                            InvShr.RowCause = Schema.Invoice__Share.RowCause.Manual;
                            listInvShr.add(InvShr);
                        }
                    }
                }
            }
            Database.SaveResult[] srinv = Database.insert(listInvShr,false);
            
            //get targets related to Customer Portal Accounts
            trglist = [select id,name,Customer_Code__c from Target__c where Dealer_Name__c in: accids];
            
            listTrgShr = new List<Target__Share>();
            tmpconlist = new List<Contact>();
            if(trglist.size() > 0){
                for(Target__c trg : trglist){
                    if(conMap.containsKey(trg.Customer_Code__c))
                        tmpconlist = conMap.get(trg.Customer_Code__c);
                    if(tmpconlist.size() > 0){
                        for(Contact con : tmpconlist){
                            Target__Share TrgShr = new Target__Share();
                            TrgShr.ParentId = trg.Id;
                            TrgShr.UserOrGroupId = conusrmap.get(con.id);
                            TrgShr.AccessLevel = 'Read';
                            TrgShr.RowCause = Schema.Target__Share.RowCause.Manual;
                            listTrgShr.add(TrgShr);
                        }
                    }
                }
            }
            Database.SaveResult[] srtrg = Database.insert(listTrgShr,false);
        }
    }
    
    global void finish(Database.BatchableContext BC){
    
    }
}