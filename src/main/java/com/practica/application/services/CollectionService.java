package com.practica.application.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.NestedRuntimeException;
import org.springframework.stereotype.Service;

import com.practica.application.exceptions.DataSourceException;
import com.practica.application.exceptions.DataSourceNotFoundException;
import com.practica.application.persistence.models.Collection;
import com.practica.application.repositories.CollectionRepository;

@Service
public class CollectionService {
    @Autowired
    private CollectionRepository collectionRepository;
    private static final String EXCEPTION_RESPONSE = "There are no Collections created to be shown.";

    public void save(Collection collection) {
        try {
            collectionRepository.save(collection);
        } catch(NestedRuntimeException ex) {
            throw new DataSourceException(ex.getRootCause().getLocalizedMessage());
        } 
    }

    public List<Collection> list() {
        List<Collection> allCollections = collectionRepository.findAll();
       
        if(allCollections.isEmpty()) throw new DataSourceNotFoundException(EXCEPTION_RESPONSE);
        
        return allCollections;            
    }
}
