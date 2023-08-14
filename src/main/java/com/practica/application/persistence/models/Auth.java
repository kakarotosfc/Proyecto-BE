package com.practica.application.persistence.models;

import java.time.LocalDate;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;


@Entity
@Table(name = "auth")
@Data
public class Auth {
    
    @Id
    private String client;
    private String token;
    private LocalDate generationDate;
    
}
