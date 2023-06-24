package com.practica.application.persistence.models;

public class Constant {
    public static final int rowSaved = 200;
    public static final String responseForSuccessfullSaving = " was saved successfully";
    public static final String[] entitiesToSave = {"Player", "Season", "Player Performance", "Team Performance"};
    
    public String responseHandler(int responseCode, int responseEntityNumber) {
        if(responseCode == rowSaved)
            return  entitiesToSave[responseEntityNumber] + responseForSuccessfullSaving;
        return null;
    }
}