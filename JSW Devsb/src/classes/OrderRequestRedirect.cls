public class OrderRequestRedirect{

 public OrderRequestRedirect() {
 system.debug('Hai in class******');
   PageReference demoPage = new pagereference('https://www.google.co.in/?gfe_rd=cr&ei=flQIWZTEI8KL8Qer1I24DA&gws_rd=ssl');
           demoPage.setRedirect(true);
 }

}