@isTest
public class MRMStateCode_Test 
{
	public static testmethod void mrmsttest()
    {
        state__c st = new state__c();
        st.State_Code__c = '01';
        st.Name = 'test st';
        insert st;
        
        State_MRM_Targets__c mrm0 = new State_MRM_Targets__c();
        mrm0.State_Code_Text__c = '01';
        mrm0.month__c = 'May';
        insert mrm0;
        
        State_MRM_Targets__c mrm = new State_MRM_Targets__c();
        mrm.State_Code_Text__c = '01';
        mrm.month__c = 'June';
        insert mrm;
        
        State_MRM_Targets__c mrm1 = new State_MRM_Targets__c();
        mrm1.State_Code_Text__c = '01';
        mrm1.month__c = 'July';
        insert mrm1;
        
        State_MRM_Targets__c mrm2 = new State_MRM_Targets__c();
        mrm2.State_Code_Text__c = '01';
        mrm2.month__c = 'August';
        insert mrm2;
        
        State_MRM_Targets__c mrm3 = new State_MRM_Targets__c();
        mrm3.State_Code_Text__c = '01';
        mrm3.month__c = 'April';
        insert mrm3;
        
        State_MRM_Targets__c mrm4 = new State_MRM_Targets__c();
        mrm4.State_Code_Text__c = '01';
        mrm4.month__c = 'March';
        insert mrm4;
        
        State_MRM_Targets__c mrm5 = new State_MRM_Targets__c();
        mrm5.State_Code_Text__c = '01';
        mrm5.month__c = 'February';
        insert mrm5;
        
        /*MRM_Targets__c mrm6 = new MRM_Targets__c();
        mrm6.State_Code_Text__c = '01';
        mrm6.month__c = 'January';
        insert mrm6;*/
        
        State_MRM_Targets__c mrm7 = new State_MRM_Targets__c();
        mrm7.State_Code_Text__c = '01';
        mrm7.month__c = 'September';
        insert mrm7;
        
        State_MRM_Targets__c mrm8 = new State_MRM_Targets__c();
        mrm8.State_Code_Text__c = '01';
        mrm8.month__c = 'October';
        insert mrm8;
        
        State_MRM_Targets__c mrm9 = new State_MRM_Targets__c();
        mrm9.State_Code_Text__c = '01';
        mrm9.month__c = 'November';
        insert mrm9;
    }
}