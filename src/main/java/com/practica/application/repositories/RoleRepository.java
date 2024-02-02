package com.practica.application.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.practica.application.enums.RoleName;
import com.practica.application.persistence.models.Roles;

import java.util.Optional;

@Repository
public interface RoleRepository extends JpaRepository<Roles, Integer> {

    Optional<Roles> findByRole(RoleName roleName);
}