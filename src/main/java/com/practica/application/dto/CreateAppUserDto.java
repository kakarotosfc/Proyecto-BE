package com.practica.application.dto;

import java.util.List;

public record CreateAppUserDto (
    String userName,
    String password,
    String role,
    List<String> roles){}

