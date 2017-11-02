@RestResource(urlMapping='/UserManagement/*')
global with sharing class UserWebservice{

  @HttpPost
    global static List<User> doPost() {
        
        List<User> userList = [select id,name,UserRole.Name from User where UserRoleId != null];
        
        return userList;
    }
 
}