package com.simplilearn.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="tbl_airports")
public class Airport {
	@Id
	@Column(name="airport_id")
	private int airport_id;
	private String airport_name;
	private String iso_country;
	private String iso_region;
	private String iata_code;
	private String city_name;
	
	@OneToMany(mappedBy="airportArrive",cascade=CascadeType.ALL)
	private List<Flight> flightsArrive;
	
	@OneToMany(mappedBy="airportDepart",cascade=CascadeType.ALL)
	private List<Flight> flightsDepart;
	
	public Airport() {
		super();
	}

	public Airport(String airport_name, String iso_country, String iso_region, String iata_code, String city_name) {
		super();
		this.airport_name = airport_name;
		this.iso_country = iso_country;
		this.iso_region = iso_region;
		this.iata_code = iata_code;
		this.city_name = city_name;
		flightsArrive = new ArrayList<>();
		flightsDepart = new ArrayList<>();
	}
	
	public void addFlightArrive(Flight flight) {
		flightsArrive.add(flight);
	}
	
	public void addFlightDepart(Flight flight) {
		flightsDepart.add(flight);
	}
	
	public String getAirport_name() {
		return airport_name;
	}
	
	public void setAirport_name(String airport_name) {
		this.airport_name = airport_name;
	}
	public String getIso_country() {
		return iso_country;
	}
	public void setIso_country(String iso_country) {
		this.iso_country = iso_country;
	}
	public String getIso_region() {
		return iso_region;
	}
	public void setIso_region(String iso_region) {
		this.iso_region = iso_region;
	}
	public String getIata_code() {
		return iata_code;
	}
	public void setIata_code(String iata_code) {
		this.iata_code = iata_code;
	}
	public String getCity_name() {
		return city_name;
	}
	public void setCity_name(String city_name) {
		this.city_name = city_name;
	}
	public int getAirport_id() {
		return airport_id;
	}
	
	
	
	
}
