package com.practica.application.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.practica.application.persistence.models.Player;
import com.practica.application.repositories.PlayerRepository;

@Service
public class PlayerService {
    @Autowired
    private PlayerRepository playerRepository;

    public String save(Player player) {
        
        var playerName = playerRepository.findByName(player.getName());

        if(playerName.size() == 0){
            playerRepository.save(player);
            return "Player " + player.getName() + " was saved successfully.";
        }
        else
            return "Player " + player.getName() + " already exists. Cannot be saved again.";
    }

    public List<Player> list() {
        return playerRepository.findAll();
    }
}
