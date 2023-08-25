package com.practica.application.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.practica.application.persistence.models.Auth;

@Repository
public interface AuthRepository extends JpaRepository<Auth, String> {
    Auth findByToken(String token);
}
