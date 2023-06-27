package com.practica.application.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.NestedRuntimeException;
import org.springframework.stereotype.Service;

import com.practica.application.exceptions.DataSourceException;
import com.practica.application.persistence.models.Player;
import com.practica.application.repositories.PlayerRepository;

@Service
public class PlayerService {
    @Autowired
    private PlayerRepository playerRepository;
    private static final String EXCEPTION_RESPONSE = "There are no Players created to be shown.";

    public void save(Player player) {
        try {
            playerRepository.save(player);
        } catch(NestedRuntimeException ex) {
            throw new DataSourceException(ex.getRootCause().getLocalizedMessage());
        }        
    }
      
    public List<Player> list() {
        
        List<Player> allPlayers = playerRepository.findAll();
        
        if(allPlayers.isEmpty()) throw new DataSourceException(EXCEPTION_RESPONSE);
        
        return allPlayers;            
    }
}
