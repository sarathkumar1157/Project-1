@isTest
public class PlanDetailsTest {
    public static testMethod void PlanDetailsTestMethod(){
        date myDate = date.today();
        string dt=string.valueOf(myDate);
        string recid=ApexPages.CurrentPage().getparameters().get('id');
        string usrid=userinfo.getUserName();
        id recid1=[select Id,Name from RecordType where RecordType.Name='Trade' and SobjectType='Account'].id;
        account ac = new account(name = 'Dealer Mohan',RecordTypeId=recid1);
        insert ac;
        Lead ld = new Lead(lastname = 'test lead',company='test');
        insert ld;
        Product2 prd = new Product2(name = 'test Product',group__c='psc');
        insert prd;
        Brand__c br=new Brand__c(Name='brand');
        insert br;
        State_Head__c st=new State_Head__c(	Date__c=myDate);
        insert st;
        Zonal_Head__c zh=new Zonal_Head__c(	Date__c=myDate,State_Head__c=st.Id);
        insert zh;
        ASM_Targets__c ast=new ASM_Targets__c(date__C=myDate,Zonal_Head__c=zh.id);
        insert ast;
        PlanDetails.getRecord(recid);
        PlanDetails.getChdRecord(recid);
        PlanDetails.getAllasms();
        PlanDetails.getAllAccounts();
        PlanDetails.getAccounts(dt,prd.group__c);
        PlanDetails.getUserName();
        PlanDetails.getAllProducts();
        PlanDetails.getmtso(dt,prd.group__c,usrid);
        PlanDetails.getAllters('Test Mohan');
        PlanDetails.getAlldists();
        PlanDetails.getNT(dt,prd.group__c);
        Monthly_Dealer_Target__c mdt=new Monthly_Dealer_Target__c();
        mdt.Account__c=ac.id;
        mdt.Actuals__c=258.00;
        mdt.ASM_Target__c=ast.id;
        mdt.Quantity__c=45.00;
        wrapperlightning wrl=new wrapperlightning();
        wrl.dealer='Dealer Mohan';
        wrl.dealerid='34567';
        wrl.LYSMactual=22;
        wrl.dlractual=45.00;
        wrl.dlrqty=45;
        wrl.dlrtrget=545646;
        list<wrapperlightning> wrplst = new list<wrapperlightning>();
        wrplst.add(wrl);
        string newdlrtrgt = JSON.serialize(wrplst);
        PlanDetails.mnthtargts(newdlrtrgt,mdt,dt);
        Monthly_Targets__c mt = new Monthly_Targets__c();
        account acc=[select id,name from account where name=:wrl.dealer limit 1];
           mt.Dealer__c = acc.id;
            insert mt;
    }
}