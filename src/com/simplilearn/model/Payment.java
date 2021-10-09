package com.simplilearn.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="tbl_payments")
public class Payment {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int payment_Id;
	private String cc_name;
	private String cc_num;
	private String cc_month;
	private String cc_year;
	private String ccv;
		
	@OneToMany(mappedBy="payment",cascade=CascadeType.ALL)
	private List<FlightRegistry> payments;
	
	public Payment() {
		super();
	}
	
	public Payment(String cc_name, String cc_num, String cc_month, String cc_year, String ccv) {
		super();
		this.cc_name = cc_name;
		this.cc_num = cc_num;
		this.cc_month = cc_month;
		this.cc_year = cc_year;
		this.ccv = ccv;
		payments = new ArrayList<FlightRegistry>();
	}
	
	public void setFlightRegistry(FlightRegistry payment) {
		payments.add(payment);
	}
	
	public String getCc_name() {
		return cc_name;
	}
	public void setCc_name(String cc_name) {
		this.cc_name = cc_name;
	}
	public String getCc_num() {
		return cc_num;
	}
	public void setCc_num(String cc_num) {
		this.cc_num = cc_num;
	}
	public String getCc_month() {
		return cc_month;
	}
	public void setCc_month(String cc_month) {
		this.cc_month = cc_month;
	}
	public String getCc_year() {
		return cc_year;
	}
	public void setCc_year(String cc_year) {
		this.cc_year = cc_year;
	}
	public String getCcv() {
		return ccv;
	}
	public void setCcv(String ccv) {
		this.ccv = ccv;
	}
	public int getPayment_Id() {
		return payment_Id;
	}
	
	
	
}
