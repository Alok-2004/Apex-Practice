// Update all Opportunity with future Closed Date by Opportunity Name=Opportunity Name + 'F'

public with sharing class Script6_UpdateOpportunity {
    public Script6_UpdateOpportunity() {
        updateOpp();
    }

     void updateOpp() {
        List<Opportunity> oppList = [SELECT Id, Name, CloseDate FROM Opportunity WHERE CloseDate > TODAY];
        for (Opportunity opp : oppList) {
            opp.Name = opp.Name + 'F';
        }
        System.debug('### oppList: ' + oppList);
        update oppList;
    }
}