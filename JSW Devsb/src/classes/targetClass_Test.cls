@isTest
public class targetClass_Test
{
    public static testmethod void targettest()
    {
        List<Target_Child__c> tchdlst = new List<Target_Child__c>();
        Account acc = new Account();
        acc.Name = 'Sample Account';
        acc.Customer_Code__c = '1111';
        acc.Distribution_Channel__c = '10';
        acc.Sales_Office__c = '0000';
        insert acc;
        Account acc1 = new Account();
        acc1.Name = 'Sample Account1';
        acc.Customer_Code__c = '1112';
        acc.Distribution_Channel__c = '10';
        acc1.Sales_Office__c = '0000';
        insert acc1;
        Actuals__c actl = new Actuals__c();
            actl.Product_Group__c = 'PSC';
            actl.Customer_Code__c = '1111';
            actl.Distribution_Channel__c = '10';
            actl.Month__c = 'June';
            actl.Year__c = '2017';
            actl.Target__c = 10;
        insert actl;
        District__c dt = new District__c();
        dt.Territory_Code__c = '0000';
        dt.Name = 'Test';
        insert dt;
        ID dtid = [Select id from District__c limit 1].id;
        Targets__c tgt = new Targets__c();
        tgt.Month__c = 'June';
        tgt.Year__c = '2017';
        tgt.Product_Group__c = 'CHD';
        tgt.Territory__c = dtid;
        insert tgt;
        Targets__c tgt1 = new Targets__c();
        tgt1.Month__c = 'June';
        tgt1.Year__c = '2017';
        tgt1.Product_Group__c = 'OPC';
        tgt1.Territory__c = dt.Id;
        insert tgt1;
        Target_Child__c tchd = new Target_Child__c();
        tchd.Targets__c = tgt.id;
        tchd.Customer_Name__c = acc.Id;
        tchd.Nature__c='Existing';
        tchd.Target__c = 100;
        //tchd.OwnerId = system.UserInfo.getUserId();
        tchd.Territory__c = dt.id;
        tchd.Product_Group__c = 'OPC';
        tchd.Month__c='June';
        tchd.Year__c = '2018';
        tchd.Type__c = 'Trade';
        tchdlst.add(tchd);
        Target_Child__c tchd1 = new Target_Child__c();
        tchd1.Targets__c = tgt.id;
        tchd1.Customer_Name__c = acc1.Id;
        tchd.Nature__c='New';
        tchd1.Target__c = 100;
        tchdlst.add(tchd1);
        insert tchdlst;
        PageReference pageRef = Page.Target_Edit;
        Test.setCurrentPage(pageRef);
        Apexpages.currentpage().getparameters().put('id',tgt.Id);
        Apexpages.currentpage().getparameters().put('rowIndex1','1');
        Apexpages.currentpage().getparameters().put('lookupindex','1');
        ApexPages.StandardController con = new ApexPages.StandardController(tgt);
        targetClass tc = new targetClass(con);
        
        tc.tgt.Territory__c = dtid;
        tc.tgt.Month__c = 'March';
        tc.tgt.Year__c = '2017';
        tc.tgt.Product_Group__c = 'PSC';
        tc.tgtchd[0].Customer_Name__c = acc.Id;
        tc.tgtchd[0].Target__c = 100;
        tc.tgtrec.id = tgt.id;
        tc.saveTo();
        tc.editSave();
        tc.saveTo();
        //tc.tgtrec = tc.tgt;
        tc.cancel();
        tc.myActionInController();
        tc.myActionInControllerEdit();
        tc.deleteRow();
        tc.cloning();
        //tc.saveTo();
        tc.submit();
        tc.edit();
        //tc.editSave();
        tc.addrow();
        
    }
}