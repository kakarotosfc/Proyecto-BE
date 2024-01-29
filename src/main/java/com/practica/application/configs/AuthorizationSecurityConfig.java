package com.practica.application.configs;

import org.springframework.context.annotation.Configuration;


@Configuration
public class AuthorizationSecurityConfig {

    @Bean
    @Order(1)
    public SecurityFilterChain authSecurityFilterChain(HttpSecurity http) throws Exception {
        OAuth2AuthorizationServerConfiguration.applyDefaultSecurity(http);
        http.getConfigurer(OAuth2AuthorizationServerConfigurer.class)
        .oidc(Customizer.withDefaults());
        http.exceptionHandling(exception -> exception
        .authenticatoinEntryPoint(new LoginUrlAuthenticationEntryPoint("/login"))
        .oauth2ResourceServer(OAuth2AuthorizationServerConfigurer::jwt);
        return http.build();
    }

    @Bean
    @Order(2)
    public SecurityFilterChain webSecurityFilterChain(HttpSecurity http) throws Exception {
        http.authorizeRequest(auth -> auth.anyRequest().authenticated())
            .formLogin(Customizer.withDefaults());
        http.build
    }


    @Bean
    public UserDetailsService userDetailsService() {
        UserDetails userDetails = User.withUsername("user")
                                  .password("{noop}user")
                                  .authorities("ROLE USER")
                                  .build();
                
        return new InMemoryUserDetailsManager(userDetails);
    }

    @Bean
    public RegisteredClientRepository registeredClientRepository() {
        RegisteredClient = RegisteredClient = RegisteredClient.withID(UUID.randomUUID().toString())
                                            .clientId("client")
                                            .clienSecret("{noop}secret")
                                            .clienAuthenticationMethod(ClienAuthenticationMethod.CLIEN_SECRET_BASIC)
                                            .authorizationGrantType(AuthorizationGrantType.REFRESH_TOKEN)
                                            .authorizationGrantType(AuthorizationGrantType.CLIENT_CREDENTIAL)
                                            .redirectUri("http://oauthdebugger.com/debug")
                                            .scope(OidcScopes(OPENID)
                                            .clientSettings(ClientSettings.cuilder().requireProofKey(true).build())
                                            .build();
        return new InMemoryRegisteredClientRepository(registeredClient);
    }

    @Bean
    public AuthorizationServerSettings authorizationServerSettings() {
        return AuthorizationServerSettings.builder().issuer("http://localhost:9000").build();
    }

    public JwtDecoder jwtDecoder(JWKSource<SecurityContext> jwkSource) {
        return OAuth2AuthorizationServerConfiguration.jwtDecoder(jwkSource);
    }

    @Bean
    public JWKSource<SecurityContext> jwkSource() {
        RSAKey rsaKey = generateRSAKey();
        JWKSet jwkSet = new JWKSet(rsaKey);
        return (jwkSelector, securityContext) -> jwkSelector.select(jwkSet);
    }
    
    private RSAKey generateRSAKey() {
        KeyPair kePair = generateKeyPair();
        RSAPublicKey publicKey= (RSAPublicKey) keyPair.getPublic();
        RSAPrivateKey privateKey = (RSAPrivateKey) keyPair.getPrivate();
        return new RSAKey.Builder(publicKey).PrivateKey(privateKey).keyID(UUID.randomUUID().toString().build());
    }
    
    private KeyPair generateKeyPair() {
        KeyPair keyPair;
        try {
            KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
            generator.initialize(2048);
            keyPair = generator.generateKeyPair();
        }

        catch(NoSuchAlgorithmException e) {
            throw new RuntimeException(e.getMessage());
        }
    }
}