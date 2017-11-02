@istest
public class ApprovalSubmission_test{
    public static testmethod void ApprovalSubmission_method(){
        Set<String> dpids = new Set<String>();
        List<Visit__c> vstlist=new List<Visit__c>();
        User u = [select firstname from user where id=:userinfo.getuserid()];
        Account ac=new Account();
        ac.name='Mohan';
        insert ac;
        
        Lead ld=new Lead(Company = 'JohnMiller', LastName = 'Mike', Status = 'Open');
        insert ld;
        Project_Site__c ps=new Project_Site__c();
        insert ps;
        District__c ds=new District__c();
        insert ds;
        Influencer__c ifu=new Influencer__c();
        ifu.Name = 'Sample Influencer';
        ifu.Registered_with_JSW_ELP_program__c = 'Yes';
        insert ifu;
        Business_Partner__c bp=new Business_Partner__c();
        insert bp;
        Month_Plan__c MPC=new Month_Plan__c();
        MPC.Name='plan';
        MPC.Start_Date__c=system.today()-30;
        MPC.End_Date__c=system.today();
        MPC.User__c=u.id;
        MPC.Year__c ='2016';
        insert MPC;
        
        Week_Plan__c WP=new Week_Plan__c();
        WP.name='test';
        WP.Start_Date__c=system.today();
        WP.End_Date__c=system.today()+7;
        WP.Month_Plan__c=MPC.id;
        Wp.Submitted_for_Approval__c =true;
        WP.Status__c='New Request';
        insert WP;
        
        Week_Plan__c WP2=new Week_Plan__c();
        WP2.name='test';
        WP2.Start_Date__c=system.today();
        WP2.End_Date__c=system.today()+7;
        WP2.Month_Plan__c=MPC.id;
        Wp2.Submitted_for_Approval__c =False;
        WP2.Status__c='Submitted';
        insert wp2;
        WP2.Status__c='Approved';
        update wp2;
        
        Day_Plan__c dp=new Day_Plan__c();
        dp.Name='day';
        dp.Week_Plan__c=wp2.id;    
        insert dp;
        dp.Date__c=date.today();
        update dp;    
        dpids.add(dp.id);
        
        Visit__c vc=new Visit__c();
        vc.Account__c=ac.id;
        vc.Week_Plan_Submitted__c=true;
        vc.Day_Plan__c=dp.id;
        vc.Address__c='sjfksjdgksdjgs';
        vc.Check_In__c='df';
        vc.JSW_Bag_Visibility__c='Good';
        insert vc;
        vstlist.add(vc);
        
        Visit__c vc1=new Visit__c();
        vc1.Lead__c=ld.id;
        vc1.Week_Plan_Submitted__c=true;
        vc1.Day_Plan__c=dp.id;
        vc1.Address__c='sjfksjdgksdjgs';
        vc1.Check_In__c='df';
        vc1.JSW_Bag_Visibility__c='Good';
        insert vc1;
        
        Visit__c vc2=new Visit__c();
        vc2.Project_Site__c=ps.id;
        vc2.Week_Plan_Submitted__c=true;
        vc2.Day_Plan__c=dp.id;
        vc2.Address__c='sjfksjdgksdjgs';
        vc2.Check_In__c='df';
        vc2.JSW_Bag_Visibility__c='Good';
        insert vc2;
        
        Visit__c vc3=new Visit__c();
        vc3.Territory__c=ds.id;
        vc3.Week_Plan_Submitted__c=true;
        vc3.Day_Plan__c=dp.id;
        vc3.Address__c='sjfksjdgksdjgs';
        vc3.Check_In__c='df';
        vc.JSW_Bag_Visibility__c='Good';
        insert vc3;
        
        Visit__c vc4=new Visit__c();
        vc4.Influencer__c=ifu.id;
        vc4.Week_Plan_Submitted__c=true;
        vc4.Day_Plan__c=dp.id;
        vc4.Address__c='sjfksjdgksdjgs';
        vc4.Check_In__c='df';
        vc4.JSW_Bag_Visibility__c='Good';
        insert vc4;
        
        Visit__c vc5=new Visit__c();
        vc5.Business_Partner__c=bp.id;
        vc5.Week_Plan_Submitted__c=true;
        vc5.Day_Plan__c=dp.id;
        vc5.Address__c='sjfksjdgksdjgs';
        vc5.Check_In__c='df';
        vc5.JSW_Bag_Visibility__c='Good';
        insert vc5;
        apexpages.currentpage().getparameters().put('id', MPC.id);
        ApprovalSubmission ASB=new ApprovalSubmission();
        pagereference pg= new pagereference('/a04/o');
        test.setCurrentPage(pg);
        ASB.pjptab();
        
        ASB.submitforapproval();
    }
}