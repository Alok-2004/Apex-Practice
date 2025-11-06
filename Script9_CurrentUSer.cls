// Display the current salesforce user details 'Name', 'Number' & 'EmailId'

public with sharing class Script9_CurrentUSer {
    public Script9_CurrentUSer() {
        getCurrentUSer();
    }
    void getCurrentUSer(){
        sObject currentUSer = [SELECT Id, Name, Email FROM User WHERE Id = :UserInfo.getUserId()];

        User u = (User) currentUser;

        System.debug('User ID: ' + u.Id);
        System.debug('User Name: ' + u.Name);
        System.debug('User Email: ' + u.Email);
    }
}