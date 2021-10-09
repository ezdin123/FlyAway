package com.simplilearn.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.HibernateException;


@Entity
@Table(name = "tbl_flights")
public class Flight {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int flight_Id;

	private String airlineName;
	private String departCity;
	private String departAirport;
	private String arriveCity;
	private String arriveAirport;
	private String terminal;
	private Integer gate;
	private double price;
	private int capacity;
	private Date dateTime;

	@ManyToOne(fetch = FetchType.LAZY)
	private Airport airportArrive;

	@ManyToOne(fetch = FetchType.LAZY)
	private Airport airportDepart;

	@OneToMany(mappedBy = "flight", cascade = CascadeType.ALL)
	private List<FlightRegistry> flights;

	public Flight() {
		super();
	}

	public Flight(String airlineName, String departCity, String departAirport, String arriveCity, String arriveAirport,
			String terminal, Integer gate, double price, Date dateTime, int capacity) {
		super();
		this.airlineName = airlineName;
		this.departCity = departCity;
		this.departAirport = departAirport;
		this.arriveCity = arriveCity;
		this.arriveAirport = arriveAirport;
		this.terminal = terminal;
		this.gate = gate;
		this.price = price;
		this.dateTime = dateTime;
		this.capacity = capacity;
		flights = new ArrayList<FlightRegistry>();
	}

	public Airport getAirportArrive() {
		return airportArrive;
	}

	public Airport getAirportDepart() {
		return airportDepart;
	}

	public List<FlightRegistry> getFlights() {
		return flights;
	}

	public void setFlightRegistry(FlightRegistry flight) {
		flights.add(flight);
	}

	public void setAirportDepart(Airport airport) {
		this.airportDepart = airport;
	}

	public void setAirportArrive(Airport airport) {
		this.airportArrive = airport;
	}

	public String getAirlineName() {
		return airlineName;
	}

	public int getCapacity() {
		return capacity;
	}

	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}

	public String getDepartAirport() {
		return departAirport;
	}

	public void setDepartAirport(String departAirport) {
		this.departAirport = departAirport;
	}

	public String getArriveAirport() {
		return arriveAirport;
	}

	public void setArriveAirport(String arriveAirport) {
		this.arriveAirport = arriveAirport;
	}

	public void setAirlineName(String airlineName) {
		this.airlineName = airlineName;
	}

	public String getDepartCity() {
		return departCity;
	}

	public void setDepartCity(String departCity) {
		this.departCity = departCity;
	}

	public String getArriveCity() {
		return arriveCity;
	}

	public void setArriveCity(String arriveCity) {
		this.arriveCity = arriveCity;
	}

	public String getTerminal() {
		return terminal;
	}

	public void setTerminal(String terminal) {
		this.terminal = terminal;
	}

	public Integer getGate() {
		return gate;
	}

	public void setGate(Integer gate) {
		this.gate = gate;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public Date getDateTime() {
		return dateTime;
	}

	public void setDateTime(Date dateTime) {
		this.dateTime = dateTime;
	}

	public int getFlightId() {
		return flight_Id;
	}

}
