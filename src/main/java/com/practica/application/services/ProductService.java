package com.practica.application.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.NestedRuntimeException;
import org.springframework.stereotype.Service;

import com.practica.application.exceptions.DataSourceException;
import com.practica.application.persistence.models.Product;
import com.practica.application.repositories.ProductRepository;

@Service
public class ProductService {
    @Autowired
    private ProductRepository productRepository;
    private static final String EXCEPTION_RESPONSE = "There are no Products created to be shown.";

    public void save(Product product) {
        try {
            productRepository.save(product);
        } catch(NestedRuntimeException ex) {
            throw new DataSourceException(ex.getRootCause().getLocalizedMessage());
        }        
    }
      
    public List<Product> list() {
        
        List<Product> allPlayers = productRepository.findAll();        
        
        if(allPlayers.isEmpty()) throw new DataSourceException(EXCEPTION_RESPONSE);
        
        return allPlayers;            
    }
}
