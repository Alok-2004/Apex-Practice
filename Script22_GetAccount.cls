// Write a Script to get all the Accounts having Oppotunity Line Items Quantity > 100 under their Opportunities(CLOSED WON only).

public with sharing class Script22_GetAccount {
    public Script22_GetAccount() {
        getAccount();
    }

    static void getAccount(){

        List<Opportunity> OpportunityList = [SELECT Id, Name, AccountId FROM Opportunity WHERE StageName = 'Closed Won' AND Id IN (SELECT OpportunityId FROM OpportunityLineItem WHERE Quantity > 2)];

        Map<Account, Integer> accountOppCountMap = new Map<Account, Integer>();

        for (Opportunity opp : opportunityList) {
            Account acc = opp.Account;

            if (acc != null) {
                if (accountOppCountMap.containsKey(acc)) {
                    accountOppCountMap.put(acc, accountOppCountMap.get(acc) + 1);
                } else {
                    accountOppCountMap.put(acc, 1);
                }
            }
        }

        for (Account acc : accountOppCountMap.keySet()) {
            System.debug('Account Name: ' + acc.Name +' | Total Closed Won Opportunities (LineItem Qty > 100): ' + accountOppCountMap.get(acc));
        }
    }
}
