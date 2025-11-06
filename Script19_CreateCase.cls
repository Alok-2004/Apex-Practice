// WAP to create 5 Case Records with all the values(Account, Contact, etc) filled in.

public with sharing class Script19_CreateCase {
    public Script19_CreateCase() {
        createCases();
    }

    public static void createCases(){

        List <Account> acc = [SELECT Id, Name FROM Account Order by Id LIMIT 1];
        List <Contact> con = [SELECT Id From Contact Order by Id LIMIT 1];

        Integer caseCount = 5;
        List<Case> caseList = new List<Case>();

        While(caseCount > 0){
            Case c = new Case();
            c.AccountId = acc[0].Id;
            c.ContactId = con[0].Id;
            c.Origin = 'Phone';
            c.Status = 'New';
            c.Priority = 'Medium';
            c.Subject = 'Test Case Subject ' + caseCount;
            c.Description = 'This is a description for test case ' + caseCount;
            caseList.add(c);
            caseCount--;
        }

        insert caseList;
        System.debug('5 Case Records Created Successfully');

    }
}