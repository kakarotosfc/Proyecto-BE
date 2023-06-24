package com.practica.application.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.NestedRuntimeException;
import org.springframework.stereotype.Service;

import com.practica.application.exceptions.DataSourceException;
import com.practica.application.persistence.models.Constant;
import com.practica.application.persistence.models.Season;
import com.practica.application.repositories.SeasonRepository;

@Service
public class SeasonService {
    @Autowired
    private SeasonRepository seasonRepository;

    public String save(Season season) {
        try {
            seasonRepository.save(season);
            Constant successfullResponse = new Constant();
            
            return successfullResponse.responseHandler(201);
        }

        catch(NestedRuntimeException ex) {
            throw new DataSourceException(ex.getRootCause().getLocalizedMessage());
        } 
    }

    public List<Season> list() {
        List<Season> allSeasons = seasonRepository.findAll();
       
        if(!allSeasons.isEmpty())
            return allSeasons;
        else 
            throw new DataSourceException("There are no Seasons created to be shown.");
    }
}
