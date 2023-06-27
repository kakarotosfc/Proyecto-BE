package com.practica.application.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestParam;

import com.practica.application.persistence.models.TeamPerformance;
import com.practica.application.services.TeamPerformanceService;

@RestController
@RequestMapping("/team-performance")
public class TeamPerformanceController {

	@Autowired
	private TeamPerformanceService service;

	@PostMapping("/save")
	public ResponseEntity<String> save(@RequestBody TeamPerformance TeamPerformance) {
		service.save(TeamPerformance);
		return ResponseEntity.ok("");
	}

	@GetMapping("/list")
	public ResponseEntity<List<TeamPerformance>> list() {
		return ResponseEntity.ok(service.list());
	}
	

	@GetMapping("/find")
	public TeamPerformance find(@RequestParam(name = "season") String season) {
		return (service.find(season));
	}

}
