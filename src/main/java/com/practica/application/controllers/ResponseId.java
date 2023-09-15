package com.practica.application.controllers;

import lombok.Data;

@Data
public class ResponseId {
	
	private Object responseId;

	 public ResponseId(Object responseId) {
        this.responseId = responseId;
    }
}
