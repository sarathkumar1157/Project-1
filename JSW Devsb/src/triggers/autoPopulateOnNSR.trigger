trigger autoPopulateOnNSR on Nsr__c (before insert, before update) {

List<String> customerCode=new List<String>();

for(Nsr__c nsr:trigger.new)
{
String soldt=nsr.Customer_Code__c+nsr.Distribution_Channel__c+nsr.Division__c;
customerCode.add(soldt);
}

List<Account> accountList=[select id,Customer_Code__c,External_Id__c from Account where External_Id__c in:customerCode and External_Id__c!=null];

for(Account acclist:accountList)
 {
  for(Nsr__c nsr:trigger.new)
   {
    if(nsr.Customer_Code__c==acclist.Customer_Code__c)
    nsr.Account__c=acclist.id;
    }
  }
}