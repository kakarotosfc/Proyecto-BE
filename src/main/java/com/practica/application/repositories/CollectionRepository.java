package com.practica.application.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.practica.application.persistence.models.Collection;

@Repository
public interface CollectionRepository extends JpaRepository<Collection, String> {
}
