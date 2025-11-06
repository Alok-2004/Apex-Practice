// Create several Accounts and Opportunites and products. Write a Script to get all the Accounts having more than 2 Opportunites with Closed Won.

public with sharing class Script30_GetAccwithCondition {
    public Script30_GetAccwithCondition() {
        getAccounts();
    }

    static void getAccounts() {
        List<AggregateResult> accList = [SELECT AccountId FROM Opportunity WHERE StageName = 'Closed Won' GROUP BY AccountId HAVING COUNT(Id) > 2];
        System.debug('Accounts with more than 2 Opportunities' + accList);
    }
}