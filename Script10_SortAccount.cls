// Print the Account Names in Alphabetical accending order.

public with sharing class Script10_SortAccount {
    public Script10_SortAccount() {
        getAccount();
    }

    void getAccount(){
        List <Account> accList = [SELECT Id, Name FROM Account ORDER BY Name ASC];

        for(Account acc : accList){
            System.debug(acc.Name);
        }
    }

}
