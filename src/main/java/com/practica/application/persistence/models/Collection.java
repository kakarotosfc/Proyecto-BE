package com.practica.application.persistence.models;

import java.time.LocalDate;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;


@Entity
@Table(name = "collection")
@Data
public class Collection {
    
    @Id
    private String collection;
    private LocalDate startDate;
    private LocalDate endDate;
    private boolean enabled;
    
}
