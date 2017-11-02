@isTest
public class batchUserTrgtUpdate_Test
{
    public static testmethod void batchtest()
    {
        Date myDate = system.today();
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'standt', Email='standduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, SAP_Code__c='abc',IsActive=true,
            TimeZoneSidKey='America/Los_Angeles', UserName='standduser@testorg.com');
    insert u;
    
    system.debug('+++++++'+u);
    Account ac = new Account(name='test',Sales_Employee_Code__c='abc');
        insert ac;
         User_Targets__c usrtrgt = new User_Targets__c();
            usrtrgt.Employee_ID__c = 'abc';
            usrtrgt.Month__c = 'October';
            usrtrgt.Year__c = '2017';
            usrtrgt.Product__c = 'PSC';
            usrtrgt.User_Trade_Actuals__c = 20;
            usrtrgt.User_Non_Trade_Actuals__c = 10;
        usrtrgt.X15_Days_Actuals__c = 10;
        insert usrtrgt;
        User_Targets__c usrtrgt1 = new User_Targets__c();
            usrtrgt1.Employee_ID__c = 'abc';
            usrtrgt1.Month__c = 'April';
            usrtrgt1.Year__c = '2017';
            usrtrgt1.Product__c = 'PSC';
            usrtrgt1.User_Trade_Actuals__c = 20;
            usrtrgt1.User_Non_Trade_Actuals__c = 10;
        usrtrgt1.X15_Days_Actuals__c = 10;
        insert usrtrgt1;
        system.debug('-------'+usrtrgt);
        
        String query1 = 'Select id,name,Plant_Name__c,NSR_T_Value__c,OwnerId,Sales_Office_Description__c,Account__c,Commercial_Invoice_Date_Formula__c,Qty__c,Plant_Short_Form__c,Sales_District__c,Brand_Short_Form__c,Sold_To_Code__c,Commercial_Invoice_Date__c,Distribution_Channel__c,Division__c,Month_of_Commercial_Invoice_Date__c,Year__c,Customer_Group_1__c from Invoice__c where DAY_ONLY(CreatedDate)=2017-05-11'; 
        Invoice__c inv = new Invoice__c();
        //inv.Plant_Short_Form__c= 'test';
        inv.Sales_District__c= 'test1';
        inv.Commercial_Invoice_Date__c=myDate;
        inv.Sold_To_Code__c='test';
        inv.Brand_Short_Form__c='PSC';
        inv.Qty__c = 10; 
        inv.Distribution_Channel__c = '10';
        inv.Division__c = '50';
        insert inv;
        
        Invoice__c inv1 = new Invoice__c();
        //inv.Plant_Short_Form__c= 'test';
        inv1.Sales_District__c= 'test1';
        inv1.Commercial_Invoice_Date__c=myDate;
        inv1.Sold_To_Code__c='test';
        inv1.Brand_Short_Form__c='PSC';
        inv1.Qty__c = 10; 
        inv1.Distribution_Channel__c = '20';
        inv1.Division__c = '50';
        insert inv1;
        Invoice__c inv11 = new Invoice__c();
        //inv.Plant_Short_Form__c= 'test';
        inv11.Sales_District__c= 'test1';
        inv11.Commercial_Invoice_Date__c=myDate;
        inv11.Sold_To_Code__c='test';
        inv11.Brand_Short_Form__c='PSC';
        inv11.Qty__c = 10; 
        inv11.Distribution_Channel__c = '20';
        inv11.Division__c = '50';
        inv11.Customer_Group_1__c = 'N01-INSTITUTIONS';
        inv11.OwnerId=u.id;
        insert inv11;
        Invoice__c inv2 = new Invoice__c();
        inv2.Sales_District__c= 'test1';
        inv2.Commercial_Invoice_Date__c=myDate;
        inv2.Sold_To_Code__c='test';
        inv2.Brand_Short_Form__c='PSC';
        inv2.Qty__c = 10; 
        inv2.Division__c = '52';
        insert inv2;
        Invoice__c inv12 = new Invoice__c();
        inv12.Sales_District__c= 'test1';
        inv12.Commercial_Invoice_Date__c=myDate-30;
        inv12.Sold_To_Code__c='test';
        inv12.Brand_Short_Form__c='PSC';
        inv12.Qty__c = 10; 
        inv12.Distribution_Channel__c = '20';
        inv12.Division__c = '50';
        inv12.Customer_Group_1__c = 'N01-INSTITUTIONS';
        inv12.OwnerId=u.id;
        insert inv12;
        List<Invoice__c> invlst = [Select id,name,Plant_Name__c,NSR_T_Value__c,OwnerId,Distribution_Channel__c,Sales_Office_Description__c,Account__c,Commercial_Invoice_Date_Formula__c,Qty__c,Plant_Short_Form__c,Customer_Group_1__c,Brand_Short_Form__c,Sales_District__c,Division__c,Month_of_Commercial_Invoice_Date__c,Year__c,Sold_To_Code__c from Invoice__c where id=:inv.Id or id=:inv1.Id or id=:inv11.Id or id=:inv2.Id or id=:inv12.Id];
        batchUserTrgtUpdate bat1 = new batchUserTrgtUpdate(query1);
        bat1.execute(null,invlst);
        Database.executeBatch(bat1);
    }
}