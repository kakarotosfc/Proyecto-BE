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

    public void save(Season season) {
        seasonRepository.save(season);
    }

    public List<Season> list() {
        return seasonRepository.findAll();
    }
}
