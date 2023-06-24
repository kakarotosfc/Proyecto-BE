package com.practica.application.services;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.practica.application.persistence.models.Constant;
import com.practica.application.persistence.models.PlayerPerformance;
import com.practica.application.persistence.models.PlayerPerformanceId;
import com.practica.application.repositories.PlayerPerformanceRepository;

@Service
public class PlayerPerformanceService {
    @Autowired
    private PlayerPerformanceRepository playerPerformanceRepository;

    public String save(PlayerPerformance playerPerformance) {
        playerPerformanceRepository.save(playerPerformance);
        Constant successfullResponse = new Constant();
            
        return successfullResponse.responseHandler(200,2);
    }

    public Optional<PlayerPerformance> find(Long playerId, String season) {
        PlayerPerformanceId playerPerformanceId = new PlayerPerformanceId(playerId, season);

        return playerPerformanceRepository.findById(playerPerformanceId);
    }
}
