package com.practica.application.persistence.models;

import jakarta.persistence.Embeddable;
import lombok.Data;

@Embeddable
@Data
public class PlayerPerformanceId {    
    private Long playerId;
    private String season;    
}