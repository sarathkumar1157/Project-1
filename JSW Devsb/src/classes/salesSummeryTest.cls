@isTest
public Class salesSummeryTest
{
    public static testMethod  void salesSummary()
    {
        date myDate = date.today();
        Account ac= new Account();
        ac.Name='test';
        ac.Customer_Code__c='test';
        ac.Sales_Office_text__c='test';
        ac.External_ID__c='test1050';
        insert ac;
        
        Target__c tr= new Target__c();
        tr.Dealer_Actuals__c= 10;
        tr.Customer_Code__c='test';
        tr.Division__c='50';
        tr.Distribution_Channel__c='10';
        tr.Year__c='2017';
        tr.Month__c='February';
        tr.Product__c='pro1';
        insert tr;
        
        Daily_Sales__c ds =new Daily_Sales__c();
        ds.Actuals_in_QTY_MT__c='a';
        ds.Plant__c='test';
        ds.Sales_Office_Description__c='test';
        ds.Customer__c='test';
        ds.Commercial_Invoice_Date__c=myDate-1;
        ds.Product_Group__c='test';
        ds.Grand_Total__c=10;
        insert ds;
        
        Invoice__c inv = new Invoice__c();
        inv.Sold_To_Code__c='test';
        inv.Distribution_Channel__c='10';
        inv.Division__c='50';
        inv.Excise_Invoice_Date__c=myDate;
        inv.Commercial_Invoice_Date__c=myDate;
        inv.Brand_Short_Form__c='test';
        inv.Plant_Short_Form__c='test';
        inv.Sales_District__c='test';
        inv.Qty__c=10;
        insert inv;
    }
}