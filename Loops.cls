public with sharing class Loops {
    public Loops() {
        
        // List<Account> accList = [SELECT Id, Name FROM Account LIMIT 5];

        forLoopExample();
        //whileLoopExample(accList);
        //doWhileLoopExample(accList);
        //nestedLoopExample(accList);
        //NoLoop_SingleRecord(accList);
    }
    
    void forLoopExample() {
        // Traditional for loop
        integer check = 10;
        for (Integer i = 0; i < 5; i++) {
            
            check = 50;
        }
        
        System.debug('check: '+check);

    }

}