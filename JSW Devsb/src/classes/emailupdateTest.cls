@isTest
public class emailupdateTest 
{
    public static testmethod void emailupd()
    {
        id recid = [select id,developername,SobjectType from recordtype where SobjectType='Account' and developername='Non_Trade'].id;
        id rec2id = [select id,developername,SobjectType from recordtype where SobjectType='Account' and developername='Trade'].id;
        //system.debug('---->'+rec);
        User u = new User(
     ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id,
     LastName = 'last',
     Email = 'puser000@amamama.com',
     Username = 'puser000@amamama.com' + System.currentTimeMillis(),
     CompanyName = 'TEST',
     Title = 'title',
     Alias = 'alias',
     TimeZoneSidKey = 'America/Los_Angeles',
     EmailEncodingKey = 'UTF-8',
     LanguageLocaleKey = 'en_US',
     LocaleSidKey = 'en_US'
);
        insert u;
        Account ac = new Account();
        ac.name = 'test123';
        ac.RecordTypeId = rec2id;
        ac.Mail_to_SAP__c = false;
        ac.Email_Sent__c=false;
        ac.OwnerId=u.id;
        insert ac;
        Attachment attachment = new Attachment();
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
    	attachment.ParentId = ac.id;
    	attachment.Name = 'Test Attachment for Parent';
    	attachment.Body =bodyBlob;
    	insert attachment;
        List<Attachment> attachments=[select id, name from Attachment where parent.id=:ac.id];
        System.assertEquals(1, attachments.size());
    	 Account ac1 = new Account();
        ac1.name = 'test123';
        ac1.RecordTypeId = recid;
        ac1.Mail_to_SAP__c = true;
        ac1.Email_Sent__c=false;
        ac1.OwnerId=u.id;
        insert ac1;
		
    }
}