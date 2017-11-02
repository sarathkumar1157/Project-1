global class OrderSharingRules implements Database.batchable<sObject>{
    
    public String query {get; set;}
    
    public OrderSharingRules(String qry){
        query = qry;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Account> scope){
    }
    
    global void finish(Database.BatchableContext BC){
    }
}