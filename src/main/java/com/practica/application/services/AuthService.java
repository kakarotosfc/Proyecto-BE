package com.practica.application.services;

import java.time.LocalDate;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.NestedRuntimeException;
import org.springframework.stereotype.Service;

import com.practica.application.exceptions.AccessForbiddenException;
import com.practica.application.exceptions.DataSourceException;
import com.practica.application.persistence.models.Auth;
import com.practica.application.repositories.AuthRepository;

@Service
public class AuthService {
    @Autowired
    private AuthRepository authRepository;
    private static final String EXCEPTION_RESPONSE = "Token does not exist.";

    public void createToken(String client) {
        try {
                        
            Auth clientToCreateToken = new Auth();
            
            clientToCreateToken.setClient(client);
            clientToCreateToken.setToken(UUID.randomUUID().toString().toLowerCase());
            clientToCreateToken.setGenerationDate(LocalDate.now());
            
            authRepository.save(clientToCreateToken);

        } catch(NestedRuntimeException ex) {
            throw new DataSourceException(ex.getRootCause().getLocalizedMessage());
        }
    }

    public String getToken(String token) {
        try {
            
            Auth clientToValidate = authRepository.findByToken(token);

            if(clientToValidate == null) throw new AccessForbiddenException(EXCEPTION_RESPONSE);
            
            return clientToValidate.getToken();
            
        } catch(NestedRuntimeException ex) {
            throw new DataSourceException(ex.getRootCause().getLocalizedMessage());
        } 
    }
}
