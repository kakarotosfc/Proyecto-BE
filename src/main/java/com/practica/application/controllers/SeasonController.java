package com.practica.application.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.practica.application.persistence.models.Season;
import com.practica.application.services.SeasonService;

@RestController
@RequestMapping("/season")
public class SeasonController {

	@Autowired
	private SeasonService service;

	@PostMapping("/save")
	public String save(@RequestBody Season season) {
		return service.save(season);
		
	}

	@GetMapping("/list")
	public ResponseEntity<List<Season>> list() {
		return ResponseEntity.ok(service.list());
	}
}
