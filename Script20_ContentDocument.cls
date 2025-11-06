public with sharing class Script20_ContentDocument {
    public Script20_ContentDocument() {
        transferFiles();
    }

    static void transferFiles() {
        List<ContentDocumentLink> contentDocLinks = [Select ContentDocumentID from ContentDocumentLink where LinkedEntityId = '001gK00000IegZJQAZ'];
        if(contentDocLinks.size() < 0) {
            System.debug('No Files Found');
            return;
        }

        List<Id> contentDocIds = new List<Id>();
        for(ContentDocumentLink cdl : contentDocLinks) {
            contentDocIds.add(cdl.ContentDocumentId);
        }

        List <Contact> contacts = [Select Id from Contact where AccountId = '001gK00000IegZJQAZ'];

        List<ContentDocumentLink> newContentDocLinks = new List<ContentDocumentLink>();

        for(Id contentDocId : contentDocIds) {
            for(Contact con : contacts) {
                ContentDocumentLink newCdl = new ContentDocumentLink();
                newCdl.ContentDocumentId = contentDocId;
                newCdl.LinkedEntityId = con.Id;
                newCdl.ShareType = 'V';
                newCdl.Visibility = 'AllUsers';
                newContentDocLinks.add(newCdl);
            }
        }

        insert newContentDocLinks;
    }
}