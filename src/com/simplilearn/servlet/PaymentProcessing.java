package com.simplilearn.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.simplilearn.model.Payment;
import com.simplilearn.util.FormValidator;
import com.simplilearn.util.HibernateUtil;

@WebServlet("/Payment")
public class PaymentProcessing extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public PaymentProcessing() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String cc_name = request.getParameter("cc_name");
		String cc_num = request.getParameter("cc_num");
		String cc_month = request.getParameter("cc_month");
		String cc_year = request.getParameter("cc_year");
		String ccv = request.getParameter("ccv");
		String flight_id = request.getParameter("flight_id");
		String customer_id = request.getParameter("customer_id");
		String capacity = request.getParameter("capacity");

		cc_num = cc_num.replaceAll("\\s+", "");

		if (!FormValidator.isAlphabet(cc_name) || !FormValidator.isInt(cc_num) || !FormValidator.isInt(cc_month)
				|| !FormValidator.isInt(cc_year) || !FormValidator.isInt(ccv) || !FormValidator.isInt(capacity)
				|| !FormValidator.isInt(customer_id) || !FormValidator.isInt(flight_id)) {

			String err = "";

			if (!FormValidator.isAlphabet(cc_name)) {
				err += "err01";
			}
			if (!FormValidator.isInt(cc_num)) {
				err += "err02";
			}
			if (!FormValidator.isInt(cc_month)) {
				err += "err03";
			}
			if (!FormValidator.isInt(cc_year)) {
				err += "err04";
			}
			if (!FormValidator.isInt(ccv)) {
				err += "err05";
			}
			if (!FormValidator.isInt(capacity)) {
				err += "err06";
			}
			if (!FormValidator.isInt(customer_id)) {
				err += "err07";
			}
			if (!FormValidator.isInt(flight_id)) {
				err += "err08";
			}
			response.sendRedirect("admin/payment.jsp?error=" + err + "&customer_id=" + customer_id + "&flight_id="
					+ flight_id + "&capacity=" + capacity);
		} else {
			Payment pmt = new Payment(cc_name, cc_num, cc_month, cc_year, ccv);

			Session session = HibernateUtil.getSessionFactory().openSession();
			Transaction trans = session.beginTransaction();
			session.save(pmt);
			trans.commit();

			response.sendRedirect("flightRegister?customer_id=" + customer_id + "&flight_id=" + flight_id
					+ "&payment_id=" + pmt.getPayment_Id() + "&capacity=" + capacity);
			session.close();
		}
	}
}
