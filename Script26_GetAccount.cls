
// Write a Script to get all the Accounts having more than 2 Oppotunity Line Items in their Opportunity.

public with sharing class Script26_GetAccount {
    public Script26_GetAccount() {
        getAccount();
    }

    static void getAccount() {
        List<AggregateResult>agg = [Select OpportunityId from OpportunityLineItem Group By OpportunityId Having Count(Id) > 2];

        if(agg.size() == 0) {
            System.debug('No Opportunity Line Items found with more than 2 items.');
            return;
        }

        Set<Account> accSet = new Set<Account>();

        for(AggregateResult ar : agg) {
            Id OppId = (Id)ar.get('OpportunityId');
            Opportunity opp = [Select AccountId, Account.Name from Opportunity where Id = :OppId Limit 1];
            accSet.add(opp.Account);
        }
        
        System.debug('Size of accSet is ' + accSet.size());

    }

}