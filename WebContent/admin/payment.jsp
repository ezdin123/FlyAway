<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.SessionFactory" %>
<%@ page import="com.simplilearn.util.HibernateUtil" %>
<%@ page import="com.simplilearn.model.Flight" %>
<%@ page import="com.simplilearn.model.Customer" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>FlyAway - Registration</title>
    </head>
    <body id="page-top">
	<a href="/FlyAway/index.html">FlyAway</a>
	<a href="/FlyAway/datagen">search Flights</a>
	<a href="/FlyAway/login.jsp">Admin Login</a>

	<section class="page-section bg-light" id="register">
            <div class="container px-5 px-lg-5">
                <div class="row gx-5 gx-lg-5 justify-content-center">
        	<%
			String error = request.getParameter("error");
		
			if(error!=null){
				%>
					<div class="alert alert-danger" role="alert">
				<%
				if(error.indexOf("01")>=0){
					%>
			   			<b>Name on Card has invalid characters or is blank.</b><br>
					<%
				}
				if(error.indexOf("02")>=0){
					%>
		   				<b>Credit Card number has invalid characters or is blank.</b><br>
					<%
				}
				if(error.indexOf("03")>=0){
					%>
			   			<b>Month is blank.</b><br>
					<%
				}
				if(error.indexOf("04")>=0){
					%>
			   			<b>Year is blank.</b><br>
					<%
				}
				if(error.indexOf("05")>=0){
					%>
			   			<b>CCV has invalid characters or is blank.</b><br>
					<%
				}
				
				if(error.indexOf("06")>=0){
					%>
			   			<b>Capacity is not a valid number or is blank.</b><br>
					<%
				}
				if(error.indexOf("07")>=0){
					%>
			   			<b>customer_id is not a valid number or is blank.</b><br>
					<%
				}
				if(error.indexOf("08")>=0){
					%>
			   			<b>flight_id is not a valid number or is blank.</b><br>
					<%
				}
				%>
				</div>
				<%
			}
			
			try{
			Session se = HibernateUtil.getSessionFactory().openSession();
			int flight_id = Integer.parseInt(request.getParameter("flight_id"));
			int customer_id = Integer.parseInt(request.getParameter("customer_id"));
			int capacity = Integer.parseInt(request.getParameter("capacity"));
			Flight f = se.load(Flight.class,flight_id);
			Customer c = se.load(Customer.class,customer_id);			
			%>
        <!-- Payment Info -->
        
                    <div class="col-lg-12 text-center">
                        <h2 class="text-primary mt-0">Credit Card Payment - Enter your card details</h2>
                        <hr class="divider divider-primary" />
                        <%
                        //error handling block here.
                        %>
                        <form class="row g-3 align-items-center" action="payment?flight_id=<%=f.getFlightId() %>&customer_id=<%=c.getCustomer_Id() %>&capacity=<%=capacity %>" method="POST">
					    	
					    	<div class="col-auto">
					    		<label for="cc_name">Name on Card</label>
					      		<input type="text" class="form-control" name="cc_name"  id="cc_name">
					    	</div>
					    	<div class="col-auto">
					    		<label for="credit_card_num">Credit Card Number</label>
						    	<div class="input-group flex-nowrap">
						    		<span class="input-group-text" id="addon-wrapping">
				                        <i class="fa fa-credit-card">
				                        </i>
				                    </span>
						    		<input class="form-control" id="cc_num" name="cc_num" placeholder="Credit Card Number" type="text" aria-label="cc_num" aria-describedby="addon-wrapping"/>
								</div>
					    	</div>
					    	<div class="col-auto">
					      		<label for="cc_month">Month</label>
	                            <select class="form-select" id="cc_month" name="cc_month">
	                                <option selected value=""></option>
	                                <option value="1">1</option>
	                                <option value="2">2</option>
	                                <option value="3">3</option>
	                                <option value="4">4</option>
	                                <option value="5">5</option>
	                                <option value="6">6</option>
	                                <option value="7">7</option>
	                                <option value="8">8</option>
	                                <option value="9">9</option>
	                                <option value="10">10</option>
	                                <option value="11">11</option>
	                                <option value="12">12</option>
	                            </select>
							</div>
							<div class="col-auto">
								<label for="ccmonth">Year</label>
					      		<select class="form-select" aria-label="cc_year" name="cc_year" id="cc_year">
									<option selected value=""></option>
									<option value="2021">2021</option>
	                                <option value="2022">2022</option>
	                                <option value="2023">2023</option>
	                                <option value="2024">2024</option>
	                                <option value="2025">2025</option>
	                                <option value="2026">2026</option>
	                                <option value="2027">2027</option>
	                                <option value="2028">2028</option>
	                                <option value="2029">2029</option>
	                                <option value="2030">2030</option>
								</select>
							</div>
							<div class="col-auto">
								<label for="cc_month">CCV/CVC</label>
					      		<input type="text" class="form-control" name="ccv"  id="ccv">
					    	</div>
					    	<button type="submit" class="btn btn-secondary col-auto">Submit</button>
						</form>
                    </div>
                </div>
            </div>
        </section>
        <!-- Customer Info -->
        <section class="page-section bg-light" id="flight_info">
            <div class="container px-5 px-lg-5">
                <div class="row gx-5 gx-lg-5 justify-content-center">
                    <div class="col-lg-12 text-center">
                        <h4 class="text-primary mt-0">Customer Information</h4>
                        <hr class="divider divider-primary" />
                        <table class="table table-striped table-hover">
							<thead>
								<tr>
						    		<th scope="col"></th>
						    		<th scope="col">First Name</th>
						      		<th scope="col">Last Name</th>
						      		<th scope="col">Birth Date</th>
						      		<th scope="col">Street Address</th>
						      		<th scope="col">Age</th>
						      		<th scope="col">Gender</th>
						      		<th scope="col">ID Type</th>
						      		<th scope="col">ID Number</th>
						      		<th scope="col">ID Exp Date</th>
						   		</tr>
							</thead>
							<tbody>
								<tr>
									<th scope="row">1</th>
								    <td><%=c.getFirstName() %></td>
								    <td><%=c.getLastName() %></td>
								    <td><%=c.getDateOfBirth() %></td>
								    <td><%=c.getSt_address() %></td>
								    <td><%=c.getAge() %></td>
								    <td><%=c.getGender() %></td>
								    <td><%=c.getId_type() %></td>
								    <td><%=c.getId_num() %></td>
								    <td><%=c.getId_Exp_date() %></td>
						    	</tr>
						   	</tbody>
						</table>
						<h4 class="text-primary mt-0">Flight Information</h4>
                        <hr class="divider divider-primary" />
                        <table class="table table-striped table-hover">
							<thead>
								<tr>
						    		<th scope="col">Flight Number</th>
						      		<th scope="col">Airline Name</th>
						      		<th scope="col">Arrive City</th>
						      		<th scope="col">Arrive Airport</th>
						      		<th scope="col">Depart City</th>
						      		<th scope="col">Depart Airport</th>
						      		<th scope="col">Price</th>
						   		</tr>
							</thead>
							<tbody>
								<tr>
									<th scope="row"><%=f.getFlightId() %></th>
								    <td><%=f.getAirlineName() %></td>
								    <td><%=f.getArriveCity() %></td>
								    <td><%=f.getArriveAirport() %></td>
								    <td><%=f.getDepartCity() %></td>
								    <td><%=f.getDepartAirport() %></td>
								    <td><%=f.getPrice() %></td>
						    	</tr>
						   	</tbody>
						</table>
                    </div>
                </div>
            </div>
        </section>
       <%	se.close();
			} catch (Exception e){
				%>
				<div class="alert alert-danger" role="alert">
				<b>Something went wrong with your query or url parameters.</b>
				</div>
				<%
			}
			
			%>
        
 
    </body>
</html>