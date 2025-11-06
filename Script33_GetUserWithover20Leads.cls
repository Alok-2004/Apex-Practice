public with sharing class Script33_GetUserWithover20Leads {
    public Script33_GetUserWithover20Leads() {
        getUSer();
    }

    static void getUSer(){
        List <AggregateResult> UserList = [Select OwnerId from Lead where CALENDAR_MONTH(CreatedDate) = 9 And CALENDAR_YEAR(CreatedDate) = 2025 GROUP BY OwnerId Having count(ID) > 2];
        for(AggregateResult ar : UserList){
            Id userId = (Id)ar.get('OwnerId');
            System.debug('User Id: ' + userId);
        }

    }
}