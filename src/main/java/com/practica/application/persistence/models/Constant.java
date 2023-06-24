package com.practica.application.persistence.models;

public class Constant {
    public static final int playerSaved = 200;
    public static final int seasonSaved = 201;
    public static final int playerPerformanceSaved = 202;
    public static final int teamPerformanceSaved = 203;
    
    
    public String responseHandler(int codigoRespuesta) {
        switch(codigoRespuesta) {
            case playerSaved:
                return  "Player was saved successfully.";
            case seasonSaved:
                return  "Season was saved successfully.";
            case playerPerformanceSaved:
                return  "Performance for this Player was saved successfully.";
            case teamPerformanceSaved:
                return  "Performance for this season was saved successfully.";
                
        }
        return null;
    }
}