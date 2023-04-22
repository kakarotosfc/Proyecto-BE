package com.practica.application.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.practica.application.persistence.models.PlayerPerformance;
import com.practica.application.repositories.PlayerPerformanceRepository;

@Service
public class PlayerPerformanceService {
    @Autowired
    private PlayerPerformanceRepository playerPerformanceRepository;

    public void save(PlayerPerformance playerPerformance) {
        playerPerformanceRepository.save(playerPerformance);
    }

    public List<PlayerPerformance> list() {
        return playerPerformanceRepository.findAll();
    }
}
