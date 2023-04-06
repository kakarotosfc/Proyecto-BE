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

    public void save(Player player) {
        playerRepository.save(player);
    }

    public List<Player> list() {
        return playerRepository.findAll();
    }
}
