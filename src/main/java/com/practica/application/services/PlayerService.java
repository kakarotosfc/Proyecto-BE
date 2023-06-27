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
    private static final String SUCCESS_RESPONSE = "Player was saved successfully";
        
    public String save(Player player) {
        try {
            playerRepository.save(player);
            return SUCCESS_RESPONSE;
        }

        catch(NestedRuntimeException ex) {
            throw new DataSourceException(ex.getRootCause().getLocalizedMessage());
        }        
    }
      
    public List<Player> list() {
        List<Player> allPlayers = playerRepository.findAll();
        
        if(!allPlayers.isEmpty())
            return allPlayers;
        else 
            throw new DataSourceException("There are no Players created to be shown.");
    }
}
