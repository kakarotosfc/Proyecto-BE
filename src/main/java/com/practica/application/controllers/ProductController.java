package com.practica.application.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.practica.application.persistence.models.Product;
import com.practica.application.persistence.models.ProductImage;
import com.practica.application.persistence.models.UnitsPerSize;
import com.practica.application.services.ProductService;

@RestController
@RequestMapping("/product")
public class ProductController {

	@Autowired
	private ProductService service;

	@PostMapping("/save")
	public ResponseEntity<String> save(@RequestBody Product product) {
		service.save(product);
		return ResponseEntity.ok("");
	}
	@PostMapping("/save_images")
	public ResponseEntity<String> save(@RequestBody ProductImage productImage) {
		service.saveImages(productImage);
		return ResponseEntity.ok("");
	}
	@PostMapping("/save_sizes_and_units")
	public ResponseEntity<String> save(@RequestBody UnitsPerSize unitsPerSize) {
		service.saveSizesAndUnits(unitsPerSize);
		return ResponseEntity.ok("");
	}

	@GetMapping("/list")
	public ResponseEntity<List<Product>> list() {
		return ResponseEntity.ok(service.list());
	}
}
