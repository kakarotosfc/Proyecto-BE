package com.practica.application.controllers;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.practica.application.persistence.models.Product;
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
	public ResponseEntity<String> save(@RequestBody ImageRequest imageRequest) {//
		service.saveImages(imageRequest.getProductId(), imageRequest.getImageDescription(), imageRequest.getImageUrl());
		return ResponseEntity.ok("");
	}
	@PostMapping("/save_sizes_and_units")
	public ResponseEntity<String> save(@RequestBody SizeRequest sizeRequest) {
		service.saveSizesAndUnits(sizeRequest.getProductId(), sizeRequest.getSize(), sizeRequest.getUnitsAvailable());
		return ResponseEntity.ok("");
	}

	@GetMapping("/list")
	public ResponseEntity<List<Product>> list() {
		return ResponseEntity.ok(service.list());
	}

	@GetMapping("/find")
	public Product find(@RequestParam(name = "product_id") Long id) {
		return (service.find(id));
	}

		@GetMapping("/find_products_by_active_collection")
	public List<Map<String, Object>> findActiveProducts() {
		return (service.findByActiveCollection());
	}
}

    
