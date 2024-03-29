package com.practica.application.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.practica.application.persistence.models.Player;
import com.practica.application.services.PlayerService;

@CrossOrigin(origins="*")
@RestController
@RequestMapping("/player")
public class PlayerController {

	@Autowired
	private PlayerService service;

	@PostMapping("/save")
	public ResponseEntity<ResponseId> save(@RequestBody Player player) {
		ResponseId responseId = new ResponseId(service.save(player).getId());
		return ResponseEntity.ok(responseId);
	}

	@GetMapping("/list_active_players")
	public ResponseEntity<List<Player>> listActivePlayers() {
		return ResponseEntity.ok(service.listActivePlayers());
	}
}


