@isTest
public class distTargetsTest 
{
    public static testmethod void dsttgt()
    {
        State__c st = new State__c();
        st.name = 'test state';
        st.State_Code__c = 'abcst';
        insert st;
        
        Districts__c dst = new Districts__c();
        dst.District_Code__c = 'abcdst';
        dst.Name = 'test dst';
        dst.State__c = st.id;
        dst.District_Category__c='test';
        insert dst;
        
        District_Targets__c dt = new District_Targets__c();
        //dt.Name = 'test dt';
        dt.District_Code__c = 'abcdst';
        dt.Product_Group__c = 'PSC';
        dt.Month__c = 'June';
        dt.Year__c = '2017';
        dt.No_of_Days_in_a_Month__c = 30;
        dt.Target_Start_Date__c = Date.newInstance(2017,06,01);
        insert dt;
    }
}