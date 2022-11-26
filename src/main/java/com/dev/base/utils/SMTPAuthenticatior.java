package com.dev.base.utils;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SMTPAuthenticatior extends Authenticator{
	PasswordAuthentication pa;

	public SMTPAuthenticatior(String userId, String userPwd) {
		super();
		this.pa = new PasswordAuthentication(userId,userPwd);
	}
	
	@Override
	public PasswordAuthentication getPasswordAuthentication() {
		return pa;
	}
}
