@isTest
public class DistrictNSRActualsSchedule_Test 
{
    public static testMethod void testschedule() 
    {
        Test.StartTest();
        DistrictNSRActualsSchedule sh1 = new DistrictNSRActualsSchedule();
        String sch = '0 15 12 * * ?'; 
        system.schedule('Test DistrictNSRActualsSchedule Check', sch, sh1);
        Test.stopTest(); 
    }
}