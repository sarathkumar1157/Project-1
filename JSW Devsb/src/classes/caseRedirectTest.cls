@isTest
public class caseRedirectTest {
    public static testMethod void method(){
        Lead led = new lead();
        led.LastName='testname';
        led.Company='testcompant';
        led.Status='open';
        insert led;
        

        Apexpages.StandardController stdController = new Apexpages.StandardController(led);
    caseRedirect controller = new caseRedirect(StdController);
    PageReference pageRef = Page.NewMonthTarget;
        controller.redirect();
    }

}