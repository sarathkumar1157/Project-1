@istest
public class AutoCheckInController_test {
public static testmethod void AutoCheckInController_method(){
account act=new account();
act.name='testact';
act.account_type__c='depot';
insert act;

Month_Plan__c pjp = new Month_Plan__c();
insert pjp;

Day_Plan__c dp = new Day_Plan__c();
dp.Month_Plan__c = pjp.id;
insert dp;

Visit__c vst=new Visit__c();
vst.name='test';
vst.account__c=act.id;
vst.Day_Plan__c = dp.id;
insert vst;
ApexPages.StandardController sc = new ApexPages.StandardController(vst); 
AutoCheckInController  ACC=new AutoCheckInController (sc);
}

public static testmethod void AutoCheckInController_method1(){

GeoTagging_Distance__c gtd = new GeoTagging_Distance__c();
        gtd.Name = 'Geo Tagging';
        gtd.Distance__c = 1;
        insert gtd;

account act=new account();
act.name='testact';
act.account_type__c='depot';
insert act;

Month_Plan__c pjp = new Month_Plan__c();
insert pjp;

Day_Plan__c dp = new Day_Plan__c();
dp.Month_Plan__c = pjp.id;
insert dp;

Visit__c vst=new Visit__c();
vst.name='test';
vst.account__c=act.id;
vst.Day_Plan__c = dp.id;
insert vst;
AutoCheckInController.autoCheckIn('17','15','17','15', vst.Id);

}

public static testmethod void AutoCheckInController_method2(){
GeoTagging_Distance__c gtd = new GeoTagging_Distance__c();
gtd.Name = 'Geo Tagging';
gtd.Distance__c = 1;
insert gtd;

account act=new account();
act.name='testact';
act.account_type__c='depot';
insert act;

AutoCheckInController.autoCheckInAcc('17','15','17','15', act.Id);
}

public static testmethod void AutoCheckInController_method3(){
GeoTagging_Distance__c gtd = new GeoTagging_Distance__c();
gtd.Name = 'Geo Tagging';
gtd.Distance__c = 1;
insert gtd;

lead ld=new lead();
ld.lastname='testlead';
ld.Company='BT';
ld.status='NEW';
insert ld;

AutoCheckInController.autoCheckInLd('17','15','17','15', ld.Id);
}

public static testmethod void AutoCheckInController_method4(){
GeoTagging_Distance__c gtd = new GeoTagging_Distance__c();
gtd.Name = 'Geo Tagging';
gtd.Distance__c = 1;
insert gtd;

Project_Site__c PS=new Project_Site__c();
ps.Name='testprojectsite';
insert ps;

AutoCheckInController.autoCheckInPS('17','15','17','15', ps.Id);
}

public static testmethod void AutoCheckInController_method5(){
GeoTagging_Distance__c gtd = new GeoTagging_Distance__c();
gtd.Name = 'Geo Tagging';
gtd.Distance__c = 1;
insert gtd;

Influencer__c inf=new Influencer__c();
inf.Name='testinf';
inf.Registered_with_JSW_ELP_program__c = 'Yes';
insert inf;

AutoCheckInController.autoCheckInInfnc('17','15','17','15', inf.Id);
}

public static testmethod void AutoCheckInController_method6(){
GeoTagging_Distance__c gtd = new GeoTagging_Distance__c();
gtd.Name = 'Geo Tagging';
gtd.Distance__c = 1;
insert gtd;

Event__c Evnt=new event__c();
evnt.name='test evnt';
insert evnt;

AutoCheckInController.autoCheckInEvnt('17','15','17','15', evnt.Id);
}

public static testmethod void AutoCheckInController_method7(){
GeoTagging_Distance__c gtd = new GeoTagging_Distance__c();
gtd.Name = 'Geo Tagging';
gtd.Distance__c = 1;
insert gtd;

Business_Partner__c BP=new Business_Partner__c();
BP.name='test Buss';
insert BP;

AutoCheckInController.autoCheckInBP('17','15','17','15', BP.Id);
}

public static testmethod void AutoCheckInController_method8(){
/*GeoTagging_Distance__c gtd = new GeoTagging_Distance__c();
gtd.Name = 'Geo Tagging';
gtd.Distance__c = 1;
insert gtd;*/

account act=new account();
act.name='testact';
act.account_type__c='depot';
insert act;

Month_Plan__c pjp = new Month_Plan__c();
insert pjp;

Day_Plan__c dp = new Day_Plan__c();
dp.Month_Plan__c = pjp.id;
insert dp;

Visit__c vst=new Visit__c();
vst.name='test';
vst.account__c=act.id;
vst.Day_Plan__c = dp.id;
insert vst;
AutoCheckInController.autoCheckInVisit('17','15',vst.Id);
}

public static testmethod void AutoCheckInController_method9(){
GeoTagging_Distance__c gtd = new GeoTagging_Distance__c();
gtd.Name = 'Geo Tagging';
gtd.Distance__c = 1;
insert gtd;

account act=new account();
act.name='testact';
act.account_type__c='depot';
insert act;

Month_Plan__c pjp = new Month_Plan__c();
insert pjp;

Day_Plan__c dp = new Day_Plan__c();
dp.Month_Plan__c = pjp.id;
insert dp;

Visit__c vst=new Visit__c();
vst.name='test';
vst.account__c=act.id;
vst.Day_Plan__c = dp.id;
insert vst;
AutoCheckInController.autoCheckdistance('17','15','17', vst.Id);
}
}