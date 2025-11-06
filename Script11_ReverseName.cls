public with sharing class Script11_ReverseName {
    public Script11_ReverseName() {
        getAccount();  
    }

    void getAccount(){
        List <Account> accList = [SELECT Id, Name FROM Account ORDER BY Name ASC];

        for(Account acc : accList){
            System.debug(acc.Name.reverse());
        }
    }
}