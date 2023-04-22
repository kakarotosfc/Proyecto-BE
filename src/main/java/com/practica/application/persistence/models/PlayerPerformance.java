package com.practica.application.persistence.models;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "playerperformance")
@Data
public class PlayerPerformance {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String season;
    private int matches;
    private int goals;
    private int assists;
    private int yellowCards;
    private int blueCards;
    private int redCards;
    private int mvpMatches;
}