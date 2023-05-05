package com.practica.application.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.practica.application.persistence.models.Season;
import com.practica.application.repositories.SeasonRepository;

@Service
public class SeasonService {
    @Autowired
    private SeasonRepository seasonRepository;

    public String save(Season season) {
        var seasonId = seasonRepository.findBySeason(season.getSeason());
        
        if(seasonId.size() == 0){
            seasonRepository.save(season);
            return "Season" + season.getSeason() + " was saved successfully";
        }
        else
            return "Season" + season.getSeason() + " already exists. Cannot be saved again.";
    }

    public List<Season> list() {
        return seasonRepository.findAll();
    }
}
