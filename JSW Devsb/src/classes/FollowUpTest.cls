@isTest
public class FollowUpTest 
{
    public static testmethod void folwup()
    {
        Date dat = System.today();
        Account ac = new account(name = 'test');
        insert ac;
        ApexPages.StandardController sc = new ApexPages.StandardController(ac);
        FollowUp fup = new FollowUp(sc);
        fup.followUpDate();
        System.assertEquals(null,fup.dat);
    }
}