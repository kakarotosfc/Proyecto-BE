package com.practica.application.services;

import java.time.LocalDate;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.NestedRuntimeException;
import org.springframework.stereotype.Service;

import com.practica.application.exceptions.DataSourceException;
import com.practica.application.persistence.models.Auth;
import com.practica.application.repositories.AuthRepository;

@Service
public class AuthService {
    @Autowired
    private AuthRepository authRepository;
    private static final String EXCEPTION_RESPONSE = "Client has been created already";

    public void createToken(String client) {
        try {
            
            Optional<Auth> clientToValidate = authRepository.findById(client);
            
            if(!clientToValidate.isEmpty()) throw new DataSourceException(EXCEPTION_RESPONSE);
            
            Auth clientToCreateToken = new Auth();
            
            clientToCreateToken.setClient(client);
            clientToCreateToken.setToken(UUID.randomUUID().toString().toLowerCase());
            clientToCreateToken.setGenerationDate(LocalDate.now());
            
            authRepository.save(clientToCreateToken);

        } catch(NestedRuntimeException ex) {
            throw new DataSourceException(ex.getRootCause().getLocalizedMessage());
        }
    }

    public String getToken(String client) {
        try {
            
            Auth clientFound = new Auth();
            Optional<Auth> clientToValidate = authRepository.findById(client);
            
            if(clientToValidate.isEmpty()) throw new DataSourceException(EXCEPTION_RESPONSE);
            clientFound = clientToValidate.orElse(null);
            return clientFound.getToken();
            
        } catch(NestedRuntimeException ex) {
            throw new DataSourceException(ex.getRootCause().getLocalizedMessage());
        } 
    }
}
