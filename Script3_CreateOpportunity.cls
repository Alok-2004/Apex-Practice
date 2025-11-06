/*
Create 20 Opportunity with Closed Date, Stage and Opportyunity Name. With all the accounts attached, which are created in the first step.
*/


public with sharing class Script3_CreateOpportunity {
    public Script3_CreateOpportunity() {
        System.debug('Script3_CreateOpportunity Constructor Called');
        createOpportunities();
    }

    public void createOpportunities() {
        List<Account> accList = [SELECT Id, Name FROM Account ORDER BY CreatedDate DESC LIMIT 10];
        List<Opportunity> oppList = new List<Opportunity>();

        // Query Record Type Id for Licensing Deal
        Id licensingDealRecordTypeId = [
            SELECT Id FROM RecordType 
            WHERE SObjectType = 'Opportunity' AND Name = 'Licensing Deal' 
            LIMIT 1
        ].Id;

        String oppNamePrefix = 'Test Opp ';
        Date closeDate = Date.today().addDays(15);

        for (Account acc : accList) {
            for (Integer j = 0; j < 2; j++) {
                Opportunity opp = new Opportunity();
                opp.Name = oppNamePrefix + acc.Name + '_' + j;
                opp.StageName = 'Prospecting';
                opp.CloseDate = closeDate;
                opp.AccountId = acc.Id;
                opp.RecordTypeId = licensingDealRecordTypeId;
                oppList.add(opp);
            }
        }

        insert oppList;
        System.debug('Total Opportunities inserted: ' + oppList.size());
    }
}
