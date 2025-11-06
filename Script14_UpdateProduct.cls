// Find all the Products having Description field containing 'a' in it.

public with sharing class Script14_UpdateProduct {
    
    public Script14_UpdateProduct() {
        updateProducts();
    }
    
    public void updateProducts() {
        List<Product2> productsToUpdate = [SELECT Id, Name, Description FROM Product2 WHERE Description LIKE '%a%'];
        
        if(productsToUpdate.isEmpty()) {
            System.debug('No products found to update.');
        } else {
            for(Product2 p : productsToUpdate) {
                p.Description = p.Description + ' - Updated'; 
            }
            
            update productsToUpdate;
            System.debug(productsToUpdate.size() + ' products updated successfully.');
        }
    }
}
