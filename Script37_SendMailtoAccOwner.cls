public with sharing class Script37_SendMailtoAccOwner {
    public Script37_SendMailtoAccOwner() {
        sendMail();
    }

    static void sendMail() {
        List<Opportunity> oppList = [SELECT Id, Name, Amount, CloseDate, Account.Owner.Email FROM Opportunity WHERE CloseDate = NEXT_N_DAYS:10];

        if (oppList.isEmpty()) {
            System.debug('OppList is empty');
            return;
        }

        Set<String> emailSet = new Set<String>();
        for (Opportunity opp : oppList) {
            if (opp.Account.Owner.Email != null) {
                emailSet.add(opp.Account.Owner.Email);
            }
        }

        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        for (String email : emailSet) {
            String body = 'Dear User,\n\n'
                + 'Here are your Opportunities closing in 10 days:\n\n';
            
            for (Opportunity opp : oppList) {
                if (opp.Account.Owner.Email == email) {
                    body += 'Opportunity Name: ' + opp.Name 
                        + '\nAmount: ' + opp.Amount 
                        + '\nClose Date: ' + opp.CloseDate + '\n\n';
                }
            }

            body += 'Please review these opportunities.\n\nBest Regards,\nSalesforce Admin';

            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(new List<String>{ email });
            mail.setSubject('Upcoming Opportunity Closing Reminder');
            mail.setPlainTextBody(body);
            mails.add(mail);
        }

        if (!mails.isEmpty()) {
            Messaging.sendEmail(mails);
            System.debug('Emails sent successfully to account owners.');
        } else {
            System.debug('No valid email addresses found.');
        }
    }
}
