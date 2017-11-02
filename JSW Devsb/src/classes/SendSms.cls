global class SendSms{
 @future(callout=true)
 public static void sendSmsToOtherSystem(String phone,String message1){
 system.debug('****phone***'+phone);
  system.debug('****message1***'+message1);
 HttpRequest req = new HttpRequest();
 String url='http://info.bulksms-service.com/WebServiceSMS.aspx?User=T2015122802&passwd=HZTc85Cj5p&mobilenumber='+phone+'&message='+message1+'&sid=JSWCMT&mtype=N';
String url1=url.replaceAll(' ','%20');

system.debug('****url***'+url1);
 req.setEndpoint(url1);
 req.setMethod('GET');



 /*String username = 'T2015122802';
 String password = 'HZTc85Cj5p';

 Blob headerValue = Blob.valueOf(username + ':' + password);
 String authorizationHeader = 'BASIC ' +
 EncodingUtil.base64Encode(headerValue);
 req.setHeader('Authorization', authorizationHeader);
*/
 
 Http http = new Http();
 HTTPResponse res = http.send(req);
 System.debug(res.getBody());
  }
 }