@isTest
public class PIBVolNSR_Test 
{
    public static testmethod void pibActlTest()
    {
        List<Invoice__c> invlst = new List<Invoice__c>();
        String query = 'Select Employee_ID__c,Month_of_Commercial_Invoice_Date__c,Year__c,Sales_Office_Code__c,Commercial_Invoice_Date_Formula__c,Distribution_Channel__c,Brand_Short_Form__c,Cust_Grp1_from_Master__c,Account__c,qty__c,NSR_T_Value__c from Invoice__c';
        
        Profile p = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];

        User u = new User(
          Alias = 'testu',
          Email = 'test789@example987.com',
          EmailEncodingKey = 'UTF-8',
          LastName = 'Test',
          LanguageLocaleKey = 'en_US',
          LocaleSidKey = 'en_US',
          TimeZoneSidKey='America/Los_Angeles',
          ProfileId = p.Id,
          UserName='test7889@example9887.com',
          Employee_Code__c='abc123'
        );
        Account ac = new Account(name='Test Account',Sales_Office__c='xyz');
        Insert ac;
        
        PIB_ASM_Targets__c asm = new PIB_ASM_Targets__c();
        asm.Employee_Code__c = 'abc1234';
        Insert asm;
        
        PIB_SO_Targets__c pib = new PIB_SO_Targets__c();
        pib.PIB_ASM_Targets__c = asm.id;
        pib.Month__c = 'September';
        pib.Year__c = '2017';
        pib.Employee_Code__c = 'abc123';
        Insert pib;
        
        System.runAs(u){
        Invoice__c inv = new Invoice__c();
        //inv.Employee_ID__c = 'abc123';
        //inv.Sales_Office_Code__c = 'xyz';
        inv.Commercial_Invoice_Date__c = System.today()-2;
        inv.Distribution_Channel__c = '10';
        inv.Brand_Short_Form__c = 'PSC';
        inv.Cust_Grp1_from_Master__c = 'N01-Institutions';
        inv.Account__c = ac.id;
        inv.qty__c = 50;
        inv.NSR_PD_Value__c = 100;
        Insert inv;
        }
        List<Invoice__c> invlist1 = [Select Employee_ID__c,Month_of_Commercial_Invoice_Date__c,Year__c,Sales_Office_Code__c,Commercial_Invoice_Date_Formula__c,Distribution_Channel__c,Brand_Short_Form__c,Cust_Grp1_from_Master__c,Account__c,qty__c,NSR_T_Value__c from Invoice__c];
        PIBVolNSR bat = new PIBVolNSR(query);
        bat.execute(null,invlist1);
        Database.executeBatch(bat);
    }
}