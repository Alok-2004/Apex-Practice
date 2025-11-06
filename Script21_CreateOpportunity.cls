// Write a code to clone(copy ) 1 Opportunity with all Opportunity line items into a new Opportunity with Closed Date = Old closed date + 30 days & Opportunity name = Opportunity Name+ 'Clone'

public with sharing class Script21_CreateOpportunity {
    public Script21_CreateOpportunity() {
        createOpportunities();
    }

    public static void createOpportunities() {

        AggregateResult ar = [SELECT OpportunityId oppId, COUNT(Id) lineItemCount FROM OpportunityLineItem GROUP BY OpportunityId ORDER BY COUNT(Id) DESC LIMIT 1];
        Id oppId = (Id) ar.get('oppId');

        Opportunity originalOpp = [SELECT Id, Name, CloseDate, StageName, AccountId, Pricebook2Id FROM Opportunity WHERE Id = :oppId LIMIT 1];
        List<OpportunityLineItem> oppLineItems = [SELECT Id, OpportunityId, PricebookEntryId, Quantity, UnitPrice FROM OpportunityLineItem WHERE OpportunityId = :oppId];

        Opportunity newOpp = originalOpp.clone(false, false, false, false);
        newOpp.Name = originalOpp.Name + ' Clone';
        newOpp.CloseDate = originalOpp.CloseDate.addDays(200);
        insert newOpp;

        List<OpportunityLineItem> newOppLineItems = new List<OpportunityLineItem>();
        for (OpportunityLineItem oli : oppLineItems) {
            OpportunityLineItem newOli = oli.clone(false, false, false, false);
            newOli.OpportunityId = newOpp.Id;
            newOppLineItems.add(newOli);
        }

        if (!newOppLineItems.isEmpty()) insert newOppLineItems;
        else System.debug('No Opportunity Line Items found to clone.');
    }
}
