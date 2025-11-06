// Write a script to get all Account those are associated with opportunity and put the attachment from account to their opportunity. 
// If the account does not have attachment put opportunity close loss otherwise close won.

public with sharing class Script36_transferAttachFromAccToOpp {
    public Script36_transferAttachFromAccToOpp() {
        getWorkDone();
    }

    static void getWorkDone(){
        List<AggregateResult> AggreagateAccWithOpp = [SELECT AccountId Id FROM Opportunity GROUP BY AccountId];     
        Set<Id> AccWithOpp = new Set<Id>(); 
        for(AggregateResult ar : AggreagateAccWithOpp){
            AccWithOpp.add((Id)ar.get('Id'));
        }

        if(AccWithOpp.isEmpty()){
            System.debug('No Account with Opportunity');
            return;
        }

        List<ContentdocumentLink> AccWithAttCDL = [Select LinkedEntityId from ContentdocumentLink where LinkedEntityId in :AccWithOpp];

        Set<Id> AccwithAtt = New Set<Id>();

        for(ContentdocumentLink cdl : AccWithAttCDL){
            AccwithAtt.add(cdl.LinkedEntityId);
        }
        
        // Seperating Account without Attachments in AccWithOpp

        List<id> AccWithoutAtt = new List<Id>();

        for(Id accId :  AccWithOpp){
            if(!AccwithAtt.contains(accId)){
                AccWithoutAtt.add(accId);
            }
        }

        // HAndling Account without Attachments
        if(AccWithoutAtt.isEmpty()){
            System.debug('All Accounts have Attachments');
        }else{
            List<Opportunity> oppList = [SELECT Id, Name, AccountId, StageName FROM Opportunity WHERE AccountId in :AccWithoutAtt];
            for(Opportunity opp : oppList){
                opp.StageName = 'Closed Lost';
            }
            update oppList;
        }

        // Handling Account with Attachments
        if(AccwithAtt.isEmpty()){
            System.debug('No Account with Attachments');
        }else{
            List<Opportunity> oppList = [SELECT Id, Name, AccountId, StageName FROM Opportunity WHERE AccountId in :AccWithAtt];
            for(Opportunity opp : oppList){
                opp.StageName = 'Closed Won';
            }
            update oppList;


            // To do : Transfer Attachments from Account to Opportunity

            List<ContentDocumentLink> accLinks = [SELECT ContentDocumentId, LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId IN :AccwithAtt];    

            Map<Id, List<Opportunity>> accToOppMap = new Map<Id, List<Opportunity>>();
            for (Opportunity opp : oppList) {
                if(!accToOppMap.containsKey(opp.AccountId)) {
                    accToOppMap.put(opp.AccountId, new List<Opportunity>());
                }
                accToOppMap.get(opp.AccountId).add(opp);
            }

            List<ContentDocumentLink> newLinks = new List<ContentDocumentLink>();

            for (ContentDocumentLink accLink : accLinks) {
                Id accId = accLink.LinkedEntityId;
                if (accToOppMap.containsKey(accId)) {
                    for (Opportunity opp : accToOppMap.get(accId)) {
                        newLinks.add(new ContentDocumentLink(
                            ContentDocumentId = accLink.ContentDocumentId,
                            LinkedEntityId = opp.Id,
                            ShareType = 'V',  // Viewer (or 'I' for Inferred, 'C' for Collaborator)
                            Visibility = 'AllUsers'
                        ));
                    }
                }
            }

            if (!newLinks.isEmpty()) {
                insert newLinks;
            }

        }        
    }
}