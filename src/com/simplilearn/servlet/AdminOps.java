package com.simplilearn.servlet;

import java.io.IOException;
import java.util.List;

import javax.persistence.NoResultException;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.simplilearn.model.Admin;
import com.simplilearn.model.Airline;
import com.simplilearn.model.Airport;
import com.simplilearn.model.Flight;
import com.simplilearn.util.HibernateUtil;

@WebServlet("/AdminOps")
public class AdminOps extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminOps() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int op_num = Integer.parseInt(request.getParameter("op"));
		System.out.println("op_num: " + op_num);

		if (op_num == 1) {
			String username = "admin";
			String password = "AdminPassword";
			Session session = HibernateUtil.getSessionFactory().openSession();
			Admin admin = new Admin(username, password);
			Admin check = session.load(Admin.class, 0);
			if (check == null) {
				try {

					Transaction trans = session.beginTransaction();
					session.save(admin);
					trans.commit();
					session.close();
					response.sendRedirect("login.jsp?success=1");
				} catch (Exception e) {
					response.sendRedirect("login.jsp?error=2");
				}
			} else {
				check.setPassword(password);
				Transaction trans = session.beginTransaction();
				session.save(check);
				trans.commit();
				session.close();
				response.sendRedirect("login.jsp?success=2");

			}
		} else if (op_num == 2) {
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			Session se = HibernateUtil.getSessionFactory().openSession();

			try {

				se.beginTransaction();
				CriteriaBuilder cb = se.getCriteriaBuilder();
				CriteriaQuery<Admin> cr = cb.createQuery(Admin.class);
				Root<Admin> root = cr.from(Admin.class);
				Predicate equalsUsername = cb.equal(root.get("username"), username);
				Predicate equalsPassword = cb.equal(root.get("password"), password);

				cr.select(root).where(cb.and(equalsUsername, equalsPassword));
				Query<Admin> query = se.createQuery(cr);

				Admin user = query.getSingleResult();
				response.sendRedirect("admin/admin.jsp?success=s01");
			} catch (NoResultException e) {
				response.sendRedirect("login.jsp?error=1");
			} finally {
				se.close();
			}
		} else if (op_num == 3) {
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String newPassword = request.getParameter("newPassword");
			Session se = HibernateUtil.getSessionFactory().openSession();
			try {
				Transaction trans = se.beginTransaction();
				CriteriaBuilder cb = se.getCriteriaBuilder();
				CriteriaQuery<Admin> cr = cb.createQuery(Admin.class);
				Root<Admin> root = cr.from(Admin.class);
				Predicate equalsUsername = cb.equal(root.get("username"), username);
				Predicate equalsPassword = cb.equal(root.get("password"), password);
				cr.select(root).where(cb.and(equalsUsername, equalsPassword));
				Query<Admin> query = se.createQuery(cr);

				Admin user = query.getSingleResult();
				user.setPassword(newPassword);
				se.save(user);
				trans.commit();
				System.out.println("username and password correct");
				response.sendRedirect("admin/admin.jsp?success=s02");
			} catch (NoResultException e) {
				response.sendRedirect("admin/admin.jsp?error=err01");
			} finally {
				se.close();
			}
		} else if (op_num == 4) {
			Session session = HibernateUtil.getSessionFactory().openSession();
			try {
				Transaction trans = session.beginTransaction();
				Airport airport = session.load(Airport.class, Integer.parseInt(request.getParameter("airport_id")));
				session.delete(airport);
				trans.commit();
				session.close();
				response.sendRedirect("admin/admin.jsp?success=s03&pg=1");
			} catch (Exception e) {
				response.sendRedirect("admin/admin.jsp?error=err02&pg=1");
			}

		} else if (op_num == 5) {
			Session session = HibernateUtil.getSessionFactory().openSession();
			try {
				Transaction trans = session.beginTransaction();
				Airline airline = session.load(Airline.class, Integer.parseInt(request.getParameter("airline_id")));
				session.delete(airline);
				trans.commit();
				session.close();
				response.sendRedirect("admin/admin.jsp?success=s04&pg=2");
			} catch (Exception e) {
				response.sendRedirect("admin/admin.jsp?error=err03&pg=2");
			}
		} else if (op_num == 6) {
			// delete flight
			Session session = HibernateUtil.getSessionFactory().openSession();
			try {
				Transaction trans = session.beginTransaction();
				Flight flight = session.load(Flight.class, Integer.parseInt(request.getParameter("flight_id")));
				session.delete(flight);
				trans.commit();
				session.close();
				response.sendRedirect("admin/admin.jsp?success=s05&pg=3");
			} catch (Exception e) {
				response.sendRedirect("admin/admin.jsp?error=err04&pg=3");
			}
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
