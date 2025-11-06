// Create a look up[Lead] on product so that Products come over in related list of a Lead.  Write script to create 3 Leads and 5 Products with Lead lookup field.


public with sharing class Script31_LeadAndProduct {
    public Script31_LeadAndProduct() {
        createLeadsAndProducts();
    }

    static void createLeadsAndProducts(){
        List<Lead> leads = new List<Lead>();
        for(Integer i = 1; i <= 3; i++){
            leads.add(new Lead(FirstName = 'Lead' + i, LastName = 'Test' + i, Company = 'Company' + i));
        }
        insert leads;

        List<Product2> products = new List<Product2>();
        for(Integer i = 1; i <= 5; i++){
            products.add(new Product2(
                Name = 'Product' + i,
                Lead__c = leads[Math.mod(i, 3)].Id,
                IsActive = true
            ));
        }
        insert products;
    }
}
