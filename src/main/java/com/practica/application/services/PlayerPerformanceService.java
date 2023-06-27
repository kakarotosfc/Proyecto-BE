package com.practica.application.services;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.NestedRuntimeException;
import org.springframework.stereotype.Service;

import com.practica.application.exceptions.DataSourceException;
import com.practica.application.persistence.models.PlayerPerformance;
import com.practica.application.persistence.models.PlayerPerformanceId;
import com.practica.application.repositories.PlayerPerformanceRepository;

@Service
public class PlayerPerformanceService {
    @Autowired
    private PlayerPerformanceRepository playerPerformanceRepository;
    private static final String EXCEPTION_RESPONSE = "There are no Performance for this Player or Season to be shown.";

    public void save(PlayerPerformance playerPerformance) {
        try {
            playerPerformanceRepository.save(playerPerformance);
        } catch(NestedRuntimeException ex){
            throw new DataSourceException(ex.getRootCause().getLocalizedMessage());
        }
    }

    public PlayerPerformance find(Long playerId, String season) {
        PlayerPerformanceId playerPerformanceId = new PlayerPerformanceId(playerId, season);
        Optional<PlayerPerformance> playerToFind  = playerPerformanceRepository.findById(playerPerformanceId);

        if(playerToFind.isEmpty()) throw new DataSourceException(EXCEPTION_RESPONSE);

        return playerToFind.get();     
    }
}
