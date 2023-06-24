package com.practica.application.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.practica.application.persistence.models.Constant;
import com.practica.application.persistence.models.TeamPerformance;
import com.practica.application.repositories.TeamPerformanceRepository;

@Service
public class TeamPerformanceService {
    
    @Autowired
    private TeamPerformanceRepository teamPerformanceRepository;

    public String save(TeamPerformance teamPerformance) {
        teamPerformanceRepository.save(teamPerformance);
        Constant successfullResponse = new Constant();
            
        return successfullResponse.responseHandler(203);            
        }
        
 
    public List<TeamPerformance> list() {
        return teamPerformanceRepository.findAll();
    }

    public TeamPerformance find(String season) {
        Optional<TeamPerformance> seasonOptional = teamPerformanceRepository.findById(season);

        if(seasonOptional.isEmpty()){
            return null;
        }
        return seasonOptional.get();            
    }
}
