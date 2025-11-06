// Create 10 Products with different Product Names, Discrption & Family 


public with sharing class Script4_CreateProduct {

    public Script4_CreateProduct() {
        System.debug('Script4_CreateProduct Constructor Called');
        createProducts();
    }

    public void CreateProducts() {
        String description = 'This is a test product created by Script4_CreateProduct class.';
        String Name = 'Test Product';
        String family = 'Apex';

        List<Product2> prodList = new List<Product2>();

        for(integer i = 0; i < 10 ; i++){
            Product2 prod = new Product2();
            prod.Name = Name + i;
            prod.Description = description + i;
            prod.Family = family;
            prod.IsActive = true;
            prodList.add(prod);
        }

        insert prodList;

    }
}