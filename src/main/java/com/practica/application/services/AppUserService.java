package com.practica.application.services;

import java.util.Collections;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.practica.application.dto.CreateAppUserDto;
import com.practica.application.dto.MessageDto;
import com.practica.application.enums.RoleName;
import com.practica.application.persistence.models.AppUser;
import com.practica.application.persistence.models.Role;
import com.practica.application.repositories.AppUserRepository;
import com.practica.application.repositories.RoleRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AppUserService {

    private final AppUserRepository appUserRepository;
    private final RoleRepository repository;
    private final PasswordEncoder passwordEncoder;

    public MessageDto createUser(CreateAppUserDto dto){
        AppUser appUser = AppUser.builder()
                .username(dto.userName())
                .password(passwordEncoder.encode(dto.password()))
                .build();
    
        String roleName = dto.role(); // Obtener el rol como un solo String
    
        Role role = repository.findByRole(RoleName.valueOf(roleName))
                .orElseThrow(() -> new RuntimeException("Role not found"));
    
        appUser.setRole(Collections.singleton(role)); // Usar Collections.singleton para crear un conjunto con un solo elemento
        appUserRepository.save(appUser);
    
        return new MessageDto("user " + appUser.getUsername() + " saved");
    }
}