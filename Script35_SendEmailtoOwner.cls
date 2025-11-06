// Write a script to send Email to all users which are having more than 100 Account (Having phone number) and 30 contacts(Having email address).

// Edit 5 Account and 3 Opportunity

public with sharing class Script35_SendEmailtoOwner {
    public Script35_SendEmailtoOwner() {
        sendEmail();
    }

    static void sendEmail(){
        List<AggregateResult> USerIdAcc = [Select OwnerId from Account where Phone != null Group by OwnerId Having Count(ID) > 5];

        List<Id> userList = new List<Id>();
        for (AggregateResult ar : userIdAcc) {
            userList.add((Id)ar.get('OwnerId'));
        }

        List<AggregateResult> USerIdCon = [Select OwnerId from Contact where Email != null And OwnerId in :userList Group by OwnerId Having Count(ID) > 3];

        List<Id> finalUserList = new List<Id>();

        for (AggregateResult ar : USerIdCon) {
            finalUserList.add((Id)ar.get('OwnerId'));
        }

        if (finalUserList.isEmpty()) {
            System.debug('No users found meeting both Account and Contact conditions.');
            return;
        }
        
        List<User> USerMail = [Select Email from User where Id in :finalUserList];

        List<String> toAddresses = new List<String>();
        for(User u : USerMail){
            toAddresses.add(u.Email);
        }

        if (!toAddresses.isEmpty()) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(toAddresses); //Expects a List
            mail.setSubject('Notification: Account and Contact Threshold Exceeded');
            mail.setPlainTextBody(
                'Dear User,\n\n' +
                'You currently have more than 100 Accounts with phone numbers and more than 30 Contacts with email addresses.\n' +
                'Please review your records accordingly.\n\n' +
                'Best Regards,\nSalesforce Admin'
            );
            
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            System.debug('Email sent to: ' + toAddresses);
        } else {
            System.debug('No email addresses found for qualified users.');
        }

    }
}