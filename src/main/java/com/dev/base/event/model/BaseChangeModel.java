package com.dev.base.event.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class BaseChangeModel {
	private String action;
	private String tableName;
	private Object obj;

	public BaseChangeModel(String action, String tableName, Object obj) {
		super();;
		this.action = action;
		this.tableName = tableName;
		this.obj = obj;
	}
}
