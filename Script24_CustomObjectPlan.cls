public with sharing class Script24_CustomObjectPlan {
    public Script24_CustomObjectPlan() {
        GetHRs();
    }

    static void GetHRs() {

        Map<String , Integer> hrMap = new Map<String , Integer>();

        AggregateResult result = [SELECT SUM(Travel_Hrs__c) FROM Plan__c WHERE Travel_Location__c = 'A'];
        hrMap.put('A', Integer.valueOf(result.get('expr0')));

        AggregateResult result1 = [SELECT SUM(Travel_Hrs__c) FROM Plan__c WHERE Travel_Location__c = 'F'];
        hrMap.put('F', Integer.valueOf(result1.get('expr0')));

        AggregateResult result2 = [SELECT SUM(Travel_Hrs__c) FROM Plan__c WHERE Travel_Location__c not in ('A', 'F')];
        hrMap.put('Others', Integer.valueOf(result2.get('expr0')));

        for (String key : hrMap.keySet()) {
            System.debug('Location: ' + key + ', Total Travel Hrs: ' + hrMap.get(key));
        }

    }
}