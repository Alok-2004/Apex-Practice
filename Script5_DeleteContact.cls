public with sharing class Script5_DeleteContact {
    public Script5_DeleteContact() {
        deleteContacts();
        System.debug('Script5_DeleteContact executed');
    }

    public void deleteContacts(){

        List<Contact> contList = [Select id from Contact where Account.Name LIKE '%Grand%'];
        System.debug(contList);
        delete contList;

    }
}