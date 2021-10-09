package com.simplilearn.servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.simplilearn.model.Customer;
import com.simplilearn.util.FormValidator;
import com.simplilearn.util.HibernateUtil;

@WebServlet("/SaveCustomer")
public class Registration extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Registration() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String dateOfBirthIn = request.getParameter("dateOfBirth");
		String st_address = request.getParameter("st_address");
		String gender = request.getParameter("gender");
		String id_type = request.getParameter("id_type");
		String id_num = request.getParameter("id_num");
		String exp_dateIn = request.getParameter("id_exp_date");
		String flight_id = request.getParameter("flight_id");
		String capacity = request.getParameter("capacity");
		SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
		
		//DEBUG
		System.out.println("firstName: "+firstName);
		System.out.println("lastName: "+lastName);
		System.out.println("dateOfBirthIn: "+dateOfBirthIn);
		System.out.println("st_address: "+st_address);
		System.out.println("gender: "+gender);
		System.out.println("id_type: "+id_type);
		System.out.println("id_num: "+id_num);
		System.out.println("exp_dateIn: "+exp_dateIn);
		System.out.println("flight_id: "+flight_id);
		
		//ERROR CHECK
		if(gender.equals("Gender")){
			gender=null;
		}
		
		if(id_type.equals("ID Type")){
			id_type=null;
		}
		if( !FormValidator.isAlphabet(firstName)||
			!FormValidator.isAlphabet(lastName)||
			!FormValidator.isDateTime(dateOfBirthIn)||
			!FormValidator.isAlphanumeric(st_address)||
			!FormValidator.isAlphabet(gender)||
			!FormValidator.isAlphabet(id_type)||
			!FormValidator.isAlphanumeric(id_num)||
			!FormValidator.isDateTime(exp_dateIn)||
			!FormValidator.isInt(capacity)||
			!FormValidator.isInt(flight_id)){
			
			String err = "";
			
        	if( !FormValidator.isAlphabet(firstName) ){
        		err += "err01";
        	}
    		if ( !FormValidator.isAlphabet(lastName) ) {
    			err += "err02";
        	}
    		if ( !FormValidator.isDateTime(dateOfBirthIn) ) {
    			err += "err03";
        	}
    		if ( !FormValidator.isAlphanumeric(st_address) ) {
    			err += "err04";
        	}
    		if ( !FormValidator.isAlphabet(gender) ) {
    			err += "err05";
        	}
    		if ( !FormValidator.isAlphabet(id_type) ) {
    			err += "err06";
        	}
    		if ( !FormValidator.isAlphanumeric(id_num) ) {
    			err += "err07";
        	}
    		if ( !FormValidator.isDateTime(exp_dateIn) ) {
    			err += "err08";
        	}
    		if ( !FormValidator.isInt(capacity) ) {
    			err += "err09";
        	}
    		if ( !FormValidator.isInt(flight_id) ) {
    			err += "err10";
        	}
    		response.sendRedirect("/admin/registration.jsp?error="+err+"&flight_id="+flight_id+"&capacity="+capacity);
		} else {
			Date dateOfBirth = null;
			Date exp_date = null;
			try {
				dateOfBirth = sdf.parse(dateOfBirthIn);
				exp_date = sdf.parse(exp_dateIn);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			Customer nc = new Customer(firstName,lastName,dateOfBirth,st_address,gender,id_type,id_num,exp_date);
			
			SessionFactory factory = HibernateUtil.getSessionFactory();		
			Session session = factory.openSession();		
			Transaction trans = session.beginTransaction();
			session.save(nc);		
			trans.commit();		
 
			response.sendRedirect("/admin/payment.jsp?customer_id="+nc.getCustomer_Id()+"&flight_id="+flight_id+"&capacity="+capacity);
			session.close();
		}
	}
}
