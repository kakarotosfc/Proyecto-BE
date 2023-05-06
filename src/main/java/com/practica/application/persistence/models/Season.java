package com.practica.application.persistence.models;

import java.time.LocalDate;

import jakarta.persistence.Embeddable;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Embeddable
@Entity
@Table(name = "season")
@Data
public class Season {
    
    @Id
    private String season;
    private LocalDate startDate;
    private LocalDate endDate;
    
}
