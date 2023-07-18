package com.practica.application.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.practica.application.persistence.models.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    @Query("SELECT a FROM Product a JOIN Collection d ON a.collection = d.collection WHERE d.enabled = true")
    List<Product> findByCollectionJoin();
}
