@isTest(SeeAllData=true)
public class DailyVisitPlanTest {
    public static testmethod void unitSFTest(){
        Profile msfp = [select id,name from Profile where name = 'JSW Sales'];
        Profile tsfp = [select id,name from Profile where name = 'JSW Technical Services'];
        Profile sfp = [select id,name from Profile where name = 'JSW SO'];
        UserRole msrl = [select id,name from UserRole where name = 'Vijayawada ASM'];
        UserRole tsrl = [select id,name from UserRole where name = 'Vijayawada TSO'];
        UserRole sfrl = [select id,name from UserRole where name = 'Vijayawada SO'];
        User mngusr = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_IN', ProfileId = msfp.Id, UserRoleId = msrl.id,
            TimeZoneSidKey='Asia/Kolkata', UserName='standardmnguser@testorg.com');
        insert mngusr;
        
        User tsfusr = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_IN', ProfileId = tsfp.Id, ManagerId = mngusr.id, UserRoleId = tsrl.id,
            TimeZoneSidKey='Asia/Kolkata', UserName='standardtsouser@testorg.com');
        insert tsfusr;
        
        User sfusr = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', UserRoleId = sfrl.id,
            LocaleSidKey='en_IN', ProfileId = sfp.Id, ManagerId = mngusr.id,
            TimeZoneSidKey='Asia/Kolkata', UserName='standardsfuser@testorg.com');
        insert sfusr;
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        system.runAs(thisUser){
            Lead ld = new Lead();
            ld.LastName = 'Sample Lead';
            ld.OwnerId = sfusr.id;
            ld.Company = 'Sample Company';
            insert ld;
            
            Account acc = new Account();
            acc.Name = 'Sample Account';
            acc.OwnerId = sfusr.id;
            insert acc;
            
            District__c dst = new District__c();
            dst.Name = 'Sample District';
            dst.OwnerId = sfusr.id;
            insert dst;
            
            Event__c evt = new Event__c();
            evt.Type_of_Meet__c = 'Mason Meet';
            evt.ownerid = sfusr.id;
            insert evt;
            
            Business_Partner__c bp = new Business_Partner__c();
            bp.Name = 'Sample BP';
            bp.OwnerId = sfusr.id;
            insert bp;
            
            Project_Site__c prj = new Project_Site__c();
            prj.Name = 'Sample Project Site';
            prj.OwnerId = sfusr.id;
            prj.Type__c = 'Project Sites';
            prj.Territory__c = dst.Id;
            prj.End_Customer_Name__c = 'Sample Customer';
            //prj.Phone_Number__c = '12345678';
            prj.Volume_Potential_in_MT__c = 12345;
            prj.Phone__c = '123456789';
            insert prj;
            
            Influencer__c inf = new Influencer__c();
            inf.Name = 'Sample Influencer';
            inf.OwnerId = sfusr.id;
            inf.District__c = dst.id;
            inf.Inclination_to_JSW__c = 'Fully inclined';
            inf.Type__c = 'Engineers';
            inf.Phone__c = '123456789';
            inf.No_of_sites_under_influencer__c = 10;
            inf.Registered_with_JSW_ELP_program__c = 'Yes';
            insert inf;
            
            RecordType rtype = [select id, name from RecordType where SObjectType = 'Month_Plan__c' and name = 'PJP'];
            Month_Plan__c mnp = new Month_Plan__c();
            mnp.User__c = sfusr.id;
            mnp.Start_Date__c = Date.newInstance(2017, 1, 24);
            mnp.Status__c = 'New Request';
            mnp.OwnerId = sfusr.id;
            insert mnp;
            
            Week_Plan__c wp = new Week_Plan__c();
            wp.Month_Plan__c = mnp.id;
            wp.OwnerId = sfusr.id;
            insert wp;
            
            Day_Plan__c dp = new Day_Plan__c();
            dp.Month_Plan__c = mnp.id;
            dp.Week_Plan__c = wp.id;
            dp.Date__c = Date.newInstance(2017, 1, 24);
            dp.OwnerId = sfusr.id;
            insert dp;
            
            Visit__c vst = new Visit__c();
            vst.Day_Plan__c = dp.id;
            vst.Visited__c = true;
            vst.OwnerId = sfusr.id;
            vst.Planned_Date__c = Date.newInstance(2017, 1, 24);
            insert vst;
            
            List<String> objlistdel = new List<String>();
            objlistdel.add(String.valueOf(vst.id));
            
            List<String> objlist = new List<String>();
            objlist.add(String.valueOf(acc.id)+'@Fri Jan 24 2017');
            objlist.add(String.valueOf(ld.id)+'@Fri Jan 24 2017');
            objlist.add(String.valueOf(dst.id)+'@Fri Jan 24 2017');
            objlist.add(String.valueOf(evt.id)+'@Fri Jan 24 2017');
            objlist.add(String.valueOf(bp.id)+'@Fri Jan 24 2017');
            objlist.add(String.valueOf(prj.id)+'@Fri Jan 24 2017');
            objlist.add(String.valueOf(inf.id)+'@Fri Jan 24 2017');
            objlist.add('Holiday@Fri Jan 24 2017');
            objlist.add('Leave@Fri Jan 24 2017');
            objlist.add('Weekly@Fri Jan 24 2017');
            objlist.add('General@Fri Jan 24 2017');
            objlist.add('Cold@Fri Jan 24 2017');
            
            List<String> objlistupd = new List<String>();
            objlistupd.add(String.valueOf(acc.id)+'@Fri Jan 26 2017');
            
            String pjpid = String.valueOf(mnp.id);
            String dtstring = '2017-01-24T00:00:00';
            ApexPages.currentPage().getParameters().put('id',mnp.id);
            
            System.runAs(mngusr){
                
                string q = system.currentPageReference().getParameters().get('Id');
                Month_Plan__c  PJP = [select id,name,User__c,Start_Date__c,End_Date__c,Status__c,RecordType.Name from Month_Plan__c where id =: q];
                ApexPages.StandardController con = new ApexPages.StandardController(PJP);
                Daily_Visit_Plan_Ctlr cntr = new Daily_Visit_Plan_Ctlr(con);
            }
            
            System.runAs(tsfusr){
                ApexPages.currentPage().getParameters().put('id',mnp.id);
                ApexPages.StandardController con = new ApexPages.StandardController(mnp);
                Daily_Visit_Plan_Ctlr cntr = new Daily_Visit_Plan_Ctlr(con);
            }
            
            System.runAs(sfusr){
                ApexPages.currentPage().getParameters().put('id',mnp.id);
                ApexPages.StandardController con = new ApexPages.StandardController(mnp);
                Daily_Visit_Plan_Ctlr cntr = new Daily_Visit_Plan_Ctlr(con);
                cntr.pjptab();
                cntr.summarytab();
                cntr.submitmonth();
                cntr.submitforapproval();
                cntr.pickval = 'account';
                cntr.subuser = UserInfo.getName();
                cntr.trnt = 'tr';
                cntr.search();
                cntr.searchByName();
                cntr.pickval = 'account';
                cntr.subuser = UserInfo.getName();
                cntr.trnt = 'nt';
                cntr.trnt1 = 'nontrade';
                cntr.search();
                cntr.searchByName();
                cntr.pickval = 'account';
                cntr.subuser = UserInfo.getName();
                cntr.trnt = 'nt';
                cntr.trnt1 = 'institute';
                cntr.search();
                cntr.searchByName();
                cntr.pickval = 'lead';
                cntr.flead.Type__c = 'Trade';
                cntr.search();
                cntr.searchByName();
                cntr.pickval = 'territory';
                cntr.search();
                cntr.pickval = 'event';
                cntr.fevnt.Type_of_Meet__c = 'Mason Meet';
                cntr.search();
                cntr.searchByName();
                cntr.pickval = 'bpartner';
                cntr.bpval = 'subdealer';
                cntr.search();
                cntr.searchByName();
                cntr.pickval = 'bpartner';
                cntr.bpval = 'mmc';
                cntr.search();
                cntr.searchByName();
                cntr.pickval = 'bpartner';
                cntr.bpval = 'salesprom';
                cntr.search();
                cntr.searchByName();
                cntr.pickval = 'project';
                cntr.search();
                cntr.searchByName();
                cntr.pickval = 'depot';
                cntr.search();
                cntr.searchByName();
                cntr.pickval = 'influencer';
                cntr.finf.Type__c = 'Mason';
                cntr.search();
                cntr.searchByName();
                cntr.pickval = 'general';
                cntr.search();
                cntr.searchByName();
                cntr.join();
                cntr.cloning();
                cntr.cloning();
                cntr.year1 = '2016';
                cntr.month1 = 1;
                cntr.createRecs();
                Daily_Visit_Plan_Ctlr.SaveCal(objlistdel, objlist, pjpid);
                Daily_Visit_Plan_Ctlr.managerjoin(objlistdel, pjpid);
                Daily_Visit_Plan_Ctlr.dayPlanUrl(dtstring,pjpid);
            }
        }
    }
    
    public static testmethod void unitTempTest(){
        Profile msfp = [select id,name from Profile where name = 'JSW Sales'];
        Profile tsfp = [select id,name from Profile where name = 'JSW Technical Services'];
        Profile sfp = [select id,name from Profile where name = 'JSW SO'];
        
        UserRole msrl = [select id,name from UserRole where name = 'Vijayawada ASM'];
        UserRole tsrl = [select id,name from UserRole where name = 'Vijayawada TSO'];
        UserRole sfrl = [select id,name from UserRole where name = 'Vijayawada SO'];
        
        User mngusr = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_IN', ProfileId = msfp.Id, UserRoleId = msrl.id,
            TimeZoneSidKey='Asia/Kolkata', UserName='standardmnguser@testorg.com');
        insert mngusr;
        
        User tsfusr = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_IN', ProfileId = tsfp.Id, ManagerId = mngusr.id, UserRoleId = tsrl.id,
            TimeZoneSidKey='Asia/Kolkata', UserName='standardtsouser@testorg.com');
        insert tsfusr;
        
        User sfusr = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_IN', ProfileId = sfp.Id, ManagerId = mngusr.id, TSO__c = tsfusr.id, UserRoleId = sfrl.id,
            TimeZoneSidKey='Asia/Kolkata', UserName='standardsfuser@testorg.com');
        insert sfusr;
        
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        system.runAs(thisUser){
            RecordType rtype = [select id, name from RecordType where SObjectType = 'Month_Plan__c' and name = 'Template'];
            Month_Plan__c mnp = new Month_Plan__c();
            mnp.User__c = sfusr.id;
            mnp.RecordTypeId = rtype.id;
            mnp.Start_Date__c = system.today();
            mnp.OwnerId = sfusr.id;
            insert mnp;
            
            Visit__c vst = new Visit__c();
            vst.Month_Plan__c = mnp.id;
            vst.OwnerId = sfusr.id;
            insert vst;
            
            Lead ld = new Lead();
            ld.LastName = 'Sample Lead';
            ld.OwnerId = sfusr.id;
            ld.Company = 'Sample Company';
            ld.status='open';
            insert ld;
            RecordType rtype1 = [select id, name from RecordType where SObjectType = 'account' and name = 'depot'];
            Account acc = new Account();
            acc.Name = 'Sample Account';
            acc.OwnerId = sfusr.id;
            acc.recordtypeid=rtype1.id;
            insert acc;
            
            District__c dst = new District__c();
            dst.Name = 'Sample District';
            dst.OwnerId = sfusr.id;
            insert dst;
            
            Event__c evt = new Event__c();
            evt.Type_of_Meet__c = 'Mason Meet';
            evt.ownerid = sfusr.id;
            insert evt;
                
            Business_Partner__c bp = new Business_Partner__c();
            bp.Name = 'Sample BP';
            bp.OwnerId = sfusr.id;
            insert bp;
            
            Project_Site__c prj = new Project_Site__c();
            prj.Name = 'Sample Project Site';
            prj.OwnerId = sfusr.id;
            prj.Type__c = 'Project Sites';
            prj.Territory__c = dst.Id;
            prj.End_Customer_Name__c = 'Sample Customer';
            //prj.Phone_Number__c = '123456789';
            prj.Volume_Potential_in_MT__c = 12345;
            prj.Phone__c = '123456789';
            insert prj;
            
            Influencer__c inf = new Influencer__c();
            inf.Name = 'Sample Influencer';
            inf.OwnerId = sfusr.id;
            inf.Inclination_to_JSW__c = 'Fully inclined';
            inf.Type__c = 'Engineers';
            inf.Phone__c = '123456789';
            inf.No_of_sites_under_influencer__c = 10;
            inf.District__c = dst.id;
            inf.Registered_with_JSW_ELP_program__c = 'Yes';
            insert inf;
            
            System.runAs(sfusr){
                ApexPages.currentPage().getParameters().put('id',mnp.id);
                //string q = system.currentPageReference().getParameters().get('Id');
                //Month_Plan__c  PJP = [select id,name,User__c,Start_Date__c,End_Date__c,Status__c,RecordType.Name from Month_Plan__c where id =: q];
                ApexPages.StandardController con = new ApexPages.StandardController(mnp);
                Daily_Visit_Plan_Ctlr cntr = new Daily_Visit_Plan_Ctlr(con);
                cntr.pickval = 'account';
                cntr.filterSearch();
                cntr.pickval = 'lead';
                cntr.filterSearch();
                cntr.pickval ='territory';
                cntr.filterSearch();
                cntr.pickval = 'event';
                cntr.filterSearch();
                cntr.pickval = 'bpartner';
                cntr.filterSearch();
                cntr.pickval ='project';
                cntr.filterSearch();
                cntr.pickval = 'depot';
                cntr.filterSearch();
                cntr.pickval = 'influencer';
                cntr.filterSearch();
                cntr.pickval ='general';
                cntr.filterSearch();
                
                pagereference pgr = page.VisitPage;
                test.setcurrentpage(pgr);
                cntr.newVisit();
                ApexPages.currentPage().getParameters().put('id',mnp.id);
                cntr.directApprove();
                cntr.directReject();
            }
        }
    }
}