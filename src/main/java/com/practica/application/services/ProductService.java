package com.practica.application.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.NestedRuntimeException;
import org.springframework.stereotype.Service;

import com.practica.application.exceptions.DataSourceException;
import com.practica.application.persistence.models.Product;
import com.practica.application.persistence.models.ProductImage;
import com.practica.application.persistence.models.UnitsPerSize;
import com.practica.application.repositories.ProductRepository;

@Service
public class ProductService {
    @Autowired
    private ProductRepository productRepository;
    
    private static final String EXCEPTION_RESPONSE = "There are no Products created to be shown.";
    private static final String EXCEPTION_NOT_FOUND = "Product received not exists.";
    public void save(Product product) {
        try {
            productRepository.save(product);
        } catch(NestedRuntimeException ex) {
            throw new DataSourceException(ex.getRootCause().getLocalizedMessage());
        }        
    }
    
    public void saveImages(Long productId, String imageDescription, String imageUrl) {
        try {
            Optional<Product> optionalProductId = productRepository.findById(productId);
            if(optionalProductId.isEmpty()) {
                throw new DataSourceException(EXCEPTION_NOT_FOUND);
            }
            Product product = optionalProductId.get();
            ProductImage productImage = new ProductImage();
            productImage.setImageDescription(imageDescription);
            productImage.setImageUrl(imageUrl);
            productImage.setProduct(product);
            product.getImages().add(productImage);
            productRepository.save(product);
            
        } catch(NestedRuntimeException ex) {
            throw new DataSourceException(ex.getRootCause().getLocalizedMessage());
        }        
    }
    
    public void saveSizesAndUnits(Long productId, String size, int unitsAvailable) {
        try {
            Optional<Product> optionalProductId = productRepository.findById(productId);
            if(optionalProductId.isEmpty()) {
                throw new DataSourceException(EXCEPTION_NOT_FOUND);
            }
            Product product = optionalProductId.get();
            UnitsPerSize unitsPerSize = new UnitsPerSize();
            unitsPerSize.setProduct(product);
            unitsPerSize.setSize(size);
            unitsPerSize.setUnitsAvailable(unitsAvailable);
            product.getUnitsPerSizes().add(unitsPerSize);
            productRepository.save(product);

        } catch(NestedRuntimeException ex) {
            throw new DataSourceException(ex.getRootCause().getLocalizedMessage());
        }        
    }
    

    public List<Product> list() {
        
        List<Product> allProducts = productRepository.findAll();        
        if(allProducts.isEmpty()) throw new DataSourceException(EXCEPTION_RESPONSE);
        
        return allProducts;            
    }

    
}
