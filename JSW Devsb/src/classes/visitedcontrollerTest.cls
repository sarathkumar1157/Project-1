@isTest
public class visitedcontrollerTest 
{
    public static testmethod void vstcntl()
    {
        Visit__c vst = new Visit__c();
        vst.Start__c = system.now();
        vst.End__c = system.now();
        visitedcontroller vc = new visitedcontroller();        
        vc.vst = vst;
        vc.save();
        vst.Start__c = system.now()-1;
        vc.vst = vst;
        vc.save();
        vst.Start__c = system.now()+1;
        vc.vst = vst;
        vc.save();
        vc.cancel();
    }
}