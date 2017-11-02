@isTest
public class SendSmsCalloutTest{
    public static testmethod void testAccountCallout() {
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                 'Complete',
                                                 '[{"Name": "sForceTest1"}]',
                                                 null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        SendSms.sendSmsToOtherSystem('9052208398','test');
       // System.assertEquals(/*check for expected results here...*/);
    }
}