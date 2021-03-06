@isTest
public Class mktInfoTest{
    public static testMethod  void updateAccount()
    {
        date myDate = date.today();
        string dt=string.valueOf(myDate);
        mktinfo.getAllBrands();
        mktinfo.getAllProducts();
        string recid=ApexPages.CurrentPage().getparameters().get('id');
        District__c dst = new District__c();
        dst.Name = 'Sample District';
        insert dst;
        account ac = new account(name = 'test account');
        insert ac;
        Lead ld = new Lead(lastname = 'test lead',company='test');
        insert ld;
        Product2 prd = new Product2(name = 'test Product');
        insert prd;
        Day_Plan__c dp = new Day_Plan__c();
        insert dp;
        Business_Partner__c bp = new Business_Partner__c();
        bp.Name = 'Sample BP';
        insert bp;
        Project_Site__c prj = new Project_Site__c();
        prj.Name = 'Sample Project Site';
        prj.Type__c = 'Project Sites';
        prj.End_Customer_Name__c = 'Sample Customer';
        prj.Volume_Potential_in_MT__c = 12345;
        prj.Territory__c = dst.Id;
        insert prj;
        Influencer__c inf = new Influencer__c();
        inf.Name = 'Sample Influencer';
        inf.Inclination_to_JSW__c = 'Fully inclined';
        inf.Type__c = 'Engineers';
        inf.Registered_with_JSW_ELP_program__c = 'Yes';
        insert inf;
        Visit__c vst = new Visit__c(name = 'test visit',Day_Plan__c = dp.id,Account__c=ac.id);
        insert vst;
        Visit__c vst1 = new Visit__c(name = 'test visit',Day_Plan__c = dp.id,Lead__c=ld.id);
        insert vst1;
        Visit__c vst2 = new Visit__c(name = 'test visit',Day_Plan__c = dp.id,Business_Partner__c=bp.id);
        insert vst2;
        Visit__c vst3 = new Visit__c(name = 'test visit',Day_Plan__c = dp.id,Influencer__c=inf.id);
        insert vst3;
        Brand__c br=new Brand__c(Name='brand');
        insert br;
        
        Market_Information__c mi = new Market_Information__c();
        mi.Account__c = ac.id;
        mi.Product__c = prd.id;
        mi.Visit__c = vst.id;
        mi.Lead__c = ld.id;
        mi.Business_Partner__c = bp.id;
        mi.Sites__c = prj.id;
        mi.Influencer__c = inf.id;
        mi.Comments__c = 'Test Code';
        insert mi;
        Brand__c bnd = [select id, name from Brand__c Order By Name limit 1];
        Marketing_Info__c mkt = new Marketing_Info__c();
        mkt.Market_Information__c = mi.Id;
        mkt.Account__c = mi.Account__c;
        mkt.Brand__c = bnd.id;
        mkt.Products__c = 'PSC';
        mkt.BP_Min__c = 100.00;
        mkt.RSP_Min__c = 200.00;
        mkt.WSP_Min__c = 300.00;
        insert mkt;
        
        mktinfo.getRecord(mi.Id);
        mktinfo.getChdRecord(mkt.id);
        mktinfo.getAllAccounts(ac.id);
        Test.setCurrentPageReference(new PageReference('Page.myPage')); 
        System.currentPageReference().getParameters().put('CF00NN0000002D7Ca_lkid', vst.Id);
        mktinfo.getAllVsts(vst.id);
        mktinfo.getAllVsts(vst1.id);
        mktinfo.getAllVsts(vst2.id);
        mktinfo.getAllVsts(vst3.id);
        mktinfo.getAllLeads(ld.id);
        mktinfo.getAllwraps();
        mktinfo.getAllters();
        mktinfo.getAllbnspartns(bp.id);
        mktinfo.getAllInfs(inf.id);
        mktinfo.getAllpjtsites(prj.id);
        mktinfo.getallMi('test',dt);
        mktinfo.getallMijsw('test',dt);
        Market_Information__c mi2 = new Market_Information__c();
        mi2.Account__c = ac.id;
        mi2.Product__c = prd.id;
        mi2.Visit__c = vst.id;
        mi2.Lead__c = ld.id;
        mi2.Comments__c = 'Test Code';
        mktinfowrapper wrp = new mktinfowrapper();
        wrp.Brand = bnd.id;
        wrp.Product = prd.id;
        wrp.BPMin = 10.00;
        wrp.RSP = 20.00;
        wrp.WSP = 30.00;
        list<mktinfowrapper> wrplst = new list<mktinfowrapper>();
        wrplst.add(wrp);
        list<Market_Information__c> mkinflst = new list<Market_Information__c>();
        mkinflst.add(mi);
        list<Marketing_Info__c> mktlst = new list<Marketing_Info__c>();
        mktlst.add(mkt);
        String newmkinfo = JSON.serialize(wrplst);
        String newmkt = JSON.serialize(mktlst);
        String newmktinfo = JSON.serialize(mkinflst);
        mktinfo.getSave(mi2,newmkinfo,ac.id,ld.id,vst.id,bp.id,prj.id,inf.id);
        mktinfo.saveEdit(newmkt, newmktinfo);
}
}