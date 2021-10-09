<%@ page import="org.hibernate.Session"%>
<%@ page import="org.hibernate.Query"%>
<%@ page import="org.hibernate.HibernateException"%>
<%@ page import="org.hibernate.SessionFactory"%>
<%@ page import="org.hibernate.criterion.Restrictions"%>
<%@ page import="javax.persistence.criteria.CriteriaBuilder"%>
<%@ page import="javax.persistence.criteria.CriteriaQuery"%>
<%@ page import="javax.persistence.criteria.Root"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="javax.persistence.criteria.Predicate"%>
<%@ page import="com.simplilearn.util.HibernateUtil"%>
<%@ page import="com.simplilearn.model.Flight"%>
<%@ page import="com.simplilearn.model.Airport"%>
<%@ page import="com.simplilearn.model.Airline"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	List<Airport> airports = new ArrayList<Airport>();
	List<Airline> airlines = new ArrayList<Airline>();
	List<Flight> flights = new ArrayList<Flight>();
	Session se = HibernateUtil.getSessionFactory().openSession();
	String nullcheck = request.getParameter("pg");
	if (nullcheck != null) {
		Integer pg_id = Integer.parseInt(request.getParameter("pg"));
		if (pg_id == 1) {
			se.beginTransaction();
			CriteriaBuilder cb = se.getCriteriaBuilder();
			CriteriaQuery<Airport> cr = cb.createQuery(Airport.class);
			Root<Airport> root = cr.from(Airport.class);
			cr.select(root);
			Query<Airport> query = se.createQuery(cr);
			airports = query.getResultList();
		} else if (pg_id == 2) {
			se.beginTransaction();
			CriteriaBuilder cb = se.getCriteriaBuilder();
			CriteriaQuery<Airline> cr = cb.createQuery(Airline.class);
			Root<Airline> root = cr.from(Airline.class);
			cr.select(root);
			Query<Airline> query = se.createQuery(cr);
			airlines = query.getResultList();
		} else if (pg_id == 3) {
			se.beginTransaction();
			CriteriaBuilder cb = se.getCriteriaBuilder();
			CriteriaQuery<Flight> cr = cb.createQuery(Flight.class);
			Root<Flight> root = cr.from(Flight.class);
			cr.select(root);
			Query<Flight> query = se.createQuery(cr);
			flights = query.getResultList();
		}
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>FlyAway - Admin Portal</title>
</head>
<body id="page-top">
	<a href="/FlyAway/index.html">Back to Home page</a>
	<a href="/FlyAway/datagen">Search Flights</a>|
	<a href="/FlyAway/login.jsp">Admin Login</a>|
	<hr>
	<br>
	<br>
	<br>
	<a href="/FlyAway/admin/admin.jsp?pg=1">Sources and Destinations</a>|
	<a class="nav-link" href="/FlyAway/admin/admin.jsp?pg=2">Airline
		List</a>|
	<a href="/FlyAway/admin/admin.jsp?pg=3">Flight List</a>|
	<a href="/FlyAway/admin/admin.jsp?pg=4">Change Password</a>|
	<a href="logout"> Logout </a>

	<!-- Admin Page -->
	<section class="page-section bg-light" id="register">
		<div class="container px-5 px-lg-5">
			<div class="row gx-5 gx-lg-5 justify-content-center">
				<div class="col-lg-12 text-center">
					<h2 class="text-primary mt-0">Admin Portal</h2>
					<hr class="divider divider-primary" />
					<%
						String success = request.getParameter("success");

						if (success != null) {
					%>
					<div class="alert alert-success" role="alert">
						<%
							if (success.indexOf("01") >= 0) {
						%>
						<b>Login Successfull!</b><br>
						<%
							}
								if (success.indexOf("02") >= 0) {
						%>
						<b>Password Updated!</b><br>
						<%
							}
								if (success.indexOf("03") >= 0) {
						%>
						<b>Source & Destination Deleted.</b><br>
						<%
							}
								if (success.indexOf("04") >= 0) {
						%>
						<b>Airline Deleted.</b><br>
						<%
							}
								if (success.indexOf("05") >= 0) {
						%>
						<b>Flight Deleted.</b><br>
						<%
							}
						%>
					</div>
					<%
						}
					%>
					<%
						String error = request.getParameter("error");

						if (error != null) {
					%>
					<div class="alert alert-danger" role="alert">
						<%
							if (error.indexOf("01") >= 0) {
						%>
						<b>Error updating password. Please try again.</b><br>
						<%
							}
								if (error.indexOf("02") >= 0) {
						%>
						<b>Error deleting source & destination. Please try again.</b><br>
						<%
							}
								if (error.indexOf("03") >= 0) {
						%>
						<b>Error deleting airline. Please try again.</b><br>
						<%
							}
								if (error.indexOf("04") >= 0) {
						%>
						<b>Error deleting airport. Please try again.</b><br>
						<%
							}
						%>
					</div>
					<%
						}
					%>
					<%
						if (nullcheck != null) {
							Integer pg_id = Integer.parseInt(request.getParameter("pg"));
							if (pg_id == 1) { //Sources and Destinations aka Airports
								//TABLE COLUMN NAMES
					%>
					<h4 class="text-primary mt-0">Sources and Destinations</h4>
					<hr class="divider divider-primary" />
					<table class="table table-striped table-hover">
						<thead>
							<tr>
								<th scope="col">Airport Id</th>
								<th scope="col">Airport Name</th>
								<th scope="col">Country Code</th>
								<th scope="col">Region Code</th>
								<th scope="col">IATA Code</th>
								<th scope="col">City Name</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<%
								for (Airport a : airports) {
							%>
							<tr>
								<th scope="row"><%=a.getAirport_id()%></th>
								<td><%=a.getAirport_name()%></td>
								<td><%=a.getIso_country()%></td>
								<td><%=a.getIso_region()%></td>
								<td><%=a.getIata_code()%></td>
								<td><%=a.getCity_name()%></td>
								<td><a class="btn btn-primary btn-sm"
									href="/FlyAway/adminOps?op=4&airport_id=<%=a.getAirport_id()%>">Delete
										Location</a></td>
							</tr>
							<%
								}
										//END TABLE
							%>
						</tbody>
					</table>
					<%
						se.close();
							} else if (pg_id == 2) { //Airlines
								//TABLE COLUMN NAMES
					%>
					<h4 class="text-primary mt-0">Airline Company List</h4>
					<hr class="divider divider-primary" />
					<table class="table table-striped table-hover">
						<thead>
							<tr>
								<th scope="col">Airline Id</th>
								<th scope="col">Airline Company Name</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<%
								for (Airline a : airlines) {
							%>
							<tr>
								<th scope="row"><%=a.getAirline_id()%></th>
								<td><%=a.getCompanyName()%></td>
								<td><a class="btn btn-primary btn-sm"
									href="/FlyAway/adminOps?op=5&airline_id=<%=a.getAirline_id()%>">Delete
										Airline</a></td>
							</tr>

							<%
								}

										//END TABLE
							%>
						</tbody>
					</table>
					<%
						se.close();
							} else if (pg_id == 3) { //Flights
								//TABLE COLUMN NAMES
					%>
					<h4 class="text-primary mt-0">All Flights List</h4>
					<hr class="divider divider-primary" />
					<table class="table table-striped table-hover">
						<thead>
							<tr>
								<th scope="col">Flight Number</th>
								<th scope="col">Airline Name</th>
								<th scope="col">Arrive City</th>
								<th scope="col">Arrive Airport</th>
								<th scope="col">Capacity</th>
								<th scope="col">Date & Time</th>
								<th scope="col">Depart City</th>
								<th scope="col">Depart Airport</th>
								<th scope="col">Terminal</th>
								<th scope="col">Gate</th>
								<th scope="col">Price</th>
								<th scope="col"></th>

							</tr>
						</thead>
						<tbody>


							<%
								for (Flight f : flights) {
											//ROW GENERATION
							%>
							<tr>
								<th scope="row"><%=f.getFlightId()%></th>
								<td><%=f.getAirlineName()%></td>
								<td><%=f.getArriveCity()%></td>
								<td><%=f.getArriveAirport()%></td>
								<td><%=f.getCapacity()%></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd hh:mm"
										value="<%=f.getDateTime()%>" /></td>
								<td><%=f.getDepartCity()%></td>
								<td><%=f.getDepartAirport()%></td>
								<td><%=f.getTerminal()%></td>
								<td><%=f.getGate()%></td>
								<td><%=f.getPrice()%></td>
								<td><a class="btn btn-primary btn-sm"
									href="/FlyAway/adminOps?op=6&flight_id=<%=f.getFlightId()%>">Delete
										Flight</a></td>
							</tr>
							<%
								}

										//END TABLE
							%>
						</tbody>
					</table>
					<%
						se.close();

							} else if (pg_id == 4) { // change pw
					%>
					<p>To reset your password, please login.
					<form method="post" action="/FlyAway/adminOps?op=3">
						<div class="form-group">
							<div class="input-group">
								<div class="input-group-prepend">
									<span class="input-group-text"> <i class="fa fa-user"></i>
									</span>
								</div>
								<input name="username" class="form-control"
									placeholder="Username" type="text">

								<div class="form-group">
									<div class="input-group">
										<div class="input-group-prepend">
											<span class="input-group-text"> <i class="fa fa-lock"></i>
											</span>
										</div>
										<input class="form-control mb-5"
											placeholder="Current Password" type="password"
											name="password">

										<div class="form-group">
											<div class="input-group">
												<div class="input-group-prepend">
													<span class="input-group-text"> <i
														class="fa fa-lock"></i>
													</span>
												</div>
												<input class="form-control mb-5" placeholder="New Password"
													type="password" name="newPassword">
											</div>
											<!-- input-group.// -->
										</div>
										<!-- form-group// -->
										<div class="form-group">
											<button type="submit" class="btn btn-primary btn-block mb-3">
												Update</button>
										</div>
										<!-- form-group// -->
					</form>
					<%
						}
						} else {
					%>
					<p>Choose an option from the navbar.</p>
					<%
						}
					%>

				</div>
			</div>
		</div>
	</section>
	<%
		se.close();
	%>

</body>
</html>