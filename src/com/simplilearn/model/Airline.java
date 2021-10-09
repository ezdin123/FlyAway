package com.simplilearn.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "tbl_airlines")
public class Airline {

	@Id
	@Column(name = "airline_id")
	private int airline_id;
	private String companyName;

	public Airline() {
		super();
	}

	public Airline(int airline_id, String companyName) {
		super();
		this.companyName = companyName;
	}

	public int getAirline_id() {
		return airline_id;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
}
