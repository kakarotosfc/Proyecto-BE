package com.practica.application.persistence.models;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "team_performance")
@Data
public class TeamPerformance {
    
    @Id
    private String season;
    private int playedMatches;
    private int wonMatches;
    private int drawnMatches;
    private int lostMatches;
    private int goalsFor;
    private int goalsAgainst;
    private int points;
    private String positionPerRivals;
}