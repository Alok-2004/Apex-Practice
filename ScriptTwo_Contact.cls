public with sharing class ScriptTwo_Contact {
    public ScriptTwo_Contact() {
        createContacts();   
    }

    public void createContacts() {
        List<Account> accList = [SELECT Id FROM Account WHERE RecordType.Name = 'Business Account' LIMIT 10];
        List<Contact> contList = new List<Contact>();

        String lastName = 'TestLastName';
        String firstName = 'TestFirstName';
        String salutation = 'Mr.';

        for (Integer i = 0; i < accList.size(); i++) {
            Contact c = new Contact();
            c.LastName = lastName + i;
            c.FirstName = firstName + i;
            c.Salutation = salutation;
            c.AccountId = accList[i].Id;
            contList.add(c);
        }

        insert contList;
    }
}