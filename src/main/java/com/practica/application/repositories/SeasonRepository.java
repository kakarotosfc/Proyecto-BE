package com.practica.application.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.practica.application.persistence.models.Season;

@Repository
public interface SeasonRepository extends JpaRepository<Season, Long> {
    List<Season> findBySeason(String season);
}
