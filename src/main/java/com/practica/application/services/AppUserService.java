package com.practica.application.services;

import java.util.HashSet;
import java.util.Set;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.practica.application.dto.CreateAppUserDto;
import com.practica.application.dto.MessageDto;
import com.practica.application.enums.RoleName;
import com.practica.application.persistence.models.AppUser;
import com.practica.application.persistence.models.Roles;
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
                .username(dto.username())
                .password(passwordEncoder.encode(dto.password()))
                .build();
        Set<Roles> roles = new HashSet<>();
        dto.roles().forEach(r -> {
            Roles role = repository.findByRole(RoleName.valueOf(r))
                    .orElseThrow(()-> new RuntimeException("role not found"));
            roles.add(role);
        });
        appUser.setRoles(roles);
        appUserRepository.save(appUser);
        return new MessageDto("user " + appUser.getUsername() + " saved");
    }
}