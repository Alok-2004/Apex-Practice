public with sharing class Script18_CreateUSer {
    public Script18_CreateUSer() {
        CreateUserRecords();
    }

    static void CreateUserRecords(){
        Id systemAdminProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1].Id;

        User user = new User();
        user.Username = 'emailtest@test.com';
        user.FirstName = 'First';
        user.LastName = 'Last';
        user.Alias = 'Alias';
        user.Email = 'alokprasad02004@gmail.com';
        user.TimeZoneSidKey = 'America/New_York';
        user.LocaleSidKey = 'en_US';
        user.EmailEncodingKey = 'ISO-8859-1';
        user.ProfileId = systemAdminProfileId;
        user.LanguageLocaleKey = 'en_US';

        insert user;
    }
}