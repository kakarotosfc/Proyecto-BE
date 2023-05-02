package com.practica.application.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.practica.application.persistence.models.PlayerPerformance;
import com.practica.application.persistence.models.PlayerPerformanceId;

@Repository
public interface PlayerPerformanceRepository extends JpaRepository<PlayerPerformance, PlayerPerformanceId> {
}
