@RestResource(urlMapping='/UserLogin/*')
global with sharing class LoginRoleWebservice{

  @HttpPost
    global static String doPost(String userId) {
        
        User curuser = [select id,name,Userrole.Name from User where UserRoleId != null and id =: userId];
        String rolename = '';
        
        if(curuser.Userrole.Name.contains('TSO'))
        rolename = 'TSO';
        else if(curuser.Userrole.Name.contains('SO'))
        rolename = 'SO';
        else if(curuser.Userrole.Name.contains('ASM'))
        rolename = 'ASM';
        else
        rolename = curuser.UserRole.Name;
        return rolename;
    }
 
}