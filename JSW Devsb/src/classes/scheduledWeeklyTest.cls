@isTest
        private class scheduledWeeklyTest{
           static testmethod void  testschedule(){
           Test.StartTest();
         Invouceupdate invc = new Invouceupdate(); 
               Date myDate = System.today();
               Date myDate1 = System.today()-1;
               Account ac = new Account(name = 'test'); insert ac;
               State_Head__c st=new State_Head__c(	Date__c=myDate);
        insert st;
        Zonal_Head__c zh=new Zonal_Head__c(	Date__c=myDate,State_Head__c=st.Id);
        insert zh;
        ASM_Targets__c ast=new ASM_Targets__c(date__C=myDate,Zonal_Head__c=zh.id);
        insert ast;
               Monthly_Dealer_Target__c mdt=new Monthly_Dealer_Target__c();
        mdt.Account__c=ac.id;
        mdt.Actuals__c=258.00;
        mdt.ASM_Target__c=ast.id;
               mdt.Target_Date__c = myDate;
        mdt.Quantity__c=45.00;
               insert mdt;
               Monthly_Targets__c mt = new Monthly_Targets__c();
               mt.Today_Sale__c = 10;
               mt.Dealer__c = ac.id;
               mt.Monthly_Dealer_Target__c = mdt.id;
               insert mt;
           Invoice__c inv = new Invoice__c();
        inv.Account__c = ac.id;
        inv.Basic_Price_Per_MT__c = 20.00;
        inv.Brand_Short_Form__c = 'PSC';
        inv.qty__c = 10;
        inv.Commercial_Invoice_Date__c = myDate1;
        inv.Total_Basic_Price__c = 10.00;
        insert inv;   
               
         String sch = '0  00 1 3 * ?';
           system.schedule('Test', sch, invc); 
        Test.stopTest();
     }
    }
    /*@isTest
public class invouceupdateTest 
{
	public static testmethod void invupd()
    {
        Invouceupdate inv = new Invouceupdate();
        inv.execute(sc);
    }
}*/