//  Write a script to get all the Account having more than 10 opportunities whose status is closed won and the close date is between one month.

public with sharing class Script34_GetAccountwith10Opp {
    public Script34_GetAccountwith10Opp() {
        getAccount();
    }

    static void getAccount(){
        List<AggregateResult> AccountList = [Select AccountId from Opportunity where StageName = 'Closed Won' And CloseDate = LAST_N_DAYS:30 Group By AccountId Having Count(Id) > 1];
        
        List<Account> accList = new List<Account>();

        for(AggregateResult ar : AccountList){
            Id accId = (Id)ar.get('AccountId');
            System.debug('Account Id: ' + accId);
        }
    }
}