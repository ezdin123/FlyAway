package com.simplilearn.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="tbl_flight_registry")
public class FlightRegistry {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int flight_registry_Id;
	
	@ManyToOne(fetch=FetchType.LAZY)
	private Flight flight;
	
	
	@ManyToOne(fetch=FetchType.LAZY)
	private Customer customer;
	
	@ManyToOne(fetch=FetchType.LAZY)
	private Payment payment;
	
	
	
	public FlightRegistry() {
		super();
	}

	public FlightRegistry(Flight flight, Customer customer, Payment payment) {
		super();
		this.flight = flight;
		this.customer = customer;
		this.payment = payment;
	}

	public Flight getFlight() {
		return flight;
	}

	public void setFlight(Flight flight) {
		this.flight = flight;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public Payment getPayment() {
		return payment;
	}

	public void setPayment(Payment payment) {
		this.payment = payment;
	}

	public int getFlight_registry_Id() {
		return flight_registry_Id;
	}
	
	
	
}
