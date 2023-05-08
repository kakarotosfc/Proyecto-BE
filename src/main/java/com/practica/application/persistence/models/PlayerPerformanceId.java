package com.practica.application.persistence.models;

import jakarta.persistence.Embeddable;
import lombok.Data;

@Embeddable
@Data
public class PlayerPerformanceId {    
    private Long playerId;
    private String season;    

    public PlayerPerformanceId() {
    }

    public PlayerPerformanceId(Long playerId, String season) {
        this.playerId = playerId;
        this.season = season;
    }
}