package com.practica.application.persistence.models;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "player_performance")
@Data
public class PlayerPerformance {
    
    @EmbeddedId
    private PlayerPerformanceId playerPerformanceId;
    private int matches;
    private int goals;
    private int assists;
    private int yellowCards;
    private int blueCards;
    private int redCards;
    private int mvpMatches;
}