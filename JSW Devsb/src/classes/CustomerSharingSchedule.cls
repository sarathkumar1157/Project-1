global class CustomerSharingSchedule implements Schedulable{
    global void execute(SchedulableContext sc) {
        CustomerSharingRules cus = new CustomerSharingRules('select id,name,Customer_code__c from Account where isCustomerPortal = true');
        Database.executeBatch(cus,100);
        
        NewCustomerSharing usr = new NewCustomerSharing('select id,name,Contactid from User where CreatedDate = TODAY');
        Database.executeBatch(usr,1);
    }
}