package com.practica.application.controllers;

import lombok.Data;

@Data
public class ImageRequest {
    
    private Long productId;
    private String imageDescription;
    private String imageUrl;

}
