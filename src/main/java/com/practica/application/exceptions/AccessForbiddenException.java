package com.practica.application.exceptions;

public class AccessForbiddenException extends RuntimeException {

    public AccessForbiddenException(String msg) {
        super(msg);
    }
}

