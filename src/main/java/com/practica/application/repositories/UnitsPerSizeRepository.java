package com.practica.application.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.practica.application.persistence.models.UnitsPerSize;

@Repository
public interface UnitsPerSizeRepository extends JpaRepository<UnitsPerSize, Long> {
    
}
