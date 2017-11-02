global class Invouceupdate implements Schedulable
{
    public Invouceupdate(){}
    public void execute(SchedulableContext sc)
    {
        integer mnth;
        Date myDate = System.today()-1;
        if(myDate.day()==1)
            mnth = myDate.month()-1;
        else
            mnth = myDate.month();
        list<Monthly_Targets__c> mdt=[select id,Today_Sale__c,Dealer__c from Monthly_Targets__c where month__c = :mnth];
        list<Invoice__c> inv=[select id,Total_value__c,Account__c  from Invoice__c where Commercial_Invoice_Date__c = :myDate];
        
        for(Monthly_Targets__c mt:mdt)
        {
            for(Invoice__c invc:inv)
            {
                if(mt.Dealer__c==invc.Account__c)
                {
                    if(invc.Total_value__c != null)
                        mt.Today_Sale__c=mt.Today_Sale__c+double.valueof(invc.Total_value__c);
                }
            }
        }
        update mdt;
    }
}