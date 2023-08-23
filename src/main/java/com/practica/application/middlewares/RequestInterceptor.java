package com.practica.application.middlewares;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.practica.application.exceptions.AccessForbiddenException;
import com.practica.application.services.AuthService;

@Component
public class RequestInterceptor implements HandlerInterceptor {

    @Autowired
    private AuthService authService;
    private static final String FORBIDDEN = "Client or token invalid.";

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        
        System.out.println("Intercepted request: " + request.getRequestURI());       
        
        String clientFromRequest =  request.getHeader("Client");
        String tokenFromRequest = request.getHeader("Token");
        String tokenFromDatabase = authService.getToken(clientFromRequest);
        
        if(tokenFromRequest.equals(tokenFromDatabase))
            return true;
        throw new AccessForbiddenException(FORBIDDEN);
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {}

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {}

}   
