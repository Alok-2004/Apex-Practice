// Write a Script to get all the Contacts having same email as any Salesforce User.Email

public with sharing class Script28_MatchEmail {
    public Script28_MatchEmail() {
        getContactsWithUserEmails();
    }

    static void getContactsWithUserEmails() {
        List<User> users = [SELECT Email FROM User WHERE Email != null];
        Set<String> userEmails = new Set<String>();

        for (User u : users) {
            userEmails.add(u.Email);
        }

        if (userEmails.isEmpty()) {
            System.debug('No user emails found.');
            return;
        }

        List<Contact> contacts = [SELECT Id, Name, Email FROM Contact WHERE Email IN :userEmails];

        if (contacts.isEmpty()) {
            System.debug('No Contacts found with matching User emails.');
        } else {
            System.debug('Contacts with matching User emails: ' + contacts);
        }
    }
}
