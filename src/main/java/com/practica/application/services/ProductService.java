package com.practica.application.services;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

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

    public Product save(Product product) {
        try {
            return productRepository.save(product);
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

    public Product find(Long id) {
        Optional<Product> productOptional = productRepository.findById(id);

        if(productOptional.isEmpty()) throw new DataSourceException(EXCEPTION_RESPONSE);
        
        return productOptional.get();
    }
    
    public List<Map<String, Object>> findByActiveCollection() {
        
        try {         
            List<Product> availableProducts = productRepository.findByCollectionJoin();
            if(availableProducts.isEmpty()) throw new DataSourceException(EXCEPTION_RESPONSE);
            
            return groupProductsByCollection(availableProducts);

        } catch(NestedRuntimeException ex) {
            throw new DataSourceException(ex.getRootCause().getLocalizedMessage());
        }     
    }

    public static List<Map<String, Object>> groupProductsByCollection(List<Product> productsToGroupBy) {

        List<Map<String, Object>> groupedProducts = productsToGroupBy.stream()
        .collect(Collectors.groupingBy(Product::getCollection))
        .entrySet()
        .stream()
        .map(entry -> {
            Map<String, Object> groupedProduct = new HashMap<>();
            groupedProduct.put("collection", entry.getKey());
            groupedProduct.put("products", entry.getValue());
            return groupedProduct;
        })
        .collect(Collectors.toList());
       
        return groupedProducts;

    }
}
