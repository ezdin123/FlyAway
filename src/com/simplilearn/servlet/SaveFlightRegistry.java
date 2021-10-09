package com.simplilearn.servlet;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.simplilearn.model.Customer;
import com.simplilearn.model.Flight;
import com.simplilearn.model.FlightRegistry;
import com.simplilearn.model.Payment;
import com.simplilearn.util.HibernateUtil;

@WebServlet("/SaveFlightRegistry")
public class SaveFlightRegistry extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SaveFlightRegistry() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int flight_id = Integer.parseInt(request.getParameter("flight_id"));
		int customer_id = Integer.parseInt(request.getParameter("customer_id"));
		int payment_id = Integer.parseInt(request.getParameter("payment_id"));
		int capacity = Integer.parseInt(request.getParameter("capacity"));
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		Flight f = session.load(Flight.class,flight_id);
		Customer c = session.load(Customer.class,customer_id);
		Payment p = session.load(Payment.class,payment_id);

		int flightCapacity = f.getCapacity();
		f.setCapacity(flightCapacity-capacity);
		
		for (int i = 0; i < capacity; i++) {
			FlightRegistry fr = new FlightRegistry(f,c,p);	
			Transaction trans = session.beginTransaction();
			f.setFlightRegistry(fr);
			c.setFlightRegistry(fr);
			p.setFlightRegistry(fr);
 
			session.save(f);
			session.save(c);
			session.save(p);
			session.save(fr);
			
			trans.commit();
		}
		
		
		response.sendRedirect("admin/confirmation.jsp?customer_id="+customer_id+"&flight_id="+flight_id+"&payment_id="+payment_id);
		
		session.close();
		
	}

}