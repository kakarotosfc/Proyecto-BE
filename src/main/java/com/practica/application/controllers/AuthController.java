package com.practica.application.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.practica.application.services.AuthService;

@CrossOrigin(origins="*")
@RestController
@RequestMapping("/auth")
public class AuthController {

	@Autowired
	private AuthService service;

	@PostMapping("/create_token")
	public ResponseEntity<String> createToken(@RequestParam String client) {
		service.createToken(client);
		return ResponseEntity.ok("");
	}

	@GetMapping("/get_token")
	public ResponseEntity<String> getToken(@RequestParam String token) {
		return ResponseEntity.ok(service.getToken(token));
	}
}
