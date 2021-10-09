package com.simplilearn.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.concurrent.ThreadLocalRandom;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.ObjectNotFoundException;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.simplilearn.model.Airline;
import com.simplilearn.model.Airport;
import com.simplilearn.model.Flight;
import com.simplilearn.util.HibernateUtil;
 
@WebServlet("/DataGen")
public class DataGen extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DataGen() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
Session session = HibernateUtil.getSessionFactory().openSession();
		
		try {
		PrintWriter out = response.getWriter();
		
		int i = 1000;
		for (int j = 0; j < i; j++) {
			int randomAirportArrive;
			int randomAirportDepart;
			int randomAirline;
			Date dateTime;
			String terminal;
			Integer gate;
			double price;
			long now = new Date().getTime();
			int capacity;
			
			
			if(j>20) {
				randomAirportArrive = ThreadLocalRandom.current().nextInt(1,9225 + 2);
				randomAirportDepart = ThreadLocalRandom.current().nextInt(1,9225 + 2);
				randomAirline = ThreadLocalRandom.current().nextInt(1,1571 + 2);
				while(randomAirportDepart==randomAirportArrive) {
					randomAirportDepart+=10;
					if(randomAirportDepart>9225) {
						randomAirportDepart-=20;
					}
				}
				
				String letters = "ABCDEFGHIJKLMNOPQRSTUVWZYZ";
				int number =  ThreadLocalRandom.current().nextInt(0,25 + 1);
				terminal = letters.substring(number,number+1);
				gate = ThreadLocalRandom.current().nextInt(1,30 + 1);
				price = ThreadLocalRandom.current().nextDouble(200.0, 1500.0);
				long aDay = TimeUnit.DAYS.toMillis(1);
				Date today =  new Date(now);
				Date thirtyDaysAhead = new Date(now + aDay * 30);
				dateTime = between(today, thirtyDaysAhead);
				capacity = ThreadLocalRandom.current().nextInt(0,300 + 1);
			} else {
				randomAirportArrive = 2;
				randomAirportDepart = 10;
				randomAirline = j+2;
				dateTime = new Date(now);
				terminal = "A";
				gate = j+1;
				price = 129.99;
				capacity = j;
			}
			
			Airline airline = session.load(Airline.class,randomAirline);
			Airport airportDepart = session.load(Airport.class,randomAirportDepart);
			Airport airportArrive = session.load(Airport.class,randomAirportArrive);
			String airlineName = airline.getCompanyName();
			String departCity = airportDepart.getCity_name(); 
			String departAirport = airportDepart.getAirport_name();
			String arriveCity = airportArrive.getCity_name(); 
			String arriveAirport = airportArrive.getAirport_name();
			if(departCity.equals("NA")) {
				departCity = "IAD";
			}
			if(arriveCity.equals("NA")) {
				arriveCity = "DFW";
			}
						
			Flight flight = new Flight(airlineName,departCity,departAirport,arriveCity,arriveAirport,terminal,gate,price,dateTime,capacity);
			flight.setAirportDepart(airportDepart);
			flight.setAirportArrive(airportArrive);
			Transaction tr = session.beginTransaction();
			
			session.save(flight);
			tr.commit();
			
		}
		} catch (ObjectNotFoundException e) {
			System.out.println(e.getMessage());
			System.out.println("No row found");
		}
		
		session.close();
		  session.close(); response.sendRedirect("/FlyAway/index.html");
		 
	}

	public static Date between(Date startInclusive, Date endExclusive) {
	    long startMillis = startInclusive.getTime();
	    long endMillis = endExclusive.getTime();
	    long randomMillisSinceEpoch = ThreadLocalRandom
	      .current()
	      .nextLong(startMillis, endMillis);

	    return new Date(randomMillisSinceEpoch);
	}

}
