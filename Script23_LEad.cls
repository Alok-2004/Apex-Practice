// Create a new multiplicklist field In Lead Object"Records" [Buyer, Seller, Tenant , Landloard]. 
// Write script to fetch all the Sellers and Tenant which were entered in last year.

public with sharing class Script23_LEad {
    public Script23_LEad() {
        getLeads();
    }

    static void getLeads() {
        List<Lead> leadList = [SELECT Id, Name, CreatedDate FROM Lead WHERE (Type_Scirpt__c Includes ('Seller', 'Tenant')) AND CreatedDate = LAST_N_DAYS:365 ];

        for (Lead ld : leadList) {
            System.debug('Lead Name: ' + ld.Name + ', Multi Picklist Values: ' + ld.Type_Scirpt__c);
        }
    }
}