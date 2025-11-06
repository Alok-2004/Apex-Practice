// In Account Object create a Multi picklist "Working in (ASIA, EMA, NA, SA)".
// Write a script to get the total "No of employees"  of all the Accounts working in ASIA and NA(North America)

public with sharing class Script27_WorkingInarea {
    public Script27_WorkingInarea() {
        getTotalEmployees();
    }

    Static void getTotalEmployees() {
        AggregateResult agg = [SELECT SUM(NumberOfEmployees) totalEmployees FROM Account WHERE Workingin__c INCLUDES ('ASIA', 'NA')];
        if(agg == null || agg.get('totalEmployees') == null) {
            System.debug('No Accounts found working in ASIA and NA.');
            return;
        }else System.debug('Size of agg is ' + agg.get('totalEmployees'));       
    }

}