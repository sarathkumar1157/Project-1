@isTest
public class actualsUpdateTest 
{
    public static testmethod void invtest()
    {
        Date myDate = System.today();
        State_Head__c sh = new State_Head__c(Date__c=myDate);insert sh;
        Zonal_Head__c zh = new Zonal_Head__c(Date__c=myDate,State_Head__c=sh.id);insert zh;
        ASM_Targets__c asm = new ASM_Targets__c(Date__c=myDate,Zonal_Head__c=zh.id);insert asm;
        Account ac = new Account(name='test');
        insert ac;
        Monthly_Dealer_Target__c mdt = new Monthly_Dealer_Target__c();
        mdt.Target_Date__c = mydate;
        mdt.Products__c = 'PSC';
        mdt.ASM_Target__c = asm.id;
        mdt.Actuals__c = 10.00;
        mdt.Quantity__c = 10.00;
        insert mdt;
        Monthly_Targets__c mt = new Monthly_Targets__c();
        mt.Monthly_Dealer_Target__c = mdt.id;
        mt.Dealer__c = ac.id;
        mt.Product_short__c = 'PSC';
        mt.Monthly_Target__c = 10.00;
        mt.Monthly_Actaul__c = 10.00;
        mt.Quantity__c = 10.00;
         insert mt;
        Monthly_Targets__c mt1 = new Monthly_Targets__c();
        mt1.Monthly_Dealer_Target__c = mdt.id;
        mt1.Dealer__c = ac.id;
        mt1.Product_short__c = 'PSC';
        mt1.Monthly_Target__c = 10.00;
        mt1.Monthly_Actaul__c = 10.00;
        mt1.Quantity__c = 10.00;
         insert mt1;
        Invoice__c inv = new Invoice__c();
        inv.Account__c = ac.id;
        inv.Basic_Price_Per_MT__c = 20.00;
        inv.Brand_Short_Form__c = 'PSC';
        inv.qty__c = 10;
        inv.Commercial_Invoice_Date__c = myDate;
        inv.Total_Basic_Price__c = 10.00;
        insert inv;
    }
}