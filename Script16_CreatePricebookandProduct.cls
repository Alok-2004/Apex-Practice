/*
Create New Price book 'Algo Pricebook' and 10 Products with Prices in the Pricebook
*/
public with sharing class Script16_CreatePricebookandProduct {
    public Script16_CreatePricebookandProduct() {
        createPricebookAndProducts();
    }

    public void createPricebookAndProducts() {
        // Fetch Standard Pricebook
        Pricebook2 stdPb = [SELECT Id FROM Pricebook2 WHERE IsStandard = true LIMIT 1];

        // Create 10 Products
        List<Product2> products = new List<Product2>();
        for (Integer i = 1; i <= 10; i++) {
            products.add(new Product2(
                Name = 'Product ' + i,
                ProductCode = 'P' + i,
                IsActive = true
            ));
        }
        insert products;

        // Create Standard Pricebook Entries (mandatory)
        List<PricebookEntry> stdEntries = new List<PricebookEntry>();
        for (Integer i = 0; i < products.size(); i++) {
            stdEntries.add(new PricebookEntry(
                Pricebook2Id = stdPb.Id,
                Product2Id = products[i].Id,
                UnitPrice = 1000 + (i * 100),
                IsActive = true
            ));
        }
        insert stdEntries;

        // Create a new custom Pricebook
        Pricebook2 customPb = new Pricebook2(
            Name = 'Algo Pricebook',
            IsActive = true
        );
        insert customPb;

        // Create entries for Algo Pricebook
        List<PricebookEntry> customEntries = new List<PricebookEntry>();
        for (Integer i = 0; i < products.size(); i++) {
            customEntries.add(new PricebookEntry(
                Pricebook2Id = customPb.Id,
                Product2Id = products[i].Id,
                UnitPrice = 2000 + (i * 150),
                IsActive = true,
                UseStandardPrice = false
            ));
        }
        insert customEntries;
    }
}
