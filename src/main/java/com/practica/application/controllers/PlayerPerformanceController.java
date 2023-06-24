package com.practica.application.controllers;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.practica.application.persistence.models.PlayerPerformance;
import com.practica.application.services.PlayerPerformanceService;

@RestController
@RequestMapping("/player-performance")
public class PlayerPerformanceController {

	@Autowired
	private PlayerPerformanceService service;

	@PostMapping("/save")
	public ResponseEntity<String> save(@RequestBody PlayerPerformance player) {
		return ResponseEntity.ok(service.save(player));
	}

	@GetMapping("/find")
	public ResponseEntity<Optional<PlayerPerformance>> find(@RequestParam(name= "playerId") Long playerId, @RequestParam(name="season") String season) {
		return ResponseEntity.ok(service.find(playerId, season));	
	}
}
