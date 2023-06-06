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

    public String save(Player player) {
        try {
            playerRepository.save(player);
            String playerSaved = "Player " + player.getName() + " was saved successfully";

            return playerSaved;
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
