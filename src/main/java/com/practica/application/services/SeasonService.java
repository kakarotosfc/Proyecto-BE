package com.practica.application.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.NestedRuntimeException;
import org.springframework.stereotype.Service;

import com.practica.application.exceptions.DataSourceException;
import com.practica.application.persistence.models.Season;
import com.practica.application.repositories.SeasonRepository;

@Service
public class SeasonService {
    @Autowired
    private SeasonRepository seasonRepository;
    private static final String SUCCESS_RESPONSE = "Season was saved successfully";
    private static final String EXCEPTION_RESPONSE = "There are no Seasons created to be shown.";

    public String save(Season season) {
        try {
            seasonRepository.save(season);
            return SUCCESS_RESPONSE;
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
            throw new DataSourceException(EXCEPTION_RESPONSE);
    }
}
