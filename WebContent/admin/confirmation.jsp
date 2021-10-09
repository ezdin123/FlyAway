<%@ page import="com.simplilearn.util.HibernateUtil"%>
<%@ page import="com.simplilearn.model.Flight"%>
<%@ page import="com.simplilearn.model.Customer"%>
<%@ page import="com.simplilearn.model.Payment"%>
<%@ page import="com.simplilearn.model.Airport"%>
<%@ page import="com.simplilearn.model.FlightRegistry"%>
<%@ page import="org.hibernate.Session"%>
<%@ page import="org.hibernate.SessionFactory"%>
<%@ page import="org.hibernate.Query"%>
<%@ page import="org.hibernate.HibernateException"%>
<%@ page import="org.hibernate.SessionFactory"%>
<%@ page import="org.hibernate.criterion.Restrictions"%>
<%@ page import="javax.persistence.criteria.Predicate"%>
<%@ page import="javax.persistence.criteria.CriteriaBuilder"%>
<%@ page import="javax.persistence.criteria.CriteriaQuery"%>
<%@ page import="javax.persistence.criteria.Root"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- 
 
</style>
</head>
<body id="page-top">
	<!-- Navigation-->
<a href="/FlyAway/index.html">FlyAway</a>
<a href="/FlyAway/index.html">Home</a>
</li>

<section class="page-section bg-light" id="register">
	<div class="container px-5 px-lg-5">
		<div class="row gx-5 gx-lg-5 justify-content-center">
			<h1 class="text-primary font-weight-bold">Your Adventure Begins
				Now!</h1>
			<%
				try {
					Session se = HibernateUtil.getSessionFactory().openSession();
					int flight_id = Integer.parseInt(request.getParameter("flight_id"));
					int customer_id = Integer.parseInt(request.getParameter("customer_id"));
					int payment_id = Integer.parseInt(request.getParameter("payment_id"));

					se.beginTransaction();
					CriteriaBuilder cb = se.getCriteriaBuilder();
					CriteriaQuery<FlightRegistry> cr = cb.createQuery(FlightRegistry.class);
					Root<FlightRegistry> root = cr.from(FlightRegistry.class);
					Predicate flightIdMatch = cb.equal(root.get("flight"), flight_id);
					Predicate customerIdMatch = cb.equal(root.get("customer"), customer_id);
					Predicate paymentIdMatch = cb.equal(root.get("payment"), payment_id);

					cr.select(root).where(cb.and(flightIdMatch, customerIdMatch, paymentIdMatch));
					Query<FlightRegistry> query = se.createQuery(cr);
					List<FlightRegistry> flightReg = query.getResultList();

					for (FlightRegistry fr : flightReg) {

						Flight f = fr.getFlight();
						Customer c = fr.getCustomer();
						Payment p = fr.getPayment();
						Airport airport_arrive = f.getAirportArrive();
						Airport airport_depart = f.getAirportDepart();
			%>
			<span><%=f.getAirlineName()%></span> <span>Boarding pass</span><br>
			<span>Airport codes: </span> <span><%=airport_arrive.getIata_code()%>
				&</span><span><%=airport_depart.getIata_code()%></span><br> <span>PASSENGER
				NAME: <span><%=c.getLastName()%>, <%=c.getFirstName()%></span>
			</span><br> <span>FLIGHT N&deg;: <span>X3-65C3</span></span><br> <span>TERMINAL/GATE:
				<span><%=f.getTerminal()%>/<%=f.getGate()%></span>
			</span><br> <span>TICKET #: <span><%=fr.getFlight_registry_Id()%></span></span><br> <span>BOARDING TIME<br> <span><fmt:formatDate
						pattern="yyyy-MM-dd hh:mm" value="<%=f.getDateTime()%>" /></span></span>
			<hr>


			<%
				}
					se.close();
				} catch (Exception e) {
					System.out.println(e.getMessage());
			%>
			<p>Ticket generation error.</p>
			<%
				}
			%>

		</div>
	</div>
</section>

</body>
</html>