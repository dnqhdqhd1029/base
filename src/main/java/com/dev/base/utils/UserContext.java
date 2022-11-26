package com.dev.base.utils;

import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Component;

@Component
public class UserContext {
	public static final String CORRELATION_ID = "tmx-correlation-id";
	public static final String AUTH_TOKEN  = "Authorization";
	public static final String USER_ID = "preferred_username";
	public static final String USER_NAME = "name";

    private static final ThreadLocal<String> correlationId= new ThreadLocal<String>();
    private static final ThreadLocal<String> authToken= new ThreadLocal<String>();
    private static final ThreadLocal<String> userId = new ThreadLocal<String>();
    private static final ThreadLocal<String> userName = new ThreadLocal<String>();

    public static String getCorrelationId() { return correlationId.get(); }
    public static void setCorrelationId(String cid) {correlationId.set(cid);}

    public static String getAuthToken() { return authToken.get(); }
    public static void setAuthToken(String aToken) {authToken.set(aToken);}

    public static String getUserId() { return userId.get(); }
    public static void setUserId(String aUser) {userId.set(aUser);}

    public static String getUserName() { return userName.get(); }
    public static void setUserName(String aName) {userName.set(aName);}

    public static HttpHeaders getHttpHeaders(){
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.set(CORRELATION_ID, getCorrelationId());

        return httpHeaders;
    }

}
