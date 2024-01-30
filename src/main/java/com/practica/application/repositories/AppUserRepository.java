package com.practica.application.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.practica.application.persistence.models.AppUser;

@Repository
public interface AppUserRepository extends JpaRepository<AppUser, Integer> {

    Optional<AppUser> findByUsername(String username);
}