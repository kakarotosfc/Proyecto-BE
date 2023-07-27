package com.practica.application.exceptions;

public class DataSourceNotFoundException extends RuntimeException {

    public DataSourceNotFoundException(String msg) {
        super(msg);
    }
}

