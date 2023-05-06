package com.practica.application.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.practica.application.persistence.models.TeamPerformance;
import com.practica.application.repositories.TeamPerformanceRepository;

@Service
public class TeamPerformanceService {
    
    @Autowired
    private TeamPerformanceRepository teamPerformanceRepository;

    public void save(TeamPerformance teamPerformance) {
        teamPerformanceRepository.save(teamPerformance);            
        }
        
 
    public List<TeamPerformance> list() {
        return teamPerformanceRepository.findAll();
    }

    public TeamPerformance find(String season) {
        Optional<TeamPerformance> seasonToFind = teamPerformanceRepository.findById(season);

        if(seasonToFind.isEmpty()){
            return null;
        }
        return seasonToFind.get();            
    }
}
