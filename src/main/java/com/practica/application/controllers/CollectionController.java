package com.practica.application.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.practica.application.persistence.models.Collection;
import com.practica.application.services.CollectionService;

@RestController
@RequestMapping("/collection")
public class CollectionController {

	@Autowired
	private CollectionService service;

	@PostMapping("/save")
	public ResponseEntity<ResponseId> save(@RequestBody Collection collection) {
		ResponseId responseId = new ResponseId(service.save(collection).getCollection());
		return ResponseEntity.ok(responseId);
		
	}

	@GetMapping("/list")
	public ResponseEntity<List<Collection>> list() {
		return ResponseEntity.ok(service.list());
	}
}
