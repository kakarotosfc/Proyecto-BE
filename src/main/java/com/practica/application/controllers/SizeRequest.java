package com.practica.application.controllers;

import lombok.Data;

@Data
public class SizeRequest {
    
    private Long productId;
    private String size;
    private int unitsAvailable;

}
