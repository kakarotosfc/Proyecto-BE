package com.practica.application.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.NestedRuntimeException;
import org.springframework.stereotype.Service;

import com.practica.application.exceptions.DataSourceException;
import com.practica.application.persistence.models.TeamPerformance;
import com.practica.application.repositories.TeamPerformanceRepository;

@Service
public class TeamPerformanceService {
    
    @Autowired
    private TeamPerformanceRepository teamPerformanceRepository;
    private static final String EXCEPTION_RESPONSE = "There are no Performance for this Season to be shown.";

    public void save(TeamPerformance teamPerformance) {
        try {
            teamPerformanceRepository.save(teamPerformance);    
        }
        catch(NestedRuntimeException ex){
            throw new DataSourceException(ex.getRootCause().getLocalizedMessage());
        }
    }
        
    public List<TeamPerformance> list() {
        var allPerformances = teamPerformanceRepository.findAll();

        if(allPerformances.isEmpty()) throw new DataSourceException(EXCEPTION_RESPONSE);
        
        return allPerformances;
    }

    public TeamPerformance find(String season) {
        Optional<TeamPerformance> seasonOptional = teamPerformanceRepository.findById(season);

        if(seasonOptional.isEmpty()) throw new DataSourceException(EXCEPTION_RESPONSE);
        
        return seasonOptional.get();
    }
}
