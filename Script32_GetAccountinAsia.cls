// In Account Object create a Multi picklist "Working in (ASIA, EMA, NA, SA)" Multipicklist.
// Write a script to get the total Quantity of Products sold in only Accounts working in ASIA.

public with sharing class Script32_GetAccountinAsia {
    public Script32_GetAccountinAsia() {
        getTotalQuantityInAsia();
    }

    static void getTotalQuantityInAsia(){

        // List <Account> asiaAccounts = [SELECT Id FROM Account WHERE Workingin__c INCLUDES ('ASIA')];
        // if(asiaAccounts.size() == 0) {
        //     System.debug('No Accounts found working in ASIA.');
        //     return;
        // }

        // List<Opportunity> asiaOpportunities = [SELECT Id FROM Opportunity WHERE AccountId IN :asiaAccounts];

        // if(asiaOpportunities.size() == 0) {
        //     System.debug('No Opportunities found for Accounts working in ASIA.');
        //     return;
        // }

        // List<OpportunityLineItem> oliList = [SELECT Quantity FROM OpportunityLineItem WHERE OpportunityId IN :asiaOpportunities];

        // if(oliList.size() == 0) {
        //     System.debug('No Products sold for Opportunities in Accounts working in ASIA.');
        //     return;
        // }

        // Decimal totalQuantity = 0;
        // for(OpportunityLineItem oli : oliList){
        //     totalQuantity += oli.Quantity; 
        // }
        // System.debug('Total Quantity of Products sold in only Accounts working in ASIA: ' + totalQuantity);

        AggregateResult x = [SELECT SUM(Quantity) totalQty FROM OpportunityLineItem WHERE Opportunity.Account.Workingin__c INCLUDES ('ASIA')];

        System.debug('Total Quantity using Aggregate Query: ' + x.get('totalQty'));


    }
}